Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8S9mJNs003314
	for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2005 05:48:20 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8S9guct029382
	for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2005 09:42:56 GMT
Message-ID: <433A6799.7040309@cornell.edu>
Date: Wed, 28 Sep 2005 05:51:21 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   dwalsh@redhat.com, jbrindle@tresys.com
Subject: Re: [ SEMANAGE ] Infrastucture patch
References: <200509271224.j8RCOaYs025773@gotham.columbia.tresys.com> <4339760A.9080300@cornell.edu>
In-Reply-To: <4339760A.9080300@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------020804030202030904020606"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020804030202030904020606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached is version 2 of my semanage patch. This is still not re-synced 
against Tresys' introduction of the handle, because that code is still 
unmerged. However, I thought it was important to re-post a version of my 
patch, because it is better than the previous one, and shows what the 
infrastructure would look like. Also... if the multiple header approach 
is chosen over a single semanage.h, it may be better to have Tresys 
resync their patch instead.

This patch does everything that I summarized previously, most notably:
- introduction of handle down to dbase_* layer
- initialization/release of DATA-backend database resources in the 
handle create/destroy
- split of record table into two
- other bugfixes and improvements

In addition to that, it introduces a second database format - policy. A 
new record table is created for policy-related functions, which 
introduces the indirection that Karl wants w/ respect to policy backend 
(see record_file.h). Planned functions are load() and list(). I've added 
various interfaces required to interact with policydb - hopefully I can 
make those work in the near future.

If this is merged, can you please also rename the following files:

record_file.h -> record.h
database_file.c -> database.c (or database_list.c)
The file prefix no longer accurate.

==========
I think I am starting to see how this will work - I will allow 
non-modifying functions on both base and local files. I will add a 
function to perform a query only on locals, and a query only on base. If 
the generic function is used, it will query both, whenever possible. 
Queries during a transaction will be rejected. Queries while 
disconnected will query local stuff only. Handle while disconnected will 
still be used to provide the sandbox for locking.

Modifying functions outside of transaction will be rejected. Modifying 
functions on base will be rejected at all times (though you can install 
modules, while connected, and in transaction).

The backend object to a policy database (direct case) is a policydb (not 
a file). This means a policydb must be created on connect()... I will 
have to investigate if/when cache stuff needs to be invalidated and 
reloaded.


 



--------------020804030202030904020606
Content-Type: text/x-patch;
 name="libsemanage.infrastructure.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.infrastructure.diff"

diff -Naur libsemanage.new/include/semanage/handle.h libsemanage/include/semanage/handle.h
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
diff -Naur libsemanage.new/include/semanage/ports.h libsemanage/include/semanage/ports.h
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
 
diff -Naur libsemanage.new/include/semanage/user_record.h libsemanage/include/semanage/user_record.h
--- libsemanage.new/include/semanage/user_record.h	2005-09-23 10:37:40.000000000 -0400
+++ libsemanage/include/semanage/user_record.h	2005-09-27 23:49:10.000000000 -0400
@@ -1,6 +1,8 @@
 #ifndef _SEMANAGE_USER_RECORD_H_
 #define _SEMANAGE_USER_RECORD_H_
 
+#include <stddef.h>
+
 struct semanage_user;
 struct semanage_user_key;
 typedef struct semanage_user* semanage_user_t;
diff -Naur libsemanage.new/include/semanage/users.h libsemanage/include/semanage/users.h
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
 
diff -Naur libsemanage.new/src/database_file.c libsemanage/src/database_file.c
--- libsemanage.new/src/database_file.c	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage/src/database_file.c	2005-09-28 04:49:37.000000000 -0400
@@ -12,24 +12,119 @@
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
-	const char* filename;
+#define DBASE_DATA_FILE 0
+#define DBASE_POLICY_DIRECT 1
+	int dbase_type;
+
+	/* Extra functions for datbase backend */
+	union {
+		record_file_table_t* rftable;
+		record_policy_table_t* rptable;
+	} method; 
+
+	/* Database backend */ 
+	union {
+		const char* filename;
+		policy_store_t policy;
+	} backend;
 
-	/* Once parsed, it is cached here */
+        /* In-memory representation */
 	cache_entry_t* cache;
 	size_t cache_sz;
+	int cached;
 };
 
+/* Initialize a DATA FILE database  */
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
+	tmp_dconfig->dbase_type = DBASE_DATA_FILE;
+	tmp_dconfig->method.rftable = rftable;
+	tmp_dconfig->backend.filename = filename;
+	tmp_dconfig->cache = NULL;
+	tmp_dconfig->cache_sz = 0;	
+	tmp_dconfig->cached = 0;
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
+/* Initialize a POLICY DIRECT database */
+int dbase_direct_init(
+	record_table_t* rtable,
+	record_policy_table_t* rptable,
+	policy_store_t policy,
+	dbase_config_t** dconfig) {
+
+	dbase_config_t* tmp_dconfig = 
+		(dbase_config_t*) malloc(sizeof(dbase_config_t));
+	
+	if (tmp_dconfig == NULL)
+		goto omem;
+
+	tmp_dconfig->rtable = rtable;
+	tmp_dconfig->dbase_type = DBASE_POLICY_DIRECT;
+	tmp_dconfig->method.rptable = rptable;
+	tmp_dconfig->backend.policy= policy;
+	tmp_dconfig->cache = NULL;
+	tmp_dconfig->cache_sz = 0;
+	tmp_dconfig->cached = 0;
+	
+	*dconfig = tmp_dconfig;
+	return STATUS_SUCCESS;
+
+	omem:
+	/* FIXME: handle error codntion */
+	free(tmp_dconfig);
+	return STATUS_ERR;
+}
+
+/* Release a database */
+void dbase_release(
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
+/* Flush a database to disk */
+int dbase_flush(
+	dbase_config_t* dconfig) {
+
+	/* Stub */
+	return STATUS_SUCCESS;
+}
+
 static int dbase_cache_add(
 	dbase_config_t* dconfig,
 	record_t data) {
@@ -39,10 +134,7 @@
 	if (entry == NULL)
 		goto omem;
 	entry->data = data;
-	entry->prev = NULL;
 	entry->next = dconfig->cache;
-	if (dconfig->cache != NULL)
-		dconfig->cache->prev = entry;
 	dconfig->cache = entry;
 	dconfig->cache_sz++;
 
@@ -74,8 +166,12 @@
 static int dbase_cache_fill(
 	dbase_config_t* dconfig) {
 
+	/* FIXME: handle policy database */
+	if (dconfig->dbase_type != DBASE_DATA_FILE)
+		return STATUS_ERR;
+	
 	/* Already cached */
-	if (dconfig->cache != NULL)
+	if (dconfig->cached)
 		return STATUS_SUCCESS;
 
 	int perr_fatal = 0;
@@ -84,7 +180,7 @@
 	record_t process_record = NULL;
 	int pstatus = STATUS_SUCCESS;
 	parse_info_t parse_info;
-	parse_info.filename = dconfig->filename;
+	parse_info.filename = dconfig->backend.filename;
 	parse_info.parse_arg = NULL;
 	/* FIXME: pass from caller? */
 
@@ -98,7 +194,7 @@
 			goto err;
 
 		/* Parse record */
-		pstatus = dconfig->rtable->parse(&parse_info, process_record);
+		pstatus = dconfig->method.rftable->parse(&parse_info, process_record);
 
 		/* Parse error is fatal, exit */
 		if (perr_fatal && (pstatus < 0))
@@ -115,6 +211,7 @@
         } while (pstatus != STATUS_NODATA);
 
 	dbase_close_file(&parse_info);
+	dconfig->cached = 1;
 	return STATUS_SUCCESS;
 
 	err:
@@ -126,10 +223,10 @@
 
 static int dbase_cache_locate(
 	dbase_config_t* dconfig,
-	record_key_t key, 
+	record_key_t key,
 	cache_entry_t** entry) {
 	
-	cache_entry_t* ptr;
+	cache_entry_t *ptr;
 
 	if (dbase_cache_fill(dconfig) < 0)
 		goto err;
@@ -148,6 +245,7 @@
 }
 
 int dbase_add(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_key_t key,
 	record_t data) {
@@ -157,7 +255,7 @@
 	if (dbase_cache_fill(dconfig) < 0)
 		goto err;
 
-	if (dbase_exists(dconfig, key, &exists) < 0)
+	if (dbase_exists(handle, dconfig, key, &exists) < 0)
 		goto err;
 
 	else if (exists) { 
@@ -176,6 +274,7 @@
 }
 
 int dbase_modify(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_key_t key,
 	record_t data) {
@@ -190,7 +289,7 @@
 	if (status < 0)
 		goto err;
 	if (status == STATUS_NODATA)
-		return dbase_add(dconfig,key,data);
+		return dbase_add(handle, dconfig, key, data);
 	else
 		entry->data = data;
 
@@ -203,32 +302,31 @@
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
@@ -237,6 +335,7 @@
 }
 
 int dbase_query(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_key_t key,
 	record_t* response) {
@@ -261,6 +360,7 @@
 }
 
 int dbase_exists(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_key_t key,
 	int* response) {
@@ -284,6 +384,7 @@
 }
 
 int dbase_count(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	int* response) {
 
@@ -299,6 +400,7 @@
 }
 
 int dbase_iterate(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	int (*fn) (record_t record, void* varg),
 	void* fn_arg) {
@@ -326,6 +428,7 @@
 }
 
 int dbase_list(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_t** records,	
 	size_t* count) {
diff -Naur libsemanage.new/src/database.h libsemanage/src/database.h
--- libsemanage.new/src/database.h	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage/src/database.h	2005-09-28 04:48:40.000000000 -0400
@@ -1,52 +1,87 @@
 #ifndef _SEMANAGE_DATABASE_H_
 #define _SEMANAGE_DATABASE_H_
 
-#include <stddef.h>
-
 #ifndef RECORD_DEFINED
 typedef void* record_t;
 typedef void* record_key_t;
 #define RECORD_DEFINED
 #endif
 
+#include <stddef.h>
+#include "handle.h"
+#include "record_file.h"
+
 struct dbase_config;
 typedef struct dbase_config dbase_config_t;
 
+/* Initialize a DATA FILE database */
+extern int dbase_file_init(
+        record_table_t* rtable,
+	record_file_table_t* rftable,
+	const char* filename,
+        dbase_config_t** dconfig);
+
+/* Initialize a POLICY DIRECT database */
+extern int dbase_direct_init(
+	record_table_t* rtable,
+	record_policy_table_t* rptable,
+	policy_store_t policy,
+	dbase_config_t** dconfig);
+
+/* Release a database */
+extern void dbase_release(
+	dbase_config_t* dconfig);
+
+/* Flush a database to disk */
+extern int dbase_flush(
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
diff -Naur libsemanage.new/src/handle.c libsemanage/src/handle.c
--- libsemanage.new/src/handle.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/src/handle.c	2005-09-28 04:15:34.000000000 -0400
@@ -0,0 +1,40 @@
+#include <stdlib.h>
+#include "handle.h"
+#include "database.h"
+#include "users_file.h"
+#include "ports_file.h"
+
+/* FIXME: Initialize POLICY databases on connect/disconnect */
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
+	dbase_release(sh->dbase[DBASE_USERS]);
+	dbase_release(sh->dbase[DBASE_PORTS]);
+
+	free(sh);
+}
diff -Naur libsemanage.new/src/handle.h libsemanage/src/handle.h
--- libsemanage.new/src/handle.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/src/handle.h	2005-09-28 04:21:16.000000000 -0400
@@ -0,0 +1,43 @@
+#ifndef _SEMANAGE_HANDLE_INTERNAL_H_
+#define _SEMANAGE_HANDLE_INTERNAL_H_
+
+#include <semanage/handle.h>
+
+/* Can't include - circular dependency */
+struct dbase_config;
+
+struct semanage_handle {
+	#define DBASE_COUNT 4
+
+	/* File databases */
+	#define DBASE_USERS 0
+	#define DBASE_PORTS 1
+
+	/* User databases */
+	#define DBASE_USERS_DIRECT 3 
+	#define DBASE_PORTS_DIRECT 4
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
+static inline
+struct dbase_config* semanage_user_direct_dbase(semanage_handle_t* handle) {
+	return handle->dbase[DBASE_USERS_DIRECT];
+}
+
+static inline
+struct dbase_config* semanage_port_direct_dbase(semanage_handle_t* handle) {
+	return handle->dbase[DBASE_PORTS_DIRECT];
+}
+
+#endif
+
diff -Naur libsemanage.new/src/ports.c libsemanage/src/ports.c
--- libsemanage.new/src/ports.c	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage/src/ports.c	2005-09-28 03:46:02.000000000 -0400
@@ -1,64 +1,97 @@
-#include <stddef.h>
-#include <stdlib.h>
+/* 
+ * Common code for manipulating port DATA backends
+ */
+
 #include <semanage/port_record.h>
-#include <semanage/ports.h>
 
 typedef semanage_port_key_t record_key_t;
 typedef semanage_port_t record_t;
 #define RECORD_DEFINED
+
+#include <stddef.h>
+#include <stdlib.h>
+#include <semanage/ports.h>
 #include "database.h"
+#include "handle.h"
+#include "record_file.h"
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
diff -Naur libsemanage.new/src/ports_direct.c libsemanage/src/ports_direct.c
--- libsemanage.new/src/ports_direct.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/src/ports_direct.c	2005-09-28 04:14:06.000000000 -0400
@@ -0,0 +1,64 @@
+/* 
+ * Code for manipulating the port POLICY DIRECT backend
+ */
+#include <sepol/port_record.h>
+#include <sepol/policydb.h>
+
+typedef sepol_port_t record_t;
+typedef sepol_port_key_t record_key_t;
+#define RECORD_DEFINED
+
+typedef policydb_t* policy_store_t;
+#define PSTORE_DEFINED
+
+#include <stddef.h>
+#include <sepol/ports.h>
+#include "ports_direct.h"
+#include "debug.h"
+#include "record_file.h"
+#include "database.h"
+
+static int port_load(
+	policy_store_t policydb, 
+	sepol_port_t port) {
+
+	if (sepol_port_load(policydb, port) < 0)
+		return STATUS_ERR;
+
+	return STATUS_SUCCESS;
+}
+
+static int port_list(
+	policy_store_t policy,
+	sepol_port_t* ports,
+	size_t* nports) {
+
+	policy = NULL;
+	ports = NULL;
+	nports = NULL;
+
+	/* if (sepol_port_list(policy, ports < 0)
+		return STATUS_ERR;
+	*/
+
+	return STATUS_SUCCESS;
+}
+
+/* From ports_policy.c */
+extern record_table_t SEPOL_PORT_RTABLE;
+
+/* Record functions for POLICY direct backend  */
+record_policy_table_t SEMANAGE_PORT_DIRECT_RTABLE = {
+	.load        = port_load,
+	.list        = port_list,        
+};
+
+int port_direct_dbase_init(dbase_config_t** dconfig) {
+	return dbase_direct_init(
+		&SEPOL_PORT_RTABLE,
+		&SEMANAGE_PORT_DIRECT_RTABLE,
+		NULL, /* FIXME */
+		dconfig);
+
+	return STATUS_SUCCESS;
+}
diff -Naur libsemanage.new/src/ports_direct.h libsemanage/src/ports_direct.h
--- libsemanage.new/src/ports_direct.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/src/ports_direct.h	2005-09-28 04:13:59.000000000 -0400
@@ -0,0 +1,13 @@
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
+	dbase_config_t** dconfig);
+
+#endif
diff -Naur libsemanage.new/src/ports_file.c libsemanage/src/ports_file.c
--- libsemanage.new/src/ports_file.c	2005-09-14 11:44:44.000000000 -0400
+++ libsemanage/src/ports_file.c	2005-09-28 04:14:27.000000000 -0400
@@ -6,8 +6,9 @@
 typedef semanage_port_key_t record_key_t;
 #define RECORD_DEFINED
 #include "record_file.h"
+#include "database.h"
 
-static int semanage_port_print(
+static int port_print(
 	semanage_port_t port, 
 	FILE* str) {
 
@@ -17,7 +18,7 @@
 	return -1;
 }
 
-static int semanage_port_parse(
+static int port_parse(
 	parse_info_t* info, 
 	semanage_port_t port) {
 
@@ -27,16 +28,19 @@
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
-
-	/* Record functions for FILE backend */
-	.parse       = semanage_port_parse,
-	.print       = semanage_port_print,
+/* From ports.c */
+extern record_table_t SEMANAGE_PORT_RTABLE;
+
+/* Record functions for FILE backend */
+record_file_table_t SEMANAGE_PORT_FILE_RTABLE = {
+	.parse       = port_parse,
+	.print       = port_print,
 };
+
+int port_file_dbase_init(dbase_config_t** dconfig) {
+	return dbase_file_init(
+		&SEMANAGE_PORT_RTABLE,  
+		&SEMANAGE_PORT_FILE_RTABLE,
+		NULL, /* FIXME */
+		dconfig);
+}
diff -Naur libsemanage.new/src/ports_file.h libsemanage/src/ports_file.h
--- libsemanage.new/src/ports_file.h	2005-09-14 11:44:44.000000000 -0400
+++ libsemanage/src/ports_file.h	2005-09-28 04:13:44.000000000 -0400
@@ -1,8 +1,13 @@
 #ifndef _SEMANAGE_PORTS_FILE_H_
 #define _SEMANAGE_PORTS_FILE_H_
 
-#include "record_file.h"
+/*
+ * Header for the port DATA FILE backend
+ */
 
-extern record_table_t RTABLE_PORT;
+#include "database.h"
+
+int port_file_dbase_init(
+	dbase_config_t** config);
 
 #endif 
diff -Naur libsemanage.new/src/ports_policy.c libsemanage/src/ports_policy.c
--- libsemanage.new/src/ports_policy.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/src/ports_policy.c	2005-09-28 03:46:22.000000000 -0400
@@ -0,0 +1,66 @@
+/* 
+ * Common code for manipulating port POLICY backends
+ */
+
+#include <semanage/port_record.h>
+#include <sepol/port_record.h>
+#include "debug.h"
+
+static inline int convert(
+	semanage_port_key_t semanage_key,
+	semanage_port_t semanage_port,
+	sepol_port_key_t* sepol_key, 
+	sepol_port_t* sepol_port) {
+
+	*sepol_key = (sepol_port_key_t) semanage_key;
+	*sepol_port = (sepol_port_t) semanage_port;
+	return STATUS_SUCCESS;
+}
+
+typedef sepol_port_key_t record_key_t;
+typedef sepol_port_t record_t;
+#define RECORD_DEFINED
+
+#include <stddef.h>
+#include <stdlib.h>
+#include "handle.h"
+#include "database.h"
+#include "record_file.h"
+#include "ports_policy.h"
+
+/* Record base functions */
+record_table_t SEPOL_PORT_RTABLE = {
+	.create      = sepol_port_create,
+	.key_extract = sepol_port_key_extract,
+	.key_free    = sepol_port_key_free,
+	.clone       = sepol_port_clone,
+	.compare     = sepol_port_compare,
+	.free        = sepol_port_free,
+};
+
+int semanage_port_policy_load(
+	semanage_handle_t* handle,
+	semanage_port_key_t key,
+	semanage_port_t data) {
+
+	sepol_port_t sepol_data;
+	sepol_port_key_t sepol_key;
+
+	if (convert(key, data, &sepol_key, &sepol_data) < 0)
+		return STATUS_ERR;
+
+	dbase_config_t* dbase = semanage_port_direct_dbase(handle);
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
diff -Naur libsemanage.new/src/ports_policy.h libsemanage/src/ports_policy.h
--- libsemanage.new/src/ports_policy.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/src/ports_policy.h	2005-09-28 02:55:16.000000000 -0400
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
diff -Naur libsemanage.new/src/record_file.h libsemanage/src/record_file.h
--- libsemanage.new/src/record_file.h	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage/src/record_file.h	2005-09-28 03:52:04.000000000 -0400
@@ -9,6 +9,11 @@
 #define RECORD_DEFINED
 #endif
 
+#ifndef PSTORE_DEFINED
+typedef void* policy_store_t;
+#define PSTORE_DEFINED
+#endif
+
 /* Structure available during parsing (created internally) */
 typedef struct parse_info {
 	/* Parser controlled */
@@ -22,7 +27,7 @@
 	void* parse_arg;
 } parse_info_t;
 
-/* Record table format - necessary during processing */
+/* Record table format */
 typedef struct record_table {
 
 	/* Create a record */
@@ -41,6 +46,15 @@
 	/* Deep-copy clone of this record */
 	int (*clone) (record_t rec, record_t* new_rec);
 
+	/* Deallocate record resources. Must
+	 * sucessfully handle NULL. */
+	void (*free) (record_t rec);
+
+} record_table_t;
+
+/* Record table when working with DATA FILE backend */
+typedef struct record_file_table {
+
 	/* Fill record structuure based on supplied parse info.
 	 * Parser must return STATUS_NODATA when EOF is encountered.
 	 * Parser must handle NULL file stream correctly */
@@ -49,9 +63,17 @@
 	/* Print record to stream */
 	int (*print) (record_t record, FILE* str);
 
-	/* Deallocate record resources. Must
-	 * sucessfully handle NULL. */
-	void (*free) (record_t rec);
-} record_table_t;
+} record_file_table_t;
+
+/* Record table when working with POLICY backend(s) */
+typedef struct record_policy_table {
+
+    /* Load record into policy store */
+    int (*load) (policy_store_t store, record_t record); 
+
+    /* Extract records from policy store */
+    int (*list) (policy_store_t store, record_t* records, size_t* nrecords);
+
+} record_policy_table_t;
 
 #endif 
diff -Naur libsemanage.new/src/user_record.c libsemanage/src/user_record.c
--- libsemanage.new/src/user_record.c	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage/src/user_record.c	2005-09-27 23:49:25.000000000 -0400
@@ -1,3 +1,4 @@
+#include <stddef.h>
 #include <sepol/user_record.h>
 
 typedef sepol_user_t semanage_user_t;
diff -Naur libsemanage.new/src/users.c libsemanage/src/users.c
--- libsemanage.new/src/users.c	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage/src/users.c	2005-09-28 03:43:01.000000000 -0400
@@ -1,64 +1,96 @@
-#include <stddef.h>
-#include <stdlib.h>
+/*
+ * Common code for manipulating user DATA backends
+ */
+
 #include <semanage/user_record.h>
-#include <semanage/users.h>
 
 typedef semanage_user_key_t record_key_t;
 typedef semanage_user_t record_t;
 #define RECORD_DEFINED
+
+#include <stddef.h>
+#include <stdlib.h>
+#include <semanage/users.h>
+#include "handle.h"
 #include "database.h"
 
+/* Record base functions */
+record_table_t SEMANAGE_USER_RTABLE = {
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
diff -Naur libsemanage.new/src/users_direct.c libsemanage/src/users_direct.c
--- libsemanage.new/src/users_direct.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/src/users_direct.c	2005-09-28 04:14:13.000000000 -0400
@@ -0,0 +1,65 @@
+/*
+ * Code for manipulating the user DATA FILE backend
+ */
+#include <sepol/user_record.h>
+#include <sepol/policydb.h>
+
+typedef sepol_user_t record_t;
+typedef sepol_user_key_t record_key_t;
+#define RECORD_DEFINED
+
+typedef policydb_t* policy_store_t;
+#define PSTORE_DEFINED
+
+#include <stddef.h>
+#include <sepol/users.h>
+#include "users_direct.h"
+#include "debug.h"
+#include "record_file.h"
+#include "database.h"
+
+static int user_load(
+	policy_store_t policy, 
+	sepol_user_t user) {
+
+	if (sepol_user_load(policy, user) < 0)
+		return STATUS_ERR;
+
+	return STATUS_SUCCESS;
+}
+
+static int user_list(
+	policy_store_t policy,
+	sepol_user_t* users,
+	size_t* nusers) {
+
+	policy = NULL;
+	users = NULL;
+	nusers = NULL;
+
+	/* if (sepol_user_list(policy, users < 0)
+		return STATUS_ERR;
+	*/
+
+	return STATUS_SUCCESS;
+}
+	
+
+/* From users_policy.c */
+extern record_table_t SEPOL_USER_RTABLE;
+
+/* Record functions for POLICY direct backend  */
+record_policy_table_t SEMANAGE_USER_DIRECT_RTABLE = {
+	.load        = user_load,
+	.list        = user_list,        
+};
+
+int user_direct_dbase_init(dbase_config_t** dconfig) {
+	return dbase_direct_init(
+		&SEPOL_USER_RTABLE,
+		&SEMANAGE_USER_DIRECT_RTABLE,
+		NULL, /* FIXME */
+		dconfig);
+
+	return STATUS_SUCCESS;
+}
diff -Naur libsemanage.new/src/users_direct.h libsemanage/src/users_direct.h
--- libsemanage.new/src/users_direct.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/src/users_direct.h	2005-09-28 04:13:52.000000000 -0400
@@ -0,0 +1,13 @@
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
+	dbase_config_t** dconfig);
+
+#endif
diff -Naur libsemanage.new/src/users_file.c libsemanage/src/users_file.c
--- libsemanage.new/src/users_file.c	2005-09-14 11:44:44.000000000 -0400
+++ libsemanage/src/users_file.c	2005-09-28 04:14:20.000000000 -0400
@@ -6,8 +6,9 @@
 typedef semanage_user_key_t record_key_t;
 #define RECORD_DEFINED
 #include "record_file.h"
+#include "database.h"
 
-static int semanage_user_print(
+static int user_print(
 	semanage_user_t user, 
 	FILE* str) {
 
@@ -17,7 +18,7 @@
 	return -1;
 }
 
-static int semanage_user_parse(
+static int user_parse(
 	parse_info_t* info, 
 	semanage_user_t user) {
 
@@ -27,16 +28,19 @@
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
-
-	/* Record functions for FILE backend */
-	.parse       = semanage_user_parse,
-	.print       = semanage_user_print,
+/* From users.c */
+extern record_table_t SEMANAGE_USER_RTABLE;
+
+/* Record functions for FILE backend  */
+record_file_table_t SEMANAGE_USER_FILE_RTABLE = {
+	.parse       = user_parse,
+	.print       = user_print,
 };
+
+int user_file_dbase_init(dbase_config_t** dconfig) {
+	return dbase_file_init(
+		&SEMANAGE_USER_RTABLE,
+		&SEMANAGE_USER_FILE_RTABLE,
+		NULL, /* FIXME */
+		dconfig);
+}
diff -Naur libsemanage.new/src/users_file.h libsemanage/src/users_file.h
--- libsemanage.new/src/users_file.h	2005-09-14 11:44:44.000000000 -0400
+++ libsemanage/src/users_file.h	2005-09-28 04:13:37.000000000 -0400
@@ -1,8 +1,13 @@
 #ifndef _SEMANAGE_USERS_FILE_H_
 #define _SEMANAGE_USERS_FILE_H_
 
-#include "record_file.h"
+/**
+ * Header for the users DATA FILE backend
+ */
 
-extern record_table_t RTABLE_USER;
+#include "database.h"
+
+int user_file_dbase_init(
+	dbase_config_t** config);
 
 #endif 
diff -Naur libsemanage.new/src/users_policy.c libsemanage/src/users_policy.c
--- libsemanage.new/src/users_policy.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/src/users_policy.c	2005-09-28 03:44:22.000000000 -0400
@@ -0,0 +1,66 @@
+/*
+ * Common code for manipulating user POLICY backends 
+ */
+
+#include "debug.h"
+#include <semanage/user_record.h>
+#include <sepol/user_record.h>
+
+static inline int convert(
+	semanage_user_key_t semanage_key,
+	semanage_user_t semanage_user,
+	sepol_user_key_t* sepol_key, 
+	sepol_user_t* sepol_user) {
+
+	*sepol_key = (sepol_user_key_t) semanage_key;
+	*sepol_user = (sepol_user_t) semanage_user;
+	return STATUS_SUCCESS;
+}
+
+typedef sepol_user_key_t record_key_t;
+typedef sepol_user_t record_t;
+#define RECORD_DEFINED
+
+#include <stddef.h>
+#include <stdlib.h>
+#include "handle.h"
+#include "database.h"
+#include "record_file.h"
+#include "users_policy.h"
+
+/* Record base functions */
+record_table_t SEPOL_USER_RTABLE = {
+	.create      = sepol_user_create,
+	.key_extract = sepol_user_key_extract,
+	.key_free    = sepol_user_key_free,
+	.clone       = sepol_user_clone,
+	.compare     = sepol_user_compare,
+	.free        = sepol_user_free,
+};
+
+int semanage_user_policy_load(
+	semanage_handle_t* handle,
+	semanage_user_key_t key,
+	semanage_user_t data) {
+
+	sepol_user_t sepol_data;
+	sepol_user_key_t sepol_key;
+
+	if (convert(key, data, &sepol_key, &sepol_data) < 0)
+		return STATUS_ERR;
+
+	dbase_config_t* dbase = semanage_user_direct_dbase(handle);
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
diff -Naur libsemanage.new/src/users_policy.h libsemanage/src/users_policy.h
--- libsemanage.new/src/users_policy.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/src/users_policy.h	2005-09-28 02:54:35.000000000 -0400
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

--------------020804030202030904020606--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
