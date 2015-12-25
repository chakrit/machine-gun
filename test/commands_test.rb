require 'support'

module MachineGun
  class CommandsTest < MachineGunTest
    def test_ping
      assert_send 'ping', { hello: "world" }, { "pong" => "result" } do
        assert_equal "result", Commands.ping(hello: "world")
      end
    end

    def test_start
      assert_send 'start', { }, nil do
        assert_nil Commands.start
      end
    end

    def test_stop
      assert_send 'stop', { }, nil do
        assert_nil Commands.stop
      end
    end

    def test_request
      payload = TEST_REQUEST_COMMAND

      assert_send 'request', payload, { "id" => 1 } do
        result = Commands.request(:get, payload[:url], payload[:headers], payload[:payload])
        assert_equal 1, result
      end
    end

    def test_response
      assert_send 'response', { id: 1337 }, nil do
        Commands.response(1337)
      end
    end
  end
end
