window.Posts ?= {}

window.Posts.PostsController = ($http) ->
  vm = this
  vm.currentPage = 1
  vm.loading = false

  vm.init = (url) ->
    vm.url = url
    fullUrl = "#{vm.url}/posts"
    fullUrl += "?page=#{vm.currentPage}" if vm.currentPage != 1

    $http.get(fullUrl).success (data) ->
      vm.posts = data.posts

  vm.published_at = (post) ->
    new Date(post.published_at*1000).toISOString()

  vm.nextPage = ->
    return if vm.loading
    vm.loading = true
    vm.currentPage += 1

    fullUrl = "#{vm.url}/posts"
    fullUrl += "?page=#{vm.currentPage}" if vm.currentPage != 1

    $http.get(fullUrl).success (data) ->
      vm.posts = vm.posts.concat(data.posts)
      vm.loading = false

  return vm
