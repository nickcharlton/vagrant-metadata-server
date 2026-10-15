require_relative "../spec_helper"

RSpec.describe "CLI" do
  describe "help" do
    it "has help text covering commands" do
      result = session.run("cli")

      expect(result).to have_stdout(/cli \[global options\]/)
        .and have_stdout(/add-box/)
    end
  end

  describe "add-box" do
    it "adds a box to database" do
      result = session.run("cli add-box --name ubuntu/noble")

      expect(result).to be_a_success.and have_stdout(/Box added/)
    end

    it "has help text" do
      result = session.run("cli add-box --help")

      expect(result).to have_stdout(/add-box \[command options\] \[command args...\]/)
    end
  end

  describe "add-version" do
    it "adds a version to a box" do
      session.run("cli add-box --name ubuntu/noble")
      result = session.run("cli add-version --box ubuntu/noble --version 20260415.0.0")

      expect(result).to be_a_success.and have_stdout(/Version added/)
    end

    it "has help text" do
      result = session.run("cli add-version --help")

      expect(result).to have_stdout(/add-version \[command options\] \[command args...\]/)
    end
  end

  def session
    @session ||= JetBlack::Session.new
  end
end
