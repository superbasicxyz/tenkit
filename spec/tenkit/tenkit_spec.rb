require 'tenkit'
require 'dotenv'
Dotenv.load

RSpec.describe Tenkit do
  describe '#get_weather' do
    it 'returns the weather' do
      tenkit_config = {
        team_id: ENV['TID'],
        service_id: ENV['SID'],
        key_id: ENV['KID'],
        key: ENV['AUTH_KEY']
      }
      client = Tenkit::Client.new(tenkit_config)
      expect(client.get_weather).to eq('it is not good')
    end
  end
end
