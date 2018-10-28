module Swagger
  class Boolean
    TRUE_REGEXP = /(y|Y|yes|Yes|YES|true|True|TRUE|on|On|ON)/.freeze
    FALSE_REGEXP = /(n|N|no|No|NO|false|False|FALSE|off|Off|OFF)/.freeze

    def self.coerce(obj)
      val = obj.to_s.downcase
      return true if val.match(TRUE_REGEXP)
      return false if val.match(FALSE_REGEXP)

      raise ArgumentError, "#{obj} cannot be coerced to a boolean"
    end
  end
end
