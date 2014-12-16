@Metrica.module "InputApp.List", (List, App, Backbone, Marionette, $, _) ->

	List.Controller = 
		
		lines: null
		currentLine: null

		listInput: ->
			@lines = App.request "line:entities"
			inputView = @getInputView @lines
			App.inputRegion.show inputView

		getInputView: (lines)->
			new List.Inputs
				collection: lines

	App.vent.on 'clicked:addLine', ->
		lines = List.Controller.lines
		time = App.request "currentTime:video"
		model = lines.find (m)->
			m.get("time") == time
		if model
			List.Controller.currentLine = model
		else
			List.Controller.currentLine = lines.add {name: "Line" + (lines.length + 1), time: time}
		App.vent.trigger "getReadyForDrawing:canvas" 
	
	App.reqres.setHandler 'currentLine:lines', ->
		console.log List.Controller.currentLine 
		return List.Controller.currentLine	
