Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6E4j4Ha010947
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 00:45:04 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6E4j3H5001219
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 04:45:03 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h6E4j3RX001216 for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 04:45:03 GMT
Received: from columbia (dhcp024-208-189-249.columbus.rr.com [24.208.189.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "columbia.verbum.org", Issuer "verbum.org CA" (verified OK))
	by monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id 759EA32A6BB
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 12:49:45 -0400 (EDT)
Subject: [patch] pass linker soname flag for libselinux, autotools
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-YqPjnauMN3+URuy2tfZp"
Message-Id: <1058157786.9620.38.camel@columbia>
Mime-Version: 1.0
Date: 14 Jul 2003 00:43:06 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-YqPjnauMN3+URuy2tfZp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Debian has an automatic package checking tool (lintian) which was
continually saying to me:

E: libselinux1: ldconfig-symlink-missing-for-shlib usr/lib/libselinux.so usr/lib/libselinux.so.1 libselinux.so
N:
N:   The package should not only include the shared library itself, but
N:   also the symbolic link which ldconfig would produce. (This is
N:   necessary, so that the link gets removed by dpkg automatically when
N:   the package gets removed.) If the symlink is in the package, check
N:   that the SONAME of the library matches the info in the shlibs file.
N:
N:   Refer to Policy Manual, section 9.1 for details.
N:

The symlink was there in the package, so I started looking at the
library SONAME, and I eventually figured out the magic -Wl,-soname flag
was missing.  Apparently this encodes the soname into the file.

A patch is attached which fixes this problem.

This does remind me though; has any consideration been given to
autotoolizing the various packages?  That would have fixed the CFLAGS
issue I ran into earlier, and libtool knows all about the magic needed
to create shared libraries.  Plus you automatically get support for lots
of nice things like testing for installed software, regression tests,
etc.  I'd be willing to put a bit of effort into doing the
autotoolizing, but since this is a new set of tools you'd have to use
upstream I'd like to see if there was interest before doing the work.


--=-YqPjnauMN3+URuy2tfZp
Content-Disposition: attachment; filename=shared-library-soname.patch
Content-Type: text/plain; name=shared-library-soname.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIHNyYy9NYWtlZmlsZX4JMjAwMy0wNy0wNyAwODo1Mzo0MC4wMDAwMDAwMDAgLTA0MDANCisr
KyBzcmMvTWFrZWZpbGUJMjAwMy0wNy0xNCAwMDozMjozMi4wMDAwMDAwMDAgLTA0MDANCkBAIC0x
OSw3ICsxOSw3IEBADQogCXJhbmxpYiAkQA0KIA0KICQoTElCU08pOiAkKE9CSlMpDQotCSQoQ0Mp
ICQoTERGTEFHUykgLXNoYXJlZCAtbyAkQCAkXiAtbGMNCisJJChDQykgJChMREZMQUdTKSAtc2hh
cmVkIC1vICRAICReIC1sYyAtV2wsLXNvbmFtZSwkKExJQlNPKSANCiAJbG4gLXNmICRAICQoVEFS
R0VUKSANCiANCiAlLm86ICAlLmMNCg==

--=-YqPjnauMN3+URuy2tfZp--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
