require 'spec_helper'

describe Jobz::Async do

    subject do
        Class.new.tap{ |klazz| klazz.send :extend, Jobz::Async }
    end

    before do
        @klazz = Class.new
    end

    it 'should mark a class as deferrable' do
        subject.deferrable!(@klazz)
        @klazz.new.must_respond_to :async
    end

    module CustomHandler
        extend ActiveSupport::Concern
        module ClassMethods
            def jobz ; end
        end
    end

    it 'should mark a class as deferrable with a custom metadata handler' do
        subject.deferrable!(@klazz, CustomHandler)
        @klazz.new.must_respond_to :async
        @klazz.must_respond_to :jobz
    end
end