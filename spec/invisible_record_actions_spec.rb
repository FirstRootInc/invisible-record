# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Actions for Invisible Record" do
  it "can restore a hidden record that was soft-deleted" do
    post = Post.new(title: "Hello", body: "World")
    deleted_datetime = DateTime.now
    post.soft_delete(datetime: deleted_datetime)
    expect(post.deleted_at).to eq(deleted_datetime)
    expect(post).to respond_to(:restore)
    expect(post.title).to be_nil
    expect(post.body).to be_nil
    post.restore
    expect(post.title).to eq("Hello")
    expect(post.body).to eq("World")
    expect(post.deleted_at).to be_nil
  end

  it "can soft delete records without specifying a datetime" do
    post = Post.new(title: "Hello", body: "World")
    post.soft_delete
    expect(post.deleted_at).to_not be_nil
    expect(post.title).to be_nil
    expect(post.body).to be_nil
  end

  it "can soft_delete! and restore!" do
    post = Post.new(title: "Hello")
    datetime = DateTime.now - 1.day
    post.soft_delete!(datetime: datetime)
    expect(post.deleted_at).to eq(datetime)
    expect(post.title).to be_nil
    post.restore!
    expect(post.deleted_at).to be_nil
    expect(post.title).to eq("Hello")
    expect(post).to be_persisted
  end
end
