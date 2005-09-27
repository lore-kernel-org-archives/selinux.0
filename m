Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RCr9Ns021636
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 08:53:09 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RClipk003953
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:47:44 GMT
Message-Id: <200509271247.j8RClqYs026059@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: [PATCH] semanage-functionality 7/17
Date: Tue, 27 Sep 2005 08:47:52 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0022_01C5C340.25AC2890"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0022_01C5C340.25AC2890
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds the private header dso.h which includes utility macros for
managing the exporting of symbols in shared libraries.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_0022_01C5C340.25AC2890
Content-Type: application/octet-stream;
	name="libsemanage_src_include_dso.h.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libsemanage_src_include_dso.h.diff"

diff -purN -x .svn libsemanage/src/include/dso.h =
libsemanage/src/include/dso.h=0A=
--- libsemanage/src/include/dso.h	1969-12-31 19:00:00.000000000 -0500=0A=
+++ libsemanage/src/include/dso.h	2005-09-26 11:36:19.000000000 -0400=0A=
@@ -0,0 +1,23 @@=0A=
+#ifndef _SELINUX_DSO_H=0A=
+#define _SELINUX_DSO_H  1=0A=
+=0A=
+#ifdef SHARED=0A=
+# define hidden __attribute__ ((visibility ("hidden")))=0A=
+# define hidden_proto(fct) __hidden_proto (fct, fct##_internal)=0A=
+# define __hidden_proto(fct, internal)  \=0A=
+     extern __typeof (fct) internal;    \=0A=
+     extern __typeof (fct) fct __asm (#internal) hidden;=0A=
+# if defined(__alpha__) || defined(__mips__)=0A=
+#  define hidden_def(fct) \=0A=
+     asm (".globl " #fct "\n" #fct " =3D " #fct "_internal");=0A=
+# else=0A=
+#  define hidden_def(fct) \=0A=
+     asm (".globl " #fct "\n.set " #fct ", " #fct "_internal");=0A=
+#endif=0A=
+#else=0A=
+# define hidden=0A=
+# define hidden_proto(fct)=0A=
+# define hidden_def(fct)=0A=
+#endif=0A=
+=0A=
+#endif=0A=

------=_NextPart_000_0022_01C5C340.25AC2890--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
