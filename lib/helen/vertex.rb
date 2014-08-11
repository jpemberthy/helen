module Helen
  class Vertex
    attr_reader :_id

    # results sample. {"_id"=>"6", "_type"=>"vertex", "_properties"=>{"age"=>35, "name"=>"peter"}}
    def self.new_from_response(response)
      result = response.results.first
      new(result["_properties"].merge(_id: result["_id"]))
    end

    def initialize(attributes = {})
      @_id = attributes.delete(:_id)

      attributes.each do |k, v|
        define_singleton_method(k) { instance_variable_get("@#{k}") }
        define_singleton_method("#{k}=") { |new_value| instance_variable_set("@#{k}", new_value) }
        send("#{k}=", v)
      end
    end

    def self.create(attributes = {})
    end
  end
end
