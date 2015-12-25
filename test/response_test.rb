require 'support'

module MachineGun
  class ResposeTest < MachineGunTest
    def test_initialize
      result = TEST_RESPONSE_COMMAND_RESULT

      assert_send 'response', { id: 333 }, result do
        response = Response.new(333)
        assert_equal 333, response.id
        assert_equal result["status_code"], response.status_code
        assert_equal result["headers"], response.headers
        assert_equal result["payload"], response.payload
      end
    end

    def test_payload_as_json
      Spy.on(Commands, :response).and_return(TEST_RESPONSE_COMMAND_RESULT)
      json = Response.new(333).payload_as_json
      assert_equal "not_found", json["error"]
    end
  end
end
