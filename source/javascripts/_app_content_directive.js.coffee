window.Posts ?= {}

window.Posts.AppContent = ->
  {
    restrict: 'A'
    link: ($rootScope, $document) ->
      body = angular.element(document).find("body")
      $rootScope.$on "loading:finish", ->
        body.attr("class", "")
      $rootScope.$on "loading:error", ->
        body.attr("class", "")
        body.attr("class", "page-error")
  }
