# frozen_string_literal: true

require "spec_helper"

RSpec.describe InvisibleRecord do
  it "has a version number" do
    expect(InvisibleRecord::VERSION).not_to be nil
  end
end
