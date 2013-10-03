module Jobz
    class Railtie < ::Rails::Railtie

        # Attach the config to Rails configuration
        config.jobz = Jobz.config

        # Attach async methods to target classes and modules
        initializer 'jobz.attach' do
            ActiveSupport.on_load(:active_record) do
                Jobz.deferrable!( ActiveRecord::Base, ::Jobz::Metadata::ActiveRecord )
            end
            ActiveSupport.on_load(:mongoid) do
                Jobz.deferrable!( Mongoid::Document, ::Jobz::Metadata::Mongoid )
            end
        end

    end
end