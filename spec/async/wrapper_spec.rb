require 'spec_helper'
require 'timecop'

describe Jobz::Async::Wrapper do

    before do
        @queue = :critical
        @config = Jobz::Config::Configuration.new
        @wrapper_subject = Object
    end

    subject do
        Jobz::Async::Wrapper.new(@wrapper_subject, @queue, @config)
    end

    it 'should store subject, config and queue at initialization' do
        subject.instance_variable_get(:@subject).must_equal @wrapper_subject
        subject.instance_variable_get(:@queue).must_equal @queue
        subject.instance_variable_get(:@config).must_equal @config
    end

    it 'should store timestamp when using at' do
        ts = Time.now + 1.day
        wrapper = subject.at(ts)
        wrapper.must_equal subject
        subject.instance_variable_get(:@timestamp).must_equal ts
    end

    it 'should compute timestamp based on delay when using in' do
        Timecop.freeze(Time.local(2013, 9, 27, 0, 0, 0))
        wrapper = subject.in(1.day)
        wrapper.must_equal subject
        subject.instance_variable_get(:@timestamp).must_equal Time.local(2013, 9, 28, 0, 0, 0)
        Timecop.return
    end

    describe 'on checking respond to' do

        it 'should try to find a method by its own' do
            subject.respond_to?(:at).must_equal true
        end

        it 'should try to delegate method search to subject' do
            subject.respond_to?(:hey_you).must_equal false
            subject.stubs(:hey_you)
            subject.respond_to?(:hey_you).must_equal true
        end
    end

    describe 'on extracting subject metadata' do

        it 'should use a specific metadata handler if any' do
            handler = Object.new
            handler.expects(:metadata).with(@wrapper_subject).returns({key: :value})
            @wrapper_subject.class.expects(:jobz).returns(handler)
            subject.send(:metadata, :method_name).must_equal({key: :value, method: :method_name})
        end

        describe 'without any handler' do

            it 'should extract class info if no metadata handler available' do
                subject.instance_variable_set(:@subject, Object)
                subject.send(:metadata, :method_name).must_equal({class_name: 'Object', method: :method_name})
            end

            it 'should raise unless subject is a class' do
                subject.instance_variable_set(:@subject, Object.new)
                ->(){ subject.send(:metadata, :method_name) }.must_raise(RuntimeError)
            end

        end
    end

    describe 'on calling a missing method' do
        it 'should raise unless method is queueable' do
            ->(){ subject.pointless }.must_raise(RuntimeError)
        end

        describe 'with a test adapter' do

            before do
                @adapter = Object.new
                @config.expects(:adapter_instance).returns(@adapter)
                @wrapper_subject.stubs(:make)
            end

            it 'should enqueue job' do
                @adapter.expects(:enqueue_to).
                    with(@queue, Jobz::Async::Job, { class_name: 'Object', method: :make }, 1, 2)
                subject.make(1, 2)
            end

            it 'should enqueue at a given date if timestamp' do
                Timecop.freeze
                subject.instance_variable_set(:@timestamp, ts = Time.now)
                @adapter.expects(:enqueue_at_with_queue).
                    with(@queue, ts, Jobz::Async::Job, { class_name: 'Object', method: :make }, 1, 2)
                subject.make(1, 2)
                Timecop.return
            end

        end

    end
end