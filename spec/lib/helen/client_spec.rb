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

  describe ".v" do
    # Equivalent to g.v(1,2,3)
    it "finds vertices by ids" do
      vertices = helen.v([1, 2])
      expect(vertices).to have(2).items
      expect(vertices.map(&:name)).to match_array(['marko', 'vadas'])
    end
  end

  describe '.vertix' do
    # Equivalent to g.V('name', 'hercules')
    it "finds a vertex with the given property" do
      peter = helen.vertex(name: 'peter')
      assert_vertex(peter, { _id: '6', age: 35, name: 'peter' })
    end

    # equivalent to g.v(1)
    it 'finds a vertex by id' do
      peter = helen.vertex(6)
      expect(peter).to eq(helen.vertex(name: 'peter'))

      marko = helen.vertex(1)
      assert_vertex(marko, { _id: '1', name: 'marko' })

      vadas = helen.vertex(2)
      assert_vertex(vadas, { _id: '2', name: 'vadas' })
    end
  end
end
