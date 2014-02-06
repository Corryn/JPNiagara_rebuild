function deleteEvent(event_id) {
	if ( confirm( "Are you sure you want to delete this event?" ) ) {
		new Effect.SlideUp('event-'+event_id);
	} else {
		alert("NOT DELETING");
	}
};