var currentImage = 1;

function changeImage(divID,parkID,picNum) {

//	alert( "picnum is " + picNum + ' and current image is ' + currentImage );
	if ( picNum != currentImage ) { 
		var url = '/utils/getImageCode?park_id=' + encodeURIComponent(parkID) + '&picNum=' + encodeURIComponent(picNum);
		//var url = 'http://www.bookyoursite.com';
		// notice the use of a proxy to circumvent the Same Origin Policy.
	
		new Ajax.Request(url, {
	  		method: 'get',
	  		onSuccess: function(transport) {
	    		var notice = $(divID);
		    	notice.update(transport.responseText);
		    	currentImage = picNum;
			},
			onError: function(transport) {
				alert(transport.errorCode);
			}
		});
	}
}
