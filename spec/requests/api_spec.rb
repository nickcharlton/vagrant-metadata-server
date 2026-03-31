require_relative "../spec_helper"

RSpec.describe "GET /api/v2/vagrant/:user/:box" do
  it "returns box metadata" do
    get "/api/v2/vagrant/debian/trixie64"

    expect(last_response.content_type).to eq("application/json")
    body = JSON.parse(last_response.body)
    expect(body["name"]).to eq("debian/trixie64")
  end
end
