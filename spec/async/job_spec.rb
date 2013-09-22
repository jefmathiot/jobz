require 'spec_helper'
require 'active_support/inflector'

describe Jobz::Async::Job do

    class JobSubject
    end

    it 'should perform task' do
        JobSubject.expects(:respond_to?).with(:jobz).returns(false)
        JobSubject.expects(:a_method).with(1, 2)
        Jobz::Async::Job.perform({class_name: 'JobSubject', method: :a_method}, 1, 2)
    end
    
    it 'should resolve using handler if subject responds to jobz' do

        jobz = Object.new
        JobSubject.expects(:respond_to?).with(:jobz).returns(true)
        JobSubject.expects(:jobz).returns(jobz)
        jobz.expects(:resolve).with(JobSubject, {class_name: "JobSubject"}).returns("Value")
        Jobz::Async::Job.resolve( {class_name: "JobSubject"} ).must_equal "Value"
    end
    
    it 'should resolve to class unless subject responds to jobz' do
        Jobz::Async::Job.resolve( {class_name: "Object"} ).must_equal Object
    end

end