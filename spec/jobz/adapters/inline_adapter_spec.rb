require 'spec_helper'

describe Jobz::Adapters::InlineAdapter do

    subject do
        Jobz::Adapters::InlineAdapter.new({})
    end

    before do
        @job = Object.new
        @job.expects(:perform).with({key: :value},
            1,
            '2014-10-10',
            "string",
            'symbol',
            {'hash'=> 10}
        )
    end

    it 'should jsonize args pass through enqueue at' do
        subject.enqueue_at_with_queue(:critical, Time.now, @job, {key: :value},
            1,
            Date.parse('2014-10-10'),
            "string",
            :symbol,
            {hash: 10}
        )
    end

    it 'should jsonize args pass through enqueue to' do
        subject.enqueue_to(:critical, @job, {key: :value},
            1,
            Date.parse('2014-10-10'),
            "string",
            :symbol,
            {hash: 10}
        )
    end

end
