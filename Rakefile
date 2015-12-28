require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << './lib'
  t.libs << './test'
  t.pattern = "test/*_test.rb"
  t.test_files = FileList["test/**/*_test.rb"]
end

task default: [:build, :check, :test]

task :go_test do
  puts `go test -v -timeout 1s src/*.go`
end

task :check do
  # Checks for any ruby errors before Bundler eats them up.
  puts '# Checking Ruby bindings'
  require_relative './lib/machine-gun.rb'
  puts
end

task :build do
  puts '# Building shared library (machine-gun.so)...'
  puts `./build-so.sh`
end
