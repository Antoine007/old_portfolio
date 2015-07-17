$(document).ready(function(){
	/* animates once you click an a link of href="xxx" towards an element  of id "xxx"*/
	$('a[href^="#"]').click(function(){  
		var the_id = $(this).attr("href");  
		$('html, body').animate({  
			scrollTop:$(the_id).offset().top
			}, 'slow');  
		return false;  
	}); 
	
	/*scroll to the top when clicking maintitle*/
	$('#maintitle').click(function(){
		$('html, body').animate({scrollTop: $("html, body").offset().top}, 'very slow');
	});
	
	/*prettyphoto and its functions*/
	$("a[rel^='prettyPhoto']").prettyPhoto({
		default_width: 800,
		default_height: 500,
		autoplay_slideshow: true,
		slideshow: 5000, 
		theme: 'dark_square',
		overlay_gallery: false,
		social_tools: false,
	});
	
	/* hides link title on mouse hover (useful since prettyPhoto uses link titles as photo titles*/
	$("a").removeAttr("title");
	
	/*hide instructions after click*/
	$(window).click(function(){
		$('div.instructions').toggle("drop");
		$('div.instructions').css('z-index', -1);
	});
	
	/*replaces elements when window is resized*/
	$(window).resize(function() {
		var img1HH = $('#background1').height();
		var img1WW = $('#background1').width();
		var img2HH = $('#background2').height();
		var img3HH = $('#background3').height();
		var img4HH = $('#background4').height();
		var img5HH = $('#background5').height();
		var img6HH = $('#background6').height();
		
				
				/*placing the floating elements*/
		$('div.title').css('font-size', img1WW/27);
		$('div.category').css('font-size', img1WW/60);
		
		/*$('#maintitle').css('height', img1HH/14);*/
		$('#maintitle').css('font-size', img1WW/37);
		
		$('#category1').css('top', img1HH/4);
		$('#category1').css('height', img1HH/1.5);
		$('#title1').css('top', img1HH/6);
				
		$('#category2').css('top', (img1HH + img2HH/4));
		$('#category2').css('height', img2HH/1.5);
		$('#title2').css('top', (img1HH + img2HH/6));
		
		$('#category3').css('top', (img1HH +img2HH+ img3HH/4));
		$('#category3').css('height', img2HH/1.5);
		$('#title3').css('top', (img1HH + img2HH+ img3HH/6));
		
		$('#category4').css('top', (img1HH +img2HH+ img3HH+ img4HH/4));
		$('#category4').css('height', img4HH/1.5);
		$('#title4').css('top', (img1HH + img2HH+ img3HH+ img4HH/6));
		
		$('#category5').css('top', (img1HH +img2HH+ img3HH+ img4HH + img5HH/4));
		$('#category5').css('height', img5HH/1.5);
		$('#title5').css('top', (img1HH + img2HH+ img3HH+ img4HH + img5HH/6));
		
		$('#category6').css('top', (img1HH +img2HH+ img3HH+ img4HH + img5HH+ img6HH/4));
		$('#category6').css('height', img6HH/1.5);
		$('#title6').css('top', (img1HH + img2HH+ img3HH+ img4HH + img5HH+ img6HH/6));
			
		$('div.socnet').css('height', img1WW/16);
		$('img.socnet').css('top', img1WW/80);
		
		var maintitleHH = $('#maintitle').height();
		
		/*$('.catchphrase').css('height', img1HH/30);*/
		$('.catchphrase').css('font-size', img1WW/80);
		$('.catchphrase').css('top', maintitleHH+25);
		$('#catchphrase3').css('left', img1WW/5.5);
		$('#catchphrase2').css('left', img1WW/8);
		$('#catchphrase1').css('left', img1WW/19);
	});
});	

