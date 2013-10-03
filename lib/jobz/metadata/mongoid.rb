module Jobz
    module Metadata
        module Mongoid
            extend ActiveSupport::Concern
            
            module ClassMethods
                def jobz
                    MongoidHandler.new
                end
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