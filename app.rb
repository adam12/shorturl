#!/opt/ruby/bin/ruby

ENV["HOME"] ||= `echo ~`.strip
ENV["RUBYGEMS_GEMDEPS"] ||= "-"

require "pstore"
require "securerandom"
require "rubygems"
require "rack"

store = PStore.new("db")

app = Proc.new do |env|
  req = Rack::Request.new(env)

  if req.get?
    short_code = req.path.split("/").last
    url = store.transaction(_read_only=true) { store[short_code] }

    if url
      [301, {"Location" => url}, []]
    else
      [404, {}, ["Not found"]]
    end
  else
    short_code = SecureRandom.urlsafe_base64[0..2]
    url = req.params["url"]

    store.transaction { store[short_code] = url }

    [201, {}, [req.url + short_code]]
  end
end

Rack::Handler::CGI.run(Rack::PathInfoRewriter.new(app))
