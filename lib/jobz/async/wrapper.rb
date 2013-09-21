module Jobz
    module Async
        class Wrapper
            include Checks

            def initialize(subject, queue, config)
                @subject = subject
                @queue = queue
                @config = config
            end

            def at(timestamp)
                @timestamp = timestamp
                self
            end

            def in(delay)
                @timestamp = Time.now + delay
                self
            end

            def respond_to?(method_sym, include_private = false)
                super || @subject.respond_to?(method_sym, include_private)
            end

            def method_missing(method_sym, *args, &block)
                # TODO If marked as inline, do not enqueue
                check_queueable!(@subject, method_sym, *args)
                if @timestamp
                    @config.adapter_instance.enqueue_at_with_queue( @queue, @timestamp, Job, metadata(method_sym), *args )
                else
                    @config.adapter_instance.enqueue_to( @queue, Job, metadata(method_sym), *args )
                end
            end

            private
            def metadata(method_sym)
                if @subject.class.respond_to?(:jobz)
                    # A specific handler has been found, delegating metadata
                    @subject.class.jobz.metadata( @subject ).merge(method: method_sym)
                else
                    # No specific handler for this kind of subject: we assume it is a class
                    # TODO Raise if its not...
                    {class_name: @subject, method: method_sym}
                end
            end

        end
    end
end