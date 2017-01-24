module Matron
  module Consul
    class Lock
      attr_reader :shard_index

      def initialize(shard_index)
        @shard_index = shard_index
      end

      def renew!
        Diplomat::Session.renew session_id
      end

      def lock
        lock_acquired = Diplomat::Lock.acquire key, session_id
        if lock_acquired
          begin
            yield
          rescue Exception => e
            raise e
          ensure
            Rails.logger.info "releasing lock on shard index #{shard_index}"
            unlock
          end
        end
      end

      def unlock
        Diplomat::Lock.release key, session_id
      end

      def key
        "#{Rails.env}/voice-sns-workers/kinesis/shards-#{shard_index}/lock"
      end

      def session_id
        @session_id ||= Diplomat::Session.create "LockDelay" => "15s", "TTL" => "60s"
      end
    end
  end
end