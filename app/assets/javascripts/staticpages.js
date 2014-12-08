$(document).ready(function(){
	$(".one").hide();
	$(".two").hide();
	$(".three").hide();


	$(".one").fadeIn(1000).delay(1000).fadeOut(1000).delay(6000).fadeIn();
	$(".two").delay(3000).fadeIn(1000).delay(1000).fadeOut(1000).delay(3000).fadeIn();
	$(".three").delay(6000).fadeIn(1000).delay(1000).fadeOut(1000).delay(0).fadeIn();


})