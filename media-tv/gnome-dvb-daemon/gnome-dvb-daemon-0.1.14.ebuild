# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEFINE_DEFAULT_FUNCTIONS="1"
NEED_PYTHON="2.5"
RESTRICT_PYTHON_ABIS="3.*"

inherit gnome2 python

DESCRIPTION="record and watch TV shows and browse EPG"
HOMEPAGE="http://live.gnome.org/DVBDaemon"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="totem"

RDEPEND="dev-libs/glib:2
	dev-libs/dbus-glib
	>=dev-libs/libgee-0.5.0
	dev-db/sqlite:3
	>=media-libs/gst-plugins-base-0.10.25
	media-libs/gst-plugins-good
	media-libs/gst-plugins-bad
	media-plugins/gst-plugins-dvb
	>=media-plugins/gst-rtsp-server-0.10.5
	gnome-base/gconf
	x11-libs/gtk+:2
	dev-python/gst-python
	dev-python/pygobject
	totem? ( media-video/totem )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-dependency-tracking
		$(use_enable totem totem-plugin)"

	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	# Disable pyc compiling
	mv "${S}"/py-compile "${S}"/py-compile.orig
	ln -s $(type -P true) "${S}"/py-compile
	gnome2_src_prepare
	python_copy_sources
}

src_configure() {
	export GST_INSPECT=/bin/true
	export GST_REGISTRY="${T}/.gstreamer"
	python_execute_function -s gnome2_src_configure
}

src_install() {
	python_execute_function -s gnome2_src_install
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_need_rebuild
	python_mod_optimize gnomedvb /usr/$(get_libdir)/totem/plugins/dvb-daemon
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup gnomedvb /usr/$(get_libdir)/totem/plugins/dvb-daemon
}
