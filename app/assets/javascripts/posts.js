$(function() {
  $(".upvotes").click(function (event) {
    $.ajax("2/upvote")
  })
})

$('video').on('ended', function () {
  this.load();
  this.play();
})
