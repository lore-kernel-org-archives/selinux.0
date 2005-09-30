Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8U3BSNs023841
	for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2005 23:11:28 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8U35cS2017478
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 03:05:38 GMT
Message-ID: <433CAD8A.8040004@cornell.edu>
Date: Thu, 29 Sep 2005 23:14:18 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: dwalsh@redhat.com
Subject: Re: [ 7/9 ] [ SEMANAGE ] Backend separation (Init 3)
References: <433CA7CA.6000207@cornell.edu>
In-Reply-To: <433CA7CA.6000207@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------060008020102000906090102"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060008020102000906090102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch:

- removes FILE-specific code from the database, and puts that in 
database_file.[c,h].
- stubs out a second type of database - database_direct.[c,h] (for policy)
- adds user/port interfaces for the POLICY DIRECT database
- splits record table into base (in users.c/ports.c) and extensions - 
FILE and POLICY DIRECT
- adds polymorphism on the database backend, and uses that in database
- adds init()/release() functions for the backend.
- forwards cache() and flush() operations to the backend

- adds some functions with the intent to use those for moving things 
from a FILE to POLICY database, but I'm still not entirely sure how this 
code will work (so it's partially disabled).





--------------060008020102000906090102
Content-Type: text/x-patch;
 name="libsemanage.06.dbase_init3_backend_separation.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.06.dbase_init3_backend_separation.diff"

diff -Naur --exclude CVS libsemanage/src/database.c libsemanage.new2/src/database.c
--- libsemanage/src/database.c	2005-09-29 18:34:10.000000000 -0400
+++ libsemanage.new2/src/database.c	2005-09-29 19:08:50.000000000 -0400
@@ -1,39 +1,15 @@
 #include <stdlib.h>
 #include <stddef.h>
-#include <stdio.h>
-#include <stdio_ext.h>
-#include <errno.h>
 #include "debug.h"
 #include "database.h"
 #include "interfaces.h"
 #include "handle.h"
 
-/* Representation of the database once loaded in memory */
-typedef struct cache_entry {
-	record_t data;
-	struct cache_entry* next;
-} cache_entry_t;
-
-/* Database-specific configuration */
-struct dbase {
-
-	/* What's the format of this database */
-	record_table_t* rtable;
-
-	/* Where is it stored */
-	const char* filename;
-
-	/* Once parsed, it is cached here */
-	cache_entry_t* cache;
-	size_t cache_sz;
-	int cached;
-	int cache_invalid;
-};
-
 /* Initialize a database */
 int dbase_init(
 	record_table_t* rtable,
-	const char* filename,
+	dbase_backend_t* backend,
+	dbase_backend_table_t* btable,
 	dbase_t** dbase) {
 
 	dbase_t* tmp_dbase =
@@ -43,7 +19,8 @@
 		goto omem;
 
 	tmp_dbase->rtable = rtable;
-	tmp_dbase->filename = filename;
+	tmp_dbase->backend = backend;
+	tmp_dbase->btable = btable;
 	tmp_dbase->cache = NULL;
 	tmp_dbase->cache_sz = 0;
 	tmp_dbase->cached = 0;
@@ -62,13 +39,15 @@
 void dbase_release(
 	dbase_t* dbase) {
 
-	cache_entry_t *prev, *ptr;
+	cache_entry_t *prev, *ptr = dbase->cache;
 	while (ptr != NULL) {
 		prev = ptr;
 		ptr = ptr->next;
 		dbase->rtable->free(prev->data);
 		free(prev);
 	}
+
+	free(dbase);
 }
 
 /* Invalidate database cache */
@@ -82,12 +61,13 @@
 int dbase_flush(
 	dbase_t* dbase) {
 
-	/* Stub */
-	dbase = NULL;
+	if (dbase->btable->flush(dbase, dbase->backend) < 0)
+		return STATUS_ERR;
+
 	return STATUS_SUCCESS;
 }
 
-static int dbase_cache_add(
+int dbase_cache_add(
 	dbase_t* dbase,
 	record_t data) {
 
@@ -106,80 +86,6 @@
 	return STATUS_ERR;
 }
 
-static int dbase_open_file(parse_info_t* info) {
-
-	info->file_stream = fopen(info->filename, "r");
-	if (!info->file_stream && (errno != ENOENT)) {
-		/* FIXME: handle error condition */
-		return STATUS_ERR;
-	}
-	if (info->file_stream)
-		__fsetlocking(info->file_stream, FSETLOCKING_BYCALLER);
-
-        return STATUS_SUCCESS;
-}
-
-static void dbase_close_file(parse_info_t* info) {
-	if (info->file_stream && (fclose(info->file_stream) < 0))
-		/* FIXME: handle error condition */
-	info->file_stream = NULL;
-}
-
-static int dbase_cache_fill(
-	dbase_t* dbase) {
-
-	/* Already cached */
-	if (dbase->cached && (!dbase->cache_invalid))
-		return STATUS_SUCCESS;
-
-	int perr_fatal = 0;
-	/* FIXME: pass from caller? */
-
-	record_t process_record = NULL;
-	int pstatus = STATUS_SUCCESS;
-	parse_info_t parse_info;
-	parse_info.filename = dbase->filename;
-	parse_info.parse_arg = NULL;
-	/* FIXME: pass from caller? */
-
-	if (dbase_open_file(&parse_info) < 0)
-		goto err;
-
-	/* Main processing loop */
-	do {
-		/* Create record */
-		if (dbase->rtable->create(&process_record) < 0)
-			goto err;
-
-		/* Parse record */
-		pstatus = dbase->rtable->parse(&parse_info, process_record);
-
-		/* Parse error is fatal, exit */
-		if (perr_fatal && (pstatus < 0))
-			goto err;
-
-		/* Parse error is not fatal */
-		else if (pstatus < 0)
-			continue;
-
-		/* Add record to list */
-		if (dbase_cache_add(dbase, process_record) < 0)
-			goto err;
-
-        } while (pstatus != STATUS_NODATA);
-
-	dbase_close_file(&parse_info);
-	dbase->cached = 1;
-	dbase->cache_invalid = 0;
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle failure */
-	dbase->rtable->free(process_record);
-	dbase_close_file(&parse_info);
-	return STATUS_ERR;
-}
-
 static int dbase_cache_locate(
 	dbase_t* dbase,
 	record_key_t key,
@@ -187,7 +93,7 @@
 	
 	cache_entry_t* ptr;
 
-	if (dbase_cache_fill(dbase) < 0)
+	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
 	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) { 
@@ -211,7 +117,7 @@
 
 	int exists;
 
-	if (dbase_cache_fill(dbase) < 0)
+	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
 	if (dbase_exists(handle, dbase, key, &exists) < 0)
@@ -242,7 +148,7 @@
 	cache_entry_t* entry;
 	int status;
 
-	if (dbase_cache_fill(dbase) < 0)
+	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
 	status = dbase_cache_locate(dbase, key, &entry);
@@ -268,7 +174,7 @@
 
 	cache_entry_t *ptr, *prev = NULL;
 
-	if (dbase_cache_fill(dbase) < 0)
+	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
 	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
@@ -277,15 +183,15 @@
 				prev->next = ptr->next;
 			else
 				dbase->cache = ptr->next;
-
+	
 			dbase->rtable->free(ptr->data);
 			dbase->cache_sz--;
 			free(ptr);
 			return STATUS_SUCCESS;
-		}
+                }
 		else
 			prev = ptr;
-	}
+        }
 
 	return STATUS_SUCCESS;
 	err:
@@ -303,7 +209,7 @@
 	cache_entry_t* entry;
 	int status;
 
-	if (dbase_cache_fill(dbase) < 0)
+	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
 	status = dbase_cache_locate(dbase, key, &entry);
@@ -329,7 +235,7 @@
 	cache_entry_t* entry;
 	int status;
 
-	if (dbase_cache_fill(dbase) < 0)
+	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
 	status = dbase_cache_locate(dbase, key, &entry);
@@ -350,7 +256,7 @@
 	dbase_t* dbase,
 	int* response) {
 
-	if (dbase_cache_fill(dbase) < 0)
+	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
 	*response = dbase->cache_sz;
@@ -371,7 +277,7 @@
 	int status;	
 	cache_entry_t* ptr;
 	
-	if (dbase_cache_fill(dbase) < 0)
+	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
 	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
@@ -402,7 +308,7 @@
 	size_t tmp_count;
 	int i = 0;
 	
-	if (dbase_cache_fill(dbase) < 0)
+	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
 	tmp_count = dbase->cache_sz;
diff -Naur --exclude CVS libsemanage/src/database_direct.c libsemanage.new2/src/database_direct.c
--- libsemanage/src/database_direct.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new2/src/database_direct.c	2005-09-29 18:52:38.000000000 -0400
@@ -0,0 +1,94 @@
+struct dbase_direct_backend;
+typedef struct dbase_direct_backend dbase_backend_t;
+#define BACKEND_DEFINED
+
+#include <stdlib.h>
+#include <sepol/policydb.h>
+#include "database_direct.h"
+#include "interfaces.h"
+#include "debug.h"
+
+/* POLICY DIRECT backend */
+struct dbase_direct_backend {
+
+	/* Backing file */
+	const char* filename;
+
+	/* Address to store the policydb object, once it's
+	 * read from the file above. This is a double pointer,
+	 * because the address will be provided from outside.
+	 * This is done for two reasons:
+	 *
+	 * 1) We want to share the same policy backend object
+	 * for multiple databases {user/interfaces/ports} -> same policydb
+	 * backend. We don't want to re-construct the policy separately for
+	 * each.
+	 *
+	 * 2) This allows the policydb to updated outside the dbase_*
+	 * call chain...for example on commit(), after modifications are made.
+	 */
+	policydb_t** policy;
+
+	/* Method of access */
+	record_direct_table_t* rptable;
+
+};
+
+static int dbase_direct_cache(
+        dbase_t* dbase,
+	dbase_direct_backend_t* backend) {
+
+	/* Stub */
+	dbase = NULL;
+	backend = NULL;
+	return STATUS_SUCCESS;	
+}
+
+static int dbase_direct_flush(
+	dbase_t* dbase,
+	dbase_direct_backend_t* backend) {
+
+	/* Stub */
+	dbase = NULL;
+	backend = NULL;
+	return STATUS_SUCCESS;
+}
+
+int dbase_direct_init(
+	const char* filename,
+	policydb_t** policy_update_ptr,
+	record_direct_table_t* rptable,
+        dbase_direct_backend_t** backend) {
+
+	dbase_direct_backend_t* tmp_backend =
+		(dbase_direct_backend_t*) malloc(sizeof(dbase_direct_backend_t));
+
+	if (!tmp_backend)
+		goto omem;
+
+	tmp_backend->filename = filename;
+	tmp_backend->rptable = rptable;
+	tmp_backend->policy = policy_update_ptr;
+	*backend = tmp_backend;
+
+	return STATUS_SUCCESS;
+
+	omem:
+	/* FIXME: handle error condition */
+	free(tmp_backend);
+
+	return STATUS_ERR;
+}
+
+/* Release backend resources */
+void dbase_direct_release(
+	dbase_direct_backend_t* backend) {
+
+	free(backend);
+}
+
+/* DIRECT POLICY backend - method table implementation */
+dbase_backend_table_t SEMANAGE_DIRECT_BTABLE = {
+	.cache = dbase_direct_cache,
+	.flush = dbase_direct_flush,
+};
diff -Naur --exclude CVS libsemanage/src/database_direct.h libsemanage.new2/src/database_direct.h
--- libsemanage/src/database_direct.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new2/src/database_direct.h	2005-09-29 18:52:42.000000000 -0400
@@ -0,0 +1,24 @@
+#ifndef _SEMANAGE_DATABASE_DIRECT_INTERNAL_H_
+#define _SEMANAGE_DATABASE_DIRECT_INTERNAL_H_
+
+#include "database.h"
+#include "interfaces.h"
+
+struct dbase_direct_backend;
+typedef struct dbase_direct_backend dbase_direct_backend_t;
+
+/* POLICY DIRECT backend - initialization */
+extern int dbase_direct_init(
+	const char* filename,
+	policydb_t** policy_update_ptr,
+	record_direct_table_t* rptable,
+	dbase_direct_backend_t** backend);
+
+/* POLICY DIRECT backend - release */
+extern void dbase_direct_release(
+	dbase_direct_backend_t* backend);
+
+/* POLICY DIRECT backend - method table implementation */
+extern dbase_backend_table_t SEMANAGE_DIRECT_BTABLE;
+
+#endif
diff -Naur --exclude CVS libsemanage/src/database_file.c libsemanage.new2/src/database_file.c
--- libsemanage/src/database_file.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new2/src/database_file.c	2005-09-29 18:54:06.000000000 -0400
@@ -0,0 +1,143 @@
+struct dbase_file_backend;
+typedef struct dbase_file_backend dbase_backend_t;
+#define BACKEND_DEFINED
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <stdio_ext.h>
+#include "debug.h"
+#include "interfaces.h"
+#include "database_file.h"
+
+/* FILE backend */ 
+struct dbase_file_backend {
+
+	/* Backing file */
+	const char* filename;
+
+	/* Method of access */
+	record_file_table_t* rftable;
+};
+
+static int dbase_file_open(parse_info_t* info) {
+
+	info->file_stream = fopen(info->filename, "r");
+	if (!info->file_stream && (errno != ENOENT)) {
+		/* FIXME: handle error condition */
+		return STATUS_ERR;
+	}
+	if (info->file_stream)
+		__fsetlocking(info->file_stream, FSETLOCKING_BYCALLER);
+
+	return STATUS_SUCCESS;
+}
+
+static void dbase_file_close(parse_info_t* info) {
+	if (info->file_stream && (fclose(info->file_stream) < 0))
+		/* FIXME: handle error condition */
+	info->file_stream = NULL;
+}
+
+static int dbase_file_cache(
+	dbase_t* dbase,
+	dbase_file_backend_t* backend) {
+
+	/* Already cached */
+	if (dbase->cached && (!dbase->cache_invalid))
+		return STATUS_SUCCESS;
+
+	int perr_fatal = 0;
+	/* FIXME: pass from caller? */
+
+	record_t process_record = NULL;
+	int pstatus = STATUS_SUCCESS;
+	parse_info_t parse_info;
+	parse_info.filename = backend->filename;
+	parse_info.parse_arg = NULL;
+	/* FIXME: pass from caller? */
+
+	if (dbase_file_open(&parse_info) < 0)
+                goto err;
+
+	/* Main processing loop */
+	do {
+		/* Create record */
+		if (dbase->rtable->create(&process_record) < 0)
+			goto err;
+
+		/* Parse record */
+		pstatus = backend->rftable->parse(&parse_info, process_record);
+
+		/* Parse error is fatal, exit */
+		if (perr_fatal && (pstatus < 0))
+			goto err;
+
+		/* Parse error is not fatal */
+		else if (pstatus < 0)
+			continue;
+
+		/* Add record to list */
+		if (dbase_cache_add(dbase, process_record) < 0)
+			goto err;
+
+	} while (pstatus != STATUS_NODATA);
+
+	dbase_file_close(&parse_info);
+	dbase->cached = 1;
+	dbase->cache_invalid = 0;
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle failure */
+	dbase->rtable->free(process_record);
+	dbase_file_close(&parse_info);
+	return STATUS_ERR;
+}
+
+/* Flush database to file */
+static int dbase_file_flush(
+	dbase_t* dbase,
+	dbase_file_backend_t* backend) {
+
+	/* Stub */
+	dbase = NULL;
+	backend = NULL;
+	return STATUS_SUCCESS;
+}
+
+int dbase_file_init(
+	const char* filename,
+	record_file_table_t* rftable,
+	dbase_file_backend_t** backend) {
+
+	dbase_file_backend_t* tmp_backend = 
+		(dbase_file_backend_t*) malloc(sizeof(dbase_file_backend_t));
+	
+	if (!tmp_backend)
+		goto omem;
+
+	tmp_backend->filename = filename;
+	tmp_backend->rftable = rftable;
+	*backend = tmp_backend;
+	
+	return STATUS_SUCCESS;
+	
+	omem:
+	/* FIXME: handle error condition */
+	free(tmp_backend);
+	return STATUS_ERR;
+}
+		
+/* Release backend resources */
+void dbase_file_release(
+	dbase_file_backend_t* backend) {
+
+	free(backend);
+}
+
+/* FILE backend - method table implementation */
+dbase_backend_table_t SEMANAGE_FILE_BTABLE = {
+	.cache = dbase_file_cache,
+	.flush = dbase_file_flush,
+};
diff -Naur --exclude CVS libsemanage/src/database_file.h libsemanage.new2/src/database_file.h
--- libsemanage/src/database_file.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new2/src/database_file.h	2005-09-29 18:53:50.000000000 -0400
@@ -0,0 +1,23 @@
+#ifndef _SEMANAGE_DATABASE_FILE_INTERNAL_H_
+#define _SEMANAGE_DATABASE_FILE_INTERNAL_H_
+
+#include "database.h"
+#include "interfaces.h"
+
+struct dbase_file_backend;
+typedef struct dbase_file_backend dbase_file_backend_t;
+
+/* FILE backend - initialization */
+extern int dbase_file_init(
+	const char* filename,
+	record_file_table_t* rftable,
+	dbase_file_backend_t** backend);
+
+/* FILE backend - release */
+extern void dbase_file_release(
+	dbase_file_backend_t* backend);
+
+/* FILE backend - method table implementation */
+extern dbase_backend_table_t SEMANAGE_FILE_BTABLE;
+
+#endif
diff -Naur --exclude CVS libsemanage/src/database.h libsemanage.new2/src/database.h
--- libsemanage/src/database.h	2005-09-29 18:34:10.000000000 -0400
+++ libsemanage.new2/src/database.h	2005-09-29 18:57:01.000000000 -0400
@@ -7,19 +7,67 @@
 #define RECORD_DEFINED
 #endif
 
+#ifndef BACKEND_DEFINED
+typedef void* dbase_backend_t;
+#define BACKEND_DEFINED
+#endif
+
 #include <stddef.h>
 #include "handle.h"
 #include "interfaces.h"
 
-struct dbase;
-typedef struct dbase dbase_t;
+/* ==========================================
+   Internal representation of the database.
+   Not to be used outside database_*.c
+ * =========================================== */
+
+/* Representation of the database once loaded in memory */
+typedef struct cache_entry {
+        record_t data;
+        struct cache_entry* next;
+} cache_entry_t;
+
+/* Database-specific configuration */
+typedef struct dbase {
+
+        /* Base record functions */
+        record_table_t* rtable;
+
+        /* Backend */
+        dbase_backend_t* backend;
+
+        /* Table to manipulate backend */
+        dbase_backend_table_t* btable;
+
+        /* In-memory representation (cache) */
+        cache_entry_t* cache;
+        size_t cache_sz;
+        int cached;
+        int cache_invalid;
+} dbase_t;
+
+/* Add a record to the database cache */
+extern int dbase_cache_add(
+	dbase_t* dbase,
+	record_t data);
+
+/* ======================================
+   API for use elsewhere:
+  ======================================= */
 
 /* Initialize a database */
 extern int dbase_init(
 	record_table_t* rtable,
-	const char* filename,
+	dbase_backend_t* backend,
+	dbase_backend_table_t* btable,
 	dbase_t** dbase);
 
+/* Get back the backend object  */
+static inline dbase_backend_t* dbase_get_backend(
+	dbase_t* dbase) {
+	return dbase->backend;
+}
+
 /* Release a database */
 extern void dbase_release(
 	dbase_t* dbase);
@@ -32,6 +80,7 @@
 extern void dbase_invalidate_cache(
 	dbase_t* dbase);
 
+/* Standard database operations */
 extern int dbase_add(
 	semanage_handle_t* handle,
 	dbase_t* dbase,
diff -Naur --exclude CVS libsemanage/src/handle.c libsemanage.new2/src/handle.c
--- libsemanage/src/handle.c	2005-09-29 17:54:40.000000000 -0400
+++ libsemanage.new2/src/handle.c	2005-09-29 19:14:00.000000000 -0400
@@ -124,8 +124,8 @@
 	semanage_conf_destroy(sh->conf);
 
 	/* Free object databases */
-	dbase_release(sh->dbase[DBASE_USERS]);
-	dbase_release(sh->dbase[DBASE_PORTS]);
+	user_file_dbase_release(sh->dbase[DBASE_USERS]);
+	port_file_dbase_release(sh->dbase[DBASE_PORTS]);
 
 	free(sh);
 }
diff -Naur --exclude CVS libsemanage/src/interfaces.h libsemanage.new2/src/interfaces.h
--- libsemanage/src/interfaces.h	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage.new2/src/interfaces.h	2005-09-29 18:58:33.000000000 -0400
@@ -1,7 +1,7 @@
 #ifndef _SEMANAGE_RECORD_FILE_H_
 #define _SEMANAGE_RECORD_FILE_H_
 
-#include <stdio.h>
+/* The interfaces below are used for polymorphism */
 
 #ifndef RECORD_DEFINED
 typedef void* record_t;
@@ -9,6 +9,17 @@
 #define RECORD_DEFINED
 #endif
 
+#ifndef BACKEND_DEFINED
+typedef void* dbase_backend_t;
+#define BACKEND_DEFINED
+#endif
+
+#include <stdio.h>
+#include <sepol/policydb.h>
+
+/* Circular dependency - can't include database.h */
+struct dbase;
+
 /* Structure available during parsing (created internally) */
 typedef struct parse_info {
 	/* Parser controlled */
@@ -22,7 +33,7 @@
 	void* parse_arg;
 } parse_info_t;
 
-/* Record table format - necessary during processing */
+/* RECORD interface - method table */
 typedef struct record_table {
 
 	/* Create a record */
@@ -41,6 +52,15 @@
 	/* Deep-copy clone of this record */
 	int (*clone) (record_t rec, record_t* new_rec);
 
+	/* Deallocate record resources. Must
+	 * sucessfully handle NULL. */
+	void (*free) (record_t rec);
+
+} record_table_t;
+
+/* FILE extension to RECORD interface - method table */
+typedef struct record_file_table {
+
 	/* Fill record structuure based on supplied parse info.
 	 * Parser must return STATUS_NODATA when EOF is encountered.
 	 * Parser must handle NULL file stream correctly */
@@ -49,9 +69,28 @@
 	/* Print record to stream */
 	int (*print) (record_t record, FILE* str);
 
-	/* Deallocate record resources. Must
-	 * sucessfully handle NULL. */
-	void (*free) (record_t rec);
-} record_table_t;
+} record_file_table_t;
+
+/* POLICY DIRECT extension to RECORD interface - method table */
+typedef struct record_direct_table {
+
+	/* Load record into policy store */
+	int (*load) (policydb_t* policy, record_t record); 
+
+	/* Extract records from policy store */
+	int (*list) (policydb_t* policy, record_t** records, size_t* nrecords);
+
+} record_direct_table_t;
+
+/* DBASE_BACKEND interface - method table */
+typedef struct dbase_backend_table {
+
+	/* Cache backend into dbase */
+	int (*cache) (struct dbase* dbase, dbase_backend_t* backend);	
+
+	/* Flush dbase to backend */
+	int (*flush) (struct dbase* dbase, dbase_backend_t* backend);
+
+} dbase_backend_table_t;
 
 #endif 
diff -Naur --exclude CVS libsemanage/src/ports.c libsemanage.new2/src/ports.c
--- libsemanage/src/ports.c	2005-09-29 18:34:10.000000000 -0400
+++ libsemanage.new2/src/ports.c	2005-09-29 19:06:11.000000000 -0400
@@ -13,6 +13,17 @@
 #include <semanage/ports.h>
 #include "database.h"
 #include "handle.h"
+#include "interfaces.h"
+
+/* Port base functions */
+record_table_t SEMANAGE_PORT_RTABLE = {
+	.create      = semanage_port_create,
+	.key_extract = semanage_port_key_extract,
+	.key_free    = semanage_port_key_free,
+	.clone       = semanage_port_clone,
+	.compare     = semanage_port_compare,
+	.free        = semanage_port_free,
+};
 
 int semanage_port_add(
 	semanage_handle_t* handle,
diff -Naur --exclude CVS libsemanage/src/ports_direct.c libsemanage.new2/src/ports_direct.c
--- libsemanage/src/ports_direct.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new2/src/ports_direct.c	2005-09-29 18:56:49.000000000 -0400
@@ -0,0 +1,54 @@
+/* 
+ * Code for manipulating the port POLICY DIRECT backend
+ */
+#include <sepol/port_record.h>
+
+typedef sepol_port_t* record_t;
+typedef sepol_port_key_t* record_key_t;
+#define RECORD_DEFINED
+
+struct dbase_direct_backend;
+typedef struct dbase_direct_backend dbase_backend_t;
+#define BACKEND_DEFINED
+
+#include <stddef.h>
+#include <sepol/ports.h>
+#include <sepol/policydb.h>
+#include "ports_direct.h"
+#include "debug.h"
+#include "interfaces.h"
+#include "database_direct.h"
+
+/* PORT RECORD (SEPOL): method table (ports_policy.c) */
+extern record_table_t SEPOL_PORT_RTABLE;
+
+/* PORT RECORD (SEPOL): POLICY DIRECT extension : method table */
+record_direct_table_t SEMANAGE_PORT_DIRECT_RTABLE = {
+	.load        = sepol_port_load,
+	.list        = NULL, /* sepol_port_list,  */      
+};
+
+int port_direct_dbase_init(dbase_t** dbase) {
+	dbase_direct_backend_t* backend;
+
+	if (dbase_direct_init(
+		NULL, /* FIXME */
+		NULL, /* FIXME */
+		&SEMANAGE_PORT_DIRECT_RTABLE,
+		&backend) < 0)
+		return STATUS_ERR;
+
+	return dbase_init(
+		&SEPOL_PORT_RTABLE,
+		backend,
+		&SEMANAGE_DIRECT_BTABLE,
+		dbase);
+}
+
+void port_direct_dbase_release(dbase_t* dbase) {
+	if (dbase == NULL)
+		return;
+
+	dbase_direct_release(dbase_get_backend(dbase));
+	dbase_release(dbase);
+}
diff -Naur --exclude CVS libsemanage/src/ports_direct.h libsemanage.new2/src/ports_direct.h
--- libsemanage/src/ports_direct.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new2/src/ports_direct.h	2005-09-29 18:47:55.000000000 -0400
@@ -0,0 +1,16 @@
+#ifndef _SEMANAGE_PORTS_DIRECT_H_
+#define _SEMANAGE_PORTS_DIRECT_H_
+
+/*
+ * Header for the port POLICY DIRECT backend
+ */
+
+#include "database.h"
+
+int port_direct_dbase_init(
+	dbase_t** dbase);
+
+void port_direct_dbase_release(
+	dbase_t* dbase);
+
+#endif
diff -Naur --exclude CVS libsemanage/src/ports_file.c libsemanage.new2/src/ports_file.c
--- libsemanage/src/ports_file.c	2005-09-29 17:54:40.000000000 -0400
+++ libsemanage.new2/src/ports_file.c	2005-09-29 18:50:58.000000000 -0400
@@ -4,14 +4,17 @@
 typedef semanage_port_key_t record_key_t;
 #define RECORD_DEFINED
 
+struct dbase_file_backend;
+typedef struct dbase_file_backend dbase_backend_t;
+#define BACKEND_DEFINED
+
 #include <stdlib.h>
 #include <stdio.h>
-#include <semanage/port_record.h>
-#include "debug.h"
 #include "interfaces.h"
-#include "database.h"
+#include "database_file.h"
+#include "debug.h"
 
-static int semanage_port_print(
+static int port_print(
 	semanage_port_t port, 
 	FILE* str) {
 
@@ -21,7 +24,7 @@
 	return STATUS_SUCCESS;
 }
 
-static int semanage_port_parse(
+static int port_parse(
 	parse_info_t* info, 
 	semanage_port_t port) {
 
@@ -31,24 +34,28 @@
 	return STATUS_SUCCESS;	
 }
 
-record_table_t SEMANAGE_PORT_RTABLE = {
-	/* Record base functions */
-	.create      = semanage_port_create,
-	.key_extract = semanage_port_key_extract,
-	.key_free    = semanage_port_key_free,
-	.clone       = semanage_port_clone,
-	.compare     = semanage_port_compare,
-	.free        = semanage_port_free,
-
-	/* Record functions for FILE backend */
-	.parse       = semanage_port_parse,
-	.print       = semanage_port_print,
+/* PORT RECORD: method table (ports.c) */
+extern record_table_t SEMANAGE_PORT_RTABLE;
+
+/* PORT RECORD: FILE extension: method table */
+record_file_table_t SEMANAGE_PORT_FILE_RTABLE = {
+	.parse       = port_parse,
+	.print       = port_print,
 };
 
 int port_file_dbase_init(dbase_t** dbase) {
+
+	dbase_file_backend_t* backend;
+
+	if (dbase_file_init(
+		NULL, /* FIXME */
+		&SEMANAGE_PORT_FILE_RTABLE, &backend) < 0)
+		return STATUS_ERR;
+
 	return dbase_init(
 		&SEMANAGE_PORT_RTABLE,
-		NULL, /* FIXME */
+		backend,
+		&SEMANAGE_FILE_BTABLE,
 		dbase);
 }
 
@@ -56,5 +63,6 @@
 	if (dbase == NULL)
 		return;
 
+	dbase_file_release(dbase_get_backend(dbase));
 	dbase_release(dbase);
 }
diff -Naur --exclude CVS libsemanage/src/ports_policy.c libsemanage.new2/src/ports_policy.c
--- libsemanage/src/ports_policy.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new2/src/ports_policy.c	2005-09-29 19:01:45.000000000 -0400
@@ -0,0 +1,69 @@
+/* 
+ * Common code for manipulating port POLICY backends
+ */
+
+#include <sepol/port_record.h>
+
+typedef sepol_port_key_t* record_key_t;
+typedef sepol_port_t* record_t;
+#define RECORD_DEFINED
+
+#include <semanage/port_record.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include "handle.h"
+#include "database.h"
+#include "interfaces.h"
+#include "ports_policy.h"
+#include "debug.h"
+
+static inline int convert(
+	semanage_port_key_t semanage_key,
+	semanage_port_t semanage_port,
+	sepol_port_key_t** sepol_key,
+	sepol_port_t** sepol_port) {
+
+	*sepol_key = (sepol_port_key_t*) semanage_key;
+	*sepol_port = (sepol_port_t*) semanage_port;
+	return STATUS_SUCCESS;
+}
+
+/* PORT RECORD (SEPOL): method table */
+record_table_t SEPOL_PORT_RTABLE = {
+	.create      = sepol_port_create,
+	.key_extract = sepol_port_key_extract,
+	.key_free    = sepol_port_key_free,
+	.clone       = sepol_port_clone,
+	.compare     = sepol_port_compare,
+	.free        = sepol_port_free,
+};
+
+/* FIXME: might need to change */
+#if 0
+int semanage_port_policy_load(
+	semanage_handle_t* handle,
+	semanage_port_key_t key,
+	semanage_port_t data) {
+
+	sepol_port_t* sepol_data;
+	sepol_port_key_t* sepol_key;
+
+	if (convert(key, data, &sepol_key, &sepol_data) < 0)
+		return STATUS_ERR;
+
+	dbase_t* dbase = semanage_port_direct_dbase(handle);
+	return dbase_add(handle, dbase, sepol_key, sepol_data);	
+}
+
+int semanage_port_policy_list(
+	semanage_handle_t* handle,
+	semanage_port_t** records,
+	size_t* count) {
+
+	/* Stub */
+	handle = NULL;
+	records = NULL;
+	count = NULL;
+	return STATUS_SUCCESS;
+}
+#endif
diff -Naur --exclude CVS libsemanage/src/ports_policy.h libsemanage.new2/src/ports_policy.h
--- libsemanage/src/ports_policy.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new2/src/ports_policy.h	2005-09-29 18:59:17.000000000 -0400
@@ -0,0 +1,18 @@
+#ifndef _SEMANAGE_PORTS_POLICY_H_
+#define _SEMANAGE_PORTS_POLICY_H_
+
+#include <stddef.h>
+#include <semanage/port_record.h>
+#include "handle.h"
+
+int semanage_port_policy_load(
+	semanage_handle_t* handle,
+	semanage_port_key_t key,
+	semanage_port_t data);
+
+int semanage_port_policy_list(
+	semanage_handle_t* handle,
+	semanage_port_t** records,
+	size_t* count);
+
+#endif
diff -Naur --exclude CVS libsemanage/src/users.c libsemanage.new2/src/users.c
--- libsemanage/src/users.c	2005-09-29 18:34:10.000000000 -0400
+++ libsemanage.new2/src/users.c	2005-09-29 19:06:03.000000000 -0400
@@ -13,6 +13,17 @@
 #include <semanage/users.h>
 #include "handle.h"
 #include "database.h"
+#include "interfaces.h"
+
+/* Record base functions */
+record_table_t SEMANAGE_USER_RTABLE = {
+	.create      = semanage_user_create,
+	.key_extract = semanage_user_key_extract,
+	.key_free    = semanage_user_key_free,
+	.clone       = semanage_user_clone,
+	.compare     = semanage_user_compare,
+	.free        = semanage_user_free,
+};
 
 int semanage_user_add(
 	semanage_handle_t* handle,
diff -Naur --exclude CVS libsemanage/src/users_direct.c libsemanage.new2/src/users_direct.c
--- libsemanage/src/users_direct.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new2/src/users_direct.c	2005-09-29 18:56:47.000000000 -0400
@@ -0,0 +1,54 @@
+/*
+ * Code for manipulating the user DATA FILE backend
+ */
+#include <sepol/user_record.h>
+
+typedef sepol_user_t* record_t;
+typedef sepol_user_key_t* record_key_t;
+#define RECORD_DEFINED
+
+struct dbase_direct_backend;
+typedef struct dbase_direct_backend dbase_backend_t;
+#define BACKEND_DEFINED
+
+#include <stddef.h>
+#include <sepol/users.h>
+#include <sepol/policydb.h>
+#include "users_direct.h"
+#include "debug.h"
+#include "interfaces.h"
+#include "database_direct.h"
+
+/* USER RECORD (SEPOL): method table (users_policy.c) */
+extern record_table_t SEPOL_USER_RTABLE;
+
+/* USER RECRORD (SEPOL): POLICY DIRECT extension: method table */
+record_direct_table_t SEMANAGE_USER_DIRECT_RTABLE = {
+	.load        = sepol_user_load,
+	.list        = NULL, /* sepol_user_list */      
+};
+
+int user_direct_dbase_init(dbase_t** dbase) {
+	dbase_direct_backend_t* backend;
+
+	if (dbase_direct_init(
+		NULL, /* FIXME */
+		NULL, /* FIXME */
+		&SEMANAGE_USER_DIRECT_RTABLE,
+		&backend) < 0)
+		return STATUS_ERR;
+
+	return dbase_init(
+		&SEPOL_USER_RTABLE,
+		backend,
+		&SEMANAGE_DIRECT_BTABLE,
+		dbase);
+}
+
+void user_direct_dbase_release(dbase_t* dbase) {
+	if (dbase == NULL)
+		return;
+
+	dbase_direct_release(dbase_get_backend(dbase));
+	dbase_release(dbase);
+}
diff -Naur --exclude CVS libsemanage/src/users_direct.h libsemanage.new2/src/users_direct.h
--- libsemanage/src/users_direct.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new2/src/users_direct.h	2005-09-29 18:47:50.000000000 -0400
@@ -0,0 +1,16 @@
+#ifndef _SEMANAGE_USERS_DIRECT_H_
+#define _SEMANAGE_USERS_DIRECT_H_
+
+/* 
+ * Header for the user POLICY DIRECT backend 
+ */
+
+#include "database.h"
+
+int user_direct_dbase_init(
+	dbase_t** dbase);
+
+void user_direct_dbase_release(
+	dbase_t* dbase);
+
+#endif
diff -Naur --exclude CVS libsemanage/src/users_file.c libsemanage.new2/src/users_file.c
--- libsemanage/src/users_file.c	2005-09-29 17:54:40.000000000 -0400
+++ libsemanage.new2/src/users_file.c	2005-09-29 19:11:43.000000000 -0400
@@ -4,13 +4,17 @@
 typedef semanage_user_key_t record_key_t;
 #define RECORD_DEFINED
 
+struct dbase_file_backend;
+typedef struct dbase_file_backend dbase_backend_t;
+#define BACKEND_DEFINED 
+
 #include <stdlib.h>
 #include <stdio.h>
 #include "interfaces.h"
-#include "database.h"
+#include "database_file.h"
 #include "debug.h"
 
-static int semanage_user_print(
+static int user_print(
 	semanage_user_t user, 
 	FILE* str) {
 
@@ -20,7 +24,7 @@
 	return STATUS_SUCCESS;
 }
 
-static int semanage_user_parse(
+static int user_parse(
 	parse_info_t* info, 
 	semanage_user_t user) {
 
@@ -30,24 +34,28 @@
 	return STATUS_SUCCESS;	
 }
 
-record_table_t SEMANAGE_USER_RTABLE = {
-	/* Record base functions */
-	.create      = semanage_user_create,
-	.key_extract = semanage_user_key_extract,
-	.key_free    = semanage_user_key_free,
-	.clone       = semanage_user_clone,
-	.compare     = semanage_user_compare,
-	.free        = semanage_user_free,
-
-	/* Record functions for FILE backend */
-	.parse       = semanage_user_parse,
-	.print       = semanage_user_print,
+/* USER RECORD: metod table (users.c) */
+extern record_table_t SEMANAGE_USER_RTABLE;
+
+/* USER RECORD: FILE extension: method table */
+record_file_table_t SEMANAGE_USER_FILE_RTABLE = {
+	.parse       = user_parse,
+	.print       = user_print,
 };
 
 int user_file_dbase_init(dbase_t** dbase) {
+	dbase_file_backend_t* backend;
+	
+	if (dbase_file_init(
+		NULL, /* FIXME */
+		&SEMANAGE_USER_FILE_RTABLE,
+		&backend) < 0)
+		return STATUS_ERR;
+
 	return dbase_init(
 		&SEMANAGE_USER_RTABLE,
-		NULL, /* FIXME */
+		backend,
+		&SEMANAGE_FILE_BTABLE,
 		dbase);
 }
 
@@ -55,6 +63,6 @@
 	if (dbase == NULL)
 		return;
 
+	dbase_file_release(dbase_get_backend(dbase));
 	dbase_release(dbase);
 }
-
diff -Naur --exclude CVS libsemanage/src/users_policy.c libsemanage.new2/src/users_policy.c
--- libsemanage/src/users_policy.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new2/src/users_policy.c	2005-09-29 19:01:58.000000000 -0400
@@ -0,0 +1,69 @@
+/*
+ * Common code for manipulating user POLICY backends 
+ */
+
+#include <sepol/user_record.h>
+
+typedef sepol_user_key_t* record_key_t;
+typedef sepol_user_t* record_t;
+#define RECORD_DEFINED
+
+#include <stddef.h>
+#include <stdlib.h>
+#include <semanage/user_record.h>
+#include "handle.h"
+#include "database.h"
+#include "interfaces.h"
+#include "users_policy.h"
+#include "debug.h"
+
+static inline int convert(
+	semanage_user_key_t semanage_key,
+	semanage_user_t semanage_user,
+	sepol_user_key_t** sepol_key,
+	sepol_user_t** sepol_user) {
+
+	*sepol_key = (sepol_user_key_t*) semanage_key;
+	*sepol_user = (sepol_user_t*) semanage_user;
+	return STATUS_SUCCESS;
+}
+
+/* USER RECORD (SEPOL): method table */
+record_table_t SEPOL_USER_RTABLE = {
+	.create      = sepol_user_create,
+	.key_extract = sepol_user_key_extract,
+	.key_free    = sepol_user_key_free,
+	.clone       = sepol_user_clone,
+	.compare     = sepol_user_compare,
+	.free        = sepol_user_free,
+};
+
+/* FIXME: might need to change */
+#if 0
+int semanage_user_policy_load(
+	semanage_handle_t* handle,
+	semanage_user_key_t key,
+	semanage_user_t data) {
+
+	sepol_user_t* sepol_data;
+	sepol_user_key_t* sepol_key;
+
+	if (convert(key, data, &sepol_key, &sepol_data) < 0)
+		return STATUS_ERR;
+
+	dbase_t* dbase = semanage_user_direct_dbase(handle);
+	return dbase_add(handle, dbase, sepol_key, sepol_data);
+}
+
+int semanage_user_policy_list(
+	semanage_handle_t* handle,
+	semanage_user_t** records,
+	size_t* count) {
+
+	/* Stub */
+	handle = NULL;
+	records = NULL;
+	count = NULL;
+	return STATUS_SUCCESS;
+}
+#endif
diff -Naur --exclude CVS libsemanage/src/users_policy.h libsemanage.new2/src/users_policy.h
--- libsemanage/src/users_policy.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new2/src/users_policy.h	2005-09-29 18:59:14.000000000 -0400
@@ -0,0 +1,18 @@
+#ifndef _SEMANAGE_USERS_POLICY_H_
+#define _SEMANAGE_USERS_POLICY_H_
+
+#include <stddef.h>
+#include <semanage/user_record.h>
+#include "handle.h"
+
+int semanage_user_policy_load(
+	semanage_handle_t* handle,
+	semanage_user_key_t key,
+	semanage_user_t data);
+
+int semanage_user_policy_list(
+	semanage_handle_t* handle,
+	semanage_user_t** records,
+	size_t* count);
+
+#endif

--------------060008020102000906090102--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
