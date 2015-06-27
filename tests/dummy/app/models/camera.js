import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr("string"),
  digits: DS.attr("number"),
  address: DS.attr("string"),
  insertedAt: DS.attr("date"),
  updatedAt: DS.attr("date")
});