$(document).ready(function() {
  $('button').on('click', function(event) {
    event.preventDefault();
    var buttonData = $(event.target);
    buttonData.next().toggle();
  })
});