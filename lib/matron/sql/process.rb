module Matron
  module Sql
    class Process
      attr_reader :process_id, :user, :host, :db, :command, :time, :state, :info

      def initialize db_connection, row
        @db_connection = db_connection
        self.process_id = row[:Id]
        self.user = row[:User]
        self.host = row[:Host]
        self.db = row[:db]
        self.command = row[:Command]
        self.time = row[:Time]
        self.state = row[:State]
        self.info = row[:Info]
      end

      def kill!
        @db_connection.run "kill #{process_id}"
      end
    end
  end
end