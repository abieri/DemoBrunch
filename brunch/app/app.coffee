# The application is a the object from which the cooking data, current timer
# selection, user and router can be accessed.


# Models

Router = require("lib/router")

# Collections
Application =
  initialize: (callback) ->
    @router = new Router callback
    	
  
  
module.exports = Application
	