require_relative '../../../lib/tenkit'

RSpec.describe Tenkit::Config do
  describe '#validate!' do
    it 'raises a Tenkit::TenkitError exception if missing required config vals' do
      config = Tenkit::Config.new
      expect { config.validate! }.to raise_error Tenkit::TenkitError
      config.team_id = '123'
      expect { config.validate! }.to raise_error Tenkit::TenkitError
      config.service_id = 'abc'
      expect { config.validate! }.to raise_error Tenkit::TenkitError
      config.key_id = 'hij'
      expect { config.validate! }.to raise_error Tenkit::TenkitError
      config.key = '====PRIVATE KEY===='
      expect { config.validate! }.not_to raise_error
    end
  end
end
