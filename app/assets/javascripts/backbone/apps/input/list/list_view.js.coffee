@Metrica.module "InputApp.List", (List, App, Backbone, Marionette, $, _) ->
	
	class List.Input extends Marionette.ItemView
		template: "input/list/templates/_input"
		tagName: "li"
		ui:{
			edit:   '.edit-input'
			remove: '.delete-input'
			input:  'input'
		}
		events:{
			'click .edit-input' : 'editInput'
			'click .delete-input' : 'deleteInput'
		}

		editInput: ->
			if @ui.input.prop('disabled') == true
				@ui.input.prop 'disabled', false
				@ui.input.focus()
				@ui.edit.removeClass "glyphicon-pencil"
				@ui.edit.addClass "glyphicon-ok"
			else
				@ui.input.prop 'disabled', true
				@ui.input.blur()
				@ui.edit.removeClass "glyphicon-ok"
				@ui.edit.addClass "glyphicon-pencil"
				@model.set('name', @ui.input.prop('value'))
				@model.save()
		
		deleteInput: ->
			@model.destroy()


		serializeData: (x)->
			timeInSeconds = @.model.get('time')
			minutes = Math.floor(timeInSeconds / 60);
			seconds = timeInSeconds - minutes * 60
			if seconds < 10
				seconds = "0" + seconds  
			formattedTime = minutes + ":" + seconds
			@model.set("formattedTime", formattedTime)
			return @.model.attributes

	class List.Inputs extends Marionette.CompositeView
		template: "input/list/templates/inputs"
		childView: List.Input
		childViewContainer: "ul"
		events: {
			'click #add-line' : "addLine"
		}

		addLine: ->
			if App.interactionState == "idle" 
				App.vent.trigger 'clicked:addLine'
				   
