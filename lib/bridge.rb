require 'ffi'

module MachineGun
  module Bridge
    extend FFI::Library

    ffi_lib './lib/machine-gun.so'
    attach_function :Hello, [:string], :string
  end
end
