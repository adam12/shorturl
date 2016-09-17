#!/opt/ruby/bin/ruby
ENV["HOME"] ||= `echo ~`.strip
require "./app"

#
# Apache gives us a funny SCRIPT_NAME when running as CGI
# So we need to rewrite it and remove a bunch of crap
#
class Rack::PathInfoRewriter
  def initialize(app)
    @app = app
  end

  def call(env)
    env["SCRIPT_NAME"] = ""
    pathInfo, query = env["REQUEST_URI"].split("?", 2)
    env["PATH_INFO"] = pathInfo
    env["QUERY_STRING"] = query
    @app.call(env)
  end
end

Rack::Handler::CGI.run(Rack::PathInfoRewriter.new(App))
