Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RCroNs021682
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 08:53:50 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RCmPpk004015
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:48:26 GMT
Message-Id: <200509271248.j8RCmXYs026073@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: [PATCH] semanage-functionality 9/17
Date: Tue, 27 Sep 2005 08:48:33 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0028_01C5C340.3DFD4960"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0028_01C5C340.3DFD4960
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds the private portion of semanage.h for use by implementations
of the public api. In particular it adds the semanage_handle_t struct.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_0028_01C5C340.3DFD4960
Content-Type: application/octet-stream;
	name="libsemanage_src_include_semanage_private.h.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libsemanage_src_include_semanage_private.h.diff"

diff -purN -x .svn libsemanage/src/include/semanage_private.h =
libsemanage/src/include/semanage_private.h=0A=
--- libsemanage/src/include/semanage_private.h	1969-12-31 =
19:00:00.000000000 -0500=0A=
+++ libsemanage/src/include/semanage_private.h	2005-09-26 =
11:36:19.000000000 -0400=0A=
@@ -0,0 +1,119 @@=0A=
+/* Author: Joshua Brindle <jbrindle@tresys.com>=0A=
+ *	   Jason Tang	  <jtang@tresys.com>=0A=
+ *=0A=
+ * Copyright (C) 2005 Tresys Technology, LLC=0A=
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
+#ifndef SEMANAGE_PRIVATE_H=0A=
+#define SEMANAGE_PRIVATE_H=0A=
+=0A=
+#include <semanage/semanage.h>=0A=
+=0A=
+#include "semanage_conf.h"=0A=
+#include "dso.h"=0A=
+=0A=
+#include <stdlib.h>=0A=
+#include <sys/time.h> =0A=
+=0A=
+struct semanage_module_conn {=0A=
+	int translock_file_fd;=0A=
+	int readlock_file_fd;=0A=
+};=0A=
+=0A=
+struct semanage_func_table {=0A=
+	void (*destroy)(semanage_handle_t *);=0A=
+	int (*disconnect)(semanage_handle_t *);=0A=
+	int (*begin_trans)(semanage_handle_t *); =0A=
+	int (*commit)(semanage_handle_t *);=0A=
+	int (*install)(semanage_handle_t *, char *, size_t);=0A=
+	int (*upgrade)(semanage_handle_t *, char *, size_t);=0A=
+	int (*install_base)(semanage_handle_t *, char *, size_t);=0A=
+	int (*remove)(semanage_handle_t *, char *);=0A=
+	int (*list)(semanage_handle_t *, semanage_module_info_t **, int *);=0A=
+};=0A=
+=0A=
+#define SEMANAGE_ERRBUFSZ 1024=0A=
+=0A=
+struct semanage_handle {=0A=
+	int con_id;		/* Connection ID */=0A=
+	int policy_serial;	/* Policy serial number at connect time */=0A=
+	char err_buf[SEMANAGE_ERRBUFSZ];=0A=
+=0A=
+	/* one of these connections will actually be used while=0A=
+	 * working with the module store -- the particular one is=0A=
+	 * given by conf->store_type */=0A=
+	semanage_conf_t *conf;=0A=
+	union {=0A=
+		struct semanage_module_conn module;=0A=
+	} conn;=0A=
+	int is_connected;=0A=
+	int is_in_transaction;=0A=
+=0A=
+	/* these function pointers will point to the appropriate=0A=
+	 * routine given the connection type.  think of these as=0A=
+	 * simulating polymorphism for non-OO languages. */=0A=
+	struct semanage_func_table *funcs;=0A=
+=0A=
+	/* This timeout is used for transactions and waiting for locks =0A=
+	   -1 means wait indefinetely=0A=
+	    0 means return immediately =0A=
+	   >0 means wait that many seconds */=0A=
+	int timeout;=0A=
+};=0A=
+=0A=
+struct semanage_module_info {=0A=
+	char *name;		/* Key */=0A=
+	char *version;=0A=
+};=0A=
+=0A=
+struct semanage_role {=0A=
+	char *name;		/* Key */=0A=
+};=0A=
+=0A=
+struct semanage_mls {=0A=
+	char *level;=0A=
+	char *range;=0A=
+};=0A=
+=0A=
+struct semanage_user {=0A=
+	char *name;		/* Key */=0A=
+	struct semanage_role **roles;=0A=
+	int num_roles;=0A=
+	struct semanage_mls *mls;=0A=
+};=0A=
+=0A=
+struct semanage_homedir {=0A=
+	char *user;=0A=
+	char *path;		/* Key */=0A=
+};=0A=
+=0A=
+struct semanage_boolean {=0A=
+	char *name;		/* Key */=0A=
+	char default_state;=0A=
+};=0A=
+=0A=
+semanage_handle_t *semanage_handle_create(void);=0A=
+=0A=
+#ifdef __GNUC__=0A=
+__attribute__ ((format (printf, 2, 3)))=0A=
+#endif=0A=
+void semanage_write_error(semanage_handle_t *sh, char *fmt, ...);=0A=
+=0A=
+hidden_proto(semanage_handle_create)=0A=
+hidden_proto(semanage_write_error)=0A=
+=0A=
+#endif=0A=

------=_NextPart_000_0028_01C5C340.3DFD4960--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
