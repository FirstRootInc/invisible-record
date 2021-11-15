# frozen_string_literal: true

require "invisible_record"
require "active_record"

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

load "#{File.dirname(__FILE__)}/support/schema.rb"
require "#{File.dirname(__FILE__)}/support/models.rb"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
