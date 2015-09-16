window.scrollTo = (elementId, duration) ->
  return if duration < 0
  to = document.getElementById(elementId).offsetTop
  scrollTop = document.body.scrollTop + document.documentElement.scrollTop
  perTick = (to - scrollTop) / duration * 10
  setTimeout (->
    scrollTop = scrollTop + perTick
    document.body.scrollTop = scrollTop
    document.documentElement.scrollTop = scrollTop
    return if scrollTop == to
    scrollTo elementId, duration - 10
  ), 10
