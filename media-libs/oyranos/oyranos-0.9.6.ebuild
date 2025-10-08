# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit cmake

DESCRIPTION="Oyranos - system-wide colour management library"
HOMEPAGE="https://www.oyranos.org https://github.com/oyranos-cms/oyranos"
SRC_URI="https://github.com/oyranos-cms/oyranos/archive/refs/tags/0.9.6.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc cairo jpeg png tiff raw exiv2 cups qt fltk yajl elektra xcm oyjl microhttpd"

COMMON_DEPEND="
	x11-libs/libXrandr
	x11-libs/libXinerama
	x11-libs/libXfixes
	x11-libs/libXxf86vm
	media-libs/lcms:2
	dev-libs/libxml2
	jpeg? ( media-libs/libjpeg-turbo:= )
	png?  ( media-libs/libpng:0= )
	tiff? ( media-libs/tiff:0= )
	raw?  ( media-libs/libraw:= )
	exiv2? ( media-gfx/exiv2:= )
	cups? ( net-print/cups )
	yajl? ( dev-libs/yajl )
	elektra? ( app-admin/elektra )
	xcm? ( x11-libs/libXcm )
	oyjl? ( dev-libs/oyjl )
	microhttpd? ( net-libs/libmicrohttpd )
	cairo? ( x11-libs/cairo )
	qt? ( dev-qt/qtcore:5 dev-qt/qtgui:5 dev-qt/qtwidgets:5 )
	fltk? ( x11-libs/fltk:= )
"

DEPEND="
	${COMMON_DEPEND}
	virtual/pkgconfig
"

RDEPEND="${COMMON_DEPEND}"

BDEPEND="
	doc? ( app-doc/doxygen media-gfx/graphviz )
"

S="${WORKDIR}/${PN}-0.9.6"

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_LIBXML2=ON
		-DUSE_SYSTEM_YAJL=$(usex yajl ON OFF)
		-DUSE_SYSTEM_ELEKTRA=$(usex elektra ON OFF)
		-DUSE_SYSTEM_LIBXCM=$(usex xcm ON OFF)
		-DUSE_SYSTEM_OYJL=$(usex oyjl ON OFF)

		-DENABLE_DOCU_OYRANOS=$(usex doc ON OFF)
		-DENABLE_TESTS_OYRANOS=OFF
		-DENABLE_EXAMPLES_OYRANOS=OFF

		-DENABLE_FLTK=$(usex fltk ON OFF)
		-DENABLE_QT=$(usex qt ON OFF)
	)

	use cairo || mycmakeargs+=( -DCMAKE_DISABLE_FIND_PACKAGE_Cairo=ON )
	use jpeg  || mycmakeargs+=( -DCMAKE_DISABLE_FIND_PACKAGE_JPEG=ON )
	use png   || mycmakeargs+=( -DCMAKE_DISABLE_FIND_PACKAGE_PNG=ON )
	use tiff  || mycmakeargs+=( -DCMAKE_DISABLE_FIND_PACKAGE_TIFF=ON )
	use raw   || mycmakeargs+=( -DCMAKE_DISABLE_FIND_PACKAGE_Raw=ON )
	use exiv2 || mycmakeargs+=( -DCMAKE_DISABLE_FIND_PACKAGE_Exiv2=ON )
	use cups  || mycmakeargs+=( -DCMAKE_DISABLE_FIND_PACKAGE_CUPS=ON )
	use microhttpd || mycmakeargs+=( -DCMAKE_DISABLE_FIND_PACKAGE_microhttpd=ON )

	cmake_src_configure
}

src_install() {
	cmake_src_install
	find "${ED}" -name '*.la' -delete || die
	dodoc README.md ChangeLog.md 2>/dev/null || die
}