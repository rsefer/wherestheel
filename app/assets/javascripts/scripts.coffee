updateArrivals = ->
  $('.arrivals-list').removeClass('new').addClass 'old'
  $.ajax
    url: '/update_station_arrivals?id=' + $('.station').data('station-id')
    success: ->
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

jQuery(document).on 'turbolinks:load', ->

  $('.get-nearest-link').click ->
    if navigator.geolocation
      $('.nearest-station-wrap').html('<div class="finding-nearest-station">Finding Nearest Station...</div>')
      navigator.geolocation.getCurrentPosition ((position) ->
        $.ajax
          url: '/find_nearest_station?lat=' + position.coords.latitude + '&lng=' + position.coords.longitude
      ), (error) ->
        $('.nearest-station-wrap').html('Unable to find location.')

  $('.route-title').click ->
    if $(this).parent().hasClass('active')
      $(this).parent().removeClass 'active'
    else
      $(this).parent().addClass 'active'
      $('html, body').animate { scrollTop: $(this).offset().top }, 300

  if $('body').hasClass('station')
    $.ajax
      url: '/display_alerts?id=' + $('.station').data('station-id')
      success: ->
        setTimeout (->
          $('.alert-toggle').addClass 'loaded'
        ), 500
    setInterval updateArrivals, 30 * 1000
    $('.arrival').click ->
      $(this).toggleClass 'active'
