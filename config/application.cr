require "amber"

require "../src/controllers/*"
require "../src/channels/*"
require "../src/sockets/*"

Amber::Server.configure do |settings|
  settings.port = ENV["PORT"].to_i if ENV["PORT"]?
end
