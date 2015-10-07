// SLICK SLIDER
$(document).ready(function(){
  var container_width = $('.container').width();
  if (container_width > 400 ){
    var arrowness = true
    $('.full-square-image').height(container_width - 60);
  }else{
    var arrowness = false
    $('.full-square-image').height(container_width);
  }

  $('.auto-rotate').slick({
    arrows: arrowness,
    dots: true,
    infinite: true,
    speed: 500,
    fade: true,
    adaptiveHeight: true,
    mobileFirst: true,
    cssEase: 'linear'
  });
});
