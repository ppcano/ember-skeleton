
App.Router.map(function() {
  this.route("route1");
  this.route("route2");
});

App.Route = Ember.Route.extend({

  renderTemplate: function() {
    console.log('rendering template');
    this.render();
  }

});

App.Route1Router = App.Route.extend({

});

App.Route2Router = App.Route.extend({

});
