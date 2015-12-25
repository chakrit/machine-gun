require 'support'

module MachineGun
  class MachineGunModuleTest < MachineGunTest
    def test_start
      assert_send 'start', { }, { } do
        MachineGun.start
      end
    end

    def test_stop
      assert_send 'stop', { }, { } do
        MachineGun.stop
      end
    end
  end
end
