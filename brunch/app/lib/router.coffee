# The app router watches the browser's navigation and plugs to the
# corresponding action on the mainView

ViewManager = require("./vm")
NavView = require("../views/nav")

class AppRouter extends Backbone.Router

  preload : (callback)=>
    views = [
      {
        name : "home"
      },
      {
        name : "about"
        
      }
      
    ]
    @vm.preloadViews views, callback
    
    


  initLockRotateMethods : ()=>
     # functions to handle the orientation lock. For android we use a plugin, for ios there is a solution
    window.lockautorotate = () =>
      if /iphone|ipad|ipod/i.test(navigator.userAgent.toLowerCase())
        window.plugins.deviceOrientation.setOrientation("portrait")
        
      else if /android/i.test(navigator.userAgent.toLowerCase())
        window.plugins?.orientationLock?.lock("portrait")
    window.unlockautorotate = () =>
      if /iphone|ipad|ipod/i.test(navigator.userAgent.toLowerCase())
        window.autoRotatelocked = false  
      else if /android/i.test(navigator.userAgent.toLowerCase())
        window.plugins?.orientationLock?.unlock()
    window.shouldRotateToOrientation = (o) =>
      # works on ios for the iphone because screen is too small
      return !window.autoRotatelocked
    
    
  bindAnalyticsEvents : =>
    
    @on "route", ()=>
      console.log "trackPage :", Backbone.history.fragment
      window.plugins?.gaPlugin?.trackPage(
        ->
        ->
        Backbone.history.fragment
      )
  
  errorAnalyticsInit : =>
    console.log "error analytics"

    #by default we lock the autorotate
  initialize:(callback) ->
    window.plugins?.gaPlugin?.init @bindAnalyticsEvents ,@errorAnalyticsInit, "UA-43047189-1", 10
    @initLockRotateMethods()
    
    @vm = new ViewManager 
      viewpath : "../views/"

    @preload ()=>
      @navBar = new NavView
        el : $('.nav')
      @navBar.render()
      callback()

  # Bind the routes to their corresponding methods
  routes:
    
    "home" :              "home"
    "about":              "about"
    "*actions": "home"


  about :() ->
    @vm.showView "about"

  
  home :() ->
    @vm.showView "home",
      lockview : true
module.exports = AppRouter
