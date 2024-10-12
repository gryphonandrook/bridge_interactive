# BridgeInteractive

BridgeInteractive is a Ruby gem that provides a unified API client for interacting with both the Bridge Web API and RESO Web API. It allows you to work with datasets, properties, members, offices, and open houses from both systems using a flexible configuration.

## Installation

Add this line to your application's Gemfile:

```bash
gem 'bridge_interactive'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install bridge_interactive
```

## Getting Started

Once installed, you can configure the gem with your access token and API type (either :bridge for the Bridge Web API or :reso for the RESO Web API). You can set these configurations globally or override them on a per-use basis.

## Configuration

To configure the gem globally, create an initializer in your Rails app (e.g., config/initializers/bridge_interactive.rb):

```bash
BridgeInteractive.configure do |config|
  config.api_type = :bridge   # or :reso
  config.timeout = 30         # Timeout for API requests in seconds
  config.logger = Rails.logger # Use the Rails logger, or provide your custom logger
end
```

## Usage

### Initializing the Client

You can initialize the API client using your server_token. The api_type can be either :bridge or :reso. If not provided, the default from the configuration will be used:

```bash
client = BridgeInteractive::API.new('your_server_token', api_type: :bridge)
```

### Fetching Datasets

For Bridge API:

```bash
datasets = client.datasets.all
```

For RESO API, use lookup to fetch RESO-specific datasets.

### Fetching Properties or Listings

To fetch properties or listings:

```bash
# For Bridge API (listings)
listings = client.property.all('dataset_id')

# For RESO API (properties)
properties = client.property(api_type: :reso).all('dataset_id')
```

### Fetching Agents or Members

For Bridge API, agents are used, while for RESO API, members are equivalent.

```bash
# For Bridge API (agents)
agents = client.agents.all('dataset_id')

# For RESO API (members)
members = client.members.all('dataset_id')
```

### Fetching Open Houses

The OpenHouse resource is available in both APIs:

```bash
# For Bridge API
open_houses = client.open_houses.all

# For RESO API
open_houses = client.open_houses(api_type: :reso).all
```

### Error Handling

The gem raises errors when attempting to use the wrong API for certain resources. For example:

```bash
begin
  lookup_data = client.lookup.all('dataset_id') # Will fail if api_type is :bridge
rescue StandardError => e
  puts e.message
end
```

### Custom Use Cases

You can override the global configuration for specific API calls:

```bash
# Use RESO API for fetching members, overriding the global setting
members = client.members(api_type: :reso).all('dataset_id')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gryphonandrook/bridge_interactive.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
