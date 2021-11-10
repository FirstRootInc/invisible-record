# frozen_string_literal: true

module InvisibleRecord
  # Helper methods for specific usage
  module Helper
    def self.define_attribute_methods(attribute_names)
      attribute_names.each do |attribute|
        redefine_nil_method_for attribute

        next if respond_to? attribute

        redefine_hidden_method_for attribute
      end
    end

    def self.redefine_nil_method_for(attribute)
      define_method attribute do |*_args|
        return attributes["deleted_at"] if attribute == "deleted_at"

        if attributes["deleted_at"].present?
          nil
        else
          attributes[attribute]
        end
      end
    end

    def self.redefine_hidden_method_for(attribute)
      define_method "hidden_#{attribute}" do |*_args|
        attributes[attribute]
      end
    end
  end
end
