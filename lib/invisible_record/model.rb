# frozen_string_literal: true

require_relative "helper"

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

        Helper.define_attribute_methods attribute_names

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
