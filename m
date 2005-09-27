Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RCsfNs021707
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 08:54:41 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RCnLcJ006359
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:49:21 GMT
Message-Id: <200509271249.j8RCnKYs026085@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: [PATCH] semanage-functionality 10/17
Date: Tue, 27 Sep 2005 08:49:20 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002B_01C5C340.5A035BE0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_002B_01C5C340.5A035BE0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds the private header for the semanage transactional store.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_002B_01C5C340.5A035BE0
Content-Type: application/octet-stream;
	name="libsemanage_src_include_semanage_store.h.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libsemanage_src_include_semanage_store.h.diff"

diff -purN -x .svn libsemanage/src/include/semanage_store.h =
libsemanage/src/include/semanage_store.h=0A=
--- libsemanage/src/include/semanage_store.h	1969-12-31 =
19:00:00.000000000 -0500=0A=
+++ libsemanage/src/include/semanage_store.h	2005-09-26 =
12:21:22.000000000 -0400=0A=
@@ -0,0 +1,104 @@=0A=
+/* Authors: Karl MacMillan <kmacmillan@tresys.com>=0A=
+ *	    Joshua Brindle <jbrindle@tresys.com>=0A=
+ *	    Jason Tang <jtang@tresys.com>=0A=
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
+#ifndef SEMANAGE_MODULE_STORE_H=0A=
+#define SEMANAGE_MODULE_STORE_H=0A=
+=0A=
+#include "semanage_private.h"=0A=
+#include "dso.h"=0A=
+=0A=
+#include <sys/time.h>=0A=
+=0A=
+#include <sepol/module.h>=0A=
+=0A=
+enum semanage_store_defs {=0A=
+	SEMANAGE_ACTIVE,=0A=
+	SEMANAGE_PREVIOUS,=0A=
+	SEMANAGE_TMP,=0A=
+	SEMANAGE_NUM_STORES=0A=
+};=0A=
+=0A=
+/* sandbox filenames and paths */=0A=
+enum semanage_sandbox_defs {=0A=
+	SEMANAGE_TOPLEVEL,=0A=
+	SEMANAGE_MODULES, =0A=
+	SEMANAGE_KERNEL,=0A=
+	SEMANAGE_BASE, =0A=
+	SEMANAGE_LINKED, =0A=
+	SEMANAGE_FC,=0A=
+	SEMANAGE_COMMIT_NUM_FILE,=0A=
+	SEMANAGE_STORE_NUM_PATHS=0A=
+};=0A=
+=0A=
+/* FIXME: this needs to be made a module store specific init and the=0A=
+ * global configuration moved to another file.=0A=
+ */=0A=
+const char *semanage_conf_path(void);=0A=
+int semanage_check_init(const char *root);=0A=
+const char *semanage_path(enum semanage_store_defs store, enum =
semanage_sandbox_defs file);=0A=
+=0A=
+int semanage_create_store(semanage_handle_t *sh, int create);=0A=
+hidden_proto(semanage_create_store)=0A=
+=0A=
+int semanage_remove_directory(const char *path);=0A=
+hidden_proto(semanage_remove_directory)=0A=
+=0A=
+int semanage_make_sandbox(semanage_handle_t *sh);=0A=
+int semanage_get_modules_names(semanage_handle_t *sh,=0A=
+			       char ***filenames, int *len);=0A=
+int semanage_install_sandbox(semanage_handle_t *sh);=0A=
+hidden_proto(semanage_make_sandbox)=0A=
+hidden_proto(semanage_get_modules_names)=0A=
+hidden_proto(semanage_install_sandbox)=0A=
+=0A=
+/* lock file routines */=0A=
+int semanage_get_trans_lock(semanage_handle_t *sh);=0A=
+int semanage_get_read_lock(semanage_handle_t *sh);=0A=
+void semanage_release_trans_lock(semanage_handle_t *sh);=0A=
+void semanage_release_read_lock(semanage_handle_t *sh);=0A=
+int semanage_get_commit_number(semanage_handle_t *sh);=0A=
+hidden_proto(semanage_get_trans_lock)=0A=
+hidden_proto(semanage_get_read_lock)=0A=
+hidden_proto(semanage_release_trans_lock)=0A=
+hidden_proto(semanage_release_read_lock)=0A=
+hidden_proto(semanage_get_commit_number)=0A=
+=0A=
+=0A=
+int semanage_link_sandbox(semanage_handle_t *sh, sepol_module_package_t =
**base);=0A=
+int semanage_expand_sandbox(semanage_handle_t *sh, =
sepol_module_package_t *base);=0A=
+int semanage_install_sandbox(semanage_handle_t *sh);=0A=
+=0A=
+int semanage_verify_modules(semanage_handle_t *sh,=0A=
+			    char **module_filenames, int num_modules);=0A=
+int semanage_verify_linked(semanage_handle_t *sh);=0A=
+int semanage_verify_kernel(semanage_handle_t *sh);=0A=
+=0A=
+hidden_proto(semanage_conf_path)=0A=
+hidden_proto(semanage_check_init)=0A=
+hidden_proto(semanage_path)=0A=
+=0A=
+hidden_proto(semanage_link_sandbox)=0A=
+hidden_proto(semanage_expand_sandbox)=0A=
+hidden_proto(semanage_install_sandbox)=0A=
+hidden_proto(semanage_verify_modules)=0A=
+hidden_proto(semanage_verify_linked)=0A=
+hidden_proto(semanage_verify_kernel)=0A=
+#endif=0A=

------=_NextPart_000_002B_01C5C340.5A035BE0--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
