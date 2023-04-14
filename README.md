# Tenkit 天気ト

![Gem](https://img.shields.io/gem/v/tenkit)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/superbasicxyz/tenkit/ruby.yml)

A wrapper for Apple's WeatherKit API in Ruby

A portmanteau of "tenki" the Japanese word for weather, and "kit", the end of WeatherKit.

This project is in beta, some of its API may be unstable, or possibly non-functional (like WeatherKit itself). We recommend pinning the version in your Gemfile until we get to a stable release, at which point we will be using [Semantic Versioning](https://semver.org/).

## Installation

Add to `Gemfile`

```
gem 'tenkit'
```

See Apple's instructions on how to [Get Started with Weatherkit](https://developer.apple.com/weatherkit/get-started/). Your WeatherKit API dashboard should be at this URL <https://developer.apple.com/account/resources/services/weatherkit>.



## Usage

See [Credentials](#credentials) for information on how to obtain the configuration values below.
```ruby
Tenkit.configure do |c|
  c.team_id = ENV["APPLE_DEVELOPER_TEAM_ID"]
  c.service_id = ENV["APPLE_DEVELOPER_SERVICE_ID"]
  c.key_id = ENV["APPLE_DEVELOPER_KEY_ID"]
  c.key =  ENV["APPLE_DEVELOPER_PRIVATE_KEY"]
end

client = Tenkit::Client.new

lat = '37.323'
lon = '122.032'

client.weather(lat, lon)
```

## Credentials

Once obtained, these values should be kept secret.

For Ruby you might use ENV variables, or a .env file **not committed to git**.

Rails projects will likely store these values encrypted in [custom credentials](https://guides.rubyonrails.org/security.html#custom-credentials), which can be commited to git.

### APPLE_DEVELOPER_TEAM_ID
This is your Apple Team ID, taken from the top-right of your [developer account certificates page](https://developer.apple.com/account/resources/certificates/list):

![screenshot example of where to find your team ID](doc/team_id-crunch.png)

### APPLE_DEVELOPER_SERVICE_ID
This is a Service ID that you’ll need to create: https://developer.apple.com/account/resources/identifiers/list/serviceId It will be in the same style as an App ID, as a reverse domain name, e.g. “com.example.fancypantsweather”

### APPLE_DEVELOPER_KEY_ID
Generate a new key: https://developer.apple.com/account/resources/authkeys/add Give it a name (not important but descriptive to you) and make sure to check “WeatherKit”

![screenshot example of registering a new key](doc/register_key-crunch.png)

Make sure you download the key and keep it safe for the next credential. Use the generated Key ID as the value for `APPLE DEVELOPER KEY ID`.

### APPLE_DEVELOPER_PRIVATE_KEY
This is the freshly downloaded private key, a .p8 file. P8 is a format that presents the private key in plain text (.p12 is a binary format). You may have seen these before, they look something like this:

```text
-----BEGIN PRIVATE KEY-----
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAA
-----END PRIVATE KEY-----
```

## About

Maintained by: **[Super Basic](https://superbasic.xyz)**
