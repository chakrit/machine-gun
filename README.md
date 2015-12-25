# MACHINE-GUN.rb

Fire asynchronous HTTP requests **in ruby** like a machine gun.
Utilizing the power of goroutines.

# INSTALL

```ruby
gem 'machine-gun'
```

# USE

**DON'T** do this:

```ruby
require 'net/http'

responses = [
  Net::HTTP.get('example.com', '/one.html'),
  Net::HTTP.get('example.com', '/two.html'),
  Net::HTTP.get('example.com', '/three.html')
]
```

This will perform HTTP requests serially, waiting before the last one finish before the
next one starts. This will also blocks your ruby Thread for the total duration of the 3
calls.

**INSTEAD DO** this:

```ruby
require 'machine-gun'

responses = [
  MachineGun::Request.new(:get, 'http://example.com/one.html', { })
  MachineGun::Request.new(:get, 'http://example.com/two.html', { })
  MachineGun::Request.new(:get, 'http://example.com/three.html', { })
].map { |req| req.response }
```

This will first 3 HTTP requests simultaneously in the background (more specifically, in a
hidden goroutine). And then waits for the result. This will blocks your ruby Thread only
for the duration of the longest request.

# LICENSE

MIT

