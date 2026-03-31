require "sinatra"

get "/api/v2/vagrant/:user/:box" do
  content_type "application/json"

  {
    name: "debian/trixie64",
    description: "Debian 13 \"trixie\"",
    short_description: "",
    versions: [
      {
        version: "13.20260121.1",
        status: "active",
        description_html: "",
        description_markdown: "",
        providers: [
          {
            name: "libvirt",
            architecture: "amd64",
            default_architecture: true,
            checksum: "ce31963b5ebd206a9a7f1a65e82647d581b1f1345f33bde233b01fb338b05781",
            checksum_type: "sha256",
            url: "https://vagrantcloud.com/debian/boxes/trixie64/versions/13.20260121.1/providers/libvirt/amd64/vagrant.box"
          }
        ]
      }
    ]
  }.to_json
end
