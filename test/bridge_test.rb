require 'support'

module MachineGun
  class BridgeTest < MiniTest::Test
    def test_hello
      result = Bridge.Hello("cross FFI boundary")
      assert_equal "Hello, cross FFI boundary", result
    end
  end
end

