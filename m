Message-ID: <43510C78.1080209@cornell.edu>
Date: Sat, 15 Oct 2005 10:04:40 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [ SEMANAGE ] User and port apis - policy database
Content-Type: multipart/mixed;
 boundary="------------010805070700090202010006"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010805070700090202010006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The following patch adds the relay functions (implements some, and stubs 
others) to dbase for user and port policy databases (as opposed to file 
databases). These are the users and ports _in policy_ - you'd call those 
functions to add/modify a semanage user in active policy, or to iterate 
all the users in active policy, etc..

I intend to expose some of those APIs to libsemanage clients, but I 
haven't decided which ones right now (the modify APIs likely should not 
be exposed, since policy modifications are all done on commit, 
internally), so for now all those functions are internal only. The idea 
is to have two sets of functions - one which works on locally 
customizable users/ports, and the other works on all users/ports in the 
expanded policy.

These functions aren't quite as simple as the ones in users.c, and 
ports.c, because the database works in terms of sepol objects, and we 
need to convert the semanage objects to those. "Convert" right now means 
a simple cast, but in case that every changes, I've made it into an 
(inlined) function.

==================

Also in this patch:
- use the inline functions that get each database from the handle in 
direct_api.c and handle.c
- rename DBASE_BASE to DBASE_POLICY, since BASE implies working on 
"base.pp", while here we are working on "policy.kern".




--------------010805070700090202010006
Content-Type: text/x-patch;
 name="libsemanage.policy.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.policy.diff"

diff -Naur --exclude VERSION --exclude ChangeLog --exclude CVS libsemanage/src/direct_api.c libsemanage.new/src/direct_api.c
--- libsemanage/src/direct_api.c	2005-10-14 15:49:56.000000000 -0400
+++ libsemanage.new/src/direct_api.c	2005-10-15 09:36:19.000000000 -0400
@@ -80,17 +80,21 @@
 	/* set up function pointers */
 	sh->funcs = &direct_funcs;
 
-	if (user_direct_dbase_init(&sh->dbase[DBASE_BASE_USERS]) < 0)
+	if (user_direct_dbase_init(
+		semanage_user_dbase_policy(sh)) < 0)
 		goto err;
 
-	if (port_direct_dbase_init(&sh->dbase[DBASE_BASE_PORTS]) < 0)
+	if (port_direct_dbase_init(
+		semanage_port_dbase_policy(sh)) < 0)
 		goto err;
 
 #if 0
-	if (iface_direct_dbase_init(&sh->dbase[DBASE_BASE_INTERFACES]) < 0)
+	if (iface_direct_dbase_init(
+		semanage_iface_dbase_policy(sh)) < 0)
 		goto err;
 
-	if (bool_direct_dbase_init(&sh->dbase[DBASE_BASE_BOOLEANS]) < 0)
+	if (bool_direct_dbase_init(
+		semanage_bool_dbase_policy(sh)) < 0)
 		goto err;
 #endif
 
@@ -118,11 +122,11 @@
 	}
 
 	/* Remove object databases */
-	user_direct_dbase_release(sh, &sh->dbase[DBASE_BASE_USERS]);
-	port_direct_dbase_release(sh, &sh->dbase[DBASE_BASE_PORTS]);
+	user_direct_dbase_release(sh, semanage_user_dbase_policy(sh));
+	port_direct_dbase_release(sh, semanage_port_dbase_policy(sh));
 #if 0
-	iface_direct_dbase_release(sh, &sh->dbase[DBASE_BASE_INTERFACES]);
-	bool_direct_dbase_release(sh, &sh->dbase[DBASE_BASE_BOOLEANS]);
+	iface_direct_dbase_release(sh, semanage_iface_dbase_policy(sh));
+	bool_direct_dbase_release(sh, semanage_port_dbase_policy(sh));
 #endif
 
 	return 0;
diff -Naur --exclude VERSION --exclude ChangeLog --exclude CVS libsemanage/src/handle.c libsemanage.new/src/handle.c
--- libsemanage/src/handle.c	2005-10-14 15:49:56.000000000 -0400
+++ libsemanage.new/src/handle.c	2005-10-15 09:36:16.000000000 -0400
@@ -75,19 +75,19 @@
 
 	/* Configure object databases 
 	 * Hardcore DATA FILE backend for now */
-	if (user_file_dbase_init(&sh->dbase[DBASE_USERS]) < 0)
+	if (user_file_dbase_init(semanage_user_dbase(sh)) < 0)
 		goto err;
 
-	if (port_file_dbase_init(&sh->dbase[DBASE_PORTS]) < 0)
+	if (port_file_dbase_init(semanage_port_dbase(sh)) < 0)
 		goto err;
 
-	if (iface_file_dbase_init(&sh->dbase[DBASE_INTERFACES]) < 0)
+	if (iface_file_dbase_init(semanage_iface_dbase(sh)) < 0)
 		goto err;
 
-	if (bool_file_dbase_init(&sh->dbase[DBASE_BOOLEANS]) < 0)
+	if (bool_file_dbase_init(semanage_bool_dbase(sh)) < 0)
 		goto err;
 
-	if (seuser_file_dbase_init(&sh->dbase[DBASE_SEUSERS]) < 0)
+	if (seuser_file_dbase_init(semanage_seuser_dbase(sh)) < 0)
 		goto err;
 
         return sh;
@@ -140,11 +140,11 @@
 	semanage_conf_destroy(sh->conf);
 
 	/* Free object databases */
-	user_file_dbase_release(sh, &sh->dbase[DBASE_USERS]);
-	port_file_dbase_release(sh, &sh->dbase[DBASE_PORTS]);
-	iface_file_dbase_release(sh, &sh->dbase[DBASE_INTERFACES]);
-	bool_file_dbase_release(sh, &sh->dbase[DBASE_BOOLEANS]);
-	seuser_file_dbase_release(sh, &sh->dbase[DBASE_SEUSERS]);
+	user_file_dbase_release(sh, semanage_user_dbase(sh));
+	port_file_dbase_release(sh, semanage_port_dbase(sh));
+	iface_file_dbase_release(sh, semanage_iface_dbase(sh));
+	bool_file_dbase_release(sh, semanage_bool_dbase(sh));
+	seuser_file_dbase_release(sh, semanage_seuser_dbase(sh));
 
 	free(sh);
 }
diff -Naur --exclude VERSION --exclude ChangeLog --exclude CVS libsemanage/src/handle.h libsemanage.new/src/handle.h
--- libsemanage/src/handle.h	2005-10-14 14:32:34.000000000 -0400
+++ libsemanage.new/src/handle.h	2005-10-15 09:41:18.000000000 -0400
@@ -79,11 +79,11 @@
 #define DBASE_BOOLEANS   3
 #define DBASE_SEUSERS    4
 
-#define DBASE_BASE_USERS      5
-#define DBASE_BASE_PORTS      6
+#define DBASE_POLICY_USERS      5
+#define DBASE_POLICY_PORTS      6
 #if 0
-#define DBASE_BASE_INTERFACES 7
-#define DBASE_BASE_BOOLEANS   8
+#define DBASE_POLICY_INTERFACES 7
+#define DBASE_POLICY_BOOLEANS   8
 #endif
 	dbase_config_t dbase[DBASE_COUNT];
 };
@@ -114,24 +114,24 @@
 }
 
 static inline
-dbase_config_t* semanage_base_user_dbase(semanage_handle_t* handle) {
-	return &handle->dbase[DBASE_BASE_USERS];
+dbase_config_t* semanage_user_dbase_policy(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_POLICY_USERS];
 }
 
 static inline
-dbase_config_t* semanage_base_port_dbase(semanage_handle_t* handle) {
-	return &handle->dbase[DBASE_BASE_PORTS];
+dbase_config_t* semanage_port_dbase_policy(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_POLICY_PORTS];
 }
 
 #if 0
 static inline
-dbase_config_t* semanage_base_iface_dbase(semanage_handle_t* handle) {
-	return &handle->dbase[DBASE_BASE_INTERFACES];
+dbase_config_t* semanage_iface_dbase_policy(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_POLICY_INTERFACES];
 }
 
 static inline
-dbase_config_t* semanage_base_bool_dbase(semanage_handle_t* handle) {
-	return &handle->dbase[DBASE_BASE_BOOLEANS];
+dbase_config_t* semanage_bool_dbase_policy(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_POLICY_BOOLEANS];
 }
 #endif
 
diff -Naur --exclude VERSION --exclude ChangeLog --exclude CVS libsemanage/src/ports_policy.c libsemanage.new/src/ports_policy.c
--- libsemanage/src/ports_policy.c	2005-10-04 10:51:22.000000000 -0400
+++ libsemanage.new/src/ports_policy.c	2005-10-15 09:44:08.000000000 -0400
@@ -8,22 +8,28 @@
 typedef struct dbase_direct dbase_t;
 #define DBASE_DEFINED
 
-#include <semanage/port_record.h>
 #include <stddef.h>
 #include <stdlib.h>
+#include <semanage/port_record.h>
 #include "handle.h"
 #include "database.h"
 #include "ports_policy.h"
 #include "debug.h"
 
-static inline int convert(
+static inline int semanage2sepol_key(
 	semanage_port_key_t* semanage_key,
-	semanage_port_t* semanage_port,
-	sepol_port_key_t** sepol_key,
-	sepol_port_t** sepol_port) {
-
+	sepol_port_key_t** sepol_key) {
+	
 	*sepol_key = (sepol_port_key_t*) semanage_key;
-	*sepol_port = (sepol_port_t*) semanage_port;
+	return STATUS_SUCCESS;
+}
+
+
+static inline int semanage2sepol_data(
+	semanage_port_t* semanage_data,
+	sepol_port_t** sepol_data) {
+
+	*sepol_data = (sepol_port_t*) semanage_data;
 	return STATUS_SUCCESS;
 }
 
@@ -37,24 +43,147 @@
 	.free        = sepol_port_free,
 };
 
-/* FIXME: might need to change */
-#if 0
-int semanage_port_policy_load(
+int semanage_port_add_base(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	semanage_port_t* data) {
+
+	dbase_config_t* dconfig = 
+		semanage_port_dbase_policy(handle);
+	sepol_port_t* sepol_data;
+	sepol_port_key_t* sepol_key;
+
+	if (semanage2sepol_key(key, &sepol_key) < 0)
+		goto err;
+
+	if (semanage2sepol_data(data, &sepol_data) < 0)
+		goto err;
+
+	if (dconfig->dtable->add(handle, dconfig->dbase, 
+			sepol_key, sepol_data) < 0)
+		goto err;
+	
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_port_modify_base(
 	semanage_handle_t* handle,
 	semanage_port_key_t* key,
 	semanage_port_t* data) {
 
+	dbase_config_t* dconfig = 
+		semanage_port_dbase_policy(handle);
 	sepol_port_t* sepol_data;
 	sepol_port_key_t* sepol_key;
 
-	if (convert(key, data, &sepol_key, &sepol_data) < 0)
-		return STATUS_ERR;
+	if (semanage2sepol_key(key, &sepol_key) < 0)
+		goto err;
+
+	if (semanage2sepol_data(data, &sepol_data) < 0)
+		goto err;
+
+	if (dconfig->dtable->modify(handle, dconfig->dbase,
+			sepol_key, sepol_data) <  0)
+		goto err;
+
+	return STATUS_SUCCESS;
+	
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_port_del_base(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key) {
+
+	dbase_config_t* dconfig = 
+		semanage_port_dbase_policy(handle);
+	sepol_port_key_t* sepol_key;
+
+	if (semanage2sepol_key(key, &sepol_key) < 0)
+		goto err;
+
+	if (dconfig->dtable->del(handle, dconfig->dbase, sepol_key) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_port_query_base(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	semanage_port_t** response) {
+
+	/* Stub */
+	handle = NULL;
+	key = NULL;
+	response = NULL;
+	return STATUS_SUCCESS;
+}
+
+int semanage_port_exists_base(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	int* response) {
+
+	dbase_config_t* dconfig = 
+		semanage_port_dbase_policy(handle);
+	sepol_port_key_t* sepol_key;
+
+	if (semanage2sepol_key(key, &sepol_key) < 0)
+		goto err;
+
+	if (dconfig->dtable->exists(handle, dconfig->dbase, 
+			sepol_key, response) < 0)
+		goto err;
 
-	dbase_config_t* dconfig = semanage_port_direct_dbase(handle);
-	return dconfig->dtable->add(handle, dconfig, sepol_key, sepol_data);	
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_port_count_base(
+	semanage_handle_t* handle,
+	int* response) {
+
+	dbase_config_t* dconfig = 
+		semanage_port_dbase_policy(handle);
+
+	if (dconfig->dtable->count(handle, dconfig->dbase, response) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_port_iterate_base(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_port_t* record,
+	                void* varg),
+	void* handler_arg) {
+
+	/* Stub */
+	handle = NULL;
+	handler = NULL;
+	handler_arg = NULL;
+	return STATUS_SUCCESS;
 }
 
-int semanage_port_policy_list(
+int semanage_port_list_base(
 	semanage_handle_t* handle,
 	semanage_port_t*** records,
 	size_t* count) {
@@ -65,4 +194,3 @@
 	count = NULL;
 	return STATUS_SUCCESS;
 }
-#endif
diff -Naur --exclude VERSION --exclude ChangeLog --exclude CVS libsemanage/src/ports_policy.h libsemanage.new/src/ports_policy.h
--- libsemanage/src/ports_policy.h	2005-09-30 16:19:07.000000000 -0400
+++ libsemanage.new/src/ports_policy.h	2005-10-15 09:39:13.000000000 -0400
@@ -1,18 +1,49 @@
-#ifndef _SEMANAGE_PORTS_POLICY_H_
-#define _SEMANAGE_PORTS_POLICY_H_
+#ifndef _SEMANAGE_PORTS_POLICY_INTERNAL_H_
+#define _SEMANAGE_PORTS_POLICY_INTERNAL_H_
 
-#include <stddef.h>
+#include <semanage/handle.h> 
 #include <semanage/port_record.h>
-#include "handle.h"
 
-int semanage_port_policy_load(
+/* PORT RECORD (SEPOL): method table */
+extern record_table_t SEPOL_PORT_RTABLE;
+
+extern int semanage_port_add_policy(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	semanage_port_t* data);
+
+extern int semanage_port_modify_policy(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	semanage_port_t* data);
+
+extern int semanage_port_del_policy(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key);
+
+extern int semanage_port_query_policy(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	semanage_port_t** response);
+
+extern int semanage_port_exists_policy(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	int* response);
+
+extern int semanage_port_count_policy(
+	semanage_handle_t* handle,
+	int* response);
+
+extern int semanage_port_iterate_policy(
 	semanage_handle_t* handle,
-	semanage_port_key_t key,
-	semanage_port_t data);
+	int (*handler) (semanage_port_t* record,
+	                void* varg),
+	void* handler_arg);
 
-int semanage_port_policy_list(
+extern int semanage_port_list_policy(
 	semanage_handle_t* handle,
-	semanage_port_t** records,
+	semanage_port_t*** records,
 	size_t* count);
 
 #endif
diff -Naur --exclude VERSION --exclude ChangeLog --exclude CVS libsemanage/src/users_policy.c libsemanage.new/src/users_policy.c
--- libsemanage/src/users_policy.c	2005-10-04 10:51:22.000000000 -0400
+++ libsemanage.new/src/users_policy.c	2005-10-15 09:44:22.000000000 -0400
@@ -16,14 +16,20 @@
 #include "users_policy.h"
 #include "debug.h"
 
-static inline int convert(
+static inline int semanage2sepol_key(
 	semanage_user_key_t* semanage_key,
-	semanage_user_t* semanage_user,
-	sepol_user_key_t** sepol_key,
-	sepol_user_t** sepol_user) {
-
+	sepol_user_key_t** sepol_key) {
+	
 	*sepol_key = (sepol_user_key_t*) semanage_key;
-	*sepol_user = (sepol_user_t*) semanage_user;
+	return STATUS_SUCCESS;
+}
+
+
+static inline int semanage2sepol_data(
+	semanage_user_t* semanage_data,
+	sepol_user_t** sepol_data) {
+
+	*sepol_data = (sepol_user_t*) semanage_data;
 	return STATUS_SUCCESS;
 }
 
@@ -37,24 +43,147 @@
 	.free        = sepol_user_free,
 };
 
-/* FIXME: might need to change */
-#if 0
-int semanage_user_policy_load(
+int semanage_user_add_policy(
 	semanage_handle_t* handle,
 	semanage_user_key_t* key,
 	semanage_user_t* data) {
 
+	dbase_config_t* dconfig = 
+		semanage_user_dbase_policy(handle);
 	sepol_user_t* sepol_data;
 	sepol_user_key_t* sepol_key;
 
-	if (convert(key, data, &sepol_key, &sepol_data) < 0)
-		return STATUS_ERR;
+	if (semanage2sepol_key(key, &sepol_key) < 0)
+		goto err;
+
+	if (semanage2sepol_data(data, &sepol_data) < 0)
+		goto err;
+
+	if (dconfig->dtable->add(handle, dconfig->dbase, 
+			sepol_key, sepol_data) < 0)
+		goto err;
+	
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_user_modify_policy(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	semanage_user_t* data) {
+
+	dbase_config_t* dconfig = 
+		semanage_port_dbase_policy(handle);
+	sepol_user_t* sepol_data;
+	sepol_user_key_t* sepol_key;
+
+	if (semanage2sepol_key(key, &sepol_key) < 0)
+		goto err;
+
+	if (semanage2sepol_data(data, &sepol_data) < 0)
+		goto err;
+
+	if (dconfig->dtable->modify(handle, dconfig->dbase,
+			sepol_key, sepol_data) <  0)
+		goto err;
+
+	return STATUS_SUCCESS;
+	
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_user_del_policy(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key) {
+
+	dbase_config_t* dconfig = 
+		semanage_user_dbase_policy(handle);
+	sepol_user_key_t* sepol_key;
+
+	if (semanage2sepol_key(key, &sepol_key) < 0)
+		goto err;
+
+	if (dconfig->dtable->del(handle, dconfig->dbase, sepol_key) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_user_query_policy(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	semanage_user_t** response) {
+
+	/* Stub */
+	handle = NULL;
+	key = NULL;
+	response = NULL;
+	return STATUS_SUCCESS;
+}
+
+int semanage_user_exists_policy(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	int* response) {
+
+	dbase_config_t* dconfig = 
+		semanage_user_dbase_policy(handle);
+	sepol_user_key_t* sepol_key;
+
+	if (semanage2sepol_key(key, &sepol_key) < 0)
+		goto err;
 
-	dbase_config_t* dconfig = semanage_user_direct_dbase(handle);
-	return dconfig->dtable->add(handle, dconfig->dbase, sepol_key, sepol_data);
+	if (dconfig->dtable->exists(handle, dconfig->dbase, 
+			sepol_key, response) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_user_count_policy(
+	semanage_handle_t* handle,
+	int* response) {
+
+	dbase_config_t* dconfig = 
+		semanage_user_dbase_policy(handle);
+
+	if (dconfig->dtable->count(handle, dconfig->dbase, response) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_user_iterate_policy(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_user_t* record,
+	                void* varg),
+	void* handler_arg) {
+
+	/* Stub */
+	handle = NULL;
+	handler = NULL;
+	handler_arg = NULL;
+	return STATUS_SUCCESS;
 }
 
-int semanage_user_policy_list(
+int semanage_user_list_policy(
 	semanage_handle_t* handle,
 	semanage_user_t*** records,
 	size_t* count) {
@@ -65,4 +194,3 @@
 	count = NULL;
 	return STATUS_SUCCESS;
 }
-#endif
diff -Naur --exclude VERSION --exclude ChangeLog --exclude CVS libsemanage/src/users_policy.h libsemanage.new/src/users_policy.h
--- libsemanage/src/users_policy.h	2005-09-30 16:19:07.000000000 -0400
+++ libsemanage.new/src/users_policy.h	2005-10-15 09:38:23.000000000 -0400
@@ -1,18 +1,49 @@
-#ifndef _SEMANAGE_USERS_POLICY_H_
-#define _SEMANAGE_USERS_POLICY_H_
+#ifndef _SEMANAGE_USERS_POLICY_INTERNAL_H_
+#define _SEMANAGE_USERS_POLICY_INTERNAL_H_
 
-#include <stddef.h>
+#include <semanage/handle.h> 
 #include <semanage/user_record.h>
-#include "handle.h"
 
-int semanage_user_policy_load(
+/* USER RECORD (SEPOL): method table */
+extern record_table_t SEPOL_USER_RTABLE;
+
+extern int semanage_user_add_policy(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	semanage_user_t* data);
+
+extern int semanage_user_modify_policy(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	semanage_user_t* data);
+
+extern int semanage_user_del_policy(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key);
+
+extern int semanage_user_query_policy(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	semanage_user_t** response);
+
+extern int semanage_user_exists_policy(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	int* response);
+
+extern int semanage_user_count_policy(
+	semanage_handle_t* handle,
+	int* response);
+
+extern int semanage_user_iterate_policy(
 	semanage_handle_t* handle,
-	semanage_user_key_t key,
-	semanage_user_t data);
+	int (*handler) (semanage_user_t* record,
+	                void* varg),
+	void* handler_arg);
 
-int semanage_user_policy_list(
+extern int semanage_user_list_policy(
 	semanage_handle_t* handle,
-	semanage_user_t** records,
+	semanage_user_t*** records,
 	size_t* count);
 
 #endif

--------------010805070700090202010006--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
