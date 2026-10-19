require_relative "../../spec_helper"

require_relative "../../../lib/cli"

RSpec.describe AddProviderCommand do
  context "with the correct options" do
    it "creates a version on a box" do
      allow($stdout).to receive(:puts)
      box = Box.create(name: "debian/trixie64")
      version = Version.create(box: box, version: "13.20260121.1")

      command = described_class.new(
        command_options: {
          box: box.name,
          version: version.version,
          name: "libvirt",
          architecture: "amd64",
          "default-architecture": true,
          checksum: "abc123",
          "checksum-type": "not_a_checksum",
          url: "https://example.com/vms-example-box/vagrant.box"
        },
        args: []
      )
      command.execute

      version = box.versions.first
      provider = version.providers.first

      expect(provider).not_to be_nil
    end

    it "throws an exception with an unknown box" do
      command = described_class.new(
        command_options: {
          box: "ubuntu/unknown64",
          version: "20260415.0.0",
          name: "libvirt",
          architecture: "amd64",
          "default-architecture": true,
          checksum: "abc123",
          "checksum-type": "not_a_checksum",
          url: "https://example.com/vms-example-box/vagrant.box"
        },
        args: []
      )

      expect do
        command.execute
      end.to raise_error(RuntimeError, /Unknown box/)
    end

    it "throws an exception with an unknown version" do
      Box.create(name: "debian/trixie64")

      command = described_class.new(
        command_options: {
          box: "debian/trixie64",
          version: "20260415.0.0",
          name: "libvirt",
          architecture: "amd64",
          "default-architecture": true,
          checksum: "abc123",
          "checksum-type": "not_a_checksum",
          url: "https://example.com/vms-example-box/vagrant.box"

        },
        args: []
      )

      expect do
        command.execute
      end.to raise_error(RuntimeError, /Unknown version/)
    end
  end

  context "when missing options" do
    it "throws an exception when missing box" do
      command = described_class.new(
        command_options: {
          version: "13.20260121.1",
          name: "libvirt",
          architecture: "amd64",
          "default-architecture": true,
          checksum: "abc123",
          "checksum-type": "not_a_checksum",
          url: "https://example.com/vms-example-box/vagrant.box"
        },
        args: []
      )

      expect do
        command.execute
      end.to raise_error(OptionParser::MissingArgument, /box/)
    end

    it "throws an exception when missing version" do
      command = described_class.new(
        command_options: {
          box: "debian/trixie64",
          name: "libvirt",
          architecture: "amd64",
          "default-architecture": true,
          checksum: "abc123",
          "checksum-type": "not_a_checksum",
          url: "https://example.com/vms-example-box/vagrant.box"
        },
        args: []
      )

      expect do
        command.execute
      end.to raise_error(OptionParser::MissingArgument, /version/)
    end

    it "throws an exception when missing name" do
      command = described_class.new(
        command_options: {
          box: "debian/trixie64",
          version: "13.20260121.1",
          architecture: "amd64",
          "default-architecture": true,
          checksum: "abc123",
          "checksum-type": "not_a_checksum",
          url: "https://example.com/vms-example-box/vagrant.box"
        },
        args: []
      )

      expect do
        command.execute
      end.to raise_error(OptionParser::MissingArgument, /name/)
    end

    it "throws an exception when missing architecture" do
      command = described_class.new(
        command_options: {
          box: "debian/trixie64",
          version: "13.20260121.1",
          name: "libvirt",
          "default-architecture": true,
          checksum: "abc123",
          "checksum-type": "not_a_checksum",
          url: "https://example.com/vms-example-box/vagrant.box"
        },
        args: []
      )

      expect do
        command.execute
      end.to raise_error(OptionParser::MissingArgument, /architecture/)
    end

    it "throws an exception when missing default-architecture" do
      command = described_class.new(
        command_options: {
          box: "debian/trixie64",
          version: "13.20260121.1",
          name: "libvirt",
          architecture: "amd64",
          checksum: "abc123",
          "checksum-type": "not_a_checksum",
          url: "https://example.com/vms-example-box/vagrant.box"
        },
        args: []
      )

      expect do
        command.execute
      end.to raise_error(OptionParser::MissingArgument, /default-architecture/)
    end

    it "throws an exception when missing checksum" do
      command = described_class.new(
        command_options: {
          box: "debian/trixie64",
          version: "13.20260121.1",
          name: "libvirt",
          architecture: "amd64",
          "default-architecture": true,
          "checksum-type": "not_a_checksum",
          url: "https://example.com/vms-example-box/vagrant.box"
        },
        args: []
      )

      expect do
        command.execute
      end.to raise_error(OptionParser::MissingArgument, /checksum/)
    end

    it "throws an exception when missing checksum type" do
      command = described_class.new(
        command_options: {
          box: "debian/trixie64",
          version: "13.20260121.1",
          name: "libvirt",
          architecture: "amd64",
          "default-architecture": true,
          checksum: "abc123",
          url: "https://example.com/vms-example-box/vagrant.box"
        },
        args: []
      )

      expect do
        command.execute
      end.to raise_error(OptionParser::MissingArgument, /checksum-type/)
    end

    it "throws an exception when missing url" do
      command = described_class.new(
        command_options: {
          box: "debian/trixie64",
          version: "13.20260121.1",
          name: "libvirt",
          architecture: "amd64",
          "default-architecture": true,
          checksum: "abc123",
          "checksum-type": "not_a_checksum"
        },
        args: []
      )

      expect do
        command.execute
      end.to raise_error(OptionParser::MissingArgument, /url/)
    end
  end
end
