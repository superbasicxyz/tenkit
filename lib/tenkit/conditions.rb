module Tenkit
  class Conditions
    def initialize(conditions)
      return if conditions.nil?

      conditions.each do |key, val|
        singleton_class.class_eval { attr_accessor key.to_underscore }
        instance_variable_set(:"@#{key.to_underscore}", val.is_a?(Hash) ? Conditions.new(val) : val)
      end
    end
  end
end
