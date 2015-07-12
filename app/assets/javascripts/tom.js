$(document).ready(function() {


  // display hidden forms
  $('button').on('click', function(event) {
    event.preventDefault();
    var buttonData = $(event.target);
    buttonData.next().toggle();
  });

  // AJAX call to create an answer and display it
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
      $('.answer_form').after(partial).toggle();
      $('#answer_body').val('');
    }).fail(function(err) {
      console.log(err);
    })
  });

  // AJAX call to create a comment and display it
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var target = $(e.target);
    var data = target.serialize();
    var body = target.find('#comment_body').val();
    var userId = target.find('#comment_commentable_id').val();
    var commentable_type = target.find('#comment_commentable_type').val();
    var commentable_id = target.find('#comment_commentable_id').val();
    $.ajax({
      url: '/comments',
      method: 'post',
      data: {comment: {body: body, user_id: userId, commentable_type: commentable_type, commentable_id: commentable_id}},
      dataType: "json"
    }).done(function(data) {
      var body = data.comment.body
      var username = data.username
      var partial = ""
      partial += "<p>" + body + "<p>";
      partial += "<p>" + username + "<p>";
      $('#question-comment-button').before(partial);
      $('.question-comment-form').toggle();
      $('#comment_body').val('');
    }).fail(function(err) {
      console.log(err);
    })
  });

  // AJAX call to comment on an answer and display in the DOM
  $('.answer-comment-form').on('submit', function(e){
    e.preventDefault();
    var target = $(e.target);
    var data = target.serialize();
    var body = target.find('#comment_body').val();
    var userId = target.find('#comment_commentable_id').val();
    var commentable_type = target.find('#comment_commentable_type').val();
    var commentable_id = target.find('#comment_commentable_id').val();
    $.ajax({
      url: '/comments',
      method: 'post',
      data: {comment: {body: body, user_id: userId, commentable_type: commentable_type, commentable_id: commentable_id}},
      dataType: "json"
    }).done(function(data) {
      var body = data.comment.body
      var username = data.username
      var partial = ""
      partial += "<p>" + body + "<p>";
      partial += "<p>" + username + "<p>";
      $('#answer-comment-' + data.comment.commentable_id.toString()).after(partial).toggle();
      // TOM SAVE US SOMETHING WRONG WITH CLEARING THE FIELD
      $('#comment_body').val('');
    }).fail(function(err) {
      console.log(err);
    })
  });


  $('.enlarge').mouseover(function() {
    $(this).animate({ fontSize : '22px' });
  }),

  $('.enlarge').mouseleave(function() {
    $(this).animate({ fontSize : '20px' });
  });


// VOTING
// upvote on a question

$('#up-vote').on('submit', function(event) {
     event.preventDefault();
     var target = $(event.target);
     var userId = target.find('#vote_user_id').val();
     var value = target.find('#vote_value').val();
     var voteableType = target.find('#vote_voteable_type').val();
     var voteableId = target.find('#vote_voteable_id').val();

     $.ajax({
       url: '/votes',
       method: 'post',
       data: {vote: {user_id: userId, value: value, voteable_type: voteableType, voteable_id: voteableId}},
       dataType:"json"
     }).done(function(data) {
      $('#vote-count-span').text(data);
     }).fail(function(err) {
      console.log(err);
     })

   });

  // downvote on a question
  $('#down-vote').on('submit', function(event) {
     event.preventDefault();
     var target = $(event.target);
     var data = target.serialize();
     var userId = target.find('#vote_user_id').val();
     var value = target.find('#vote_value').val();
     var voteableType = target.find('#vote_voteable_type').val();
     var voteableId = target.find('#vote_voteable_id').val();
     $.ajax({
       url: '/votes',
       method: 'post',
       data: {vote: {user_id: userId, value: value, voteable_type: voteableType, voteable_id: voteableId}},
       dataType:"json"
     }).done(function(data) {
        $('#vote-count-span').text(data);
        console.log("QUESTION VOTE");
     }).fail(function(err) {
      console.log(err);
     })
   });

//upvote on an answer
$(".up-vote-answer-form").on('submit', function(event) {
     event.preventDefault();
     var target = $(event.target);
     var userId = target.find('#vote_user_id').val();
     var value = target.find('#vote_value').val();
     var voteableType = target.find('#vote_voteable_type').val();
     var voteableId = target.find('#vote_voteable_id').val();
     $.ajax({
       url: '/votes',
       method: 'post',
       data: {vote: {user_id: userId, value: value, voteable_type: voteableType, voteable_id: voteableId}},
       dataType:"json"
     }).done(function(data) {
      target.parent().parent().children().find('#vote-count-answer-span').html(data);
     }).fail(function(err) {
      console.log(err);
     });

   });

  // downvote on an answer
  $('.down-vote-answer-form').on('submit', function(event) {
     event.preventDefault();
     var target = $(event.target);
     var data = target.serialize();
     var userId = target.find('#vote_user_id').val();
     var value = target.find('#vote_value').val();
     var voteableType = target.find('#vote_voteable_type').val();
     var voteableId = target.find('#vote_voteable_id').val();
     $.ajax({
       url: '/votes',
       method: 'post',
       data: {vote: {user_id: userId, value: value, voteable_type: voteableType, voteable_id: voteableId}},
       dataType:"json"
     }).done(function(data) {
      target.parent().parent().children().find('#vote-count-answer-span').html(data);
     }).fail(function(err) {
      console.log(err);
     })
   });

});