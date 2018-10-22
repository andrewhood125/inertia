require "inertia/version"

require 'inertia/mass'
require 'inertia/grouped_mass'
require 'inertia/resistance'

# Be nimble, be organized.
module Inertia
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    yield(config)
  end

  # Hold the configuration for the command
  class Configuration
    attr_accessor :ignore_scss,
                  :ignore_js,
                  :ignore_jsx,
                  :ignore_ts,
                  :ignore_tsx,
                  :ignore_haml,
                  :ignore_rabl,
                  :ignore_erb,
                  :ignore_ruby_spec,
                  :ignore_yml
  end
end
