Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h64K2OHa006942
	for <selinux@tycho.nsa.gov>; Fri, 4 Jul 2003 16:02:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h64K1UnJ010513
	for <selinux@tycho.nsa.gov>; Fri, 4 Jul 2003 20:01:31 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id h64K1Uhr010510
	for <selinux@tycho.nsa.gov>; Fri, 4 Jul 2003 20:01:30 GMT
Received: from columbia (h-66-134-23-16.SFLDMIDN.covad.net [66.134.23.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "columbia.verbum.org", Issuer "verbum.org CA" (verified OK))
	by monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id CD12141402D
	for <selinux@tycho.nsa.gov>; Fri,  4 Jul 2003 16:02:38 -0400 (EDT)
Subject: Re: build patches for checkpolicy, libselinux, policycoreutils
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
In-Reply-To: <1057271791.24843.13.camel@columbia>
References: <1057271791.24843.13.camel@columbia>
Content-Type: multipart/mixed; boundary="=-rBNECZCsuUs8rFxmzh0L"
Message-Id: <1057299613.31326.9.camel@columbia>
Mime-Version: 1.0
Date: 04 Jul 2003 02:20:13 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-rBNECZCsuUs8rFxmzh0L
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Oops, sorry, the first patch (for checkpolicy) was not the correct fix. 
An updated patch is attached.


--=-rBNECZCsuUs8rFxmzh0L
Content-Disposition: attachment; filename=makefile-cflags.patch
Content-Type: text/x-makefile; name=makefile-cflags.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- Makefile~	2003-07-03 17:52:32.000000000 -0400
+++ Makefile	2003-07-04 02:17:24.000000000 -0400
@@ -4,7 +4,8 @@
 PREFIX ?=3D ${DESTDIR}/usr
 BINDIR ?=3D $(PREFIX)/bin
=20
-CFLAGS =3D -g -Wall -O2 -pipe -include global.h -I. -Iinclude
+CFLAGS =3D -g -Wall -O2 -pipe
+override CFLAGS +=3D -include global.h -I. -Iinclude
=20
 OBJS =3D ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services=
.o y.tab.o lex.yy.o queue.o write.o checkpolicy.o
=20

--=-rBNECZCsuUs8rFxmzh0L--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
