# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit gnome.org

DESCRIPTION="record and watch TV shows and browse EPG"
HOMEPAGE="http://live.gnome.org/DVBDaemon"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16
	>=dev-libs/dbus-glib-0.74
	>=dev-libs/libgee-0.1.4
	>=dev-db/sqlite-3.4
	media-plugins/gst-plugins-dvb
	media-plugins/gst-plugins-rtsp
	>=dev-libs/gupnp-vala-0.2
	>=gnome-base/gconf-2.16
	>=x11-libs/gtk+-2.12"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_compile() {
	econf --disable-dependency-tracking --disable-gtk-doc
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
