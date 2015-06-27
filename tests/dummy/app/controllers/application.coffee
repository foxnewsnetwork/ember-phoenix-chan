`import Em from 'ember'`

ApplicationController = Em.Controller.extend
  actions:
    makeCamera: ->
      @model
      .save()
      .then =>
        @send "refresh"

`export default ApplicationController`