require 'spec_helper'

describe Jobz::Metadata::Handler do
    
    subject do
        Jobz::Metadata::Handler.new
    end

    it 'should extract class name' do
        subject.metadata(Object.new).must_equal({class_name: 'Object'})
    end
end