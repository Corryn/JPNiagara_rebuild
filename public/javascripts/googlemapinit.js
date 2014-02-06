function mapper (lat,lon,zoom) {
 
  var map_canvas = document.getElementById('map_canvas');
  myLocation = new google.maps.LatLng (lat,lon);
  var map_options = {
          center: myLocation,
          zoom: zoom,
          mapTypeId: google.maps.MapTypeId.ROADMAP
      }
      map = new google.maps.Map(map_canvas, map_options)
}



function initialize() {
      
    var marker;

    function show_map(position) {
        
      var latitude = position.coords.latitude;
      var longitude = position.coords.longitude;

      document.getElementById("search_userlatitude").value= latitude;
      document.getElementById("search_userlongitude").value= longitude;

      mapper(position.coords.latitude, position.coords.longitude,9);

      marker = new google.maps.Marker({map: map, position: myLocation});
      marker.setIcon("http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png");
      marker.setTitle ("You are here");

      $('form#searchForm').trigger('submit.rails'); //loads an initial set of parks.
    
    }
    function handle_error(err) { //user did not provide location
        
        mapper(43.834527,-101.439514,3);
        $('form#searchForm').trigger('submit.rails'); //loads an initial set of parks.
    }
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(show_map, handle_error);
    } else {
        mapper(43.834527,-101.439514,3);
        $('form#searchForm').trigger('submit.rails'); //loads an initial set of parks.
    }

    
}

google.maps.event.addDomListener(window, 'load', initialize);


  

    