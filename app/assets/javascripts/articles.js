$(document).ready(function(){
	
	$("#article-topic").submit(function(event){
		event.preventDefault()
		
		$.ajax({
			url: "/wiki_scrape",
			type: "POST",
			data: $("#topic")
		}).done(function(response){
			$('#result').html(response.data)
		});
	})
})