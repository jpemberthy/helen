require "helen/configuration"

module Helen
  class Client
    VERTEX_ITERATOR = "g.V(%s)".freeze
    GET_VERTEX = "g.v(%s)".freeze

    attr_reader :host, :port, :graph, :client

    def self.config
      Configuration.instance
    end

    def self.configure(&block)
      block.call(config)
    end

    def initialize(host: nil, port: nil, graph: nil)
      @host = host || global_config.host
      @port = port || global_config.port
      @graph = graph || global_config.graph
    end

    # TODO: check how to handle big collections.
    def v(identifier)
      response = identifier_request(identifier)
      Vertex.from_response response
    end

    def vertex(identifier)
      v(identifier).first
    end

    private

    def client
      @client ||= Rexpro::Client.new(host: host, port: port)
    end

    def execute(script, bindings={})
      client.execute(script, graph_name: graph, bindings: bindings)
    end

    def identifier_request(identifier)
      if identifier.is_a? Hash
        script = VERTEX_ITERATOR % "key, value"
        execute(script, key: identifier.keys.first, value: identifier.values.last)
      elsif identifier.is_a? Array
        execute(GET_VERTEX % identifier.join(","))
      else
        execute(GET_VERTEX % identifier.to_i)
      end
    end

    def global_config
      self.class.config
    end
  end
end
