require 'fast_underscore'

module Tenkit
  class Conditions
    def initialize(conditions)
      return if conditions.nil?

      conditions.each do |key, val|
        singleton_class.class_eval { attr_accessor key.underscore }
        instance_variable_set(:"@#{key.underscore}", val.is_a?(Hash) ? Conditions.new(val) : val)
      end
    end
  end
end
