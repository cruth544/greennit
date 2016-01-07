$(function() {
  $(".upvotes").click(function (event) {
    $.ajax("2/upvote")
  })
})
