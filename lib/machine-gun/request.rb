module MachineGun
  class Request
    attr_accessor :id
    attr_accessor :method
    attr_accessor :url
    attr_accessor :headers
    attr_accessor :payload

    def initialize(method, url, headers, payload)
      @id = Commands.request(method, url, headers, payload)
      @method = method
    end

    def response
      Response.new(@id)
    end
  end
end

