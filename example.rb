require 'machine-gun'

def protect
  yield
rescue MachineGun::Error => e
  "ERR  #{e}"
end

def example
  MachineGun.start

  responses = (1..30).
    map { |n| MachineGun::Request.new(:get, 'http://google.co.th', { }) }.
    map do |req|
      protect do
        resp = req.response
        "#{resp.status_code} #{resp.payload[0,10]} ..."
      end
    end

  responses.each do |line|
    puts line
  end

ensure
  MachineGun.stop
end

example
