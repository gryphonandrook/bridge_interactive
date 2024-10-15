# frozen_string_literal: true

require_relative "lib/bridge_interactive/version"

Gem::Specification.new do |spec|
  spec.name = "bridge_interactive"
  spec.version = BridgeInteractive::VERSION
  spec.authors = ["Stephen Higgins"]
  spec.email = ["stephen@gryphonandrook.com"]

  spec.summary = "BridgeInteractive is a Ruby gem that provides a unified API client for interacting with both the Bridge Web API and RESO Web API."
  spec.description = "BridgeInteractive is a Ruby gem that provides a unified API client for interacting with both the Bridge Web API and RESO Web API. It allows you to work with datasets, properties, members, offices, and open houses from both systems using a flexible configuration."
  spec.homepage = "https://github.com/gryphonandrook/bridge_interactive"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # Declare runtime dependencies here
  spec.add_runtime_dependency 'httpclient', '~> 2.8'  # Ensure HTTPClient is included

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/gryphonandrook/bridge_interactive"
  spec.metadata["changelog_uri"] = "https://github.com/gryphonandrook/bridge_interactive/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
