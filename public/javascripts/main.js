function showElement(id) {
	document.getElementById(id).style.visibility = 'visible'; 
}

function hideElement(id) {
	document.getElementById(id).style.visibility = 'hidden';
}

/* Reservation box animation */

function toggleReservation () {
	$("#reservation").unbind("click");
	$("#BYSframe").slideToggle(1000,function(){
		$("#reservation").bind('click',toggleReservation);
	});
}
	
function disableSelection(target) { // Function by Abinash Grahachrya of mindfiresolutions.com
    //For IE This code will work
    if (typeof target.onselectstart!="undefined") {
    target.onselectstart=function(){return false};
	}
    //For Firefox This code will work
    else if (typeof target.style.MozUserSelect!="undefined") {
    target.style.MozUserSelect="none";
 	}
    //All other  (ie: Opera) This code will work
    else {
    target.onmousedown=function(){return false};
    target.style.cursor = "default";
	}
}