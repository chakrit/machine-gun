require 'support'

module MachineGun
  class OSTest < MachineGunTest
    MAC_PLATFORM = 'x86_64-darwin15'
    LINUX_PLATFORM = 'x86_64-linux-musl'

    def test_mac
      Spy.on(OS, :platform).and_return(MAC_PLATFORM)
      assert_equal 'darwin', OS.host
      assert_equal 'x86_64', OS.arch

      assert OS.mac?
      refute OS.linux?
    end

    def test_linux
      Spy.on(OS, :platform).and_return(LINUX_PLATFORM)
      assert_equal 'linux', OS.host
      assert_equal 'x86_64', OS.arch

      assert OS.linux?
      refute OS.mac?
    end
  end
end
