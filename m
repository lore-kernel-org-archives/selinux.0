Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8NNPZNs003011
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2005 19:25:35 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8NNKu0H026874
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2005 23:20:56 GMT
Message-ID: <43348FB4.4000108@cornell.edu>
Date: Fri, 23 Sep 2005 19:28:52 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: dwalsh@redhat.com, jbrindle@tresys.com
Subject: [ SEMANAGE ] dbase initialization/semanage_handle stub/fixes
Content-Type: multipart/mixed;
 boundary="------------010702030505070503070301"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010702030505070503070301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch does the following:

- Stub out semanage_handle structure and create/destroy.
Put those in include/semanage/handle.h, src/handle.h, src/handle.c.
Relay the handle down to the dbase_* level, but not any lower (for now).
Joshua, please add your patch on top of that.

- Set up initialization of dbase_config_t (most of it anyway - filename 
is still
missing). On handle creation, the handle code queries XXX_file.c, which
invokes a dbase_config_t initialization function with the appropriate
parameters. On handle destruction, do the same thing for releasing
resources. The database configuration(s) are now kept in the handle.

- Split the record table into two - base table, and file-related table.
This will be necessary for future changes that try to support policydb
as a database.

- Move the generic chunk of the record table into users.c/ports.c
where it belongs.

- Replaces the doubly-linked list in dbase_* with a singly-linked list.

- Fixes incorrect sepol function name:
sepol_user_get_num_roles -> sepol_user_get_numroles

- Adds stddef.h to user_record semanage headers.



--------------010702030505070503070301
Content-Type: text/x-patch;
 name="libsemanage.dbase.misc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.dbase.misc.diff"

diff -Naru libsemanage.new/include/semanage/handle.h libsemanage/include/semanage/handle.h
--- libsemanage.new/include/semanage/handle.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/include/semanage/handle.h	2005-09-23 17:27:31.000000000 -0400
@@ -0,0 +1,10 @@
+#ifndef _SEMANAGE_HANDLE_H_
+#define _SEMANAGE_HANDLE_H_ 
+
+struct semanage_handle;
+typedef struct semanage_handle semanage_handle_t;
+
+semanage_handle_t* semanage_handle_create(void);
+void semanage_handle_destroy(semanage_handle_t *);
+
+#endif
diff -Naru libsemanage.new/include/semanage/ports.h libsemanage/include/semanage/ports.h
--- libsemanage.new/include/semanage/ports.h	2005-09-23 10:37:40.000000000 -0400
+++ libsemanage/include/semanage/ports.h	2005-09-23 16:56:15.000000000 -0400
@@ -3,35 +3,44 @@
 
 #include <stddef.h>
 #include <semanage/port_record.h>
+#include <semanage/handle.h>
 
 extern int semanage_port_add(
+	semanage_handle_t* handle,
 	semanage_port_key_t key,
 	semanage_port_t data);
 
 extern int semanage_port_modify(
+	semanage_handle_t* handle,
 	semanage_port_key_t key,
 	semanage_port_t data);
 
 extern int semanage_port_del(
+	semanage_handle_t* handle,
 	semanage_port_key_t key);
 
 extern int semanage_port_query(
+	semanage_handle_t* handle,
 	semanage_port_key_t key,
 	semanage_port_t* response);
 
 extern int semanage_port_exists(
+	semanage_handle_t* handle,
 	semanage_port_key_t key,
 	int* response);
 
 extern int semanage_port_count(
+	semanage_handle_t* handle,
 	int* response);
 
 extern int semanage_port_iterate(
+	semanage_handle_t* handle,
 	int (*handler) (semanage_port_t record,
 	                void* varg),
 	void* handler_arg);
 
 extern int semanage_port_list(
+	semanage_handle_t* handle,
 	semanage_port_t** records,
 	size_t* count);
 
diff -Naru libsemanage.new/include/semanage/user_record.h libsemanage/include/semanage/user_record.h
--- libsemanage.new/include/semanage/user_record.h	2005-09-23 10:37:40.000000000 -0400
+++ libsemanage/include/semanage/user_record.h	2005-09-23 19:06:00.000000000 -0400
@@ -1,6 +1,8 @@
 #ifndef _SEMANAGE_USER_RECORD_H_
 #define _SEMANAGE_USER_RECORD_H_
 
+#include <stddef.h>
+
 struct semanage_user;
 struct semanage_user_key;
 typedef struct semanage_user* semanage_user_t;
@@ -46,7 +48,7 @@
 	const char* mls_range);
 
 /* Role management */
-extern int semanage_user_get_num_roles(
+extern int semanage_user_get_numroles(
 	semanage_user_t user);
 
 extern const char* semanage_user_get_defrole(
diff -Naru libsemanage.new/include/semanage/users.h libsemanage/include/semanage/users.h
--- libsemanage.new/include/semanage/users.h	2005-09-23 10:37:40.000000000 -0400
+++ libsemanage/include/semanage/users.h	2005-09-23 16:55:16.000000000 -0400
@@ -3,35 +3,44 @@
 
 #include <stddef.h>
 #include <semanage/user_record.h>
+#include <semanage/handle.h>
 
 extern int semanage_user_add(
+	semanage_handle_t* handle,
 	semanage_user_key_t key,
 	semanage_user_t data);
 
 extern int semanage_user_modify(
+	semanage_handle_t* handle,
 	semanage_user_key_t key,
 	semanage_user_t data);
 
 extern int semanage_user_del(
+	semanage_handle_t* handle,
 	semanage_user_key_t key);
 
 extern int semanage_user_query(
+	semanage_handle_t* handle,
 	semanage_user_key_t key,
 	semanage_user_t* response);
 
 extern int semanage_user_exists(
+	semanage_handle_t* handle,
 	semanage_user_key_t key,
 	int* response);
 
 extern int semanage_user_count(
+	semanage_handle_t* handle,
 	int* response);
 
 extern int semanage_user_iterate(
+	semanage_handle_t* handle,
 	int (*handler) (semanage_user_t record,
 	                void* varg),
 	void* handler_arg);
 
 extern int semanage_user_list(
+	semanage_handle_t* handle,
 	semanage_user_t** records,
 	size_t* count);
 
diff -Naru libsemanage.new/src/database_file.c libsemanage/src/database_file.c
--- libsemanage.new/src/database_file.c	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage/src/database_file.c	2005-09-23 18:50:03.000000000 -0400
@@ -12,24 +12,69 @@
 /* Representation of the database once loaded in memory */
 typedef struct cache_entry {
 	record_t data;
-	struct cache_entry* prev;
 	struct cache_entry* next;
 } cache_entry_t;
 
 /* Database-specific configuration */
 struct dbase_config {
 
-	/* What's the format of this database */
+	/* Base record functions */
 	record_table_t* rtable;
 
-	/* Where is it stored */
+	/* Extra functions for FILE backend */
+	record_file_table_t* rftable;
+
+	/* Database backing file */
 	const char* filename;
 
-	/* Once parsed, it is cached here */
+        /* In-memory representation */
 	cache_entry_t* cache;
 	size_t cache_sz;
+
 };
 
+/* Initialize the database config */
+int dbase_file_init(
+	record_table_t* rtable,
+	record_file_table_t* rftable,
+	const char* filename,
+	dbase_config_t** dconfig) {
+
+	dbase_config_t* tmp_dconfig = 
+		(dbase_config_t*) malloc(sizeof(dbase_config_t));
+
+	if (tmp_dconfig == NULL)
+		goto omem;	
+
+	tmp_dconfig->rtable = rtable;
+	tmp_dconfig->rftable = rftable;
+	tmp_dconfig->filename = filename;
+	tmp_dconfig->cache = NULL;
+	tmp_dconfig->cache_sz = 0;	
+
+	*dconfig = tmp_dconfig;
+	return STATUS_SUCCESS;	
+
+	omem:
+	/* FIXME: handle error condition */
+	free(tmp_dconfig);
+	return STATUS_ERR;	
+}
+
+/* Release the database config (free cache) */
+void dbase_file_release(
+	dbase_config_t* dconfig) {
+
+	cache_entry_t *prev, *ptr;
+
+	while (ptr != NULL) {
+		prev = ptr;
+		ptr = ptr->next;
+		dconfig->rtable->free(prev->data);
+		free(prev);
+	}
+}
+
 static int dbase_cache_add(
 	dbase_config_t* dconfig,
 	record_t data) {
@@ -39,10 +84,7 @@
 	if (entry == NULL)
 		goto omem;
 	entry->data = data;
-	entry->prev = NULL;
 	entry->next = dconfig->cache;
-	if (dconfig->cache != NULL)
-		dconfig->cache->prev = entry;
 	dconfig->cache = entry;
 	dconfig->cache_sz++;
 
@@ -98,7 +140,7 @@
 			goto err;
 
 		/* Parse record */
-		pstatus = dconfig->rtable->parse(&parse_info, process_record);
+		pstatus = dconfig->rftable->parse(&parse_info, process_record);
 
 		/* Parse error is fatal, exit */
 		if (perr_fatal && (pstatus < 0))
@@ -126,10 +168,10 @@
 
 static int dbase_cache_locate(
 	dbase_config_t* dconfig,
-	record_key_t key, 
+	record_key_t key,
 	cache_entry_t** entry) {
 	
-	cache_entry_t* ptr;
+	cache_entry_t *ptr;
 
 	if (dbase_cache_fill(dconfig) < 0)
 		goto err;
@@ -148,6 +190,7 @@
 }
 
 int dbase_add(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_key_t key,
 	record_t data) {
@@ -157,7 +200,7 @@
 	if (dbase_cache_fill(dconfig) < 0)
 		goto err;
 
-	if (dbase_exists(dconfig, key, &exists) < 0)
+	if (dbase_exists(handle, dconfig, key, &exists) < 0)
 		goto err;
 
 	else if (exists) { 
@@ -176,6 +219,7 @@
 }
 
 int dbase_modify(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_key_t key,
 	record_t data) {
@@ -190,7 +234,7 @@
 	if (status < 0)
 		goto err;
 	if (status == STATUS_NODATA)
-		return dbase_add(dconfig,key,data);
+		return dbase_add(handle, dconfig, key, data);
 	else
 		entry->data = data;
 
@@ -203,32 +247,31 @@
 }
 
 int dbase_del(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_key_t key) {
 
-	cache_entry_t* entry;
+	cache_entry_t *ptr, *prev = NULL;
 	int status;
 
 	if (dbase_cache_fill(dconfig) < 0)
 		goto err;
 
-	status = dbase_cache_locate(dconfig, key, &entry);
-	if (status < 0)
-		goto err;
+	for (ptr = dconfig->cache; ptr != NULL; ptr = ptr->next) {
+		if (! dconfig->rtable->compare(ptr->data, key)) {
+			if (prev != NULL)
+				prev->next = ptr->next;
+			else
+				dconfig->cache = ptr->next;
 	
-	else if (status != STATUS_NODATA) {
-		if (entry->next != NULL)
-			entry->next->prev = entry->prev;
-
-		if (entry->prev != NULL)
-			entry->prev->next = entry->next;
+			dconfig->rtable->free(ptr->data);
+			dconfig->cache_sz--;
+			free(ptr);
+			return STATUS_SUCCESS;
+                }
 		else
-			dconfig->cache = entry->next;
-
-		dconfig->rtable->free(entry->data);
-		dconfig->cache_sz--;
-		free(entry);
-	}
+			prev = ptr;
+        }
 
 	return STATUS_SUCCESS;
 	err:
@@ -237,6 +280,7 @@
 }
 
 int dbase_query(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_key_t key,
 	record_t* response) {
@@ -261,6 +305,7 @@
 }
 
 int dbase_exists(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_key_t key,
 	int* response) {
@@ -284,6 +329,7 @@
 }
 
 int dbase_count(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	int* response) {
 
@@ -299,6 +345,7 @@
 }
 
 int dbase_iterate(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	int (*fn) (record_t record, void* varg),
 	void* fn_arg) {
@@ -326,6 +373,7 @@
 }
 
 int dbase_list(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_t** records,	
 	size_t* count) {
diff -Naru libsemanage.new/src/database.h libsemanage/src/database.h
--- libsemanage.new/src/database.h	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage/src/database.h	2005-09-23 18:47:18.000000000 -0400
@@ -2,6 +2,8 @@
 #define _SEMANAGE_DATABASE_H_
 
 #include <stddef.h>
+#include "handle.h"
+#include "record_file.h"
 
 #ifndef RECORD_DEFINED
 typedef void* record_t;
@@ -12,41 +14,63 @@
 struct dbase_config;
 typedef struct dbase_config dbase_config_t;
 
+/* Initialize a FILE database */
+extern int dbase_file_init(
+        record_table_t* rtable,
+	record_file_table_t* rftable,
+	const char* filename,
+        dbase_config_t** dconfig);
+
+/* Release a FILE database */
+extern void dbase_file_release(
+	dbase_config_t* dconfig);
+
+/* Dabase operations: 
+ ------------------------------------- 
+ */
 extern int dbase_add(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_key_t key,
 	record_t data);
 
 extern int dbase_modify(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_key_t key,
 	record_t data);
 
 extern int dbase_del(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_key_t key);
 
 extern int dbase_query(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_key_t key,
 	record_t* response);
 
 extern int dbase_exists(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_key_t key,
 	int* response);
 
 extern int dbase_count(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	int* response);
 
 extern int dbase_iterate(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	int (*fn) (record_t record,
 	           void* varg),
 	void* fn_arg);
 
 extern int dbase_list(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_t** records,	
 	size_t* count);
diff -Naru libsemanage.new/src/handle.c libsemanage/src/handle.c
--- libsemanage.new/src/handle.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/src/handle.c	2005-09-23 18:53:09.000000000 -0400
@@ -0,0 +1,39 @@
+#include <stdlib.h>
+#include "handle.h"
+#include "database.h"
+#include "users_file.h"
+#include "ports_file.h"
+
+semanage_handle_t* semanage_handle_create(void) {
+
+	semanage_handle_t *sh = calloc(1, sizeof(semanage_handle_t));
+	
+	if (sh == NULL)
+		goto omem;
+	
+	if (user_file_dbase_init(&sh->dbase[DBASE_USERS]) < 0) 
+		goto err;
+
+	if (port_file_dbase_init(&sh->dbase[DBASE_PORTS]) < 0)
+		goto err;
+
+	
+	return sh;
+
+	omem:
+	/* FIXME: handle error condition */
+	err:
+	/* FIXME: handle error condition */
+	semanage_handle_destroy(sh);
+	return NULL;
+}
+
+void semanage_handle_destroy(semanage_handle_t *sh) {
+	if (sh == NULL)
+		return;
+
+	user_file_dbase_release(sh->dbase[DBASE_USERS]);
+	port_file_dbase_release(sh->dbase[DBASE_PORTS]);
+
+	free(sh);
+}
diff -Naru libsemanage.new/src/handle.h libsemanage/src/handle.h
--- libsemanage.new/src/handle.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/src/handle.h	2005-09-23 18:41:06.000000000 -0400
@@ -0,0 +1,27 @@
+#ifndef _SEMANAGE_HANDLE_INTERNAL_H_
+#define _SEMANAGE_HANDLE_INTERNAL_H_
+
+#include <semanage/handle.h>
+
+/* Can't include - circular dependency */
+struct dbase_config;
+
+struct semanage_handle {
+	#define DBASE_COUNT 2
+	#define DBASE_USERS 0
+	#define DBASE_PORTS 1
+	struct dbase_config* dbase[DBASE_COUNT];
+};
+
+static inline
+struct dbase_config* semanage_user_dbase(semanage_handle_t* handle) {
+        return handle->dbase[DBASE_USERS];
+}
+
+static inline
+struct dbase_config* semanage_port_dbase(semanage_handle_t* handle) {
+        return handle->dbase[DBASE_PORTS];
+}
+
+#endif
+
diff -Naru libsemanage.new/src/ports.c libsemanage/src/ports.c
--- libsemanage.new/src/ports.c	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage/src/ports.c	2005-09-23 18:51:25.000000000 -0400
@@ -2,63 +2,90 @@
 #include <stdlib.h>
 #include <semanage/port_record.h>
 #include <semanage/ports.h>
+#include "handle.h"
 
 typedef semanage_port_key_t record_key_t;
 typedef semanage_port_t record_t;
 #define RECORD_DEFINED
 #include "database.h"
 
+/* Port base functions */
+record_table_t RTABLE_PORT = {
+	.create      = semanage_port_create,
+	.key_extract = semanage_port_key_extract,
+	.key_free    = semanage_port_key_free,
+	.clone       = semanage_port_clone,
+	.compare     = semanage_port_compare,
+	.free        = semanage_port_free,
+};
+
 int semanage_port_add(
+	semanage_handle_t* handle,
 	semanage_port_key_t key,
 	semanage_port_t data) {
-	
-	return dbase_add(NULL /* FIXME */, key, data);
+
+	dbase_config_t* dbase = semanage_port_dbase(handle);	
+	return dbase_add(handle, dbase, key, data);
 }
 
 int semanage_port_modify(
+	semanage_handle_t* handle,
 	semanage_port_key_t key,
 	semanage_port_t data) {
 	
-	return dbase_modify(NULL /* FIXME */, key, data);
+	dbase_config_t* dbase = semanage_port_dbase(handle);
+	return dbase_modify(handle, dbase, key, data);
 }
 
 int semanage_port_del(
+	semanage_handle_t* handle,
 	semanage_port_key_t key) {
 
-	return dbase_del(NULL /* FIXME */, key);
+	dbase_config_t* dbase = semanage_port_dbase(handle);
+	return dbase_del(handle, dbase, key);
 }
 
 int semanage_port_query(
+	semanage_handle_t* handle,
 	semanage_port_key_t key,
 	semanage_port_t* response) {
 
-	return dbase_query(NULL /* FIXME */, key, response);
+	dbase_config_t* dbase = semanage_port_dbase(handle);
+	return dbase_query(handle, dbase, key, response);
 }
 
 int semanage_port_exists(
+	semanage_handle_t* handle,
 	semanage_port_key_t key,
 	int* response) {
 
-	return dbase_exists(NULL /* FIXME */, key, response);
+	dbase_config_t* dbase = semanage_port_dbase(handle);
+	return dbase_exists(handle, dbase, key, response);
 }
 
 int semanage_port_count(
+	semanage_handle_t* handle,
 	int* response) {
 
-	return dbase_count(NULL /*FIXME */, response);
+	dbase_config_t* dbase = semanage_port_dbase(handle);
+	return dbase_count(handle, dbase, response);
 }
 
 int semanage_port_iterate(
+	semanage_handle_t* handle,
 	int (*handler) (semanage_port_t record,
 	                void* varg),
 	void* handler_arg) {
 
-	return dbase_iterate(NULL /* FIXME */, handler, handler_arg);
+	dbase_config_t* dbase = semanage_port_dbase(handle);
+	return dbase_iterate(handle, dbase, handler, handler_arg);
 }
 
 int semanage_port_list(
+	semanage_handle_t* handle,
 	semanage_port_t** records,
 	size_t* count) {
 
-	return dbase_list(NULL /* FIXME */, records, count);
+	dbase_config_t* dbase = semanage_port_dbase(handle);
+	return dbase_list(handle, dbase, records, count);
 }
diff -Naru libsemanage.new/src/ports_file.c libsemanage/src/ports_file.c
--- libsemanage.new/src/ports_file.c	2005-09-14 11:44:44.000000000 -0400
+++ libsemanage/src/ports_file.c	2005-09-23 18:52:07.000000000 -0400
@@ -6,6 +6,7 @@
 typedef semanage_port_key_t record_key_t;
 #define RECORD_DEFINED
 #include "record_file.h"
+#include "database.h"
 
 static int semanage_port_print(
 	semanage_port_t port, 
@@ -27,16 +28,23 @@
 	return -1;	
 }
 
-record_table_t RTABLE_PORT = {
-	/* Record base functions */
-	.create      = semanage_port_create,
-	.key_extract = semanage_port_key_extract,
-	.key_free    = semanage_port_key_free,
-	.clone       = semanage_port_clone,
-	.compare     = semanage_port_compare,
-	.free        = semanage_port_free,
+/* From ports.c */
+extern record_table_t RTABLE_PORT;
 
-	/* Record functions for FILE backend */
+/* Record functions for FILE backend */
+record_file_table_t RTABLE_FILE_PORT = {
 	.parse       = semanage_port_parse,
 	.print       = semanage_port_print,
 };
+
+int port_file_dbase_init(dbase_config_t** dconfig) {
+	return dbase_file_init(
+		&RTABLE_PORT,  
+		&RTABLE_FILE_PORT,
+		NULL, /* FIXME */
+		&dconfig);
+}
+
+void port_file_dbase_release(dbase_config_t* dconfig) {
+	dbase_file_release(dconfig);
+}
diff -Naru libsemanage.new/src/ports_file.h libsemanage/src/ports_file.h
--- libsemanage.new/src/ports_file.h	2005-09-14 11:44:44.000000000 -0400
+++ libsemanage/src/ports_file.h	2005-09-23 17:43:39.000000000 -0400
@@ -1,8 +1,12 @@
 #ifndef _SEMANAGE_PORTS_FILE_H_
 #define _SEMANAGE_PORTS_FILE_H_
 
-#include "record_file.h"
+#include "database.h"
 
-extern record_table_t RTABLE_PORT;
+int port_file_dbase_init(
+	dbase_config_t** config);
+
+void port_file_dbase_release(
+	dbase_config_t* config);
 
 #endif 
diff -Naru libsemanage.new/src/record_file.h libsemanage/src/record_file.h
--- libsemanage.new/src/record_file.h	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage/src/record_file.h	2005-09-23 18:21:48.000000000 -0400
@@ -22,7 +22,7 @@
 	void* parse_arg;
 } parse_info_t;
 
-/* Record table format - necessary during processing */
+/* Record table format */
 typedef struct record_table {
 
 	/* Create a record */
@@ -41,6 +41,15 @@
 	/* Deep-copy clone of this record */
 	int (*clone) (record_t rec, record_t* new_rec);
 
+	/* Deallocate record resources. Must
+	 * sucessfully handle NULL. */
+	void (*free) (record_t rec);
+
+} record_table_t;
+
+/* Record table when working with FILE backend */
+typedef struct record_file_table {
+
 	/* Fill record structuure based on supplied parse info.
 	 * Parser must return STATUS_NODATA when EOF is encountered.
 	 * Parser must handle NULL file stream correctly */
@@ -49,9 +58,11 @@
 	/* Print record to stream */
 	int (*print) (record_t record, FILE* str);
 
-	/* Deallocate record resources. Must
-	 * sucessfully handle NULL. */
-	void (*free) (record_t rec);
-} record_table_t;
+} record_file_table_t;
+
+/* Record table when working with POLICY backend */
+typedef struct record_policy_table {
+	/* Stub */
+} record_policy_table_t;
 
 #endif 
diff -Naru libsemanage.new/src/user_record.c libsemanage/src/user_record.c
--- libsemanage.new/src/user_record.c	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage/src/user_record.c	2005-09-23 19:05:48.000000000 -0400
@@ -1,3 +1,4 @@
+#include <stddef.h>
 #include <sepol/user_record.h>
 
 typedef sepol_user_t semanage_user_t;
@@ -47,8 +48,8 @@
 }
 
 /* Role management */
-int semanage_user_get_num_roles(semanage_user_t user) {
-	return sepol_user_get_num_roles(user);
+int semanage_user_get_numroles(semanage_user_t user) {
+	return sepol_user_get_numroles(user);
 }
 
 const char* semanage_user_get_defrole(semanage_user_t user) {
diff -Naru libsemanage.new/src/users.c libsemanage/src/users.c
--- libsemanage.new/src/users.c	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage/src/users.c	2005-09-23 18:51:52.000000000 -0400
@@ -2,63 +2,90 @@
 #include <stdlib.h>
 #include <semanage/user_record.h>
 #include <semanage/users.h>
+#include "handle.h"
 
 typedef semanage_user_key_t record_key_t;
 typedef semanage_user_t record_t;
 #define RECORD_DEFINED
 #include "database.h"
 
+/* Record base functions */
+record_table_t RTABLE_USER = {
+	.create      = semanage_user_create,
+	.key_extract = semanage_user_key_extract,
+	.key_free    = semanage_user_key_free,
+	.clone       = semanage_user_clone,
+	.compare     = semanage_user_compare,
+	.free        = semanage_user_free,
+};
+
 int semanage_user_add(
+	semanage_handle_t* handle,
 	semanage_user_key_t key,
 	semanage_user_t data) {
-	
-	return dbase_add(NULL /*FIXME */, key, data);
+
+	dbase_config_t* dbase = semanage_user_dbase(handle);
+	return dbase_add(handle, dbase, key, data);
 }
 
 int semanage_user_modify(
+	semanage_handle_t* handle,
 	semanage_user_key_t key,
 	semanage_user_t data) {
-	
-	return dbase_modify(NULL /* FIXME */, key, data);
+
+	dbase_config_t* dbase = semanage_user_dbase(handle);	
+	return dbase_modify(handle, dbase, key, data);
 }
 
 int semanage_user_del(
+	semanage_handle_t* handle,
 	semanage_user_key_t key) {
 
-	return dbase_del(NULL /* FIXME */, key);
+	dbase_config_t* dbase = semanage_user_dbase(handle);
+	return dbase_del(handle, dbase, key);
 }
 
 int semanage_user_query(
+	semanage_handle_t* handle,
 	semanage_user_key_t key,
 	semanage_user_t* response) {
 
-	return dbase_query(NULL /* FIXME */, key, response);
+	dbase_config_t* dbase = semanage_user_dbase(handle);
+	return dbase_query(handle, dbase, key, response);
 }
 
 int semanage_user_exists(
+	semanage_handle_t* handle,
 	semanage_user_key_t key,
 	int* response) {
 
-	return dbase_exists(NULL /* FIXME */, key, response);
+        dbase_config_t* dbase = semanage_user_dbase(handle);
+	return dbase_exists(handle, dbase, key, response);
 }
 
 int semanage_user_count(
+	semanage_handle_t* handle,
 	int* response) {
 
-	return dbase_count(NULL /* FIXME */, response);
+	dbase_config_t* dbase = semanage_user_dbase(handle);
+	return dbase_count(handle, dbase, response);
 }
 
 int semanage_user_iterate(
+	semanage_handle_t* handle,
 	int (*handler) (semanage_user_t record,
 	                void* varg),
 	void* handler_arg) {
 
-	return dbase_iterate(NULL /* FIXME */, handler, handler_arg);
+	dbase_config_t* dbase = semanage_user_dbase(handle);
+	return dbase_iterate(handle, dbase, handler, handler_arg);
 }
 
 int semanage_user_list(
+	semanage_handle_t* handle,
 	semanage_user_t** records,
 	size_t* count) {
 
-	return dbase_list(NULL /* FIXME */, records, count);
+	dbase_config_t* dbase = semanage_user_dbase(handle);
+	return dbase_list(handle, dbase, records, count);
 }
diff -Naru libsemanage.new/src/users_file.c libsemanage/src/users_file.c
--- libsemanage.new/src/users_file.c	2005-09-14 11:44:44.000000000 -0400
+++ libsemanage/src/users_file.c	2005-09-23 18:52:17.000000000 -0400
@@ -6,6 +6,7 @@
 typedef semanage_user_key_t record_key_t;
 #define RECORD_DEFINED
 #include "record_file.h"
+#include "database.h"
 
 static int semanage_user_print(
 	semanage_user_t user, 
@@ -27,16 +28,23 @@
 	return -1;	
 }
 
-record_table_t RTABLE_USER = {
-	/* Record base functions */
-	.create      = semanage_user_create,
-	.key_extract = semanage_user_key_extract,
-	.key_free    = semanage_user_key_free,
-	.clone       = semanage_user_clone,
-	.compare     = semanage_user_compare,
-	.free        = semanage_user_free,
+/* From users.c */
+extern record_table_t RTABLE_USER;
 
-	/* Record functions for FILE backend */
+/* Record functions for FILE backend  */
+record_file_table_t RTABLE_FILE_USER = {
 	.parse       = semanage_user_parse,
 	.print       = semanage_user_print,
 };
+
+int user_file_dbase_init(dbase_config_t** dconfig) {
+	return dbase_file_init(
+		&RTABLE_USER,
+		&RTABLE_FILE_USER,
+		NULL, /* FIXME */
+		&dconfig);
+}
+
+void user_file_dbase_release(dbase_config_t* dconfig) {
+	dbase_file_release(dconfig);
+}
diff -Naru libsemanage.new/src/users_file.h libsemanage/src/users_file.h
--- libsemanage.new/src/users_file.h	2005-09-14 11:44:44.000000000 -0400
+++ libsemanage/src/users_file.h	2005-09-23 17:43:36.000000000 -0400
@@ -1,8 +1,12 @@
 #ifndef _SEMANAGE_USERS_FILE_H_
 #define _SEMANAGE_USERS_FILE_H_
 
-#include "record_file.h"
+#include "database.h"
 
-extern record_table_t RTABLE_USER;
+int user_file_dbase_init(
+	dbase_config_t** config);
+
+void user_file_dbase_release(
+	dbase_config_t* config);
 
 #endif 

--------------010702030505070503070301--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
