Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RCrWNs021660
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 08:53:32 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RCmAcJ006306
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:48:12 GMT
Message-Id: <200509271248.j8RCmDYs026069@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: [PATCH] semanage-functionality 8/17
Date: Tue, 27 Sep 2005 08:48:12 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0025_01C5C340.31D12300"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0025_01C5C340.31D12300
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds the private header for config file parsing, storage, and
management.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_0025_01C5C340.31D12300
Content-Type: application/octet-stream;
	name="libsemanage_src_include_semanage_conf.h.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libsemanage_src_include_semanage_conf.h.diff"

diff -purN -x .svn libsemanage/src/include/semanage_conf.h =
libsemanage/src/include/semanage_conf.h=0A=
--- libsemanage/src/include/semanage_conf.h	1969-12-31 =
19:00:00.000000000 -0500=0A=
+++ libsemanage/src/include/semanage_conf.h	2005-09-26 =
11:36:19.000000000 -0400=0A=
@@ -0,0 +1,60 @@=0A=
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
+#ifndef SEMANAGE_CONF_H=0A=
+#define SEMANAGE_CONF_H=0A=
+=0A=
+/* libsemanage has its own configuration file.	It has two main parts:=0A=
+ *  - single options=0A=
+ *  - external programs to execute whenever a policy is to be loaded=0A=
+ */=0A=
+=0A=
+#include "dso.h"=0A=
+=0A=
+enum semanage_connect_type {=0A=
+	SEMANAGE_CON_INVALID =3D 0,=0A=
+	SEMANAGE_CON_SOURCE, SEMANAGE_CON_DIRECT,=0A=
+	SEMANAGE_CON_POLSERV_LOCAL, SEMANAGE_CON_POLSERV_REMOTE=0A=
+};=0A=
+typedef struct semanage_conf {=0A=
+	enum semanage_connect_type store_type;=0A=
+	char *server_path;=0A=
+	int server_port;=0A=
+	int policyvers;		/* version for server generated policies */=0A=
+	struct external_prog *load_policy;=0A=
+	struct external_prog *setfiles;=0A=
+	struct external_prog *mod_prog, *linked_prog, *kernel_prog;=0A=
+} semanage_conf_t;=0A=
+=0A=
+/* A linked list of verification programs.  Each one is called in=0A=
+ * order of appearance within the configuration file.=0A=
+ */=0A=
+typedef struct external_prog {=0A=
+	char *path;=0A=
+	char *args;=0A=
+	struct external_prog *next;=0A=
+} external_prog_t;=0A=
+=0A=
+semanage_conf_t *semanage_conf_parse(const char *config_filename);=0A=
+void semanage_conf_destroy(semanage_conf_t *conf);=0A=
+=0A=
+hidden_proto(semanage_conf_parse)=0A=
+hidden_proto(semanage_conf_destroy)=0A=
+=0A=
+#endif=0A=

------=_NextPart_000_0025_01C5C340.31D12300--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
