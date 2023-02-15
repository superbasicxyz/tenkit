# frozen_string_literal: true

Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'tenkit'
  s.version = '0.0.1'
  s.required_ruby_version = '>= 2.6.7'
  s.summary = 'Wrapper for WeatherKit API'
  s.description = 'Wrapper for Weatherkit API'
  s.author = 'James Pierce'
  s.email = 'james@superbasic.xyz'
  s.homepage = 'https://github.com/superbasicxyz/tenkit'
  s.license = 'MIT'

  s.add_dependency 'httparty'
  s.add_dependency 'jwt'

  s.add_development_dependency 'bundler', '~> 2.3.17'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'
end
