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

  describe ".vertex" do
    # Equivalent to g.V('name', 'hercules')
    it "finds a vertex with the given property" do
      peter = helen.vertex(name: 'peter')
      expect(peter._id).to eq('6')
      expect(peter.age).to eq(35)
      expect(peter.name).to eq('peter')
    end

    # Equivalent to g.v(1), g.v(1,2,3)
    it "finds a vertex by id(s)" do
    end
  end

end
