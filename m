Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9DCEtNs023175
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 08:14:56 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9DCDD5H011763
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 12:13:13 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j9DCCr5w017902
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 08:12:53 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j9DCCrRK017901
	for selinux@tycho.nsa.gov; Thu, 13 Oct 2005 08:12:53 -0400
Message-ID: <434E38C2.9030602@cornell.edu>
Date: Thu, 13 Oct 2005 06:36:50 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [ SEPOL ] [ SEMANAGE ] Debug v3, some database things 
References: <434CC592.70001@cornell.edu>	 <1129132332.3308.288.camel@moss-spartans.epoch.ncsc.mil>	 <434D35B1.7060409@cornell.edu> <1129133080.3308.294.camel@moss-spartans.epoch.ncsc.mil> <434D3D33.90104@cornell.edu>
In-Reply-To: <434D3D33.90104@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------050403020506040400050801"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050403020506040400050801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

...resending patch again...

Everything from before, plus:

- newline removed from all ERR calls (justification is that info stream 
is already logically chopped into messages) - callback can write 
separator of choice.
- newline added to default semanage handler
- newline _not_ added to sepol handler, until DEBUG is eradicated
- sepol_enable_debug and sepol_disable debug dropped, and removed from 
the interface. sepol_debug is kept, since it has been around for a while 
during official releases, and has users (plus it's trivial to implement 
using new system)

- added my policy_components.c file - kind of work in progress, but it 
might give you an idea of what I plan to do. Those NULL arguments should 
probably be calling the functions in [users/ports]_policy.c, that are 
currently if-deff'ed out (or at least calling handlers that call those 
functions). Things that are in this file, should, ideally, be backend 
independent, so I don't want to see them being copied in 5 places 
depending on whether we use files, policy servers, LDAP, or whatever - 
that's why we use interfaces, and not implementations. You can also see 
I've put modules in there (commented out), since I hope I can make the 
list of modules appear as a database someday.... 
- added some database fixes for modified parameter
- added a couple of functions to attach/detach direct database from a 
policydb object for sharing (those are specific to direct backend, and 
not added to the database interface).

- draw in all sepol headers into sepol.h


--------------050403020506040400050801
Content-Type: text/x-patch;
 name="resync.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="resync.diff"

diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/include/semanage/debug.h new/libsemanage/include/semanage/debug.h
--- old/libsemanage/include/semanage/debug.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/include/semanage/debug.h	2005-10-12 03:44:05.000000000 -0400
@@ -0,0 +1,58 @@
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
+#define SEMANAGE_MSG_ERR  1
+#define SEMANAGE_MSG_WARN 2
+#define SEMANAGE_MSG_INFO 3
+
+extern int semanage_msg_get_level(
+	semanage_handle_t* handle);
+
+extern const char* semanage_msg_get_channel(
+	semanage_handle_t* handle);
+
+extern const char* semanage_msg_get_fname(
+	semanage_handle_t* handle);
+
+/* Set the messaging callback. 
+ * By the default, the callback will print
+ * the message on standard output, in a 
+ * particular format. Passing NULL here
+ * indicates that messaging should be suppressed */
+extern void semanage_msg_set_callback(
+	semanage_handle_t* handle,
+#ifdef __GNUC__
+	__attribute__ ((format (printf, 3, 4)))
+#endif
+	void (*msg_callback) (
+		void* varg,
+		semanage_handle_t* handle,
+		const char* fmt,
+		...),
+	void* msg_callback_arg);
+
+#endif 
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/include/semanage/handle.h new/libsemanage/include/semanage/handle.h
--- old/libsemanage/include/semanage/handle.h	2005-09-28 15:56:00.000000000 -0400
+++ new/libsemanage/include/semanage/handle.h	2005-10-11 01:59:36.000000000 -0400
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
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/include/semanage/semanage.h new/libsemanage/include/semanage/semanage.h
--- old/libsemanage/include/semanage/semanage.h	2005-09-28 15:56:00.000000000 -0400
+++ new/libsemanage/include/semanage/semanage.h	2005-10-11 01:59:45.000000000 -0400
@@ -23,6 +23,7 @@
 
 #include <semanage/handle.h>
 #include <semanage/modules.h>
+#include <semanage/debug.h>
 
 /*
  * Explicit libsemanage initialization.
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/src/database_direct.c new/libsemanage/src/database_direct.c
--- old/libsemanage/src/database_direct.c	2005-10-07 23:43:17.000000000 -0400
+++ new/libsemanage/src/database_direct.c	2005-10-12 02:38:15.000000000 -0400
@@ -3,6 +3,7 @@
 #define DBASE_DEFINED
 
 #include <stdlib.h>
+#include <string.h>
 #include <stdio.h>
 #include <fcntl.h>
 #include <sys/types.h>
@@ -31,6 +32,7 @@
 	sepol_policydb_t* policy;
 	int cached;
 	int modified;
+	int attached;
 };
 
 static int construct_filename(
@@ -66,7 +68,7 @@
 	char* fname = NULL;
 
 	/* Already cached */
-	if (dbase->cached)
+	if (dbase->cached || dbase->attached)
 		return STATUS_SUCCESS;
 	
 	if (construct_filename(handle, dbase, &fname) < 0)
@@ -128,11 +130,10 @@
 	if (!dbase->modified || !dbase->cached)
 		return STATUS_SUCCESS;
 
-	/* FIXME: sepol_policydb_to_image always writes a KERN policy */
+	dbase->modified = 0;
 
 	/* Stub */
 	handle = NULL;
-	dbase = NULL;
 	return STATUS_SUCCESS;
 }
 
@@ -144,6 +145,7 @@
 	if (dbase->cached) {
 		sepol_policydb_free(dbase->policy);
 		dbase->cached = 0;
+		dbase->modified = 0;
 	}
 
 	handle = NULL;
@@ -219,6 +221,7 @@
 	tmp_dbase->policy = NULL;
 	tmp_dbase->cached = 0;
 	tmp_dbase->modified = 0;
+	tmp_dbase->attached = 0;
 	*dbase = tmp_dbase;
 
 	return STATUS_SUCCESS;
@@ -239,6 +242,29 @@
 	free(dbase);
 }
 
+/* Attach to a shared policydb.
+ * This implies drop_cache(),
+ * and prevents flush() and drop_cache()
+ * until detached. */
+void dbase_direct_attach(
+        semanage_handle_t* handle,
+        dbase_direct_t* dbase,
+        sepol_policydb_t* policydb) {
+
+	dbase->attached = 1;
+	dbase_direct_drop_cache(handle, dbase);
+	dbase->policy = policydb;
+}
+
+/* Detach from a shared policdb.
+ * This implies drop_cache. */
+void dbase_direct_detach(
+	semanage_handle_t* handle,
+	dbase_direct_t* dbase) {
+
+	dbase->attached = 0;
+}
+
 static int dbase_direct_add (
 	semanage_handle_t* handle,
 	dbase_direct_t* dbase,
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/src/database_direct.h new/libsemanage/src/database_direct.h
--- old/libsemanage/src/database_direct.h	2005-10-07 18:37:59.000000000 -0400
+++ new/libsemanage/src/database_direct.h	2005-10-12 02:38:27.000000000 -0400
@@ -12,7 +12,7 @@
 typedef struct record_direct_table {
 
 	/* Add record into the policy database */
-	int (*add) (sepol_policydb_t* policy, record_t* record);
+	int (*add) (sepol_policydb_t* policydb, record_t* record);
 
 	/* Modify record into the policy database */
 	int (*modify) (sepol_policydb_t* policydb, record_t* record);
@@ -32,6 +32,21 @@
 	record_direct_table_t* rptable,
 	dbase_direct_t** dbase);
 
+/* Attach to a shared policydb.
+ * This implies drop_cache().
+ * and prevents flush() and drop_cache()
+ * until detached. */ 
+extern void dbase_direct_attach(
+	semanage_handle_t* handle,
+	dbase_direct_t* dbase,
+	sepol_policydb_t* policydb);
+
+/* Detach from a shared policdb.
+ * This implies drop_cache. */
+extern void dbase_direct_detach(
+	semanage_handle_t* handle,
+	dbase_direct_t* dbase);
+
 /* Release allocated resources */
 extern void dbase_direct_release(
 	semanage_handle_t* handle,
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-10-07 18:37:59.000000000 -0400
+++ new/libsemanage/src/database_file.c	2005-10-11 09:56:58.000000000 -0400
@@ -170,6 +170,7 @@
 	}
 
 	dbase->cached = 0;
+	dbase->modified = 0;
 	handle = NULL;
 }	
 
@@ -199,6 +200,7 @@
 			goto err;
 	}
 
+	dbase->modified = 0;
 	fclose(str);
 	free(fname);
 	return STATUS_SUCCESS;
@@ -237,7 +239,6 @@
 	dbase_file_drop_cache(handle, dbase);
 }
 
-
 static int enter_rw(
 	semanage_handle_t* handle,
 	dbase_file_t* dbase) {
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/src/debug.c new/libsemanage/src/debug.c
--- old/libsemanage/src/debug.c	2005-09-30 16:19:07.000000000 -0400
+++ new/libsemanage/src/debug.c	2005-10-13 05:46:40.000000000 -0400
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
@@ -19,20 +21,72 @@
  */
 
 #include <stdarg.h>
+#include <stdlib.h>
 #include <stdio.h>
 #include "handle.h"
 #include "debug.h"
 
-/* FIXME: redesign with callbacks ? */
+int semanage_msg_get_level(semanage_handle_t* handle) {
+	return handle->msg_level;
+}
+
+const char* semanage_msg_get_channel(semanage_handle_t* handle) {
+	return handle->msg_channel;
+}
+
+const char* semanage_msg_get_fname(semanage_handle_t* handle) {
+	return handle->msg_fname;
+}
 
-/* Write an error message to the current error buffer, up to the
- * buffer's specified size. */
 #ifdef __GNUC__
-__attribute__ ((format (printf, 2, 3)))
+__attribute__ ((format (printf, 3, 4)))
 #endif
-void semanage_write_error(semanage_handle_t *sh, char *fmt, ...) {
+void semanage_msg_default_handler(
+	void* varg,
+	semanage_handle_t* handle,
+	const char* fmt,
+	...) {
+
+	FILE* stream = NULL;
+
+	switch(semanage_msg_get_level(handle)) {
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
+	fprintf(stream, "%s.%s: ",
+		semanage_msg_get_channel(handle),
+		semanage_msg_get_fname(handle));
+
 	va_list ap;
-	va_start(ap, fmt);
-	vsnprintf(sh->err_buf, SEMANAGE_ERRBUFSZ, fmt, ap);
+	va_start(ap,fmt);
+	vfprintf(stream, fmt, ap);	
 	va_end(ap);
+
+	fprintf(stream, "\n");
+
+	varg = NULL;
+}
+
+extern void semanage_msg_set_callback(
+	semanage_handle_t* handle,
+#ifdef __GNUC__
+	__attribute__ ((format (printf, 3, 4)))
+#endif
+	void (*msg_callback) (
+		void* varg,
+		semanage_handle_t* handle,
+		const char* fmt,
+		...),
+	void* msg_callback_arg) {
+
+	handle->msg_callback = msg_callback;
+	handle->msg_callback_arg = msg_callback_arg;
 }
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/src/debug.h new/libsemanage/src/debug.h
--- old/libsemanage/src/debug.h	2005-09-30 16:19:07.000000000 -0400
+++ new/libsemanage/src/debug.h	2005-10-12 03:40:56.000000000 -0400
@@ -20,20 +20,50 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#ifndef _SEPOL_INTERNAL_DEBUG_H_
-#define _SEPOL_INTERNAL_DEBUG_H_
+#ifndef _SEMANAGE_INTERNAL_DEBUG_H_
+#define _SEMANAGE_INTERNAL_DEBUG_H_
 
+#include <stdio.h>
+#include <semanage/debug.h>
 #include "handle.h"
 
 #define STATUS_SUCCESS 0
 #define STATUS_ERR -1
 #define STATUS_NODATA 1
 
-/* FIXME: redesign with level argument ? */
+#define msg_write(handle_arg, level_arg,                   \
+	          channel_arg, func_arg, ...) {            \
+                                                           \
+        if (handle_arg->msg_callback) {                    \
+                handle_arg->msg_fname = func_arg;          \
+                handle_arg->msg_channel = channel_arg;     \
+                handle_arg->msg_level = level_arg;         \
+                                                           \
+                handle_arg->msg_callback(                  \
+                        handle_arg->msg_callback_arg,      \
+                        handle_arg, __VA_ARGS__);          \
+        }                                                  \
+}
+
+#define ERR(handle, ...) \
+	msg_write(handle, SEMANAGE_MSG_ERR, "libsemanage", \
+	__FUNCTION__, __VA_ARGS__)
+
+#define INFO(handle, ...) \
+	msg_write(handle, SEMANAGE_MSG_INFO, "libsemanage", \
+	__FUNCTION__, __VA_ARGS__)
+
+#define WARN(handle, ...) \
+	msg_write(handle, SEMANAGE_MSG_WARN, "libsemanage", \
+	__FUNCTION__, __VA_ARGS__)
 
 #ifdef __GNUC__
-__attribute__ ((format (printf, 2, 3)))
+__attribute__ ((format (printf, 3, 4)))
 #endif
-extern void semanage_write_error(semanage_handle_t *sh, char *fmt, ...);
+extern void semanage_msg_default_handler(
+	void* varg,
+	semanage_handle_t* handle,
+	const char* fmt, 
+	...);
 
 #endif 
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-10-07 18:37:59.000000000 -0400
+++ new/libsemanage/src/direct_api.c	2005-10-13 06:08:23.000000000 -0400
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
@@ -253,8 +253,6 @@
 		goto cleanup;
 	}
 
-	/* FIXME: write object databases into base */
-
 	/* write the linked base */
 	if ((linked_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED)) == NULL ||
 	    semanage_write_module(sh, linked_filename, base) == -1 ||
@@ -268,11 +266,23 @@
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
 
@@ -346,14 +356,14 @@
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
@@ -409,7 +419,7 @@
 	for (i = 0; i < num_mod_files; i++) {
 		char *base = strrchr(module_filenames[i], '/');
 		if (base == NULL) {
-			semanage_write_error(sh, "Could not read module names.");
+			ERR(sh, "Could not read module names.");
 			retval = -2;
 			goto cleanup;
 		}
@@ -417,14 +427,14 @@
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
@@ -463,12 +473,12 @@
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
 	
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/src/handle.c new/libsemanage/src/handle.c
--- old/libsemanage/src/handle.c	2005-10-06 16:43:33.000000000 -0400
+++ new/libsemanage/src/handle.c	2005-10-13 05:45:39.000000000 -0400
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
+	sh->msg_callback = semanage_msg_default_handler;
+	sh->msg_callback_arg = NULL;
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
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/src/handle.h new/libsemanage/src/handle.h
--- old/libsemanage/src/handle.h	2005-10-04 10:51:22.000000000 -0400
+++ new/libsemanage/src/handle.h	2005-10-12 03:38:42.000000000 -0400
@@ -27,17 +27,27 @@
 #include <semanage/handle.h>
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
+	/* Error handling */
+	int msg_level;
+	const char* msg_channel;
+	const char* msg_fname;
+#ifdef __GNUC__
+	__attribute__ ((format (printf, 3, 4)))
+#endif
+	void (*msg_callback) (
+		void* varg,
+		semanage_handle_t* handle,
+		const char* fmt,
+		...);
+	void* msg_callback_arg;
+	/* ================ */
 
 	/* one of these connections will actually be used while
 	 * working with the module store -- the particular one if
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/src/libsemanage.map new/libsemanage/src/libsemanage.map
--- old/libsemanage/src/libsemanage.map	2005-10-07 23:50:41.000000000 -0400
+++ new/libsemanage/src/libsemanage.map	2005-10-11 14:00:14.000000000 -0400
@@ -1,7 +1,7 @@
 LIBSEMANAGE_1.0 {
   global: semanage_handle_create; semanage_handle_destroy; 
           semanage_connect; semanage_disconnect; 
-          semanage_strerror; 
+	  semanage_msg_*;
           semanage_begin_transaction; semanage_commit;
           semanage_module_install; semanage_module_upgrade;
 	  semanage_module_install_base; semanage_module_remove;
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/src/modules.c new/libsemanage/src/modules.c
--- old/libsemanage/src/modules.c	2005-09-30 16:19:07.000000000 -0400
+++ new/libsemanage/src/modules.c	2005-10-13 05:45:22.000000000 -0400
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
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/src/modules.h new/libsemanage/src/modules.h
--- old/libsemanage/src/modules.h	2005-09-30 16:19:07.000000000 -0400
+++ new/libsemanage/src/modules.h	2005-10-11 02:43:10.000000000 -0400
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
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2005-10-13 06:06:05.000000000 -0400
@@ -0,0 +1,86 @@
+#include "policy.h"
+#include "handle.h"
+#include "database.h"
+#include "modules.h"
+#include "debug.h"
+
+int semanage_base_merge_components(
+	semanage_handle_t* handle,
+	semanage_module_info_t* base) {
+
+	//dbase_config_t* modules = dbase_modules_dbase(handle);
+	//dbase_config_t* interfaces = semanage_iface_dbase(handle);
+	//dbase_config_t* booleans = semanage_bool_dbase(handle);
+	dbase_config_t* users = semanage_user_dbase(handle);
+	dbase_config_t* ports = semanage_port_dbase(handle);
+
+#if 0
+	if (modules->dtable->iterate(handle,
+		modules->dbase, NULL, NULL, /* FIXME */) < 0)
+		goto err;	
+
+	if (interfaces->dtable->iterate(handle,
+		interfaces->dbase, NULL, NULL, /* FIXME */) < 0)
+		goto err;
+
+	if (booleans->dtable->iterate(handle,
+		booleans->dbase, NULL, NULL, /* FIXME */) < 0)
+		goto err;
+#endif
+
+	if (users->dtable->iterate(handle, 
+		users->dbase, NULL, NULL /* FIXME */) < 0)
+		goto err;
+
+	if (ports->dtable->iterate(handle, 
+		ports->dbase, NULL, NULL /* FIXME */) < 0)
+		goto err;
+
+	base = NULL;
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_SUCCESS;
+}
+
+int semanage_commit_components(
+	semanage_handle_t* handle) {
+
+	//dbase_config_t* modules = semanage_modules_dbase(handle);
+	//dbase_config_t* interfaces = semanage_iface_dbase(handle);
+	//dbase_config_t* booleans = semanage_bool_dbase(handle);
+	dbase_config_t* users = semanage_user_dbase(handle);
+	dbase_config_t* ports = semanage_port_dbase(handle);
+
+#if 0
+        if (modules->dtable->flush(handle, modules->dbase) < 0)
+                goto err;
+
+        if (interfaces->dtable->flush(handle, interfaces->dbase) < 0)
+                goto err;
+
+        if (booleans->dtable->flush(handle, booleans->dbase) < 0)
+                goto err;
+#endif
+
+	if (users->dtable->flush(handle, users->dbase) < 0) 
+		goto err;
+	
+	if (ports->dtable->flush(handle, ports->dbase) < 0) 
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+#if 0
+	modules->dtable->drop_cache(handle, modules->dbase);
+	interfaces->dtable->drop_cache(handle, interfaces->dbase);
+	booleans->dtable->drop_cache(handle, booleans->dbase);
+#endif
+	
+	users->dtable->drop_cache(handle, users->dbase);
+	ports->dtable->drop_cache(handle, ports->dbase);
+	return STATUS_ERR;
+}
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/src/policy_connection.h new/libsemanage/src/policy_connection.h
--- old/libsemanage/src/policy_connection.h	2005-10-04 10:51:22.000000000 -0400
+++ new/libsemanage/src/policy_connection.h	1969-12-31 19:00:00.000000000 -0500
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
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/src/policy.h new/libsemanage/src/policy.h
--- old/libsemanage/src/policy.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/policy.h	2005-10-13 06:02:47.000000000 -0400
@@ -0,0 +1,75 @@
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
+/* Should be backend independent */
+extern int semanage_base_merge_components(
+	struct semanage_handle* handle,
+	semanage_module_info_t* base);
+
+extern int semanage_commit_components(
+	struct semanage_handle* handle);
+
+#endif
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2005-10-07 18:38:00.000000000 -0400
+++ new/libsemanage/src/semanage_store.c	2005-10-13 05:43:21.000000000 -0400
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
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsepol/include/sepol/debug.h new/libsepol/include/sepol/debug.h
--- old/libsepol/include/sepol/debug.h	2005-07-18 10:28:43.000000000 -0400
+++ new/libsepol/include/sepol/debug.h	2005-10-13 06:14:48.000000000 -0400
@@ -1,9 +1,39 @@
 #ifndef _SEPOL_DEBUG_H_
 #define _SEPOL_DEBUG_H_
 
-extern void sepol_enable_debug(
-	void (*fn)(const char* fname, const char *fmt, ...));
+#include <sepol/handle.h>
 
-extern void sepol_disable_debug();
+/* Deprecated */
+extern void sepol_debug(int on);
+/* End deprecated */
 
-#endif /* _SEPOL_DEBUG_H_ */
+#define SEPOL_MSG_ERR  1
+#define SEPOL_MSG_WARN 2
+#define SEPOL_MSG_INFO 3
+
+extern int sepol_msg_get_level(
+	sepol_handle_t* handle);
+
+extern const char* sepol_msg_get_channel(
+	sepol_handle_t* handle);
+
+extern const char* sepol_msg_get_fname(
+	sepol_handle_t* handle);
+
+/* Set the messaging callback. 
+ * By the default, the callback will print
+ * the message on standard output, in a 
+ * particular format. Passing NULL here
+ * indicates that messaging should be suppressed */
+extern void sepol_msg_set_callback(
+	sepol_handle_t* handle,
+#ifdef __GNUC__
+	__attribute__ ((format (printf, 3, 4)))
+#endif
+	void (*msg_callback) (
+		void* varg,
+		sepol_handle_t* handle,
+		const char* fmt,
+		...),
+	void* msg_callback_arg);
+#endif 
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsepol/include/sepol/handle.h new/libsepol/include/sepol/handle.h
--- old/libsepol/include/sepol/handle.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsepol/include/sepol/handle.h	2005-10-11 03:41:51.000000000 -0400
@@ -0,0 +1,13 @@
+#ifndef _SEPOL_HANDLE_H_
+#define _SEPOL_HANDLE_H_
+
+struct sepol_handle;
+typedef struct sepol_handle sepol_handle_t;
+
+/* Create and return a sepol handle. */
+sepol_handle_t *sepol_handle_create(void);
+
+/* Destroy a sepol handle. */
+void sepol_handle_destroy(sepol_handle_t *);
+
+#endif
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsepol/include/sepol/sepol.h new/libsepol/include/sepol/sepol.h
--- old/libsepol/include/sepol/sepol.h	2005-09-14 11:44:44.000000000 -0400
+++ new/libsepol/include/sepol/sepol.h	2005-10-13 06:14:44.000000000 -0400
@@ -4,6 +4,21 @@
 #include <stddef.h>
 #include <stdio.h>
 
+#include <sepol/user_record.h>
+#include <sepol/context_record.h>
+#include <sepol/iface_record.h>
+#include <sepol/port_record.h>
+#include <sepol/boolean_record.h>
+
+#include <sepol/booleans.h>
+#include <sepol/interfaces.h>
+#include <sepol/ports.h>
+#include <sepol/users.h>
+#include <sepol/handle.h>
+#include <sepol/debug.h>
+#include <sepol/policydb.h>
+#include <sepol/module.h>
+
 /* Given an existing binary policy (starting at 'data', with length 'len')
    and a boolean configuration file named by 'boolpath', rewrite the binary
    policy for the boolean settings in the boolean configuration file.
@@ -37,6 +52,4 @@
 /* Check context validity against currently set binary policy. */
 extern int sepol_check_context(char *context);
 
-/* Turn on or off sepol error messages. */
-extern void sepol_debug(int on);
 #endif
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsepol/src/context.c new/libsepol/src/context.c
--- old/libsepol/src/context.c	2005-10-07 18:38:02.000000000 -0400
+++ new/libsepol/src/context.c	2005-10-13 05:56:52.000000000 -0400
@@ -191,14 +191,16 @@
 
 	/* Validity check */
  	if (!sepol_ctx_struct_is_valid(policydb, scontext)) {
-		if (mls)
+		if (mls) {
 			DEBUG(__FUNCTION__, 
 				"invalid security context: %s:%s:%s:%s\n",
 				user, role, type, mls);
-		else
+		}
+		else {
 			DEBUG(__FUNCTION__, 
 				"invalid security context: %s:%s:%s\n",
 				user, role, type);
+		}
 		goto err_destroy;
 	}
 
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsepol/src/debug.c new/libsepol/src/debug.c
--- old/libsepol/src/debug.c	2005-10-11 14:07:39.000000000 -0400
+++ new/libsepol/src/debug.c	2005-10-13 05:57:50.000000000 -0400
@@ -1,50 +1,85 @@
 #include <stdarg.h>
+#include <stdlib.h>
 #include <stdio.h>
-
-#include <sepol/sepol.h>
-#include <sepol/debug.h>
+#include "handle.h"
 #include "debug.h"
 
-#ifdef __GNUC__
-__attribute__ ((format (printf, 2, 3))) 
-#endif
-static void default_printf(
-	const char* fname, 
-	const char *fmt, ...) {
+/* Deprecated */
+struct sepol_handle sepol_compat_handle = {
+	.msg_callback = sepol_msg_default_handler,
+	.msg_callback_arg = NULL,
+};
 
-	va_list ap;
-	va_start(ap, fmt);
-	fprintf(stderr, "libsepol.%s: ", fname);
-	vfprintf (stderr, fmt, ap);
-	va_end(ap);
+void sepol_debug(int on) {
+	sepol_compat_handle.msg_callback = (on)? 
+		sepol_msg_default_handler : NULL;
+}
+
+/* End deprecated */
+
+int sepol_msg_get_level(sepol_handle_t* handle) {
+	return handle->msg_level;
+}
+
+const char* sepol_msg_get_channel(sepol_handle_t* handle) {
+	return handle->msg_channel;
+}
+
+const char* sepol_msg_get_fname(sepol_handle_t* handle) {
+	return handle->msg_fname;
 }
 
 #ifdef __GNUC__
-__attribute__ ((format (printf, 2, 3)))
+__attribute__ ((format (printf, 3, 4)))
 #endif
-static void suppress_printf(
-	const char* unused1, 
-	const char* unused2, ...) { 
-		unused1 = NULL;
-		unused2 = NULL;
-}
+void sepol_msg_default_handler(
+	void* varg,
+	sepol_handle_t* handle,
+	const char* fmt,
+	...) {
+
+	FILE* stream = NULL;
+
+	switch(sepol_msg_get_level(handle)) {
+
+		case SEPOL_MSG_ERR:
+		case SEPOL_MSG_WARN:
+			stream = stderr;
+			break;
+		case SEPOL_MSG_INFO:
+		default:
+			stream = stdout;
+			break;
+	}
+
+	fprintf(stream, "%s.%s: ",
+		sepol_msg_get_channel(handle),
+		sepol_msg_get_fname(handle));
 
-void (*DEBUG) (const char* fname, const char* fmt, ...) = default_printf;
+	va_list ap;
+	va_start(ap,fmt);
+	vfprintf(stream, fmt, ap);
+	va_end(ap);
 
-/* Compatibility */
-void sepol_debug(int on) {
-        sepol_debug_compat(on);
-};
+	/* FIXME: print newline here, when DEBUG
+	 * calls are no longer using this handler */
+	/* fprintf(stream, "\n"); */
 
-void sepol_debug_compat(int on) {
-	DEBUG = (on)? default_printf : suppress_printf;
+	varg = NULL;
 }
 
-void sepol_enable_debug(
-	void (*fn)(const char* fname, const char *fmt, ...)) {
-	DEBUG = (fn)? fn: default_printf;	
-}
+extern void sepol_msg_set_callback(
+	sepol_handle_t* handle,
+#ifdef __GNUC__
+	__attribute__ ((format (printf, 3, 4)))
+#endif
+	void (*msg_callback) (
+		void* varg,
+		sepol_handle_t* handle,
+		const char* fmt,
+		...),
+	void* msg_callback_arg) {
 
-void sepol_disable_debug() {
-	DEBUG = suppress_printf;
+	handle->msg_callback = msg_callback;
+	handle->msg_callback_arg = msg_callback_arg;
 }
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsepol/src/debug.h new/libsepol/src/debug.h
--- old/libsepol/src/debug.h	2005-07-18 10:28:43.000000000 -0400
+++ new/libsepol/src/debug.h	2005-10-13 05:54:58.000000000 -0400
@@ -1,17 +1,55 @@
 #ifndef _SEPOL_INTERNAL_DEBUG_H_
 #define _SEPOL_INTERNAL_DEBUG_H_
 
+#include <stdio.h>
+#include <sepol/debug.h>
+#include "handle.h"
+
 #define STATUS_SUCCESS 0
 #define STATUS_ERR -1
 #define STATUS_NODATA 1
 
-extern void sepol_debug_compat(int on);
+#define msg_write(handle_arg, level_arg,                   \
+		  channel_arg, func_arg, ...) {            \
+                                                           \
+        if (handle_arg->msg_callback) {                    \
+                handle_arg->msg_fname = func_arg;          \
+                handle_arg->msg_channel = channel_arg;     \
+                handle_arg->msg_level = level_arg;         \
+                                                           \
+                handle_arg->msg_callback(                  \
+                        handle_arg->msg_callback_arg,      \
+                        handle_arg, __VA_ARGS__);          \
+        }                                                  \
+}
+
+#define ERR(handle, ...) \
+	msg_write(handle, SEPOL_MSG_ERR, "libsepol", \
+	__FUNCTION__, __VA_ARGS__)
+
+#define INFO(handle, ...) \
+	msg_write(handle, SEPOL_MSG_INFO, "libsepol", \
+	__FUNCTION__, __VA_ARGS__)
+
+#define WARN(handle, ...) \
+	msg_write(handle, SEPOL_MSG_WARN, "libsepol", \
+	__FUNCTION__, __VA_ARGS__)
 
 #ifdef __GNUC__
-__attribute__ ((format (printf, 2, 3)))
+__attribute__ ((format (printf, 3, 4)))
 #endif
-extern void (*DEBUG) (
-	const char* fname,
-	const char* fmt, ...);
+extern void sepol_msg_default_handler(
+	void* varg,
+	sepol_handle_t* msg,
+	const char* fmt,
+	...);
+
+/* Deprecated */
+extern struct sepol_handle sepol_compat_handle;
+
+#define DEBUG(fname, ...) \
+	msg_write((&sepol_compat_handle), SEPOL_MSG_ERR, "libsepol", \
+	fname, __VA_ARGS__)
+/* End deprecated */
 
-#endif /* _SEPOL_INTERNAL_DEBUG_H_ */
+#endif 
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsepol/src/handle.c new/libsepol/src/handle.c
--- old/libsepol/src/handle.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsepol/src/handle.c	2005-10-12 03:42:42.000000000 -0400
@@ -0,0 +1,21 @@
+#include <stdlib.h>
+#include "handle.h"
+#include "debug.h"
+
+sepol_handle_t *sepol_handle_create(void) {
+
+	sepol_handle_t *sh = malloc(sizeof(sepol_handle_t));
+	if (sh == NULL)
+		return NULL;
+	
+	/* Set callback */
+	sh->msg_callback = sepol_msg_default_handler;
+	sh->msg_callback_arg = NULL;
+
+	return sh;
+}
+
+void sepol_handle_destroy(sepol_handle_t *sh) {
+	free(sh);
+}
+
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsepol/src/handle.h new/libsepol/src/handle.h
--- old/libsepol/src/handle.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsepol/src/handle.h	2005-10-13 05:57:29.000000000 -0400
@@ -0,0 +1,22 @@
+#ifndef _SEPOL_INTERNAL_HANDLE_H_
+#define _SEPOL_INTERNAL_HANDLE_H_
+
+#include <sepol/handle.h>
+
+struct sepol_handle {
+	/* Error handling */
+	int msg_level;
+	const char* msg_channel;
+	const char* msg_fname;
+#ifdef __GNUC__
+	__attribute__ ((format (printf, 3, 4)))
+#endif
+	void (*msg_callback) (
+		void* varg,
+		sepol_handle_t* handle,
+		const char* fmt,
+		...);
+	void* msg_callback_arg;
+};
+
+#endif
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsepol/src/libsepol.map new/libsepol/src/libsepol.map
--- old/libsepol/src/libsepol.map	2005-10-13 06:11:47.000000000 -0400
+++ new/libsepol/src/libsepol.map	2005-10-13 06:12:12.000000000 -0400
@@ -14,8 +14,9 @@
 	sepol_module_package_read; sepol_module_package_info;
 	sepol_module_package_write; sepol_module_package_create_file;
 	sepol_link_modules; sepol_expand_module;
-	sepol_bool*; sepol_context*; sepol_enable_debug; sepol_disable_debug; 
+	sepol_bool*; sepol_context*; 
 	sepol_iface*; sepol_port*; sepol_user*; sepol_clear_unused_users;
 	sepol_role_is_valid; sepol_set_delusers;
+	sepol_msg_*; sepol_handle_*;
   local: *;
 };

--------------050403020506040400050801--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
