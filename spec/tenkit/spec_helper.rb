require_relative '../../lib/tenkit'

require 'webmock/rspec'
require 'dotenv'
Dotenv.load

Tenkit.configure do |c|
  c.team_id = ENV.fetch("TID")
  c.service_id = ENV.fetch("SID")
  c.key_id = ENV.fetch("KID")
  c.key = ENV.fetch("AUTH_KEY")
end
