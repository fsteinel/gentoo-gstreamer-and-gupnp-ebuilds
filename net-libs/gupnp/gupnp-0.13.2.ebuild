# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp/gupnp-0.13.1.ebuild,v 1.2 2009/10/19 19:36:31 klausman Exp $

EAPI=2

inherit eutils

DESCRIPTION="an object-oriented framework for creating UPnP devs and control points."
HOMEPAGE="http://gupnp.org"
SRC_URI="http://${PN}.org/sources/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~x86"
IUSE="networkmanager"

RDEPEND=">=net-libs/gssdp-0.7
	>=net-libs/libsoup-2.4.1:2.4
	>=dev-libs/glib-2.18:2
	dev-libs/libxml2
	|| ( >=sys-apps/util-linux-2.16 <sys-libs/e2fsprogs-libs-1.41.8 )
	networkmanager? ( >=dev-libs/dbus-glib-0.76 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}"/0001-Fix-failures-for-DLNA-CTT-test-cases-7.2.5.9-and-7.2.patch
}

src_configure() {
	local backend=unix
	use networkmanager && backend=network-manager

	econf \
		--disable-dependency-tracking \
		--disable-gtk-doc \
		--with-context-manager=${backend}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
