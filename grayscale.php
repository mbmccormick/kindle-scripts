<?php

	// read in PNG file
	$str = file_get_contents("http://yourserver.com/path/to/compress-png");
	file_put_contents("source.png", $str);

	// convert to grayscale
	$image = new Imagick();
	$image->readImage("source.png");
	$image->setImageColorSpace(Imagick::COLORSPACE_GRAY);
	$image->writeImage("output.png");

	// output the image
	header("Content-Type: image/png");
	$fp = fopen("output.png", "rb");
	fpassthru($fp);

?>