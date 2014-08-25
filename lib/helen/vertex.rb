require 'set'
require 'delegate'

module Helen
  class Vertex < SimpleDelegator
    ADD_VERTEX = "g.addVertex([%s])".freeze
    REMOVE_VERTEX = "g.removeVertex(g.v(%s))".freeze
    attr_reader :_id, :attributes

    # results sample. {"_id"=>"6", "_type"=>"vertex", "_properties"=>{"age"=>35, "name"=>"peter"}}
    def self.from_response(response)
      results = response.results.is_a?(Hash) ? [ response.results ] : response.results

      results.each_with_object(Set.new) do |result, vertices|
        vertices << new(result["_properties"].merge(_id: result["_id"]))
      end
    end

    def initialize(atts = {})
      @_id = atts.delete(:_id)
      @attributes = atts

      atts.each do |k, v|
        define_singleton_method(k) { instance_variable_get("@#{k}") }
        define_singleton_method("#{k}=") { |new_value| instance_variable_set("@#{k}", new_value) }
        send("#{k}=", v)
      end

      super client
    end

    def persisted?
      !!_id
    end

    def self.create(atts = {})
      new(atts).save
    end

    def save
      persisted? ? update : add_to_graph
    end

    def destroy
      execute(REMOVE_VERTEX % "id", id: self._id)
    end

    def ==(_vertex)
      self._id && self._id == _vertex._id
    end

    private

    def client
      @client ||= Client.new
    end

    def add_to_graph
      # TODO: Fix rexpro to make it possible to pass attributes as bindings here.
      execute(ADD_VERTEX % attributes.map { |k,v| "'#{k}' : '#{v}'"}.join(','))
    end
  end
end
