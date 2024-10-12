module BridgeInteractive
  class Configuration
    attr_accessor :timeout, :logger, :api_type

    def initialize
      @timeout = 30          # Default timeout
      @logger = nil          # Default logger
      @api_type = :bridge    # Default API type (:bridge or :reso)
    end
  end
end
