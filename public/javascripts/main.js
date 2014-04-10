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

function preloadImages(arrayOfImages) {
    $(arrayOfImages).each(function(){
        $('<img/>')[0].src = this;
    });
}

function lightenRGB(r,g,b,l){
    l = l + 1.0;
    r = Math.floor(Math.min(r*l,255));
    g = Math.floor(Math.min(g*l,255));
    b = Math.floor(Math.min(b*l,255));
    return [r,g,b];
}

function lightenHex(hex,l){
    hex = hex.replace("#","");
    
    console.log("0x" + hex.substr(0,2));
    console.log("0x" + hex.substr(2,2));
    console.log("0x" + hex.substr(4,2));
    
    r = parseInt("0x" + hex.substr(0,2));
    g = parseInt("0x" + hex.substr(2,2));
    b = parseInt("0x" + hex.substr(4,2));
    
    console.log(r);
    console.log(g);
    console.log(b);

    if(l == undefined){
        l = 1.0;
    } else {
        l = l + 1.0;
    }

    r = Math.floor(Math.min(r*l,255));
    g = Math.floor(Math.min(g*l,255));
    b = Math.floor(Math.min(b*l,255));
    
    console.log(r);
    console.log(g);
    console.log(b);

    r = r.toString(16);
    g = g.toString(16);
    b = b.toString(16);

    if(r.length == 1){
        r = "0" + r;
    }
    if(g.length == 1){
        g = "0" + g;
    }
    if(b.length == 1){
        b = "0" + b;
    }

    console.log(r);
    console.log(g);
    console.log(b);

    return "#" + r + g + b;
}