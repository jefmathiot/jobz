require 'resque_scheduler'
require 'jobz/adapters/adapter'

module Jobz
    class ResqueAdapter
        include Adapter
        include Resque
        include ResqueScheduler

        register_as :resque

    end
end