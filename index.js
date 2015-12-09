var esTranspiler = require('broccoli-babel-transpiler');
var Funnel = require('broccoli-funnel');
var MergeTrees = require('broccoli-merge-trees');
var path = require("path");

/* jshint node: true */
'use strict';

module.exports = {
  name: 'ember-phoenix-chan',
  included: function included(app) {
    this._super.included.apply(this, arguments);
    if (typeof app.import !== 'function' && app.app) {
      app = app.app;
    }
    this.app = app;
    this.importDependencies(app);
  },
  importDependencies: function importDependencies(app) {
    var phoenix = path.join('ember-phoenix-chan', 'phoenix.js');
    // app.import(phoenix);  
    app.import(phoenix, {
      exports: ["Channel", "Socket", "LongPoll", "Ajax"]
    });
  },
  mergePhoenix: function mergePhoenix(tree) {
    var vendor = this.treePaths.vendor;
    var phoneixFiles = new Funnel(path.join(this.app.bowerDirectory, "/phoenix/web/static/js"), {
      destDir: "ember-phoenix-chan"
    });
    var scriptTree = esTranspiler(phoneixFiles, {
      stage: 0,
      moduleIds: true
    });
    return MergeTrees([scriptTree, tree]);
  },
  preprocessTree: function preprocessTree(type, tree) {
    if (type === "js") {
      return this.mergePhoenix(tree);
    }
    return tree;
  }
};