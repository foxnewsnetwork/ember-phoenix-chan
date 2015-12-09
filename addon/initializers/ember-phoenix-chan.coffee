initialize = (application) ->
  application.inject "controller", "phoenix", "service:phoenix"
  application.inject "route", "phoenix", "service:phoenix"
  application.inject "adapter", "phoenix", "service:phoenix"

EmberPhoenixChanInitializer =
  name: 'ember-phoenix-chan'
  before: 'store'
  initialize: initialize

`export {initialize}`
`export default EmberPhoenixChanInitializer`
