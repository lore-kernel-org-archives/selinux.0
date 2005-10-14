Message-ID: <434FEE5D.2060201@cornell.edu>
Date: Fri, 14 Oct 2005 13:43:57 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>,
   Karl MacMillan <kmacmillan@tresys.com>
Subject: [ SEMANAGE ] Seuser database
References: <434FEA78.3090406@cornell.edu>
In-Reply-To: <434FEA78.3090406@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------090604030407060204000701"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090604030407060204000701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached patch adds seuser database and files (parse/print stubbed).
Unfortunately I can't initialize the record table yet, because it does 
not support
passing the handle to records at this time (and my new seuser
record takes the handle as argument).

Also adds things I forgot in last patch that added interfaces/booleans
(headers for interfaces and boolean file databases, initialization in 
the handle, etc..)



--------------090604030407060204000701
Content-Type: text/x-patch;
 name="libsemanage.seusers.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.seusers.diff"

diff -Naur libsemanage/include/semanage/seusers.h libsemanage.new/include/semanage/seusers.h
--- libsemanage/include/semanage/seusers.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/include/semanage/seusers.h	2005-10-14 13:30:10.000000000 -0400
@@ -0,0 +1,47 @@
+#ifndef _SEMANAGE_SEUSERS_H_
+#define _SEMANAGE_SEUSERS_H_
+
+#include <stddef.h>
+#include <semanage/seuser_record.h>
+#include <semanage/handle.h>
+
+extern int semanage_seuser_add(
+	semanage_handle_t* handle,
+	semanage_seuser_key_t* key,
+	semanage_seuser_t* data);
+
+extern int semanage_seuser_modify(
+	semanage_handle_t* handle,
+	semanage_seuser_key_t* key,
+	semanage_seuser_t* data);
+
+extern int semanage_seuser_del(
+	semanage_handle_t* handle,
+	semanage_seuser_key_t* key);
+
+extern int semanage_seuser_query(
+	semanage_handle_t* handle,
+	semanage_seuser_key_t* key,
+	semanage_seuser_t** response);
+
+extern int semanage_seuser_exists(
+	semanage_handle_t* handle,
+	semanage_seuser_key_t* key,
+	int* response);
+
+extern int semanage_seuser_count(
+	semanage_handle_t* handle,
+	int* response);
+
+extern int semanage_seuser_iterate(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_seuser_t* record,
+	                void* varg),
+	void* handler_arg);
+
+extern int semanage_seuser_list(
+	semanage_handle_t* handle,
+	semanage_seuser_t*** records,
+	size_t* count);
+
+#endif 
diff -Naur libsemanage/src/booleans_file.h libsemanage.new/src/booleans_file.h
--- libsemanage/src/booleans_file.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/booleans_file.h	2005-10-14 13:32:57.000000000 -0400
@@ -0,0 +1,14 @@
+#ifndef _SEMANAGE_BOOLEANS_FILE_H_
+#define _SEMANAGE_BOOLEANS_FILE_H_
+
+#include "database.h"
+#include "handle.h"
+
+int bool_file_dbase_init(
+	dbase_config_t* dconfig);
+
+void bool_file_dbase_release(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+#endif 
diff -Naur libsemanage/src/handle.c libsemanage.new/src/handle.c
--- libsemanage/src/handle.c	2005-10-13 13:08:35.000000000 -0400
+++ libsemanage.new/src/handle.c	2005-10-14 13:37:59.000000000 -0400
@@ -36,6 +36,9 @@
 #include "semanage_store.h"
 #include "users_file.h"
 #include "ports_file.h"
+#include "interfaces_file.h"
+#include "booleans_file.h"
+#include "seusers_file.h"
 #include "database.h"
 
 #define SEMANAGE_COMMIT_READ_WAIT 5
@@ -78,6 +81,15 @@
 	if (port_file_dbase_init(&sh->dbase[DBASE_PORTS]) < 0)
 		goto err;
 
+	if (iface_file_dbase_init(&sh->dbase[DBASE_INTERFACES]) < 0)
+		goto err;
+
+	if (bool_file_dbase_init(&sh->dbase[DBASE_BOOLEANS]) < 0)
+		goto err;
+
+	if (seuser_file_dbase_init(&sh->dbase[DBASE_SEUSERS]) < 0)
+		goto err;
+
         return sh;
 
  omem:
diff -Naur libsemanage/src/handle.h libsemanage.new/src/handle.h
--- libsemanage/src/handle.h	2005-10-14 13:19:51.000000000 -0400
+++ libsemanage.new/src/handle.h	2005-10-14 13:37:26.000000000 -0400
@@ -71,11 +71,12 @@
 	struct semanage_policy_table* funcs;
 
 	/* Object databases */
-#define DBASE_COUNT      4
+#define DBASE_COUNT      5
 #define DBASE_USERS      0
 #define DBASE_PORTS      1
 #define DBASE_INTERFACES 2
 #define DBASE_BOOLEANS   3
+#define DBASE_SEUSERS    4
 	dbase_config_t dbase[DBASE_COUNT];
 };
 
@@ -99,5 +100,10 @@
 	return &handle->dbase[DBASE_BOOLEANS];
 }
 
+static inline
+dbase_config_t* semanage_seuser_dbase(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_SEUSERS];
+}
+
 #endif
 
diff -Naur libsemanage/src/interfaces_file.h libsemanage.new/src/interfaces_file.h
--- libsemanage/src/interfaces_file.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/interfaces_file.h	2005-10-14 13:32:32.000000000 -0400
@@ -0,0 +1,14 @@
+#ifndef _SEMANAGE_INTERFACES_FILE_H_
+#define _SEMANAGE_INTERFACES_FILE_H_
+
+#include "database.h"
+#include "handle.h"
+
+int iface_file_dbase_init(
+	dbase_config_t* dconfig);
+
+void iface_file_dbase_release(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+#endif 
diff -Naur libsemanage/src/seusers.c libsemanage.new/src/seusers.c
--- libsemanage/src/seusers.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/seusers.c	2005-10-14 13:39:54.000000000 -0400
@@ -0,0 +1,96 @@
+#include <semanage/seuser_record.h>
+
+typedef semanage_seuser_key_t record_key_t;
+typedef semanage_seuser_t record_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED
+
+#include <stddef.h>
+#include <stdlib.h>
+#include <semanage/seusers.h>
+#include "handle.h"
+#include "database.h"
+
+/* Record base functions */
+record_table_t SEMANAGE_SEUSER_RTABLE = {
+	.create      = NULL, /* FIXME: takes handle argument  */
+	.key_extract = NULL, /* FIXME */
+	.key_free    = semanage_seuser_key_free,
+	.clone       = NULL, /* FIXME */
+	.compare     = semanage_seuser_compare,
+	.free        = semanage_seuser_free,
+};
+
+int semanage_seuser_add(
+	semanage_handle_t* handle,
+	semanage_seuser_key_t* key,
+	semanage_seuser_t* data) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
+	return dconfig->dtable->add(handle, dconfig->dbase, key, data);
+}
+
+int semanage_seuser_modify(
+	semanage_handle_t* handle,
+	semanage_seuser_key_t* key,
+	semanage_seuser_t* data) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase(handle);	
+	return dconfig->dtable->modify(handle, dconfig->dbase, key, data);
+}
+
+int semanage_seuser_del(
+	semanage_handle_t* handle,
+	semanage_seuser_key_t* key) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
+	return dconfig->dtable->del(handle, dconfig->dbase, key);
+}
+
+int semanage_seuser_query(
+	semanage_handle_t* handle,
+	semanage_seuser_key_t* key,
+	semanage_seuser_t** response) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
+	return dconfig->dtable->query(handle, dconfig->dbase, key, response);
+}
+
+int semanage_seuser_exists(
+	semanage_handle_t* handle,
+	semanage_seuser_key_t* key,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
+	return dconfig->dtable->exists(handle, dconfig->dbase, key, response);
+}
+
+int semanage_seuser_count(
+	semanage_handle_t* handle,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
+	return dconfig->dtable->count(handle, dconfig->dbase, response);
+}
+
+int semanage_seuser_iterate(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_seuser_t* record,
+	                void* varg),
+	void* handler_arg) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
+	return dconfig->dtable->iterate(handle, dconfig->dbase, handler, handler_arg);
+}
+
+int semanage_seuser_list(
+	semanage_handle_t* handle,
+	semanage_seuser_t*** records,
+	size_t* count) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
+	return dconfig->dtable->list(handle, dconfig->dbase, records, count);
+}
diff -Naur libsemanage/src/seusers_file.c libsemanage.new/src/seusers_file.c
--- libsemanage/src/seusers_file.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/seusers_file.c	2005-10-14 13:36:29.000000000 -0400
@@ -0,0 +1,67 @@
+#include <semanage/seuser_record.h>
+
+typedef semanage_seuser_t record_t;
+typedef semanage_seuser_key_t record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <strings.h>
+#include "database_file.h"
+#include "parse_utils.h"
+#include "debug.h"
+#include "semanage_store.h"
+#include "handle.h"
+
+static int seuser_print(
+	semanage_seuser_t* seuser, 
+	FILE* str) {
+
+	/* Stub */
+	seuser = NULL;
+	str = NULL;
+	return STATUS_SUCCESS;
+}
+
+static int seuser_parse(
+	parse_info_t* info, 
+	semanage_seuser_t* seuser) {
+	
+	/* Stub */
+	info = NULL;
+	seuser = NULL;
+	return STATUS_SUCCESS;
+}
+
+/* SEUSER RECORD: method table (seusers.c) */
+extern record_table_t SEMANAGE_SEUSER_RTABLE;
+
+/* SEUSER RECORD: FILE extension: method table */
+record_file_table_t SEMANAGE_SEUSER_FILE_RTABLE = {
+	.parse       = seuser_parse,
+	.print       = seuser_print,
+};
+
+int seuser_file_dbase_init(dbase_config_t* dconfig) {
+
+	if (dbase_file_init(
+		"seusers",
+		&SEMANAGE_SEUSER_RTABLE,
+		&SEMANAGE_SEUSER_FILE_RTABLE,
+		&dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_FILE_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void seuser_file_dbase_release(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig) {
+
+	dbase_file_release(handle, dconfig->dbase);
+}
diff -Naur libsemanage/src/seusers_file.h libsemanage.new/src/seusers_file.h
--- libsemanage/src/seusers_file.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/seusers_file.h	2005-10-14 13:36:53.000000000 -0400
@@ -0,0 +1,14 @@
+#ifndef _SEMANAGE_SEUSERS_FILE_H_
+#define _SEMANAGE_SEUSERS_FILE_H_
+
+#include "database.h"
+#include "handle.h"
+
+int seuser_file_dbase_init(
+	dbase_config_t* dconfig);
+
+void seuser_file_dbase_release(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+#endif 

--------------090604030407060204000701--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
