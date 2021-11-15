# frozen_string_literal: true

require "active_support"
require "invisible_record/model"

ActiveSupport.on_load(:active_record) do
  extend InvisibleRecord::Model
end
