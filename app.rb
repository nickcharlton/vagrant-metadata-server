require "sequel"
require "sinatra"
require "sinatra/json"

DB = if ENV["APP_ENV"] == "test"
       Sequel.sqlite
     else
       Sequel.connect("sqlite://metadata.db")
     end

DB.create_table? :boxes do
  primary_key :id
  String :name
  String :description
  String :short_description
end

DB.create_table? :versions do
  primary_key :id
  foreign_key :box_id, :boxes
  String :version
  String :status
  String :description_html
  String :description_markdown
end

DB.create_table? :providers do
  primary_key :id
  foreign_key :version_id, :versions
  String :name
  String :architecture
  TrueClass :default_architecture
  String :checksum
  String :checksum_type
  String :url
end

class Box < Sequel::Model
  one_to_many :versions

  def to_h
    {
      name: name,
      description: description,
      short_description: short_description,
      versions: versions.map(&:to_h)
    }
  end
end

class Version < Sequel::Model
  many_to_one :box
  one_to_many :providers

  def to_h
    {
      version: version,
      status: status,
      description_html: description_html,
      description_markdown: description_markdown,
      providers: providers.map(&:to_h)
    }
  end
end

class Provider < Sequel::Model
  many_to_one :version

  def to_h
    {
      name: name,
      architecture: architecture,
      default_architecture: default_architecture,
      checksum: checksum,
      checksum_type: checksum_type,
      url: url
    }
  end
end

get "/api/v2/vagrant/:user/:box" do
  name = "#{params[:user]}/#{params[:box]}"
  box = Box.where(name: name).first

  unless box
    halt 404, "Box not found"
  end

  json box.to_h
end
