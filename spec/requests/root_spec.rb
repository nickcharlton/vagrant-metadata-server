require_relative "../spec_helper.rb"

RSpec.describe "/" do
  it "exists" do
    get "/"

    expect(last_response).to be_ok
    expect(last_response.body).to include "Hello world!"
  end
end
