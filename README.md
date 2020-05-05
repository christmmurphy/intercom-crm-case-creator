A basic Intercom Inbox app for demo purposes built in Ruby. This app uses the [Intercom App Framework](https://app.intercom.com/a/canvas-kit-builder) to provide a UI for agents to create cases in a CRM of their choosing.

## In Use
#### Inbox:
<img src="https://downloads.intercomcdn.com/i/o/206430329/8265babc5c45f959132f6d96/demo.gif">

#### Your CRM:
When an Intercom admin uses the integration, pressing submit captures all the details entered to the form. These case details are sent via webhook and you will see them output to your ruby console for you to refactor and include in your POST request:
```
puts "****************************"
puts "Case Title: #{case_title}"
puts "Case Description: #{case_description}"
puts "Case Label: #{case_label}"
puts "Case Priority: #{case_priority}"
puts "****************************"
```
