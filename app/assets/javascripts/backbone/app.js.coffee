@Metrica = do(Backbone, Marionette) ->
	App = new Marionette.Application

	App.addRegions
		videoRegion: "#video-region"
		canvasRegion: "#canvas-region"
		inputRegion: "#input-region"

	App.addInitializer ->
		App.module("InputApp").start()
		App.module("VideoApp").start()
		App.module("CanvasApp").start()

	App.on "initialize:after", ->
		if Backbone.history
			Backbone.history.start()

	App.interactionState = "idle"
	
	return App