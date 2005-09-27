Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RCtPNs021757
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 08:55:26 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RCo1pk004223
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:50:01 GMT
Message-Id: <200509271250.j8RCo9Ys026099@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: [PATCH] semanage-functionality 12/17
Date: Tue, 27 Sep 2005 08:50:09 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0031_01C5C340.770AFFE0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0031_01C5C340.770AFFE0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds semanage.c. This is the portion of the semanage api common
to all implementations (direct and policy server).

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_0031_01C5C340.770AFFE0
Content-Type: application/octet-stream;
	name="libsemanage_src_semanage.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libsemanage_src_semanage.c.diff"

diff -purN -x .svn libsemanage/src/semanage.c libsemanage/src/semanage.c=0A=
--- libsemanage/src/semanage.c	1969-12-31 19:00:00.000000000 -0500=0A=
+++ libsemanage/src/semanage.c	2005-09-26 11:36:20.000000000 -0400=0A=
@@ -0,0 +1,271 @@=0A=
+/* Author: Joshua Brindle <jbrindle@tresys.co=0A=
+ *	   Jason Tang	  <jtang@tresys.com>=0A=
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
+/* This file implements only the publicly-visible functions to =
libsemanage. */=0A=
+=0A=
+#include <semanage/semanage.h>=0A=
+#include "semanage_private.h"=0A=
+#include "direct_api.h"=0A=
+#include "semanage_conf.h"=0A=
+#include "semanage_store.h"=0A=
+#include <selinux/selinux.h>=0A=
+=0A=
+#include <stdarg.h>=0A=
+#include <assert.h>=0A=
+#include <stdlib.h>=0A=
+#include <stdio.h>=0A=
+#include <sys/time.h>=0A=
+=0A=
+#define SEMANAGE_COMMIT_READ_WAIT 5=0A=
+=0A=
+int semanage_init(void)=0A=
+{=0A=
+	/* FIXME: this needs to parse the configuration file */=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+semanage_handle_t *semanage_handle_create(void) {=0A=
+        semanage_handle_t *sh;=0A=
+        const char *conf_name;=0A=
+=0A=
+        /* Get the selinux policy root and pass to the path init =
function */=0A=
+        const char *pr =3D selinux_policy_root();=0A=
+        if (!pr)=0A=
+                return NULL;=0A=
+=0A=
+        if (semanage_check_init(pr))=0A=
+                return NULL;=0A=
+=0A=
+        if ((conf_name =3D semanage_conf_path()) =3D=3D NULL) {=0A=
+                goto cleanup;=0A=
+        }=0A=
+        if ((sh =3D calloc(1, sizeof(*sh))) =3D=3D NULL) {=0A=
+                return NULL;=0A=
+        }=0A=
+        if ((sh->conf =3D semanage_conf_parse(conf_name)) =3D=3D NULL) {=0A=
+                goto cleanup;=0A=
+        }=0A=
+        sh->timeout =3D SEMANAGE_COMMIT_READ_WAIT; /* some default =
value for now, later use config */=0A=
+        return sh;=0A=
+ cleanup:=0A=
+        semanage_handle_destroy(sh);=0A=
+        return NULL;=0A=
+=0A=
+}=0A=
+=0A=
+/* Write an error message to the current error buffer, up to the=0A=
+ * buffer's specified size. */=0A=
+#ifdef __GNUC__=0A=
+__attribute__ ((format (printf, 2, 3)))=0A=
+#endif=0A=
+void semanage_write_error(semanage_handle_t *sh, char *fmt, ...) {=0A=
+	va_list ap;=0A=
+	va_start(ap, fmt);=0A=
+	vsnprintf(sh->err_buf, SEMANAGE_ERRBUFSZ, fmt, ap);=0A=
+	va_end(ap);=0A=
+}=0A=
+=0A=
+hidden_def(semanage_handle_create)=0A=
+hidden_def(semanage_write_error)=0A=
+=0A=
+int semanage_connect(semanage_handle_t **sh) {=0A=
+	assert(sh !=3D NULL);=0A=
+	if ((*sh =3D semanage_handle_create()) =3D=3D NULL) {=0A=
+		return -1;=0A=
+	}=0A=
+	switch ((*sh)->conf->store_type) {=0A=
+	case SEMANAGE_CON_DIRECT: {=0A=
+		if (semanage_direct_connect(*sh) < 0) {=0A=
+			return -1;=0A=
+		}=0A=
+		break;=0A=
+	}=0A=
+	default: {=0A=
+		fprintf(stderr, "The connection type specified within your =
semanage.conf file has not been implemented yet.\n");=0A=
+		exit(EXIT_FAILURE);=0A=
+	}=0A=
+	}=0A=
+	(*sh)->is_connected =3D 1;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+int semanage_disconnect(semanage_handle_t *sh) {=0A=
+	assert(sh !=3D NULL && sh->funcs !=3D NULL && sh->funcs->disconnect =
!=3D NULL);=0A=
+	if (!sh->is_connected) {=0A=
+		return 0;=0A=
+	}=0A=
+	if (sh->funcs->disconnect(sh) < 0) {=0A=
+		return -1;=0A=
+	}=0A=
+	sh->is_in_transaction =3D 0;=0A=
+	sh->is_connected =3D 0;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+void semanage_handle_destroy(semanage_handle_t *sh) {=0A=
+	if (sh !=3D NULL) {=0A=
+		if (sh->funcs !=3D NULL && sh->funcs->destroy !=3D NULL) {=0A=
+			sh->funcs->destroy(sh);=0A=
+		}=0A=
+		semanage_conf_destroy(sh->conf);=0A=
+		free(sh);=0A=
+	}=0A=
+}=0A=
+=0A=
+const char *semanage_strerror(semanage_handle_t *sh) {=0A=
+	if (sh =3D=3D NULL) {=0A=
+		return "Could not parse semange.conf or out of memory.";=0A=
+	}=0A=
+	return sh->err_buf;=0A=
+}=0A=
+=0A=
+/********************* public transaction functions =
*********************/=0A=
+=0A=
+int semanage_begin_transaction(semanage_handle_t *sh) {=0A=
+	assert(sh !=3D NULL && sh->funcs !=3D NULL && sh->funcs->begin_trans =
!=3D NULL);=0A=
+	if (!sh->is_connected) {=0A=
+		semanage_write_error(sh, "Not connected.");=0A=
+		return -1;=0A=
+	}=0A=
+	if (sh->is_in_transaction) {=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	if (sh->funcs->begin_trans(sh) < 0) {=0A=
+		return -1;=0A=
+	}=0A=
+	sh->is_in_transaction =3D 1;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+int semanage_commit(semanage_handle_t *sh) {=0A=
+	int retval;=0A=
+	assert(sh !=3D NULL && sh->funcs !=3D NULL && sh->funcs->commit !=3D =
NULL);=0A=
+	if (!sh->is_in_transaction) {=0A=
+		semanage_write_error(sh, "Will not commit because caller does not =
have a tranaction lock yet.");=0A=
+		return -1;=0A=
+	}=0A=
+	retval =3D sh->funcs->commit(sh);=0A=
+	sh->is_in_transaction =3D 0;=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+/********************* public modules functions *********************/=0A=
+=0A=
+int semanage_module_install(semanage_handle_t *sh,=0A=
+			    char *module_data, size_t data_len) {=0A=
+	if (sh->funcs->install =3D=3D NULL) {=0A=
+		semanage_write_error(sh, "No install function defined for this =
connection type.");=0A=
+		return -1;=0A=
+	}=0A=
+	else if (!sh->is_connected) {=0A=
+		semanage_write_error(sh, "Not connected.");=0A=
+		return -1;=0A=
+	}=0A=
+	else if (!sh->is_in_transaction) {=0A=
+		if (semanage_begin_transaction(sh) < 0) {=0A=
+			return -1;=0A=
+		}=0A=
+	}=0A=
+	return sh->funcs->install(sh, module_data, data_len);=0A=
+}=0A=
+=0A=
+int semanage_module_upgrade(semanage_handle_t *sh,=0A=
+			    char *module_data, size_t data_len) {=0A=
+	if (sh->funcs->upgrade =3D=3D NULL) {=0A=
+		semanage_write_error(sh, "No upgrade function defined for this =
connection type.");=0A=
+		return -1;=0A=
+	}=0A=
+	else if (!sh->is_connected) {=0A=
+		semanage_write_error(sh, "Not connected.");=0A=
+		return -1;=0A=
+	}=0A=
+	else if (!sh->is_in_transaction) {=0A=
+		if (semanage_begin_transaction(sh) < 0) {=0A=
+			return -1;=0A=
+		}=0A=
+	}=0A=
+	return sh->funcs->upgrade(sh, module_data, data_len);=0A=
+}=0A=
+=0A=
+int semanage_module_install_base(semanage_handle_t *sh,=0A=
+				 char *module_data, size_t data_len) {=0A=
+	if (sh->funcs->install_base =3D=3D NULL) {=0A=
+		semanage_write_error(sh, "No install base function defined for this =
connection type.");=0A=
+		return -1;=0A=
+	}=0A=
+	else if (!sh->is_connected) {=0A=
+		semanage_write_error(sh, "Not connected.");=0A=
+		return -1;=0A=
+	}=0A=
+	else if (!sh->is_in_transaction) {=0A=
+		if (semanage_begin_transaction(sh) < 0) {=0A=
+			return -1;=0A=
+		}=0A=
+	}=0A=
+	return sh->funcs->install_base(sh, module_data, data_len);=0A=
+}=0A=
+=0A=
+int semanage_module_remove(semanage_handle_t *sh,=0A=
+			   char *module_name) {=0A=
+	if (sh->funcs->remove =3D=3D NULL) {=0A=
+		semanage_write_error(sh, "No remove function defined for this =
connection type.");=0A=
+		return -1;=0A=
+	}=0A=
+	else if (!sh->is_connected) {=0A=
+		semanage_write_error(sh, "Not connected.");=0A=
+		return -1;=0A=
+	}=0A=
+	else if (!sh->is_in_transaction) {=0A=
+		if (semanage_begin_transaction(sh) < 0) {=0A=
+			return -1;=0A=
+		}=0A=
+	}=0A=
+	return sh->funcs->remove(sh, module_name);=0A=
+}=0A=
+=0A=
+int semanage_module_list(semanage_handle_t *sh,=0A=
+			 semanage_module_info_t **modinfo, int *num_modules) {=0A=
+	if (sh->funcs->list =3D=3D NULL) {=0A=
+		semanage_write_error(sh, "No list function defined for this =
connection type.");=0A=
+		return -1;=0A=
+	}=0A=
+	else if (!sh->is_connected) {=0A=
+		semanage_write_error(sh, "Not connected.");=0A=
+		return -1;=0A=
+	}=0A=
+	return sh->funcs->list(sh, modinfo, num_modules);=0A=
+}=0A=
+=0A=
+void semanage_module_info_datum_destroy(semanage_module_info_t =
*modinfo) {=0A=
+	if (modinfo !=3D NULL) {=0A=
+		free(modinfo->name);=0A=
+		free(modinfo->version);=0A=
+	}=0A=
+}=0A=
+semanage_module_info_t *semanage_module_list_nth(semanage_module_info_t =
*list, int n) {=0A=
+	return list + n;=0A=
+}=0A=
+const char *semanage_module_get_name(semanage_module_info_t *modinfo) {=0A=
+	return modinfo->name;=0A=
+}=0A=
+const char *semanage_module_get_version(semanage_module_info_t =
*modinfo) {=0A=
+	return modinfo->version;=0A=
+}=0A=

------=_NextPart_000_0031_01C5C340.770AFFE0--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
