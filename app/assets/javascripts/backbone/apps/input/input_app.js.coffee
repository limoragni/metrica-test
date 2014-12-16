@Metrica.module "InputApp", (InputApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API = 
		listInput: ->
			InputApp.List.Controller.listInput()

	InputApp.on "start", ->
		API.listInput()