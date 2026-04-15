require "sinatra"
require "sinatra/json"

require_relative "database"

get "/api/v2/vagrant/:user/:box" do
  name = "#{params[:user]}/#{params[:box]}"
  box = Box.where(name: name).first

  unless box
    halt 404, "Box not found"
  end

  json box.to_h
end
