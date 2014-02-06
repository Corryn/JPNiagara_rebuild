$(function(){

/*-------------------------------MENU BAR ANIMATION------------------------------------*/
function hideMenu(){
	$('#sidebar_container_wrapper').animate({left: '-202px'},500);;
	$("#sidebar_toggle_img").rotate({duration:750, animateTo:180});
}
function showMenu(){
	$('#sidebar_container_wrapper').animate({left: 0},500);;
	$("#sidebar_toggle_img").rotate({duration:750, animateTo:0});
}

hideMenu();

$('#sidebar_container_wrapper').mouseenter(function(){
	showMenu();
	$(this).clearQueue();
	});
$('#sidebar_container_wrapper').mouseleave(function(){
	hideMenu();
	$(this).clearQueue();
});

//old method is commented out below
// jQuery.fn.extend({
//   slideLeftShow: function() {
//     return this.each(function() {
//       $(this).show('slide', {direction: 'left'}, 500);
//     });
//   },
//   slideLeftHide: function() {
//     return this.each(function() {
//       $(this).hide('slide', {direction: 'left'}, 500);
//     });
//   }
// });
//
// var value = 0; //used to initalize rotation degree for menu arrow
// $("#sidebar_toggle_container").click(function(){
// 	if($('#sidebar_container').is(":visible")) {
// 		$('#sidebar_container').slideLeftHide();
// 		$("#sidebar_toggle_container").animate({left:'-20px'},500);
// 	} else {
// 		$('#sidebar_container').slideLeftShow();
// 		$("#sidebar_toggle_container").animate({left:'180px'},500);
// 	}
// 	value += 180;
// 	$("#sidebar_toggle_img").rotate({duration:750, animateTo:value});
// });
//END: MENU BAR ANIMATION


/*-------------------------------ACTION: SITE NOTICE------------------------------------*/

//SITE NOTICE DELETE CONFIRMATION
$('#delete_kb_btn').click(function(){
	$('#delete_kb_confirm').dialog({autoOpen: true, resizable: false, draggable: false, modal: true, buttons: {
		Delete: function() {
			$('<input type="hidden" name="delete" value="delete">').appendTo("#kb_doc_form");
			$("#kb_doc_form").submit();
		},
		Cancel: function() { $(this).dialog( "close" ); }
	}});
	$('.ui-dialog').css({'top':'80px'});
});
//END: SITE NOTICE DELETE CONFIRMATION


/*-------------------------------ACTION: BANNER IMAGES------------------------------------*/

//SORTABLE BANNER IMAGES
$('#banner_sort').sortable();

$('#save_ban_order_btn').click(function(){
	order = $('#banner_sort').sortable('toArray').toString();
	auth_tok = $('#auth_tok_ban').val();
	$('<form id="dynForm" method="post"><input type="hidden" name="order" value="' + order + '"><input type="hidden" name="authenticity_token" value="' + auth_tok + '"></form>').appendTo("body");
	$("#dynForm").submit();
});
//END: SORTABLE BANNER IMAGES

//BANNER IMAGE EDIT POPUP
//for an existing item
$('.edit_ban_icon').click(function(){
	$('#edit_ban_' + $(this).parent().parent().attr('id')).dialog({autoOpen: true, draggable: false, modal: true});
	$('.ui-dialog').css({'width':'500px' , 'top':'80px' , 'left':'50%' , 'margin-left':'-250px'});
});
//for a new item
$('#add_ban_img_btn').click(function(){
	$('#edit_ban_new').dialog({autoOpen: true, draggable: false, modal: true});
	$('.ui-dialog').css({'width':'500px' , 'top':'80px' , 'left':'50%' , 'margin-left':'-250px'});
});
//END: BANNER IMAGE EDIT POPUP

//BANNER IMAGE DELETE POPUP
$('.delete_ban_icon').click(function(){
	id = $(this).parent().parent().attr('id');
	auth_tok = $('#auth_tok_ban').val();
	$('#delete_ban_confirm').dialog({autoOpen: true, resizable: false, draggable: false, modal: true, buttons: {
		Delete: function() {
			$('<form id="dynForm" method="post"><input type="hidden" name="delete" value="' + id + '"><input type="hidden" name="authenticity_token" value="' + auth_tok + '"></form>').appendTo("body");
			$("#dynForm").submit();
		},
		Cancel: function() { $(this).dialog( "close" ); }
	}});
	$('.ui-dialog').css({'top':'80px'});
});
//END: BANNER IMAGE DELETE POPUP

//PREVENT UPLOADING BOTH PDF AND URL FOR BANNER IMAGE
$('.ban_pdf').change(function(){
	if( $(this).val() != "" ) {
		$('#ban_url_'+ $(this).attr('id').replace(/ban_pdf_/,"")).attr('disabled', 'disabled');
	} else {
		$('#ban_url_'+ $(this).attr('id').replace(/ban_pdf_/,"")).removeAttr('disabled');
	}
});
$('.ban_url').change(function(){
	if( $(this).val() != "" ) {
		$('#ban_pdf_'+ $(this).attr('id').replace(/ban_url_/,"")).attr('disabled', 'disabled');
	} else {
		$('#ban_pdf_'+ $(this).attr('id').replace(/ban_url_/,"")).removeAttr('disabled');
	}
});
//END: PREVENT UPLOADING BOTH PDF AND URL FOR BANNER IMAGE

//DO NOT SEND BANNER URL PARAMETER IF IT IS BLANK
//when editing an existing banner image
$('.ban_submit_update').click(function(){
	urlField = $('#ban_url_'+ $(this).attr('id').replace(/ban_submit_update_/,""));
	form = $('#edit_ban_form_'+ $(this).attr('id').replace(/ban_submit_update_/,""));
	if( urlField.val() == "" || urlField.val() == 'undefined' ) {
		urlField.removeAttr('name');
	}
	form.submit();
});
//when creating a new banner image
$('#ban_submit_new').click(function(){
	if( $('#ban_url_new').val() == "" || $('#ban_url_new').val() == 'undefined' ) {
		$('#ban_url_new').removeAttr('name');
	}
	$('#new_ban_form').submit();
});
//END: DO NOT SEND BANNER URL PARAMETER IF IT IS BLANK


/*-------------------------------ACTION: DOWNLOADS------------------------------------*/

//SORTABLE DOWNLOADS
$('#downloads_sort').sortable();

$('#save_order_btn').click(function(){
	order = $('#downloads_sort').sortable('toArray').toString();
	auth_tok = $('#auth_tok_dl').val();
	$('<form id="dynForm" method="post"><input type="hidden" name="order" value="' + order + '"><input type="hidden" name="authenticity_token" value="' + auth_tok + '"></form>').appendTo("body");
	$("#dynForm").submit();
});
//END: SORTABLE DOWNLOADS


//DOWNLOADABLE ITEM EDIT POPUP
//for an existing item
$('.edit_icon').click(function(){
	$('#edit_dl_' + $(this).parent().parent().attr('id')).dialog({autoOpen: true, draggable: false, modal: true});
	$('.ui-dialog').css({'width':'500px' , 'top':'80px' , 'left':'50%' , 'margin-left':'-250px'});
});
//for a new item
$('#add_dl_btn').click(function(){
	$('#edit_dl_new').dialog({autoOpen: true, draggable: false, modal: true});
	$('.ui-dialog').css({'width':'500px' , 'top':'80px' , 'left':'50%' , 'margin-left':'-250px'});
});
//END: DOWNLOADABLE ITEM EDIT POPUP

//DOWNLOADABLE ITEM DELETE POPUP
$('.delete_icon').click(function(){
	id = $(this).parent().parent().attr('id');
	auth_tok = $('#auth_tok_dl').val();
	$('#delete_dl_confirm').dialog({autoOpen: true, resizable: false, draggable: false, modal: true, buttons: {
		Delete: function() {
			$('<form id="dynForm" method="post"><input type="hidden" name="delete" value="' + id + '"><input type="hidden" name="authenticity_token" value="' + auth_tok + '"></form>').appendTo("body");
			$("#dynForm").submit();
		},
		Cancel: function() { $(this).dialog( "close" ); }
	}});
	$('.ui-dialog').css({'top':'80px'});
});
//END: DOWNLOADABLE ITEM DELETE POPUP


/*-------------------------------ACTION: KNOWLEDGEBASE------------------------------------*/

//KB CONTENT INPUT FOR MEDIA TYPE
$('input:radio[name="add[media_type]"]').change(function(){
	$('.kb_doc_content').hide();
	$('#kb_' + $('input:radio[name="add[media_type]"]:checked').val() + '_content').show();
});
//END: KB CONTENT INPUT FOR MEDIA TYPE

//KB ADD NEW GROUP
$('#edit_doc_group, #add_doc_group').change(function(){
	if ( $('#new_group_option').attr('selected') == 'selected' ){
		$('#new_group_container').dialog({autoOpen: true, resizable: false, draggable: false, modal: true, buttons: {
			Cancel: function() {
				$("option:selected").removeAttr("selected");
				$(this).dialog( "close" );
			},
			Add: function() {
				newGroup = $('#new_group_input').val();
				$("option:selected").removeAttr("selected");
				$('<option value="'+newGroup+'" selected>'+newGroup+'</option>').insertBefore($('#new_group_option'));
				$(this).dialog( "close" );
			}
		}});
		$('.ui-dialog').css({'top':'80px'});
	}
});
//END: KB ADD NEW GROUP

});