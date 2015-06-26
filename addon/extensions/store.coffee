push = (modelName) ->
  output = @_super arguments...
  @adapterFor(modelName)?.onPush?output
  output

findAll = (modelName) ->
  output = @_super arguments...
  @adapterFor(modelName)?.onFindAll?output
  output

query = (modelName, query) ->
  output = @_super arguments...
  @adapterFor(modelName)?.onQuery?(output, query)
  output

class StoreExtensions
  @push = push
  @findAll = findAll
  @query = query

`export default StoreExtensions`
`export {
  push,
  findAll,
  query
}`