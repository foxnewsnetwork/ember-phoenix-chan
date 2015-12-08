# Ember Phoenix Chan

Elixir has a great web framework called Phoenix that ships with support for real-time communication (via sockets / long poll). Ember, being a front-end framework, can benefit a lot from gaining real-time capabilities.

This addon grabs phoenix.js from the Phoenix framework and puts it into your Ember app.

## How to use

To get started on building a Phoenix Elixir app, consult the good guide on Phoenix here:

[http://www.phoenixframework.org/docs/channels](http://www.phoenixframework.org/docs/channels)

In this addon, much of the same channel / socket functionality is exposed via the `phoenix` service

phoenix is automatically injected into controllers, routes, and the adapters
```coffee
SomeRoute = Ember.Route.extend
  model: ->
    @phoenix.connect("ws://localhost:4000/socket", {some_token: "x"})
    .then =>
      socket = @phoenix.get("socket")
      channel = socket.channel("rooms:lobby", {})
      channel.on "new:msg", (msg) -> # do something
      channel.join()
```
Chris McCord has written a good example of how to use the js sockets exposed by phoenix.js:

[https://github.com/chrismccord/phoenix_chat_example/blob/master/web/static/js/app.js](https://github.com/chrismccord/phoenix_chat_example/blob/master/web/static/js/app.js)

The source code for phoenix.js is here:

[https://github.com/phoenixframework/phoenix/blob/master/web/static/js/phoenix.js](https://github.com/phoenixframework/phoenix/blob/master/web/static/js/phoenix.js)

It's also possible to directly import Phoenix anywhere into your app:

```js
import {Phoenix, Socket, Channel} from 'vendor/ember-phoenix-chan/phoenix';
```
## Testing and Development

You'll need Elixir, Erlang, and the OTP on your local computer.

You can get those things at the elixir website:

[http://elixir-lang.org/install.html](http://elixir-lang.org/install.html)

Once you have the tools for the backend, you can boot them up like so:

```shell
cd ..
npm install && bower install

# Alternatively, use ./bin/phoenix
cd bower_components/phoenix_chat_example
mix local.hex
mix deps.get
iex -S mix phoenix.server

ember s
```
And navigate to localhost:4200 in your browser.

In order to properly test, you'll need to open up 2 tabs. Try filling out the form and creating a new camera object, you'll see that it propages to the other tab nicely. Clicking on the created camera objects deletes them (this also propagates).

The reason this isn't automated is because it's a lot of work rigging out phantomjs (or Capybara) to use multiple tabs to test (lol), but I need this addon right now.

## TODOs

1. Implement query filtering in the channel-store
2. Decouple phoenix.js from ChannelStore to allow for other WebSocket methods
3. Rig up automated tests with either Phantom or Capybara
4. More error handling and sensible error messages
5. Conform to more of DDP's specifications
6. Draw a mai-waifu-moe-am-i-kawaii-uguu~ logo

## Installation

* `git clone` this repository
* `npm install`
* `bower install`

## Running

* `ember server`
* Visit your app at http://localhost:4200.

## Running Tests

* `ember test`
* `ember test --server`

## Building

* `ember build`

For more information on using ember-cli, visit [http://www.ember-cli.com/](http://www.ember-cli.com/).
