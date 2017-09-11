describe Pubsub::Redis::Client, :integration do
  before(:each) do
    redis_url = ENV['REDIS_URL'] || 'redis://localhost:6379'
    @redis_client = Pubsub::Redis::Client.new(redis_url)
  end

  context 'when using as messsage broker' do
    let(:channel) { :foo }

    it 'publises a message and is received by subscriptor' do
      sent = 'message'
      received = ''

      @receiver = Pubsub::Redis::Client.new(@redis_url)
      subscriber = Thread.new do
        @receiver.subscribe(channel) do |message|
          received = message
          Thread.exit
        end
      end

      wait_until_subscribed
      @redis_client.publish(channel, sent)

      wait_until_message(subscriber)
      expect(received).to eq(sent)
    end

    def wait_until_subscribed
      sleep(0.001)
    end

    def wait_until_message(thread)
      thread.join(2)
    end
  end
end
