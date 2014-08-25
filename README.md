# [WIP] Helen

Use Helen to manipulate and traverse Titan graphs through the RexPro protocol.

## Installation

Add this line to your application's Gemfile:

    gem 'helen'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install helen

## Usage

### Connect to your graph.

```ruby
helen = Helen::Client.new(host: 'localhost', port: 8184, graph: 'gods')

# You can also define global configuration options. These values will be applied to clients
# without specific settings.
Helen::Client.configure do |c|
  c.host = 'localhost'
  c.port = 8184
  c.graph = 'gods'
end
```

### Basic traverse

Considering Titan's graph of the gods:

![gods](https://raw.githubusercontent.com/wiki/thinkaurelius/titan/images/graph-of-the-gods-2.png)

```ruby
# Get a saturn
saturn = helen.vertex(name: 'saturn')
=> #<Helen::Vertex _id: 1, name: 'saturn', age: '10000', type: 'titan'>

# Get all vertices with a given property.
monsters = helen.v(type: 'monster')
=> [ #<Helen::Vertex _id: 15, name: 'nemean', type: 'monster'>,
     #<Helen::Vertex _id: 16, name: 'hydra', type: 'monster'>,
     #<Helen::Vertex _id: 17, name: 'cerberus', type: 'monster'> ]

# Get saturn's grandchild
hercules = saturn.inv_father.inv_father
=> [ #<Helen::Vertex _id: 6, name: 'hercules', age: '30', type: 'demigod'> ]

# hercules grandfather
hercules.father.father
=> [ #<Helen::Vertex _id: 1, name: 'saturn', age: '10000', type: 'titan'> ]

hercules.father_and_mother
=> [ #<Helen::Vertex _id: 4, name: 'jupiter', age: '5000', type: 'god'>,
=>   #<Helen::Vertex _id: 5, name: 'alcmene', age: '45', type: 'human'> ]
```

### Basic manipulation

```ruby
cerberus = Helen::Vertex.create(name: 'cerberus', type:  'monster')
=> #<Helen::Vertex _id: 15, name: 'cerberus', type: 'monster'>

# Create an edge between two vertices
hercules.battled!(cerberus, time: 12, place: [39, 22])

cerberus.destroy
```

# TODO:

1. Make it possible to alias edges, e.g 'inv_father' could be defined as 'son'.
2. Fix driver bindings for g.addVertex.
3. Helen::Vertex#create should modify the object with the updated _id if it's successful.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/helen/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
