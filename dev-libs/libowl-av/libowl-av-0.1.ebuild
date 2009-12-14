# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="OpenedHand Widget Library - Audio/Video"
HOMEPAGE="http://labs.o-hand.com/av-widget-library/"
SRC_URI="http://labs.o-hand.com/sources/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.10
	>=media-libs/gst-plugins-base-0.10
	>=dev-lang/vala-0.3.5"
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}
