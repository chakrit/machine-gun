lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'machine-gun'
  s.version     = '0.2.0'
  s.date        = '2014-12-24'
  s.summary     = 'Fire HTTP requests like a machine gun.'
  s.description = 'Send multiple HTTP requests simultaneously from a single ruby Thread, powered by goroutines.'
  s.authors     = ['Chakrit Wichian']
  s.email       = 'chakrit@omise.co'
  s.homepage    = 'https://www.omise.co'
  s.license     = 'MIT'

  s.files         = `git ls-files -z lib`.split("\x0")
  s.require_paths = ['lib']

  s.add_runtime_dependency 'ffi', '~>1.9'
  s.add_runtime_dependency 'json', '~>1.8'

  s.add_development_dependency 'rake', '~>10.4'
  s.add_development_dependency 'pry', '~>0.10'
  s.add_development_dependency 'spy', '~>0.4'
  s.add_development_dependency 'bundler', '~>1.11'
  s.add_development_dependency 'minitest', '~>5.8'
end
