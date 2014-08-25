require "spec_helper"

describe Helen::Vertex do
  describe "initialize" do
    it "initializes a new vertex with _id and the right attributes setters/getters" do
      v = Helen::Vertex.new(:_id => 1, age: 27, name: "hercules")
      expect(v._id).to eq(1)
      expect(v.age).to eq(27)
      expect(v.name).to eq("hercules")

      v.name = "saturn"
      v.age = 1000

      expect(v.age).to eq(1000)
      expect(v.name).to eq("saturn")
    end
  end

  describe "class_methods" do
    describe ".from_response(response)" do
      it "it initializes a set of vertices from a rexspro response" do
        results = [ { "_id"=>"6", "_type"=>"vertex", "_properties" => { "age"=>35, "name"=>"peter" } } ]
        response = double("response", results: results)
        vertices = Helen::Vertex.from_response response
        expect(vertices).to have(1).item
        v = vertices.first
        expect(v).to be_kind_of(Helen::Vertex)
        expect(v._id).to eq("6")
        expect(v.age).to eq(35)
        expect(v.name).to eq("peter")
      end
    end

    describe ".create" do
      it "creates a new vertex in the graph with the given properties" do
        vertex = Helen::Vertex.create(name: 'sun', type: 'location')
        sun = helen.vertex(name: 'sun')
        sun.should be_persisted
        sun.name.should == 'sun'
        sun.type.should == 'location'
      end
    end
  end
end
