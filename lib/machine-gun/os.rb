module MachineGun
  module OS
    class << self
      def platform
        RUBY_PLATFORM
      end

      def host
        h = platform.split('-')[1]

        case
        when h =~ /darwin/
          'darwin'
        when h =~ /linux/
          'linux'
        else
          'unknown'
        end
      end

      def arch
        platform.split('-')[0]
      end

      def mac?
        host =~ /darwin/i
      end

      def linux?
        host =~ /linux/i
      end
    end
  end
end
