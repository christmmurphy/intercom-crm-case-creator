require "json"
require "sinatra"
require "intercom"

# Useful tools for manipulating JSON
## https://codebeautify.org/jsonminifier
## https://codebeautify.org/javascript-escape-unescape

# Create an Intercom client to make REST API calls
access_token = ENV['TOKEN']
intercom = Intercom::Client.new(token: access_token)

post'/' do # This section listens for the initial post from Intercom and retruns the default card when the app is first loaded in the messenger

  #listen for any inbound webhooks from the app
  response_from_messenger = JSON.parse(request.body.read)

  #create the json blob to display in the inbox
  create_case = "{\"canvas\":{\"content\":{\"components\":[{\"type\":\"text\",\"text\":\"*Create a Case*\",\"style\":\"header\"},{\"type\":\"input\",\"id\":\"title\",\"label\":\"Title\",\"placeholder\":\"Enter a title for your Case...\"},{\"type\":\"textarea\",\"id\":\"description\",\"label\":\"Description\",\"placeholder\":\"Enter a description of the Case...\"},{\"type\":\"dropdown\",\"id\":\"label\",\"label\":\"Label\",\"options\":[{\"type\":\"option\",\"id\":\"bug\",\"text\":\"Bug\"},{\"type\":\"option\",\"id\":\"feedback\",\"text\":\"Feedback\"}]},{\"type\":\"single-select\",\"id\":\"priority\",\"label\":\"Priority\",\"options\":[{\"type\":\"option\",\"id\":\"low\",\"text\":\"Low\"},{\"type\":\"option\",\"id\":\"medium\",\"text\":\"Medium\"},{\"type\":\"option\",\"id\":\"high\",\"text\":\"High\"}]},{\"type\":\"spacer\",\"size\":\"s\"},{\"type\":\"button\",\"id\":\"submit-issue-form\",\"label\":\"Create Case\",\"style\":\"primary\",\"action\":{\"type\":\"submit\"}}]},\"stored_data\":{}}}"

  create_case # Return the json blob
end

#When a user pushes a button in the app
post '/submit' do
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

    # -----------------------
    # SIEBEL LOGIC GOES HERE
    # Here is where you can ingest & parse what was sent from Intercom when an admin presses submit
    # -----------------------

  # build card to return after submission
  success_card = "{\"canvas\":{\"content\":{\"components\":[{\"id\":\"success-card\",\"type\":\"text\",\"text\":\"Case Submitted\",\"style\":\"header\",\"align\":\"center\",\"bottom_margin\":false},{\"id\":\"welcome-link\",\"type\":\"image\",\"url\":\"https://downloads.intercomcdn.com/i/o/206415512/c618f364d4fdb02fb20ae102/tenor_fixed.gif\",\"align\":\"center\",\"width\":130,\"height\":130,\"rounded\":true},{\"id\":\"b57a7c7047a3674d6876063a2e3a\",\"type\":\"button\",\"label\":\"Submit Another\",\"style\":\"primary\",\"action\":{\"type\":\"submit\",\"url\":null},\"bottom_margin\":false}]},\"stored_data\":{}}}"

  # After you have run your logic, return a card
  success_card
end
