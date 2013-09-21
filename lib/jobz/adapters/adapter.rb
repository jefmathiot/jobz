module Jobz
    module Adapter
        extend ActiveSupport::Concern

        module ClassMethods
            def register_as(name)
                Jobz.config.register_adapter name, self
            end
        end
    end
end