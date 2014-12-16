@Metrica.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
	
	class Entities.Line extends Backbone.Model
		
	class Entities.LinesCollection extends Backbone.Collection
		model: Entities.Line

		url: '/lines'

	Entities.linesInstance = null 

	API =
		getLines: ->
			if Entities.linesInstance != null
				console.log Entities.linesInstance 
				return Entities.linesInstance

			lines = new Entities.LinesCollection
			lines.fetch
				reset: true
			Entities.linesInstance = lines
			return Entities.linesInstance
			
	App.reqres.setHandler "line:entities", ->
		API.getLines()
