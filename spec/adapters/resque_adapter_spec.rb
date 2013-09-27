require 'spec_helper'

describe Jobz::Adapters::ResqueAdapter do

    subject do
        Jobz::Adapters::ResqueAdapter.new
    end

    it 'should include resque scheduler API' do
        subject.must_respond_to :enqueue_at_with_queue
        subject.must_respond_to :enqueue_to
    end

end