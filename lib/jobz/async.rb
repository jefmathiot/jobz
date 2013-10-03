require 'jobz/async/checks'
require 'jobz/async/job'
require 'jobz/async/methods'
require 'jobz/async/wrapper'

module Jobz
    module Async
        def deferrable!( klazz, metadata = nil )
            klazz.send :include, Methods
            klazz.send :include, metadata if metadata
        end
    end
end