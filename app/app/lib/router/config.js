
App.Router.map(function() {
  this.resource("route1", function() {
    this.route("index");
    this.route("show");
  });
  this.resource("route2");
  this.resource("error");

});

App.ErrorRoute = Ember.Route.extend({

});
/*
App.Route = Ember.Route.extend({

});

App.Route1Router = App.Route.extend({

});

App.Route2Router = App.Route.extend({

});
*/
