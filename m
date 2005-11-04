Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA458HMA022870
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 00:08:18 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA452rZc002658
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 05:02:53 GMT
Received: from [192.168.2.105] (cpe-24-59-125-231.twcny.res.rr.com [24.59.125.231])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id jA452qIO010173
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 00:02:52 -0500 (EST)
Message-ID: <436AEE61.4010307@cornell.edu>
Date: Fri, 04 Nov 2005 00:15:13 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [ SEMANAGE 2 ] Database modification tracking, and cleanup
Content-Type: multipart/mixed;
 boundary="------------080706050707020309090406"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080706050707020309090406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

- adds an is_modified function to the database interface, which will be 
used by higher level code to determine whether policy changes have been 
performed, in order not to regenerate the policy every time. I need to 
add additional code to handle modules (I wish Tresys would use my dbase 
framework for modules...)

- cleanup - remove handle argument from internal functions where it is 
unused. If you take a look, you will notice that all of those functions 
are either void or return something else already (so they won't be 
failing anytime soon). The handle is not needed in any of those 
functions for other purposes - if it starts being needed I can add it 
back in.



--------------080706050707020309090406
Content-Type: text/x-patch;
 name="libsemanage.dbase_tracking+cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.dbase_tracking+cleanup.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_file.c new/libsemanage/src/booleans_file.c
--- old/libsemanage/src/booleans_file.c	2005-11-03 12:48:03.000000000 -0500
+++ new/libsemanage/src/booleans_file.c	2005-11-03 23:52:03.000000000 -0500
@@ -124,8 +124,7 @@ int bool_file_dbase_init(
 }
 
 void bool_file_dbase_release(
-	semanage_handle_t* handle,
 	dbase_config_t* dconfig) {
 
-	dbase_file_release(handle, dconfig->dbase);
+	dbase_file_release(dconfig->dbase);
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_file.h new/libsemanage/src/booleans_file.h
--- old/libsemanage/src/booleans_file.h	2005-11-01 16:25:47.000000000 -0500
+++ new/libsemanage/src/booleans_file.h	2005-11-03 23:50:58.000000000 -0500
@@ -9,7 +9,6 @@ int bool_file_dbase_init(
 	dbase_config_t* dconfig);
 
 void bool_file_dbase_release(
-	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
 
 #endif 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_policydb.c new/libsemanage/src/booleans_policydb.c
--- old/libsemanage/src/booleans_policydb.c	2005-11-01 16:25:47.000000000 -0500
+++ new/libsemanage/src/booleans_policydb.c	2005-11-03 23:50:08.000000000 -0500
@@ -45,8 +45,7 @@ int bool_policydb_dbase_init(
 }
 
 void bool_policydb_dbase_release(
-	semanage_handle_t* handle, 
 	dbase_config_t* dconfig) {
 
-	dbase_policydb_release(handle, dconfig->dbase);
+	dbase_policydb_release(dconfig->dbase);
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_policydb.h new/libsemanage/src/booleans_policydb.h
--- old/libsemanage/src/booleans_policydb.h	2005-11-01 16:25:47.000000000 -0500
+++ new/libsemanage/src/booleans_policydb.h	2005-11-03 23:50:53.000000000 -0500
@@ -9,7 +9,6 @@ int bool_policydb_dbase_init(
 	dbase_config_t* dconfig);
 
 void bool_policydb_dbase_release(
-	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
 
 #endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database.c new/libsemanage/src/database.c
--- old/libsemanage/src/database.c	2005-10-31 11:13:08.000000000 -0500
+++ new/libsemanage/src/database.c	2005-11-03 23:47:58.000000000 -0500
@@ -49,7 +49,7 @@ static inline void exit_ro(
 
 	if (!handle->is_in_transaction) {
 		semanage_release_active_lock(handle);
-		dconfig->dtable->drop_cache(handle, dconfig->dbase);
+		dconfig->dtable->drop_cache(dconfig->dbase);
 	}
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-11-03 12:48:03.000000000 -0500
+++ new/libsemanage/src/database_file.c	2005-11-03 23:48:31.000000000 -0500
@@ -162,7 +162,6 @@ static int dbase_file_cache(
 }
 
 static void dbase_file_drop_cache(
-	semanage_handle_t* handle,
 	dbase_file_t* dbase) {
 
 	if (!dbase->cached)
@@ -178,7 +177,6 @@ static void dbase_file_drop_cache(
 
 	dbase->cached = 0;
 	dbase->modified = 0;
-	handle = NULL;
 }	
 
 /* Flush database to file */
@@ -222,6 +220,13 @@ static int dbase_file_flush(
 	return STATUS_ERR;
 }
 
+/* Check if modified */
+static int dbase_file_is_modified(
+	dbase_file_t* dbase) {
+
+	return dbase->modified;
+}
+
 /* Helper for finding records in the cache */
 static int dbase_file_cache_locate(
 	semanage_handle_t* handle,
@@ -282,10 +287,9 @@ int dbase_file_init(
 	
 /* Release dbase resources */
 void dbase_file_release(
-	semanage_handle_t* handle,
 	dbase_file_t* dbase) {
 
-	dbase_file_drop_cache(handle, dbase);
+	dbase_file_drop_cache(dbase);
 	free(dbase);
 }
 
@@ -534,19 +538,22 @@ static int dbase_file_list(
 }
 
 static record_table_t* dbase_file_get_rtable(
-	semanage_handle_t* handle,
 	dbase_file_t* dbase) {
 
-	handle = NULL;
 	return dbase->rtable;
 }
 
 
 /* FILE dbase - method table implementation */
 dbase_table_t SEMANAGE_FILE_DTABLE = {
+
+	/* Cache/Transactions */
 	.cache = dbase_file_cache,
 	.drop_cache = dbase_file_drop_cache,
 	.flush = dbase_file_flush,
+	.is_modified = dbase_file_is_modified,
+
+	/* Database API */
 	.iterate = dbase_file_iterate,
 	.exists = dbase_file_exists, 
 	.list = dbase_file_list,   
@@ -556,5 +563,7 @@ dbase_table_t SEMANAGE_FILE_DTABLE = {
 	.modify = dbase_file_modify, 
 	.query = dbase_file_query, 
 	.count = dbase_file_count, 
+
+	/* Polymorphism */
 	.get_rtable = dbase_file_get_rtable
 };
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database_file.h new/libsemanage/src/database_file.h
--- old/libsemanage/src/database_file.h	2005-11-01 16:25:47.000000000 -0500
+++ new/libsemanage/src/database_file.h	2005-11-03 23:52:19.000000000 -0500
@@ -38,7 +38,6 @@ extern int dbase_file_init(
 
 /* FILE - release */
 extern void dbase_file_release(
-	semanage_handle_t* handle,
 	dbase_file_t* dbase);
 
 /* FILE - method table implementation */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database.h new/libsemanage/src/database.h
--- old/libsemanage/src/database.h	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/database.h	2005-11-03 23:52:13.000000000 -0500
@@ -55,6 +55,8 @@ typedef struct record_table {
 /* DBASE interface - method table */
 typedef struct dbase_table {
 
+	/* --------------- Database Functionality ----------- */
+
 	/* Add the specified record to
 	 * the database if it is not present,
 	 * or fail if it already exists */
@@ -127,6 +129,8 @@ typedef struct dbase_table {
 		record_t*** records,
 		size_t* count);
 
+	/* ---------- Cache/Transaction Management ---------- */
+
 	/* Cache the database (if supported).
  	 * Invoke this function before looking at
 	 * any data, since the database may require 
@@ -138,7 +142,10 @@ typedef struct dbase_table {
 	/* Forgets all changes that haven't been written
 	 * to the database backend */
 	void (*drop_cache) (
-		struct semanage_handle* handle,
+		dbase_t* dbase);
+
+	/* Checks if there are pending changes */
+	int (*is_modified) (
 		dbase_t* dbase);
 
 	/* Writes the database changes to its backend */
@@ -146,11 +153,13 @@ typedef struct dbase_table {
 		struct semanage_handle* handle,
 		dbase_t* dbase);
 
+	/* ------------- Polymorphism ----------------------- */
+
+
 	/* Retrieves the record table for this database,
 	 * which specifies how to perform basic operations
 	 * on each record. */
 	record_table_t* (*get_rtable) (
-		struct semanage_handle* handle,
 		dbase_t* dbase);
 
 } dbase_table_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2005-11-01 16:25:47.000000000 -0500
+++ new/libsemanage/src/database_policydb.c	2005-11-03 23:53:12.000000000 -0500
@@ -132,9 +132,14 @@ static int dbase_policydb_flush(
 	return STATUS_ERR;
 }
 
+/* Check if modified */
+static int dbase_policydb_is_modified(
+	dbase_policydb_t* dbase) {
+
+	return dbase->modified;
+}
 
 static void dbase_policydb_drop_cache(
-	semanage_handle_t* handle,
 	dbase_policydb_t* dbase) {
 
 	if (dbase->cached) {
@@ -142,8 +147,6 @@ static void dbase_policydb_drop_cache(
 		dbase->cached = 0;
 		dbase->modified = 0;
 	}
-
-	handle = NULL;
 }
 
 int dbase_policydb_init(
@@ -179,10 +182,9 @@ int dbase_policydb_init(
 
 /* Release dbase resources */
 void dbase_policydb_release(
-	semanage_handle_t* handle,
 	dbase_policydb_t* dbase) {
 
-	dbase_policydb_drop_cache(handle, dbase);
+	dbase_policydb_drop_cache(dbase);
 	free(dbase);
 }
 
@@ -191,23 +193,20 @@ void dbase_policydb_release(
  * and prevents flush() and drop_cache()
  * until detached. */
 void dbase_policydb_attach(
-        semanage_handle_t* handle,
         dbase_policydb_t* dbase,
         sepol_policydb_t* policydb) {
 
 	dbase->attached = 1;
-	dbase_policydb_drop_cache(handle, dbase);
+	dbase_policydb_drop_cache(dbase);
 	dbase->policydb = policydb;
 }
 
 /* Detach from a shared policdb.
  * This implies drop_cache. */
 void dbase_policydb_detach(
-	semanage_handle_t* handle,
 	dbase_policydb_t* dbase) {
 
 	dbase->attached = 0;
-	handle = NULL;
 }
 
 static int dbase_policydb_add (
@@ -411,18 +410,21 @@ static int dbase_policydb_list (
 }
 
 static record_table_t* dbase_policydb_get_rtable(
-	semanage_handle_t* handle,
 	dbase_policydb_t* dbase) {
 
-	handle = NULL;
 	return dbase->rtable;
 }
 
 /* POLICYDB dbase - method table implementation */
 dbase_table_t SEMANAGE_POLICYDB_DTABLE = {
+
+	/* Cache/Transactions */
 	.cache = dbase_policydb_cache,
 	.drop_cache = dbase_policydb_drop_cache,
 	.flush = dbase_policydb_flush,
+	.is_modified = dbase_policydb_is_modified,
+
+	/* Database Functionality */
 	.iterate = dbase_policydb_iterate,
 	.exists = dbase_policydb_exists,
 	.list = dbase_policydb_list,
@@ -432,5 +434,7 @@ dbase_table_t SEMANAGE_POLICYDB_DTABLE =
 	.modify = dbase_policydb_modify, 
 	.query = dbase_policydb_query,
 	.count = dbase_policydb_count,
+
+	/* Polymorphism */
 	.get_rtable = dbase_policydb_get_rtable
 };
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database_policydb.h new/libsemanage/src/database_policydb.h
--- old/libsemanage/src/database_policydb.h	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/database_policydb.h	2005-11-03 23:53:44.000000000 -0500
@@ -77,19 +77,16 @@ extern int dbase_policydb_init(
  * and prevents flush() and drop_cache()
  * until detached. */ 
 extern void dbase_policydb_attach(
-	semanage_handle_t* handle,
 	dbase_policydb_t* dbase,
 	sepol_policydb_t* policydb);
 
 /* Detach from a shared policdb.
  * This implies drop_cache. */
 extern void dbase_policydb_detach(
-	semanage_handle_t* handle,
 	dbase_policydb_t* dbase);
 
 /* Release allocated resources */
 extern void dbase_policydb_release(
-	semanage_handle_t* handle,
 	dbase_policydb_t* dbase);
 
 /* POLICYDB database - method table implementation */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/direct_api.c	2005-11-03 23:51:53.000000000 -0500
@@ -152,16 +152,16 @@ static int semanage_direct_disconnect(se
 	sh->sepolh = NULL;
 
 	/* Remove object databases */
-	user_file_dbase_release(sh, semanage_user_dbase_local(sh));
-	port_file_dbase_release(sh, semanage_port_dbase_local(sh));
-	iface_file_dbase_release(sh, semanage_iface_dbase_local(sh));
-	bool_file_dbase_release(sh, semanage_bool_dbase_local(sh));
-	seuser_file_dbase_release(sh, semanage_seuser_dbase(sh));
-
-	user_policydb_dbase_release(sh, semanage_user_dbase_policy(sh));
-	port_policydb_dbase_release(sh, semanage_port_dbase_policy(sh));
-	iface_policydb_dbase_release(sh, semanage_iface_dbase_policy(sh));
-	bool_policydb_dbase_release(sh, semanage_bool_dbase_policy(sh));
+	user_file_dbase_release(semanage_user_dbase_local(sh));
+	port_file_dbase_release(semanage_port_dbase_local(sh));
+	iface_file_dbase_release(semanage_iface_dbase_local(sh));
+	bool_file_dbase_release(semanage_bool_dbase_local(sh));
+	seuser_file_dbase_release(semanage_seuser_dbase(sh));
+
+	user_policydb_dbase_release(semanage_user_dbase_policy(sh));
+	port_policydb_dbase_release(semanage_port_dbase_policy(sh));
+	iface_policydb_dbase_release(semanage_iface_dbase_policy(sh));
+	bool_policydb_dbase_release(semanage_bool_dbase_policy(sh));
 
 	return 0;
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_file.c new/libsemanage/src/interfaces_file.c
--- old/libsemanage/src/interfaces_file.c	2005-11-03 12:48:03.000000000 -0500
+++ new/libsemanage/src/interfaces_file.c	2005-11-03 23:49:54.000000000 -0500
@@ -165,8 +165,7 @@ int iface_file_dbase_init(
 }
 
 void iface_file_dbase_release(
-	semanage_handle_t* handle,
 	dbase_config_t* dconfig) {
 
-	dbase_file_release(handle, dconfig->dbase);
+	dbase_file_release(dconfig->dbase);
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_file.h new/libsemanage/src/interfaces_file.h
--- old/libsemanage/src/interfaces_file.h	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/interfaces_file.h	2005-11-03 23:50:41.000000000 -0500
@@ -9,7 +9,6 @@ int iface_file_dbase_init(
 	dbase_config_t* dconfig);
 
 void iface_file_dbase_release(
-	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
 
 #endif 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_policydb.c new/libsemanage/src/interfaces_policydb.c
--- old/libsemanage/src/interfaces_policydb.c	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/interfaces_policydb.c	2005-11-03 23:49:45.000000000 -0500
@@ -45,8 +45,7 @@ int iface_policydb_dbase_init(
 }
 
 void iface_policydb_dbase_release(
-	semanage_handle_t* handle, 
 	dbase_config_t* dconfig) {
 
-	dbase_policydb_release(handle, dconfig->dbase);
+	dbase_policydb_release(dconfig->dbase);
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_policydb.h new/libsemanage/src/interfaces_policydb.h
--- old/libsemanage/src/interfaces_policydb.h	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/interfaces_policydb.h	2005-11-03 23:50:47.000000000 -0500
@@ -9,7 +9,6 @@ int iface_policydb_dbase_init(
 	dbase_config_t* dconfig);
 
 void iface_policydb_dbase_release(
-	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
 
 #endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2005-11-03 23:54:09.000000000 -0500
@@ -25,7 +25,7 @@ static int load_handler(
 	semanage_handle_t* handle = arg->handle;
 	dbase_t* dbase = arg->dconfig->dbase;
 	dbase_table_t* dtable = arg->dconfig->dtable;
-	record_table_t* rtable = dtable->get_rtable(handle, dbase);	
+	record_table_t* rtable = dtable->get_rtable(dbase);	
 
 	if (rtable->key_extract(handle, record, &rkey) < 0)
 		goto err;
@@ -140,8 +140,7 @@ int semanage_commit_components(
 
 	/* Drop cache, because we're leaving transaction soon */
 	for (i=0; i < CCOUNT; i++)
-		components[i]->dtable->drop_cache(
-			handle, components[i]->dbase);
+		components[i]->dtable->drop_cache(components[i]->dbase);
 
 
 	return STATUS_SUCCESS;
@@ -150,7 +149,6 @@ int semanage_commit_components(
 	ERR(handle, "could not commit local modifications");
 
 	for (i=0; i < CCOUNT; i++) 
-		components[i]->dtable->drop_cache(
-			handle, components[i]->dbase);
+		components[i]->dtable->drop_cache(components[i]->dbase);
 	return STATUS_ERR;
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2005-11-03 12:48:03.000000000 -0500
+++ new/libsemanage/src/ports_file.c	2005-11-03 23:49:22.000000000 -0500
@@ -172,8 +172,7 @@ int port_file_dbase_init(
 }
 
 void port_file_dbase_release(
-	semanage_handle_t* handle,
 	dbase_config_t* dconfig) {
 
-	dbase_file_release(handle, dconfig->dbase);
+	dbase_file_release(dconfig->dbase);
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_file.h new/libsemanage/src/ports_file.h
--- old/libsemanage/src/ports_file.h	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/ports_file.h	2005-11-03 23:51:10.000000000 -0500
@@ -9,7 +9,6 @@ int port_file_dbase_init(
 	dbase_config_t* dconfig);
 
 void port_file_dbase_release(
-	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
 
 #endif 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_policydb.c new/libsemanage/src/ports_policydb.c
--- old/libsemanage/src/ports_policydb.c	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/ports_policydb.c	2005-11-03 23:49:35.000000000 -0500
@@ -46,8 +46,7 @@ int port_policydb_dbase_init(
 }
 
 void port_policydb_dbase_release(
-	semanage_handle_t* handle,
 	dbase_config_t* dconfig) {
 
-	dbase_policydb_release(handle, dconfig->dbase);
+	dbase_policydb_release(dconfig->dbase);
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_policydb.h new/libsemanage/src/ports_policydb.h
--- old/libsemanage/src/ports_policydb.h	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/ports_policydb.h	2005-11-03 23:51:05.000000000 -0500
@@ -9,7 +9,6 @@ int port_policydb_dbase_init(
 	dbase_config_t* dconfig);
 
 void port_policydb_dbase_release(
-	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
 
 #endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/semanage_store.c	2005-11-03 23:53:30.000000000 -0500
@@ -1362,17 +1362,17 @@ int semanage_expand_sandbox(semanage_han
 		goto cleanup;
 	}
 
-	dbase_policydb_attach(sh, semanage_user_dbase_policy(sh)->dbase, out);
-	dbase_policydb_attach(sh, semanage_port_dbase_policy(sh)->dbase, out);
-	dbase_policydb_attach(sh, semanage_iface_dbase_policy(sh)->dbase, out);
-	dbase_policydb_attach(sh, semanage_bool_dbase_policy(sh)->dbase, out);
+	dbase_policydb_attach(semanage_user_dbase_policy(sh)->dbase, out);
+	dbase_policydb_attach(semanage_port_dbase_policy(sh)->dbase, out);
+	dbase_policydb_attach(semanage_iface_dbase_policy(sh)->dbase, out);
+	dbase_policydb_attach(semanage_bool_dbase_policy(sh)->dbase, out);
 
 	retval = semanage_base_merge_components(sh);
 
-	dbase_policydb_detach(sh, semanage_user_dbase_policy(sh)->dbase);
-        dbase_policydb_detach(sh, semanage_port_dbase_policy(sh)->dbase);
-        dbase_policydb_detach(sh, semanage_iface_dbase_policy(sh)->dbase);
-        dbase_policydb_detach(sh, semanage_bool_dbase_policy(sh)->dbase);
+	dbase_policydb_detach(semanage_user_dbase_policy(sh)->dbase);
+        dbase_policydb_detach(semanage_port_dbase_policy(sh)->dbase);
+        dbase_policydb_detach(semanage_iface_dbase_policy(sh)->dbase);
+        dbase_policydb_detach(semanage_bool_dbase_policy(sh)->dbase);
 
 	if (retval < 0) {
 		ERR(sh, "Unable to merge local modifications into policy.");
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/seusers_file.c new/libsemanage/src/seusers_file.c
--- old/libsemanage/src/seusers_file.c	2005-11-03 17:18:24.000000000 -0500
+++ new/libsemanage/src/seusers_file.c	2005-11-03 23:50:30.000000000 -0500
@@ -136,8 +136,7 @@ int seuser_file_dbase_init(
 }
 
 void seuser_file_dbase_release(
-	semanage_handle_t* handle,
 	dbase_config_t* dconfig) {
 
-	dbase_file_release(handle, dconfig->dbase);
+	dbase_file_release(dconfig->dbase);
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/seusers_file.h new/libsemanage/src/seusers_file.h
--- old/libsemanage/src/seusers_file.h	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/seusers_file.h	2005-11-03 23:50:34.000000000 -0500
@@ -9,7 +9,6 @@ int seuser_file_dbase_init(
 	dbase_config_t* dconfig);
 
 void seuser_file_dbase_release(
-	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
 
 #endif 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2005-11-03 12:48:03.000000000 -0500
+++ new/libsemanage/src/users_file.c	2005-11-03 23:48:59.000000000 -0500
@@ -229,8 +229,7 @@ int user_file_dbase_init(
 }
 
 void user_file_dbase_release(
-	semanage_handle_t* handle,
 	dbase_config_t* dconfig) {
 
-	dbase_file_release(handle, dconfig->dbase);
+	dbase_file_release(dconfig->dbase);
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_file.h new/libsemanage/src/users_file.h
--- old/libsemanage/src/users_file.h	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/users_file.h	2005-11-03 23:51:26.000000000 -0500
@@ -9,7 +9,6 @@ int user_file_dbase_init(
 	dbase_config_t* dconfig);
 
 void user_file_dbase_release(
-	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
 
 #endif 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_policydb.c new/libsemanage/src/users_policydb.c
--- old/libsemanage/src/users_policydb.c	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/users_policydb.c	2005-11-03 23:49:12.000000000 -0500
@@ -45,8 +45,7 @@ int user_policydb_dbase_init(
 }
 
 void user_policydb_dbase_release(
-	semanage_handle_t* handle, 
 	dbase_config_t* dconfig) {
 
-	dbase_policydb_release(handle, dconfig->dbase);
+	dbase_policydb_release(dconfig->dbase);
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_policydb.h new/libsemanage/src/users_policydb.h
--- old/libsemanage/src/users_policydb.h	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/users_policydb.h	2005-11-03 23:51:19.000000000 -0500
@@ -9,7 +9,6 @@ int user_policydb_dbase_init(
 	dbase_config_t* dconfig);
 
 void user_policydb_dbase_release(
-	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
 
 #endif

--------------080706050707020309090406--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
