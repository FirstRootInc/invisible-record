# frozen_string_literal: true

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :posts, force: true do |t|
    t.string :title
    t.string :body
    t.integer :likes

    t.timestamps
  end

end
