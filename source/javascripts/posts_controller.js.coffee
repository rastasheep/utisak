window.Posts ?= {}

window.Posts.PostsController = ($http) ->
  vm = this
  vm.currentPage = 1

  vm.init = (url) ->
    vm.url = url
    $http.get("#{url}/posts").success (data) ->
      vm.posts = data.posts

  vm.published_at = (post) ->
    new Date(post.published_at*1000).toISOString()

  return vm
