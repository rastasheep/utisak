window.Posts ?= {}

window.Posts.PostsFactory = ($http, $q)->

  fetchPosts = (page) ->
    params = {}
    angular.extend(params, {category: @filter.join(",")}) if @filterPresent()
    angular.extend(params, {page: page}) if page != 1
    angular.extend(params, {sort: @sort}) if @sort != "top"

    $http({method: "GET", cache: true, url: PostsFactory.url, params: params}).then (response) =>
      @posts = response.data.posts
      @categories = response.data.categories
      return $q.reject("CNF") unless _categoryExists(@categories, @filter)
      response

  fetchCategories = ->
    $http({method: "GET", cache: true, url: PostsFactory.url}).then (response) =>
      @categories = response.data.categories
      response

  setOptions = (options = {}) ->
    @sort = options.sort
    @filter = _.without(options.filter, "").sort()

  filterPresent = ->
    !_.isEmpty(@filter)

  _categoryExists = (categories, category) ->
    return true if _.isEmpty(category)
    !_.isEmpty(_.intersection(_.pluck(categories, 'slug'), category))

  PostsFactory =
    url: window.UtisakApiUrl
    posts: @posts
    categories: @categories
    filter: @filter
    filterPresent: filterPresent
    fetchCategories: fetchCategories
    fetchPosts: fetchPosts
    setOptions: setOptions
