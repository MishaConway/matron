module Matron
  class Monitor
    def initialize db_configs=["mysql://root:root@localhost/main-website-rails_development"]
      @db_connections = db_configs.map do |db_config|
          Sequel.connect db_config
      end
    end

    def monitor
      @db_connections.each do |db|
        monitor_db_connection db
      end
    end

protected

    def monitor_db_connection( db )
      processes = Matron::Sql::Processes.new(db).process_list
      processes.each do |process|
        monitor_process process
      end
    end

    def monitor_process process
      app = Matron::Hosts.app_for_host process.host
      if app
        app_config = Matron::Hosts.config_for_app app
        if app_config
          if app_config[:max_query_time].to_i > 0 && process.time > app_config[:max_query_time]
            process.kill!
          end
        end
      end
    end
  end
end