import Em from 'ember';

export default Em.Route.extend({
  model () {
    return this.store.createRecord("camera");
  },
  actions: {
    refresh () {
      this.refresh();
    }
  }
});