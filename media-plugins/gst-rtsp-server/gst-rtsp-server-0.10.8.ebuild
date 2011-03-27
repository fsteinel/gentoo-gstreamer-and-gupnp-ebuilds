# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

#inherit autotools
inherit eutils autotools

DESCRIPTION="A GStreamer based RTSP server"
HOMEPAGE="http://people.freedesktop.org/~wtay/"
SRC_URI="http://people.freedesktop.org/~wtay/${P/-server/}.tar.bz2"
#http://cgit.freedesktop.org/gstreamer/gst-rtsp-server/

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+introspection"
#IUSE="python vala"

#FIXME autoenabled python and vala bindings
#DEPEND="python? ( >=dev-python/pygobject-2.11.2
#		>=dev-python/gst-python-0.10.12
#		>=dev-lang/python-2.3 )
#	>=media-libs/gstreamer-0.10.25
#	>=media-libs/gst-plugins-base-0.10.25
#	vala? ( >=dev-lang/vala-0.5.6 )"
DEPEND=">=dev-python/pygobject-2.11.2
	>=dev-python/gst-python-0.10.12
	>=dev-lang/python-2.3
	>=media-libs/gstreamer-0.10.29
	>=media-libs/gst-plugins-base-0.10.29
	>=dev-lang/vala-0.5.6"
RDEPEND=""
S="${WORKDIR}/${P/-server/}"

src_prepare() {
	epatch "${FILESDIR}/${P}-configure-set-PYGOBJECT_REQ-before-using-it.patch"
	eautoreconf
}
src_configure() {
	econf --with-package-name="Gentoo GStreamer Ebuild" \
	--with-package-origin="http://www.gentoo.org" \
	$(use_enable introspection)
#	$(use_enable python) \
#	$(use_enable vala)
}

src_install() {
	dodoc AUTHORS NEWS README TODO
	emake install DESTDIR="${D}"
}
