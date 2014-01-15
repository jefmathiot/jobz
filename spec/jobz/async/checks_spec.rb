require 'spec_helper'

describe Jobz::Async::Checks do

    class TestDouble
        def exact(arg) ; end
        def optional(expected, *optional) ; end
    end

    before do
        @object = TestDouble.new
        klazz = Class.new
        klazz.send :include, Jobz::Async::Checks
        @checks = klazz.new
    end

    describe "on checking arity" do


        describe "with an exact expected numbers of arguments" do

            it "should raise if lower number of arguments than expected" do
                ->(){@checks.send( :check_arity!, @object, :exact, 0)}.must_raise(RuntimeError)
            end

            it "should raise if greater number of arguments than expected" do
                ->(){@checks.send( :check_arity!, @object, :exact, 2)}.must_raise(RuntimeError)
            end

            it "should not raise with the correct number of arguments" do
                @checks.send( :check_arity!, @object, :exact, 1)
            end

        end

        describe "with a variable number of arguments" do

            it "should raise if lower number of arguments than expected" do
                ->(){@checks.send( :check_arity!, @object, :optional, 1)}.must_raise(RuntimeError)
            end

            it "should not raise with the correct number of arguments" do
                @checks.send( :check_arity!, @object, :optional, 2)
                @checks.send( :check_arity!, @object, :optional, 3)
            end

        end

    end

    it "should ensure object responds to method" do
        @checks.send( :check_responds_to!, @object, :exact)
        ->(){@checks.send( :check_responds_to!, @object, :wtf)}.must_raise(RuntimeError)
    end

    it "should check whether method call is queuable" do
        ->(){ @checks.send( :check_queueable!, @object, :wtf) }.must_raise(RuntimeError)
        ->(){ @checks.send( :check_queueable!, @object, :exact) }.must_raise(RuntimeError)
        @checks.send( :check_queueable!, @object, :optional, 1, 2)
    end
end