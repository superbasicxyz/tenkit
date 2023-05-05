# frozen_string_literal: true

require_relative 'tenkit/client'
require_relative 'tenkit/config'
require_relative 'tenkit/version'
require_relative 'tenkit/weather'
require_relative 'tenkit/tenkit_error'

module Tenkit
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Config.new
    yield config
  end
end
