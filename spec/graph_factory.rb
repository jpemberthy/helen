require 'helen'

class GraphFactory
  REMOVE_ALL = "g.V.remove()"

  def load!
    Helen::Vertex.create(name: 'saturn', age: '10000', type: 'titan', fixture: true)
  end

  def teardown!
    helen.execute(REMOVE_ALL)
  end

  def helen
    @helen ||= Helen::Client.new
  end
end
