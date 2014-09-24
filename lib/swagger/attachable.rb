module Swagger
  module Attachable
    # @api private
    def attach_parent(parent)
      @parent = parent
      attach_to_children
    end

    # @api private
    def attach_to_children # rubocop:disable Metrics/MethodLength
      each_value do |v|
        if v.respond_to? :attach_parent
          v.attach_parent self
        elsif v.respond_to? :each_value
          v.each_value do |sv|
            sv.attach_parent self if sv.respond_to? :attach_parent
          end
        elsif v.respond_to? :each
          v.each do |sv|
            sv.attach_parent self if sv.respond_to? :attach_parent
          end
        end
      end
    end

    def root
      return self if parent.nil?
      parent.root
    end
  end
end
