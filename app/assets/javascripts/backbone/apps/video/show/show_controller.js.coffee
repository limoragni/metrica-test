@Metrica.module "VideoApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Show.Controller = 
		
		showVideo: ->
			lines = App.request "line:entities"
			videoView = @getVideoView(lines)
			App.videoRegion.show videoView

		getVideoView: (lines)->
			new Show.Video
				collection: lines