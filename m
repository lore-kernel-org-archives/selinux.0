Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9BDoTNs000087
	for <selinux@tycho.nsa.gov>; Tue, 11 Oct 2005 09:50:29 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9BDn58n028571
	for <selinux@tycho.nsa.gov>; Tue, 11 Oct 2005 13:49:05 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j9BDmmSs023627
	for <selinux@tycho.nsa.gov>; Tue, 11 Oct 2005 09:48:48 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j9BDmmd6023626
	for selinux@tycho.nsa.gov; Tue, 11 Oct 2005 09:48:48 -0400
Message-ID: <434B62B8.4080309@cornell.edu>
Date: Tue, 11 Oct 2005 02:59:04 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>
Subject: [ SEMANAGE ] Replace semanage debugging system
Content-Type: multipart/mixed;
 boundary="------------020203080108000400000203"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020203080108000400000203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch replaces the current semanage debugging system, with 
one based on callbacks. It breaks API, so the libsemanage.map file needs 
to be updated, but I'm not sure how to do that properly, so I left that 
part out...

Functions removed:
semanage_strerror

Functions that need to be exposed:
Everything in include/semanage/debug.h

Changes since last time we discussed this:
- added argument level (which is set in macros WARN, ERR, and INFO)
- added argument channel (auto-set by the macros to "libsemanage") - 
this will be helpful to separate out sepol messages
- replaced use of __FUNCTION__ with __func__, which should not be GNU 
specific
- function name argument is now auto-set by macros, so we don't have to 
worry about it.
- replaced existing usage of semanage_write_error with those macros

Unrelated changes in this patch:
- Renames policy_connection.h to policy.h
- moves conn into policy.h, which is a good place for it, I think.
- some #if0'ed code paths.

--------------020203080108000400000203
Content-Type: text/x-patch;
 name="libsemanage.debug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.debug.diff"

diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libselinux --exclude policy_components.c old/libsemanage/include/semanage/debug.h exp/libsemanage/include/semanage/debug.h
--- old/libsemanage/include/semanage/debug.h	1969-12-31 19:00:00.000000000 -0500
+++ exp/libsemanage/include/semanage/debug.h	2005-10-11 02:06:34.000000000 -0400
@@ -0,0 +1,62 @@
+/* Author: Joshua Brindle <jbrindle@tresys.com>
+ *         Jason Tang     <jtang@tresys.com>
+ *         Ivan Gyurdiev  <ivg2@cornell.edu>
+ *
+ * Copyright (C) 2005 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef _SEMANAGE_DEBUG_H_
+#define _SEMANAGE_DEBUG_H_
+
+#include <semanage/handle.h>
+
+struct semanage_message;
+typedef struct semanage_message semanage_message_t;
+
+#define SEMANAGE_MSG_ERR  1
+#define SEMANAGE_MSG_WARN 2
+#define SEMANAGE_MSG_INFO 3
+
+extern const char* semanage_msg_get_message(
+	semanage_message_t* msg);
+
+extern int semanage_msg_get_level(
+	semanage_message_t* msg);
+
+extern const char* semanage_msg_get_channel(
+	semanage_message_t* msg);
+
+extern const char* semanage_msg_get_fname(
+	semanage_message_t* msg);
+
+extern void semanage_msg_free(
+	semanage_message_t* msg);
+
+/* Set the messaging callback. 
+ * By the default, the callback will print
+ * the message on standard output, in a 
+ * particular format. Passing NULL here
+ * indicates that messaging should be suppressed */
+extern void semanage_msg_set_callback(
+	semanage_handle_t* handle,
+	void (*callback) (
+		void* varg,
+		semanage_message_t* msg),
+	void* callback_arg);
+
+#endif 
diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libselinux --exclude policy_components.c old/libsemanage/include/semanage/handle.h exp/libsemanage/include/semanage/handle.h
--- old/libsemanage/include/semanage/handle.h	2005-09-28 15:56:00.000000000 -0400
+++ exp/libsemanage/include/semanage/handle.h	2005-10-11 01:59:36.000000000 -0400
@@ -51,14 +51,6 @@
  * error. */
 int semanage_disconnect(semanage_handle_t *);
 
-/* Return a string describing the most recently encountered error
- * associated with a semanage_handle_t.	 The returned string must not
- * be modified by the caller.  Be aware that this string is not
- * persistent; future calls to this library may alter the buffer
- * contents, so make a copy of it if necessary.
- */
-const char *semanage_strerror(semanage_handle_t *);
-
 /* Attempt to obtain a transaction lock on the manager.	 If another
  * process has the lock then this function may block, depending upon
  * the timeout value in the handle.
@@ -75,18 +67,4 @@
  */
 int semanage_commit(semanage_handle_t *);
 
-/* META NOTES
- *
- * All of the other interfaces expect a semanage_handle as its first
- * parameter.  If an error occurs then the function returns a negative
- * value.  Call semanage_strerror() to retrieve a string that fully
- * describes the error.
- *
- * For all functions a non-negative number indicates success. For query 
- * fucntions a >=0 returned value is the "policy sequence number".  This
- * number keeps tracks of policy revisions and is used to detect if
- * one semanage client has committed policy changes while another is
- * still connected.
- */
-
 #endif
diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libselinux --exclude policy_components.c old/libsemanage/include/semanage/semanage.h exp/libsemanage/include/semanage/semanage.h
--- old/libsemanage/include/semanage/semanage.h	2005-09-28 15:56:00.000000000 -0400
+++ exp/libsemanage/include/semanage/semanage.h	2005-10-11 01:59:45.000000000 -0400
@@ -23,6 +23,7 @@
 
 #include <semanage/handle.h>
 #include <semanage/modules.h>
+#include <semanage/debug.h>
 
 /*
  * Explicit libsemanage initialization.
diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libselinux --exclude policy_components.c old/libsemanage/src/database_direct.c exp/libsemanage/src/database_direct.c
--- old/libsemanage/src/database_direct.c	2005-10-07 23:43:17.000000000 -0400
+++ exp/libsemanage/src/database_direct.c	2005-10-07 23:55:28.000000000 -0400
@@ -3,6 +3,7 @@
 #define DBASE_DEFINED
 
 #include <stdlib.h>
+#include <string.h>
 #include <stdio.h>
 #include <fcntl.h>
 #include <sys/types.h>
diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libselinux --exclude policy_components.c old/libsemanage/src/debug.c exp/libsemanage/src/debug.c
--- old/libsemanage/src/debug.c	2005-09-30 16:19:07.000000000 -0400
+++ exp/libsemanage/src/debug.c	2005-10-11 02:21:43.000000000 -0400
@@ -1,7 +1,9 @@
 /* Author: Joshua Brindle <jbrindle@tresys.co
  *         Jason Tang     <jtang@tresys.com>
+ *         Ivan Gyurdiev  <ivg2@cornell.edu> 
  *
  * Copyright (C) 2004-2005 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat Inc.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -19,20 +21,109 @@
  */
 
 #include <stdarg.h>
+#include <stdlib.h>
 #include <stdio.h>
 #include "handle.h"
 #include "debug.h"
 
-/* FIXME: redesign with callbacks ? */
+#define SEMANAGE_ERRBUFSZ 1024
+
+struct semanage_message {
+	char message[SEMANAGE_ERRBUFSZ];
+	int level;
+	const char* channel;
+	const char* fname;
+};
+
+const char* semanage_msg_get_message(semanage_message_t* msg) {
+	return msg->message;
+};
+
+int semanage_msg_get_level(semanage_message_t* msg) {
+	return msg->level;
+}
+
+const char* semanage_msg_get_channel(semanage_message_t* msg) {
+	return msg->channel;
+}
+
+const char* semanage_msg_get_fname(semanage_message_t* msg) {
+	return msg->fname;
+}
+
+void semanage_msg_free(semanage_message_t* msg) {
+	if (!msg)
+		return;
+
+	free(msg);
+}
+
+void msg_default_handler(
+	void* varg,
+	semanage_message_t* msg) {
+
+	FILE* stream = NULL;
+
+	switch(semanage_msg_get_level(msg)) {
+	
+		case SEMANAGE_MSG_ERR:
+		case SEMANAGE_MSG_WARN:
+			stream = stderr;
+			break;
+		case SEMANAGE_MSG_INFO:
+		default:
+			stream = stdout;
+			break;
+	}
+
+	fprintf(stream, "%s.%s: %s\n",
+		semanage_msg_get_channel(msg),
+		semanage_msg_get_fname(msg),
+		semanage_msg_get_message(msg));
+
+	semanage_msg_free(msg);
+	varg = NULL;
+}
 
-/* Write an error message to the current error buffer, up to the
- * buffer's specified size. */
 #ifdef __GNUC__
-__attribute__ ((format (printf, 2, 3)))
+__attribute__ ((format (printf, 5, 6)))
 #endif
-void semanage_write_error(semanage_handle_t *sh, char *fmt, ...) {
+void msg_write(
+	semanage_handle_t* handle,
+	int level,
+	const char* channel,
+	const char* fname,
+	char* fmt,
+	...) {
+
+	semanage_message_t* msg;
+
+	if (!handle->callback)
+		return;
+
+	msg = (semanage_message_t*) malloc(sizeof(semanage_message_t));
+	if (!msg)
+		return;
+
+	msg->fname = fname;
+	msg->channel = channel;
+	msg->level = level;
+
 	va_list ap;
 	va_start(ap, fmt);
-	vsnprintf(sh->err_buf, SEMANAGE_ERRBUFSZ, fmt, ap);
+	vsnprintf(msg->message, SEMANAGE_ERRBUFSZ, fmt, ap);
 	va_end(ap);
+
+	handle->callback(handle->callback_arg, msg);
+}
+
+extern void semanage_msg_set_callback(
+	semanage_handle_t* handle,
+	void (*callback) (
+		void* varg,
+		semanage_message_t* msg),
+	void* callback_arg) {
+
+	handle->callback = callback;
+	handle->callback_arg = callback_arg;
 }
diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libselinux --exclude policy_components.c old/libsemanage/src/debug.h exp/libsemanage/src/debug.h
--- old/libsemanage/src/debug.h	2005-09-30 16:19:07.000000000 -0400
+++ exp/libsemanage/src/debug.h	2005-10-11 02:31:15.000000000 -0400
@@ -20,20 +20,42 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#ifndef _SEPOL_INTERNAL_DEBUG_H_
-#define _SEPOL_INTERNAL_DEBUG_H_
+#ifndef _SEMANAGE_INTERNAL_DEBUG_H_
+#define _SEMANAGE_INTERNAL_DEBUG_H_
 
 #include "handle.h"
+#include <stdio.h>
+#include <semanage/debug.h>
 
 #define STATUS_SUCCESS 0
 #define STATUS_ERR -1
 #define STATUS_NODATA 1
 
-/* FIXME: redesign with level argument ? */
+#define ERR(handle, ...) \
+	msg_write(handle, SEMANAGE_MSG_ERR, "libsemanage", \
+	__func__, __VA_ARGS__)
+
+#define INFO(handle, fmt, ...) \
+	msg_write(handle, SEMANAGE_MSG_INFO, "libsemanage", \
+	__func__, __VA_ARGS__)
+
+#define WARN(handle, fmt, ...) \
+	msg_write(handle, SEMANAGE_MSG_WARN, "libsemanage", \
+	__func__, __VA_ARGS__)
 
 #ifdef __GNUC__
-__attribute__ ((format (printf, 2, 3)))
+__attribute__ ((format (printf, 5, 6)))
 #endif
-extern void semanage_write_error(semanage_handle_t *sh, char *fmt, ...);
+extern void msg_write(
+	semanage_handle_t* handle,
+	int level,
+	const char* channel,
+	const char* fname,
+	char* fmt,
+	...);
+
+extern void msg_default_handler(
+	void* varg,
+	semanage_message_t* msg);
 
 #endif 
diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libselinux --exclude policy_components.c old/libsemanage/src/direct_api.c exp/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-10-07 18:37:59.000000000 -0400
+++ exp/libsemanage/src/direct_api.c	2005-10-11 02:34:29.000000000 -0400
@@ -33,7 +33,7 @@
 #include "modules.h"
 #include "direct_api.h"
 #include "semanage_store.h"
-#include "policy_connection.h"
+#include "policy.h"
 
 static void semanage_direct_destroy(semanage_handle_t *sh);
 static int semanage_direct_disconnect(semanage_handle_t *sh);
@@ -89,7 +89,7 @@
 	if (sh->is_in_transaction) {
 		/* destroy sandbox */
 		if (semanage_remove_directory(semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL)) < 0) {
-			semanage_write_error(sh, "Could not cleanly remove sandbox %s.", semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL));
+			ERR(sh, "Could not cleanly remove sandbox %s.", semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL));
 			return -1;
 		}
 		semanage_release_trans_lock(sh);
@@ -129,7 +129,7 @@
 	*module_name = *version = *filename = NULL;
 	
 	if (sepol_policy_file_create(&pf)) {
-		semanage_write_error(sh, "Out of memory!");
+		ERR(sh, "Out of memory!");
 		return -1;
 	}
 	sepol_policy_file_set_mem(pf, module_data, data_len);
@@ -138,19 +138,19 @@
 	    sepol_module_package_info(pf, &file_type, module_name,
 				      version) == -1) {
 		sepol_policy_file_free(pf);
-		semanage_write_error(sh, "Could not parse module data.");
+		ERR(sh, "Could not parse module data.");
 		return -2;
 	}
 	sepol_policy_file_free(pf);
 	if (file_type != SEPOL_POLICY_MOD) {
-		semanage_write_error(sh, "Data did not represent a module.");
+		ERR(sh, "Data did not represent a module.");
 		return -2;
 	}
 	if ((module_path = semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES)) == NULL) {
 		return -1;
 	}
 	if (asprintf(filename, "%s/%s.pp", module_path, *module_name) == -1) {
-		semanage_write_error(sh, "Out of memory!");
+		ERR(sh, "Out of memory!");
 		return -1;
 	}
 	return 0;
@@ -167,7 +167,7 @@
 	int file_type;
 
 	if (sepol_policy_file_create(&pf)) {
-		semanage_write_error(sh, "Out of memory!");
+		ERR(sh, "Out of memory!");
 		return -1;
 	}
 	sepol_policy_file_set_mem(pf, module_data, data_len);
@@ -176,14 +176,14 @@
 	    sepol_module_package_info(pf, &file_type,
 				      &module_name, &version) == -1) {
 		sepol_policy_file_free(pf);
-		semanage_write_error(sh, "Could not parse base module data.");
+		ERR(sh, "Could not parse base module data.");
 		return -2;
 	}
 	sepol_policy_file_free(pf);
 	free(module_name);
 	free(version);
 	if (file_type != SEPOL_POLICY_BASE) {
-		semanage_write_error(sh, "Data did not represent a module.");
+		ERR(sh, "Data did not represent a module.");
 		return -2;
 	}
 	return 0;
@@ -195,11 +195,11 @@
 		      const char *filename, char *data, size_t num_bytes) {
 	int out;
 	if ((out = open(filename, O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR)) == -1) {
-		semanage_write_error(sh, "Could not open %s for writing.", filename);
+		ERR(sh, "Could not open %s for writing.", filename);
 		return -1;
 	}
 	if (write(out, data, num_bytes) == -1) {
-		semanage_write_error(sh, "Error while writing to %s.", filename);
+		ERR(sh, "Error while writing to %s.", filename);
 		close(out);
 		return -1;
 	}
@@ -217,19 +217,19 @@
 	FILE *outfile;
 	int retval;
 	if (sepol_policy_file_create(&pf)) {
-		semanage_write_error(sh, "Out of memory!");
+		ERR(sh, "Out of memory!");
 		return -1;
 	}
 	if ((outfile = fopen(filename, "wb")) == NULL) {
 		sepol_policy_file_free(pf);
-		semanage_write_error(sh, "Could not open %s for writing.", filename);
+		ERR(sh, "Could not open %s for writing.", filename);
 		return -1;
 	}
 	sepol_policy_file_set_fp(pf, outfile);
 	retval = sepol_module_package_write(package, pf);
 	fclose(outfile);
 	if (retval == -1) {
-		semanage_write_error(sh, "Error while writing module to %s.", filename);
+		ERR(sh, "Error while writing module to %s.", filename);
 		return -1;
 	}
 	return 0;
@@ -268,11 +268,23 @@
 		goto cleanup;
 	}
 
-	/* expand and verify the resulting policy */
-	if (semanage_expand_sandbox(sh, base) < 0 ||
-	    semanage_verify_kernel(sh) != 0) {
+	/* Expand the resulting policy */
+	if (semanage_expand_sandbox(sh, base) < 0)
+		goto cleanup;
+
+#if 0
+	/* Link components into base policy */
+	if (semanage_base_merge_components(sh, NULL /* FIXME */) < 0)
+		goto cleanup;
+
+	/* Commit changes to components */
+	if (semanage_commit_components(sh) < 0)
+		goto cleanup;
+#endif
+
+	/* Verify policy */
+	if (semanage_verify_kernel(sh) != 0)
 		goto cleanup;
-	}
 
 	retval = semanage_install_sandbox(sh);
 
@@ -346,14 +358,14 @@
 				break;
 			}
 			else {
-				semanage_write_error(sh, "Previous module %s is same or newer.", module_name);
+				ERR(sh, "Previous module %s is same or newer.", module_name);
 				retval = -4;
 				goto cleanup;
 			}
 		}
 	}
 	if (retval == -4) {
-		semanage_write_error(sh, "There does not already exist a module named %s.", module_name);
+		ERR(sh, "There does not already exist a module named %s.", module_name);
 		goto cleanup;
 	}
 	if (write_file(sh, filename, data, data_len) == -1) {
@@ -409,7 +421,7 @@
 	for (i = 0; i < num_mod_files; i++) {
 		char *base = strrchr(module_filenames[i], '/');
 		if (base == NULL) {
-			semanage_write_error(sh, "Could not read module names.");
+			ERR(sh, "Could not read module names.");
 			retval = -2;
 			goto cleanup;
 		}
@@ -417,14 +429,14 @@
 		if (memcmp(module_name, base, name_len) == 0 &&
 		    strcmp(base + name_len, ".pp") == 0) {
 			if (unlink(module_filenames[i]) == -1) {
-				semanage_write_error(sh, "Could not remove module file %s.", module_filenames[i]);
+				ERR(sh, "Could not remove module file %s.", module_filenames[i]);
 				retval = -2;
 			}
 			retval = 0;
 			goto cleanup;
 		}
 	}
-	semanage_write_error(sh, "Module %s was not found.", module_name);
+	ERR(sh, "Module %s was not found.", module_name);
 	retval = -2;				/* module not found */
  cleanup:
 	for (i = 0; module_filenames != NULL && i < num_mod_files; i++) {
@@ -463,12 +475,12 @@
 	}
 
 	if (sepol_policy_file_create(&pf)) {
-		semanage_write_error(sh, "Out of memory!");
+		ERR(sh, "Out of memory!");
 		goto cleanup;
 	}
 	
 	if ((*modinfo = calloc(num_mod_files, sizeof(**modinfo))) == NULL) {
-		semanage_write_error(sh, "Out of memory!");
+		ERR(sh, "Out of memory!");
 		goto cleanup;
 	}
 	
diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libselinux --exclude policy_components.c old/libsemanage/src/handle.c exp/libsemanage/src/handle.c
--- old/libsemanage/src/handle.c	2005-10-06 16:43:33.000000000 -0400
+++ exp/libsemanage/src/handle.c	2005-10-11 02:21:29.000000000 -0400
@@ -41,11 +41,11 @@
 #define SEMANAGE_COMMIT_READ_WAIT 5
 
 semanage_handle_t *semanage_handle_create(void) {
-	semanage_handle_t *sh;
-	const char *conf_name;
+	semanage_handle_t *sh = NULL;
+	const char *conf_name = NULL;
 
 	/* Allocate handle */
-	if ((sh = calloc(1, sizeof(*sh))) == NULL)
+	if ((sh = calloc(1, sizeof(semanage_handle_t))) == NULL)
 		goto omem;
 
 	/* Policy root */
@@ -66,6 +66,10 @@
 	/* Set timeout: some default value for now, later use config */
 	sh->timeout = SEMANAGE_COMMIT_READ_WAIT; 
 
+	/* Set callback */
+	sh->callback = msg_default_handler;
+	sh->callback_arg = NULL;
+
 	/* Configure object databases 
 	 * Hardcore DATA FILE backend for now */
 	if (user_file_dbase_init(&sh->dbase[DBASE_USERS]) < 0)
@@ -130,19 +134,12 @@
 	free(sh);
 }
 
-const char *semanage_strerror(semanage_handle_t *sh) {
-	if (sh == NULL) {
-		return "Could not parse semange.conf or out of memory.";
-	}
-	return sh->err_buf;
-}
-
 /********************* public transaction functions *********************/
 
 int semanage_begin_transaction(semanage_handle_t *sh) {
 	assert(sh != NULL && sh->funcs != NULL && sh->funcs->begin_trans != NULL);
 	if (!sh->is_connected) {
-		semanage_write_error(sh, "Not connected.");
+		ERR(sh, "Not connected.");
 		return -1;
 	}
 	if (sh->is_in_transaction) {
@@ -160,7 +157,7 @@
 	int retval;
 	assert(sh != NULL && sh->funcs != NULL && sh->funcs->commit != NULL);
 	if (!sh->is_in_transaction) {
-		semanage_write_error(sh, "Will not commit because caller does not have a tranaction lock yet.");
+		ERR(sh, "Will not commit because caller does not have a tranaction lock yet.");
 		return -1;
 	}
 	retval = sh->funcs->commit(sh);
diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libselinux --exclude policy_components.c old/libsemanage/src/handle.h exp/libsemanage/src/handle.h
--- old/libsemanage/src/handle.h	2005-10-04 10:51:22.000000000 -0400
+++ exp/libsemanage/src/handle.h	2005-10-06 08:02:08.000000000 -0400
@@ -25,19 +25,21 @@
 
 #include <stddef.h>
 #include <semanage/handle.h>
+#include <semanage/debug.h>
 #include "modules.h"
 #include "semanage_conf.h"
-#include "policy_connection.h"
+#include "policy.h"
 #include "database.h"
 
 struct semanage_handle {
 	int con_id;             /* Connection ID */
 	int policy_serial;      /* Policy serial number at connect time */
 
-	/* Error management */
-	/* FIXME: re-design error system using callbacks (?) */
-#define SEMANAGE_ERRBUFSZ 1024
-	char err_buf[SEMANAGE_ERRBUFSZ];
+	/* Error callback */
+	void (*callback) (
+		void* varg,
+		semanage_message_t* msg);
+	void* callback_arg;
 
 	/* one of these connections will actually be used while
 	 * working with the module store -- the particular one if
diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libselinux --exclude policy_components.c old/libsemanage/src/modules.c exp/libsemanage/src/modules.c
--- old/libsemanage/src/modules.c	2005-09-30 16:19:07.000000000 -0400
+++ exp/libsemanage/src/modules.c	2005-10-11 02:21:08.000000000 -0400
@@ -37,11 +37,11 @@
 int semanage_module_install(semanage_handle_t *sh,
 			    char *module_data, size_t data_len) {
 	if (sh->funcs->install == NULL) {
-		semanage_write_error(sh, "No install function defined for this connection type.");
+		ERR(sh, "No install function defined for this connection type.");
 		return -1;
 	}
 	else if (!sh->is_connected) {
-		semanage_write_error(sh, "Not connected.");
+		ERR(sh, "Not connected.");
 		return -1;
 	}
 	else if (!sh->is_in_transaction) {
@@ -55,11 +55,11 @@
 int semanage_module_upgrade(semanage_handle_t *sh,
 			    char *module_data, size_t data_len) {
 	if (sh->funcs->upgrade == NULL) {
-		semanage_write_error(sh, "No upgrade function defined for this connection type.");
+		ERR(sh, "No upgrade function defined for this connection type.");
 		return -1;
 	}
 	else if (!sh->is_connected) {
-		semanage_write_error(sh, "Not connected.");
+		ERR(sh, "Not connected.");
 		return -1;
 	}
 	else if (!sh->is_in_transaction) {
@@ -73,11 +73,11 @@
 int semanage_module_install_base(semanage_handle_t *sh,
 				 char *module_data, size_t data_len) {
 	if (sh->funcs->install_base == NULL) {
-		semanage_write_error(sh, "No install base function defined for this connection type.");
+		ERR(sh, "No install base function defined for this connection type.");
 		return -1;
 	}
 	else if (!sh->is_connected) {
-		semanage_write_error(sh, "Not connected.");
+		ERR(sh, "Not connected.");
 		return -1;
 	}
 	else if (!sh->is_in_transaction) {
@@ -91,11 +91,11 @@
 int semanage_module_remove(semanage_handle_t *sh,
 			   char *module_name) {
 	if (sh->funcs->remove == NULL) {
-		semanage_write_error(sh, "No remove function defined for this connection type.");
+		ERR(sh, "No remove function defined for this connection type.");
 		return -1;
 	}
 	else if (!sh->is_connected) {
-		semanage_write_error(sh, "Not connected.");
+		ERR(sh, "Not connected.");
 		return -1;
 	}
 	else if (!sh->is_in_transaction) {
@@ -109,11 +109,11 @@
 int semanage_module_list(semanage_handle_t *sh,
 			 semanage_module_info_t **modinfo, int *num_modules) {
 	if (sh->funcs->list == NULL) {
-		semanage_write_error(sh, "No list function defined for this connection type.");
+		ERR(sh, "No list function defined for this connection type.");
 		return -1;
 	}
 	else if (!sh->is_connected) {
-		semanage_write_error(sh, "Not connected.");
+		ERR(sh, "Not connected.");
 		return -1;
 	}
 	return sh->funcs->list(sh, modinfo, num_modules);
diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libselinux --exclude policy_components.c old/libsemanage/src/modules.h exp/libsemanage/src/modules.h
--- old/libsemanage/src/modules.h	2005-09-30 16:19:07.000000000 -0400
+++ exp/libsemanage/src/modules.h	2005-10-11 02:43:10.000000000 -0400
@@ -23,11 +23,6 @@
 
 #include <semanage/modules.h>
 
-struct semanage_module_conn {
-	int translock_file_fd;
-	int readlock_file_fd;
-};
-
 struct semanage_module_info {
 	char *name;             /* Key */
 	char *version;
diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libselinux --exclude policy_components.c old/libsemanage/src/policy_connection.h exp/libsemanage/src/policy_connection.h
--- old/libsemanage/src/policy_connection.h	2005-10-04 10:51:22.000000000 -0400
+++ exp/libsemanage/src/policy_connection.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,55 +0,0 @@
-/* Author: Joshua Brindle <jbrindle@tresys.com>
- *         Jason Tang     <jtang@tresys.com>
- *
- * Copyright (C) 2005 Tresys Technology, LLC
- * Copyright (C) 2005 Red Hat Inc.
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#ifndef _SEMANAGE_POLICY_CONNECTION_INTERNAL_H_
-#define _SEMANAGE_POLICY_CONNECTION_INTERNAL_H_
-
-struct semanage_policy_table {
-
-	/* Destroy a connection */	
-        void (*destroy)(semanage_handle_t *);
-
-	/* Disconnect from policy */
-        int (*disconnect)(semanage_handle_t *);
-
-	/* Begin a policy transaction */
-        int (*begin_trans)(semanage_handle_t *);
-
-	/* Commit a policy transaction */
-        int (*commit)(semanage_handle_t *);
-
-	/* Install a policy module */
-        int (*install)(semanage_handle_t *, char *, size_t);
-
-	/* Upgrade a policy module */
-        int (*upgrade)(semanage_handle_t *, char *, size_t);
-
-	/* Remove a policy module */
-	int (*remove)(semanage_handle_t *, char *);
-
-	/* List policy modules */
-	int (*list)(semanage_handle_t *, semanage_module_info_t **, int *);
-
-	/* Install base policy */
-        int (*install_base)(semanage_handle_t *, char *, size_t);
-};
-
-#endif
diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libselinux --exclude policy_components.c old/libsemanage/src/policy.h exp/libsemanage/src/policy.h
--- old/libsemanage/src/policy.h	1969-12-31 19:00:00.000000000 -0500
+++ exp/libsemanage/src/policy.h	2005-10-11 02:46:00.000000000 -0400
@@ -0,0 +1,77 @@
+/* Author: Joshua Brindle <jbrindle@tresys.com>
+ *         Jason Tang     <jtang@tresys.com>
+ *
+ * Copyright (C) 2005 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef _SEMANAGE_POLICY_INTERNAL_H_
+#define _SEMANAGE_POLICY_INTERNAL_H_
+
+#include "modules.h"
+
+/* Circular dependency */
+struct semanage_handle;
+
+/* Connection Locking */
+struct semanage_module_conn {
+	int translock_file_fd;
+	int readlock_file_fd;
+};
+
+/* Backend dependent portion */
+struct semanage_policy_table {
+
+	/* Destroy a connection */	
+        void (*destroy)(struct semanage_handle*);
+
+	/* Disconnect from policy */
+        int (*disconnect)(struct semanage_handle*);
+
+	/* Begin a policy transaction */
+        int (*begin_trans)(struct semanage_handle*);
+
+	/* Commit a policy transaction */
+        int (*commit)(struct semanage_handle*);
+
+	/* Install a policy module */
+        int (*install)(struct semanage_handle*, char *, size_t);
+
+	/* Upgrade a policy module */
+        int (*upgrade)(struct semanage_handle*, char *, size_t);
+
+	/* Remove a policy module */
+	int (*remove)(struct semanage_handle*, char *);
+
+	/* List policy modules */
+	int (*list)(struct semanage_handle*, semanage_module_info_t **, int *);
+
+	/* Install base policy */
+        int (*install_base)(struct semanage_handle*, char *, size_t);
+};
+
+#if 0
+/* Should be backend independent */
+extern int semanage_base_merge_components(
+	struct semanage_handle* handle,
+	semanage_module_info_t* base);
+
+extern int semanage_commit_components(
+	struct semanage_handle* handle);
+#endif
+
+#endif
diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libselinux --exclude policy_components.c old/libsemanage/src/semanage_store.c exp/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2005-10-07 18:38:00.000000000 -0400
+++ exp/libsemanage/src/semanage_store.c	2005-10-11 02:20:49.000000000 -0400
@@ -205,18 +205,18 @@
 	if (stat(path, &sb) == -1) {
 		if (errno == ENOENT && create) {
 			if (mkdir(path, S_IRWXU) == -1) {
-				semanage_write_error(sh, "Could not create module store at %s.", path);
+				ERR(sh, "Could not create module store at %s.", path);
 				return -2;
 			}
 		}
 		else {
-			semanage_write_error(sh, "Could not read from module store at %s.", path);
+			ERR(sh, "Could not read from module store at %s.", path);
 			return -1;
 		}
 	}
 	else {
 		if (!S_ISDIR(sb.st_mode) || access(path, mode_mask) == -1) {
-			semanage_write_error(sh, "Could not access module store at %s, or it is not a directory.", path);
+			ERR(sh, "Could not access module store at %s, or it is not a directory.", path);
 			return -1;
 		}
 	}
@@ -224,18 +224,18 @@
 	if (stat(path, &sb) == -1) {
 		if (errno == ENOENT && create) {
 			if (mkdir(path, S_IRWXU) == -1) {
-				semanage_write_error(sh, "Could not create module store, active subdirectory at %s.", path);
+				ERR(sh, "Could not create module store, active subdirectory at %s.", path);
 				return -2;
 			}
 		}
 		else {
-			semanage_write_error(sh, "Could not read from module store, active subdirectory at %s.", path);
+			ERR(sh, "Could not read from module store, active subdirectory at %s.", path);
 			return -1;
 		}
 	}
 	else {
 		if (!S_ISDIR(sb.st_mode) || access(path, mode_mask) == -1) {
-			semanage_write_error(sh, "Could not access module store active subdirectory at %s, or it is not a directory.", path);
+			ERR(sh, "Could not access module store active subdirectory at %s, or it is not a directory.", path);
 			return -1;
 		}
 	}
@@ -243,18 +243,18 @@
 	if (stat (path, &sb) == -1) {
 		if (errno == ENOENT && create) {
 			if (mkdir(path, S_IRWXU) == -1) {
-				semanage_write_error(sh, "Could not create module store, active modules subdirectory at %s.", path);
+				ERR(sh, "Could not create module store, active modules subdirectory at %s.", path);
 				return -2;
 			}
 		}
 		else {
-			semanage_write_error(sh, "Could not read from module store, active modules subdirectory at %s.", path);
+			ERR(sh, "Could not read from module store, active modules subdirectory at %s.", path);
 			return -1;
 		}
 	}
 	else {
 		if (!S_ISDIR(sb.st_mode) || access(path, mode_mask) == -1) {
-			semanage_write_error(sh, "Could not access module store active modules subdirectory at %s, or it is not a directory.", path);
+			ERR(sh, "Could not access module store active modules subdirectory at %s, or it is not a directory.", path);
 			return -1;
 		}
 	}
@@ -395,21 +395,21 @@
 
 	if (stat(sandbox, &buf) == -1) {
 		if (errno != ENOENT) {
-			semanage_write_error(sh, "Error scanning directory %s.", sandbox);
+			ERR(sh, "Error scanning directory %s.", sandbox);
 			return -1;
 	       }
 	}
 	else {
 		/* remove the old sandbox */
 		if (semanage_remove_directory(sandbox) != 0) {
-			semanage_write_error(sh, "Error removing old sandbox directory %s.", sandbox);
+			ERR(sh, "Error removing old sandbox directory %s.", sandbox);
 			return -1;
 		}
 	}
 
 	if (mkdir(sandbox, S_IRWXU) == -1 ||
 	    semanage_copy_dir(semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL), sandbox) == -1) {
-		semanage_write_error(sh, "Could not copy files to sandbox %s.", sandbox);
+		ERR(sh, "Could not copy files to sandbox %s.", sandbox);
 		goto cleanup;
 	}
 	return 0;
@@ -441,7 +441,7 @@
 	*len = 0;
 	if ((num_files = scandir(modules_path, &namelist,
 				 semanage_filename_select, alphasort)) == -1) {
-		semanage_write_error(sh, "Error while scanning directory %s.", modules_path);
+		ERR(sh, "Error while scanning directory %s.", modules_path);
 		goto cleanup;
 	}
 	if (num_files == 0) {
@@ -449,7 +449,7 @@
 		goto cleanup;
 	}	
 	if ((*filenames = (char **) calloc(num_files, sizeof(**filenames))) == NULL) {
-		semanage_write_error(sh, "Out of memory!");
+		ERR(sh, "Out of memory!");
 		goto cleanup;
 	}	
 	for (i = 0; i < num_files; i++) {
@@ -459,7 +459,7 @@
 		snprintf(path, PATH_MAX, "%s/%s", modules_path, namelist[i]->d_name);
 		if ((filename = strdup(path)) == NULL) {
 			int j;
-			semanage_write_error(sh, "Out of memory!");
+			ERR(sh, "Out of memory!");
 			for (j = 0; j < i; j++) {
 				free((*filenames)[j]);
 			}
@@ -502,12 +502,12 @@
 	memset(write_buf, 0, sizeof(write_buf));
 	snprintf(write_buf, sizeof(write_buf), "%d", commit_number);
 	if ((fd = open(commit_filename, O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR)) == -1) {
-		semanage_write_error(sh, "Could not open commit number file %s for writing.", commit_filename);
+		ERR(sh, "Could not open commit number file %s for writing.", commit_filename);
 		return -1;
 	}
 	amount_written = write(fd, write_buf, sizeof(write_buf));
 	if (amount_written == -1) {
-		semanage_write_error(sh, "Error while writing commit number to %s.", commit_filename);
+		ERR(sh, "Error while writing commit number to %s.", commit_filename);
 		close(fd);
 		return -1;
 	}
@@ -517,21 +517,21 @@
 	if (stat(backup, &buf) == 0) {
 		if (S_ISDIR(buf.st_mode) && 
 		    semanage_remove_directory(backup) != 0) {
-			semanage_write_error(sh, "Could not remove previous backup %s.", backup);
+			ERR(sh, "Could not remove previous backup %s.", backup);
 			return -1;
 		}
 	}
 	else if (errno != ENOENT) {
-		semanage_write_error(sh, "Could not stat directory %s.", backup);
+		ERR(sh, "Could not stat directory %s.", backup);
 		return -1;
 	}
 
 	if (rename(active, backup) == -1) {
-		semanage_write_error(sh, "Error while renaming %s to %s.", active, backup);
+		ERR(sh, "Error while renaming %s to %s.", active, backup);
 		return -1;
 	}
 	if (rename(sandbox, active) == -1) {
-		semanage_write_error(sh, "Error while renaming %s to %s.", sandbox, active);
+		ERR(sh, "Error while renaming %s to %s.", sandbox, active);
 		/* note that if an error occurs during the next
 		 * function then the store will be left in an
 		 * inconsistent state */
@@ -788,14 +788,14 @@
 	pid_t forkval;
 
 	if ((argv = split_args(e->path, e->args, new_name, old_name)) == NULL) {
-		semanage_write_error(sh, "Out of memory!");
+		ERR(sh, "Out of memory!");
 		return -1;
 	}
 	
 	/* no need to use pthread_atfork() -- child will not be using
 	 * any mutexes. */
 	if ((forkval = fork()) == -1) {
-		semanage_write_error(sh, "Error while forking process.");
+		ERR(sh, "Error while forking process.");
 		return -1;
 	}
 	else if (forkval == 0) {
@@ -809,7 +809,7 @@
 		int status = 0;
 		free_argv(argv);
 		if (waitpid(forkval, &status, 0) == -1 || !WIFEXITED(status)) {
-			semanage_write_error(sh, "Child process %s did not exit cleanly.", e->path);
+			ERR(sh, "Child process %s did not exit cleanly.", e->path);
 			return -1;
 		}
 		return WEXITSTATUS(status);
@@ -829,20 +829,20 @@
 	snprintf(running_policy, PATH_MAX, "%s.%d",
 		 selinux_binary_policy_path(), security_policyvers());
 	if (semanage_copy_file(active_kernel, running_policy) == -1) {
-		semanage_write_error(sh, "Could not copy %s to %s.", active_kernel, running_policy);
+		ERR(sh, "Could not copy %s to %s.", active_kernel, running_policy);
 		goto cleanup;
 	}
 	if (semanage_copy_file(active_fc, running_fc) == -1) {
-		semanage_write_error(sh, "Could not copy %s to %s.", active_fc, running_fc);
+		ERR(sh, "Could not copy %s to %s.", active_fc, running_fc);
 		goto cleanup;
 	}
 	if ((r = semanage_exec_prog(sh, sh->conf->load_policy, running_policy, "")) != 0) {
-		semanage_write_error(sh, "load_policy returned error code %d.", r);
+		ERR(sh, "load_policy returned error code %d.", r);
 		goto cleanup;
 	}
 	
 	if ((r = semanage_exec_prog(sh, sh->conf->setfiles, running_policy, running_fc)) != 0) {
-		semanage_write_error(sh, "setfiles returned error code %d.", r);
+		ERR(sh, "setfiles returned error code %d.", r);
 		goto cleanup;
 	}
 	retval = 0;
@@ -861,11 +861,11 @@
 	int retval = -1, new_commit_number;
 
 	if (sh->conf->load_policy == NULL) {
-		semanage_write_error(sh, "No load_policy program specified in configuration file.");
+		ERR(sh, "No load_policy program specified in configuration file.");
 		goto cleanup;
 	}
 	if (sh->conf->setfiles == NULL) {
-		semanage_write_error(sh, "No setfiles program specified in configuration file.");
+		ERR(sh, "No setfiles program specified in configuration file.");
 		goto cleanup;
 	}
 
@@ -904,7 +904,7 @@
 	int got_lock = 0;
 
 	if ((fd = open(lock_file, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR)) == -1) {
-		semanage_write_error(sh, "Could not open direct %s at %s.", lock_name, lock_file);
+		ERR(sh, "Could not open direct %s at %s.", lock_name, lock_file);
 		return -1;
 	}
 	if (sh->timeout == 0) {
@@ -923,7 +923,7 @@
 			break;
 		}
 		else if (errno != EAGAIN) {
-			semanage_write_error(sh, "Error obtaining direct %s at %s.", lock_name, lock_file);
+			ERR(sh, "Error obtaining direct %s at %s.", lock_name, lock_file);
 			close(fd);
 			return -1;
 		}
@@ -932,7 +932,7 @@
 				if (errno == EINTR) {
 					continue;
 				}
-				semanage_write_error(sh, "Error while waiting to get direct %s at %s.", lock_name, lock_file);
+				ERR(sh, "Error while waiting to get direct %s at %s.", lock_name, lock_file);
 				close(fd);
 				return -1;
 			}
@@ -940,7 +940,7 @@
 		}
 	} while (origtime.tv_sec > 0 || sh->timeout == -1);
 	if (!got_lock) {
-		semanage_write_error(sh, "Could not get direct %s at %s.", lock_name, lock_file);
+		ERR(sh, "Could not get direct %s at %s.", lock_name, lock_file);
 		close(fd);
 		return -1;
 	}
@@ -1030,14 +1030,14 @@
 			return 0;
 		}
 		else {
-			semanage_write_error(sh, "Could not open commit number file %s.", commit_filename);
+			ERR(sh, "Could not open commit number file %s.", commit_filename);
 			return -1;
 		}
 	}
 
 	amount_read = read(fd, buf, sizeof(buf));
 	if (amount_read == -1) {
-		semanage_write_error(sh, "Error while reading commit number from %s.", commit_filename);
+		ERR(sh, "Error while reading commit number from %s.", commit_filename);
 		commit_number = -1;
 	}
 	else if (sscanf(buf, "%d", &commit_number) != 1) {
@@ -1046,7 +1046,7 @@
 	}
 	else if (commit_number < 0) {
 		/* read file ought never have negative values */
-		semanage_write_error(sh, "Commit number file %s is corrupted; it should only contain a non-negative integer.", commit_filename);
+		ERR(sh, "Commit number file %s is corrupted; it should only contain a non-negative integer.", commit_filename);
 		commit_number = -1;
 	}
 
@@ -1068,22 +1068,22 @@
 
 	*package = NULL;
 	if (sepol_module_package_create(package) == -1) {
-		semanage_write_error(sh, "Out of memory!");
+		ERR(sh, "Out of memory!");
 		return -1;
 	}
 
 	if (sepol_policy_file_create(&pf)) {
-		semanage_write_error(sh, "Out of memory!");
+		ERR(sh, "Out of memory!");
 		goto cleanup;
 	}
 
 	if ((fp = fopen(filename, "rb")) == NULL) {
-		semanage_write_error(sh, "Could not open module file %s for reading.", filename);
+		ERR(sh, "Could not open module file %s for reading.", filename);
 		goto cleanup;
 	}
 	sepol_policy_file_set_fp(pf, fp);
 	if (sepol_module_package_read(*package, pf, 0) == -1) {
-		semanage_write_error(sh, "Error while reading from module file %s.", filename);
+		ERR(sh, "Error while reading from module file %s.", filename);
 		fclose(fp);
 		goto cleanup;
 	}
@@ -1113,6 +1113,12 @@
 	int retval = -1, i;
 	int num_modules = 0;
 	sepol_module_package_t **mods = NULL;
+
+	/* FIXME: deprecated - replace with callback debugging
+	 * through a sepol state object */
+	char buffer[1024];
+	buffer[0] = '\0';
+
 	*base = NULL;
 
 	/* first make sure that base module is readable */
@@ -1120,7 +1126,7 @@
 		goto cleanup;
 	}
 	if (access(base_filename, R_OK) == -1) {
-		semanage_write_error(sh, "Could not access sandbox base file %s.", base_filename);
+		ERR(sh, "Could not access sandbox base file %s.", base_filename);
 		goto cleanup;
 	}
 
@@ -1135,7 +1141,7 @@
 		goto cleanup;
 	}
 	if ((mods = calloc(num_modules, sizeof(*mods))) == NULL) {
-		semanage_write_error(sh, "Out of memory!");
+		ERR(sh, "Out of memory!");
 		num_modules  = 0;
 		goto cleanup;
 	}
@@ -1145,10 +1151,15 @@
 		}
 	}
 
-	if (sepol_link_packages(*base, mods, num_modules, 0, sh->err_buf,
-				SEMANAGE_ERRBUFSZ) != 0) {
+	if (sepol_link_packages(*base, mods, num_modules, 
+			0, buffer, 1024) != 0) {
+		if (*buffer != '\0') 
+			ERR(sh, "%s", buffer);	
 		goto cleanup;
 	}
+	if (*buffer != '\0') 
+		WARN(sh, "%s", buffer);
+
 	retval = 0;
 
  cleanup:
@@ -1175,6 +1186,11 @@
 	int policyvers = security_policyvers();
 	FILE *outfile = NULL;
 
+	/* FIXME: deprecated - replace with callback debugging
+	 * through a sepol state object */
+	char buffer[1024];
+	buffer[0] = '\0';
+
 	if (policyvers < sepol_policy_kern_vers_min() || 
 	    policyvers > sepol_policy_kern_vers_max())
 		policyvers = sh->conf->policyvers;
@@ -1183,27 +1199,32 @@
 		return -1;
 	}
 	if (sepol_expand_module(base->policy, out, 0,
-			  sh->err_buf, SEMANAGE_ERRBUFSZ) == -1) {
+			  buffer, 1024) != -1) {
+		if (*buffer != '\0') 
+			ERR(sh, "%s", buffer);
 		goto cleanup;
 	}
+	if (*buffer != '\0') 
+		WARN(sh, "%s", buffer);
+
 	if (sepol_policydb_set_vers(out, policyvers)) {
-		semanage_write_error(sh, "Unknown/Invalid policy version %d.", sh->conf->policyvers);
+		ERR(sh, "Unknown/Invalid policy version %d.", sh->conf->policyvers);
 		goto cleanup;
 	}
 	if ((kernel_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_KERNEL)) == NULL) {
 		goto cleanup;
 	}
 	if ((outfile = fopen(kernel_filename, "wb")) == NULL) {
-		semanage_write_error(sh, "Could not open kernel policy %s for writing.", kernel_filename);
+		ERR(sh, "Could not open kernel policy %s for writing.", kernel_filename);
 		goto cleanup;
 	}
 	if (sepol_policy_file_create(&pf)) {
-		semanage_write_error(sh, "Out of memory!");
+		ERR(sh, "Out of memory!");
 		goto cleanup;
 	}
 	sepol_policy_file_set_fp(pf, outfile);
 	if (sepol_policydb_write(out, pf) == -1) {
-		semanage_write_error(sh, "Error while writing kernel policy to %s.", kernel_filename);
+		ERR(sh, "Error while writing kernel policy to %s.", kernel_filename);
 		goto cleanup;
 	}
 	retval = 0;

--------------020203080108000400000203--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
