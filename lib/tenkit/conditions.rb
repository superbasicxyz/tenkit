module Tenkit
  class Conditions
    def initialize(conditions)
      return if conditions.nil?

      conditions.each do |key, val|
        name = key.gsub(/(.)([A-Z])/, '\1_\2').downcase # underscore
        singleton_class.class_eval { attr_accessor name }
        instance_variable_set(:"@#{name}", val.is_a?(Hash) ? Conditions.new(val) : val)
      end
    end
  end
end
