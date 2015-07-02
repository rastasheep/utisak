window.Posts ?= {}

window.Posts.CategoriesController = (PostsFactory) ->
  vm = this
  vm.categories = []

  vm.init = ->
    PostsFactory.fetchCategories().then ->
      vm.categories = PostsFactory.categories
      return

  return vm
