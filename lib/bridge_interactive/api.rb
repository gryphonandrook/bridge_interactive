require_relative 'bridge/agent'
require_relative 'bridge/dataset'
require_relative 'bridge/listing'
require_relative 'bridge/office'
require_relative 'bridge/open_house'

require_relative 'reso/lookup'
require_relative 'reso/member'
require_relative 'reso/office'
require_relative 'reso/open_house'
require_relative 'reso/property'

module BridgeInteractive
  class API
    attr_reader :client, :server_token

    def initialize(server_token, api_type: nil)
      @client = HTTPClient.new
      @server_token = server_token

      # Use the api_type passed in, or fall back to the globally configured api_type
      @api_type = api_type || BridgeInteractive.configuration.api_type

      # Apply global configuration settings to the client
      @client.connect_timeout = BridgeInteractive.configuration.timeout if BridgeInteractive.configuration
    end

    # Fetch dataset resource
    def datasets
      if @api_type == :bridge
        Bridge::Dataset.new(@client, @server_token)
      else
        log_and_return_error('datasets', 'Bridge')
      end
    end

    # Fetch lookup resource
    def lookup
      if @api_type == :reso
        Reso::Lookup.new(@client, @server_token)
      else
        log_and_return_error('lookup', 'RESO')
      end
    end

    # Fetch member resource, allowing custom api_type to be passed
    def member(api_type: nil)
      selected_api_type = api_type || @api_type
      selected_api_type == :bridge ? Bridge::Agent.new(@client, @server_token) : Reso::Member.new(@client, @server_token)
    end

    alias agents member

    # Fetch office resource, allowing custom api_type to be passed
    def offices(api_type: nil)
      selected_api_type = api_type || @api_type
      selected_api_type == :bridge ? Bridge::Office.new(@client, @server_token) : Reso::Office.new(@client, @server_token)
    end

    alias office offices

    # Fetch open house resource, allowing custom api_type to be passed
    def open_houses(api_type: nil)
      selected_api_type = api_type || @api_type
      selected_api_type == :bridge ? Bridge::OpenHouse.new(@client, @server_token) : Reso::OpenHouse.new(@client, @server_token)
    end

    alias open_house open_houses

    # Fetch property resource, allowing custom api_type to be passed
    def property(api_type: nil)
      selected_api_type = api_type || @api_type
      selected_api_type == :bridge ? Bridge::Listing.new(@client, @server_token) : Reso::Property.new(@client, @server_token)
    end

    alias listings property

    private

    # Log error and return false
    def log_and_return_error(method_name, required_api)
      message = "Error: '#{method_name}' can only be used with the #{required_api} API."
      BridgeInteractive.configuration.logger.error(message) if BridgeInteractive.configuration.logger
      raise StandardError, message
    end

    # Logging functionality (using the global logger, if provided)
    def log(message)
      BridgeInteractive.configuration.logger.info(message) if BridgeInteractive.configuration.logger
    end
  end
end
