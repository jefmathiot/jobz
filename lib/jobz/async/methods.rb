module Jobz
    module Async
        module Methods
            def async(queue)
                Wrapper.new(self, queue, Jobz.config)
            end
        end
    end
end