module Swagger
  # A Bash is a 'builder' Hash that can be used to be a
  # Dash ('defined' or 'discrete' Hash). It provides a
  # build method that turns it into a Dash. It enforces
  # the same rules as a Dash except for 'required' properties,
  # which are not enforced until converting to a Dash via `build`.
  module Bash
    module ClassMethods
      def self.extend_object(dash)
        fail TypeError, 'Bash only works on Dash' unless dash <= Hashie::Dash
        dash.instance_variable_get('@required_properties').clear
        dash.coerce_value Hashie::Dash, Swagger::Bash, strict: false
      end

      def required?(_name)
        false
      end
    end

    def self.included(dash) # rubocop:disable Metrics/MethodLength
      fail TypeError, 'Bash only works on Dash' unless dash <= Hashie::Dash
      dash.extend ClassMethods
      dash.instance_variable_get('@required_properties').clear

      # Very hacky... copy instance_variables for coercions
      base_dash = dash.superclass
      [:@properties, :@defaults].each do | property |
        dash.instance_variable_set(property, base_dash.instance_variable_get(property))
      end

      [:@key_coercions, :@value_coercions].each do | property |
        coercions = base_dash.instance_variable_get(property)
        coercions.each_pair do | key, into |
          infect_class coercions, key, into
        end if coercions
        dash.instance_variable_set(property, coercions)
      end

      def [](key, &_block)
        super(key) do |v|
          if block_given?
            v ||= send(:[]=, key, {})
            yield v
            v
          end
        end
      end
    end

    def build
      self.class.superclass.new(to_hash)
    end

    private

    def self.infect_class(coercions, key, into)
      if into.is_a? Hash
        into.each_pair do | sub_key, sub_into |
          coercions[key][sub_key] = infect sub_into
        end
      elsif into.is_a? Array
        coercions[key] = into.map do | sub_into |
          infect sub_into
        end
      else
        coercions[key] = infect into
      end
    end

    def self.infect(klass)
      return klass unless klass <= Hashie::Dash

      klass.const_set('Bash',
                      Class.new(klass).tap do | bash_klass |
                        bash_klass.include Bash
                      end
      ) unless klass.const_defined? 'Bash'

      klass.const_get('Bash')
    end
  end

  class Builder < Swagger::V2::APIDeclaration
    include Swagger::Bash
  end
end
