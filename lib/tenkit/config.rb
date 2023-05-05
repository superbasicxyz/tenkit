# frozen_string_literal: true

module Tenkit
  class Config
    attr_accessor :team_id, :service_id, :key_id, :key

    REQUIRED_ATTRIBUTES = [
      :@team_id,
      :@service_id,
      :@key_id,
      :@key
    ]

    def validate!
      missing_required = REQUIRED_ATTRIBUTES.filter { |required| instance_variable_get(required).nil? }
      if missing_required.length > 0
        raise TenkitError, "#{missing_required.join(', ')} cannot be blank. check that you have configured your credentials"
      end
    end
  end
end
