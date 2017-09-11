describe Pubsub::Redis::DomainEventListener do
  let(:channel) { 'domain-events-other' }

  before(:each) do
    @redis_client = instance_spy(Pubsub::Redis::Client)
    @event_listener = Pubsub::Redis::DomainEventListener.new(
      @redis_client, channel
    )
  end

  context 'when subscribing to a channel' do
    it 'waits until a message arrives' do
      @event_listener.listen { |message| message }

      expect(@redis_client).to have_received(:subscribe).with(channel)
    end
  end
end
