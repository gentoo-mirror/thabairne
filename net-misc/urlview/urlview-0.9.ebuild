# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit autotools eutils

DESCRIPTION="extracts urls from text and will send them to another app"
HOMEPAGE="http://www.mutt.org"
SRC_URI="ftp://gd.tuwien.ac.at/infosys/mail/mutt/contrib/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	sys-libs/ncurses
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	epatch \
		"${FILESDIR}"/no-trailing-newline.patch \
		"${FILESDIR}"/include-fix.patch \
		"${FILESDIR}"/${P}-DESTDIR.patch \
		"${FILESDIR}"/${P}-tinfo.patch

	eautoreconf
}

src_install() {
	default
	dodoc README INSTALL ChangeLog AUTHORS sample.urlview
	dobin url_handler.sh
}

pkg_postinst() {
	echo
	einfo "There is a sample.urlview in /usr/share/doc/${P}"
	einfo "You can also customize /usr/bin/url_handler.sh"
	echo
	einfo "If using urlview from mutt, you may need to "set pipe_decode" in"
	einfo "your ~/.muttrc to prevent garbled URLs."
	echo
}
