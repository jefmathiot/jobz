require 'resque_scheduler'
require 'jobz/adapters/adapter'

module Jobz
    module Adapters
        class ResqueAdapter
            include Adapter
            include Resque
            include ResqueScheduler

            register_as :resque

        end
    end
end