ENV["APP_ENV"] = "test"

require "rack/test"
require "rspec"
require "jet_black"
require "jet_black/rspec"

require File.expand_path "../../app.rb", __FILE__

module RSpecMixin
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end

RSpec.configure { |c| c.include RSpecMixin }

JetBlack.configure do |config|
  config.path_prefix = File.expand_path("../bin", __dir__)
end

RSpec.configure do |config|
  config.after(:each) do
    DB.tables.reverse_each { |table_name| DB.from(table_name).delete }
  end
end
