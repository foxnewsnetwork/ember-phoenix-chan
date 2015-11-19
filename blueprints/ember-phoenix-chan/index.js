var RSVP = require('rsvp');

module.exports = {
  description: 'grabs phoenix from github',

  normalizeEntityName: function() {},

  afterInstall: function() {
    return RSVP.all([
      this.addBowerPackagesToProject('phoenixframework/phoenix#v1.0.3')
    ]);
  }
}