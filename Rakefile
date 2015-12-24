require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << './lib'
  t.libs << './test'
  t.pattern = "test/*_test.rb"
  t.test_files = FileList["test/**/*_test.rb"]
end

task default: [:build, :check, :test]

task :test_go do
  puts `go test -v -timeout 1s src/*.go`
end

task :check do
  # Checks for any ruby errors before Bundler eats them up.
  require_relative './lib/machine-gun.rb'
  puts 'Binding looks OK.'
  puts
end

task :build do
  puts 'Building shared library (machine-gun.so)...'
  puts `go build -v -buildmode=c-shared -o lib/machine-gun.so src/*.go`
end
