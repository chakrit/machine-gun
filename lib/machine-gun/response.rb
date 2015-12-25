module MachineGun
  class Response
    attr_accessor :id
    attr_accessor :status_code
    attr_accessor :headers
    attr_accessor :payload

    def initialize(id)
      response = Commands.response(id)

      @id = id
      @status_code = response["status_code"]
      @headers = response["headers"]
      @payload = response["payload"]
    end

    def payload_as_json
      JSON.load(@payload)
    end
  end
end
