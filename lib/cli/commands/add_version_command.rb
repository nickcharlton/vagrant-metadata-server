class AddVersionCommand
  def self.option_parser
    OptionParser.new do |opts|
      opts.banner = "add-version [command options] [command args...]"
      opts.on("--box BOX_NAME", "Name of the box including user")
      opts.on("--version VERSION", "Value for the version")
      opts.on("--status [STATUS]", "Status of the box, defaults to active")
      opts.on("--description [DESCRIPTION]", "Box description. Supports Markdown. Defaults to blank")
    end
  end

  def initialize(command_options:, args:)
    @command_options = command_options
    @args = args
  end

  def execute
    validate!

    box_name = command_options[:box]
    version_name = command_options[:version]
    status = command_options.fetch(:status, "active")
    description = command_options[:description]
    box = Box.where(name: box_name).first

    unless box
      raise "Unknown box: #{box_name}"
    end

    if Version.create(box: box,
      version: version_name,
      status: status,
      description_markdown: description)
      puts "Version added: #{version_name}"
    end
  end

  private

  attr_reader :command_options, :args

  def validate!
    [:box, :version].each do |key|
      raise OptionParser::MissingArgument if command_options[key].nil?
    end
  end
end
