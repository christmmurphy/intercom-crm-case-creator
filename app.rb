require "json"
require "sinatra"
require "intercom"

# Useful tools for manipulating JSON
## https://codebeautify.org/jsonminifier
## https://codebeautify.org/javascript-escape-unescape

# Create an Intercom client to make REST API calls
#access_token = ENV['TOKEN']
access_token = "dG9rOmE4OTg5MjAwXzdhMDhfNDdjYl85Mzg2X2RmNTM3N2JhZjBmZToxOjA="
intercom = Intercom::Client.new(token: access_token)

post'/' do # This section listens for the initial post from Intercom and retruns the default state of the card when the app is first loaded by the messenger
  response_from_messenger = JSON.parse(request.body.read)
  puts response_from_messenger
  create_case = "{\"canvas\":{\"content\":{\"components\":[{\"type\":\"text\",\"text\":\"*Create a Case*\",\"style\":\"header\"},{\"type\":\"input\",\"id\":\"title\",\"label\":\"Title\",\"placeholder\":\"Enter a title for your Case...\"},{\"type\":\"textarea\",\"id\":\"description\",\"label\":\"Description\",\"placeholder\":\"Enter a description of the Case...\"},{\"type\":\"dropdown\",\"id\":\"label\",\"label\":\"Label\",\"options\":[{\"type\":\"option\",\"id\":\"bug\",\"text\":\"Bug\"},{\"type\":\"option\",\"id\":\"feedback\",\"text\":\"Feedback\"}]},{\"type\":\"single-select\",\"id\":\"priority\",\"label\":\"Priority\",\"options\":[{\"type\":\"option\",\"id\":\"low\",\"text\":\"Low\"},{\"type\":\"option\",\"id\":\"medium\",\"text\":\"Medium\"},{\"type\":\"option\",\"id\":\"high\",\"text\":\"High\"}]},{\"type\":\"spacer\",\"size\":\"s\"},{\"type\":\"button\",\"id\":\"submit-issue-form\",\"label\":\"Create Case\",\"style\":\"primary\",\"action\":{\"type\":\"submit\"}}]},\"stored_data\":{}}}"
  create_case # Return the card
end

post '/submit' do # When a user presses a button in your app, return a card
  submitted_card = JSON.parse(request.body.read)
  case_title = submitted_card["input_values"]["title"]
  case_description = submitted_card["input_values"]["description"]
  case_label = submitted_card["input_values"]["label"]
  case_priority = submitted_card["input_values"]["priority"]

  puts "****************************"
  puts "Case Title: #{case_title}"
  puts "Case Description: #{case_description}"
  puts "Case Label: #{case_label}"
  puts "Case Priority: #{case_priority}"
  puts "****************************"

  create_case = "{\"canvas\":{\"content\":{\"components\":[{\"type\":\"text\",\"text\":\"*Create a Case*\",\"style\":\"header\"},{\"type\":\"input\",\"id\":\"title\",\"label\":\"Title\",\"placeholder\":\"Enter a title for your Case...\"},{\"type\":\"textarea\",\"id\":\"description\",\"label\":\"Description\",\"placeholder\":\"Enter a description of the Case...\"},{\"type\":\"dropdown\",\"id\":\"label\",\"label\":\"Label\",\"options\":[{\"type\":\"option\",\"id\":\"bug\",\"text\":\"Bug\"},{\"type\":\"option\",\"id\":\"feedback\",\"text\":\"Feedback\"}]},{\"type\":\"single-select\",\"id\":\"priority\",\"label\":\"Priority\",\"options\":[{\"type\":\"option\",\"id\":\"low\",\"text\":\"Low\"},{\"type\":\"option\",\"id\":\"medium\",\"text\":\"Medium\"},{\"type\":\"option\",\"id\":\"high\",\"text\":\"High\"}]},{\"type\":\"spacer\",\"size\":\"s\"},{\"type\":\"button\",\"id\":\"submit-issue-form\",\"label\":\"Create Case\",\"style\":\"primary\",\"action\":{\"type\":\"submit\"}}]},\"stored_data\":{}}}"
  create_case
  
end
