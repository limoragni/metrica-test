@Metrica.module "CanvasApp.Show", (Show, App, Backbone, Marionette, $, _) ->
	class Show.Canvas extends Marionette.ItemView
		template: "canvas/show/templates/show_canvas"
		ui: {
			canvas: "canvas"
		}
		
		


		