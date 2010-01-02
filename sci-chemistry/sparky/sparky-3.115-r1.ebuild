# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

PYTHON_USE_WITH="tk"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_DEFINE_DEFAULT_FUNCTIONS="1"

inherit alternatives eutils flag-o-matic toolchain-funcs python

DESCRIPTION="Graphical NMR assignment and integration program for proteins, nucleic acids, and other polymers"
HOMEPAGE="http://www.cgl.ucsf.edu/home/sparky/"
SRC_URI="http://www.cgl.ucsf.edu/home/sparky/distrib-${PV}/${PN}-source-${PV}.tar.gz"

LICENSE="sparky"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="app-shells/tcsh"
DEPEND="${RDEPEND}"

RESTRICT="mirror"

S="${WORKDIR}/${PN}"

pkg_setup() {
	TKVER=$(best_version dev-lang/tk | cut -d- -f3 | cut -d. -f1,2)
}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-ldflags.patch
	epatch "${FILESDIR}"/${PV}-wrapper.patch
	epatch "${FILESDIR}"/${PV}-paths.patch

	python_copy_sources

	preparation() {
		sed -i \
			-e "s:^\(set PYTHON =\).*:\1 ${EPREFIX}$(PYTHON -a):g" \
			-e "s:^\(setenv SPARKY_INSTALL[[:space:]]*\).*:\1 ${EPREFIX}/usr/$(get_libdir)/${PN}:g" \
			-e "s:tcl8.4:tcl${TKVER}:g" \
			-e "s:tk8.4:tk${TKVER}:g" \
			-e "s:^\(setenv TCLTK_LIB[[:space:]]*\).*:\1 ${EPREFIX}/usr/$(get_libdir):g" \
			"${BUILDDIR}"/bin/sparky
	}

	python_execute_function -s preparation
}

src_compile() {
	append-flags -fPIC

	configuration() {
		emake \
			SPARKY="${BUILDDIR}" \
			PYTHON_VERSION="$(PYTHON -a)" \
			PYTHON_PREFIX="${EPREFIX}/usr" \
			PYTHON_LIB="${EPREFIX}$(python_get_libdir)" \
			PYTHON_INC="${EPREFIX}$(python_get_includedir)" \
			TK_PREFIX="${EPREFIX}/usr" \
			TCLTK_VERSION="${TKVER}" \
			TKLIBS="-L${EPREFIX}/usr/$(get_libdir)/ -ltk${TKVER} -ltcl${TKVER} -lX11" \
			CXX="$(tc-getCXX)" \
			CC="$(tc-getCC)"
	}
	python_execute_function -s configuration
}

src_install() {
	# The symlinks are needed to avoid hacking the complete code to fix the locations

	dobin c++/{{bruk,matrix,peaks,pipe,vnmr}2ucsf,ucsfdata,sparky-no-python} || die

	insinto /usr/share/${PN}/
	doins lib/{print-prolog.ps,Sparky} || die
	dosym ../../share/${PN}/print-prolog.ps /usr/$(get_libdir)/${PN}/
	dosym ../../share/${PN}/Sparky /usr/$(get_libdir)/${PN}/

	dohtml -r manual/* || die
	dosym ../../share/doc/${PF}/html /usr/$(get_libdir)/${PN}/manual

	installation() {
		newbin bin/${PN} bin/${PN}-${PYTHON_ABI} || return 1
		insinto $(python_get_sitedir)/${PN}
		doins python/*.py c++/{spy.so,_tkinter.so} || return 1
		fperms 755 $(python_get_sitedir)/${PN}/{spy.so,_tkinter.so} || return 1
	}
	python_execute_function -s installation 

	python_generate_wrapper_scripts "${D}usr/bin/${PN}"

	if use examples; then
		insinto /usr/share/doc/${PF}/
		doins -r example || die
		dosym ../../share/doc/${PF}/example /usr/$(get_libdir)/${PN}/example
	fi

	dodoc README || die
	newdoc python/README README.python || die
}

pkg_postinst() {
	python_need_rebuild
	python_mod_optimize sparky

	create_symlinks() {
		alternatives_auto_makesym $(python_get_sitedir) /usr/$(get_libdir)/${PN}/python
	}
	python_execute_function -s create_symlinks
}

pkg_postrm() {
	python_mod_cleanup sparky
}
