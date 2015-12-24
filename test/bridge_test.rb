require 'support'

module MachineGun
  class BridgeTest < MiniTest::Test
    def test_hello
      result = Bridge.hello("cross FFI boundary")
      assert_equal "Hello, cross FFI boundary", result
    end

    def test_hello_array
      inputs = %w(Jack John Jim)
      outputs = [
        "Hello, Jack",
        "Hello, John",
        "Hello, Jim"
      ]

      result = Bridge.hello_array(%w(Jack John Jim))
      assert_equal outputs, result
    end
  end
end

