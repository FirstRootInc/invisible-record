# frozen_string_literal: true

RSpec.describe InvisibleRecord do
  it "has a version number" do
    expect(InvisibleRecord::VERSION).not_to be nil
  end

  xit "does something useful" do
    expect(false).to eq(true)
  end
end
