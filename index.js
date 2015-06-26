/* jshint node: true */
'use strict';

module.exports = {
  name: 'ember-ddp',
  included: function included(app) {
    this._super.included(app);

    this.app.import(app.bowerDirectory + '/ddp.js/src/ddp.js');
  }
};
