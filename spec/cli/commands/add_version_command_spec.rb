require_relative "../../spec_helper"

require_relative "../../../lib/cli"

RSpec.describe AddVersionCommand do
  context "with the correct options" do
    it "creates a version on a box" do
      allow($stdout).to receive(:puts)
      box = Box.create(name: "ubuntu/noble64")

      command = described_class.new(
        command_options: {
          box: "ubuntu/noble64",
          version: "20260415.0.0"
        },
        args: []
      )
      command.execute

      version = box.versions.first

      expect(version).not_to be_nil
    end

    it "throws an exception with an unknown box" do
      command = described_class.new(
        command_options: {
          box: "ubuntu/unknown64",
          version: "20260415.0.0"
        },
        args: []
      )

      expect do
        command.execute
      end.to raise_error(RuntimeError, /Unknown box/)
    end
  end

  context "when missing options" do
    it "throws an exception when missing box" do
      command = described_class.new(
        command_options: {},
        args: []
      )

      expect do
        command.execute
      end.to raise_error(OptionParser::MissingArgument)
    end

    it "throws an exception when missing version" do
      command = described_class.new(
        command_options: {box: "ubuntu/noble64"},
        args: []
      )

      expect do
        command.execute
      end.to raise_error(OptionParser::MissingArgument)
    end
  end
end
