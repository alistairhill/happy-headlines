$(document).ready(function() {
  $('.sports').on('click', sportsPage);
  $('.stories').on('click', homePage);

  // $('.story-more').on('click', 'button', function() {
  //   $(this).closest('.story-more').find('.unread').slideToggle()
  // })

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

var newsPage = function(event) {
  event.preventDefault();
  console.log(event.target.href)

  var ajaxRequest = $.ajax({
    url: event.target.href,
    type: 'GET'
  })
  ajaxRequest.done(appendNewsPage)
}

var appendNewsPage = function(response) {
  $('.home_page').remove()
  $('.sports_page').remove()
  $('.container').append(response)
}
