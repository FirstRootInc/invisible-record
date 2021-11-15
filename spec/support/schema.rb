# frozen_string_literal: true

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :posts, force: true do |t|
    t.string :title
    t.string :body
    t.integer :likes
    t.datetime :deleted_at

    t.timestamps
  end

  create_table :folders, force: true do |t|
    t.string :name
    t.datetime :archived_at

    t.timestamps
  end
end
