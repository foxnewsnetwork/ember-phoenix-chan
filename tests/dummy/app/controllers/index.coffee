`import Em from 'ember'`

{alias} = Em.computed

IndexController = Em.Controller.extend
  channel: alias "model"
  messages: alias "channel.messages"
  actions:
    submit: ->
      body = Em.$("textarea[name=xx]").val()
      user = "tester"
      @get("channel")
      .push "new:msg", {user, body}
      .receive "ok", (msg) -> console.log msg
      .receive "error", (msg) -> alert msg
`export default IndexController`