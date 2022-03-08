#!/bin/bash

if [ `id -u` != 0 ]; then
	echo "Script must be run as root!"
	exit 1
fi

if [ -e /usr/include/librsvg-2.0/librsvg/librsvg-features.h ]; then
	echo "librsvg-features.h already exists. Removing..."
	rm /usr/include/librsvg-2.0/librsvg/librsvg-features.h
	rm /usr/include/librsvg-2.0/librsvg/librsvg-cairo.h
	rm /usr/include/librsvg-2.0/librsvg/librsvg-version.h
fi

ln -s /usr/include/librsvg-2.0/librsvg/rsvg-features.h /usr/include/librsvg-2.0/librsvg/librsvg-features.h
ln -s /usr/include/librsvg-2.0/librsvg/rsvg-cairo.h /usr/include/librsvg-2.0/librsvg/librsvg-cairo.h
ln -s /usr/include/librsvg-2.0/librsvg/rsvg-version.h /usr/include/librsvg-2.0/librsvg/librsvg-version.h
echo "Done!"
