module Helen
  class Client
    attr_reader :host, :port, :graph, :_client

    def initialize(host:, port:, graph:)
      @host, @port, @graph = host, port, graph
    end

    private

    def _client
      @_client ||= Rexpro::Client.new(host: host, port: port)
    end
  end
end
