class AddBoxCommand
  def self.option_parser
    OptionParser.new do |opts|
      opts.banner = "add-box [command options] [command args...]"
      opts.on("--name NAME", "Name of the box including user")
    end
  end

  def initialize(command_options:, args:)
    @command_options = command_options
    @args = args
  end

  def execute
    validate!

    name = command_options[:name]
    if Box.create(name: name)
      puts "Box added: #{name}"
    end
  end

  private

  attr_reader :command_options, :args

  def validate!
    raise OptionParser::MissingArgument if command_options[:name].nil?
  end
end
