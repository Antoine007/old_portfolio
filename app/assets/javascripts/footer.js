
$(document).ready(function(){
  for (i = 1; i < 5; i++) {
    setTimeout(function(){
      $('fa:nth-child(i)').css("class","pulse");
    }, 500);
  };
});
