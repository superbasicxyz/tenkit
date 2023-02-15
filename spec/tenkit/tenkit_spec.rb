require 'tenkit'

RSpec.describe Tenkit do
  describe '#get_weather' do
    it 'returns the weather' do
      client = Tenkit::Client.new
      expect(client.get_weather).to eq('it is not good')
    end
  end
end
