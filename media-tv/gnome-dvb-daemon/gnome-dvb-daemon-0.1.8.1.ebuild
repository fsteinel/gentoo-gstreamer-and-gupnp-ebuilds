# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit gnome.org

DESCRIPTION="record and watch TV shows and browse EPG"
HOMEPAGE="http://live.gnome.org/DVBDaemon"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16
	>=dev-libs/dbus-glib-0.74
	>=dev-libs/libgee-0.1.6
	>=dev-db/sqlite-3.4
	media-plugins/gst-plugins-dvb
	>=media-plugins/gst-rtsp-server-0.10.4
	>=dev-libs/gupnp-vala-0.2
	>=gnome-base/gconf-2.16
	>=x11-libs/gtk+-2.12
	>=dev-lang/python-2.5
	>=dev-python/gst-python-0.10.12
	>=dev-python/pygobject-2.15.3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_configure() {
	export GST_INSPECT=/bin/true
	export GST_REGISTRY="${T}/.gstreamer"
	econf --disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
