require 'jobz/adapters/adapter'

module Jobz
    module Adapters
        def register_adapter(name, klazz)
            adapters[name] = klazz
        end

        protected
        def adapters
            @adapters ||= {}
        end

        def adapter_for(name, options)
            adapters[name].new(options)
        end
    end
end
