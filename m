Message-ID: <43BA6197.3050402@cornell.edu>
Date: Tue, 03 Jan 2006 06:35:51 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] File contexts APIs (part2)
Content-Type: multipart/mixed;
 boundary="------------000309040400070901060506"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000309040400070901060506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds read-only APIs for working with the overall 
file_contexts file.
It also proceeds to merge file_contexts.local with file_contexts (just 
like any other component), which makes the (part1) patch useful now, 
since local modifications will get installed as part of the 
file_contexts. (so matchpathcon only needs to local for .local for 
compatibility reasons).

It also fixes a pretty bad bug in policy_components.c:load_handler - 
happened to work previously just because of the ordering of the code. 
iterate() works with the master copy of the record. When loading things 
from one dbase to another, the record needs to be cloned. I suppose I 
should document a lot of those ro vs master copy conventions somewhere, 
since they're not really obvious everywhere.

Note: validation of file context records is still missing.

--------------000309040400070901060506
Content-Type: text/x-patch;
 name="libsemanage15.file_contexts2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage15.file_contexts2.diff"

diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/fcontexts_policy.h new/libsemanage/include/semanage/fcontexts_policy.h
--- old/libsemanage/include/semanage/fcontexts_policy.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/include/semanage/fcontexts_policy.h	2006-01-03 06:29:37.000000000 -0500
@@ -0,0 +1,35 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+#ifndef _SEMANAGE_FCONTEXTS_POLICY_H_
+#define _SEMANAGE_FCONTEXTS_POLICY_H_
+
+#include <stddef.h>
+#include <semanage/fcontext_record.h>
+#include <semanage/handle.h>
+
+extern int semanage_fcontext_query(
+	semanage_handle_t* handle,
+	semanage_fcontext_key_t* key,
+	semanage_fcontext_t** response);
+
+extern int semanage_fcontext_exists(
+	semanage_handle_t* handle,
+	semanage_fcontext_key_t* key,
+	int* response);
+
+extern int semanage_fcontext_count(
+	semanage_handle_t* handle,
+	unsigned int* response);
+
+extern int semanage_fcontext_iterate(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_fcontext_t* record,
+	                void* varg),
+	void* handler_arg);
+
+extern int semanage_fcontext_list(
+	semanage_handle_t* handle,
+	semanage_fcontext_t*** records,
+	size_t* count);
+
+#endif 
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/semanage.h new/libsemanage/include/semanage/semanage.h
--- old/libsemanage/include/semanage/semanage.h	2005-12-26 19:12:49.000000000 -0500
+++ new/libsemanage/include/semanage/semanage.h	2006-01-03 05:37:46.000000000 -0500
@@ -41,6 +41,7 @@
 #include <semanage/users_local.h>
 #include <semanage/users_policy.h>
 #include <semanage/fcontexts_local.h>
+#include <semanage/fcontexts_policy.h>
 #include <semanage/seusers.h>
 #include <semanage/ports_local.h>
 #include <semanage/ports_policy.h>
diff -Naurp --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2006-01-03 04:25:36.000000000 -0500
+++ new/libsemanage/src/direct_api.c	2006-01-03 06:14:38.000000000 -0500
@@ -121,7 +121,8 @@ int semanage_direct_connect(semanage_han
 	if (bool_file_dbase_init(sh, semanage_bool_dbase_local(sh)) < 0)
 		goto err;
 
-	if (fcontext_file_dbase_init(sh, semanage_fcontext_dbase_local(sh)) < 0)
+	if (fcontext_file_dbase_init(sh, "file_contexts.local", 
+		semanage_fcontext_dbase_local(sh)) < 0)
 		goto err;
 
 	if (seuser_file_dbase_init(sh, semanage_seuser_dbase(sh)) < 0)
@@ -139,6 +140,10 @@ int semanage_direct_connect(semanage_han
 	if (bool_policydb_dbase_init(sh, semanage_bool_dbase_policy(sh)) < 0)
 		goto err;
 
+	if (fcontext_file_dbase_init(sh, "file_contexts", 
+		semanage_fcontext_dbase_policy(sh)) < 0)
+		goto err;
+
 	if (bool_activedb_dbase_init(sh, semanage_bool_dbase_active(sh)) < 0)
 		goto err;
 
@@ -178,6 +183,7 @@ static int semanage_direct_disconnect(se
 	port_policydb_dbase_release(semanage_port_dbase_policy(sh));
 	iface_policydb_dbase_release(semanage_iface_dbase_policy(sh));
 	bool_policydb_dbase_release(semanage_bool_dbase_policy(sh));
+	fcontext_file_dbase_release(semanage_fcontext_dbase_policy(sh));
 
 	bool_activedb_dbase_release(semanage_bool_dbase_active(sh));
 
@@ -337,15 +343,17 @@ static int semanage_direct_commit(semana
 
 	/* Check if anything was changed */
 	int modified = sh->modules_modified;
-	dbase_config_t* pusers = semanage_user_dbase_local(sh);
-	dbase_config_t* pports = semanage_port_dbase_local(sh);
-	dbase_config_t* pbools = semanage_bool_dbase_local(sh);
-	dbase_config_t* pifaces = semanage_iface_dbase_local(sh);
+	dbase_config_t* users = semanage_user_dbase_local(sh);
+	dbase_config_t* ports = semanage_port_dbase_local(sh);
+	dbase_config_t* bools = semanage_bool_dbase_local(sh);
+	dbase_config_t* ifaces = semanage_iface_dbase_local(sh);
+	dbase_config_t* fcontexts = semanage_fcontext_dbase_local(sh);
 	dbase_config_t* seusers = semanage_seuser_dbase(sh);
-	modified |= pusers->dtable->is_modified(pusers->dbase);
-	modified |= pports->dtable->is_modified(pports->dbase);
-	modified |= pbools->dtable->is_modified(pbools->dbase);
-	modified |= pifaces->dtable->is_modified(pifaces->dbase);
+	modified |= users->dtable->is_modified(users->dbase);
+	modified |= ports->dtable->is_modified(ports->dbase);
+	modified |= bools->dtable->is_modified(bools->dbase);
+	modified |= fcontexts->dtable->is_modified(fcontexts->dbase);
+	modified |= ifaces->dtable->is_modified(ifaces->dbase);
 	int seusers_modified = seusers->dtable->is_modified(seusers->dbase);
 
 	/* FIXME: get rid of this, once we support loading the existing policy,
diff -Naurp --exclude-from excludes old/libsemanage/src/fcontext_internal.h new/libsemanage/src/fcontext_internal.h
--- old/libsemanage/src/fcontext_internal.h	2005-12-26 19:12:49.000000000 -0500
+++ new/libsemanage/src/fcontext_internal.h	2006-01-03 05:36:54.000000000 -0500
@@ -3,6 +3,7 @@
 
 #include <semanage/fcontext_record.h>
 #include <semanage/fcontexts_local.h>
+#include <semanage/fcontexts_policy.h>
 #include "database.h"
 #include "handle.h"
 #include "dso.h"
@@ -14,6 +15,7 @@ extern record_table_t SEMANAGE_FCONTEXT_
 
 extern int fcontext_file_dbase_init(
 	semanage_handle_t* handle,
+	const char* fname,
 	dbase_config_t* dconfig);
 
 extern void fcontext_file_dbase_release(
diff -Naurp --exclude-from excludes old/libsemanage/src/fcontexts_file.c new/libsemanage/src/fcontexts_file.c
--- old/libsemanage/src/fcontexts_file.c	2005-12-26 19:12:49.000000000 -0500
+++ new/libsemanage/src/fcontexts_file.c	2006-01-03 05:32:59.000000000 -0500
@@ -164,11 +164,12 @@ record_file_table_t SEMANAGE_FCONTEXT_FI
 
 int fcontext_file_dbase_init(
 	semanage_handle_t* handle,
+	const char* fname,
 	dbase_config_t* dconfig) {
 	
 	if (dbase_file_init(
 		handle, 
-		"file_contexts.local",
+		fname,
 		&SEMANAGE_FCONTEXT_RTABLE,
 		&SEMANAGE_FCONTEXT_FILE_RTABLE, 
 		&dconfig->dbase) < 0)
diff -Naurp --exclude-from excludes old/libsemanage/src/fcontexts_policy.c new/libsemanage/src/fcontexts_policy.c
--- old/libsemanage/src/fcontexts_policy.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/fcontexts_policy.c	2006-01-03 05:36:34.000000000 -0500
@@ -0,0 +1,57 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+struct semanage_fcontext;
+struct semanage_fcontext_key;
+typedef struct semanage_fcontext_key record_key_t;
+typedef struct semanage_fcontext record_t;
+#define DBASE_RECORD_DEFINED
+
+#include <stddef.h>
+#include "fcontext_internal.h"
+#include "handle.h" 
+#include "database.h"
+
+int semanage_fcontext_query(
+	semanage_handle_t* handle,
+	semanage_fcontext_key_t* key,
+	semanage_fcontext_t** response) {
+
+	dbase_config_t* dconfig = semanage_fcontext_dbase_policy(handle);
+	return dbase_query(handle, dconfig, key, response);
+}
+
+int semanage_fcontext_exists(
+	semanage_handle_t* handle,
+	semanage_fcontext_key_t* key,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_fcontext_dbase_policy(handle);
+	return dbase_exists(handle, dconfig, key, response);
+}
+
+int semanage_fcontext_count(
+	semanage_handle_t* handle,
+	unsigned int* response) {
+
+	dbase_config_t* dconfig = semanage_fcontext_dbase_policy(handle);
+	return dbase_count(handle, dconfig, response);
+}
+
+int semanage_fcontext_iterate(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_fcontext_t* record,
+	                void* varg),
+	void* handler_arg) {
+
+	dbase_config_t* dconfig = semanage_fcontext_dbase_policy(handle);
+	return dbase_iterate(handle, dconfig, handler, handler_arg);
+}
+
+int semanage_fcontext_list(
+	semanage_handle_t* handle,
+	semanage_fcontext_t*** records,
+	size_t* count) {
+
+	dbase_config_t* dconfig = semanage_fcontext_dbase_policy(handle);
+	return dbase_list(handle, dconfig, records, count);
+}
diff -Naurp --exclude-from excludes old/libsemanage/src/handle.h new/libsemanage/src/handle.h
--- old/libsemanage/src/handle.h	2005-12-26 19:12:49.000000000 -0500
+++ new/libsemanage/src/handle.h	2006-01-03 05:35:30.000000000 -0500
@@ -77,7 +77,7 @@ struct semanage_handle {
 	struct semanage_policy_table* funcs;
 
 	/* Object databases */
-#define DBASE_COUNT      11
+#define DBASE_COUNT      12
 
 #define DBASE_LOCAL_USERS       0
 #define DBASE_LOCAL_PORTS       1
@@ -90,8 +90,9 @@ struct semanage_handle {
 #define DBASE_POLICY_PORTS      7
 #define DBASE_POLICY_INTERFACES 8
 #define DBASE_POLICY_BOOLEANS   9
+#define DBASE_POLICY_FCONTEXTS  10
 
-#define DBASE_ACTIVE_BOOLEANS   10
+#define DBASE_ACTIVE_BOOLEANS   11
 	dbase_config_t dbase[DBASE_COUNT];
 };
 
@@ -146,6 +147,11 @@ dbase_config_t* semanage_bool_dbase_poli
 }
 
 static inline
+dbase_config_t* semanage_fcontext_dbase_policy(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_POLICY_FCONTEXTS];
+}
+
+static inline
 dbase_config_t* semanage_bool_dbase_active(semanage_handle_t* handle) {
 	return &handle->dbase[DBASE_ACTIVE_BOOLEANS];
 }
diff -Naurp --exclude-from excludes old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2006-01-03 04:25:36.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2006-01-03 06:24:00.000000000 -0500
@@ -72,6 +72,7 @@ static int load_handler(
 	void* varg) {
 
 	record_key_t* rkey = NULL;
+	record_t* rcopy = NULL;
 	load_handler_arg_t* arg = 
 		(load_handler_arg_t*) varg;
 
@@ -82,18 +83,23 @@ static int load_handler(
 
 	if (rtable->key_extract(handle, record, &rkey) < 0)
 		goto err;
+
+	if (rtable->clone(handle, record, &rcopy) < 0)
+		goto err;
  
 	switch (arg->mode) {
 	
 		case MODE_SET:
-			if (dtable->set(handle, dbase, rkey, record) < 0) 
+			if (dtable->set(handle, dbase, rkey, rcopy) < 0) 
 				goto err;
+			rcopy = NULL;
 			break;
 		
 		default:
 		case MODE_MODIFY:
-			if (dtable->modify(handle, dbase, rkey, record) < 0) 
+			if (dtable->modify(handle, dbase, rkey, rcopy) < 0) 
 				goto err;
+			rcopy = NULL;
 			break;
 
 	}
@@ -104,6 +110,7 @@ static int load_handler(
 	err:
 	/* FIXME: handle error */
 	rtable->key_free(rkey);
+	rtable->free(rcopy);
 	return -1;
 }
 
@@ -135,6 +142,9 @@ int semanage_base_merge_components(
 	
 		{ semanage_bool_dbase_local(handle),
 		  semanage_bool_dbase_policy(handle), MODE_SET },
+
+		{ semanage_fcontext_dbase_local(handle),
+		  semanage_fcontext_dbase_policy(handle), MODE_MODIFY },
 	};
 	const int CCOUNT = sizeof(components)/sizeof(components[0]);
 
@@ -184,6 +194,7 @@ int semanage_commit_components(
 		semanage_user_dbase_local(handle),
 		semanage_port_dbase_local(handle),
 		semanage_fcontext_dbase_local(handle),
+		semanage_fcontext_dbase_policy(handle),
 		semanage_seuser_dbase(handle),
 		semanage_bool_dbase_active(handle),
 	};
@@ -200,7 +211,6 @@ int semanage_commit_components(
 	for (i=0; i < CCOUNT; i++)
 		components[i]->dtable->drop_cache(components[i]->dbase);
 
-
 	return STATUS_SUCCESS;
 
 	err:
diff -Naurp --exclude-from excludes old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2006-01-01 06:17:57.000000000 -0500
+++ new/libsemanage/src/semanage_store.c	2006-01-03 05:48:26.000000000 -0500
@@ -1394,8 +1394,15 @@ int semanage_apply_local_changes(
 	semanage_handle_t *sh,
 	sepol_policydb_t* out) {
 
-	int retval;
+	int retval = STATUS_ERR;
+
+	/* Drop any file_context policy cache (from reads), since it 
+	 * was probably changed during expansion */
+	dbase_table_t* fcdtable = semanage_fcontext_dbase_policy(sh)->dtable;
+	dbase_t* fcdbase = semanage_fcontext_dbase_policy(sh)->dbase;
+	fcdtable->drop_cache(fcdbase);
 
+	/* Similarly, attaching the policydb will erase any existing cache */	
 	dbase_policydb_attach(semanage_user_dbase_policy(sh)->dbase, out);
 	dbase_policydb_attach(semanage_port_dbase_policy(sh)->dbase, out);
 	dbase_policydb_attach(semanage_iface_dbase_policy(sh)->dbase, out);
diff -Naurp --exclude-from excludes old/libsemanage/src/semanageswig.i new/libsemanage/src/semanageswig.i
--- old/libsemanage/src/semanageswig.i	2005-12-26 19:12:49.000000000 -0500
+++ new/libsemanage/src/semanageswig.i	2006-01-03 05:38:30.000000000 -0500
@@ -40,6 +40,7 @@
 	#include "semanage/seuser_record.h"
 	#include "semanage/fcontext_record.h"
 	#include "semanage/fcontexts_local.h"
+	#include "semanage/fcontexts_policy.h"
 	#include "semanage/seusers.h"	
 	#include "semanage/semanage.h"
 %}
@@ -303,6 +304,7 @@
 %include "../include/semanage/ports_policy.h"
 %include "../include/semanage/fcontext_record.h"
 %include "../include/semanage/fcontexts_local.h"
+%include "../include/semanage/fcontexts_policy.h"
 %include "../include/semanage/seuser_record.h"
 %include "../include/semanage/seusers.h"
 %include "../include/semanage/semanage.h"

--------------000309040400070901060506--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
