Message-ID: <43DBC34E.9010100@cornell.edu>
Date: Sat, 28 Jan 2006 12:17:34 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   Joshua Brindle <jbrindle@tresys.com>
Subject: [SEMANAGE,UTILS] Support seusers.system
Content-Type: multipart/mixed;
 boundary="------------090906070100020003090805"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090906070100020003090805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch complements the previous rename patch (which was 
accepted after discussion).

It instantiates the seuser dbase 2 more times, for seusers.system, and 
seusers.final.
seusers and seusers.system stack to get seusers.final. I would have 
preferred consistent naming for the files (.local for local stuff, 
seusers for final), but that will create compatibility issues with 
systems using the current setup. Patch changes manpages, the installed 
file in semanage_store, and all dependencies that I know of 
(genhomedircon, and seobject.py).

We still need policy package support for users_extra.system, and 
seusers.system.

Dan, if you install a seusers.system file, anything that you put in it 
cannot be deleted, and semanage will reject at attempt to delete root or 
__default__, if they are installed in that file (just like anything else 
defined in policy).

--------------090906070100020003090805
Content-Type: text/x-patch;
 name="libsemanage.policycoreutils.seusers.system.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.policycoreutils.seusers.system.diff"

diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/semanage.h new/libsemanage/include/semanage/semanage.h
--- old/libsemanage/include/semanage/semanage.h	2006-01-27 13:44:07.000000000 -0700
+++ new/libsemanage/include/semanage/semanage.h	2006-01-28 11:45:33.000000000 -0700
@@ -43,6 +43,7 @@
 #include <semanage/fcontexts_local.h>
 #include <semanage/fcontexts_policy.h>
 #include <semanage/seusers_local.h>
+#include <semanage/seusers_policy.h>
 #include <semanage/ports_local.h>
 #include <semanage/ports_policy.h>
 #include <semanage/interfaces_local.h>
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/seusers_local.h new/libsemanage/include/semanage/seusers_local.h
--- old/libsemanage/include/semanage/seusers_local.h	2006-01-27 13:44:07.000000000 -0700
+++ new/libsemanage/include/semanage/seusers_local.h	2006-01-28 11:44:38.000000000 -0700
@@ -1,7 +1,7 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#ifndef _SEMANAGE_SEUSERS_H_
-#define _SEMANAGE_SEUSERS_H_
+#ifndef _SEMANAGE_SEUSERS_LOCAL_H_
+#define _SEMANAGE_SEUSERS_LOCAL_H_
 
 #include <semanage/seuser_record.h>
 #include <semanage/handle.h>
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/seusers_policy.h new/libsemanage/include/semanage/seusers_policy.h
--- old/libsemanage/include/semanage/seusers_policy.h	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/include/semanage/seusers_policy.h	2006-01-28 11:45:05.000000000 -0700
@@ -0,0 +1,35 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+#ifndef _SEMANAGE_SEUSERS_POLICY_H_
+#define _SEMANAGE_SEUSERS_POLICY_H_
+
+#include <semanage/seuser_record.h>
+#include <semanage/handle.h>
+
+extern int semanage_seuser_query(
+	semanage_handle_t* handle,
+	const semanage_seuser_key_t* key,
+	semanage_seuser_t** response);
+
+extern int semanage_seuser_exists(
+	semanage_handle_t* handle,
+	const semanage_seuser_key_t* key,
+	int* response);
+
+extern int semanage_seuser_count(
+	semanage_handle_t* handle,
+	unsigned int* response);
+
+extern int semanage_seuser_iterate(
+	semanage_handle_t* handle,
+	int (*handler) (
+		const semanage_seuser_t* record,
+		void* varg),
+	void* handler_arg);
+
+extern int semanage_seuser_list(
+	semanage_handle_t* handle,
+	semanage_seuser_t*** records,
+	unsigned int* count);
+
+#endif 
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_count.3 new/libsemanage/man/man3/semanage_seuser_count.3
--- old/libsemanage/man/man3/semanage_seuser_count.3	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_count.3	2006-01-28 11:56:30.000000000 -0700
@@ -0,0 +1 @@
+.so man3/semanage_user_count_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_exists.3 new/libsemanage/man/man3/semanage_seuser_exists.3
--- old/libsemanage/man/man3/semanage_seuser_exists.3	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_exists.3	2006-01-28 11:56:42.000000000 -0700
@@ -0,0 +1 @@
+.so man3/semanage_user_exists_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_iterate.3 new/libsemanage/man/man3/semanage_seuser_iterate.3
--- old/libsemanage/man/man3/semanage_seuser_iterate.3	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_iterate.3	2006-01-28 11:56:48.000000000 -0700
@@ -0,0 +1 @@
+.so man3/semanage_user_iterate_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_list.3 new/libsemanage/man/man3/semanage_seuser_list.3
--- old/libsemanage/man/man3/semanage_seuser_list.3	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_list.3	2006-01-28 11:56:54.000000000 -0700
@@ -0,0 +1 @@
+.so man3/semanage_user_list_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_query.3 new/libsemanage/man/man3/semanage_seuser_query.3
--- old/libsemanage/man/man3/semanage_seuser_query.3	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_query.3	2006-01-28 11:56:36.000000000 -0700
@@ -0,0 +1 @@
+.so man3/semanage_user_query_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_count_local.3 new/libsemanage/man/man3/semanage_user_count_local.3
--- old/libsemanage/man/man3/semanage_user_count_local.3	2006-01-27 13:44:08.000000000 -0700
+++ new/libsemanage/man/man3/semanage_user_count_local.3	2006-01-28 11:53:03.000000000 -0700
@@ -33,6 +33,9 @@ return the number of context specificati
 .B semanage_fcontext_count_local \- 
 return the number of context specifications in the local store
 .br
+.B semanage_seuser_count \-
+return the number of seusers (login mappings) in the persistent policy
+.br
 .B semanage_seuser_count_local \- 
 return the number of seusers (login mappings) in the local store
 
@@ -59,6 +62,8 @@ return the number of seusers (login mapp
 .br
 .B #include <semanage/fcontexts_local.h>
 .br
+.B #include <semanage/seusers_policy.h>
+.br
 .B #include <semanage/seusers_local.h>
 .sp
 
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_exists_local.3 new/libsemanage/man/man3/semanage_user_exists_local.3
--- old/libsemanage/man/man3/semanage_user_exists_local.3	2006-01-27 13:44:08.000000000 -0700
+++ new/libsemanage/man/man3/semanage_user_exists_local.3	2006-01-28 11:54:25.000000000 -0700
@@ -33,6 +33,9 @@ check if a context specification exists 
 .B semanage_fcontext_exists_local \- 
 check if a context specification exists in the local store
 .br
+.B semanage_seuser_exists \-
+check if a seuser (login mapping) exists in the persistent policy
+.br
 .B semanage_seuser_exists_local \- 
 check if a seuser (login mapping) exists in the local store
 
@@ -59,6 +62,8 @@ check if a seuser (login mapping) exists
 .br
 .B #include <semanage/fcontexts_local.h>
 .br
+.B #include <semanage/seusers_policy.h
+.br
 .B #include <semanage/seusers_local.h>
 .sp
 
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_iterate_local.3 new/libsemanage/man/man3/semanage_user_iterate_local.3
--- old/libsemanage/man/man3/semanage_user_iterate_local.3	2006-01-27 13:44:08.000000000 -0700
+++ new/libsemanage/man/man3/semanage_user_iterate_local.3	2006-01-28 11:54:40.000000000 -0700
@@ -33,6 +33,9 @@ execute a callback for all context speci
 .B semanage_fcontext_iterate_local \- 
 execute a callback for all context specifications in the local store
 .br
+.B semanage_seuser_iterate \-
+execute a callback for all seusers (login mappings) in the persistent policy
+.br
 .B semanage_seuser_iterate_local \- 
 execute a callback for all seusers (login mappings) in the local store
 
@@ -59,6 +62,8 @@ execute a callback for all seusers (logi
 .br
 .B #include <semanage/fcontexts_local.h>
 .br
+.B #include <semanage/seusers_policy.h>
+.br
 .B #include <semanage/seusers_local.h>
 .sp
 
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_list_local.3 new/libsemanage/man/man3/semanage_user_list_local.3
--- old/libsemanage/man/man3/semanage_user_list_local.3	2006-01-27 13:44:08.000000000 -0700
+++ new/libsemanage/man/man3/semanage_user_list_local.3	2006-01-28 11:56:03.000000000 -0700
@@ -33,6 +33,9 @@ list all context specifications in the p
 .B semanage_fcontext_list_local \- 
 list all context specifications in the local store
 .br
+.B semanage_seuser_list \-
+list all seusers (login mappings) in the persistent policy
+.br
 .B semanage_seuser_list_local \- 
 list all seusers (login mappings) in the local store
 
@@ -59,6 +62,8 @@ list all seusers (login mappings) in the
 .br
 .B #include <semanage/fcontexts_local.h>
 .br
+.B #include <semanage/seusers_policy.h>
+.br
 .B #include <semanage/seusers_local.h>
 .sp
 
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_query_local.3 new/libsemanage/man/man3/semanage_user_query_local.3
--- old/libsemanage/man/man3/semanage_user_query_local.3	2006-01-27 13:44:08.000000000 -0700
+++ new/libsemanage/man/man3/semanage_user_query_local.3	2006-01-28 11:55:22.000000000 -0700
@@ -33,6 +33,9 @@ query a context specification in the per
 .B semanage_fcontext_query_local \- 
 query a context specification in the local store
 .br
+.B semanage_seuser_query \-
+query a seuser (login mapping) in the persistent policy
+.br
 .B semanage_seuser_query_local \- 
 query a seuser (login mapping) in the local store
 
@@ -59,6 +62,8 @@ query a seuser (login mapping) in the lo
 .br
 .B #include <semanage/fcontexts_local.h>
 .br
+.B #include <semanage/seusers_policy.h>
+.br
 .B #include <semanage/seusers_local.h>
 .sp
 
diff -Naurp --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2006-01-28 11:03:16.000000000 -0700
+++ new/libsemanage/src/direct_api.c	2006-01-28 12:02:08.000000000 -0700
@@ -115,7 +115,7 @@ int semanage_direct_connect(semanage_han
 	/* set up function pointers */
 	sh->funcs = &direct_funcs;
 
-        /* Configure object databases */
+        /* Object databases: local modifications */
 	if (user_base_file_dbase_init(sh, "users.local", 
 		semanage_user_base_dbase_local(sh)) < 0)
 		goto err;
@@ -150,10 +150,16 @@ int semanage_direct_connect(semanage_han
 		semanage_seuser_dbase_local(sh)) < 0)
 		goto err;
 
+	/* Object databases: policy */
 	if (user_extra_file_dbase_init(sh, "users_extra.system",
 		semanage_user_extra_dbase_system(sh)) < 0)
 		goto err;
 
+	if (seuser_file_dbase_init(sh, "seusers.system", 
+		semanage_seuser_dbase_system(sh)) < 0)
+		goto err;
+
+	/* Object databases: local modifications + policy */
 	if (user_base_policydb_dbase_init(sh, 
 		semanage_user_base_dbase_policy(sh)) < 0)
 		goto err;
@@ -181,6 +187,11 @@ int semanage_direct_connect(semanage_han
 		semanage_fcontext_dbase_policy(sh)) < 0)
 		goto err;
 
+	if (seuser_file_dbase_init(sh, "seusers.final", 
+		semanage_seuser_dbase_policy(sh)) < 0)
+		goto err;
+
+	/* Active kernel policy */
 	if (bool_activedb_dbase_init(sh, semanage_bool_dbase_active(sh)) < 0)
 		goto err;
 
@@ -208,7 +219,7 @@ static int semanage_direct_disconnect(se
 		semanage_release_trans_lock(sh);
 	}
 
-	/* Remove object databases */
+	/* Release object databases: local modifications */
 	user_base_file_dbase_release(semanage_user_base_dbase_local(sh));
 	user_extra_file_dbase_release(semanage_user_extra_dbase_local(sh));
 	user_join_dbase_release(semanage_user_dbase_local(sh));
@@ -218,8 +229,11 @@ static int semanage_direct_disconnect(se
 	fcontext_file_dbase_release(semanage_fcontext_dbase_local(sh));
 	seuser_file_dbase_release(semanage_seuser_dbase_local(sh));
 
+	/* Release object databases: policy */
 	user_extra_file_dbase_release(semanage_user_extra_dbase_system(sh));
+	seuser_file_dbase_release(semanage_seuser_dbase_system(sh));
 
+	/* Release object databases: local modifications + policy */
 	user_base_policydb_dbase_release(semanage_user_base_dbase_policy(sh));
 	user_extra_file_dbase_release(semanage_user_extra_dbase_policy(sh));
 	user_join_dbase_release(semanage_user_dbase_policy(sh));
@@ -227,7 +241,9 @@ static int semanage_direct_disconnect(se
 	iface_policydb_dbase_release(semanage_iface_dbase_policy(sh));
 	bool_policydb_dbase_release(semanage_bool_dbase_policy(sh));
 	fcontext_file_dbase_release(semanage_fcontext_dbase_policy(sh));
+	seuser_file_dbase_release(semanage_seuser_dbase_policy(sh));
 
+	/* Release object databases: active kernel policy */
 	bool_activedb_dbase_release(semanage_bool_dbase_active(sh));
 
 	return 0;
@@ -412,10 +428,10 @@ static int semanage_direct_commit(semana
 	dbase_config_t* fcontexts = semanage_fcontext_dbase_local(sh);
 	dbase_config_t* pfcontexts = semanage_fcontext_dbase_policy(sh);
 	dbase_config_t* seusers = semanage_seuser_dbase_local(sh);
+	dbase_config_t* pseusers = semanage_seuser_dbase_policy(sh);
 
 	/* Before we do anything else, flush the join to its component parts.
 	 * This *does not* flush to disk automatically */
-	users = semanage_user_dbase_local(sh);
 	if (users->dtable->is_modified(users->dbase) &&
 	    users->dtable->flush(sh, users->dbase) < 0)
 		goto cleanup;
@@ -471,11 +487,14 @@ static int semanage_direct_commit(semana
 			goto cleanup;
 		pfcontexts->dtable->drop_cache(pfcontexts->dbase);
 
-		/* ==================== Users extra data =============== */
+		/* ==================== Other file-backed ================== */
 
-		/* Clear any users_extra cache completely */
+		/* Clear any cache, will be regenerated */
 		if (pusers_extra->dtable->clear(sh, pusers_extra->dbase) < 0)
 			goto cleanup;
+		
+		if (pseusers->dtable->clear(sh, pseusers->dbase) < 0)
+			goto cleanup;
 
 		/* ==================== Policydb-backed ================ */
 
@@ -540,7 +559,7 @@ static int semanage_direct_commit(semana
 		free(mod_filenames[i]);
 	}
 
-	/* Detach out, so it can be freed */
+	/* Detach from policydb, so it can be freed */
 	dbase_policydb_detach((dbase_policydb_t*) pusers_base->dbase);
 	dbase_policydb_detach((dbase_policydb_t*) pports->dbase);
 	dbase_policydb_detach((dbase_policydb_t*) pifaces->dbase);
diff -Naurp --exclude-from excludes old/libsemanage/src/handle.h new/libsemanage/src/handle.h
--- old/libsemanage/src/handle.h	2006-01-27 13:44:09.000000000 -0700
+++ new/libsemanage/src/handle.h	2006-01-28 11:30:56.000000000 -0700
@@ -78,7 +78,7 @@ struct semanage_handle {
 	struct semanage_policy_table* funcs;
 
 	/* Object databases */
-#define DBASE_COUNT      17
+#define DBASE_COUNT      19
 
 /* Local modifications */
 #define DBASE_LOCAL_USERS_BASE  0
@@ -92,21 +92,24 @@ struct semanage_handle {
 
 /* Policy */
 #define DBASE_SYSTEM_USERS_EXTRA 8
+#define DBASE_SYSTEM_SEUSERS     9
 
 /* Policy + Local modifications */
-#define DBASE_POLICY_USERS_BASE  9
-#define DBASE_POLICY_USERS_EXTRA 10
-#define DBASE_POLICY_USERS       11
-#define DBASE_POLICY_PORTS       12
-#define DBASE_POLICY_INTERFACES  13
-#define DBASE_POLICY_BOOLEANS    14
-#define DBASE_POLICY_FCONTEXTS   15
+#define DBASE_POLICY_USERS_BASE  10
+#define DBASE_POLICY_USERS_EXTRA 11
+#define DBASE_POLICY_USERS       12
+#define DBASE_POLICY_PORTS       13
+#define DBASE_POLICY_INTERFACES  14
+#define DBASE_POLICY_BOOLEANS    15
+#define DBASE_POLICY_FCONTEXTS   16
+#define DBASE_POLICY_SEUSERS     17
 
 /* Active kernel policy */
-#define DBASE_ACTIVE_BOOLEANS    16
+#define DBASE_ACTIVE_BOOLEANS    18
 	dbase_config_t dbase[DBASE_COUNT];
 };
 
+/* === Local modifications === */
 static inline
 dbase_config_t* semanage_user_base_dbase_local(semanage_handle_t* handle) {
 	return &handle->dbase[DBASE_LOCAL_USERS_BASE];
@@ -147,12 +150,20 @@ dbase_config_t* semanage_seuser_dbase_lo
 	return &handle->dbase[DBASE_LOCAL_SEUSERS];
 }
 
+/* === Policy === */
 static inline
 dbase_config_t* semanage_user_extra_dbase_system(semanage_handle_t* handle) {
 	return &handle->dbase[DBASE_SYSTEM_USERS_EXTRA];
 }
 
 static inline
+dbase_config_t* semanage_seuser_dbase_system(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_SYSTEM_SEUSERS];
+}
+
+
+/* === Policy + Local modifications === */
+static inline
 dbase_config_t* semanage_user_base_dbase_policy(semanage_handle_t* handle) {
 	return &handle->dbase[DBASE_POLICY_USERS_BASE];
 }
@@ -188,6 +199,12 @@ dbase_config_t* semanage_fcontext_dbase_
 }
 
 static inline
+dbase_config_t* semanage_seuser_dbase_policy(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_POLICY_SEUSERS];
+}
+
+/* === Active kernel policy === */
+static inline
 dbase_config_t* semanage_bool_dbase_active(semanage_handle_t* handle) {
 	return &handle->dbase[DBASE_ACTIVE_BOOLEANS];
 }
diff -Naurp --exclude-from excludes old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2006-01-28 11:21:34.000000000 -0700
+++ new/libsemanage/src/policy_components.c	2006-01-28 11:41:37.000000000 -0700
@@ -147,6 +147,12 @@ int semanage_base_merge_components(
 
 		{ semanage_fcontext_dbase_local(handle),
 		  semanage_fcontext_dbase_policy(handle), MODE_MODIFY },
+
+		{ semanage_seuser_dbase_system(handle),
+		  semanage_seuser_dbase_policy(handle), MODE_MODIFY },
+	
+		{ semanage_seuser_dbase_local(handle),
+		  semanage_seuser_dbase_policy(handle), MODE_MODIFY },
 	};
 	const int CCOUNT = sizeof(components)/sizeof(components[0]);
 
@@ -199,6 +205,7 @@ int semanage_commit_components(
 		semanage_fcontext_dbase_local(handle),
 		semanage_fcontext_dbase_policy(handle),
 		semanage_seuser_dbase_local(handle),
+		semanage_seuser_dbase_policy(handle),
 		semanage_bool_dbase_active(handle),
 	};
 	const int CCOUNT = sizeof(components)/sizeof(components[0]);
diff -Naurp --exclude-from excludes old/libsemanage/src/pywrap-test.py new/libsemanage/src/pywrap-test.py
--- old/libsemanage/src/pywrap-test.py	2006-01-27 13:44:09.000000000 -0700
+++ new/libsemanage/src/pywrap-test.py	2006-01-28 11:59:45.000000000 -0700
@@ -132,7 +132,7 @@ class Tests:
 	def test_seusers(self,sh):
 		print "Testing seusers..."
 
-		(status, slist, slist_size) = semanage.semanage_seuser_list_local(sh)
+		(status, slist, slist_size) = semanage.semanage_seuser_list(sh)
 		if status < 0:
 			raise Error("Could not list seusers")
 		print "Query status (commit number): ", status
diff -Naurp --exclude-from excludes old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2006-01-27 08:00:53.000000000 -0700
+++ new/libsemanage/src/semanage_store.c	2006-01-28 11:47:21.000000000 -0700
@@ -96,7 +96,7 @@ static const char *semanage_sandbox_path
 	"/homedir_template",
 	"/file_contexts.template",
 	"/commit_num",
-	"/seusers"
+	"/seusers.final"
 };
 
 /* Initialize the paths to config file, lock files and store root.
diff -Naurp --exclude-from excludes old/libsemanage/src/semanageswig.i new/libsemanage/src/semanageswig.i
--- old/libsemanage/src/semanageswig.i	2006-01-27 13:44:09.000000000 -0700
+++ new/libsemanage/src/semanageswig.i	2006-01-28 11:46:13.000000000 -0700
@@ -41,7 +41,8 @@
 	#include "semanage/fcontext_record.h"
 	#include "semanage/fcontexts_local.h"
 	#include "semanage/fcontexts_policy.h"
-	#include "semanage/seusers_local.h"	
+	#include "semanage/seusers_local.h"
+	#include "semanage/seusers_policy.h"
 	#include "semanage/semanage.h"
 %}
 
@@ -311,4 +312,5 @@
 %include "../include/semanage/fcontexts_policy.h"
 %include "../include/semanage/seuser_record.h"
 %include "../include/semanage/seusers_local.h"
+%include "../include/semanage/seusers_policy.h"
 %include "../include/semanage/semanage.h"
diff -Naurp --exclude-from excludes old/libsemanage/src/seuser_internal.h new/libsemanage/src/seuser_internal.h
--- old/libsemanage/src/seuser_internal.h	2006-01-28 11:03:16.000000000 -0700
+++ new/libsemanage/src/seuser_internal.h	2006-01-28 11:44:12.000000000 -0700
@@ -3,6 +3,7 @@
 
 #include <semanage/seuser_record.h>
 #include <semanage/seusers_local.h>
+#include <semanage/seusers_policy.h>
 #include <sepol/policydb.h>
 #include "database.h"
 #include "handle.h"
@@ -22,6 +23,7 @@ hidden_proto(semanage_seuser_key_free)
 hidden_proto(semanage_seuser_set_mlsrange)
 hidden_proto(semanage_seuser_set_name)
 hidden_proto(semanage_seuser_set_sename)
+hidden_proto(semanage_seuser_iterate)
 hidden_proto(semanage_seuser_iterate_local)
 
 /* SEUSER RECORD: method table */
diff -Naurp --exclude-from excludes old/libsemanage/src/seusers_policy.c new/libsemanage/src/seusers_policy.c
--- old/libsemanage/src/seusers_policy.c	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/src/seusers_policy.c	2006-01-28 11:43:41.000000000 -0700
@@ -0,0 +1,62 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+struct semanage_seuser;
+struct semanage_seuser_key;
+typedef struct semanage_seuser_key record_key_t;
+typedef struct semanage_seuser record_t;
+#define DBASE_RECORD_DEFINED
+
+#include <sepol/policydb.h>
+#include <sepol/context.h>
+#include "user_internal.h"
+#include "seuser_internal.h"
+#include "handle.h"
+#include "database.h"
+#include "debug.h"
+
+int semanage_seuser_query(
+	semanage_handle_t* handle,
+	const semanage_seuser_key_t* key,
+	semanage_seuser_t** response) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase_policy(handle);
+	return dbase_query(handle, dconfig, key, response);
+}
+
+int semanage_seuser_exists(
+	semanage_handle_t* handle,
+	const semanage_seuser_key_t* key,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase_policy(handle);
+	return dbase_exists(handle, dconfig, key, response);
+}
+
+int semanage_seuser_count(
+	semanage_handle_t* handle,
+	unsigned int* response) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase_policy(handle);
+	return dbase_count(handle, dconfig, response);
+}
+
+int semanage_seuser_iterate(
+	semanage_handle_t* handle,
+	int (*handler) (
+		const semanage_seuser_t* record,
+		void* varg),
+	void* handler_arg) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase_policy(handle);
+	return dbase_iterate(handle, dconfig, handler, handler_arg);
+}
+hidden_def(semanage_seuser_iterate)
+
+int semanage_seuser_list(
+	semanage_handle_t* handle,
+	semanage_seuser_t*** records,
+	unsigned int* count) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase_policy(handle);
+	return dbase_list(handle, dconfig, records, count);
+}
diff -Naurp --exclude-from excludes old/policycoreutils/scripts/genhomedircon new/policycoreutils/scripts/genhomedircon
--- old/policycoreutils/scripts/genhomedircon	2006-01-27 13:44:22.000000000 -0700
+++ new/policycoreutils/scripts/genhomedircon	2006-01-28 11:51:03.000000000 -0700
@@ -207,7 +207,7 @@ class selinuxConfig:
 	def getUsers(self):
 		udict = {}
 		if self.semanaged:
-			(status, list, lsize) = semanage_seuser_list_local(self.semanageHandle)
+			(status, list, lsize) = semanage_seuser_list(self.semanageHandle)
 			for idx in range(lsize):
 				user=[]
 				seuser = semanage_seuser_by_idx(list, idx)
diff -Naurp --exclude-from excludes old/policycoreutils/semanage/seobject.py new/policycoreutils/semanage/seobject.py
--- old/policycoreutils/semanage/seobject.py	2006-01-27 13:44:22.000000000 -0700
+++ new/policycoreutils/semanage/seobject.py	2006-01-28 11:50:43.000000000 -0700
@@ -174,7 +174,7 @@ class loginRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not create a key for %s" % name)
 
-		(rc,exists) = semanage_seuser_exists_local(self.sh, k)
+		(rc,exists) = semanage_seuser_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError("Could not check if login mapping for %s is defined" % name)
 		if exists:
@@ -223,13 +223,13 @@ class loginRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not create a key for %s" % name)
 
-		(rc,exists) = semanage_seuser_exists_local(self.sh, k)
+		(rc,exists) = semanage_seuser_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError("Could not check if login mapping for %s is defined" % name)
 		if not exists:
 			raise ValueError("Login mapping for %s is not defined" % name)
 
-		(rc,u) = semanage_seuser_query_local(self.sh, k)
+		(rc,u) = semanage_seuser_query(self.sh, k)
 		if rc < 0:
 			raise ValueError("Could not query seuser for %s" % name)
 
@@ -258,12 +258,18 @@ class loginRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not create a key for %s" % name)
 
-		(rc,exists) = semanage_seuser_exists_local(self.sh, k)
+		(rc,exists) = semanage_seuser_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError("Could not check if login mapping for %s is defined" % name)
 		if not exists:
 			raise ValueError("Login mapping for %s is not defined" % name)
 
+		(rc,exists) = semanage_seuser_exists_local(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if login mapping for %s is defined" % name)
+		if not exists:
+			raise ValueError("Login mapping for %s is defined in policy, cannot be deleted" % name)
+
 		rc = semanage_begin_transaction(self.sh)
 		if rc < 0:
 			raise ValueError("Could not start semanage transaction")
@@ -282,7 +288,7 @@ class loginRecords(semanageRecords):
 		
 	def get_all(self):
 		ddict={}
-		(rc, self.ulist, self.usize) = semanage_seuser_list_local(self.sh)
+		(rc, self.ulist, self.usize) = semanage_seuser_list(self.sh)
 		if rc < 0:
 			raise ValueError("Could not list login mappings")
 

--------------090906070100020003090805--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
