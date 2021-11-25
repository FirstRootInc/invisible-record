# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Scopes for Invisible Record" do
  it "should include or exclude deleted records in the collection" do
    Post.create!(title: "Hello", body: "World")
    existing_post = Post.create!(title: "Existing")
    deleted_post = Post.create!(title: "Deleted", deleted_at: DateTime.now)

    # Post.all should list only non-deleted records
    expect(Post.all.count).to eq(2)
    expect(Post.all).to include(existing_post)
    expect(Post.all).to_not include(deleted_post)

    # Post.include_deleted should list all records
    expect(Post.include_deleted.count).to eq(3)
    expect(Post.include_deleted).to include(existing_post)
    expect(Post.include_deleted).to include(deleted_post)

    # Post.deleted should list only deleted records
    expect(Post.deleted.count).to eq(1)
    expect(Post.deleted).to_not include(existing_post)
    expect(Post.deleted).to include(deleted_post)

    Post.destroy_all
  end

  it "should behave correctly if the deleted_timestamp_attribute is different to the default" do
    Folder.create!(name: "Hello")
    existing_folder = Folder.create!(name: "Existing")
    deleted_folder = Folder.create!(name: "Deleted", archived_at: DateTime.now)

    # Folder.all should list only non-deleted records
    expect(Folder.all.count).to eq(2)
    expect(Folder.all).to include(existing_folder)
    expect(Folder.all).to_not include(deleted_folder)

    # Folder.include_deleted should list all records
    expect(Folder.include_deleted.count).to eq(3)
    expect(Folder.include_deleted).to include(existing_folder)
    expect(Folder.include_deleted).to include(deleted_folder)

    # Folder.deleted should list only deleted records
    expect(Folder.deleted.count).to eq(1)
    expect(Folder.deleted).to_not include(existing_folder)
    expect(Folder.deleted).to include(deleted_folder)

    Folder.destroy_all
  end
end
