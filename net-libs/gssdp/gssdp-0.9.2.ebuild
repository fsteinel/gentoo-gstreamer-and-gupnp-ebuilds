# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="A GObject-based API for handling resource discovery and announcement over SSDP."
HOMEPAGE="http://gupnp.org/"
SRC_URI="http://gupnp.org/sites/all/files/sources/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="+introspection"

RDEPEND=">=dev-libs/glib-2.22:2
	>=net-libs/libsoup-2.26.1:2.4[introspection?]
	>=x11-libs/gtk+-2.12:2
	introspection? ( >=dev-libs/gobject-introspection-0.6.4 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_configure() {
	econf \
		$(use_enable introspection) \
		--disable-dependency-tracking \
		--disable-gtk-doc \
		--with-html-dir=/usr/share/doc/${PF}/html
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
