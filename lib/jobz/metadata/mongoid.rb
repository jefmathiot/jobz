module Jobz
    module Metadata
        module Mongoid
            extend ActiveSupport::Concern
            
            module ClassMethods
                def jobz
                    Handler.new :document_id
                end
            end
        end
    end
end
