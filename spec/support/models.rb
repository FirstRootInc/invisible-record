# frozen_string_literal: true

class Post < ActiveRecord::Base
  acts_as_invisible
end

class Folder < ActiveRecord::Base
  acts_as_invisible deleted_timestamp_attribute: "archived_at"
end
