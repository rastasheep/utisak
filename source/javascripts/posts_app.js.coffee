window.Posts ?= {}

angular
  .module("postsApp", ["yaru22.angular-timeago"])
  .controller("PostsController", ["$http", Posts.PostsController])
