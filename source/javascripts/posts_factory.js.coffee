window.Posts ?= {}

window.Posts.PostsFactory = ($http)->

  PostsFactory = (apiUrl) ->
    @apiUrl = apiUrl
    [@posts, @categories] = [[],[]]
    return

  PostsFactory::getPosts = (page) ->
    self = this
    pageParams = ""
    pageParams = "?page=#{page}" if page != 1
    url = @apiUrl + "/posts" + pageParams

    $http({method: "GET", cache: true, url: url}).then (response) ->
      self.posts = response.data.posts
      self.categories = response.data.categories
      # promises success should always return something in order to allow chaining
      response

  PostsFactory
