# frozen_string_literal: true

require "spec_helper"

RSpec.describe InvisibleRecord::Model do
  it "injects methods to the activerecord class" do
    expect(Post).to respond_to(:invisible_record_model?)
  end
end
