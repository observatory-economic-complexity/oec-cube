require 'bundler'
Bundler.setup

require 'rack/cors'
require 'rack/config'
require 'rack/deflater'

require 'logger'
require 'java'
require 'jruby/core_ext'
require 'mondrian_rest'

# require_relative './drivers/monetdb-jdbc-2.18.jar'
# Java::nl.cwi.monetdb.jdbc.MonetDriver

require 'jdbc/postgres'
Jdbc::Postgres.load_driver

logger = Logger.new(STDERR)
logger.level = Logger::DEBUG

PARAMS = {
  driver: 'postgresql',
  host: ENV['MONDRIAN_DB_HOST'],
  port: ENV['MONDRIAN_DB_PORT'],
  database: ENV['MONDRIAN_DB_NAME'],
  username: ENV['MONDRIAN_DB_USER'],
  password: ENV['MONDRIAN_DB_PW'],
  catalog: File.join(File.dirname(__FILE__), 'schema.xml')
}

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :get
  end
end

use Rack::Config do |env|
  env['mondrian-olap.params'] = PARAMS
end

use Rack::CommonLogger, $stdout

run Mondrian::REST::Api
