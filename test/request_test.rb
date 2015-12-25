require 'support'

module MachineGun
  class RequestTest < MachineGunTest
    def test_initialize
      payload = TEST_REQUEST_COMMAND

      assert_send 'request', payload, { "id" => 3333 } do
        req = Request.new(payload[:method], payload[:url], payload[:headers], payload[:payload])
        assert_equal 3333, req.id
      end
    end

    def test_response
      Spy.on(Commands, :request).and_return(333)
      Spy.on(Commands, :response).and_return({ })

      response = Request.new(nil, nil, nil, nil).response
      assert_instance_of Response, response
      assert_equal 333, response.id
    end
  end
end
