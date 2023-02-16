# Tenkit

A wrapper for Apple's WeatherKit API in Ruby

Maintained by: [Super Basic](https://superbasic.xyz)

## Installation

Add to `Gemfile`

```
gem 'tenkit'
```

## Usage

```ruby
config = {
  team_id: "APPLE DEVELOPER TEAM ID",
  service_id: "APPLE DEVELOPER SERVICE ID",
  key_id: "APPLE DEVELOPER KEY ID",
  key: "APPLE DEVELOPER PRIVATE KEY"
}

client = Tenkit::Client.new(config)

lat = '37.323'
lon = '122.032'

client.weather(lat, lon)
```
