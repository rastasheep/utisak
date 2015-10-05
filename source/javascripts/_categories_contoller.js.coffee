window.Posts ?= {}

window.Posts.CategoriesController = (PostsFactory, $location) ->
  vm = this
  vm.categories = []

  vm.init = ->
    PostsFactory.fetchCategories().then ->
      vm.categories = PostsFactory.categories
      return

  vm.emptyFilter = ->
    !PostsFactory.filterPresent()

  vm.activeCategory = (category) ->
    _.include(PostsFactory.filter, category.slug)

  vm.openCategory = (category) ->
    window._scrollTo('header', 200)
    $location.hash(category.slug)

  vm.pinnable = (category) ->
    PostsFactory.filterPresent() &&
      !@activeCategory(category)

  vm.unpinnable = (category) ->
    PostsFactory.filterPresent() &&
      @activeCategory(category)

  vm.unpinCategpry = (category) ->
    _.remove(PostsFactory.filter, (el) -> el == category.slug).join(",")
    newCategories = PostsFactory.filter.join(",")
    $location.hash(newCategories)

  vm.pinCategpry = (category) ->
    PostsFactory.filter.push(category.slug)
    newCategories = PostsFactory.filter.join(",")
    $location.hash(newCategories)

  return vm
