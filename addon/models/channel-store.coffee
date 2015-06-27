`import Ember from 'ember'`

RSVP = Ember.RSVP

assertInclusion = (key, keys) ->
  return if keys.contains(key)?
  throw new Error "Expected #{key} to be found in #{keys}, but it wasn't"

getModelName = (record) ->
  record?.type?.modelName ?
  record?.constructor?.modelName ?
  record?.type?.typeKey ? 
  record?.constructor.typeKey

class ChannelStore
  constructor: (@socket) ->
    @channels =
      changes: {}
      adds: {}
      removes: {}

  cleanUp: (model) ->
    modelName = getModelName(model)
    id = model.get("id")
    @channels.changes[modelName]?.then (chan) -> chan.off id
    @channels.removes[modelName]?.then (chan) -> chan.off id

  subscribe: (chanType, modelName) ->
    assertInclusion chanType, Ember.A(["changes", "adds", "removes"])
    topic = Ember.String.pluralize modelName
    chan = @socket.chan "#{topic}:#{chanType}"
    @channels[chanType][modelName] = new RSVP.Promise (resolve) ->
      chan.join().receive "ok", -> 
        resolve chan

  getChan: (chanType, modelName) ->
    @channels[chanType]?[modelName]

  listenForUpdatesTo: (record) ->
    modelName = getModelName(record)
    if (chan = @getChan("changes", modelName))?
      chan
    else
      @subscribe("changes", modelName)
      .then (chan) ->
        chan.on record.get("id"), (fields) ->
          record.store.pushPayload fields
          record #.reload()

  listenForAddRemoveTo: (models, query) ->
    @listenForAddsTo(models, query)
    @listenForRemovesTo(models, query)

  listenForAddsTo: (models, query) ->
    modelName = getModelName(models)
    if (chan = @getChan("adds", modelName))?
      chan
    else
      @subscribe("adds", modelName)
      .then (chan) ->
        chan.on "new", (fields) ->
          # if matchesQuery query, fields
          models.store.pushPayload fields
          models # .update()

  listenForRemovesTo: (models, query) ->
    modelName = getModelName(models)
    if (chan = @getChan("removes", modelName))?
      chan
    else
      cs = @
      @subscribe("removes", modelName)
      .then (chan) ->
        models.map (model) ->
          chan.on model.get("id"), (fields) ->
            cs.cleanUp model
            models.store.unloadRecord model
            models

`export default ChannelStore`