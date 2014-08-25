require "singleton"

module Helen
  class Configuration
    include Singleton
    attr_accessor :host, :port, :graph
  end
end
