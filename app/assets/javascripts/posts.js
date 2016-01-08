$(function() {
  $(".upvotes").click(function (event) {
    $.ajax("2/upvote")
  })
  $('video').on("mouseenter", function (event) {
    event.target.play()
  })
  $('video').on("mouseleave", function (event) {
    event.target.pause()
    event.target.currentTime = 0
  })
})

$('video').on('ended', function () {
  this.load();
  this.play();
})

