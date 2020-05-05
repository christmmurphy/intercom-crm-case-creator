# This is required for hosting Sinatra apps on heroku
# More info: https://devcenter.heroku.com/articles/rack
require './app'
run Sinatra::Application
