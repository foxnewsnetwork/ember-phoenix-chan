`import Em from 'ember'`

IndexController = Em.Controller.extend
  cameras: Em.computed.alias("model")

  actions:
    killCamera: (camera) ->
      camera.destroyRecord()
    makeCamera: (params) ->
      @store.createRecord("camera", params)
      .save()

`export default IndexController`