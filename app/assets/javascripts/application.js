// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
	if ($('#notice') && !$('#notice').hasClass('warning')) {
		setTimeout(function(){ 
			$('#notice').slideUp();
		}, 2000);
	}
	
	$(".toggable").each(function(){
		if($(this).children('input').attr('checked') != 'checked') {
			group = $(this).attr('data-group');
			$('div[data-group='+group+']:not(.toggable)').hide();
		}
	});
	
	$(".toggable input").click(function(){
		group = $(this).parent('div').attr('data-group');
		if($(this).attr('checked') != 'checked') {
			$('div[data-group='+group+']:not(.toggable)').slideUp();
		} else {
			$('div[data-group='+group+']:not(.toggable)').slideDown();
		}
	});
	
	$(".datepicker" ).datetimepicker({
		showOn: "both",
		buttonImage: "/images/calendar_background.png",
		buttonImageOnly: true,
		dateFormat: 'yyyy-mm-dd HH:MM',
		showButtonPanel: true
	});

});