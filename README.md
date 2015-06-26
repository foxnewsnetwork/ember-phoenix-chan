# Ember-ddp

DDP is Meteor's Distributed Data Protocol, and Meteor is a real-time front-and-back-end js framework.

Luckily, DDP decouples nicely from Meteor which means we can use it in Ember to achieve the same level of real-time using whatever backend we choose.

> ## WARNING
>
> This library is alpha software and a lot of DDP's functionalities will not have been implemented
>
> Granted I'll be working on it (since I'll be using it), but you should only use it at your own descretion
>
> Me

## How to use
Q: WTF it's a mixin?! 

A: Yes

Mix it in to whatever adapter you wish to use ddp and it'll just work

```javascript
ApplicationAdapter = DS.ActiveModelAdapter.extend(EmberDDPMixin, {
  SocketConstructor: WebSocket
});
```
If you don't provide a socket, DDP will use a default web socket.

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
