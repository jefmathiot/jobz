module Jobz
    module Metadata
        class Handler
            def metadata(subject)
                { class_name: subject.class.name }
            end
        end
    end
end