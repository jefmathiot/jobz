module Jobz
    module Metadata
        class Handler

            def initialize(primary_key)
                @primary_key = primary_key
            end

            def metadata(subject)
                { :class_name => subject.class.name, @primary_key => subject.id }
            end

            def resolve(klazz, metadata)
              klazz.unscoped.find(metadata[@primary_key])
            end

        end
    end
end
