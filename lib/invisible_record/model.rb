# frozen_string_literal: true

module InvisibleRecord
  # Add invisible behavior to an ActiveRecord Model
  module Model
    def acts_as_invisible(**options)
      options.deep_symbolize_keys!
      deleted_timestamp_attr = options[:deleted_timestamp_attribute] || "deleted_at"
      raise "Only call acts_as_invisible once per model" if respond_to?(:invisible_record_model?)

      class_eval do
        class << self
          def invisible_record_model?
            true
          end
        end

        attribute_names.each do |attribute|
          define_method attribute do |*_args|
            return attributes[deleted_timestamp_attr] if attribute == deleted_timestamp_attr

            if attributes[deleted_timestamp_attr].present?
              nil
            else
              attributes[attribute]
            end
          end

          define_method "hidden_#{attribute}" do |*_args|
            attributes[attribute]
          end
        end

        define_method "restore" do |*_args|
          assign_timestamp = "#{deleted_timestamp_attr}="
          send(assign_timestamp, nil)
        end

        define_method "restore!" do |*_args|
          restore
          save!
        end
      end
    end
  end
end
