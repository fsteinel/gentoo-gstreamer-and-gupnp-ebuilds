# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp/gupnp-0.8.ebuild,v 1.1 2008/04/24 15:20:00 drac Exp $

EAPI=1

inherit autotools

DESCRIPTION="a MediaRenderer version 1 reference implementation."
HOMEPAGE="http://gupnp.org"
SRC_URI="http://gupnp.org/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/gupnp-vala-0.2
	>=gnome-base/gconf-2.16
	>=x11-libs/gtk+-2.12
	>=dev-libs/libgee-0.1.4-r1
	dev-libs/libowl-av"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_unpack() {
	unpack ${A}

	cd "${S}"
	sed -i -e 's/0.1.5/0.1.4/' "${S}"/configure.ac
	eautoreconf
}

src_compile() {
	econf --disable-dependency-tracking --disable-gtk-doc
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
