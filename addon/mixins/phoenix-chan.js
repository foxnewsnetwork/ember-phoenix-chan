import Ember from "ember";
import ChannelStore from '../models/channel-store';
import { Socket } from '../utils/phoenix';

export default Ember.Mixin.create({
  init() {
    this._super(...arguments);
    this.socket = new Socket(this.socketEndpointURI());
    this.socket.connect();
    this.channelStore = new ChannelStore(this.socket);
  },

  socketEndpointURI () {
    return [this.get("socketHost"), this.get("socketNamespace")].join("/");
  },

  onPush (modelOrModels) {
    if (Ember.isArray(modelOrModels)) {
      modelOrModels.map( (model) => { 
        return this.channelStore.listenForUpdatesTo(model); 
      });
    } else {
      return this.channelStore.listenForUpdatesTo(modelOrModels);
    }
  },

  onFindAll (modelsPromise) {
    return this.onQuery(modelsPromise, {});
  },

  onQuery (modelsPromise, query) {
    return modelsPromise.then( (models) => {
      return this.channelStore.listenForAddRemoveTo(models, query);
    });
  }
});