require 'httpclient'
require 'json'

require_relative 'bridge_interactive/version'
require_relative 'bridge_interactive/configuration'
require_relative 'bridge_interactive/api'
require_relative 'bridge_interactive/error'

module BridgeInteractive
  class << self
    attr_accessor :configuration

    # Automatically create a configuration object if it doesn't exist
    def configuration
      @configuration ||= Configuration.new
    end

    # Create or yield the configuration block
    def configure
      yield(configuration)
    end

    # Reset the configuration to default
    def reset_configuration
      @configuration = Configuration.new
    end
  end
end
