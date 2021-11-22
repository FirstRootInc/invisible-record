# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Scopes for Invisible Record" do
  it "should omit deleted records if the without_deleted scope is used" do
    Post.create!(title: "Hello", body: "World")
    existing_post = Post.create!(title: "Existing")
    deleted_post = Post.create!(title: "Deleted", deleted_at: DateTime.now)

    expect(Post.all.count).to eq(3)
    expect(Post.without_deleted.count).to eq(2)
    expect(Post.without_deleted).to_not include(deleted_post)
    expect(Post.without_deleted).to include(existing_post)
  end

  it "should omit deleted records if the deleted attribute name is different" do
    Folder.create!(name: "Hello")
    existing_folder = Folder.create!(name: "Existing")
    deleted_folder = Folder.create!(name: "Deleted", archived_at: DateTime.now)

    expect(Folder.all.count).to eq(3)
    expect(Folder.without_deleted.count).to eq(2)
    expect(Folder.without_deleted).to_not include(deleted_folder)
    expect(Folder.without_deleted).to include(existing_folder)
  end
end
