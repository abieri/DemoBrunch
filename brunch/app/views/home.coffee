# The MainView holds the wrapper template and is used to control rendering
# between the different child views.
template = require "./templates/home"
class HomeView extends Backbone.View

  # Add the html from the corresponding template and create the child views
  # Set the height on this element to avoid the app awkwardly resizing when
  # the keyboard is active
  initialize: ->
    
    
  render : =>
    @$el.html(template())

  
module.exports = HomeView
