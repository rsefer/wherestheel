updateArrivals = ->
  $('.arrivals-list').removeClass('new').addClass 'old'
  stationID = $('.station').data('station-id')
  $.ajax
    url: '/update_station_arrivals?id=' + stationID
    complete: ->
      $('.arrivals-list.old').each ->
        oldHeight = $(this).outerHeight()
        $(this).parent().css 'height', oldHeight
        $(this).addClass 'updating'
        thisList = $(this)
        setTimeout (->
          thisList.addClass 'updated'
        ), 1000
      setTimeout (->
        $('.arrivals-list-wrap').css('height', 'auto')
      ), 2000
      setTimeout (->
        $('.arrivals-list.old').remove()
      ), 3000

jQuery(document).ready ($) ->

  $('.get-nearest-link').click ->
    if navigator.geolocation
      $('.nearest-station-wrap').html('<div class="finding-nearest-station">Finding Nearest Station...</div>')
      navigator.geolocation.getCurrentPosition ((position) ->
        $.ajax
          url: '/find_nearest_station?lat=' + position.coords.latitude + '&lng=' + position.coords.longitude
          complete: ->
            console.log 'complete'
      ), (error) ->
        $('.nearest-station-wrap').html('Unable to find location.')

  $('.route-title').click ->
    if $(this).parent().hasClass('active')
      $(this).parent().removeClass 'active'
    else
      $(this).parent().addClass 'active'
      $('html, body').animate { scrollTop: $(this).offset().top }, 300

  if $('body').hasClass('station')
    setInterval updateArrivals, 30 * 1000
    $('.arrival').click ->
      $(this).toggleClass 'active'
