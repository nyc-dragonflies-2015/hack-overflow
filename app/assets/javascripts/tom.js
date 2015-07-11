$(document).ready(function() {

  $('button').on('click', function(event) {
    event.preventDefault();
    var buttonData = $(event.target);
    buttonData.next().toggle();
  });

  $('#new_answer').on('submit', function(e){
    e.preventDefault();
    var target = $(e.target);
    console.log(target);
    var data = target.serialize();
    var body = target.find('#answer_body').val();
    var questionId = target.find('#answer_question_id').val();
    console.log(data);
    $.ajax({
      url: '/answers',
      method: 'post',
      data: {answer: {body: body, question_id: questionId}},
      dataType: "json"
    }).done(function(data) {
      var body = data.answer.body
      var username = data.username
      var partial = ""
      partial += "<p>" + body + "<p>";
      partial += "<p>" + username + "<p>";
      $('.answer_form').after(partial);
    }).fail(function(err) {
      console.log(err);
    })
  });
});