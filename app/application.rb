require 'socket'
require 'byebug'
require 'mono_logger'

require './app/tools/router.rb'
require './app/tools/keeper'

class Application
  def initialize
    Keeper.store({ logger: Logger.new(STDOUT) })

    server = TCPServer.new ENV["PORT"]
    router = Router.new

    Keeper.logger.info("Listening to #{ENV["PORT"]}")
    loop do
      Thread.start(server.accept) do |session|
        destination = router.route(session.gets)
        if destination.nil?
          data = "Page Not Found"
          status = 404
        else
          data = destination&.new&.run
          status = 200
        end
        # https://blog.appsignal.com/2016/11/23/ruby-magic-building-a-30-line-http-server-in-ruby.html
        session.print "HTTP/1.1 #{status}\r\n"
        session.print "Content-Type: text/html\r\n"
        session.print "\r\n"
        session.print data
      ensure
        session.close
      end
    end
  end
end

Application.new
