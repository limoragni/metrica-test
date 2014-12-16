@Metrica.module "CanvasApp", (CanvasApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	CanvasApp.addInitializer ->
		CanvasApp.lines = App.request "line:entities"
	
	@canvas = null
	@currentLine = null
	@currentPointsArray = []
	@mousePosition = {}

	API =
		showCanvas: ->
			canvas = CanvasApp.Show.Controller.showCanvas()
			CanvasApp.Draw.Controller.canvas = canvas
			CanvasApp.canvas = canvas
		
		drawLineOnCanvas: (points, normalized) ->
			CanvasApp.Draw.Controller.drawLine(points, normalized)

		drawLineWhileDrawing: (point, mousePosition) ->
			CanvasApp.Draw.Controller.drawLineWhileDrawing(point, mousePosition)
		
		clearCanvas: ->
			CanvasApp.Draw.Controller.clearCanvas()

		getPoint: (e)->
			return CanvasApp.Draw.Controller.getPoint(e)

		drawPoint: (point)->
			return CanvasApp.Draw.Controller.drawPoint(point)
		
		storePoint: (point, index) ->
			point.x = point.x / CanvasApp.canvas[0].width
			point.y = point.y / CanvasApp.canvas[0].height
			CanvasApp.currentPointsArray[index] = point
		
		setFirstPoint: (e)->
			point = @getPoint(e)
			@storePoint(point, 0)
		
		endLineDrawing: (e)->
			point = @getPoint(e)
			@drawPoint(point)
			@storePoint(point, 1)
			@drawLineOnCanvas(CanvasApp.currentPointsArray, true)
		
		stopIfIsLineOnTime: (second)->
			model = CanvasApp.lines.find (m)->
				m.get("time") == second
			if model
				position = model.get('position')
				App.execute "drawing:line" 
				API.drawLineOnCanvas(position, true)

		saveLine: ->
			currentLine = App.request 'currentLine:lines'
			currentLine.set 'position', _.clone CanvasApp.currentPointsArray
			currentLine.save()

	CanvasApp.on 'start', ->
		API.showCanvas()

	App.vent.on "syncPulse:video", (second) ->
		API.stopIfIsLineOnTime(second)
		
	App.commands.setHandler 'playing:video', ->
		API.clearCanvas()

	App.vent.on 'getReadyForDrawing:canvas', (currentLine)->
		API.clearCanvas()
		App.interactionState = "readyForDrawing"
		CanvasApp.currentLine = currentLine

	
	App.vent.on 'clicked:canvas', (e)->
		switch App.interactionState
			when "readyForDrawing" 
				API.setFirstPoint(e)
				App.interactionState = "drawingLine"
			when "drawingLine" 
				API.endLineDrawing(e)
				API.saveLine()
				App.interactionState = "idle"

	$(document).mousemove (e) ->
		if App.interactionState == "drawingLine"
			mousePosition = {}
			mousePosition.x = e.pageX - 20
			mousePosition.y = e.pageY - 20
			API.drawLineWhileDrawing(CanvasApp.currentPointsArray[0], mousePosition)


			
			


	