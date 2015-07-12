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
      $('.answer_form').after(partial).toggle();
      $('#answer_body').val('');
    }).fail(function(err) {
      console.log(err);
    })
  });

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

$('#up-vote').on('submit', function(event) {
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
      var currentCount = parseInt($("#vote-count-span").text());
      var updatedCount = currentCount += 1;
      $('#vote-count-span').text(updatedCount.toString());
     }).fail(function(err) {
      console.log(err);
     })

   });

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
      var currentCount = parseInt($("#vote-count-span").text());
      var updatedCount = currentCount -= 1;
        $('#vote-count-span').text(updatedCount.toString());
     }).fail(function(err) {
      console.log(err);
     })

   });

//answers votes ajax

$('#up-vote-answer').on('submit', function(event) {
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
      console.log("done")
      var currentCount = parseInt($("#vote-count-answer-span").text());
      var updatedCount = currentCount += 1;
      $("#vote-count-answer-span").text(updatedCount.toString());
     }).fail(function(err) {
      console.log(err);
     })

   });

  $('#down-vote-answer').on('submit', function(event) {
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
      var currentCount = parseInt($("#vote-count-answer-span").text());
      var updatedCount = currentCount -= 1;
        $("#vote-count-answer-span").text(updatedCount.toString());
     }).fail(function(err) {
      console.log(err);
     })

   });

});