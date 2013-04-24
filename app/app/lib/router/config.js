
App.Router.map(function() {
  this.resource("route1", function() {
    this.route("index");
    this.route("show");
  });
  this.resource("route2");
});
/*
App.Route = Ember.Route.extend({

});

App.Route1Router = App.Route.extend({

});

App.Route2Router = App.Route.extend({

});
*/
