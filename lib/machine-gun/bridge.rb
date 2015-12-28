require 'ffi'
require 'json'

module MachineGun
  module Bridge
    extend FFI::Library

    def self.lib_path
      path = "../#{OS.host}/#{OS.arch}/machine-gun.so"
      File.absolute_path(File.join(File.dirname(__FILE__), path))
    end

    ffi_lib lib_path
    attach_function :Free, [:pointer], :int

    attach_function :BridgeCommand, [:string, :string, :pointer], :int
    def self.command(cmd, in_hash)
      input = JSON.generate(in_hash) rescue nil

      out_ptr = FFI::MemoryPointer.new(:pointer, 1)
      BridgeCommand(cmd, input, out_ptr)
      out_json = out_ptr.read_pointer.read_string.force_encoding('UTF-8')
      Free(out_ptr.read_pointer)

      result = JSON.load(out_json)
      if result && result["error"]
        raise Error.new(result["code"], result["error"])
      end

      result
    end
  end
end
