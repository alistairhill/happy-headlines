$(document).ready(function() {
  $('#sports_link').on('click', sportsPage);
  $('#home_link').on('click', homePage);

  $('.story-more').on('click', 'button', function() {
    $(this).closest('.story-more').find('.ticket').slideToggle()
  })


});

var sportsPage = function(event) {
  event.preventDefault()

  var ajaxRequest = $.ajax({
    url: event.target.href,
    type: 'GET'
  })
  ajaxRequest.done(appendSportsArticles)
}

var appendSportsArticles = function(response) {
  $('.home_page').remove()
  $('.sports_page').remove()
  $('.container').append(response)
}

var homePage = function(event) {
  event.preventDefault();
  console.log(event.target.href)

  var ajaxRequest = $.ajax({
    url: event.target.href,
    type: 'GET'
  })
  ajaxRequest.done(appendHomePage)
}

var appendHomePage = function(response) {
  $('.home_page').remove()
  $('.sports_page').remove()
  $('.container').append(response)
}
