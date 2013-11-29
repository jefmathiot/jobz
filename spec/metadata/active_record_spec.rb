require 'spec_helper'

describe Jobz::Metadata::ActiveRecord do
    
    subject do
        Class.new.tap{ |klazz| klazz.send(:include, Jobz::Metadata::ActiveRecord) }
    end

    it 'should return an handler for active record' do
        subject.jobz.must_be_instance_of Jobz::Metadata::Handler
    end
end


describe Jobz::Metadata::Handler do
    
    subject do
        Jobz::Metadata::Handler.new :primary_key
    end

    it 'should add the primary key to the metadata' do
        model = Object.new
        model.class.expects(:name).returns('Model')
        model.expects(:id).returns(1)
        subject.metadata(model).must_equal({class_name: 'Model', primary_key: 1})
    end

    it 'should resolve object using AR finder' do
        klazz = Class.new
        model = klazz.new.tap{|o| o.stubs(:id).returns(1)}
        klazz.expects(:find).with(1).returns(model)
        subject.resolve(klazz, {primary_key: 1}).id.must_equal 1
    end
end
