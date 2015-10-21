import Ember from 'ember';

const Promise = Ember.RSVP.Promise;

export default Ember.Route.extend({
  model () {
    const socket = this.phoenix.get("socket");
    return new Promise((resolve, reject) => {
      var channel = socket.channel("rooms:lobby", {})
      channel.messages = Ember.A();
      channel.on("new:msg", (msg) => {
        console.log("new:msg");
        console.log(msg);
        channel.messages.pushObject(msg);
      });

      channel.join()
      .receive("ok", (msg) => { 
        console.log("channel join success: ");
        console.log(msg);
        return resolve(channel); 
      })
      .receive("error", (msg) => { 
        console.log("channel join failed: ");
        console.log(msg);
        return reject(channel); 
      });
    });
  }
});