window.Posts ?= {}

window.Posts.ShareLink = ->
  {
    restrict: "A",
    link: (scope, element, attribute) ->
      element.bind "click", (e) ->
        e.preventDefault()
        width = 500
        height = 300
        left = screen.width / 2 - (width / 2)
        top = screen.height / 3 - (height / 2)
        options = 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,width=' + width + ',height=' + height + ',top=' + top + ',left=' + left
        window.open attribute.shareLink, '', options
        return
  }
