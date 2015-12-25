require 'support'

module MachineGun
  class CommandsTest < MiniTest::Test
    def teardown
      super
      Spy.teardown
    end

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
      payload = {
        method: :get,
        url: "https://api.example.com/v1",
        headers: {
          "Content-Type" => "application/json",
          "Accept" => "application/json"
        },
        payload: "{\"hello\":\"world\"}"
      }

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

    private

    def assert_send(cmd, input, output)
      Spy.on(Bridge, :command).and_return(output)
      result = yield
      assert_received_with Bridge, :command, cmd, input

      result
    end
  end
end
