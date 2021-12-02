# frozen_string_literal: true

module InvisibleRecord
  # Define scopes for the invisible record
  module Scopes
    def self.included(base)
      base.extend ClassMethods
    end

    # Define methods for Scopes
    module ClassMethods
      protected

      def define_default_scopes(deleted_ts_attr:)
        default_scope { where(deleted_ts_attr => nil) }
        scope :include_deleted, -> { unscope(where: deleted_ts_attr.to_sym) }
        scope :deleted, -> { unscope(where: deleted_ts_attr.to_sym).where.not(deleted_ts_attr => nil) }
      end
    end
  end
end
