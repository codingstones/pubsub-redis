require 'redis'

module Pubsub
  module Redis
    class Client
      def initialize(url)
        @redis_client = ::Redis.new(url: url)
      end

      def publish(channel, message)
        @redis_client.publish(channel, message)
      end

      def subscribe(channel)
        @redis_client.subscribe(channel) do |on|
          on.message do |_channel, message|
            yield message
          end
        end
      end
    end
  end
end
