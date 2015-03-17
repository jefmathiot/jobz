module Jobz
    module Adapters
        class InlineAdapter
            include Adapter

            register_as :inline

            def enqueue_at_with_queue( queue, timestamp, job, metadata, *args )
                enqueue_to( queue, job, metadata, *args )
            end

            def enqueue_to( queue, job, metadata, *args )
                args.collect! do |arg|
                    JSON.dump arg
                end
                args.collect! do |arg|
                    JSON.load arg
                end
                job.perform(metadata, *args)
            end

        end
    end
end
