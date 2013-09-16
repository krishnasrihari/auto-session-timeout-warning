# auto-session-timeout-warning

This provides warning message before auto session timeout in Rails application,
if you don't looking for warning message before session timeout please check source gem
https://github.com/pelargir/auto-session-timeout

## Installation

Add this line to your application's Gemfile:

    gem 'auto-session-timeout-warning'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install auto-session-timeout-warning

## Usage
Add jquery and jquery-ui on your application.js file, set the current_user helper method in application controller if its not yet defined

and follow all steps as for https://github.com/pelargir/auto-session-timeout.

Check below configuration for warning message


## Warning message Configuration
    <html>
      <head>...</head>
      <body>
        <% if current_user %>
          <%= auto_session_timeout_js timeout: 60, frequency: 60, start: 60, warning: 20 %>
        <% end %>
        ...
      </body>
    </html>

frequency refers to how frequently browser interactive with server to find the session details,

timeout refers to auto session time out, if you set auto_session_timeout: 2.minutes on application_controller, you should set 120 seconds here,

start describes the starting time of server interaction, if it is 60, first server interaction will start after 60 seconds,

warning describes the starting time of warning message before session timed out, if is 20, dialog warning message will popup before 20 seconds of timeout.

Default values here:

timeout: 60,
frequecy: 60,
start: 60,
warning: 20

## TODO
* setting timeout in controller vs. user

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Resources

* Source Repository: http://github.com/pelargir/auto-session-timeout/