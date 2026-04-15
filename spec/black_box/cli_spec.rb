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

  def session
    JetBlack::Session.new
  end
end
