@Metrica.module "CanvasApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Show.Controller = 
		
		showCanvas: ->
			canvasView = @getCanvasView()
			App.canvasRegion.show canvasView
			canvasView.ui.canvas.click (e)->
				App.vent.trigger "clicked:canvas", e
			return canvasView.ui.canvas
		
		getCanvasView: ->
			new Show.Canvas


 
				