# frozen_string_literal: true

require_relative 'tenkit/client'
require_relative 'tenkit/config'

module Tenkit
  class Error < StandardError; end

  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Config.new
    yield config
  end
end
