require 'machine-gun/bridge'
require 'machine-gun/commands'
require 'machine-gun/request'
require 'machine-gun/response'

module MachineGun
  def self.start
    Commands.start
  end

  def self.stop
    Commands.stop
  end

  class Error < StandardError
    attr_accessor :code

    def initialize(code, message)
      super message
      @code = code
    end
  end
end
