`import Ember from 'ember'`
`import {Socket} from 'vendor/ember-phoenix-chan/phoenix'`

{computed, isBlank, RSVP} = Ember
{equal} = computed
{Promise} = RSVP

PhoenixService = Ember.Service.extend
  isConnected: equal "connectionState", "open"
  p: computed get: RSVP.resolve @
  
  init: ->
    @_super arguments...
    @updateStatus()

  updateStatus: ->
    state = @get("socket")?.connectionState() ? "closed"
    @set "connectionState", state

  disconnect: ->
    return @get("p") if isBlank @get("socket")
    new Promise (resolve) =>
      @get("socket").disconnect =>
        @set "socket", null
        resolve @

  connect: (endpoint, params={}) ->
    @disconnect()
    .then =>
      socket = new Socket(endpoint, params)
      @set "socket", socket
      update = @updateStatus.bind(@)
      socket.onMessage update 
      socket.onClose update
      socket.onError update
      socket.onOpen update
      socket.connect()
      new Promise (resolve, reject) =>
        socket.onOpen => resolve @
        socket.onError => reject @

`export default PhoenixService`
