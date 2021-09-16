$(window).on('turbolinks:load', function(){
  $("#spock").on('click', function(){
    var $div = $("#secret");
    $div.addClass("reveal");
    $div.on('webkitAnimationEnd', function(){
      $div.removeClass("reveal");
    });
  });
});