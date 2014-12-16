@Metrica.module "VideoApp", (VideoApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	@videoApi = null
	
	API =
		showVideo: ->
			VideoApp.Show.Controller.showVideo()

	VideoApp.on 'start', ->
		API.showVideo()

	App.vent.on 'setApi:video', (v) ->
		VideoApp.videoApi = v

	App.commands.setHandler 'drawing:line', ->
		VideoApp.videoApi[0].pause()
	
	App.vent.on 'clicked:addLine', ->
		VideoApp.videoApi[0].pause()

	App.reqres.setHandler 'currentTime:video', ->
		parseInt(VideoApp.videoApi[0].currentTime)