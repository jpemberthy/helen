require "spec_helper"

describe Helen::Vertex do
  describe "initialize" do
    it "initializes a new vertex with _id and the right attributes setters/getters" do
      v = Helen::Vertex.new("_id" => 1, "_properties" => { "age" => 27, "name" => "hercules" })
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
    describe ".create" do
      it "creates a new vertex in the graph with the given properties" do
        pending "WIP"
        vertex = Helen::Vertex.create(name: 'sun', type: 'location')
        sun = helen.vertex('sun')
        sun.name.should == name
        sun.type.should == 'location'
      end
    end
  end
end
