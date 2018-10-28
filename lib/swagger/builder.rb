module Swagger
  # A Bash is a 'builder' Hash that can be used to be a
  # Dash ('defined' or 'discrete' Hash). It provides a
  # build method that turns it into a Dash. It enforces
  # the same rules as a Dash except for 'required' properties,
  # which are not enforced until converting to a Dash via `build`.
  module Bash
    # @api private
    module ClassMethods
      def self.extend_object(dash)
        raise TypeError, 'Bash only works on Dash' unless dash <= Hashie::Dash

        dash.instance_variable_get('@required_properties').clear
        dash.coerce_value Hashie::Dash, Swagger::Bash, strict: false
      end

      def required?(_name)
        false
      end
    end

    # @api private
    def self.included(dash) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      raise TypeError, 'Bash only works on Dash' unless dash <= Hashie::Dash

      dash.extend ClassMethods
      dash.instance_variable_get('@required_properties').clear

      # Very hacky... copy instance_variables for coercions
      base_dash = dash.superclass
      %i[@properties @defaults].each do |property|
        dash.instance_variable_set(property, base_dash.instance_variable_get(property))
      end

      %i[@key_coercions @value_coercions].each do |property|
        coercions = base_dash.instance_variable_get(property)
        if coercions
          coercions.each_pair do |key, into|
            infect_class coercions, key, into
          end
        end
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
        into.each_pair do |sub_key, sub_into|
          coercions[key][sub_key] = infect sub_into
        end
      elsif into.is_a? Array
        coercions[key] = into.map do |sub_into|
          infect sub_into
        end
      else
        coercions[key] = infect into
      end
    end

    def self.infect(klass)
      return klass unless klass <= Hashie::Dash

      unless klass.const_defined? 'Bash'
        klass.const_set('Bash',
                        Class.new(klass).tap do |bash_klass|
                          # include is public in Ruby 2.1+, hack to support older
                          bash_klass.send(:include, Bash)
                        end)
      end

      klass.const_get('Bash')
    end
  end

  # An object for building a Swagger document. Coerces and validates data types
  # as create the document, but does not enforce required fields until you call
  # #{Bash#build}.
  module Builder
    def self.builder(opts = {})
      version = opts[:version] || '2.0'
      target_class = target_api_class(version)
      klass = Swagger::Bash.infect(target_class)
      klass.new({})
    end

    private

    def self.target_api_class(version)
      major, _minor = version.to_s.split('.')
      case major
      when '2'
        Swagger::V2::API
      else
        raise ArgumentError, "Swagger version #{version} is not currently supported"
      end
    end
  end
end
