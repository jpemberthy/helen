module Helen
  class Vertex
    attr_reader :_id

    # attrs sample. {"_id"=>"6", "_type"=>"vertex", "_properties"=>{"age"=>35, "name"=>"peter"}}
    def initialize(attributes = {})
      @_id = attributes["_id"]

      attributes.fetch("_properties", {}).each do |k, v|
        define_singleton_method(k) { instance_variable_get("@#{k}") }
        define_singleton_method("#{k}=") { |new_value| instance_variable_set("@#{k}", new_value) }
        send("#{k}=", v)
      end
    end

    def self.create(attributes = {})
    end
  end
end
