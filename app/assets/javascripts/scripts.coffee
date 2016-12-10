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
        $('.arrivals-list.old').remove()
        $('.arrivals-list-wrap').css('height', '')
      ), 3000

jQuery(document).ready ($) ->

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
