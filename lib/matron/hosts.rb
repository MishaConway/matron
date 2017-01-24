module Matron
  class Hosts
    def app_for_host host
      ::Diplomat::Kv.get "matron/hosts/#{host}"
    end

    def hosts_for_app app
      Matron::Client.new(app).hosts
    end
  end
end