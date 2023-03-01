# Tenkit 天気ト

A wrapper for Apple's WeatherKit API in Ruby

A portmanteau of "tenki" the Japanese word for weather, and "kit", the end of WeatherKit.


## Installation

Add to `Gemfile`

```
gem 'tenkit'
```

## Usage

```ruby
Tenkit.configure do |c|
  c.team_id = "APPLE DEVELOPER TEAM ID"
  c.service_id = "APPLE DEVELOPER SERVICE ID"
  c.key_id = "APPLE DEVELOPER KEY ID"
  c.key =  "APPLE DEVELOPER PRIVATE KEY"
end

client = Tenkit::Client.new

lat = '37.323'
lon = '122.032'

client.weather(lat, lon)
```

Maintained by: **[Super Basic](https://superbasic.xyz)**
