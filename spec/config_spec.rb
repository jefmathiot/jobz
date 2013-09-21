require 'spec_helper'

describe Jobz::Config do

    describe "on a configuration object" do
        
        before do
            @config = Jobz::Config::Configuration.new
        end

        it "should use default attributes" do
            @config.adapter.must_equal :resque
            @config.inline.must_equal false
        end

        it "should allow attributes override" do
            @config.adapter = :whatever
            @config.adapter.must_equal :whatever
            @config.inline = true
            @config.inline.must_equal true
        end

        it "should provide adapter instances" do
            raise "Not implemented"
        end

    end

    before do
        klazz = Class.new
        klazz.send :include, Jobz::Config
        @helper = klazz.new
    end

    it "should return a singleton configuration" do
        config = @helper.config
        @helper.config.must_be_same_as config
    end

    it "should yield to block if any" do

    end

end