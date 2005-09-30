Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8U2xmNs023633
	for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2005 22:59:48 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8U2s6A9012976
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 02:54:06 GMT
Message-ID: <433CAAE2.2000106@cornell.edu>
Date: Thu, 29 Sep 2005 23:02:58 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: dwalsh@redhat.com
Subject: Re: [ 4/9 ] [ SEMANAGE ] Database initialization Stage 1
References: <433CA7CA.6000207@cornell.edu>
In-Reply-To: <433CA7CA.6000207@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------010009080802040306000603"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010009080802040306000603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch breaks up semanage.h/semanage_private.h into 
modules.h, handle.h, debug.h. It moves the debug function into debug.c. 
It adds functions to intialize and release database resources, and uses 
those to add USER and PORT file databases to the handle.

Also, rename some variables and datatypes. Fix caching. Add functions to 
flush and invalidate the cache.

--------------010009080802040306000603
Content-Type: text/x-patch;
 name="libsemanage.03.dbase_init1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.03.dbase_init1.diff"

diff -Naur libsemanage/src/database.c libsemanage.new2/src/database.c
--- libsemanage/src/database.c	2005-09-29 17:08:21.000000000 -0400
+++ libsemanage.new2/src/database.c	2005-09-29 17:52:42.000000000 -0400
@@ -17,7 +17,7 @@
 } cache_entry_t;
 
 /* Database-specific configuration */
-struct dbase_config {
+struct dbase {
 
 	/* What's the format of this database */
 	record_table_t* rtable;
@@ -28,10 +28,69 @@
 	/* Once parsed, it is cached here */
 	cache_entry_t* cache;
 	size_t cache_sz;
+	int cached;
+	int cache_invalid;
 };
 
+/* Initialize a database */
+int dbase_init(
+	record_table_t* rtable,
+	const char* filename,
+	dbase_t** dbase) {
+
+	dbase_t* tmp_dbase =
+		(dbase_t*) malloc(sizeof(dbase_t));
+
+	if (tmp_dbase == NULL)
+		goto omem;
+
+	tmp_dbase->rtable = rtable;
+	tmp_dbase->filename = filename;
+	tmp_dbase->cache = NULL;
+	tmp_dbase->cache_sz = 0;
+	tmp_dbase->cached = 0;
+	tmp_dbase->cache_invalid = 0;
+
+	*dbase = tmp_dbase;
+	return STATUS_SUCCESS;
+
+	omem:
+	/* FIXME: handle error codntion */
+	free(tmp_dbase);
+	return STATUS_ERR;
+}
+
+/* Release a database */
+void dbase_release(
+	dbase_t* dbase) {
+
+	cache_entry_t *prev, *ptr;
+	while (ptr != NULL) {
+		prev = ptr;
+		ptr = ptr->next;
+		dbase->rtable->free(prev->data);
+		free(prev);
+	}
+}
+
+/* Invalidate database cache */
+void dbase_invalidate_cache(
+	dbase_t* dbase) {
+
+	dbase->cache_invalid = 1;
+}
+
+/* Flush the database cache */
+int dbase_flush(
+	dbase_t* dbase) {
+
+	/* Stub */
+	dbase = NULL;
+	return STATUS_SUCCESS;
+}
+
 static int dbase_cache_add(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	record_t data) {
 
 	cache_entry_t* entry = 
@@ -40,11 +99,11 @@
 		goto omem;
 	entry->data = data;
 	entry->prev = NULL;
-	entry->next = dconfig->cache;
-	if (dconfig->cache != NULL)
-		dconfig->cache->prev = entry;
-	dconfig->cache = entry;
-	dconfig->cache_sz++;
+	entry->next = dbase->cache;
+	if (dbase->cache != NULL)
+		dbase->cache->prev = entry;
+	dbase->cache = entry;
+	dbase->cache_sz++;
 
 	return STATUS_SUCCESS;
 	omem:
@@ -72,10 +131,10 @@
 }
 
 static int dbase_cache_fill(
-	dbase_config_t* dconfig) {
+	dbase_t* dbase) {
 
 	/* Already cached */
-	if (dconfig->cache != NULL)
+	if (dbase->cached && (!dbase->cache_invalid))
 		return STATUS_SUCCESS;
 
 	int perr_fatal = 0;
@@ -84,7 +143,7 @@
 	record_t process_record = NULL;
 	int pstatus = STATUS_SUCCESS;
 	parse_info_t parse_info;
-	parse_info.filename = dconfig->filename;
+	parse_info.filename = dbase->filename;
 	parse_info.parse_arg = NULL;
 	/* FIXME: pass from caller? */
 
@@ -94,11 +153,11 @@
 	/* Main processing loop */
 	do {
 		/* Create record */
-		if (dconfig->rtable->create(&process_record) < 0)
+		if (dbase->rtable->create(&process_record) < 0)
 			goto err;
 
 		/* Parse record */
-		pstatus = dconfig->rtable->parse(&parse_info, process_record);
+		pstatus = dbase->rtable->parse(&parse_info, process_record);
 
 		/* Parse error is fatal, exit */
 		if (perr_fatal && (pstatus < 0))
@@ -109,33 +168,35 @@
 			continue;
 
 		/* Add record to list */
-		if (dbase_cache_add(dconfig, process_record) < 0)
+		if (dbase_cache_add(dbase, process_record) < 0)
 			goto err;
 
         } while (pstatus != STATUS_NODATA);
 
 	dbase_close_file(&parse_info);
+	dbase->cached = 1;
+	dbase->cache_invalid = 0;
 	return STATUS_SUCCESS;
 
 	err:
 	/* FIXME: handle failure */
-	dconfig->rtable->free(process_record);
+	dbase->rtable->free(process_record);
 	dbase_close_file(&parse_info);
 	return STATUS_ERR;
 }
 
 static int dbase_cache_locate(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	record_key_t key, 
 	cache_entry_t** entry) {
 	
 	cache_entry_t* ptr;
 
-	if (dbase_cache_fill(dconfig) < 0)
+	if (dbase_cache_fill(dbase) < 0)
 		goto err;
 
-	for (ptr = dconfig->cache; ptr != NULL; ptr = ptr->next) { 
-		if (! dconfig->rtable->compare(ptr->data, key)) {
+	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) { 
+		if (! dbase->rtable->compare(ptr->data, key)) {
 			*entry = ptr;	
 			return STATUS_SUCCESS;
 		}
@@ -148,16 +209,16 @@
 }
 
 int dbase_add(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	record_key_t key,
 	record_t data) {
 
 	int exists;
 
-	if (dbase_cache_fill(dconfig) < 0)
+	if (dbase_cache_fill(dbase) < 0)
 		goto err;
 
-	if (dbase_exists(dconfig, key, &exists) < 0)
+	if (dbase_exists(dbase, key, &exists) < 0)
 		goto err;
 
 	else if (exists) { 
@@ -165,7 +226,7 @@
 		goto err;
 	}
 
-	if (dbase_cache_add(dconfig, data) < 0)
+	if (dbase_cache_add(dbase, data) < 0)
 		goto err;
 
 	return STATUS_SUCCESS;
@@ -176,21 +237,21 @@
 }
 
 int dbase_modify(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	record_key_t key,
 	record_t data) {
 
 	cache_entry_t* entry;
 	int status;
 
-	if (dbase_cache_fill(dconfig) < 0)
+	if (dbase_cache_fill(dbase) < 0)
 		goto err;
 
-	status = dbase_cache_locate(dconfig, key, &entry);
+	status = dbase_cache_locate(dbase, key, &entry);
 	if (status < 0)
 		goto err;
 	if (status == STATUS_NODATA)
-		return dbase_add(dconfig,key,data);
+		return dbase_add(dbase,key,data);
 	else
 		entry->data = data;
 
@@ -203,16 +264,16 @@
 }
 
 int dbase_del(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	record_key_t key) {
 
 	cache_entry_t* entry;
 	int status;
 
-	if (dbase_cache_fill(dconfig) < 0)
+	if (dbase_cache_fill(dbase) < 0)
 		goto err;
 
-	status = dbase_cache_locate(dconfig, key, &entry);
+	status = dbase_cache_locate(dbase, key, &entry);
 	if (status < 0)
 		goto err;
 	
@@ -223,10 +284,10 @@
 		if (entry->prev != NULL)
 			entry->prev->next = entry->next;
 		else
-			dconfig->cache = entry->next;
+			dbase->cache = entry->next;
 
-		dconfig->rtable->free(entry->data);
-		dconfig->cache_sz--;
+		dbase->rtable->free(entry->data);
+		dbase->cache_sz--;
 		free(entry);
 	}
 
@@ -237,21 +298,21 @@
 }
 
 int dbase_query(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	record_key_t key,
 	record_t* response) {
 
 	cache_entry_t* entry;
 	int status;
 
-	if (dbase_cache_fill(dconfig) < 0)
+	if (dbase_cache_fill(dbase) < 0)
 		goto err;
 
-	status = dbase_cache_locate(dconfig, key, &entry);
+	status = dbase_cache_locate(dbase, key, &entry);
 	if (status < 0 || status == STATUS_NODATA)
 		goto err;
 
-	if (dconfig->rtable->clone(entry->data, *response) < 0)
+	if (dbase->rtable->clone(entry->data, *response) < 0)
 		goto err;
 
 	return STATUS_SUCCESS;
@@ -261,17 +322,17 @@
 }
 
 int dbase_exists(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	record_key_t key,
 	int* response) {
 
 	cache_entry_t* entry;
 	int status;
 
-	if (dbase_cache_fill(dconfig) < 0)
+	if (dbase_cache_fill(dbase) < 0)
 		goto err;
 
-	status = dbase_cache_locate(dconfig, key, &entry);
+	status = dbase_cache_locate(dbase, key, &entry);
 	if (status < 0)
 		goto err;
 
@@ -284,13 +345,13 @@
 }
 
 int dbase_count(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	int* response) {
 
-	if (dbase_cache_fill(dconfig) < 0)
+	if (dbase_cache_fill(dbase) < 0)
 		goto err;
 
-	*response = dconfig->cache_sz;
+	*response = dbase->cache_sz;
 	return STATUS_SUCCESS;
 
 	err:
@@ -299,17 +360,17 @@
 }
 
 int dbase_iterate(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	int (*fn) (record_t record, void* varg),
 	void* fn_arg) {
 
 	int status;	
 	cache_entry_t* ptr;
 	
-	if (dbase_cache_fill(dconfig) < 0)
+	if (dbase_cache_fill(dbase) < 0)
 		goto err;
 
-	for (ptr = dconfig->cache; ptr != NULL; ptr = ptr->next) {
+	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
 		status = fn(ptr->data, fn_arg);
 		if (status < 0)
 			goto err;
@@ -326,7 +387,7 @@
 }
 
 int dbase_list(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	record_t** records,	
 	size_t* count) {
 
@@ -335,18 +396,18 @@
 	size_t tmp_count;
 	int i = 0;
 	
-	if (dbase_cache_fill(dconfig) < 0)
+	if (dbase_cache_fill(dbase) < 0)
 		goto err;
 
-	tmp_count = dconfig->cache_sz;
+	tmp_count = dbase->cache_sz;
 
 	if (tmp_count > 0) {
 		tmp_records = (record_t*) calloc(tmp_count, sizeof (record_t));
 		if (tmp_records == NULL) 
 			goto omem;			
 	
-		for (ptr = dconfig->cache; ptr != NULL; ptr = ptr->next) 
-			if (dconfig->rtable->clone(ptr->data, &tmp_records[i++]) < 0)
+		for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) 
+			if (dbase->rtable->clone(ptr->data, &tmp_records[i++]) < 0)
 				goto err;
 
 	}
diff -Naur libsemanage/src/database.h libsemanage.new2/src/database.h
--- libsemanage/src/database.h	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage.new2/src/database.h	2005-09-29 17:53:26.000000000 -0400
@@ -1,53 +1,72 @@
 #ifndef _SEMANAGE_DATABASE_H_
 #define _SEMANAGE_DATABASE_H_
 
-#include <stddef.h>
-
 #ifndef RECORD_DEFINED
 typedef void* record_t;
 typedef void* record_key_t;
 #define RECORD_DEFINED
 #endif
 
-struct dbase_config;
-typedef struct dbase_config dbase_config_t;
+#include <stddef.h>
+#include "interfaces.h"
+
+struct dbase;
+typedef struct dbase dbase_t;
+
+/* Initialize a database */
+extern int dbase_init(
+	record_table_t* rtable,
+	const char* filename,
+	dbase_t** dbase);
+
+/* Release a database */
+extern void dbase_release(
+	dbase_t* dbase);
+
+/* Flush a database to disk */
+extern int dbase_flush(
+	dbase_t* dbase);
+
+/* Invalidate the database cache */
+extern void dbase_invalidate_cache(
+	dbase_t* dbase);
 
 extern int dbase_add(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	record_key_t key,
 	record_t data);
 
 extern int dbase_modify(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	record_key_t key,
 	record_t data);
 
 extern int dbase_del(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	record_key_t key);
 
 extern int dbase_query(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	record_key_t key,
 	record_t* response);
 
 extern int dbase_exists(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	record_key_t key,
 	int* response);
 
 extern int dbase_count(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	int* response);
 
 extern int dbase_iterate(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	int (*fn) (record_t record,
 	           void* varg),
 	void* fn_arg);
 
 extern int dbase_list(
-	dbase_config_t* dconfig,
+	dbase_t* dbase,
 	record_t** records,	
 	size_t* count);
 
diff -Naur libsemanage/src/debug.c libsemanage.new2/src/debug.c
--- libsemanage/src/debug.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new2/src/debug.c	2005-09-29 17:23:34.000000000 -0400
@@ -0,0 +1,38 @@
+/* Author: Joshua Brindle <jbrindle@tresys.co
+ *         Jason Tang     <jtang@tresys.com>
+ *
+ * Copyright (C) 2004-2005 Tresys Technology, LLC
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
+#include <stdarg.h>
+#include <stdio.h>
+#include "handle.h"
+#include "debug.h"
+
+/* FIXME: redesign with callbacks ? */
+
+/* Write an error message to the current error buffer, up to the
+ * buffer's specified size. */
+#ifdef __GNUC__
+__attribute__ ((format (printf, 2, 3)))
+#endif
+void semanage_write_error(semanage_handle_t *sh, char *fmt, ...) {
+	va_list ap;
+	va_start(ap, fmt);
+	vsnprintf(sh->err_buf, SEMANAGE_ERRBUFSZ, fmt, ap);
+	va_end(ap);
+}
diff -Naur libsemanage/src/debug.h libsemanage.new2/src/debug.h
--- libsemanage/src/debug.h	2005-09-21 10:42:25.000000000 -0400
+++ libsemanage.new2/src/debug.h	2005-09-29 17:23:34.000000000 -0400
@@ -1,10 +1,39 @@
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
 #ifndef _SEPOL_INTERNAL_DEBUG_H_
 #define _SEPOL_INTERNAL_DEBUG_H_
 
+#include "handle.h"
+
 #define STATUS_SUCCESS 0
 #define STATUS_ERR -1
 #define STATUS_NODATA 1
 
-/* Define debug system in this header */
+/* FIXME: redesign with level argument ? */
+
+#ifdef __GNUC__
+__attribute__ ((format (printf, 2, 3)))
+#endif
+extern void semanage_write_error(semanage_handle_t *sh, char *fmt, ...);
 
 #endif 
diff -Naur libsemanage/src/direct_api.c libsemanage.new2/src/direct_api.c
--- libsemanage/src/direct_api.c	2005-09-28 15:56:00.000000000 -0400
+++ libsemanage.new2/src/direct_api.c	2005-09-29 17:23:34.000000000 -0400
@@ -17,10 +17,6 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include "semanage_private.h"
-#include "direct_api.h"
-#include "semanage_store.h"
-
 #include <sepol/module.h>
 
 #include <assert.h>
@@ -30,6 +26,12 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 
+#include "debug.h"
+#include "handle.h"
+#include "modules.h"
+#include "direct_api.h"
+#include "semanage_store.h"
+
 static void semanage_direct_destroy(semanage_handle_t *sh);
 static int semanage_direct_disconnect(semanage_handle_t *sh);
 static int semanage_direct_begintrans(semanage_handle_t *sh);
@@ -68,11 +70,15 @@
 
 	/* set up function pointers */
 	sh->funcs = &direct_funcs;
+
+	/* FIXME: configure policy query databases */
+
 	return 0;
 }
 
 static void semanage_direct_destroy(semanage_handle_t *sh) {
 	/* do nothing */
+	sh = NULL;
 }
 
 static int semanage_direct_disconnect(semanage_handle_t *sh) {
@@ -85,6 +91,9 @@
 		}
 		semanage_release_trans_lock(sh);
 	}
+
+	/* FIXME: release policy query databases */
+
 	return 0;
 }
 
@@ -233,6 +242,8 @@
 		goto cleanup;
 	}
 
+	/* FIXME: write object databases into base */
+
 	/* write the linked base */
 	if ((linked_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED)) == NULL ||
 	    semanage_write_module(sh, linked_filename, base, POLICY_BASE) == -1 ||
diff -Naur libsemanage/src/direct_api.h libsemanage.new2/src/direct_api.h
--- libsemanage/src/direct_api.h	2005-09-28 15:56:00.000000000 -0400
+++ libsemanage.new2/src/direct_api.h	2005-09-29 17:23:34.000000000 -0400
@@ -20,7 +20,7 @@
 #ifndef SEMANAGE_DIRECT_API_H
 #define SEMANAGE_DIRECT_API_H
 
-#include "semanage_private.h"
+#include "handle.h"
 
 int semanage_direct_connect(semanage_handle_t *sh);
 
diff -Naur libsemanage/src/handle.c libsemanage.new2/src/handle.c
--- libsemanage/src/handle.c	2005-09-28 15:56:00.000000000 -0400
+++ libsemanage.new2/src/handle.c	2005-09-29 17:23:34.000000000 -0400
@@ -21,10 +21,6 @@
 /* This file implements only the publicly-visible handle functions to libsemanage. */
 
 #include <semanage/semanage.h>
-#include "semanage_private.h"
-#include "direct_api.h"
-#include "semanage_conf.h"
-#include "semanage_store.h"
 #include <selinux/selinux.h>
 
 #include <stdarg.h>
@@ -33,35 +29,59 @@
 #include <stdio.h>
 #include <sys/time.h>
 
+#include "handle.h"
+#include "debug.h"
+#include "direct_api.h"
+#include "semanage_conf.h"
+#include "semanage_store.h"
+#include "users_file.h"
+#include "ports_file.h"
+#include "database.h"
+
 #define SEMANAGE_COMMIT_READ_WAIT 5
 
 semanage_handle_t *semanage_handle_create(void) {
-        semanage_handle_t *sh;
-        const char *conf_name;
+	semanage_handle_t *sh;
+	const char *conf_name;
+
+	/* Allocate handle */
+	if ((sh = calloc(1, sizeof(*sh))) == NULL)
+		goto omem;
+
+	/* Policy root */
+	const char *pr = selinux_policy_root();
+	if (!pr)
+		goto err;
+
+	if (semanage_check_init(pr))
+		goto err;
+
+	/* Config */
+	if ((conf_name = semanage_conf_path()) == NULL) 
+		goto err;
+
+	if ((sh->conf = semanage_conf_parse(conf_name)) == NULL)
+		goto err;
+
+	/* Set timeout: some default value for now, later use config */
+	sh->timeout = SEMANAGE_COMMIT_READ_WAIT; 
+
+	/* Configure object databases 
+	 * Hardcore DATA FILE backend for now */
+	if (user_file_dbase_init(&sh->dbase[DBASE_USERS]) < 0)
+		goto err;
+
+	if (port_file_dbase_init(&sh->dbase[DBASE_PORTS]) < 0)
+		goto err;
 
-        /* Get the selinux policy root and pass to the path init function */
-        const char *pr = selinux_policy_root();
-        if (!pr)
-                return NULL;
-
-        if (semanage_check_init(pr))
-                return NULL;
-
-        if ((conf_name = semanage_conf_path()) == NULL) {
-                goto cleanup;
-        }
-        if ((sh = calloc(1, sizeof(*sh))) == NULL) {
-                return NULL;
-        }
-        if ((sh->conf = semanage_conf_parse(conf_name)) == NULL) {
-                goto cleanup;
-        }
-        sh->timeout = SEMANAGE_COMMIT_READ_WAIT; /* some default value for now, later use config */
         return sh;
- cleanup:
-        semanage_handle_destroy(sh);
-        return NULL;
 
+ omem:
+	/* FIXME: report error condition */
+ err:
+	/* FIXME: report error condition */
+	semanage_handle_destroy(sh);
+	return NULL;
 }
 
 int semanage_connect(semanage_handle_t *sh) {
@@ -96,13 +116,18 @@
 }
 
 void semanage_handle_destroy(semanage_handle_t *sh) {
-	if (sh != NULL) {
-		if (sh->funcs != NULL && sh->funcs->destroy != NULL) {
-			sh->funcs->destroy(sh);
-		}
-		semanage_conf_destroy(sh->conf);
-		free(sh);
-	}
+	if (sh == NULL)
+		return;
+
+	if (sh->funcs != NULL && sh->funcs->destroy != NULL)
+		sh->funcs->destroy(sh);
+	semanage_conf_destroy(sh->conf);
+
+	/* Free object databases */
+	dbase_release(sh->dbase[DBASE_USERS]);
+	dbase_release(sh->dbase[DBASE_PORTS]);
+
+	free(sh);
 }
 
 const char *semanage_strerror(semanage_handle_t *sh) {
diff -Naur libsemanage/src/handle.h libsemanage.new2/src/handle.h
--- libsemanage/src/handle.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new2/src/handle.h	2005-09-29 17:53:04.000000000 -0400
@@ -0,0 +1,95 @@
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
+#ifndef _SEMANAGE_INTERNAL_HANDLE_H_
+#define _SEMANAGE_INTERNAL_HANDLE_H_
+
+#include <stddef.h>
+#include <semanage/handle.h>
+#include "modules.h"
+#include "semanage_conf.h"
+
+/* Can't include - circular dependency */
+struct dbase;
+
+/* FIXME: Some of this needs to go into modules.h */
+struct semanage_func_table {
+	void (*destroy)(semanage_handle_t *);
+	int (*disconnect)(semanage_handle_t *);
+	int (*begin_trans)(semanage_handle_t *);
+	int (*commit)(semanage_handle_t *);
+	int (*install)(semanage_handle_t *, char *, size_t);
+	int (*upgrade)(semanage_handle_t *, char *, size_t);
+	int (*install_base)(semanage_handle_t *, char *, size_t);
+	int (*remove)(semanage_handle_t *, char *);
+	int (*list)(semanage_handle_t *, semanage_module_info_t **, int *);
+};
+
+struct semanage_handle {
+	int con_id;             /* Connection ID */
+	int policy_serial;      /* Policy serial number at connect time */
+
+	/* Error management */
+	/* FIXME: re-design error system using callbacks (?) */
+#define SEMANAGE_ERRBUFSZ 1024
+	char err_buf[SEMANAGE_ERRBUFSZ];
+
+	/* one of these connections will actually be used while
+	 * working with the module store -- the particular one if
+	 * given by conf->store_type */
+	semanage_conf_t *conf;
+	union {
+		struct semanage_module_conn module;
+	} conn;
+	int is_connected;
+	int is_in_transaction;
+
+	/* This timeout is used for transactions and waiting for lock
+	   -1 means wait indefinetely
+	    0 means return immediately
+	    >0 means wait that many seconds */
+	int timeout;
+
+	/* these function pointers will point to the appropriate
+	 * routine given the connection type.  think of these as
+	 * simulating polymorphism for non-OO languages. */
+	struct semanage_func_table *funcs;
+
+	/* Object databases */
+#define DBASE_COUNT 2
+#define DBASE_USERS 0
+#define DBASE_PORTS 1
+	struct dbase* dbase[DBASE_COUNT];
+};
+
+static inline
+struct dbase* semanage_user_dbase(semanage_handle_t* handle) {
+        return handle->dbase[DBASE_USERS];
+}
+
+static inline
+struct dbase* semanage_port_dbase(semanage_handle_t* handle) {
+        return handle->dbase[DBASE_PORTS];
+}
+
+#endif
+
diff -Naur libsemanage/src/modules.c libsemanage.new2/src/modules.c
--- libsemanage/src/modules.c	2005-09-28 15:56:00.000000000 -0400
+++ libsemanage.new2/src/modules.c	2005-09-29 17:23:34.000000000 -0400
@@ -21,7 +21,6 @@
 /* This file implements only the publicly-visible module functions to libsemanage. */
 
 #include <semanage/semanage.h>
-#include "semanage_private.h"
 #include "direct_api.h"
 #include "semanage_conf.h"
 #include "semanage_store.h"
@@ -31,6 +30,10 @@
 #include <stdlib.h>
 #include <stdio.h>
 
+#include "handle.h"
+#include "modules.h"
+#include "debug.h"
+
 int semanage_module_install(semanage_handle_t *sh,
 			    char *module_data, size_t data_len) {
 	if (sh->funcs->install == NULL) {
diff -Naur libsemanage/src/modules.h libsemanage.new2/src/modules.h
--- libsemanage/src/modules.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new2/src/modules.h	2005-09-29 17:23:34.000000000 -0400
@@ -0,0 +1,36 @@
+/* Author: Joshua Brindle <jbrindle@tresys.com>
+ *         Jason Tang     <jtang@tresys.com>
+ *
+ * Copyright (C) 2005 Tresys Technology, LLC
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
+#ifndef _SEMANAGE_INTERNAL_MODULES_H_
+#define _SEMANAGE_INTERNAL_MODULES_H_
+
+#include <semanage/modules.h>
+
+struct semanage_module_conn {
+	int translock_file_fd;
+	int readlock_file_fd;
+};
+
+struct semanage_module_info {
+	char *name;             /* Key */
+	char *version;
+};
+
+#endif
diff -Naur libsemanage/src/ports_file.c libsemanage.new2/src/ports_file.c
--- libsemanage/src/ports_file.c	2005-09-29 17:07:03.000000000 -0400
+++ libsemanage.new2/src/ports_file.c	2005-09-29 17:49:14.000000000 -0400
@@ -9,6 +9,7 @@
 #include <semanage/port_record.h>
 #include "debug.h"
 #include "interfaces.h"
+#include "database.h"
 
 static int semanage_port_print(
 	semanage_port_t port, 
@@ -30,7 +31,7 @@
 	return STATUS_SUCCESS;	
 }
 
-record_table_t RTABLE_PORT = {
+record_table_t SEMANAGE_PORT_RTABLE = {
 	/* Record base functions */
 	.create      = semanage_port_create,
 	.key_extract = semanage_port_key_extract,
@@ -43,3 +44,17 @@
 	.parse       = semanage_port_parse,
 	.print       = semanage_port_print,
 };
+
+int port_file_dbase_init(dbase_t** dbase) {
+	return dbase_init(
+		&SEMANAGE_PORT_RTABLE,
+		NULL, /* FIXME */
+		dbase);
+}
+
+void port_file_dbase_release(dbase_t* dbase) {
+	if (dbase == NULL)
+		return;
+
+	dbase_release(dbase);
+}
diff -Naur libsemanage/src/ports_file.h libsemanage.new2/src/ports_file.h
--- libsemanage/src/ports_file.h	2005-09-29 17:07:13.000000000 -0400
+++ libsemanage.new2/src/ports_file.h	2005-09-29 17:49:15.000000000 -0400
@@ -1,8 +1,16 @@
 #ifndef _SEMANAGE_PORTS_FILE_H_
 #define _SEMANAGE_PORTS_FILE_H_
 
-#include "interfaces.h"
+/*
+ * Header for the port DATA FILE backend
+ */
 
-extern record_table_t RTABLE_PORT;
+#include "database.h"
+
+int port_file_dbase_init(
+	dbase_t** dbase);
+
+void port_file_dbase_release(
+	dbase_t* dbase);
 
 #endif 
diff -Naur libsemanage/src/semanage.c libsemanage.new2/src/semanage.c
--- libsemanage/src/semanage.c	2005-09-28 15:56:00.000000000 -0400
+++ libsemanage.new2/src/semanage.c	2005-09-29 17:23:34.000000000 -0400
@@ -19,7 +19,6 @@
  */
 
 #include <semanage/semanage.h>
-#include "semanage_private.h"
 #include "direct_api.h"
 #include "semanage_conf.h"
 #include "semanage_store.h"
@@ -27,9 +26,6 @@
 
 #include <stdarg.h>
 #include <assert.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <sys/time.h>
 
 int semanage_init(void)
 {
@@ -49,15 +45,3 @@
 {
 	semanage_init();
 }
-
-/* Write an error message to the current error buffer, up to the
- * buffer's specified size. */
-#ifdef __GNUC__
-__attribute__ ((format (printf, 2, 3)))
-#endif
-void semanage_write_error(semanage_handle_t *sh, char *fmt, ...) {
-	va_list ap;
-	va_start(ap, fmt);
-	vsnprintf(sh->err_buf, SEMANAGE_ERRBUFSZ, fmt, ap);
-	va_end(ap);
-}
diff -Naur libsemanage/src/semanage_private.h libsemanage.new2/src/semanage_private.h
--- libsemanage/src/semanage_private.h	2005-09-28 15:56:00.000000000 -0400
+++ libsemanage.new2/src/semanage_private.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,86 +0,0 @@
-/* Author: Joshua Brindle <jbrindle@tresys.com>
- *	   Jason Tang	  <jtang@tresys.com>
- *
- * Copyright (C) 2005 Tresys Technology, LLC
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
-#ifndef SEMANAGE_PRIVATE_H
-#define SEMANAGE_PRIVATE_H
-
-#include <semanage/semanage.h>
-
-#include "semanage_conf.h"
-#include <stdlib.h>
-#include <sys/time.h> 
-
-struct semanage_module_conn {
-	int translock_file_fd;
-	int readlock_file_fd;
-};
-
-struct semanage_func_table {
-	void (*destroy)(semanage_handle_t *);
-	int (*disconnect)(semanage_handle_t *);
-	int (*begin_trans)(semanage_handle_t *); 
-	int (*commit)(semanage_handle_t *);
-	int (*install)(semanage_handle_t *, char *, size_t);
-	int (*upgrade)(semanage_handle_t *, char *, size_t);
-	int (*install_base)(semanage_handle_t *, char *, size_t);
-	int (*remove)(semanage_handle_t *, char *);
-	int (*list)(semanage_handle_t *, semanage_module_info_t **, int *);
-};
-
-#define SEMANAGE_ERRBUFSZ 1024
-
-struct semanage_handle {
-	int con_id;		/* Connection ID */
-	int policy_serial;	/* Policy serial number at connect time */
-	char err_buf[SEMANAGE_ERRBUFSZ];
-
-	/* one of these connections will actually be used while
-	 * working with the module store -- the particular one is
-	 * given by conf->store_type */
-	semanage_conf_t *conf;
-	union {
-		struct semanage_module_conn module;
-	} conn;
-	int is_connected;
-	int is_in_transaction;
-
-	/* these function pointers will point to the appropriate
-	 * routine given the connection type.  think of these as
-	 * simulating polymorphism for non-OO languages. */
-	struct semanage_func_table *funcs;
-
-	/* This timeout is used for transactions and waiting for locks 
-	   -1 means wait indefinetely
-	    0 means return immediately 
-	   >0 means wait that many seconds */
-	int timeout;
-};
-
-struct semanage_module_info {
-	char *name;		/* Key */
-	char *version;
-};
-
-#ifdef __GNUC__
-__attribute__ ((format (printf, 2, 3)))
-#endif
-void semanage_write_error(semanage_handle_t *sh, char *fmt, ...);
-
-#endif
diff -Naur libsemanage/src/semanage_store.c libsemanage.new2/src/semanage_store.c
--- libsemanage/src/semanage_store.c	2005-09-28 15:56:00.000000000 -0400
+++ libsemanage.new2/src/semanage_store.c	2005-09-29 17:23:34.000000000 -0400
@@ -45,6 +45,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
+#include "debug.h"
 
 /* relative path names to enum semanage_paths to special files and
  * directories for the module store */
diff -Naur libsemanage/src/semanage_store.h libsemanage.new2/src/semanage_store.h
--- libsemanage/src/semanage_store.h	2005-09-28 15:56:00.000000000 -0400
+++ libsemanage.new2/src/semanage_store.h	2005-09-29 17:23:34.000000000 -0400
@@ -22,11 +22,9 @@
 #ifndef SEMANAGE_MODULE_STORE_H
 #define SEMANAGE_MODULE_STORE_H
 
-#include "semanage_private.h"
-
 #include <sys/time.h>
-
 #include <sepol/module.h>
+#include "handle.h"
 
 enum semanage_store_defs {
 	SEMANAGE_ACTIVE,
diff -Naur libsemanage/src/users_file.c libsemanage.new2/src/users_file.c
--- libsemanage/src/users_file.c	2005-09-29 17:07:53.000000000 -0400
+++ libsemanage.new2/src/users_file.c	2005-09-29 17:49:29.000000000 -0400
@@ -7,6 +7,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include "interfaces.h"
+#include "database.h"
 #include "debug.h"
 
 static int semanage_user_print(
@@ -29,7 +30,7 @@
 	return STATUS_SUCCESS;	
 }
 
-record_table_t RTABLE_USER = {
+record_table_t SEMANAGE_USER_RTABLE = {
 	/* Record base functions */
 	.create      = semanage_user_create,
 	.key_extract = semanage_user_key_extract,
@@ -42,3 +43,18 @@
 	.parse       = semanage_user_parse,
 	.print       = semanage_user_print,
 };
+
+int user_file_dbase_init(dbase_t** dbase) {
+	return dbase_init(
+		&SEMANAGE_USER_RTABLE,
+		NULL, /* FIXME */
+		dbase);
+}
+
+void user_file_dbase_release(dbase_t* dbase) {
+	if (dbase == NULL)
+		return;
+
+	dbase_release(dbase);
+}
+
diff -Naur libsemanage/src/users_file.h libsemanage.new2/src/users_file.h
--- libsemanage/src/users_file.h	2005-09-29 17:08:00.000000000 -0400
+++ libsemanage.new2/src/users_file.h	2005-09-29 17:42:54.000000000 -0400
@@ -1,8 +1,16 @@
 #ifndef _SEMANAGE_USERS_FILE_H_
 #define _SEMANAGE_USERS_FILE_H_
 
-#include "interfaces.h"
+/**
+ * Header for the users DATA FILE backend
+ */
 
-extern record_table_t RTABLE_USER;
+#include "database.h"
+
+int user_file_dbase_init(
+	dbase_t** dbase);
+
+void user_file_dbase_release(
+	dbase_t* dbase);
 
 #endif 

--------------010009080802040306000603--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
