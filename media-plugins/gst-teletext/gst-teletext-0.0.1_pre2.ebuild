# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils autotools

DESCRIPTION="A GStreamer based teletext decoder"
HOMEPAGE="http://github.com/sebp/gst-teletext"
SRC_URI="https://download.github.com/sebp-gst-teletext-c692687.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="media-libs/zvbi
	>=media-libs/gstreamer-0.10.23
	>=media-libs/gst-plugins-base-0.10.23"
RDEPEND=""
S="${WORKDIR}/sebp-${PN}-c692687/"

src_prepare() {
	AT_M4DIR=m4 eautoreconf
}

src_configure() {
	econf --with-package-name="Gentoo GStreamer Ebuild" \
	--with-package-origin="http://www.gentoo.org"
#	$(use_enable python) \
#	$(use_enable vala)
}

src_install() {
	dodoc AUTHORS NEWS README TODO
	emake install DESTDIR="${D}"
}
