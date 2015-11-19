module.exports = {
  description: 'grabs phoenix from github',

  normalizeEntityName: function() {},

  afterInstall: function() {
    return this.addBowerPackageToProject('phoenix', 'phoenixframework/phoenix#v1.0.3');
  }
}