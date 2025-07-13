# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=no

PYTHON_COMPAT=( python3_{4,5,6,7,8,9,10,11,12,13,14} )
DISTUTILS_IN_SOURCE_BUILD=1
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 git-r3 gnome2-utils

DESCRIPTION="A graphical manager for CompizConfig Plugin (libcompizconfig)"
HOMEPAGE="https://gitlab.com/compiz"
EGIT_REPO_URI="https://github.com/compiz-reloaded/ccsm.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE="gtk3"

RDEPEND="
	>=dev-python/compizconfig-python-${PV}[${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/pycairo[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	gnome-base/librsvg[introspection]
"

python_prepare_all() {
	# correct gettext behavior
	if [[ -n "${LINGUAS+x}" ]] ; then
		for i in $(cd po ; echo *po | sed 's/\.po//g') ; do
		if ! has ${i} ${LINGUAS} ; then
			rm po/${i}.po || die
		fi
		done
	fi

	distutils-r1_python_prepare_all
}

python_configure_all() {
	mydistutilsargs=(
		build
		"--prefix=/usr"
		"--with-gtk=$(usex gtk3 3.0 2.0)"
	)
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

src_install() {
    distutils-r1_python_install() {
        distutils-r1_python_install_orig "$@"
        # Fix the failing rm line:
        local reg_scriptdir="${D}/usr/bin"
        rm -f "${reg_scriptdir}"/{"${EPYTHON}",python3,python} || die
    }

    distutils-r1_src_install
}
