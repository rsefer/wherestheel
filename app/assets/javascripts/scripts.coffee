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
          return
        ), 1000
        return
      setTimeout (->
        $('.arrivals-list.old').remove()
        $('.arrivals-list-wrap').css('height', '')
        return
      ), 3000
  return

jQuery(document).ready ($) ->

  if $('body').hasClass('station')
    setInterval updateArrivals, 30 * 1000
    $('.arrival').click ->
      $(this).toggleClass 'active'
      return
    return
  return
