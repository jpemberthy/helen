# Helen

Use Helen to manipulate and traverse Titan graphs through the RexPro protocol.

## Installation

Add this line to your application's Gemfile:

    gem 'helen'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install helen

## Usage

# Connect to your graph.

    helen = Helen::Client.new(host: 'localhost', port: 8184, graph: 'gods')

# Basic traverse

    saturn = helen.vertex(name: 'saturn')
    => #<Helen::Vertex _id: 1, name: 'saturn', age: '10000', type: 'titan'>

    hercules = saturn.in(:father).in(:father)
    => #<Helen::Vertex _id: 6, name: 'hercules', age: '30', type: 'demigod'>

    hercules.father.father
    => #<Helen::Vertex _id: 1, name: 'saturn', age: '10000', type: 'titan'>

    hercules.father_and_mother
    => [ #<Helen::Vertex _id: 4, name: 'jupiter', age: '5000', type: 'god'>,
    =>   #<Helen::Vertex _id: 5, name: 'alcmene', age: '45', type: 'human'> ]

# Basic manipulation

    cerberus = Helen::Vertex.create(name: 'cerberus', type:  'monster')
    => #<Helen::Vertex _id: 15, name: 'cerberus', type: 'monster'>

    # Create an edge between two vertices
    hercules.battled!(cerberus, time: 12, place: [39, 22])

    cerberus.destroy

## Contributing

1. Fork it ( http://github.com/<my-github-username>/helen/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
