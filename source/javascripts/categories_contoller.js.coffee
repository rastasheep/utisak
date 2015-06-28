window.Posts ?= {}

window.Posts.CategoriesController = (PostsFactory) ->
  vm = this
  vm.categories = []

  vm.init = (url) ->
    vm.postsFactory = new PostsFactory(url)
    vm.postsFactory.getCategories().then ->
      vm.categories = vm.categories.concat(vm.postsFactory.categories)
      return

  return vm
