class AddProviderCommand
  def self.option_parser
    OptionParser.new do |opts|
      opts.banner = "add-provider [command options] [command args...]"
      opts.on("--box BOX_NAME", "Name of the box including user")
      opts.on("--version VERSION", "Name of the version")
      opts.on("--name [NAME]", "Name of the provider")
      opts.on("--architecture [ARCHITECTURE]", "Architecture of the provider")
      opts.on("--[no-]default-architecture", TrueClass, "Set as the default architecture")
      opts.on("--checksum [CHECKSUM]", "Checksum of the box file")
      opts.on("--checksum-type [CHECKSUM_TYPE]", "Type of checksum used")
      opts.on("--url [URL]", "URL of where to find the box file")
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
    provider_name = command_options[:name]
    architecture = command_options[:architecture]
    default_architecture = command_options[:"default-architecture"]
    checksum = command_options[:checksum]
    checksum_type = command_options[:"checksum-type"]
    url = command_options[:url]
    box = Box.where(name: box_name).first

    unless box
      raise "Unknown box: #{box_name}"
    end

    version = Version.where(box: box, version: version_name).first

    unless version
      raise "Unknown version (#{version_name}) for box: #{box_name}"
    end

    if Provider.create(version: version,
      name: provider_name,
      architecture: architecture,
      default_architecture: default_architecture,
      checksum: checksum,
      checksum_type: checksum_type,
      url: url)
      puts "Provider added: #{provider_name} for version #{version_name}"
    end
  end

  private

  attr_reader :command_options, :args

  def validate!
    [
      :box,
      :version,
      :name,
      :architecture,
      :"default-architecture",
      :checksum,
      :"checksum-type",
      :url
    ].each do |key|
      raise OptionParser::MissingArgument.new(key) if command_options[key].nil?
    end
  end
end
