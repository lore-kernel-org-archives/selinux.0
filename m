Message-ID: <434FE2D1.5070505@cornell.edu>
Date: Fri, 14 Oct 2005 12:54:41 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Add more databases - booleans and interfaces
Content-Type: multipart/mixed;
 boundary="------------030500060704030501060908"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030500060704030501060908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

- Add more databases:
boolean and interface APIs,
boolean and interface file databases (parse/print stubbed)

- Fix bug in iface_record.h

--------------030500060704030501060908
Content-Type: text/x-patch;
 name="libsemanage.bool.iface.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.bool.iface.diff"

diff -Naur libsemanage/include/semanage/booleans.h libsemanage.new/include/semanage/booleans.h
--- libsemanage/include/semanage/booleans.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/include/semanage/booleans.h	2005-10-14 12:47:06.000000000 -0400
@@ -0,0 +1,47 @@
+#ifndef _SEMANAGE_BOOLEANS_H_
+#define _SEMANAGE_BOOLEANS_H_
+
+#include <stddef.h>
+#include <semanage/boolean_record.h>
+#include <semanage/handle.h>
+
+extern int semanage_bool_add(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data);
+
+extern int semanage_bool_modify(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data);
+
+extern int semanage_bool_del(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key);
+
+extern int semanage_bool_query(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t** response);
+
+extern int semanage_bool_exists(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	int* response);
+
+extern int semanage_bool_count(
+	semanage_handle_t* handle,
+	int* response);
+
+extern int semanage_bool_iterate(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_bool_t* record,
+	                void* varg),
+	void* handler_arg);
+
+extern int semanage_bool_list(
+	semanage_handle_t* handle,
+	semanage_bool_t*** records,
+	size_t* count);
+
+#endif 
diff -Naur libsemanage/include/semanage/iface_record.h libsemanage.new/include/semanage/iface_record.h
--- libsemanage/include/semanage/iface_record.h	2005-09-30 16:18:58.000000000 -0400
+++ libsemanage.new/include/semanage/iface_record.h	2005-10-14 12:48:47.000000000 -0400
@@ -29,7 +29,7 @@
 	semanage_iface_t* iface);
 
 extern int semanage_iface_set_name(
-	semanage_user_t iface, 
+	semanage_iface_t* iface, 
 	const char* name);
 
 /* Context */
diff -Naur libsemanage/include/semanage/interfaces.h libsemanage.new/include/semanage/interfaces.h
--- libsemanage/include/semanage/interfaces.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/include/semanage/interfaces.h	2005-10-14 12:38:26.000000000 -0400
@@ -0,0 +1,47 @@
+#ifndef _SEMANAGE_INTERFACES_H_
+#define _SEMANAGE_INTERFACES_H_
+
+#include <stddef.h>
+#include <semanage/iface_record.h>
+#include <semanage/handle.h>
+
+extern int semanage_iface_add(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t* data);
+
+extern int semanage_iface_modify(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t* data);
+
+extern int semanage_iface_del(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key);
+
+extern int semanage_iface_query(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t** response);
+
+extern int semanage_iface_exists(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	int* response);
+
+extern int semanage_iface_count(
+	semanage_handle_t* handle,
+	int* response);
+
+extern int semanage_iface_iterate(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_iface_t* record,
+	                void* varg),
+	void* handler_arg);
+
+extern int semanage_iface_list(
+	semanage_handle_t* handle,
+	semanage_iface_t*** records,
+	size_t* count);
+
+#endif 
diff -Naur libsemanage/src/booleans.c libsemanage.new/src/booleans.c
--- libsemanage/src/booleans.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/booleans.c	2005-10-14 12:47:27.000000000 -0400
@@ -0,0 +1,96 @@
+#include <semanage/boolean_record.h>
+
+typedef semanage_bool_key_t record_key_t;
+typedef semanage_bool_t record_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED
+
+#include <stddef.h>
+#include <stdlib.h>
+#include <semanage/booleans.h>
+#include "handle.h"
+#include "database.h"
+
+/* Record base functions */
+record_table_t SEMANAGE_BOOL_RTABLE = {
+	.create      = semanage_bool_create,
+	.key_extract = semanage_bool_key_extract,
+	.key_free    = semanage_bool_key_free,
+	.clone       = semanage_bool_clone,
+	.compare     = semanage_bool_compare,
+	.free        = semanage_bool_free,
+};
+
+int semanage_bool_add(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase(handle);
+	return dconfig->dtable->add(handle, dconfig->dbase, key, data);
+}
+
+int semanage_bool_modify(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase(handle);	
+	return dconfig->dtable->modify(handle, dconfig->dbase, key, data);
+}
+
+int semanage_bool_del(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase(handle);
+	return dconfig->dtable->del(handle, dconfig->dbase, key);
+}
+
+int semanage_bool_query(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t** response) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase(handle);
+	return dconfig->dtable->query(handle, dconfig->dbase, key, response);
+}
+
+int semanage_bool_exists(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase(handle);
+	return dconfig->dtable->exists(handle, dconfig->dbase, key, response);
+}
+
+int semanage_bool_count(
+	semanage_handle_t* handle,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase(handle);
+	return dconfig->dtable->count(handle, dconfig->dbase, response);
+}
+
+int semanage_bool_iterate(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_bool_t* record,
+	                void* varg),
+	void* handler_arg) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase(handle);
+	return dconfig->dtable->iterate(handle, dconfig->dbase, handler, handler_arg);
+}
+
+int semanage_bool_list(
+	semanage_handle_t* handle,
+	semanage_bool_t*** records,
+	size_t* count) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase(handle);
+	return dconfig->dtable->list(handle, dconfig->dbase, records, count);
+}
diff -Naur libsemanage/src/booleans_file.c libsemanage.new/src/booleans_file.c
--- libsemanage/src/booleans_file.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/booleans_file.c	2005-10-14 12:48:12.000000000 -0400
@@ -0,0 +1,70 @@
+#include <semanage/boolean_record.h>
+
+typedef semanage_bool_t record_t;
+typedef semanage_bool_key_t record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED 
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <ctype.h>
+#include <string.h>
+#include <selinux/selinux.h>
+#include "database_file.h"
+#include "parse_utils.h"
+#include "debug.h"
+#include "semanage_store.h"
+#include "handle.h"
+
+static int bool_print(
+	semanage_bool_t* bool, 
+	FILE* str) {
+
+	/* Stub */
+	bool = NULL;
+	str = NULL;
+	return STATUS_SUCCESS;
+}
+
+static int bool_parse(
+	parse_info_t* info, 
+	semanage_bool_t* bool) {
+
+	/* Stub */
+	info = NULL;
+	bool = NULL;
+	return STATUS_SUCCESS;
+
+}
+
+/* BOOL RECORD: metod table (booleans.c) */
+extern record_table_t SEMANAGE_BOOL_RTABLE;
+
+/* BOOL RECORD: FILE extension: method table */
+record_file_table_t SEMANAGE_BOOL_FILE_RTABLE = {
+	.parse       = bool_parse,
+	.print       = bool_print,
+};
+
+int bool_file_dbase_init(dbase_config_t* dconfig) {
+	
+	if (dbase_file_init(
+		"booleans",
+		&SEMANAGE_BOOL_RTABLE,
+		&SEMANAGE_BOOL_FILE_RTABLE, 
+		&dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_FILE_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void bool_file_dbase_release(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig) {
+
+	dbase_file_release(handle, dconfig->dbase);
+}
diff -Naur libsemanage/src/handle.h libsemanage.new/src/handle.h
--- libsemanage/src/handle.h	2005-10-13 13:08:35.000000000 -0400
+++ libsemanage.new/src/handle.h	2005-10-14 12:42:30.000000000 -0400
@@ -71,9 +71,11 @@
 	struct semanage_policy_table* funcs;
 
 	/* Object databases */
-#define DBASE_COUNT 2
-#define DBASE_USERS 0
-#define DBASE_PORTS 1
+#define DBASE_COUNT      4
+#define DBASE_USERS      0
+#define DBASE_PORTS      1
+#define DBASE_INTERFACES 2
+#define DBASE_BOOLEANS   3
 	dbase_config_t dbase[DBASE_COUNT];
 };
 
@@ -87,5 +89,15 @@
         return &handle->dbase[DBASE_PORTS];
 }
 
+static inline
+dbase_config_t* semanage_iface_dbase(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_INTERFACES];
+}
+
+static inline
+dbase_config_t* semanage_bool_dbase(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_BOOLEANS];
+}
+
 #endif
 
diff -Naur libsemanage/src/interfaces.c libsemanage.new/src/interfaces.c
--- libsemanage/src/interfaces.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/interfaces.c	2005-10-14 12:47:38.000000000 -0400
@@ -0,0 +1,96 @@
+#include <semanage/iface_record.h>
+
+typedef semanage_iface_key_t record_key_t;
+typedef semanage_iface_t record_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED
+
+#include <stddef.h>
+#include <stdlib.h>
+#include <semanage/interfaces.h>
+#include "handle.h"
+#include "database.h"
+
+/* Record base functions */
+record_table_t SEMANAGE_IFACE_RTABLE = {
+	.create      = semanage_iface_create,
+	.key_extract = semanage_iface_key_extract,
+	.key_free    = semanage_iface_key_free,
+	.clone       = semanage_iface_clone,
+	.compare     = semanage_iface_compare,
+	.free        = semanage_iface_free,
+};
+
+int semanage_iface_add(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t* data) {
+
+	dbase_config_t* dconfig = semanage_iface_dbase(handle);
+	return dconfig->dtable->add(handle, dconfig->dbase, key, data);
+}
+
+int semanage_iface_modify(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t* data) {
+
+	dbase_config_t* dconfig = semanage_iface_dbase(handle);	
+	return dconfig->dtable->modify(handle, dconfig->dbase, key, data);
+}
+
+int semanage_iface_del(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key) {
+
+	dbase_config_t* dconfig = semanage_iface_dbase(handle);
+	return dconfig->dtable->del(handle, dconfig->dbase, key);
+}
+
+int semanage_iface_query(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t** response) {
+
+	dbase_config_t* dconfig = semanage_iface_dbase(handle);
+	return dconfig->dtable->query(handle, dconfig->dbase, key, response);
+}
+
+int semanage_iface_exists(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_iface_dbase(handle);
+	return dconfig->dtable->exists(handle, dconfig->dbase, key, response);
+}
+
+int semanage_iface_count(
+	semanage_handle_t* handle,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_iface_dbase(handle);
+	return dconfig->dtable->count(handle, dconfig->dbase, response);
+}
+
+int semanage_iface_iterate(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_iface_t* record,
+	                void* varg),
+	void* handler_arg) {
+
+	dbase_config_t* dconfig = semanage_iface_dbase(handle);
+	return dconfig->dtable->iterate(handle, dconfig->dbase, handler, handler_arg);
+}
+
+int semanage_iface_list(
+	semanage_handle_t* handle,
+	semanage_iface_t*** records,
+	size_t* count) {
+
+	dbase_config_t* dconfig = semanage_iface_dbase(handle);
+	return dconfig->dtable->list(handle, dconfig->dbase, records, count);
+}
diff -Naur libsemanage/src/interfaces_file.c libsemanage.new/src/interfaces_file.c
--- libsemanage/src/interfaces_file.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/interfaces_file.c	2005-10-14 12:48:23.000000000 -0400
@@ -0,0 +1,70 @@
+#include <semanage/iface_record.h>
+
+typedef semanage_iface_t record_t;
+typedef semanage_iface_key_t record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED 
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <ctype.h>
+#include <string.h>
+#include <selinux/selinux.h>
+#include "database_file.h"
+#include "parse_utils.h"
+#include "debug.h"
+#include "semanage_store.h"
+#include "handle.h"
+
+static int iface_print(
+	semanage_iface_t* iface, 
+	FILE* str) {
+
+	/* Stub */
+	iface = NULL;
+	str = NULL;
+	return STATUS_SUCCESS;
+}
+
+static int iface_parse(
+	parse_info_t* info, 
+	semanage_iface_t* iface) {
+
+	/* Stub */
+	info = NULL;
+	iface = NULL;
+	return STATUS_SUCCESS;
+
+}
+
+/* IFACE RECORD: metod table (interfaces.c) */
+extern record_table_t SEMANAGE_IFACE_RTABLE;
+
+/* IFACE RECORD: FILE extension: method table */
+record_file_table_t SEMANAGE_IFACE_FILE_RTABLE = {
+	.parse       = iface_parse,
+	.print       = iface_print,
+};
+
+int iface_file_dbase_init(dbase_config_t* dconfig) {
+	
+	if (dbase_file_init(
+		NULL, /* FIXME */
+		&SEMANAGE_IFACE_RTABLE,
+		&SEMANAGE_IFACE_FILE_RTABLE, 
+		&dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_FILE_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void iface_file_dbase_release(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig) {
+
+	dbase_file_release(handle, dconfig->dbase);
+}
diff -Naur libsemanage/src/policy_components.c libsemanage.new/src/policy_components.c
--- libsemanage/src/policy_components.c	2005-10-13 13:08:35.000000000 -0400
+++ libsemanage.new/src/policy_components.c	2005-10-14 12:50:28.000000000 -0400
@@ -9,8 +9,8 @@
 	semanage_module_info_t* base) {
 
 	//dbase_config_t* modules = dbase_modules_dbase(handle);
-	//dbase_config_t* interfaces = semanage_iface_dbase(handle);
-	//dbase_config_t* booleans = semanage_bool_dbase(handle);
+	dbase_config_t* interfaces = semanage_iface_dbase(handle);
+	dbase_config_t* booleans = semanage_bool_dbase(handle);
 	dbase_config_t* users = semanage_user_dbase(handle);
 	dbase_config_t* ports = semanage_port_dbase(handle);
 
@@ -18,15 +18,15 @@
 	if (modules->dtable->iterate(handle,
 		modules->dbase, NULL, NULL, /* FIXME */) < 0)
 		goto err;	
+#endif
 
 	if (interfaces->dtable->iterate(handle,
-		interfaces->dbase, NULL, NULL, /* FIXME */) < 0)
+		interfaces->dbase, NULL, NULL /* FIXME */) < 0)
 		goto err;
 
 	if (booleans->dtable->iterate(handle,
-		booleans->dbase, NULL, NULL, /* FIXME */) < 0)
+		booleans->dbase, NULL, NULL /* FIXME */) < 0)
 		goto err;
-#endif
 
 	if (users->dtable->iterate(handle, 
 		users->dbase, NULL, NULL /* FIXME */) < 0)
@@ -48,21 +48,21 @@
 	semanage_handle_t* handle) {
 
 	//dbase_config_t* modules = semanage_modules_dbase(handle);
-	//dbase_config_t* interfaces = semanage_iface_dbase(handle);
-	//dbase_config_t* booleans = semanage_bool_dbase(handle);
+	dbase_config_t* interfaces = semanage_iface_dbase(handle);
+	dbase_config_t* booleans = semanage_bool_dbase(handle);
 	dbase_config_t* users = semanage_user_dbase(handle);
 	dbase_config_t* ports = semanage_port_dbase(handle);
 
 #if 0
         if (modules->dtable->flush(handle, modules->dbase) < 0)
                 goto err;
+#endif
 
         if (interfaces->dtable->flush(handle, interfaces->dbase) < 0)
                 goto err;
 
         if (booleans->dtable->flush(handle, booleans->dbase) < 0)
                 goto err;
-#endif
 
 	if (users->dtable->flush(handle, users->dbase) < 0) 
 		goto err;
@@ -76,10 +76,9 @@
 	/* FIXME: handle error */
 #if 0
 	modules->dtable->drop_cache(handle, modules->dbase);
+#endif
 	interfaces->dtable->drop_cache(handle, interfaces->dbase);
 	booleans->dtable->drop_cache(handle, booleans->dbase);
-#endif
-	
 	users->dtable->drop_cache(handle, users->dbase);
 	ports->dtable->drop_cache(handle, ports->dbase);
 	return STATUS_ERR;

--------------030500060704030501060908--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
