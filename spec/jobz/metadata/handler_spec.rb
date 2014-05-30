require 'spec_helper'

describe Jobz::Metadata::Handler do    
    subject do
        Jobz::Metadata::Handler.new :foo
    end

    it 'should add the document id to the metadata' do
        model = Object.new
        model.class.expects(:name).returns('Model')
        model.expects(:id).returns(1)
        subject.metadata(model).must_equal({class_name: 'Model', foo: 1})
    end

    it 'should resolve object using unscoped finder' do
        klazz = Class.new
        model = klazz.new.tap{|o| o.stubs(:id).returns(1)}
        klazz.expects(:unscoped).returns(klazz)
        klazz.expects(:find).with(1).returns(model)
        subject.resolve(klazz, {foo: 1}).id.must_equal 1
    end
end
