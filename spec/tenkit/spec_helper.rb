require_relative "../../lib/tenkit"

require "webmock/rspec"
require "dotenv"
Dotenv.load

Tenkit.configure do |c|
  c.team_id = ENV.fetch("TID", "A1A1A1A1A1")
  c.service_id = ENV.fetch("SID", "com.mydomain.myapp")
  c.key_id = ENV.fetch("KID", "B2B2B2B2B2")
  c.key = ENV.fetch("AUTH_KEY", '-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----')
end
