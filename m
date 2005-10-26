Message-ID: <435FF625.9030500@cornell.edu>
Date: Wed, 26 Oct 2005 17:33:25 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Complete query APIs for in-policy objects
Content-Type: multipart/mixed;
 boundary="------------010301040500030703010905"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010301040500030703010905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:
- drop convert functions for now - we will require binary compatibility 
at least in the immediate future, as off-list discussion w/ Tresys 
established. We might need to get back to this problem after FC5t1
- implement all query APIs for in-policy objects, and simplify them.

I've done minimal testing - the iterate() function works... (and I know 
count() works from before). List is not going to work, because it's a 
stub. Query... haven't tested it yet (but all sepol functions were 
tested w/ respect to sepol, and worked).





--------------010301040500030703010905
Content-Type: text/x-patch;
 name="libsemanage.policy_apis.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.policy_apis.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/booleans_policy.c new/libsemanage/src/booleans_policy.c
--- old/libsemanage/src/booleans_policy.c	2005-10-21 09:54:25.000000000 -0400
+++ new/libsemanage/src/booleans_policy.c	2005-10-26 17:21:18.000000000 -0400
@@ -16,23 +16,6 @@ typedef struct dbase_direct dbase_t;
 #include "database.h"
 #include "debug.h"
 
-static inline int semanage2sepol_key(
-	semanage_bool_key_t* semanage_key,
-	sepol_bool_key_t** sepol_key) {
-	
-	*sepol_key = (sepol_bool_key_t*) semanage_key;
-	return STATUS_SUCCESS;
-}
-
-
-static inline int semanage2sepol_data(
-	semanage_bool_t* semanage_data,
-	sepol_bool_t** sepol_data) {
-
-	*sepol_data = (sepol_bool_t*) semanage_data;
-	return STATUS_SUCCESS;
-}
-
 /* BOOLEAN RECORD (SEPOL): method table */
 record_table_t SEPOL_BOOL_RTABLE = {
 	.create      = sepol_bool_create,
@@ -48,11 +31,11 @@ int semanage_bool_query(
 	semanage_bool_key_t* key,
 	semanage_bool_t** response) {
 
-	/* Stub */
-	handle = NULL;
-	key = NULL;
-	response = NULL;
-	return STATUS_ERR;
+	dbase_config_t* dconfig = semanage_bool_dbase_policy(handle);
+
+	/* Note: requires binary compatible sepol record */
+	return dconfig->dtable->query(handle, dconfig->dbase, 
+		(sepol_bool_key_t*) key, (sepol_bool_t**) response);
 }
 
 int semanage_bool_exists(
@@ -60,39 +43,19 @@ int semanage_bool_exists(
 	semanage_bool_key_t* key,
 	int* response) {
 
-	dbase_config_t* dconfig = 
-		semanage_bool_dbase_policy(handle);
-	sepol_bool_key_t* sepol_key;
-
-	if (semanage2sepol_key(key, &sepol_key) < 0)
-		goto err;
-
-	if (dconfig->dtable->exists(handle, dconfig->dbase, 
-			sepol_key, response) < 0)
-		goto err;
-
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
+	dbase_config_t* dconfig = semanage_bool_dbase_policy(handle);
+
+	/* Note: requires binary compatible sepol record */
+	return dconfig->dtable->exists(handle, dconfig->dbase,
+		(sepol_bool_key_t*) key, response);
 }
 
 int semanage_bool_count(
 	semanage_handle_t* handle,
 	int* response) {
 
-	dbase_config_t* dconfig = 
-		semanage_bool_dbase_policy(handle);
-
-	if (dconfig->dtable->count(handle, dconfig->dbase, response) < 0)
-		goto err;
-
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
+	dbase_config_t* dconfig = semanage_bool_dbase_policy(handle);
+	return dconfig->dtable->count(handle, dconfig->dbase, response);
 }
 
 int semanage_bool_iterate(
@@ -101,11 +64,11 @@ int semanage_bool_iterate(
 	                void* varg),
 	void* handler_arg) {
 
-	/* Stub */
-	handle = NULL;
-	handler = NULL;
-	handler_arg = NULL;
-	return STATUS_ERR;
+	/* Note: requires binary compatible sepol record */
+	dbase_config_t* dconfig = semanage_bool_dbase_policy(handle);
+	return dconfig->dtable->iterate(handle, dconfig->dbase,
+			(int (*) (sepol_bool_t*, void*)) 
+			handler, handler_arg);	
 }
 
 int semanage_bool_list(
@@ -113,9 +76,8 @@ int semanage_bool_list(
 	semanage_bool_t*** records,
 	size_t* count) {
 
-	/* Stub */
-	handle = NULL;
-	records = NULL;
-	count = NULL;
-	return STATUS_ERR;
+	/* Note: requires binary compatible sepol record */
+	dbase_config_t* dconfig = semanage_bool_dbase_policy(handle);
+	return dconfig->dtable->list(handle, dconfig->dbase,
+		(sepol_bool_t***) records, count);
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/interfaces_policy.c new/libsemanage/src/interfaces_policy.c
--- old/libsemanage/src/interfaces_policy.c	2005-10-21 09:54:25.000000000 -0400
+++ new/libsemanage/src/interfaces_policy.c	2005-10-26 17:21:26.000000000 -0400
@@ -16,23 +16,6 @@ typedef struct dbase_direct dbase_t;
 #include "database.h"
 #include "debug.h"
 
-static inline int semanage2sepol_key(
-	semanage_iface_key_t* semanage_key,
-	sepol_iface_key_t** sepol_key) {
-	
-	*sepol_key = (sepol_iface_key_t*) semanage_key;
-	return STATUS_SUCCESS;
-}
-
-
-static inline int semanage2sepol_data(
-	semanage_iface_t* semanage_data,
-	sepol_iface_t** sepol_data) {
-
-	*sepol_data = (sepol_iface_t*) semanage_data;
-	return STATUS_SUCCESS;
-}
-
 /* INTERFACE RECORD (SEPOL): method table */
 record_table_t SEPOL_IFACE_RTABLE = {
 	.create      = sepol_iface_create,
@@ -48,11 +31,11 @@ int semanage_iface_query(
 	semanage_iface_key_t* key,
 	semanage_iface_t** response) {
 
-	/* Stub */
-	handle = NULL;
-	key = NULL;
-	response = NULL;
-	return STATUS_SUCCESS;
+	dbase_config_t* dconfig = semanage_iface_dbase_policy(handle);
+
+	/* Note: requires binary compatible sepol record */
+	return dconfig->dtable->query(handle, dconfig->dbase, 
+		(sepol_iface_key_t*) key, (sepol_iface_t**) response);
 }
 
 int semanage_iface_exists(
@@ -60,39 +43,19 @@ int semanage_iface_exists(
 	semanage_iface_key_t* key,
 	int* response) {
 
-	dbase_config_t* dconfig = 
-		semanage_iface_dbase_policy(handle);
-	sepol_iface_key_t* sepol_key;
-
-	if (semanage2sepol_key(key, &sepol_key) < 0)
-		goto err;
-
-	if (dconfig->dtable->exists(handle, dconfig->dbase, 
-			sepol_key, response) < 0)
-		goto err;
-
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
+	dbase_config_t* dconfig = semanage_iface_dbase_policy(handle);
+
+	/* Note: requires binary compatible sepol record */
+	return dconfig->dtable->exists(handle, dconfig->dbase,
+		(sepol_iface_key_t*) key, response);
 }
 
 int semanage_iface_count(
 	semanage_handle_t* handle,
 	int* response) {
 
-	dbase_config_t* dconfig = 
-		semanage_iface_dbase_policy(handle);
-
-	if (dconfig->dtable->count(handle, dconfig->dbase, response) < 0)
-		goto err;
-
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
+	dbase_config_t* dconfig = semanage_iface_dbase_policy(handle);
+	return dconfig->dtable->count(handle, dconfig->dbase, response);
 }
 
 int semanage_iface_iterate(
@@ -101,11 +64,10 @@ int semanage_iface_iterate(
 	                void* varg),
 	void* handler_arg) {
 
-	/* Stub */
-	handle = NULL;
-	handler = NULL;
-	handler_arg = NULL;
-	return STATUS_SUCCESS;
+	/* Note: requires binary compatible sepol record */
+	dbase_config_t* dconfig = semanage_iface_dbase_policy(handle);
+	return dconfig->dtable->iterate(handle, dconfig->dbase,
+			(int (*) (sepol_iface_t*,void*)) handler, handler_arg);	
 }
 
 int semanage_iface_list(
@@ -113,9 +75,8 @@ int semanage_iface_list(
 	semanage_iface_t*** records,
 	size_t* count) {
 
-	/* Stub */
-	handle = NULL;
-	records = NULL;
-	count = NULL;
-	return STATUS_SUCCESS;
+	/* Note: requires binary compatible sepol record */
+	dbase_config_t* dconfig = semanage_iface_dbase_policy(handle);
+	return dconfig->dtable->list(handle, dconfig->dbase,
+		(sepol_iface_t***) records, count);
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/ports_policy.c new/libsemanage/src/ports_policy.c
--- old/libsemanage/src/ports_policy.c	2005-10-21 09:54:25.000000000 -0400
+++ new/libsemanage/src/ports_policy.c	2005-10-26 17:21:35.000000000 -0400
@@ -16,23 +16,6 @@ typedef struct dbase_direct dbase_t;
 #include "database.h"
 #include "debug.h"
 
-static inline int semanage2sepol_key(
-	semanage_port_key_t* semanage_key,
-	sepol_port_key_t** sepol_key) {
-	
-	*sepol_key = (sepol_port_key_t*) semanage_key;
-	return STATUS_SUCCESS;
-}
-
-
-static inline int semanage2sepol_data(
-	semanage_port_t* semanage_data,
-	sepol_port_t** sepol_data) {
-
-	*sepol_data = (sepol_port_t*) semanage_data;
-	return STATUS_SUCCESS;
-}
-
 /* PORT RECORD (SEPOL): method table */
 record_table_t SEPOL_PORT_RTABLE = {
 	.create      = sepol_port_create,
@@ -48,11 +31,11 @@ int semanage_port_query(
 	semanage_port_key_t* key,
 	semanage_port_t** response) {
 
-	/* Stub */
-	handle = NULL;
-	key = NULL;
-	response = NULL;
-	return STATUS_ERR;
+	dbase_config_t* dconfig = semanage_port_dbase_policy(handle);
+
+	/* Note: requires binary compatible sepol record */
+	return dconfig->dtable->query(handle, dconfig->dbase, 
+		(sepol_port_key_t*) key, (sepol_port_t**) response);
 }
 
 int semanage_port_exists(
@@ -60,39 +43,19 @@ int semanage_port_exists(
 	semanage_port_key_t* key,
 	int* response) {
 
-	dbase_config_t* dconfig = 
-		semanage_port_dbase_policy(handle);
-	sepol_port_key_t* sepol_key;
-
-	if (semanage2sepol_key(key, &sepol_key) < 0)
-		goto err;
-
-	if (dconfig->dtable->exists(handle, dconfig->dbase, 
-			sepol_key, response) < 0)
-		goto err;
-
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
+	dbase_config_t* dconfig = semanage_port_dbase_policy(handle);
+
+	/* Note: requires binary compatible sepol record */
+	return dconfig->dtable->exists(handle, dconfig->dbase,
+		(sepol_port_key_t*) key, response);
 }
 
 int semanage_port_count(
 	semanage_handle_t* handle,
 	int* response) {
 
-	dbase_config_t* dconfig = 
-		semanage_port_dbase_policy(handle);
-
-	if (dconfig->dtable->count(handle, dconfig->dbase, response) < 0)
-		goto err;
-
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
+	dbase_config_t* dconfig = semanage_port_dbase_policy(handle);
+	return dconfig->dtable->count(handle, dconfig->dbase, response);
 }
 
 int semanage_port_iterate(
@@ -101,11 +64,10 @@ int semanage_port_iterate(
 	                void* varg),
 	void* handler_arg) {
 
-	/* Stub */
-	handle = NULL;
-	handler = NULL;
-	handler_arg = NULL;
-	return STATUS_ERR;
+	/* Note: requires binary compatible sepol record */
+	dbase_config_t* dconfig = semanage_port_dbase_policy(handle);
+	return dconfig->dtable->iterate(handle, dconfig->dbase,
+			(int (*) (sepol_port_t*,void*)) handler, handler_arg);	
 }
 
 int semanage_port_list(
@@ -113,9 +75,8 @@ int semanage_port_list(
 	semanage_port_t*** records,
 	size_t* count) {
 
-	/* Stub */
-	handle = NULL;
-	records = NULL;
-	count = NULL;
-	return STATUS_ERR;
+	/* Note: requires binary compatible sepol record */
+	dbase_config_t* dconfig = semanage_port_dbase_policy(handle);
+	return dconfig->dtable->list(handle, dconfig->dbase,
+		(sepol_port_t***) records, count);
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/users_policy.c new/libsemanage/src/users_policy.c
--- old/libsemanage/src/users_policy.c	2005-10-21 09:54:25.000000000 -0400
+++ new/libsemanage/src/users_policy.c	2005-10-26 17:21:44.000000000 -0400
@@ -16,23 +16,6 @@ typedef struct dbase_direct dbase_t;
 #include "database.h"
 #include "debug.h"
 
-static inline int semanage2sepol_key(
-	semanage_user_key_t* semanage_key,
-	sepol_user_key_t** sepol_key) {
-	
-	*sepol_key = (sepol_user_key_t*) semanage_key;
-	return STATUS_SUCCESS;
-}
-
-
-static inline int semanage2sepol_data(
-	semanage_user_t* semanage_data,
-	sepol_user_t** sepol_data) {
-
-	*sepol_data = (sepol_user_t*) semanage_data;
-	return STATUS_SUCCESS;
-}
-
 /* USER RECORD (SEPOL): method table */
 record_table_t SEPOL_USER_RTABLE = {
 	.create      = sepol_user_create,
@@ -48,11 +31,11 @@ int semanage_user_query(
 	semanage_user_key_t* key,
 	semanage_user_t** response) {
 
-	/* Stub */
-	handle = NULL;
-	key = NULL;
-	response = NULL;
-	return STATUS_ERR;
+	dbase_config_t* dconfig = semanage_user_dbase_policy(handle);
+
+	/* Note: requires binary compatible sepol record */
+	return dconfig->dtable->query(handle, dconfig->dbase, 
+		(sepol_user_key_t*) key, (sepol_user_t**) response);
 }
 
 int semanage_user_exists(
@@ -60,39 +43,19 @@ int semanage_user_exists(
 	semanage_user_key_t* key,
 	int* response) {
 
-	dbase_config_t* dconfig = 
-		semanage_user_dbase_policy(handle);
-	sepol_user_key_t* sepol_key;
-
-	if (semanage2sepol_key(key, &sepol_key) < 0)
-		goto err;
-
-	if (dconfig->dtable->exists(handle, dconfig->dbase, 
-			sepol_key, response) < 0)
-		goto err;
-
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
+	dbase_config_t* dconfig = semanage_user_dbase_policy(handle);
+
+	/* Note: requires binary compatible sepol record */
+	return dconfig->dtable->exists(handle, dconfig->dbase,
+		(sepol_user_key_t*) key, response);
 }
 
 int semanage_user_count(
 	semanage_handle_t* handle,
 	int* response) {
 
-	dbase_config_t* dconfig = 
-		semanage_user_dbase_policy(handle);
-
-	if (dconfig->dtable->count(handle, dconfig->dbase, response) < 0)
-		goto err;
-
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
+	dbase_config_t* dconfig = semanage_user_dbase_policy(handle);
+	return dconfig->dtable->count(handle, dconfig->dbase, response);
 }
 
 int semanage_user_iterate(
@@ -101,11 +64,10 @@ int semanage_user_iterate(
 	                void* varg),
 	void* handler_arg) {
 
-	/* Stub */
-	handle = NULL;
-	handler = NULL;
-	handler_arg = NULL;
-	return STATUS_ERR;
+	/* Note: requires binary compatible sepol record */
+	dbase_config_t* dconfig = semanage_user_dbase_policy(handle);
+	return dconfig->dtable->iterate(handle, dconfig->dbase,
+			(int (*) (sepol_user_t*,void*)) handler, handler_arg);	
 }
 
 int semanage_user_list(
@@ -113,9 +75,8 @@ int semanage_user_list(
 	semanage_user_t*** records,
 	size_t* count) {
 
-	/* Stub */
-	handle = NULL;
-	records = NULL;
-	count = NULL;
-	return STATUS_ERR;
+	/* Note: requires binary compatible sepol record */
+	dbase_config_t* dconfig = semanage_user_dbase_policy(handle);
+	return dconfig->dtable->list(handle, dconfig->dbase,
+		(sepol_user_t***) records, count);
 }

--------------010301040500030703010905--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
