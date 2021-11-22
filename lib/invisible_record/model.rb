# frozen_string_literal: true

require "invisible_record/helper"

module InvisibleRecord
  # Add invisible behavior to an ActiveRecord Model
  module Model
    def acts_as_invisible(**options)
      options.deep_symbolize_keys!
      @_deleted_timestamp_attr = options[:deleted_timestamp_attribute] || "deleted_at"
      raise "Only call acts_as_invisible once per model" if respond_to?(:invisible_record_model?)

      class_eval do
        class << self
          def invisible_record_model?
            true
          end

          def without_deleted
            where(@_deleted_timestamp_attr => nil)
          end
        end

        Helper.define_hidden_attributes self, deleted_ts_attr: @_deleted_timestamp_attr

        Helper.define_actions self, deleted_ts_attr: @_deleted_timestamp_attr
      end
    end
  end
end
