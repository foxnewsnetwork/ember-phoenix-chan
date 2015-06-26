import Ember from 'ember';
import ChannelStore from '../models/channel-store';

export default Ember.Mixin.create({
  init() {
    this._super(...arguments);
    this.ddp = new DDP(this.buildDDPOptions());
    this.connection = this.setupDDPConnection();
    this.setupDDPCallbacks()
    this.channelStore = new ChannelStore(this.ddp);
  },

  buildDDPOptions() {
    return {
      endpoint: this.urlPrefix(),
      SocketConstructor: this.get("SocketConstructor")
    };
  },

  setupDDPConnection() {
    return new Ember.RSVP.Promise( resolve => {
      this.ddp.on("connected", => { 
        return resolve(this.ddp); 
      });
    });
  },
  
  setupDDPCallbacks() {
    return this.connection.then( ddp => {
      let cs = this.channelStore;
      ddp.on("nosub", cs.handleNoSub.bind(cs));
      ddp.on("ready", cs.handleReady.bind(cs));
      ddp.on("added", cs.handleAdded.bind(cs));
      ddp.on("changed", cs.handleChanged.bind(cs));
      ddp.on("removed", cs.handleRemoved.bind(cs));
      ddp.on("addedBefore", cs.handleAddedBefore.bind(cs));
      ddp.on("movedBefore", cs.handleMovedBefore.bind(cs));
    });
  }
});