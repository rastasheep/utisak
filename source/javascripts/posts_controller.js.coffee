window.Posts ?= {}

window.Posts.PostsController = (PostsFactory) ->
  vm = this
  vm.currentPage = 1
  vm.loading = false
  vm.posts = []

  vm.init = (url) ->
    vm.postsFactory = new PostsFactory(url)
    loadPosts()

  vm.nextPage = ->
    return if vm.loading
    vm.currentPage += 1
    loadPosts()

  vm.published_at = (post) ->
    new Date(post.published_at*1000).toISOString()

  vm.share = (post) ->
    post.sharing = !post.sharing

  loadPosts = ->
    vm.loading = true
    vm.postsFactory.getPosts(vm.currentPage).then ->
      vm.posts = vm.posts.concat(vm.postsFactory.posts)
      vm.loading = !vm.loading
      return

  return vm
