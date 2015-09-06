window.Posts ?= {}
window.UtisakApiUrl = "http://local.go:8080"

angular
  .module("postsApp", ["yaru22.angular-timeago", "ngSanitize"])
  .factory("HttpInterceptor", ["$q", "$rootScope", Posts.HttpInterceptor])
  .config([
    "$httpProvider"
    Posts.HttpInterceptorConfig
  ])
  .factory("PostsFactory", ["$http", "$q", Posts.PostsFactory])
  .controller("PostsController", ["PostsFactory", "$location", "$scope", Posts.PostsController])
  .controller("CategoriesController", ["PostsFactory", "$location", Posts.CategoriesController])
  .filter("urlEncode", [Posts.UrlEncode])
  .directive("shareLink", [Posts.ShareLink])
  .directive("appContent", ["$rootScope", "$document", Posts.AppContent])
  .config [
    "$locationProvider"
    ($locationProvider) ->
      $locationProvider.html5Mode true
      return
  ]
