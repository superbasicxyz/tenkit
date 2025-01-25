module Tenkit
  class Utils
    def self.snake(str)
      return str.underscore if str.respond_to? :underscore

      str.gsub(/(.)([A-Z])/, '\1_\2').sub(/_UR_L$/, "_URL").downcase
    end
  end
end
