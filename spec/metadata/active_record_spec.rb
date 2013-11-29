require 'spec_helper'

describe Jobz::Metadata::ActiveRecord do
    
    subject do
        Class.new.tap{ |klazz| klazz.send(:include, Jobz::Metadata::ActiveRecord) }
    end

    it 'should return an handler for active record' do
        Jobz::Metadata::Handler.expects(:new).with(:primary_key).returns(:foo)
        subject.jobz.must_equal :foo
    end
end
