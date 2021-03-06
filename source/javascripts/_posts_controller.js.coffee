window.Posts ?= {}

window.Posts.PostsController = (PostsFactory, $location, $scope) ->
  vm = this
  vm.posts = []
  vm.wordsPerMin = 250
  vm.initializing = false
  vm.loading = false
  vm.morePages = true
  vm.sort = "top"

  initFactory = (filter) ->
    PostsFactory.setOptions(sort: vm.sort, filter: filter)
    loadPosts(init: true, page: 1)

  initSort = ->
    if $location.search().newest
      vm.sort = "newest"
    else
      vm.sort = "top"
      vm.setSort("")

  $scope.$on "$locationChangeSuccess", ->
    filter = $location.hash().split(",")
    return if _searchActive(filter)
    initSort()
    initFactory(filter)

  vm.nextPage = ->
    return if vm.loading
    loadPosts(page: vm.currentPage + 1)

  vm.setSort = (sort) ->
    $location.search(sort)

  vm.publishedAt = (post) ->
    new Date(post.published_at).toISOString()

  vm.readTime = (post) ->
    Math.round(post.word_count / vm.wordsPerMin)

  vm.share = (post) ->
    post.sharing = !post.sharing

  loadPosts = (options = {}) ->
    vm.initializing = options.init ? false
    vm.currentPage = options.page
    vm.loading = true

    PostsFactory.fetchPosts(vm.currentPage).then ( ->
      posts = PostsFactory.posts
      vm.morePages = !(posts.length < 20)
      vm.posts = if vm.initializing then posts else vm.posts.concat(posts)
      vm.loading = !vm.loading
      return
    ), (reason) ->
      $location.hash("") if reason == "CNF"

  _searchActive = (query) ->
      query.join(",").indexOf("stq=") != -1

  return vm
