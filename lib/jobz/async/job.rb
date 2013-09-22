require 'active_support/core_ext'

module Jobz
    module Async
        class Job
            class << self
                def perform(metadata, *args)
                    metadata = metadata.with_indifferent_access
                    object = resolve(metadata)
                    object.send metadata[:method], *args
                end

                def resolve(metadata)
                    klazz = metadata[:class_name].constantize
                    if klazz.respond_to?(:jobz)
                        klazz.jobz.resolve(klazz, metadata)
                    else
                        klazz
                    end
                end
            end
        end
    end
end