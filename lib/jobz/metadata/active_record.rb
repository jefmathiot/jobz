module Jobz
    module Metadata
        module ActiveRecord
            def jobz
                ActiveRecordHandler.new
            end

            class ActiveRecordHandler < Handler
                def metadata(subject)
                    super.merge( primary_key: subject.id )
                end

                def resolve(klazz, metadata)
                    klazz.find(metadata[:primary_key])
                end
            end
        end
    end
end