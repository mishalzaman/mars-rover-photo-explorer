//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
	var $images = $('.images'),
		$camera = $('.camera select'),
		$rover = $('.rover-select'),
		cameras = {
			'curiosity' : {
				'All' : 'all',
				'Front Hazard Avoidance Camera' : 'FHAZ',
				'Rear Hazard Avoidance Camera' : 'RHAZ',
				'Mast Camera' : 'MAST',
				'Chemistry and Camera Complex' : 'CHEMCAM',
				'Mars Hand Lends Imager' : 'MAHLI',
				'Mars Descent Imager' : 'MARDI',
				'Navigation Camera' : 'NAVCAM',
				'Panoramic Camera' : 'PANCAM',
				'Miniature Thermal Emission Spectrometer (Mini-TES)' : 'MINITES'
			},
			'other' : {
				'All' : 'all',
				'Front Hazard Avoidance Camera' : 'FHAZ',
				'Rear Hazard Avoidance Camera' : 'RHAZ',			
				'Navigation Camera' : 'NAVCAM',
				'Panoramic Camera' : 'PANCAM',
				'Miniature Thermal Emission Spectrometer (Mini-TES)' : 'MINITES'
			}
		};

	build_cameras("curiosity");

	// Update camera list based on selected Rover
	$rover.on('change', function(){
		build_cameras(this.value);
	});

	$('.submit-search').click(function(){
		$images.empty();
		$images.append('<p>Searching for Images, please wait ...</p>');
	});

	// AJAX request response status
	$('form.image_query')
		.on('ajax:success', function(e, data, status, xhr) {
			if(data.result == true) {
				display_images(data.images);
			} else {
				$images.empty();
				$images.append('<p>Could not find any images</p>');
			}
			
		})
		.on('ajax:error', function(e, xhr, status, error) {
			console.error(error);
			console.log(status);
		});

	// Display images from AJAX request
	function display_images(data) {
		var counter = 0;
		var camera = $('#image_camera').val();

		$images.empty();
		$images.append('<p></p>');

		for(var i = 0; i < data.length; i++) {
			if (data[i].camera_name == camera || camera == 'all') {
				$img = '<div class="image"><img src="' + data[i].img_src + '" alt="" width="200" height="200" class="img-rounded"></div>';
				$images.append($img);
				counter++
			}
		}

		if(counter > 0) {
			$images.find('p').html('Found ' + counter + ' images for camera with filter: <strong>' + camera + '</strong>');
		} else {
			$images.find('p').html('Did not find any images for filter: <strong>' + camera + '</strong>');
		}
	}

	// Build select box for selected Rover's cameras
	function build_cameras(rover) {
		if (rover !== "curiosity") {
			rover = "other"
		}

		$camera.empty();

		for(var prop in cameras[rover]) {
			$camera.append($('<option>').attr('value', cameras[rover][prop]).text(prop));
		}
	}
});
