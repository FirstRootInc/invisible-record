# frozen_string_literal: true

require "active_support"

ActiveSupport.on_load(:active_record) do
  extend InvisibleRecord::Model
end
