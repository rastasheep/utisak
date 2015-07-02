window.Posts ?= {}
window.UtisakApiUrl = "https://demo9565267.mockable.io"

angular
  .module("postsApp", ["yaru22.angular-timeago"])
  .factory("HttpInterceptor", ["$q", "$rootScope", Posts.HttpInterceptor])
  .config(Posts.HttpInterceptorConfig)
  .factory("PostsFactory", ["$http", "$q", Posts.PostsFactory])
  .controller("PostsController", ["PostsFactory", "$location", "$scope", Posts.PostsController])
  .controller("CategoriesController", ["PostsFactory", Posts.CategoriesController])
  .filter("urlEncode", [Posts.UrlEncode])
  .directive("shareLink", [Posts.ShareLink])
  .directive("appContent", ["$rootScope", "$document", Posts.AppContent])
  .config [
    "$locationProvider"
    ($locationProvider) ->
      $locationProvider.html5Mode true
      return
  ]
