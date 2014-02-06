// show contact page

contact=document.getElementById("contact_page");
bug=document.getElementById("bug_report_page");
faq=document.getElementById("FAQ_page");
demo=document.getElementById("demo_page");
pics=document.getElementById("pics_page");

function showContact(){
contact.style.visibility="visible";
bug.style.visibility="hidden";;
faq.style.visibility="hidden";;
demo.style.visibility="hidden";;
pics.style.visibility="hidden";;
}

function showBug_Report(){
contact.style.visibility="hidden";;
bug.style.visibility="visible";();
faq.style.visibility="hidden";;
demo.style.visibility="hidden";;
pics.style.visibility="hidden";;
}

function showFAQ(){
contact.style.visibility="hidden";;
bug.style.visibility="hidden";;
faq.style.visibility="visible";();
demo.style.visibility="hidden";;
pics.style.visibility="hidden";;
}

function showDemo(){
contact.style.visibility="hidden";;
bug.style.visibility="hidden";;
faq.style.visibility="hidden";;
demo.style.visibility="visible";();
pics.style.visibility="hidden";;
}

function showPics(){
contact.style.visibility="hidden";;
bug.style.visibility="hidden";;
faq.style.visibility="hidden";;
demo.style.visibility="hidden";;
pics.style.visibility="visible";();
}

function putText(){
var p = document.getElementById("sample");
p.innerHTML="button works"
}

var p;
var yt;
var button;

onYoutubePlayerReady();

function clickContact(){
p = document.getElementById("contact_page").style.visibility="visible";
p = document.getElementById("bug_report_page").style.visibility="hidden";
p = document.getElementById("FAQ_page").style.visibility="hidden";
p = document.getElementById("demo_page").style.visibility="hidden";
p = document.getElementById("pics_page").style.visibility="hidden";
yt = document.getElementById("youtube_embed");
yt.pauseVideo();
}

function clickFAQ(){
p = document.getElementById("contact_page").style.visibility="hidden";
p = document.getElementById("bug_report_page").style.visibility="hidden";
p = document.getElementById("FAQ_page").style.visibility="visible";
p = document.getElementById("demo_page").style.visibility="hidden";
p = document.getElementById("pics_page").style.visibility="hidden";
yt = document.getElementById("youtube_embed");
yt.pauseVideo();
}

function clickBug(){
p = document.getElementById("contact_page").style.visibility="hidden";
p = document.getElementById("bug_report_page").style.visibility="visible";
p = document.getElementById("FAQ_page").style.visibility="hidden";
p = document.getElementById("demo_page").style.visibility="hidden";
p = document.getElementById("pics_page").style.visibility="hidden";
yt = document.getElementById("youtube_embed");
yt.pauseVideo();
}

function clickDemo(){
p = document.getElementById("contact_page").style.visibility="hidden";
p = document.getElementById("bug_report_page").style.visibility="hidden";
p = document.getElementById("FAQ_page").style.visibility="hidden";
p = document.getElementById("demo_page").style.visibility="visible";
p = document.getElementById("pics_page").style.visibility="hidden";
}

function clickPics(){
p = document.getElementById("contact_page").style.visibility="hidden";
p = document.getElementById("bug_report_page").style.visibility="hidden";
p = document.getElementById("FAQ_page").style.visibility="hidden";
p = document.getElementById("demo_page").style.visibility="hidden";
p = document.getElementById("pics_page").style.visibility="visible";
yt = document.getElementById("youtube_embed");
yt.pauseVideo();
}

