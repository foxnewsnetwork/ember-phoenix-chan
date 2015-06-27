import DS from 'ember-data';
import PhoenixChanMixin from 'ember-phoenix-chan';

export default DS.ActiveModelAdapter.extend(PhoenixChanMixin, {
  namespace: "api",
  socketHost: "ws://localhost:4000",
  socketNamespace: "ws"
});