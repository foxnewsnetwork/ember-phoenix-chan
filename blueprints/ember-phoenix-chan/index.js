var RSVP = require('rsvp');

module.exports = {
  normalizeEntityName: function() {},

  afterInstall: function() {
    return RSVP.all([
      this.addBowerPackagesToProject('phoenixframework/phoenix', '~1.0.3')
    ]);
  }
}