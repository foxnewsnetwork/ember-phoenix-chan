`import DS from 'ember-data'`
`import { push, findAll, query} from '../extensions/store'`

initialize = ->
  unless DS.Store::_emberPhoenixChanMonkeyPatch is true
    DS.Store.reopen
      _emberPhoenixChanMonkeyPatch: true
      push: push
      findAll: findAll
      findByQuery: query
      query: query


EmberPhoenixChanInitializer =
  name: 'ember-phoenix-chan'
  before: 'store'
  initialize: initialize

`export {initialize}`
`export default EmberPhoenixChanInitializer`
