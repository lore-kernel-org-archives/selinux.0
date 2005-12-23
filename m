Message-ID: <43ABC97B.7010107@cornell.edu>
Date: Fri, 23 Dec 2005 04:55:07 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Active dbase backend, active booleans
Content-Type: multipart/mixed;
 boundary="------------020302000902010509040809"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020302000902010509040809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch implements the read interfaces for booleans with libselinux 
as a backend. It also implements the write interfaces, but they're 
disabled, since I don't know where to put the flush() call - they'll 
just get overwritten every time, since libsemanage insists on rebuilding 
the policy on every commit (which is slow, and needs to be fixed IMHO...).

The "activedb" dbase backend requires two functions - read_list and 
commit_list, and can be generalized to any other record that can support 
those functions.




--------------020302000902010509040809
Content-Type: text/x-patch;
 name="libsemanage5.active.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage5.active.diff"

diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/booleans_active.h new/libsemanage/include/semanage/booleans_active.h
--- old/libsemanage/include/semanage/booleans_active.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/include/semanage/booleans_active.h	2005-12-23 03:17:17.000000000 -0500
@@ -0,0 +1,54 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+#ifndef _SEMANAGE_BOOLEANS_ACTIVE_H_
+#define _SEMANAGE_BOOLEANS_ACTIVE_H_
+
+#include <stddef.h>
+#include <semanage/boolean_record.h>
+#include <semanage/handle.h>
+
+extern int semanage_bool_add_active(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data);
+
+extern int semanage_bool_modify_active(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data);
+
+extern int semanage_bool_set_active(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data);
+
+extern int semanage_bool_del_active(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key);
+
+extern int semanage_bool_query_active(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t** response);
+
+extern int semanage_bool_exists_active(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	int* response);
+
+extern int semanage_bool_count_active(
+	semanage_handle_t* handle,
+	unsigned int* response);
+
+extern int semanage_bool_iterate_active(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_bool_t* record,
+	                void* varg),
+	void* handler_arg);
+
+extern int semanage_bool_list_active(
+	semanage_handle_t* handle,
+	semanage_bool_t*** records,
+	size_t* count);
+
+#endif 
diff -Naurp --exclude-from excludes old/libsemanage/src/boolean_internal.h new/libsemanage/src/boolean_internal.h
--- old/libsemanage/src/boolean_internal.h	2005-12-23 01:38:10.000000000 -0500
+++ new/libsemanage/src/boolean_internal.h	2005-12-23 04:44:33.000000000 -0500
@@ -4,6 +4,7 @@
 #include <semanage/boolean_record.h>
 #include <semanage/booleans_local.h>
 #include <semanage/booleans_policy.h>
+#include <semanage/booleans_active.h>
 #include "database.h"
 #include "handle.h"
 #include "dso.h"
@@ -36,4 +37,11 @@ extern int bool_policydb_dbase_init(
 extern void bool_policydb_dbase_release(
 	dbase_config_t* dconfig);
 
+extern int bool_activedb_dbase_init(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+extern void bool_activedb_dbase_release(
+	dbase_config_t* dconfig);
+
 #endif
diff -Naurp --exclude-from excludes old/libsemanage/src/booleans_active.c new/libsemanage/src/booleans_active.c
--- old/libsemanage/src/booleans_active.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/booleans_active.c	2005-12-23 03:57:56.000000000 -0500
@@ -0,0 +1,92 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+struct semanage_bool;
+struct semanage_bool_key;
+typedef struct semanage_bool_key record_key_t;
+typedef struct semanage_bool record_t;
+#define DBASE_RECORD_DEFINED
+
+#include <stddef.h>
+#include "boolean_internal.h"
+#include "handle.h" 
+#include "database.h"
+
+int semanage_bool_add_active(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_active(handle);
+	return dbase_add(handle, dconfig, key, data);
+}
+
+int semanage_bool_modify_active(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_active(handle);	
+	return dbase_modify(handle, dconfig, key, data);
+}
+
+int semanage_bool_set_active(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_active(handle);	
+	return dbase_set(handle, dconfig, key, data);
+}
+
+int semanage_bool_del_active(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_active(handle);
+	return dbase_del(handle, dconfig, key);
+}
+
+int semanage_bool_query_active(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t** response) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_active(handle);
+	return dbase_query(handle, dconfig, key, response);
+}
+
+int semanage_bool_exists_active(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_active(handle);
+	return dbase_exists(handle, dconfig, key, response);
+}
+
+int semanage_bool_count_active(
+	semanage_handle_t* handle,
+	unsigned int* response) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_active(handle);
+	return dbase_count(handle, dconfig, response);
+}
+
+int semanage_bool_iterate_active(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_bool_t* record,
+	                void* varg),
+	void* handler_arg) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_active(handle);
+	return dbase_iterate(handle, dconfig, handler, handler_arg);
+}
+
+int semanage_bool_list_active(
+	semanage_handle_t* handle,
+	semanage_bool_t*** records,
+	size_t* count) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_active(handle);
+	return dbase_list(handle, dconfig, records, count);
+}
diff -Naurp --exclude-from excludes old/libsemanage/src/booleans_activedb.c new/libsemanage/src/booleans_activedb.c
--- old/libsemanage/src/booleans_activedb.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/booleans_activedb.c	2005-12-23 04:48:06.000000000 -0500
@@ -0,0 +1,161 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+struct semanage_bool;
+struct semanage_bool_key;
+typedef struct semanage_bool record_t;
+typedef struct semanage_bool_key record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_activedb;
+typedef struct dbase_activedb dbase_t;
+#define DBASE_DEFINED 
+
+#include <stdlib.h>
+#include <string.h>
+#include <selinux/selinux.h>
+#include <semanage/handle.h>
+#include "boolean_internal.h"
+#include "database_activedb.h"
+#include "parse_utils.h"
+#include "debug.h"
+
+static int bool_read_list(
+	semanage_handle_t* handle,
+	semanage_bool_t*** booleans,
+	size_t* count) {
+
+	semanage_bool_t** tmp_booleans = NULL;
+	size_t tmp_count = 0;
+	int i;
+
+	char** names = NULL;
+	int len = 0;
+
+	/* Fetch boolean names */
+	if (security_get_boolean_names(&names, &len) < 0) {
+		ERR(handle, "could not get list of boolean names");
+		goto err;
+	}
+
+	/* Allocate a sufficiently large array */
+	tmp_booleans = malloc(sizeof(semanage_bool_t*) * len);
+	if (tmp_booleans == NULL)
+		goto omem;
+
+	/* Create records one by one */
+	for (i = 0; i < len; i++) {
+		
+		int value;
+
+		if (semanage_bool_create(handle, &tmp_booleans[i]) < 0)
+			goto err;
+		tmp_count++;
+
+		if (semanage_bool_set_name(handle, 
+			tmp_booleans[i], names[i]) < 0)
+			goto err;
+
+		value = security_get_boolean_active(names[i]);
+		if (value < 0) {
+			ERR(handle, "could not get the value "
+				"for boolean %s", names[i]);
+			goto err;
+		}
+
+		semanage_bool_set_value(tmp_booleans[i], value);
+	}
+
+	/* Success */
+	for (i=0; i < len; i++)
+		free(names[i]);
+	free(names);
+	*booleans = tmp_booleans;
+	*count = tmp_count;
+	return STATUS_SUCCESS;
+
+	/* Failure */
+	omem:
+	ERR(handle, "out of memory");
+
+	err:
+	ERR(handle, "could not read boolean list");
+	for (i=0; i < len; i++)
+		free(names[i]);
+	free(names);
+	for (i=0; (size_t) i < tmp_count; i++)
+		semanage_bool_free(tmp_booleans[i]);
+	free(tmp_booleans);
+	return STATUS_ERR;
+}
+
+static int bool_commit_list(
+	semanage_handle_t* handle,
+	semanage_bool_t** booleans,
+	size_t count) {
+
+	SELboolean* blist = NULL;
+	size_t bcount = 0;
+	size_t i;
+
+	/* Allocate a sufficiently large array */
+	blist = malloc(sizeof(SELboolean) * count);
+	if (blist == NULL)
+		goto omem;
+
+	/* Populate array */
+	for (i = 0; i < count; i++) {
+		blist[i].name = strdup(semanage_bool_get_name(booleans[i]));
+		bcount++;
+		if (blist[i].name == NULL)
+			goto omem;
+		blist[i].value = semanage_bool_get_value(booleans[i]);
+	}
+
+	/* Commit */
+	if (security_set_boolean_list(bcount, blist, 0) < 0) {
+		ERR(handle, "libselinux commit failed");
+		goto err;
+	}
+
+	for (i = 0; i < bcount; i++)
+		free(blist[i].name);
+	free(blist);
+	return STATUS_SUCCESS;
+
+	omem:
+	ERR(handle, "out of memory");
+
+	err:
+	ERR(handle, "could not commit boolean list");
+	for (i = 0; i < bcount; i++)
+		free(blist[i].name);
+	free(blist);
+	return STATUS_ERR;
+}
+
+/* BOOL RECORD: ACTIVEDB extension: method table */
+record_activedb_table_t SEMANAGE_BOOL_ACTIVEDB_RTABLE = {
+	.read_list         = bool_read_list,
+	.commit_list       = bool_commit_list,
+};
+
+int bool_activedb_dbase_init(
+	semanage_handle_t* handle, 
+	dbase_config_t* dconfig) {
+	
+	if (dbase_activedb_init(
+		handle, 
+		&SEMANAGE_BOOL_RTABLE,
+		&SEMANAGE_BOOL_ACTIVEDB_RTABLE, 
+		&dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_ACTIVEDB_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void bool_activedb_dbase_release(
+	dbase_config_t* dconfig) {
+
+	dbase_activedb_release(dconfig->dbase);
+}
diff -Naurp --exclude-from excludes old/libsemanage/src/database_activedb.c new/libsemanage/src/database_activedb.c
--- old/libsemanage/src/database_activedb.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/database_activedb.c	2005-12-23 04:47:46.000000000 -0500
@@ -0,0 +1,166 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+/* Object: dbase_activedb_t (Active/Kernel)
+ * Extends: dbase_llist_t (Linked List) 
+ * Implements: dbase_t (Database)
+ */
+
+struct dbase_activedb;
+typedef struct dbase_activedb dbase_t;
+#define DBASE_DEFINED
+
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include "debug.h"
+#include "handle.h"
+#include "database_activedb.h"
+#include "database_llist.h"
+
+/* ACTIVEDB dbase */ 
+struct dbase_activedb {
+
+	/* Parent object - must always be 
+	 * the first field - here we are using
+	 * a linked list to store the records */
+	dbase_llist_t llist;
+
+	/* ACTIVEDB extension */
+	record_activedb_table_t* ratable;
+};
+
+static int dbase_activedb_cache(
+	semanage_handle_t* handle,
+	dbase_activedb_t* dbase) {
+
+	record_table_t* rtable = dbase_llist_get_rtable(&dbase->llist);
+	record_activedb_table_t* ratable = dbase->ratable;
+
+	record_t** records = NULL;
+	size_t rcount = 0;
+	size_t i;
+
+	/* Already cached */
+	if (dbase_llist_is_cached(&dbase->llist))
+		return STATUS_SUCCESS;
+
+	dbase_llist_cache_init(&dbase->llist);
+
+	/* Fetch the entire list */
+	if (ratable->read_list(handle, &records, &rcount) < 0)
+		goto err;
+
+	/* Add records one by one */
+	for (i = 0; i < rcount; i++) { 
+		if (dbase_llist_cache_prepend(handle, &dbase->llist, records[i]) < 0)
+			goto err;
+		records[i] = NULL;
+	}
+
+	free(records);
+	dbase_llist_set_cached(&dbase->llist, 1);
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not cache active database");
+	for (; i < rcount; i++)
+		rtable->free(records[i]);
+	free(records);
+	return STATUS_ERR;
+}
+
+static int dbase_activedb_flush(
+	semanage_handle_t* handle,
+	dbase_activedb_t* dbase) {
+
+	record_table_t* rtable = dbase_llist_get_rtable(&dbase->llist);
+	record_activedb_table_t* ratable = dbase->ratable;
+
+	record_t** records = NULL;
+	size_t rcount = 0;
+	size_t i;
+
+	/* Not cached, or not modified - flush is not necessary */
+	if (!dbase_llist_is_cached(&dbase->llist) ||
+	    !dbase_llist_is_modified(&dbase->llist))
+		return STATUS_SUCCESS;
+
+	/* Fetch list */
+	if (dbase_llist_list(handle, &dbase->llist, &records, &rcount) < 0)
+		goto err;
+
+	/* Commit */
+	if (ratable->commit_list(handle, records, rcount) < 0)
+		goto err;
+
+	for (i=0; i < rcount; i++)
+		rtable->free(records[i]);
+	free(records);
+	dbase_llist_set_modified(&dbase->llist, 0);
+	return STATUS_SUCCESS;
+
+	err:
+	for (i=0 ; i < rcount; i++)
+		rtable->free(records[i]);
+	free(records);	
+	ERR(handle, "could not flush active database");
+	return STATUS_ERR;
+}
+
+int dbase_activedb_init(
+	semanage_handle_t* handle, 
+	record_table_t* rtable,
+	record_activedb_table_t* ratable,
+	dbase_activedb_t** dbase) {
+
+	dbase_activedb_t* tmp_dbase = 
+		(dbase_activedb_t*) malloc(sizeof(dbase_activedb_t));
+	
+	if (!tmp_dbase)
+		goto omem;
+
+	tmp_dbase->ratable = ratable;
+	dbase_llist_init(
+		&tmp_dbase->llist, rtable, &SEMANAGE_ACTIVEDB_DTABLE);
+
+	*dbase = tmp_dbase;
+	
+	return STATUS_SUCCESS;
+	
+	omem:
+	ERR(handle, "out of memory, could not initialize active database");
+	free(tmp_dbase);
+	return STATUS_ERR;
+}
+	
+/* Release dbase resources */
+void dbase_activedb_release(
+	dbase_activedb_t* dbase) {
+
+	dbase_llist_drop_cache(&dbase->llist);
+	free(dbase);
+}
+
+/* ACTIVEDB dbase - method table implementation */
+dbase_table_t SEMANAGE_ACTIVEDB_DTABLE = {
+
+	/* Cache/Transactions */
+	.cache = dbase_activedb_cache,
+	.drop_cache = (void*) dbase_llist_drop_cache,
+	.flush = dbase_activedb_flush,
+	.is_modified = (void*) dbase_llist_is_modified,
+
+	/* Database API */
+	.iterate = (void*) dbase_llist_iterate,
+	.exists = (void*) dbase_llist_exists, 
+	.list = (void*) dbase_llist_list,   
+	.add = (void*) dbase_llist_add,
+	.set = (void*) dbase_llist_set,
+	.del = (void*) dbase_llist_del, 
+	.modify = (void*) dbase_llist_modify, 
+	.query = (void*) dbase_llist_query, 
+	.count = (void*) dbase_llist_count, 
+
+	/* Polymorphism */
+	.get_rtable = (void*) dbase_llist_get_rtable
+};
diff -Naurp --exclude-from excludes old/libsemanage/src/database_activedb.h new/libsemanage/src/database_activedb.h
--- old/libsemanage/src/database_activedb.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/database_activedb.h	2005-12-23 04:47:07.000000000 -0500
@@ -0,0 +1,44 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+#ifndef _SEMANAGE_DATABASE_ACTIVEDB_INTERNAL_H_
+#define _SEMANAGE_DATABASE_ACTIVEDB_INTERNAL_H_
+
+#include <stddef.h>
+#include "database.h"
+#include "handle.h"
+
+struct dbase_activedb;
+typedef struct dbase_activedb dbase_activedb_t;
+
+/* ACTIVEDB extension to RECORD interface - method table */
+typedef struct record_activedb_table {
+
+	/* Read a list of records */
+	int (*read_list) (
+		semanage_handle_t* handle,
+		record_t*** records,
+		size_t* count);
+
+	/* Commit a list of records */
+	int (*commit_list) (
+		semanage_handle_t* handle,
+		record_t** records,
+		size_t count);
+
+} record_activedb_table_t;
+
+/* ACTIVEDB - initialization */
+extern int dbase_activedb_init(
+	semanage_handle_t* handle,
+	record_table_t* rtable,
+	record_activedb_table_t* ratable,
+	dbase_activedb_t** dbase);
+
+/* ACTIVEDB - release */
+extern void dbase_activedb_release(
+	dbase_activedb_t* dbase);
+
+/* ACTIVEDB - method table implementation */
+extern dbase_table_t SEMANAGE_ACTIVEDB_DTABLE;
+
+#endif
diff -Naurp --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-12-23 01:38:10.000000000 -0500
+++ new/libsemanage/src/direct_api.c	2005-12-23 04:45:09.000000000 -0500
@@ -135,6 +135,9 @@ int semanage_direct_connect(semanage_han
 	if (bool_policydb_dbase_init(sh, semanage_bool_dbase_policy(sh)) < 0)
 		goto err;
 
+	if (bool_activedb_dbase_init(sh, semanage_bool_dbase_active(sh)) < 0)
+		goto err;
+
 	return STATUS_SUCCESS;
 
 	err:
@@ -171,6 +174,8 @@ static int semanage_direct_disconnect(se
 	iface_policydb_dbase_release(semanage_iface_dbase_policy(sh));
 	bool_policydb_dbase_release(semanage_bool_dbase_policy(sh));
 
+	bool_activedb_dbase_release(semanage_bool_dbase_active(sh));
+
 	return 0;
 }
 

--------------020302000902010509040809--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
