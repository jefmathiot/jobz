require "jobz/version"

require "active_support"

require "jobz/async"
require "jobz/config"
require "jobz/metadata"

module Jobz
  extend Config
  extend Async
end

if defined?(Rails::Railtie)
    require "jobz/railtie"
end

require 'jobz/adapters/resque_adapter'
require 'jobz/adapters/inline_adapter'