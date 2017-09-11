describe Pubsub::Redis::DomainEventPublisher do
  let(:channel) { 'domain-events-other' }

  before(:each) do
    @redis_client = instance_spy(Pubsub::Redis::Client)
    @serializer = instance_spy(Pubsub::Serializer)
    @event_publisher = Pubsub::Redis::DomainEventPublisher.new(
      @redis_client, @serializer, channel
    )
  end

  context 'when publishing a domain event' do
    let(:event) { { name:  'irrelevant event name' } }

    it 'publishes serialized event message' do
      serialized = 'irrelevant serialized event'
      allow(@serializer).to \
        receive(:serialize).with(event).and_return(serialized)

      @event_publisher.publish(event)

      expect(@redis_client).to have_received(:publish).with(channel, serialized)
    end
  end
end
