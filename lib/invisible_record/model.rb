# frozen_string_literal: true

module InvisibleRecord
  # Add invisible behavior to an ActiveRecord Model
  module Model
    def acts_as_invisible(**_options)
      raise "Only call acts_as_invisible once per model" if respond_to?(:invisible_record_model?)

      class_eval do
        class << self
          def invisible_record_model?
            true
          end
        end

        attribute_names.each do |attribute|
          define_method attribute do |*_args|
            return attributes["deleted_at"] if attribute == "deleted_at"

            if attributes["deleted_at"].present?
              nil
            else
              attributes[attribute]
            end
          end

          next if respond_to? attribute

          define_method "hidden_#{attribute}" do |*_args|
            attributes[attribute]
          end
        end

        def restore
          self.deleted_at = nil
        end

        def restore!
          restore
          save!
        end
      end
    end
  end
end
