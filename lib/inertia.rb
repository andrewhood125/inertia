require "inertia/version"

require 'inertia/mass'
require 'inertia/grouped_mass'
require 'inertia/resistance'

module Inertia
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    yield(config)
  end

  class Configuration
    attr_accessor :ignore_scss, :ignore_js, :ignore_haml, :ignore_rabl, :ignore_erb, :ignore_ruby_spec
  end
end
