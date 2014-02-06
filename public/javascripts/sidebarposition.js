//this function sticks the fixed sidebar to the top if scrolled past it or under the header if it isn't hidden yet
$(window).scroll(function(){
  if ($(document).height() > $(window).height() && $('#mid-content').outerHeight() > $('#right-bar').outerHeight()) { //only use the function if page is scrollable

    if ($('#right-bar').outerHeight() + $(window).scrollTop() - $('#header').outerHeight(true) > $('#mid-content').outerHeight()){ //hidden body + height of right > whole body --> stick to bottom
     $('#right-bar').css({
            'top':($('#mid-content').outerHeight() - $('#right-bar').outerHeight()) + "px",
      });
    }
    else if($(window).scrollTop() > $('#header').outerHeight(true)){ //if we've scrolled past the header, time to stick

      
      $('#right-bar').css({
            'top':($(window).scrollTop() - $('#header').outerHeight(true)) + "px",//outerHeight(true) is height of div with padding,border and margins
      });
    }
    else { //un-stick
      $('#right-bar').css({
            'top':0,
          });
    }
    
  }
});