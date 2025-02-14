module Tenkit
  class Utils
    def self.snake(str)
      return str.underscore if str.respond_to? :underscore

      str.gsub(/(.)([A-Z])/, '\1_\2').sub(/_UR_L$/, "_URL").downcase
    end

    def self.camel(str)
      return str.camelize(:lower) if str.respond_to? :camelize

      str.gsub(/_(.)/) {|e| $1.upcase}
    end
  end
end
