require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :test)

require 'pry'
require 'minitest/autorun'
require 'spy'
require 'spy/integration'

require 'machine-gun'

module MachineGun
  class MachineGunTest < MiniTest::Test
    TEST_REQUEST_COMMAND = {
      method: :get,
      url: "https://api.example.com/v1",
      headers: {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      },
      payload: "{\"hello\":\"world\"}"
    }

    TEST_RESPONSE_COMMAND_RESULT = {
      "status_code" => 404,
      "headers" => { "Content-Type" => "application/json" },
      "payload" => "{\"error\":\"not_found\"}"
    }

    def teardown
      super
      Spy.teardown
    end

    protected

    def assert_send(cmd, input, output)
      Spy.on(Bridge, :command).and_return(output)
      result = yield
      assert_received_with Bridge, :command, cmd, input

      result
    end
  end
end
