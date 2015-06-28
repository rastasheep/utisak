window.Posts ?= {}

angular
  .module("postsApp", ["yaru22.angular-timeago"])
  .factory("HttpInterceptor", ["$q", "$rootScope", Posts.HttpInterceptor])
  .config(Posts.HttpInterceptorConfig)
  .factory("PostsFactory", ["$http", Posts.PostsFactory])
  .controller("PostsController", ["PostsFactory", Posts.PostsController])
  .controller("CategoriesController", ["PostsFactory", Posts.CategoriesController])
  .filter("urlEncode", [Posts.UrlEncode])
  .directive("shareLink", [Posts.ShareLink])
  .directive("appContent", ["$rootScope", "$document", Posts.AppContent])
