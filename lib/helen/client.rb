
module Helen
  class Client
    VERTEX_ITERATOR = "g.V(%s)".freeze
    GET_VERTEX = "g.v(%s)".freeze

    attr_reader :host, :port, :graph, :client

    def initialize(host:, port:, graph:)
      @host, @port, @graph = host, port, graph
    end

    def vertex(identifier)
      # g.V('name', 'peter')
      if identifier.is_a? Hash
        script = VERTEX_ITERATOR % "key, value"
        response = execute(script, key: identifier.keys.first, value: identifier.values.last)
        # TODO: double check if we should always return the first vertix here.
        Vertex.new_from_response(response).first
      elsif identifier.is_a? Array
      else
        response = execute(GET_VERTEX % identifier.to_i)
        Vertex.new_from_response(response).first
      end
    end

    private

    def client
      @client ||= Rexpro::Client.new(host: host, port: port)
    end

    def execute(script, bindings={})
      client.execute(script, graph_name: graph, bindings: bindings)
    end
  end
end
