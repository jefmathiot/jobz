require 'spec_helper'

describe Jobz::Metadata::Mongoid do
    
    subject do
        Class.new.tap{ |klazz| klazz.send(:include, Jobz::Metadata::Mongoid) }
    end

    it 'should return an handler for mongoid' do
        Jobz::Metadata::Handler.expects(:new).with(:document_id).returns(:foo)
        subject.jobz.must_equal :foo
    end
end
