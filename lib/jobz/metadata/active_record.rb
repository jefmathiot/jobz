module Jobz
    module Metadata
        module ActiveRecord
            extend ActiveSupport::Concern

            module ClassMethods
                def jobz
                    Handler.new :primary_key
                end
            end
        end
    end
end
