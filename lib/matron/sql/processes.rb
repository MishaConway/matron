module Matron
  module Sql
    class Processes
      attr_reader :shard_index

      def initialize db
        @db = db
      end

      def process_list( hosts )
        DB['SHOW PROCESSLIST'].map do |row|
          ::Matron::Sql::Process.new @db, row
        end
      end
    end
  end
end