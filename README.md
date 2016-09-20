# auto-session-timeout-warning

This provides warning message before auto session timeout in Rails application,
if you don't looking for warning message before session timeout please check source gem
https://github.com/pelargir/auto-session-timeout
---
## Installation

Add this line to your application's Gemfile:

    gem 'auto-session-timeout-warning'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install auto-session-timeout-warning
---
## How to use?
### Add jQuery and jQuery UI
Add jquery and jquery-ui on your application.js file, set the current_user helper method in application controller if its not yet defined

### Setup 
setup your application controller to use auto timeout warning. Here I setup the session timeout warning to 20 minutes of inactivity.
```
class ApplicationController < ActionController::Base
  auto_session_timeout 20.minutes
end  
```

Add before_timedout_action in application controller
```
class ApplicationController < ActionController::Base
  before_timedout_action
end
```

If you want to override the before_timedout, just add protected before_timedout action and add your custom implementation here
```
class ApplicationController < ActionController::Base
  before_timedout_action

  protected
  #override before_timedout
  def before_timedout
  	#your custom code here
  end
end
```

### Warning message configuration
Add warning tag and auto session_timeout javascript config in views like application layout or any other page
``` 
      <body>
        <% if current_user %>
          <%= auto_session_warning_tag %>
          <%= auto_session_timeout_js timeout: 60, frequency: 60, start: 60, warning: 20 %>
        <% end %>
        ...
      </body>
```
#### auto_session_timeout_js config details here
**frequency:** how frequently browser interactive with server to find the session details,

**timeout:** auto session time out in seconds. If you set auto_session_timeout: 2.minutes on application_controller, you should set 120 seconds here.

**start:** starting time of server interaction. If it is 60, first server interaction will start after 60 seconds,

**warning:** Show warning message before session timed out. If it is 20, dialog warning message will popup before 20 seconds of timeout.

*Default values here:*
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