
module Helen
  class Client
    VERTEX_ITERATOR = "g.V(%s)".freeze

    attr_reader :host, :port, :graph, :client

    def initialize(host:, port:, graph:)
      @host, @port, @graph = host, port, graph
    end

    def vertex(identifier)
      puts identifier
      # g.V('name', 'peter')
      if identifier.is_a? Hash
        script = VERTEX_ITERATOR % "key, value"
        execute script, key: identifier.keys.first, value: identifier.values.last
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
