window.Posts ?= {}

window.Posts.AppContent = ->
  {
    restrict: 'A'
    link: ($rootScope, $document) ->
      class_name = "page-loading"
      body = angular.element(document).find("body")
      body.addClass(class_name)
      $rootScope.$on "loading:finish", ->
        body.removeClass(class_name)
  }
