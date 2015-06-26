import Ember from 'ember';

export default Ember.Mixin.create({
  onPush (modelOrModels) {
    if (Ember.isArray(modelOrModels)) {
      modelOrModels.map( (model) => { 
        return this.channelStore.listenForUpdatesTo(modelOrModels); 
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