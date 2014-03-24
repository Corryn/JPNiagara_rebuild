function parseXML(s) {
	var count = 0;
	var tag = "";
	while(s.charAt(count) != "") {
		if(s.charAt(count) == '<') {
			count++;
			while(s.charAt(count) != '>') {
				tag = tag + s.charAt(count);
				count++;
			}
		}
		count++;
		alert(tag);
	}
}