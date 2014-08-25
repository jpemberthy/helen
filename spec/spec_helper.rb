require 'helen'
require 'graph_factory'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  # Have a default client always.
  config.before(:each) do
    Helen::Client.configure do |c|
      c.host = 'localhost'
      c.port = 8184
      c.graph = 'test'
    end
  end

  config.around(:each) do |example|
    # GraphFactory.new.load!
    example.run
    GraphFactory.new.teardown!
  end
end

def helen(opts = {})
  opts = { host: 'localhost', port: 8184, graph: 'test' }.merge(opts)
  @_helen ||= Helen::Client.new(opts)
end

def assert_vertex(vertex, attributes = {})
  attributes.each { |k, v| expect(vertex.send(k)).to eq(v) }
end
