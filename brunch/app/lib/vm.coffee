

class ViewManager

  constructor:(options) ->
    @viewpath = options.viewpath
    console.log @viewpath
    @views = {}
    @viewElements = {}

  getViewElement : (name)=>
    if @viewElements[name]?
      viewElement = @viewElements[name]
    else
      newElement = $("<div class='view' id='"+name+"'></div>")
      $(".views").append newElement
      @viewElements[name] = newElement
      viewElement = newElement
    viewElement
  
  create : (name, View, options = {}) =>
    if options and !options.el?
      options.el =  @getViewElement(name,options)   
    view = new View(options)
    view.$el?.hide() 
    @views[name] = view


  preloadViews : (viewsToPreload,done) ->
    viewRenderings = Futures.Lateral.create (complete, viewToRender) =>
      view = require @viewpath + viewToRender.name
      key = viewToRender.options?.key or viewToRender.name 
      createdView =  @create key, view, viewToRender.options
      createdView.render() if createdView.render?
      complete()
    
    viewRenderings.add(viewsToPreload).when =>
        done()
    
      
  
  showView : (name, options = {}) ->
    if options?.lockview
      window.lockautorotate()
    else
      window.unlockautorotate()
    key = options?.key or name
    if @views[key]?
      view = @views[key]
    else
      view = @create name, key, options
    if view.display?
      view.display options
    @currentView?.$el?.hide().removeClass "active"
    @currentView = view
    @currentView.$el?.show().addClass "active"

module.exports = ViewManager
