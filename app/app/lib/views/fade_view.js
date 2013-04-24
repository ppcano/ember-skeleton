var get = Ember.get, set = Ember.set;

//https://github.com/billysbilling/ember-animated-outlet/blob/master/src/sass/effects/_fade.scss
App.FadeView = Ember.ContainerView.extend({

  classNames: ['animated-outlet'],

  outletName: null,
  outletContent: null,

  init: function () {
    this._super();
    this._outletContentAfter();
  },

  _outletContentAfter: Em.observer(function() {

    var newContent = get(this, 'outletContent');
    if (newContent) {

      var newView = Em.ContainerView.create({

        classNames: ['fade-container'],
        classNameBindings: ['isOut'],
        isOut: false,

        currentView: newContent,
        transitionEnd: function() {
          this.removeFromParent();
        }
      });

      var oldView = this.objectAt(0);
      if (oldView) {
        set(oldView, 'isOut', true);
      }
      this.pushObject(newView);
    }
  }, 'outletContent')

});
