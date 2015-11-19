module.exports = {
  description: 'grabs phoenix from github',

  normalizeEntityName: function() {},

  afterInstall: function() {
    return this.addBowerPackageToProject('phoenixframework/phoenix', '~1.0.3');
  }
}