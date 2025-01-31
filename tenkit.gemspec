# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'tenkit/version'

Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'tenkit'
  s.version = Tenkit::VERSION
  s.required_ruby_version = '>= 2.6.7'
  s.summary = 'Wrapper for WeatherKit API'
  s.description = 'Wrapper for Weatherkit API'
  s.author = 'James Pierce'
  s.email = 'james@superbasic.xyz'
  s.homepage = 'https://github.com/superbasicxyz/tenkit'
  s.license = 'MIT'
  s.files = Dir['lib/tenkit.rb', 'lib/**/*.rb']

  s.add_dependency 'httparty', '~> 0.21.0'
  s.add_dependency 'jwt', '~> 2.7.0'

  s.add_development_dependency 'bundler', '~> 2.4.22'
  s.add_development_dependency 'dotenv', '~> 2.8'
  s.add_development_dependency 'rake', '~> 12.3'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 3.8'
end
