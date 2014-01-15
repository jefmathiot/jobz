require 'spec_helper'

describe Jobz::Async::Methods do

    subject do
        klazz = Class.new
        klazz.send :include, Jobz::Async::Methods
        klazz.new
    end

    it 'should build a new wrapper' do
        wrapper = subject.async(:critical)
        wrapper.instance_variable_get(:@subject).must_equal subject
        wrapper.instance_variable_get(:@queue).must_equal :critical
        wrapper.instance_variable_get(:@config).must_equal Jobz.config
    end
end