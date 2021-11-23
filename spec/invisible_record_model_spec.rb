# frozen_string_literal: true

require "spec_helper"

RSpec.describe InvisibleRecord::Model do
  it "injects methods to the activerecord class" do
    expect(Post).to respond_to(:invisible_record_model?)
  end

  it "hides attributes when setting deleted_at attribute" do
    post = Post.new(title: "Hello", body: "World")
    expect(post.title).to eq("Hello")
    expect(post.body).to eq("World")
    deleted_datetime = DateTime.now
    post.deleted_at = deleted_datetime
    expect(post.deleted_at).to eq(deleted_datetime)
    expect(post).to respond_to(:restore)
    expect(post).to respond_to(:hidden_title)
    expect(post.hidden_title).to eq("Hello")
    expect(post.hidden_body).to eq("World")
    expect(post.title).to be_nil
    expect(post.body).to be_nil
  end

  it "hides attributes when using another deleted timestamp attribute column" do
    folder = Folder.new(name: "MyFolder")
    expect(folder.name).to eq("MyFolder")
    archived_datetime = DateTime.now
    folder.archived_at = archived_datetime
    expect(folder).to respond_to(:restore)
    expect(folder).to respond_to(:hidden_name)
    expect(folder.hidden_name).to eq("MyFolder")
    expect(folder.name).to be_nil
  end

  it "doesn't hide deleted_at nor id of the deleted record" do
    post = Post.create!(title: "Hello")
    post.soft_delete!
    expect(post.title).to be_nil
    expect(post.id).to_not be_nil
    expect(post.deleted_at).to_not be_nil
    post.destroy!
  end
end
