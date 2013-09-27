require 'jobz/adapters'

module Jobz
    module Config

        def config
            @config ||= Configuration.new
            yield @config if block_given?
            @config
        end

        class Configuration
            include Adapters

            [:adapter, :inline].each do |attribute|
                attr_writer attribute
                class_eval <<-EOF
                def #{attribute}
                    @#{attribute} ||= defaults[:#{attribute}]
                end
                EOF
            end

            def adapter_instance
                self.inline ? adapter_for(:inline) : adapter_for(adapter)
            end

            private
            def defaults
                @defaults||={adapter: :resque, inline: false}
            end
        end

    end

end