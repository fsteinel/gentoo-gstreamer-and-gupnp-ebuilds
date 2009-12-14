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
IUSE=""

DEPEND=">=dev-python/pygobject-2.11.2
	>=media-libs/gstreamer-0.10.22.1
	>=media-libs/gst-plugins-base-0.10.22.1
	>=dev-lang/vala-0.5.6"
RDEPEND=""
S="${WORKDIR}/${P/-server/}"

src_install() {
	dodoc AUTHORS NEWS README TODO
	einstall
}
