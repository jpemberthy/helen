
module Helen
  class Client
    VERTEX_ITERATOR = "g.V(%s)".freeze
    GET_VERTEX = "g.v(%s)".freeze

    attr_reader :host, :port, :graph, :client

    def initialize(host:, port:, graph:)
      @host, @port, @graph = host, port, graph
    end

    # When the identifier is a single `key` a vertex is returned.
    # When the identifier is a collection of keys a set of vertices is returned.
    # TODO: For a graph indexed key that is not unique return a collection.
    def vertex(identifier)
      # g.V('name', 'peter')
      if identifier.is_a? Hash
        script = VERTEX_ITERATOR % "key, value"
        response = execute(script, key: identifier.keys.first, value: identifier.values.last)
        Vertex.from_response(response).first
      elsif identifier.is_a? Array
        response = execute(GET_VERTEX % identifier.join(","))
        Vertex.from_response(response)
      else
        response = execute(GET_VERTEX % identifier.to_i)
        Vertex.from_response(response).first
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
