require 'support'

module MachineGun
  class BridgeTest < MiniTest::Test
    def test_command
      result = Bridge.command("ping", hello: "world")
      refute_nil result
      assert_instance_of Hash, result
      assert_equal "{\"hello\":\"world\"}", result["pong"]
    end

    def test_command_error
      assert_raises MachineGun::Error do
        Bridge.command('unimplemented_command', { })
      end

      assert_raises MachineGun::Error do
        Bridge.command('ping', nil)
      end
    end
  end
end

