# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit multilib gnome2 python

DESCRIPTION="record and watch TV shows and browse EPG"
HOMEPAGE="http://live.gnome.org/DVBDaemon"
SRC_URI="http://launchpad.net/gnome-dvb-daemon/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="totem"

RDEPEND=">=dev-libs/glib-2.16
	>=dev-libs/dbus-glib-0.74
	>=dev-libs/libgee-0.5.0
	>=dev-db/sqlite-3.4
	media-plugins/gst-plugins-dvb
	>=media-plugins/gst-rtsp-server-0.10.5
	>=dev-libs/gupnp-vala-0.2
	>=gnome-base/gconf-2.16
	>=x11-libs/gtk+-2.12
	>=dev-lang/python-2.5
	>=dev-python/gst-python-0.10.12
	>=dev-python/pygobject-2.15.3
	totem? ( >=media-video/totem-2.20 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

RESTRICT_PYTHON_ABIS="3*"

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
}

src_configure() {
	export GST_INSPECT=/bin/true
	export GST_REGISTRY="${T}/.gstreamer"
	gnome2_src_configure
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_need_rebuild
	python_mod_optimize /usr/$(get_libdir)/totem/plugins/dvb-daemon
	python_mod_optimize gnomedvb
}
pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/totem/plugins/dvb-daemon
	python_mod_cleanup gnomedvb
}
