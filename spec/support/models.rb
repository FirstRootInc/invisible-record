# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Post < ApplicationRecord
  acts_as_invisible
end

class Folder < ApplicationRecord
  acts_as_invisible deleted_timestamp_attribute: "archived_at"
end
