require_relative "../spec_helper"

RSpec.describe "GET /api/v2/vagrant/:user/:box" do
  context "with a known box" do
    it "responds with box metadata" do
      box = Box.create(name: "debian/trixie64")
      version = Version.create(box: box, version: "13.20260121.1", status: "active")
      _provider = Provider.create(
        version: version,
        name: "libvirt",
        architecture: "amd64",
        default_architecture: true,
        checksum: "ce31963b5ebd206a9a7f1a65e82647d581b1f1345f33bde233b01fb338b05781",
        checksum_type: "sha256",
        url: "https://vagrantcloud.com/debian/boxes/trixie64/versions/13.20260121.1/providers/libvirt/amd64/vagrant.box"
      )

      get "/api/v2/vagrant/debian/trixie64"

      expect(last_response.content_type).to eq("application/json")
      body = JSON.parse(last_response.body)
      expect(body).to include(
        "name" => "debian/trixie64",
        "versions" => include(a_hash_including(
          "version" => "13.20260121.1",
          "status" => "active",
          "providers" => include(a_hash_including(
            "name" => "libvirt",
            "architecture" => "amd64",
            "default_architecture" => true,
            "checksum" => "ce31963b5ebd206a9a7f1a65e82647d581b1f1345f33bde233b01fb338b05781",
            "checksum_type" => "sha256",
            "url" => "https://vagrantcloud.com/debian/boxes/trixie64/versions/13.20260121.1/providers/libvirt/amd64/vagrant.box"
          ))
        ))
      )
    end
  end

  context "with an unknown box" do
    it "responds with a 404" do
      get "/api/v2/vagrant/debian/unknown64"

      expect(last_response).to be_not_found
    end
  end
end
