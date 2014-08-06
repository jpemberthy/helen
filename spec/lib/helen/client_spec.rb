require "spec_helper"

describe Helen::Client do
  describe "initialize" do
    it "properly maps the host, port and graph name" do
      client = Helen::Client.new(host: 'localhost', port: 8182, graph: 'gods')
      expect(client.host).to eq('localhost')
      expect(client.port).to eq(8182)
      expect(client.graph).to eq('gods')
    end
  end
end
