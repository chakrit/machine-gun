module MachineGun
  module Commands
    def self.ping(input)
      Bridge.command('ping', input)["pong"]
    end

    def self.start
      Bridge.command('start', { })
    end

    def self.stop
      Bridge.command('stop', { })
    end

    def self.request(method, url, headers, payload=nil)
      Bridge.command('request', {
        method: method,
        url: url,
        headers: headers,
        payload: payload
      })["id"]
    end

    def self.response(id)
      Bridge.command('response', id: id)
    end
  end
end
