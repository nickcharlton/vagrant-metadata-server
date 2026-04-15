require_relative "../../spec_helper"

require_relative "../../../lib/cli"

RSpec.describe AddBoxCommand do
  context "with the correct options" do
    it "creates a box" do
      allow($stdout).to receive(:puts)

      command = described_class.new(
        command_options:  {name: "ubuntu/noble64"},
        args: []
      )
      command.execute

      box = Box.where(name: "ubuntu/noble64")
      expect(box.first).not_to be_nil
    end
  end

  context "when missing options" do
    it "throws an exception when missing :name" do
      command = described_class.new(
        command_options:  {},
        args: []
      )

      expect do
        command.execute
      end.to raise_error(OptionParser::MissingArgument)
    end
  end
end
