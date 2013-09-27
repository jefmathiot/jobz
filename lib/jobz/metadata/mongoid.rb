module Jobz
    module Metadata
        module Mongoid
            def jobz
                MongoidHandler.new
            end

            class MongoidHandler < Handler
                def metadata(subject)
                    super.merge( document_id: subject.id )
                end

                def resolve(klazz, metadata)
                    klazz.find(metadata[:document_id])
                end
            end
        end
    end
end