require 'resque_scheduler'

module Jobz
    module Adapters
        class ResqueAdapter
            include Adapter
            include Resque
            include ResqueScheduler

            register_as :resque

            def initialize(options)
              self.redis = Redis.new(options || {})
            end
        end
    end
end
