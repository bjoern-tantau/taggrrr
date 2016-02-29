# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery.ajaxSetup { cache: true }
$ ->
  # Configure infinite table
  $('.images').infinitePages
    # debug: true
    loading: ->
      $(this).text('Loading next page...')
    error: ->
      $(this).button('There was an error, please try again')
  $(window).bind 'popstate', (event) ->
    if window.statereplaced
      if event.originalEvent.state.body
        $('body').html event.originalEvent.state.body
      else
        window.location.reload()
  $(document).on 'click', 'a[data-url]', ->
    window.history.replaceState null, null, $(this).data 'url'
