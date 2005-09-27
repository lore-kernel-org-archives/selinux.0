Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RCqmNs021616
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 08:52:49 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RClTcJ006231
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:47:29 GMT
Message-Id: <200509271247.j8RClWYs026052@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: [PATCH] semanage-functionality 6/17
Date: Tue, 27 Sep 2005 08:47:32 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001F_01C5C340.19ED9110"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_001F_01C5C340.19ED9110
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds the private header for direct_api.c.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_001F_01C5C340.19ED9110
Content-Type: application/octet-stream;
	name="libsemanage_src_include_direct_api.h.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libsemanage_src_include_direct_api.h.diff"

diff -purN -x .svn libsemanage/src/include/direct_api.h =
libsemanage/src/include/direct_api.h=0A=
--- libsemanage/src/include/direct_api.h	1969-12-31 19:00:00.000000000 =
-0500=0A=
+++ libsemanage/src/include/direct_api.h	2005-09-26 11:36:19.000000000 =
-0400=0A=
@@ -0,0 +1,30 @@=0A=
+/* Authors: Jason Tang <jtang@tresys.com>=0A=
+ *=0A=
+ * Copyright (C) 2004-2005 Tresys Technology, LLC=0A=
+ *=0A=
+ *  This library is free software; you can redistribute it and/or=0A=
+ *  modify it under the terms of the GNU Lesser General Public=0A=
+ *  License as published by the Free Software Foundation; either=0A=
+ *  version 2.1 of the License, or (at your option) any later version.=0A=
+ *=0A=
+ *  This library is distributed in the hope that it will be useful,=0A=
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
+ *  Lesser General Public License for more details.=0A=
+ *=0A=
+ *  You should have received a copy of the GNU Lesser General Public=0A=
+ *  License along with this library; if not, write to the Free Software=0A=
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA=0A=
+ */=0A=
+=0A=
+#ifndef SEMANAGE_DIRECT_API_H=0A=
+#define SEMANAGE_DIRECT_API_H=0A=
+=0A=
+#include "semanage_private.h"=0A=
+#include "dso.h"=0A=
+=0A=
+int semanage_direct_connect(semanage_handle_t *sh);=0A=
+=0A=
+hidden_proto(semanage_direct_connect)=0A=
+=0A=
+#endif=0A=

------=_NextPart_000_001F_01C5C340.19ED9110--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
