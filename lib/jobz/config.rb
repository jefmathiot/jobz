require 'jobz/adapters'

module Jobz
    module Config

        def config
            @config ||= Configuration.new
        end

        class Configuration
            include Adapters

            [:adapter, :inline, :adapter_options].each do |attribute|

                attr_writer attribute

                class_eval <<-EOF
                def #{attribute}(value=nil)
                    @#{attribute} || defaults[:#{attribute}]
                end
                EOF
            end

            def adapter_instance
                return adapter_for(:inline, {}) if inline
                adapter_for(adapter, adapter_options)
            end

            private
            def defaults
                @defaults ||= {adapter: :resque, inline: false}
            end
        end

    end

end
