# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

#http://cgit.freedesktop.org/gstreamer/gst-rtsp-server/
DESCRIPTION="A GStreamer based RTSP server"
HOMEPAGE="http://people.freedesktop.org/~wtay/"
SRC_URI="http://people.freedesktop.org/~wtay/${P/-server/}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
#IUSE="python vala"

#FIXME autoenable python and vala bindings
#DEPEND="python? ( >=dev-python/pygobject-2.11.2
#		>=dev-python/gst-python-0.10.12
#		>=dev-lang/python-2.3 )
#	>=media-libs/gstreamer-0.10.23
#	>=media-libs/gst-plugins-base-0.10.23
#	vala? ( >=dev-lang/vala-0.5.6 )"
DEPEND=">=dev-python/pygobject-2.11.2
	>=dev-python/gst-python-0.10.12
	>=dev-lang/python-2.3
	>=media-libs/gstreamer-0.10.23
	>=media-libs/gst-plugins-base-0.10.23
	>=dev-lang/vala-0.5.6"
RDEPEND=""
S="${WORKDIR}/${P/-server/}"

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
