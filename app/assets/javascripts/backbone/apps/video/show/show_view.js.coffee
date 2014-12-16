@Metrica.module "VideoApp.Show", (Show, App, Backbone, Marionette, $, _) ->
	class Show.Video extends Marionette.ItemView
		template: "video/show/templates/show_video"
		lastSecondCaptured: 0
		currentSecondCaptured: 0
		
		
		onRender: ->
			videojs @$('#video-player')[0], {}
			App.vent.trigger "setApi:video", @$('#video-player_html5_api')
			@addVideoTimeUpdateListener()
			
		addVideoTimeUpdateListener: ->
  			self = @
  			@$('#video-player_html5_api').on 'timeupdate', (t)->
  				self.currentSecondCaptured = parseInt(@.currentTime)
  				self.sendSyncEventEverySecond()	
  			@$('#video-player_html5_api').on 'playing', (e) ->
  				App.execute "playing:video"	
		
		sendSyncEventEverySecond: ->
			if @lastSecondCaptured != @currentSecondCaptured 
				@lastSecondCaptured = @currentSecondCaptured
				App.vent.trigger("syncPulse:video", @currentSecondCaptured)




		