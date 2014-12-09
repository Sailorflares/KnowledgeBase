$(document).ready(function(){
	$(".one").hide();
	$(".two").hide();
	$(".three").hide();


	$(".one").fadeIn(1000).delay(2000).fadeOut(1000).delay(8000).fadeIn();
	$(".two").delay(4000).fadeIn(1000).delay(2000).fadeOut(1000).delay(4000).fadeIn();
	$(".three").delay(8000).fadeIn(1000).delay(2000).fadeOut(1000).delay(0).fadeIn();


})