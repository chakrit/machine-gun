require 'bridge'
require 'commands'
require 'request'

module MachineGun
  class Error < StandardError
    attr_accessor :code

    def initialize(code, message)
      super message
      @code = code
    end
  end
end
