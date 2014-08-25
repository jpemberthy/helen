require "spec_helper"

describe Helen::Client do
  describe "initialize" do
    it "sets the global host, port and graph name if it's not supplied" do
      client = Helen::Client.new
      expect(client.host).to eq('localhost')
      expect(client.port).to eq(8184)
      expect(client.graph).to eq('test')
    end

    it "properly maps the host, port and graph name" do
      client = Helen::Client.new(host: 'localhost', port: 8182, graph: 'gods')
      expect(client.host).to eq('localhost')
      expect(client.port).to eq(8182)
      expect(client.graph).to eq('gods')
    end
  end

  describe ".v" do
    before(:each) do
      Helen::Vertex.create(name: 'saturn', age: '10000', type: 'titan')
      Helen::Vertex.create(name: 'jupiter', age: '5000', type: 'god')
    end

    # Equivalent to g.v(1,2,3)
    it "finds vertices by ids" do
      saturn_id = helen.vertex(name: 'saturn')._id
      jupiter_id = helen.vertex(name: 'jupiter')._id

      vertices = helen.v([saturn_id, jupiter_id])

      expect(vertices).to have(2).items
      expect(vertices.map(&:name)).to match_array(['saturn', 'jupiter'])
    end
  end

  describe '.vertix' do
    before(:each) do
      Helen::Vertex.create(name: 'saturn', age: '10000', type: 'titan')
    end

    # Equivalent to g.V('name', 'hercules')
    it "finds a vertex with the given property" do
      saturn = helen.vertex(name: 'saturn')
      assert_vertex(saturn, { age: '10000', name: 'saturn' })
    end

    # equivalent to g.v(1)
    it 'finds a vertex by id' do
      saturn_id = helen.vertex(name: 'saturn')._id
      saturn = helen.vertex(saturn_id)
      assert_vertex(saturn, { _id: saturn_id, name: 'saturn' })
    end
  end
end
