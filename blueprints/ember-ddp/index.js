module.exports = {
  normalizeEntityName: function() {
    // this prevents an error when the entityName is
    // not specified (since that doesn't actually matter
    // to us)

    // I don't even know if this is useful to me,
    // but I'm just copy-and-pasting from emberfire's
    // blueprints, so whatever
  },
  afterInstall: function() {
    return this.addBowerPackagesToProject([ {name: 'ddp.js', target: "~0.6.0"} ]);
  }
};