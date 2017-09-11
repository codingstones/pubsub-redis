require 'pubsub'
require 'pubsub/redis/client'
require 'pubsub/redis/version'

module Pubsub
  module Redis
    class DomainEventPublisher < Pubsub::DomainEventPublisher
      def initialize(redis_client, serializer, channel)
        @redis_client = redis_client
        @serializer = serializer
        @channel = channel
      end

      def publish(domain_event)
        @redis_client.publish(@channel,
                              @serializer.serialize(domain_event.to_h))
      end
    end

    class DomainEventListener < Pubsub::DomainEventListener
      def initialize(redis_client, channel)
        @redis_client = redis_client
        @channel = channel
      end

      def listen(&_block)
        @redis_client.subscribe(@channel) do |message|
          yield message
        end
      end
    end
  end
end
