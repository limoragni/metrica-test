@Metrica.module "CanvasApp.Draw", (Draw, App, Backbone, Marionette, $, _, CanvasApp) ->

	Draw.Controller = 
		canvas: null

		drawLine: (points, normalized)->
			canvas = @canvas[0]
			ctx = canvas.getContext "2d"
			ctx.beginPath()
			if normalized
				ctx.moveTo points[0].x * canvas.width, points[0].y * canvas.height
				ctx.lineTo points[1].x * canvas.width, points[1].y * canvas.height, 10
			else
				ctx.moveTo points[0].x, points[0].y 
				ctx.lineTo points[1].x, points[1].y , 10
			
			ctx.strokeStyle = '#E01A00'
			ctx.lineWidth = 2
			ctx.stroke()

		drawLineWhileDrawing: (point, mousePosition)->
			x = point.x * @canvas[0].width
			y = point.y * @canvas[0].height
			
			@clearCanvas()
			@drawPoint({x:x,y:y})
			@drawLine([mousePosition, {x:x,y:y}], false)
			

		clearCanvas: ->
			ctx = @canvas[0].getContext "2d"
			ctx.clearRect 0, 0, @canvas[0].width, @canvas[0].height

		drawPoint: (point)->
			ctx = @canvas[0].getContext "2d"
			ctx.beginPath()
			ctx.fillStyle = 'red'
			ctx.arc point.x, point.y, 5, 0, 2 * Math.PI, false
			ctx.fill()
			
		getPoint: (e) ->
			x = e.offsetX - @canvas[0].offsetLeft + 20
			y = e.offsetY - @canvas[0].offsetTop + 20
			return {x: x, y: y}			 	 
		

 
				