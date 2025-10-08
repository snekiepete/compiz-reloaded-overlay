# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The Compiz ICC colour server"
HOMEPAGE="https://gitlab.com/compiz"
SRC_URI="https://github.com/compiz-reloaded/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-libs/libxml2
	>=media-libs/oyranos-0.9.6
	>=x11-wm/compiz-0.8
	<x11-wm/compiz-0.9
	x11-libs/libXinerama
	x11-libs/libXxf86vm
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-base/xorg-proto
"

DEPEND="${RDEPEND}
	app-text/doxygen
	>=dev-util/intltool-0.35
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
"
