require_relative '../../lib/tenkit'

require 'webmock/rspec'
require 'dotenv'
Dotenv.load

# REMOVE ONCE PROPER PKEY SET IN BUILD ENVIRONMENT
ENV['AUTH_KEY'] = <<~PKEY
  -----BEGIN PRIVATE KEY-----
  MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgvDhFoOhIgO3j/1KT
  D/tGcxdMK9ILbIPv63GO4IlkrMagCgYIKoZIzj0DAQehRANCAAQGjZk+nabnYj16
  7wADUWYq4xFQ4tAKfNmjPTHQm0YGV/eUhfEsVgtV0N8jR3baRuHMFlEbAyyiN46G
  efTzbRg+
  -----END PRIVATE KEY-----
  PKEY

Tenkit.configure do |c|
  c.team_id = ENV.fetch('TID')
  c.service_id = ENV.fetch('SID')
  c.key_id = ENV.fetch('KID')
  c.key = ENV.fetch('AUTH_KEY')
end

