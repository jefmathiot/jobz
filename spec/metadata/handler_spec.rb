require 'spec_helper'

describe Jobz::Metadata::Handler do
    
    subject do
        Jobz::Metadata::Handler.new :foo
    end

    class Mock
        def id
            :bar
        end
    end

    it 'should extract class name' do
        subject.metadata(Mock.new).must_equal({class_name: 'Mock', foo: :bar})
    end
end
