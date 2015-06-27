# Ember Phoenix Chan

Elixir has a great web framework called phoenix which ships with support for real-time communication (via sockets / long poll), and Ember, being a front-end framework, can benefit a lot from gaining real-time capabilities.

This library attempts to achieve this through a compromise between what Phoenix ships and MeteorJS's DDP specs.

> ## WARNING
>
> This library is alpha software and a lot of DDP's functionalities will not have been implemented
>
> Granted I'll be working on it (since I'll be using it), but you should only use it at your own descretion
>
> Me

## How to use
Suppose you have a camera database and a camera model, you can setup real-time updates like so (you can also check out the example in the `serve` directory):

On the Elixir back-end, you'll need to setup your channel like so:

`web/channels/camera_channel.ex`
```elixir
defmodule App.CameraChannel do
  use App.Web, :channel

  def join("cameras:adds", _auth_msg, socket) do
    {:ok, socket}
  end

  def join("cameras:changes", _auth_msg, socket) do
    {:ok, socket}
  end

  def join("cameras:removes", _auth_msg, socket) do
    {:ok, socket}
  end

end
```
Be sure to also update your `web/router.ex`:
```elixir
...
  socket "/ws", App do
    channel "cameras:*", CameraChannel
  end
...
```
You'll also need to tell your controller to broadcast changes as POST, PUT, and DELETE requests happen:

`web/controllers/camera_controller.ex`
```elixir
defmodule App.CameraController do
  ...
  def create(conn, %{"camera" => camera_params}) do
    ...
    App.Endpoint.broadcast! "cameras:adds", "new", %{camera: camera}
    ...
  end

  def update(conn, %{"id" => id, "camera" => camera_params}) do
    ...
    App.Endpoint.broadcast! "cameras:changes", "#{camera.id}", %{camera: camera}
    ...
  end

  def delete(conn, %{"id" => id}) do
    ...
    App.Endpoint.broadcast! "cameras:removes", "#{camera.id}", %{camera: camera}
    ...
  end
  ...
end
```
Now, onto the front end! Mix `PhoenixChanMixin` into whatever adapter you wish and it should just work

```javascript
import PhoenixChanMixin from 'ember-phoenix-chan';

ApplicationAdapter = DS.ActiveModelAdapter.extend(PhoenixChanMixin, {
  socketNamespace: "ws", // you must provide these two, or else you'll see some nonsensical error lol
  socketHost: "ws://localhost:4000" // you must provide these two, or else you'll see some nonsensical error lol
});

```
Be sure to provide the `socketHost` and `socketNamespace` fields so Phoenix-chan knows where to look for your Elixir back-end

## Q&A
Q: WTF it's a mixin?! 

A: Yes...

Q: Why?!

A: Because, if you're like me, you believe real-time is just an optimization over ctrl+r (or cmd+r if you're an insufferable bandwagoner), and therefore should be readily decoupled from the actual logic of your application.

Are you running a rails / php backend and now, all of a sudden, you want to jump aboard the Elixir/Erlang craze and go real-time? Great, just setup your Phoenix back-end somewhere independent of your older back-end, and mix PhoenixChan into your already existing adapter (instead of writing a new one, or extending https://github.com/BlakeWilliams/ember-phoenix-adapter)!

## Testing
lol okay, I lied, there are no automated tests yet, but there is a local app in dummy that you can manually test. 

But in order to do that, first, you'll need to install Erlang and Elixir. Unfortunately, this step is not trivial, but an excellent guide has been written up by Jose Valim and his cronies:

http://elixir-lang.org/install.html

Next, it helps (though it isn't required) if you install Phoenix, you can following the guide here:

http://www.phoenixframework.org/v0.13.1/docs/installation

Next, you'll need to build the example Phoenix app included in this addon:

```shell
cd serve
mix deps.get
iex -S mix phoenix.serve
```

Now, you're ready to boot up the dummy ember application:

```shell
cd ..
npm install && bower install
ember s
```
And navigate to localhost:4200 in your browser.

In order to properly test, you'll need to open up 2 tabs. Try filling out the form and creating a new camera object, you'll see that it propages to the other tab nicely. Clicking on the created camera objects deletes them (this also propagates).

The reason this isn't automated is because it's a lot of work rigging out phantomjs (or crapybara) to use multiple tabs to test (lol), but I need this addon right now.

## TODOs

1. Implement query filtering in the channel-store
2. Decouple phoenix.js from ChannelStore to allow for other WebSocket methods
3. Rig up automated tests with either phantom or crapybara
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
