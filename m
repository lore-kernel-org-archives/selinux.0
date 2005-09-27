Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RCuPNs021796
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 08:56:28 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RCp0pk004401
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:51:01 GMT
Message-Id: <200509271251.j8RCp8Ys026119@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: [PATCH] semanage-functionality 15/17
Date: Tue, 27 Sep 2005 08:51:08 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_003A_01C5C340.9A894DA0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_003A_01C5C340.9A894DA0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch changes the semodule makefile to link dynamically with
libsemanage.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_003A_01C5C340.9A894DA0
Content-Type: application/octet-stream;
	name="policycoreutils_semodule_Makefile.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="policycoreutils_semodule_Makefile.diff"

diff -purN -x .svn policycoreutils/semodule/Makefile =
policycoreutils/semodule/Makefile=0A=
--- policycoreutils/semodule/Makefile	2005-09-26 14:02:41.000000000 -0400=0A=
+++ policycoreutils/semodule/Makefile	2005-09-19 09:11:13.000000000 -0400=0A=
@@ -7,7 +7,7 @@ LIBDIR ?=3D ${PREFIX}/lib=0A=
 =0A=
 CFLAGS ?=3D -Werror -Wall -W=0A=
 override CFLAGS +=3D -I$(INCLUDEDIR)=0A=
-LDLIBS =3D -lselinux ${LIBDIR}/libsemanage.a ${LIBDIR}/libsepol.a =
-L$(LIBDIR)=0A=
+LDLIBS =3D -lselinux -lsemanage ${LIBDIR}/libsepol.a -L$(LIBDIR)=0A=
 SEMODULE_OBJS =3D semodule.o=0A=
 =0A=
 all: semodule=0A=

------=_NextPart_000_003A_01C5C340.9A894DA0--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
