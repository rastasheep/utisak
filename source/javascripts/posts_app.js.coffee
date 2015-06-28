window.Posts ?= {}

angular
  .module("postsApp", ["yaru22.angular-timeago"])
  .factory("PostsFactory", ["$http", Posts.PostsFactory])
  .controller("PostsController", ["PostsFactory", Posts.PostsController])
  .filter("urlEncode", [Posts.UrlEncode])
  .directive("shareLink", [Posts.ShareLink])
