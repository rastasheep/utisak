window.Posts ?= {}

window.Posts.PostsController = (PostsFactory, $location, $scope) ->
  vm = this
  vm.posts = []
  vm.initializing = false
  vm.loading = false

  initCategory = (category) ->
    PostsFactory.setCategory(category)
    loadPosts(init: true, page: 1)

  $scope.$watch (-> $location.hash()), initCategory

  vm.nextPage = ->
    return if vm.loading
    loadPosts(page: vm.currentPage + 1)

  vm.publishedAt = (post) ->
    new Date(post.published_at).toISOString()

  vm.readTime = (post) ->
    new Date(post.published_at).toISOString()

  vm.share = (post) ->
    post.sharing = !post.sharing

  loadPosts = (options = {}) ->
    vm.initializing = options.init ? false
    vm.currentPage = options.page
    vm.loading = true

    PostsFactory.fetchPosts(vm.currentPage).then ( ->
      posts = PostsFactory.posts
      vm.posts = if vm.initializing then posts else vm.posts.concat(posts)
      vm.loading = !vm.loading
      return
    ), (reason) ->
      $location.hash("") if reason == "CNF"

  return vm
