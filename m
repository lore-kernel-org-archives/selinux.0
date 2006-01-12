Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0CCxVXf008656
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 07:59:31 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0CCxTDu022292
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 12:59:29 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id k0CCwbnd010508
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 07:58:37 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id k0CCwbtu010507
	for selinux@tycho.nsa.gov; Thu, 12 Jan 2006 07:58:37 -0500
Message-ID: <43C63F87.1070406@cornell.edu>
Date: Thu, 12 Jan 2006 04:37:43 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Join: User Extra Data (part 2) 
Content-Type: multipart/mixed;
 boundary="------------010203080708070306030903"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010203080708070306030903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

.and here's the last patch, which is pretty large - sorry, but it 
doesn't make much sense to split it up.
This patch adds libsemanage support for managing the labeling prefix 
(although we still need to resolve the issue of how users_extra.system 
will be initialized).

What's going on:
1.
The previous user_record.c is getting renamed to user_base_record.c 
everywhere internally (including the handle dbase).
(this includes renaming files:
    user_record.c -> user_base_record.c
    users_file.c -> users_base_file.c
    users_policydb.c -> users_base_policydb.c)

This is the other part of the join, to complement user_extra_record.c

2. The previous user_record.c now becomes the join record. This means it 
routes all get and set functions to either the base or the extra record. 
It changes the way clone(), create(), free(), compare(), compare2(), 
compare2_qsort(), and key_extract() work. It implements the join() and 
split() functions (note it sets a missing prefix to user by default)

3. A new dbase is created - see users_join.c, and changes to handle.h, 
and direct_api.c to add the join.

4. Users_policy.c and users_local.c relays updated to go to the joined 
dbase. Prefix function added to the user record interface. Prefix added 
to the test interface.

--------------010203080708070306030903
Content-Type: text/x-patch;
 name="libsemanage.diff_users.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.diff_users.diff"

diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/user_record.h new/libsemanage/include/semanage/user_record.h
--- old/libsemanage/include/semanage/user_record.h	2006-01-11 16:23:41.000000000 -0700
+++ new/libsemanage/include/semanage/user_record.h	2006-01-12 02:54:57.000000000 -0700
@@ -6,12 +6,13 @@
 #include <stddef.h>
 #include <semanage/handle.h>
 
-#ifndef _SEMANAGE_USER_DEFINED_
 struct semanage_user;
-struct semanage_user_key;
 typedef struct semanage_user semanage_user_t;
+
+#ifndef _SEMANAGE_USER_KEY_DEFINED_
+struct semanage_user_key;
 typedef struct semanage_user_key semanage_user_key_t;
-#define _SEMANAGE_USER_DEFINED_
+#define _SEMANAGE_USER_KEY_DEFINED_
 #endif
 
 /* Key */
@@ -45,6 +46,15 @@ extern int semanage_user_set_name(
 	semanage_user_t* user, 
 	const char* name);
 
+/* Labeling prefix */
+extern const char* semanage_user_get_prefix(
+	const semanage_user_t* user);
+
+extern int semanage_user_set_prefix(
+	semanage_handle_t* handle,
+	semanage_user_t* user,
+	const char* name);
+
 /* MLS */
 extern const char* semanage_user_get_mlslevel(
 	const semanage_user_t* user);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2006-01-09 22:48:57.000000000 -0700
+++ new/libsemanage/src/direct_api.c	2006-01-12 01:08:37.000000000 -0700
@@ -110,13 +110,20 @@ int semanage_direct_connect(semanage_han
 	sh->funcs = &direct_funcs;
 
         /* Configure object databases */
-	if (user_file_dbase_init(sh, semanage_user_dbase_local(sh)) < 0)
+	if (user_base_file_dbase_init(sh, 
+		semanage_user_base_dbase_local(sh)) < 0)
 		goto err;
 
 	if (user_extra_file_dbase_init(sh, "users_extra.local",
 		semanage_user_extra_dbase_local(sh)) < 0)
 		goto err;
 
+	if (user_join_dbase_init(sh,
+		semanage_user_base_dbase_local(sh),
+		semanage_user_extra_dbase_local(sh),
+		semanage_user_dbase_local(sh)) < 0)
+		goto err;
+
 	if (port_file_dbase_init(sh, semanage_port_dbase_local(sh)) < 0)
 		goto err;
 
@@ -137,13 +144,20 @@ int semanage_direct_connect(semanage_han
 		semanage_user_extra_dbase_system(sh)) < 0)
 		goto err;
 
-	if (user_policydb_dbase_init(sh, semanage_user_dbase_policy(sh)) < 0)
+	if (user_base_policydb_dbase_init(sh, 
+		semanage_user_base_dbase_policy(sh)) < 0)
 		goto err;
 
 	if (user_extra_file_dbase_init(sh, "users_extra", 
 		semanage_user_extra_dbase_policy(sh)) < 0)
 		goto err;
 
+	if (user_join_dbase_init(sh, 
+		semanage_user_base_dbase_policy(sh),
+		semanage_user_extra_dbase_policy(sh),
+		semanage_user_dbase_policy(sh)) < 0)
+		goto err;
+
 	if (port_policydb_dbase_init(sh, semanage_port_dbase_policy(sh)) < 0)
 		goto err;
 
@@ -185,8 +199,9 @@ static int semanage_direct_disconnect(se
 	}
 
 	/* Remove object databases */
-	user_file_dbase_release(semanage_user_dbase_local(sh));
+	user_base_file_dbase_release(semanage_user_base_dbase_local(sh));
 	user_extra_file_dbase_release(semanage_user_extra_dbase_local(sh));
+	user_join_dbase_release(semanage_user_dbase_local(sh));
 	port_file_dbase_release(semanage_port_dbase_local(sh));
 	iface_file_dbase_release(semanage_iface_dbase_local(sh));
 	bool_file_dbase_release(semanage_bool_dbase_local(sh));
@@ -195,8 +210,9 @@ static int semanage_direct_disconnect(se
 
 	user_extra_file_dbase_release(semanage_user_extra_dbase_system(sh));
 
-	user_policydb_dbase_release(semanage_user_dbase_policy(sh));
+	user_base_policydb_dbase_release(semanage_user_base_dbase_policy(sh));
 	user_extra_file_dbase_release(semanage_user_extra_dbase_policy(sh));
+	user_join_dbase_release(semanage_user_dbase_policy(sh));
 	port_policydb_dbase_release(semanage_port_dbase_policy(sh));
 	iface_policydb_dbase_release(semanage_iface_dbase_policy(sh));
 	bool_policydb_dbase_release(semanage_bool_dbase_policy(sh));
@@ -365,19 +381,31 @@ static int semanage_direct_commit(semana
 	int retval = -1, num_modfiles = 0, i;
 	sepol_policydb_t* out = NULL;
 
-	/* Check if anything was changed */
-	int modified = sh->modules_modified;
+	/* Declare some variables */
+	int modified, fcontexts_modified, seusers_modified, users_extra_modified;
 	dbase_config_t* users = semanage_user_dbase_local(sh);
-	dbase_config_t* users_extra = semanage_user_extra_dbase_local(sh);
-	dbase_config_t* ports = semanage_port_dbase_local(sh);
-	dbase_config_t* bools = semanage_bool_dbase_local(sh);
-	dbase_config_t* ifaces = semanage_iface_dbase_local(sh);
-	dbase_config_t* fcontexts = semanage_fcontext_dbase_local(sh);
-	dbase_config_t* seusers = semanage_seuser_dbase(sh);
-	int fcontexts_modified = fcontexts->dtable->is_modified(fcontexts->dbase);
-	int seusers_modified = seusers->dtable->is_modified(seusers->dbase);
-	int users_extra_modified = users_extra->dtable->is_modified(users_extra->dbase);
-	modified |= users->dtable->is_modified(users->dbase);
+        dbase_config_t* users_base = semanage_user_base_dbase_local(sh);
+        dbase_config_t* users_extra = semanage_user_extra_dbase_local(sh);
+        dbase_config_t* ports = semanage_port_dbase_local(sh);
+        dbase_config_t* bools = semanage_bool_dbase_local(sh);
+        dbase_config_t* ifaces = semanage_iface_dbase_local(sh);
+        dbase_config_t* fcontexts = semanage_fcontext_dbase_local(sh);
+        dbase_config_t* seusers = semanage_seuser_dbase(sh);
+
+	/* Before we do anything else, flush the join to its component parts.
+	 * This *does not* flush to disk automatically */
+	users = semanage_user_dbase_local(sh);
+	if (users->dtable->is_modified(users->dbase) &&
+	    users->dtable->flush(sh, users->dbase) < 0)
+		goto cleanup;
+
+	/* Decide if anything was modified */
+	fcontexts_modified = fcontexts->dtable->is_modified(fcontexts->dbase);
+	seusers_modified = seusers->dtable->is_modified(seusers->dbase);
+	users_extra_modified = users_extra->dtable->is_modified(users_extra->dbase);
+
+	modified = sh->modules_modified;
+	modified |= users->dtable->is_modified(users_base->dbase);
 	modified |= ports->dtable->is_modified(ports->dbase);
 	modified |= bools->dtable->is_modified(bools->dbase);
 	modified |= ifaces->dtable->is_modified(ifaces->dbase);
@@ -422,7 +450,7 @@ static int semanage_direct_commit(semana
 
 		if (semanage_apply_local_changes(sh, out) < 0)
 			goto cleanup;
-	
+
 		if (semanage_write_policydb(sh, out) < 0)
 			goto cleanup;
 
@@ -447,7 +475,7 @@ static int semanage_direct_commit(semana
 	 * if either policy changed, or seusers changed,
 	 * or we forced a rebuild */
 	if (sh->do_rebuild || modified || seusers_modified) {
-		if (semanage_seuser_validate(sh, out) < 0)
+		if (semanage_seuser_validate(sh, out) < 0) 
 			goto cleanup;
 	}
 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/handle.h new/libsemanage/src/handle.h
--- old/libsemanage/src/handle.h	2006-01-09 22:41:55.000000000 -0700
+++ new/libsemanage/src/handle.h	2006-01-11 19:08:29.000000000 -0700
@@ -77,36 +77,38 @@ struct semanage_handle {
 	struct semanage_policy_table* funcs;
 
 	/* Object databases */
-#define DBASE_COUNT      15
+#define DBASE_COUNT      17
 
 /* Local modifications */
-#define DBASE_LOCAL_USERS       0
+#define DBASE_LOCAL_USERS_BASE  0
 #define DBASE_LOCAL_USERS_EXTRA 1
-#define DBASE_LOCAL_PORTS       2
-#define DBASE_LOCAL_INTERFACES  3
-#define DBASE_LOCAL_BOOLEANS    4
-#define DBASE_LOCAL_FCONTEXTS	5
-#define DBASE_SEUSERS           6
+#define DBASE_LOCAL_USERS       2
+#define DBASE_LOCAL_PORTS       3
+#define DBASE_LOCAL_INTERFACES  4
+#define DBASE_LOCAL_BOOLEANS    5
+#define DBASE_LOCAL_FCONTEXTS	6
+#define DBASE_SEUSERS           7
 
 /* Policy */
-#define DBASE_SYSTEM_USERS_EXTRA 7
+#define DBASE_SYSTEM_USERS_EXTRA 8
 
 /* Policy + Local modifications */
-#define DBASE_POLICY_USERS       8
-#define DBASE_POLICY_USERS_EXTRA 9
-#define DBASE_POLICY_PORTS       10
-#define DBASE_POLICY_INTERFACES  11
-#define DBASE_POLICY_BOOLEANS    12
-#define DBASE_POLICY_FCONTEXTS   13
+#define DBASE_POLICY_USERS_BASE  9
+#define DBASE_POLICY_USERS_EXTRA 10
+#define DBASE_POLICY_USERS       11
+#define DBASE_POLICY_PORTS       12
+#define DBASE_POLICY_INTERFACES  13
+#define DBASE_POLICY_BOOLEANS    14
+#define DBASE_POLICY_FCONTEXTS   15
 
 /* Active kernel policy */
-#define DBASE_ACTIVE_BOOLEANS    14
+#define DBASE_ACTIVE_BOOLEANS    16
 	dbase_config_t dbase[DBASE_COUNT];
 };
 
 static inline
-dbase_config_t* semanage_user_dbase_local(semanage_handle_t* handle) {
-	return &handle->dbase[DBASE_LOCAL_USERS];
+dbase_config_t* semanage_user_base_dbase_local(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_LOCAL_USERS_BASE];
 }
 
 static inline
@@ -115,6 +117,11 @@ dbase_config_t* semanage_user_extra_dbas
 }
 
 static inline 
+dbase_config_t* semanage_user_dbase_local(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_LOCAL_USERS];
+}
+
+static inline 
 dbase_config_t* semanage_port_dbase_local(semanage_handle_t* handle) {
 	return &handle->dbase[DBASE_LOCAL_PORTS];
 }
@@ -145,8 +152,8 @@ dbase_config_t* semanage_user_extra_dbas
 }
 
 static inline
-dbase_config_t* semanage_user_dbase_policy(semanage_handle_t* handle) {
-	return &handle->dbase[DBASE_POLICY_USERS];
+dbase_config_t* semanage_user_base_dbase_policy(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_POLICY_USERS_BASE];
 }
 
 static inline
@@ -155,6 +162,11 @@ dbase_config_t* semanage_user_extra_dbas
 }
 
 static inline
+dbase_config_t* semanage_user_dbase_policy(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_POLICY_USERS];
+}
+
+static inline
 dbase_config_t* semanage_port_dbase_policy(semanage_handle_t* handle) {
 	return &handle->dbase[DBASE_POLICY_PORTS];
 }
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2006-01-09 22:41:55.000000000 -0700
+++ new/libsemanage/src/policy_components.c	2006-01-12 00:00:46.000000000 -0700
@@ -128,8 +128,8 @@ int semanage_base_merge_components(
 	 * mutual dependencies are ran after everything is merged */
 	load_table_t components[] = {
 
-		{ semanage_user_dbase_local(handle),
-		  semanage_user_dbase_policy(handle), MODE_MODIFY },
+		{ semanage_user_base_dbase_local(handle),
+		  semanage_user_base_dbase_policy(handle), MODE_MODIFY },
 
 		{ semanage_user_extra_dbase_system(handle),
 		  semanage_user_extra_dbase_policy(handle), MODE_MODIFY },
@@ -193,7 +193,7 @@ int semanage_commit_components(
 	dbase_config_t* components[] = {
 		semanage_iface_dbase_local(handle),
 		semanage_bool_dbase_local(handle),
-		semanage_user_dbase_local(handle),
+		semanage_user_base_dbase_local(handle),
 		semanage_user_extra_dbase_local(handle),
 		semanage_user_extra_dbase_policy(handle),
 		semanage_port_dbase_local(handle),
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/pywrap-test.py new/libsemanage/src/pywrap-test.py
--- old/libsemanage/src/pywrap-test.py	2006-01-09 15:58:45.000000000 -0700
+++ new/libsemanage/src/pywrap-test.py	2006-01-12 02:53:48.000000000 -0700
@@ -156,6 +156,7 @@ class Tests:
 			user = semanage.semanage_user_by_idx(list, idx)
 			if self.verbose: print "User reference: ", user 
 			print "User name: ", semanage.semanage_user_get_name(user)
+			print "   User labeling prefix: ", semanage.semanage_user_get_prefix(user)
 			print "   User mls level: ", semanage.semanage_user_get_mlslevel(user)
 			print "   User mls range: ", semanage.semanage_user_get_mlsrange(user)
 			print "   User number of roles: ", semanage.semanage_user_get_num_roles(user)
@@ -287,8 +288,11 @@ class Tests:
 		status = semanage.semanage_user_set_name(sh,user, "testPyUser")
                	if self.verbose: print "User name set: ", semanage.semanage_user_get_name(user)
                 
-		status = semanage.semanage_user_add_role(sh, user, "user_r")
-		
+		status = semanage.semanage_user_add_role(sh, user, "user_r")	
+
+		status = semanage.semanage_user_set_prefix(sh,user, "user")
+		if self.verbose: print "User prefix set: ", semanage.semanage_user_get_prefix(user)
+	
 		status = semanage.semanage_user_set_mlsrange(sh, user, "s0")
                 if self.verbose: print "User mlsrange: ", semanage.semanage_user_get_mlsrange(user)
 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2006-01-11 16:27:43.000000000 -0700
+++ new/libsemanage/src/semanage_store.c	2006-01-11 17:11:26.000000000 -0700
@@ -1400,14 +1400,14 @@ int semanage_apply_local_changes(
 	fcdtable->drop_cache(fcdbase);
 
 	/* Similarly, attaching the policydb will erase any existing cache */	
-	dbase_policydb_attach(semanage_user_dbase_policy(sh)->dbase, out);
+	dbase_policydb_attach(semanage_user_base_dbase_policy(sh)->dbase, out);
 	dbase_policydb_attach(semanage_port_dbase_policy(sh)->dbase, out);
 	dbase_policydb_attach(semanage_iface_dbase_policy(sh)->dbase, out);
 	dbase_policydb_attach(semanage_bool_dbase_policy(sh)->dbase, out);
 
 	retval = semanage_base_merge_components(sh);
 
-	dbase_policydb_detach(semanage_user_dbase_policy(sh)->dbase);
+	dbase_policydb_detach(semanage_user_base_dbase_policy(sh)->dbase);
         dbase_policydb_detach(semanage_port_dbase_policy(sh)->dbase);
         dbase_policydb_detach(semanage_iface_dbase_policy(sh)->dbase);
         dbase_policydb_detach(semanage_bool_dbase_policy(sh)->dbase);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/user_base_record.c new/libsemanage/src/user_base_record.c
--- old/libsemanage/src/user_base_record.c	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/src/user_base_record.c	2006-01-12 02:33:00.000000000 -0700
@@ -0,0 +1,181 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+/* Object: semanage_user_base_t (SELinux User/Class Policy Object)
+ * Object: semanage_user_key_t (SELinux User/Class Key)
+ * Implements: record_t (Database Record)
+ * Implements: record_key_t (Database Record Key)
+ */
+
+#include <sepol/user_record.h>
+
+typedef sepol_user_key_t semanage_user_key_t;
+#define _SEMANAGE_USER_KEY_DEFINED_
+
+typedef sepol_user_t semanage_user_base_t;
+#define _SEMANAGE_USER_BASE_DEFINED_
+
+typedef semanage_user_base_t record_t;
+typedef semanage_user_key_t record_key_t;
+#define DBASE_RECORD_DEFINED
+
+#include <stdlib.h>
+#include <stddef.h>
+#include "user_internal.h"
+#include "handle.h"
+#include "database.h"
+#include "debug.h"
+
+/* Key */
+hidden int semanage_user_base_key_extract(
+	semanage_handle_t* handle,
+	const semanage_user_base_t* user, 
+	semanage_user_key_t** key) {
+
+	return sepol_user_key_extract(handle->sepolh, user, key); 
+}
+
+static int semanage_user_base_compare(
+	const semanage_user_base_t* user, 
+	const semanage_user_key_t* key) {
+
+	return sepol_user_compare(user, key);
+}
+
+static int semanage_user_base_compare2(
+	const semanage_user_base_t* user,
+	const semanage_user_base_t* user2) {
+
+	return sepol_user_compare2(user, user2);
+}
+
+static int semanage_user_base_compare2_qsort(
+	const semanage_user_base_t** user,
+	const semanage_user_base_t** user2) {
+
+	return sepol_user_compare2(*user, *user2);
+}
+	
+/* Name */
+hidden const char* semanage_user_base_get_name(
+	const semanage_user_base_t* user) {
+
+	return sepol_user_get_name(user);
+}
+
+hidden int semanage_user_base_set_name(
+	semanage_handle_t* handle,
+	semanage_user_base_t* user, 
+	const char* name) {
+
+	return sepol_user_set_name(handle->sepolh, user, name);
+}
+
+/* MLS */
+hidden const char* semanage_user_base_get_mlslevel(
+	const semanage_user_base_t* user) {
+
+	return sepol_user_get_mlslevel(user);
+}
+
+hidden int semanage_user_base_set_mlslevel(
+	semanage_handle_t* handle,
+	semanage_user_base_t* user, 
+	const char* mls_level) {
+
+	return sepol_user_set_mlslevel(handle->sepolh, user, mls_level);
+}
+
+hidden const char* semanage_user_base_get_mlsrange(
+	const semanage_user_base_t* user) {
+
+	return sepol_user_get_mlsrange(user);
+}
+
+hidden int semanage_user_base_set_mlsrange(
+	semanage_handle_t* handle,
+	semanage_user_base_t* user, 
+	const char* mls_range) {
+
+	return sepol_user_set_mlsrange(handle->sepolh, user, mls_range);
+}
+
+/* Role management */
+hidden int semanage_user_base_get_num_roles(
+	const semanage_user_base_t* user) {
+
+	return sepol_user_get_num_roles(user);
+}
+
+hidden int semanage_user_base_add_role(
+	semanage_handle_t* handle,
+	semanage_user_base_t* user, 
+	const char* role) {
+
+	return sepol_user_add_role(handle->sepolh, user, role);
+}
+
+hidden void semanage_user_base_del_role(
+	semanage_user_base_t* user, 
+	const char* role) {
+
+	sepol_user_del_role(user, role);
+}
+
+hidden int semanage_user_base_has_role(
+	const semanage_user_base_t* user, 
+	const char* role) {
+
+	return sepol_user_has_role(user, role);
+}
+
+hidden int semanage_user_base_get_roles(
+	semanage_handle_t* handle,
+	const semanage_user_base_t* user,
+	const char*** roles_arr, 
+	size_t* num_roles) {
+
+	return sepol_user_get_roles(handle->sepolh, user, roles_arr, num_roles);
+}
+
+hidden int semanage_user_base_set_roles(
+	semanage_handle_t* handle,
+	semanage_user_base_t* user,
+	const char** roles_arr,
+	size_t num_roles) {
+
+	return sepol_user_set_roles(handle->sepolh, user, roles_arr, num_roles);
+}
+
+/* Create/Clone/Destroy */
+hidden int semanage_user_base_create(
+	semanage_handle_t* handle,
+	semanage_user_base_t** user_ptr) {
+
+	return sepol_user_create(handle->sepolh, user_ptr);
+}
+
+hidden int semanage_user_base_clone(
+	semanage_handle_t* handle,
+	const semanage_user_base_t* user, 
+	semanage_user_base_t** user_ptr) {
+
+	return sepol_user_clone(handle->sepolh, user, user_ptr);
+}
+
+hidden void semanage_user_base_free(
+	semanage_user_base_t* user) {
+
+	sepol_user_free(user);
+}
+
+/* Record base functions */
+record_table_t SEMANAGE_USER_BASE_RTABLE = {
+	.create      = semanage_user_base_create,
+	.key_extract = semanage_user_base_key_extract,
+	.key_free    = semanage_user_key_free,
+	.clone       = semanage_user_base_clone,
+	.compare     = semanage_user_base_compare,
+	.compare2    = semanage_user_base_compare2,
+	.compare2_qsort = semanage_user_base_compare2_qsort,
+	.free        = semanage_user_base_free,
+};
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/user_extra_record.c new/libsemanage/src/user_extra_record.c
--- old/libsemanage/src/user_extra_record.c	2006-01-12 03:47:32.000000000 -0700
+++ new/libsemanage/src/user_extra_record.c	2006-01-12 03:25:24.000000000 -0700
@@ -6,10 +6,14 @@
  * Implements: record_key_t (Database Record Key)
  */
 
+#include <sepol/user_record.h>
+
+typedef sepol_user_key_t semanage_user_key_t;
+#define _SEMANAGE_USER_KEY_DEFINED_
+
 struct semanage_user_extra;
-struct semanage_user_extra_key;
 typedef struct semanage_user_extra record_t;
-typedef struct semanage_user_key record_key_t;
+typedef semanage_user_key_t record_key_t;
 #define DBASE_RECORD_DEFINED
 
 #include <semanage/handle.h>
@@ -48,6 +52,7 @@ static int semanage_user_extra_compare(
 
 	const char* name;
 	semanage_user_key_unpack(key, &name);
+
 	return strcmp(user_extra->name, name);	
 }
 
@@ -112,7 +117,7 @@ hidden int semanage_user_extra_set_prefi
 }
 
 /* Create */
-static int semanage_user_extra_create(
+hidden int semanage_user_extra_create(
 	semanage_handle_t* handle,
 	semanage_user_extra_t** user_extra_ptr) {
 
@@ -133,7 +138,7 @@ static int semanage_user_extra_create(
 }
 
 /* Destroy */
-static void semanage_user_extra_free(
+hidden void semanage_user_extra_free(
 	semanage_user_extra_t* user_extra) {
 
 	if (!user_extra)
@@ -145,7 +150,7 @@ static void semanage_user_extra_free(
 }
 
 /* Deep copy clone */
-static int semanage_user_extra_clone(
+hidden int semanage_user_extra_clone(
 	semanage_handle_t* handle,
 	const semanage_user_extra_t* user_extra, 
 	semanage_user_extra_t** user_extra_ptr) {
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/user_internal.h new/libsemanage/src/user_internal.h
--- old/libsemanage/src/user_internal.h	2006-01-09 22:41:55.000000000 -0700
+++ new/libsemanage/src/user_internal.h	2006-01-12 02:12:30.000000000 -0700
@@ -1,6 +1,7 @@
 #ifndef _SEMANAGE_USER_INTERNAL_H_
 #define _SEMANAGE_USER_INTERNAL_H_
 
+#include <sepol/user_record.h>
 #include <semanage/user_record.h>
 #include <semanage/users_local.h>
 #include <semanage/users_policy.h>
@@ -30,15 +31,20 @@ hidden_proto(semanage_user_query)
 /* USER record: metod table */
 extern record_table_t SEMANAGE_USER_RTABLE;
 
+/* USER BASE record: method table */
+extern record_table_t SEMANAGE_USER_BASE_RTABLE;
+
 /* USER EXTRA record: method table */
 extern record_table_t SEMANAGE_USER_EXTRA_RTABLE;
 
-/* USER record, FILE backend */
-extern int user_file_dbase_init(
+/* ============ Init/Release functions ========== */
+
+/* USER BASE record, FILE backend */
+extern int user_base_file_dbase_init(
 	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
 
-extern void user_file_dbase_release(
+extern void user_base_file_dbase_release(
 	dbase_config_t* dconfig);
 
 /* USER EXTRA record, FILE backend */
@@ -50,22 +56,113 @@ extern int user_extra_file_dbase_init(
 extern void user_extra_file_dbase_release(
 	dbase_config_t* dconfig);
 
-/* USER record, POLICYDB backend */
-extern int user_policydb_dbase_init(
+/* USER BASE record, POLICYDB backend */
+extern int user_base_policydb_dbase_init(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+extern void user_base_policydb_dbase_release(
+	dbase_config_t* dconfig);
+
+/* USER record, JOIN backend */
+extern int user_join_dbase_init(
 	semanage_handle_t* handle,
+	dbase_config_t* join1,
+	dbase_config_t* join2,
 	dbase_config_t* dconfig);
 
-extern void user_policydb_dbase_release(
+extern void user_join_dbase_release(
 	dbase_config_t* dconfig);
 
-/* Internal use */
+/*======= Internal API: Base (Policy) User record ====== */
+
+#ifndef _SEMANAGE_USER_BASE_DEFINED_
+struct semanage_user_base;
+typedef struct semanage_user_base semanage_user_base_t;
+#define _SEMANAGE_USER_BASE_DEFINED_
+#endif
+
+hidden int semanage_user_base_create(
+	semanage_handle_t* handle,
+	semanage_user_base_t** user_ptr);
+
+hidden int semanage_user_base_clone(
+	semanage_handle_t* handle,
+	const semanage_user_base_t* user,
+	semanage_user_base_t** user_ptr);
+
+hidden int semanage_user_base_key_extract(
+	semanage_handle_t* handle,
+	const semanage_user_base_t* user,
+	semanage_user_key_t** key);
+
+hidden const char* semanage_user_base_get_name(
+	const semanage_user_base_t* user);
+
+hidden int semanage_user_base_set_name(
+	semanage_handle_t* handle,
+	semanage_user_base_t* user,
+	const char* name);
+
+hidden const char* semanage_user_base_get_mlslevel(
+	const semanage_user_base_t* user);
+
+hidden int semanage_user_base_set_mlslevel(
+	semanage_handle_t* handle,
+	semanage_user_base_t* user,
+	const char* mls_level);
+
+hidden const char* semanage_user_base_get_mlsrange(
+	const semanage_user_base_t* user);
 
+hidden int semanage_user_base_set_mlsrange(
+	semanage_handle_t* handle,
+	semanage_user_base_t* user,
+	const char* mls_range);
+
+hidden int semanage_user_base_get_num_roles(
+	const semanage_user_base_t* user);
+
+hidden int semanage_user_base_add_role(
+	semanage_handle_t* handle,
+	semanage_user_base_t* user,
+	const char* role);
+
+hidden void semanage_user_base_del_role(
+	semanage_user_base_t* user,
+	const char* role);
+
+hidden int semanage_user_base_has_role(
+	const semanage_user_base_t* user,
+	const char* role);
+
+hidden int semanage_user_base_get_roles(
+	semanage_handle_t* handle,
+	const semanage_user_base_t* user,
+	const char*** roles_arr,
+	size_t* num_roles);
+
+hidden int semanage_user_base_set_roles(
+	semanage_handle_t* handle,
+	semanage_user_base_t* user,
+	const char** roles_arr,
+	size_t num_roles);
+
+hidden void semanage_user_base_free(
+	semanage_user_base_t* user);
+
+/*=========== Internal API: Extra User record ==========*/
 struct semanage_user_extra;
 typedef struct semanage_user_extra semanage_user_extra_t;
 
-hidden void semanage_user_key_unpack(
-	const semanage_user_key_t* key,
-	const char** name);
+hidden int semanage_user_extra_create(
+	semanage_handle_t* handle,
+	semanage_user_extra_t** user_extra_ptr);
+
+hidden int semanage_user_extra_clone(
+	semanage_handle_t* handle,
+	const semanage_user_extra_t* user_extra,
+	semanage_user_extra_t** user_extra_ptr);
 
 hidden const char* semanage_user_extra_get_name(
 	const semanage_user_extra_t* user_extra);
@@ -83,4 +180,25 @@ hidden int semanage_user_extra_set_prefi
 	semanage_user_extra_t* user_extra,
 	const char* prefix);
 
+hidden void semanage_user_extra_free(
+	semanage_user_extra_t* user_extra);
+
+/*======== Internal API: Join record ========== */
+hidden void semanage_user_key_unpack(
+        const semanage_user_key_t* key,
+        const char** name);
+
+hidden int semanage_user_join(
+	semanage_handle_t* handle,
+	const semanage_user_base_t* record1,
+	const semanage_user_extra_t* record2,
+	semanage_user_t** result);
+
+hidden int semanage_user_split(
+	semanage_handle_t* handle,
+	const semanage_user_t* record,
+	semanage_user_base_t** split1,
+	semanage_user_extra_t** split2);
+
+
 #endif
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/user_record.c new/libsemanage/src/user_record.c
--- old/libsemanage/src/user_record.c	2006-01-12 03:47:32.000000000 -0700
+++ new/libsemanage/src/user_record.c	2006-01-12 03:23:37.000000000 -0700
@@ -8,11 +8,11 @@
 
 #include <sepol/user_record.h>
 
-typedef sepol_user_t semanage_user_t;
 typedef sepol_user_key_t semanage_user_key_t;
-#define _SEMANAGE_USER_DEFINED_
+#define _SEMANAGE_USER_KEY_DEFINED_
 
-typedef semanage_user_t record_t;
+struct semanage_user;
+typedef struct semanage_user record_t;
 typedef semanage_user_key_t record_key_t;
 #define DBASE_RECORD_DEFINED
 
@@ -23,6 +23,12 @@ typedef semanage_user_key_t record_key_t
 #include "database.h"
 #include "debug.h"
 
+struct semanage_user {
+	char* name;
+	semanage_user_base_t* base;
+	semanage_user_extra_t* extra;
+};
+
 /* Key */
 int semanage_user_key_create(
 	semanage_handle_t* handle,
@@ -38,7 +44,7 @@ int semanage_user_key_extract(
 	const semanage_user_t* user, 
 	semanage_user_key_t** key) {
 
-	return sepol_user_key_extract(handle->sepolh, user, key);
+	return semanage_user_base_key_extract(handle, user->base, key);
 }
 hidden_def(semanage_user_key_extract)
 
@@ -60,7 +66,9 @@ int semanage_user_compare(
 	const semanage_user_t* user, 
 	const semanage_user_key_t* key) {
 
-	return sepol_user_compare(user, key);
+	const char* name;
+	sepol_user_key_unpack(key, &name);
+	return strcmp(user->name, name);
 }
 hidden_def(semanage_user_compare)
 
@@ -68,7 +76,7 @@ int semanage_user_compare2(
 	const semanage_user_t* user,
 	const semanage_user_t* user2) {
 
-	return sepol_user_compare2(user, user2);
+	return strcmp(user->name, user2->name);
 }
 hidden_def(semanage_user_compare2)
 
@@ -76,14 +84,13 @@ static int semanage_user_compare2_qsort(
 	const semanage_user_t** user,
 	const semanage_user_t** user2) {
 
-	return sepol_user_compare2(*user, *user2);
+	return strcmp((*user)->name, (*user2)->name);
 }
 	
 /* Name */
 const char* semanage_user_get_name(
 	const semanage_user_t* user) {
-
-	return sepol_user_get_name(user);
+	return user->name;
 }
 hidden_def(semanage_user_get_name)
 
@@ -92,15 +99,50 @@ int semanage_user_set_name(
 	semanage_user_t* user, 
 	const char* name) {
 
-	return sepol_user_set_name(handle->sepolh, user, name);
+        char* tmp_name = strdup(name);
+        if (!tmp_name)
+		goto omem;
+
+	if (semanage_user_base_set_name(handle, user->base, name) < 0)
+		goto err;
+
+	if (semanage_user_extra_set_name(handle, user->extra, name) < 0)
+		goto err;
+
+	free(user->name);
+	user->name = tmp_name;
+	return STATUS_SUCCESS;
+
+	omem:
+	ERR(handle, "out of memory");
+
+	err:
+	ERR(handle, "could not set user name to %s", name);
+	free(tmp_name);
+	return STATUS_ERR;
 }
 hidden_def(semanage_user_set_name)
 
+/* Labeling prefix */
+const char* semanage_user_get_prefix(
+	const semanage_user_t* user) {
+
+	return semanage_user_extra_get_prefix(user->extra);
+}
+
+int semanage_user_set_prefix(
+	semanage_handle_t* handle,
+	semanage_user_t* user,
+	const char* name) {
+
+	return semanage_user_extra_set_prefix(handle, user->extra, name);
+}
+
 /* MLS */
 const char* semanage_user_get_mlslevel(
 	const semanage_user_t* user) {
 
-	return sepol_user_get_mlslevel(user);
+	return semanage_user_base_get_mlslevel(user->base);
 }
 hidden_def(semanage_user_get_mlslevel)
 
@@ -109,14 +151,14 @@ int semanage_user_set_mlslevel(
 	semanage_user_t* user, 
 	const char* mls_level) {
 
-	return sepol_user_set_mlslevel(handle->sepolh, user, mls_level);
+	return semanage_user_base_set_mlslevel(handle, user->base, mls_level);
 }
 hidden_def(semanage_user_set_mlslevel)
 
 const char* semanage_user_get_mlsrange(
 	const semanage_user_t* user) {
 
-	return sepol_user_get_mlsrange(user);
+	return semanage_user_base_get_mlsrange(user->base);
 }
 hidden_def(semanage_user_get_mlsrange)
 
@@ -125,7 +167,7 @@ int semanage_user_set_mlsrange(
 	semanage_user_t* user, 
 	const char* mls_range) {
 
-	return sepol_user_set_mlsrange(handle->sepolh, user, mls_range);
+	return semanage_user_base_set_mlsrange(handle, user->base, mls_range);
 }
 hidden_def(semanage_user_set_mlsrange)
 
@@ -133,7 +175,7 @@ hidden_def(semanage_user_set_mlsrange)
 int semanage_user_get_num_roles(
 	const semanage_user_t* user) {
 
-	return sepol_user_get_num_roles(user);
+	return semanage_user_base_get_num_roles(user->base);
 }
 
 int semanage_user_add_role(
@@ -141,7 +183,7 @@ int semanage_user_add_role(
 	semanage_user_t* user, 
 	const char* role) {
 
-	return sepol_user_add_role(handle->sepolh, user, role);
+	return semanage_user_base_add_role(handle, user->base, role);
 }
 hidden_def(semanage_user_add_role)
 
@@ -149,14 +191,14 @@ void semanage_user_del_role(
 	semanage_user_t* user, 
 	const char* role) {
 
-	sepol_user_del_role(user, role);
+	semanage_user_base_del_role(user->base, role);
 }
 
 int semanage_user_has_role(
 	const semanage_user_t* user, 
 	const char* role) {
 
-	return sepol_user_has_role(user, role);
+	return semanage_user_base_has_role(user->base, role);
 }
 
 int semanage_user_get_roles(
@@ -165,7 +207,7 @@ int semanage_user_get_roles(
 	const char*** roles_arr, 
 	unsigned int* num_roles) {
 
-	return sepol_user_get_roles(handle->sepolh, user, roles_arr, num_roles);
+	return semanage_user_base_get_roles(handle, user->base, roles_arr, num_roles);
 }
 hidden_def(semanage_user_get_roles)
 
@@ -175,7 +217,7 @@ int semanage_user_set_roles(
 	const char** roles_arr,
 	unsigned int num_roles) {
 
-	return sepol_user_set_roles(handle->sepolh, user, roles_arr, num_roles);
+	return semanage_user_base_set_roles(handle, user->base, roles_arr, num_roles);
 }
 
 /* Create/Clone/Destroy */
@@ -183,7 +225,29 @@ int semanage_user_create(
 	semanage_handle_t* handle,
 	semanage_user_t** user_ptr) {
 
-	return sepol_user_create(handle->sepolh, user_ptr);
+	semanage_user_t* tmp_user = calloc(1, sizeof(semanage_user_t));
+	if (!tmp_user)
+		goto omem;
+
+	if (semanage_user_base_create(handle, &tmp_user->base) < 0)
+		goto err;
+	if (semanage_user_extra_create(handle, &tmp_user->extra) < 0)
+		goto err;
+
+	/* Initialize the prefix for migration purposes */
+	if (semanage_user_extra_set_prefix(handle, tmp_user->extra, "user") < 0)
+		goto err;
+
+	*user_ptr = tmp_user;
+	return STATUS_SUCCESS;
+
+	omem:
+	ERR(handle, "out of memory");
+
+	err:
+	ERR(handle, "could not create user record");
+	semanage_user_free(tmp_user);
+	return STATUS_ERR;
 }
 hidden_def(semanage_user_create)
 
@@ -192,17 +256,133 @@ int semanage_user_clone(
 	const semanage_user_t* user, 
 	semanage_user_t** user_ptr) {
 
-	return sepol_user_clone(handle->sepolh, user, user_ptr);
+	semanage_user_t* tmp_user = calloc(1, sizeof(semanage_user_t));
+	if (!tmp_user)
+		goto omem;
+
+	/* Clone base and extra records */
+	if (semanage_user_base_clone(handle, user->base, &tmp_user->base) < 0)
+		goto err;
+	if (semanage_user_extra_clone(handle, user->extra, &tmp_user->extra) < 0)
+		goto err;
+
+	/* Set the shared name */
+	if (semanage_user_set_name(handle, tmp_user, user->name) < 0)
+		goto err;
+
+	*user_ptr = tmp_user;
+	return STATUS_SUCCESS;
+
+	omem:
+	ERR(handle, "out of memory");
+
+	err:
+	ERR(handle, "could not clone user record");
+	semanage_user_free(tmp_user);
+	return STATUS_ERR;
 }
 hidden_def(semanage_user_clone)
 
 void semanage_user_free(
 	semanage_user_t* user) {
 
-	sepol_user_free(user);
+	if (!user)
+		return;
+
+	semanage_user_base_free(user->base);
+	semanage_user_extra_free(user->extra);
+	free(user->name);
+	free(user);
 }
 hidden_def(semanage_user_free)
 
+/* Join properties */
+hidden int semanage_user_join(
+	semanage_handle_t* handle,
+	const semanage_user_base_t* record1,
+	const semanage_user_extra_t* record2,
+	semanage_user_t** result) {
+
+	const char* name;
+	semanage_user_t* tmp_user = calloc(1, sizeof(semanage_user_t));
+	if (!tmp_user)
+		goto omem;
+
+	/* Set the shared name from one of the records 
+	 * (at least one is available) */
+	if (record1 == NULL)
+		name = semanage_user_extra_get_name(record2);
+	else
+		name = semanage_user_base_get_name(record1);
+
+	/* Join base record if it exists, create a blank one otherwise */
+	if (record1) {
+		if (semanage_user_base_clone(handle, record1, &tmp_user->base) < 0)
+			goto err;
+	} else {
+		if (semanage_user_base_create(handle, &tmp_user->base) < 0)
+			goto err;
+		if (semanage_user_base_set_name(handle, tmp_user->base, name) < 0)
+			goto err;
+	}
+
+	/* Join extra record if it exists, create a blank one otherwise */
+	if (record2) {
+		if (semanage_user_extra_clone(handle, record2, &tmp_user->extra) < 0)
+			goto err;
+	} else {
+		if (semanage_user_extra_create(handle, &tmp_user->extra) < 0)
+			goto err;
+		if (semanage_user_extra_set_name(handle, tmp_user->extra, name) < 0)
+			goto err;
+		if (semanage_user_extra_set_prefix(handle, tmp_user->extra, "user") < 0)
+			goto err;
+        }
+
+	if (semanage_user_set_name(handle, tmp_user, name) < 0)
+		goto err;
+
+	*result = tmp_user;
+	return STATUS_SUCCESS;
+
+	omem:
+	ERR(handle, "out of memory");
+
+	err:
+	ERR(handle, "could not join data records for user %s", 
+		semanage_user_base_get_name(record1));
+	semanage_user_free(tmp_user);
+	return STATUS_ERR;
+}
+
+hidden int semanage_user_split(
+	semanage_handle_t* handle,
+	const semanage_user_t* record,
+	semanage_user_base_t** split1,
+	semanage_user_extra_t** split2) {
+
+	semanage_user_base_t* tmp_base_user = NULL;
+	semanage_user_extra_t* tmp_extra_user = NULL;
+
+	if (semanage_user_base_clone(handle, record->base, &tmp_base_user) < 0)
+		goto err;
+
+	if (semanage_user_extra_clone(handle, record->extra, &tmp_extra_user) < 0)
+		goto err;
+
+	*split1 = tmp_base_user;
+	*split2 = tmp_extra_user;
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not split data records for user %s",
+		semanage_user_get_name(record));
+	semanage_user_base_free(tmp_base_user);
+	semanage_user_extra_free(tmp_extra_user);
+	return STATUS_ERR;
+}
+
+
 /* Record base functions */
 record_table_t SEMANAGE_USER_RTABLE = {
 	.create      = semanage_user_create,
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/users_base_file.c new/libsemanage/src/users_base_file.c
--- old/libsemanage/src/users_base_file.c	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/src/users_base_file.c	2006-01-11 17:10:41.000000000 -0700
@@ -0,0 +1,228 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+struct semanage_user_base;
+struct semanage_user_key;
+typedef struct semanage_user_base record_t;
+typedef struct semanage_user_key record_key_t;
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
+#include <semanage/handle.h>
+#include "user_internal.h"
+#include "database_file.h"
+#include "parse_utils.h"
+#include "debug.h"
+
+static int user_base_print(
+	semanage_handle_t* handle,
+	semanage_user_base_t* user, 
+	FILE* str) {
+
+	const char** roles = NULL;
+	unsigned int i, nroles;
+
+	const char* name      = semanage_user_base_get_name(user);
+	const char* mls_level = semanage_user_base_get_mlslevel(user);
+	const char* mls_range = semanage_user_base_get_mlsrange(user);
+
+	if (fprintf(str, "user %s roles { ", name) < 0)
+		goto err;
+
+	if (semanage_user_base_get_roles(handle, user, &roles, &nroles) < 0)
+		goto err;
+	
+	for (i = 0; i < nroles; i++) {
+		if (fprintf(str, "%s ", roles[i]) < 0)
+			goto err;
+	}
+
+	if (fprintf(str, "} ") < 0)
+		goto err;
+
+	/* MLS */
+	if (mls_level != NULL && mls_range != NULL)
+		if (fprintf(str, "level %s range %s", mls_level, mls_range) < 0)
+			goto err;
+
+	if (fprintf(str, ";\n") < 0)
+		goto err;
+
+	free(roles);
+	return STATUS_SUCCESS;
+
+	err:
+	free(roles);
+	ERR(handle, "could not print user %s to stream", name);
+	return STATUS_ERR;
+}
+
+static int user_base_parse(
+	semanage_handle_t* handle,
+	parse_info_t* info, 
+	semanage_user_base_t* user) {
+
+	int islist = 0;
+	char* str = NULL;
+	char* start;
+	char* name_str = NULL;
+
+	if (parse_skip_space(handle, info) < 0)
+		goto err;
+	if (!info->ptr)
+		goto last;
+
+	/* Parse user header */
+	if (parse_assert_str(handle, info, "user") < 0)
+		goto err;
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+
+	/* Parse user name */
+	if (parse_fetch_string(handle, info, &name_str, ' ') < 0)
+		goto err;
+
+	if (semanage_user_base_set_name(handle, user, name_str) < 0) {
+		free(name_str);
+                goto err;
+	}
+	free(name_str);
+
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+	if (parse_assert_str(handle, info, "roles") < 0)
+		goto err;
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+
+	islist = (parse_optional_ch(info,'{') != STATUS_NODATA);
+
+	/* For each role, loop */
+	do {
+		char delim;
+
+		if (parse_skip_space(handle, info) < 0)
+			goto err;
+		if (parse_assert_noeof(handle, info) < 0)
+			goto err;
+
+		start = info->ptr;
+		while (
+			*(info->ptr) &&
+			*(info->ptr) != ';' &&
+			*(info->ptr) != '}' &&
+			!isspace(*(info->ptr)))
+			info->ptr++;
+
+		delim = *(info->ptr);
+		*(info->ptr)++ = '\0';
+
+		if (semanage_user_base_add_role(handle, user, start) < 0)
+			goto err;
+
+		if (delim && !isspace(delim)) {
+			if (islist && delim == '}')
+				break;
+			else if (!islist && delim == ';')
+				goto skip_semicolon;
+			else
+				goto err;
+		}
+
+		if (parse_skip_space(handle, info) < 0)
+			goto err;
+		if (parse_optional_ch(info,';') != STATUS_NODATA)
+			goto skip_semicolon;
+		if (parse_optional_ch(info,'}') != STATUS_NODATA)
+			islist =0;
+
+	} while (islist);
+
+	/* Handle mls */
+	/* Parse level header */
+	if (parse_skip_space(handle, info) < 0)
+		goto err;
+	if (parse_optional_str(info, "level") == STATUS_NODATA)
+		goto semicolon;
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+
+	/* NOTE: does not allow spaces/multiline */
+	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+		goto err;
+	if (semanage_user_base_set_mlslevel(handle, user, str) < 0)
+		goto err;
+	free(str);
+	str = NULL;
+
+	/* Parse range header */
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+	if (parse_assert_str(handle, info, "range") < 0)
+		goto err;
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+
+	/* NOTE: does not allow spaces/multiline */
+	if (parse_fetch_string(handle, info, &str, ';') < 0)
+		goto err;
+	if (semanage_user_base_set_mlsrange(handle, user, str) < 0)
+		goto err;
+
+	free(str);
+	str = NULL;
+
+	/* Check for semicolon */
+	semicolon:
+	if (parse_skip_space(handle, info) < 0)
+		goto err;
+	if (parse_assert_ch(handle, info,';') < 0)
+		goto err;
+
+	skip_semicolon:
+	return STATUS_SUCCESS;
+
+	last:
+	parse_dispose_line(info);
+	return STATUS_NODATA;
+
+	err:
+	ERR(handle, "could not parse user record");
+	free(str);
+	parse_dispose_line(info);
+	return STATUS_ERR;
+}
+
+/* USER BASE record: FILE extension: method table */
+record_file_table_t SEMANAGE_USER_BASE_FILE_RTABLE = {
+	.parse       = user_base_parse,
+	.print       = user_base_print,
+};
+
+int user_base_file_dbase_init(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig) {
+	
+	if (dbase_file_init(
+		handle, 
+		"users.local",
+		&SEMANAGE_USER_BASE_RTABLE,
+		&SEMANAGE_USER_BASE_FILE_RTABLE, 
+		&dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_FILE_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void user_base_file_dbase_release(
+	dbase_config_t* dconfig) {
+
+	dbase_file_release(dconfig->dbase);
+}
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/users_base_policydb.c new/libsemanage/src/users_base_policydb.c
--- old/libsemanage/src/users_base_policydb.c	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/src/users_base_policydb.c	2006-01-10 00:38:06.000000000 -0700
@@ -0,0 +1,50 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+struct semanage_user_base;
+struct semanage_user_key;
+typedef struct semanage_user_base record_t;
+typedef struct semanage_user_key record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_policydb;
+typedef struct dbase_policydb dbase_t;
+#define DBASE_DEFINED
+
+#include <sepol/users.h>
+#include <semanage/handle.h>
+#include "user_internal.h"
+#include "debug.h"
+#include "database_policydb.h"
+
+/* USER BASE record: POLICYDB extension: method table */
+record_policydb_table_t SEMANAGE_USER_BASE_POLICYDB_RTABLE = {
+	.add         = NULL,
+	.modify      = sepol_user_modify,
+	.set         = NULL,
+	.query       = sepol_user_query, 
+	.count       = sepol_user_count,
+	.exists      = sepol_user_exists,
+	.iterate     = sepol_user_iterate,
+};
+
+int user_base_policydb_dbase_init(
+	semanage_handle_t* handle, 
+	dbase_config_t* dconfig) {
+
+	if (dbase_policydb_init(
+		handle, 
+		"policy.kern",
+		&SEMANAGE_USER_BASE_RTABLE, 
+		&SEMANAGE_USER_BASE_POLICYDB_RTABLE, 
+		&dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_POLICYDB_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void user_base_policydb_dbase_release(
+	dbase_config_t* dconfig) {
+
+	dbase_policydb_release(dconfig->dbase);
+}
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2006-01-11 16:23:42.000000000 -0700
+++ new/libsemanage/src/users_file.c	1969-12-31 17:00:00.000000000 -0700
@@ -1,228 +0,0 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
-
-struct semanage_user;
-struct semanage_user_key;
-typedef struct semanage_user record_t;
-typedef struct semanage_user_key record_key_t;
-#define DBASE_RECORD_DEFINED
-
-struct dbase_file;
-typedef struct dbase_file dbase_t;
-#define DBASE_DEFINED 
-
-#include <stdlib.h>
-#include <stdio.h>
-#include <ctype.h>
-#include <string.h>
-#include <semanage/handle.h>
-#include "user_internal.h"
-#include "database_file.h"
-#include "parse_utils.h"
-#include "debug.h"
-
-static int user_print(
-	semanage_handle_t* handle,
-	semanage_user_t* user, 
-	FILE* str) {
-
-	const char** roles = NULL;
-	unsigned int i, nroles;
-
-	const char* name      = semanage_user_get_name(user);
-	const char* mls_level = semanage_user_get_mlslevel(user);
-	const char* mls_range = semanage_user_get_mlsrange(user);
-
-	if (fprintf(str, "user %s roles { ", name) < 0)
-		goto err;
-
-	if (semanage_user_get_roles(handle, user, &roles, &nroles) < 0)
-		goto err;
-	
-	for (i = 0; i < nroles; i++) {
-		if (fprintf(str, "%s ", roles[i]) < 0)
-			goto err;
-	}
-
-	if (fprintf(str, "} ") < 0)
-		goto err;
-
-	/* MLS */
-	if (mls_level != NULL && mls_range != NULL)
-		if (fprintf(str, "level %s range %s", mls_level, mls_range) < 0)
-			goto err;
-
-	if (fprintf(str, ";\n") < 0)
-		goto err;
-
-	free(roles);
-	return STATUS_SUCCESS;
-
-	err:
-	free(roles);
-	ERR(handle, "could not print user %s to stream", name);
-	return STATUS_ERR;
-}
-
-static int user_parse(
-	semanage_handle_t* handle,
-	parse_info_t* info, 
-	semanage_user_t* user) {
-
-	int islist = 0;
-	char* str = NULL;
-	char* start;
-	char* name_str = NULL;
-
-	if (parse_skip_space(handle, info) < 0)
-		goto err;
-	if (!info->ptr)
-		goto last;
-
-	/* Parse user header */
-	if (parse_assert_str(handle, info, "user") < 0)
-		goto err;
-	if (parse_assert_space(handle, info) < 0)
-		goto err;
-
-	/* Parse user name */
-	if (parse_fetch_string(handle, info, &name_str, ' ') < 0)
-		goto err;
-
-	if (semanage_user_set_name(handle, user, name_str) < 0) {
-		free(name_str);
-                goto err;
-	}
-	free(name_str);
-
-	if (parse_assert_space(handle, info) < 0)
-		goto err;
-	if (parse_assert_str(handle, info, "roles") < 0)
-		goto err;
-	if (parse_assert_space(handle, info) < 0)
-		goto err;
-
-	islist = (parse_optional_ch(info,'{') != STATUS_NODATA);
-
-	/* For each role, loop */
-	do {
-		char delim;
-
-		if (parse_skip_space(handle, info) < 0)
-			goto err;
-		if (parse_assert_noeof(handle, info) < 0)
-			goto err;
-
-		start = info->ptr;
-		while (
-			*(info->ptr) &&
-			*(info->ptr) != ';' &&
-			*(info->ptr) != '}' &&
-			!isspace(*(info->ptr)))
-			info->ptr++;
-
-		delim = *(info->ptr);
-		*(info->ptr)++ = '\0';
-
-		if (semanage_user_add_role(handle, user, start) < 0)
-			goto err;
-
-		if (delim && !isspace(delim)) {
-			if (islist && delim == '}')
-				break;
-			else if (!islist && delim == ';')
-				goto skip_semicolon;
-			else
-				goto err;
-		}
-
-		if (parse_skip_space(handle, info) < 0)
-			goto err;
-		if (parse_optional_ch(info,';') != STATUS_NODATA)
-			goto skip_semicolon;
-		if (parse_optional_ch(info,'}') != STATUS_NODATA)
-			islist =0;
-
-	} while (islist);
-
-	/* Handle mls */
-	/* Parse level header */
-	if (parse_skip_space(handle, info) < 0)
-		goto err;
-	if (parse_optional_str(info, "level") == STATUS_NODATA)
-		goto semicolon;
-	if (parse_assert_space(handle, info) < 0)
-		goto err;
-
-	/* NOTE: does not allow spaces/multiline */
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
-		goto err;
-	if (semanage_user_set_mlslevel(handle, user, str) < 0)
-		goto err;
-	free(str);
-	str = NULL;
-
-	/* Parse range header */
-	if (parse_assert_space(handle, info) < 0)
-		goto err;
-	if (parse_assert_str(handle, info, "range") < 0)
-		goto err;
-	if (parse_assert_space(handle, info) < 0)
-		goto err;
-
-	/* NOTE: does not allow spaces/multiline */
-	if (parse_fetch_string(handle, info, &str, ';') < 0)
-		goto err;
-	if (semanage_user_set_mlsrange(handle, user, str) < 0)
-		goto err;
-
-	free(str);
-	str = NULL;
-
-	/* Check for semicolon */
-	semicolon:
-	if (parse_skip_space(handle, info) < 0)
-		goto err;
-	if (parse_assert_ch(handle, info,';') < 0)
-		goto err;
-
-	skip_semicolon:
-	return STATUS_SUCCESS;
-
-	last:
-	parse_dispose_line(info);
-	return STATUS_NODATA;
-
-	err:
-	ERR(handle, "could not parse user record");
-	free(str);
-	parse_dispose_line(info);
-	return STATUS_ERR;
-}
-
-/* USER RECORD: FILE extension: method table */
-record_file_table_t SEMANAGE_USER_FILE_RTABLE = {
-	.parse       = user_parse,
-	.print       = user_print,
-};
-
-int user_file_dbase_init(
-	semanage_handle_t* handle,
-	dbase_config_t* dconfig) {
-	
-	if (dbase_file_init(
-		handle, 
-		"users.local",
-		&SEMANAGE_USER_RTABLE,
-		&SEMANAGE_USER_FILE_RTABLE, 
-		&dconfig->dbase) < 0)
-		return STATUS_ERR;
-
-	dconfig->dtable = &SEMANAGE_FILE_DTABLE;
-	return STATUS_SUCCESS;
-}
-
-void user_file_dbase_release(
-	dbase_config_t* dconfig) {
-
-	dbase_file_release(dconfig->dbase);
-}
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/users_join.c new/libsemanage/src/users_join.c
--- old/libsemanage/src/users_join.c	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/src/users_join.c	2006-01-12 01:42:07.000000000 -0700
@@ -0,0 +1,52 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+struct semanage_user;
+struct semanage_user_key;
+typedef struct semanage_user record_t;
+typedef struct semanage_user_key record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct semanage_user_base;
+struct semanage_user_extra;
+typedef struct semanage_user_base record1_t;
+typedef struct semanage_user_extra record2_t;
+#define DBASE_RECORD_JOIN_DEFINED
+
+struct dbase_join;
+typedef struct dbase_join dbase_t;
+#define DBASE_DEFINED 
+
+#include <semanage/handle.h>
+#include "user_internal.h"
+#include "database_join.h"
+#include "debug.h"
+
+/* USER record: JOIN extension: method table */
+record_join_table_t SEMANAGE_USER_JOIN_RTABLE = { 
+	.join       = semanage_user_join,
+	.split      = semanage_user_split,
+};
+
+int user_join_dbase_init(
+	semanage_handle_t* handle,
+	dbase_config_t* join1,
+	dbase_config_t* join2,
+	dbase_config_t* dconfig) {
+
+	if (dbase_join_init(
+		handle, 
+	 	&SEMANAGE_USER_RTABLE,
+		&SEMANAGE_USER_JOIN_RTABLE,
+		join1, join2,
+		&dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_JOIN_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void user_join_dbase_release(
+	dbase_config_t* dconfig) {
+
+	dbase_join_release(dconfig->dbase);
+}
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/users_policydb.c new/libsemanage/src/users_policydb.c
--- old/libsemanage/src/users_policydb.c	2006-01-04 10:18:17.000000000 -0700
+++ new/libsemanage/src/users_policydb.c	1969-12-31 17:00:00.000000000 -0700
@@ -1,50 +0,0 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
-
-struct semanage_user;
-struct semanage_user_key;
-typedef struct semanage_user record_t;
-typedef struct semanage_user_key record_key_t;
-#define DBASE_RECORD_DEFINED
-
-struct dbase_policydb;
-typedef struct dbase_policydb dbase_t;
-#define DBASE_DEFINED
-
-#include <sepol/users.h>
-#include <semanage/handle.h>
-#include "user_internal.h"
-#include "debug.h"
-#include "database_policydb.h"
-
-/* USER RECRORD (SEPOL): POLICYDB extension: method table */
-record_policydb_table_t SEMANAGE_USER_POLICYDB_RTABLE = {
-	.add         = NULL,
-	.modify      = sepol_user_modify,
-	.set         = NULL,
-	.query       = sepol_user_query, 
-	.count       = sepol_user_count,
-	.exists      = sepol_user_exists,
-	.iterate     = sepol_user_iterate,
-};
-
-int user_policydb_dbase_init(
-	semanage_handle_t* handle, 
-	dbase_config_t* dconfig) {
-
-	if (dbase_policydb_init(
-		handle, 
-		"policy.kern",
-		&SEMANAGE_USER_RTABLE, 
-		&SEMANAGE_USER_POLICYDB_RTABLE, 
-		&dconfig->dbase) < 0)
-		return STATUS_ERR;
-
-	dconfig->dtable = &SEMANAGE_POLICYDB_DTABLE;
-	return STATUS_SUCCESS;
-}
-
-void user_policydb_dbase_release(
-	dbase_config_t* dconfig) {
-
-	dbase_policydb_release(dconfig->dbase);
-}

--------------010203080708070306030903--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
