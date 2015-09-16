window.Posts ?= {}

window.Posts.CategoriesController = (PostsFactory, $location) ->
  vm = this
  vm.categories = []

  vm.init = ->
    PostsFactory.fetchCategories().then ->
      vm.categories = PostsFactory.categories
      return

  vm.activeCategory = (category) ->
    PostsFactory.category == category.slug

  vm.openCategory = (category) ->
    window.scrollTo('header', 200)
    $location.hash(category.slug)

  return vm
