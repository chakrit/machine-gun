require 'ffi'

module MachineGun
  module Bridge
    extend FFI::Library


    class Wrapper
      def initialize(method, url, headers={}, payload=nil)
      end
    end

    ffi_lib './lib/machine-gun.so'
    attach_function :Free, [:pointer], :int

    # Hello functions for testing the GO<->RB bridge.
    # Not actually used, kept for referece purpose.

    attach_function :Hello, [:string, :pointer], :int
    def self.hello(input)
      out_ptr = FFI::MemoryPointer.new(:pointer, 1)
      Hello(input, out_ptr)
      out_ptr.read_pointer.read_string.force_encoding('UTF-8')
    end

    attach_function :HelloArray, [:pointer, :int, :pointer, :pointer], :int
    def self.hello_array(inputs)
      input_ptrs = inputs.map { |input| FFI::MemoryPointer.from_string(input) }
      in_ptr = FFI::MemoryPointer.new(:pointer, input_ptrs.length)
      in_ptr.write_array_of_pointer(input_ptrs)

      out_ptr = FFI::MemoryPointer.new(:pointer, 1)
      out_len_ptr = FFI::MemoryPointer.new(:int, 1)
      HelloArray(in_ptr, inputs.length, out_ptr, out_len_ptr)

      out_len = out_len_ptr.read_bytes(4).unpack('l').first
      result = out_ptr.read_pointer.read_array_of_pointer(out_len).map do |ptr|
        ptr.read_string.force_encoding('UTF-8')
      end

      # cleanup allocations from go-side
      out_ptr.read_pointer.read_array_of_pointer(out_len).map { |ptr| Free(ptr) }
      Free(out_ptr.read_pointer)

      result
    end
  end
end
