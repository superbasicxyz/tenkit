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

  def self.gem_version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 0
    MINOR = 0
    TINY = 2
    PRE = nil

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
  end
end
