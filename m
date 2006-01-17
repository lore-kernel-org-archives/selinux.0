Message-ID: <43CD16C3.60603@cornell.edu>
Date: Tue, 17 Jan 2006 09:09:39 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [SEMANAGE] Improve cache management
Content-Type: multipart/mixed;
 boundary="------------080505070205020200080208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080505070205020200080208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changelog:

- add get_serial() function to the policy.h interface, which provides a 
way to get a serial/commit number for both direct and pserver. This 
removes part of the dependency of database.* on semanage_store, which we 
need to get rid of, to support the policy server.

- remove policy_serial variable from the handle, I don't see it being 
used. It can be added back when necessary. I am not sure the serial at 
connect time is very important.

- On cache(), check not only if cache exists, but also if it needs 
resync (expired). Do this by storing the serial on every cache(), and 
comparing the stored serial against the current one. Stop calling 
drop_cache() on exiting a read-only dbase call, so the caller can 
benefit from the cache as long as it's valid. Also, don't call 
drop_cache() on successful commit, since it will be invalidated 
automatically by the serial increase.

- Some other simplifications - assume the modified flag implies cached, 
and don't check both on flush(). Set modified =0 in policydb_detach().

--------------080505070205020200080208
Content-Type: text/x-patch;
 name="libsemanage.cache_management.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.cache_management.diff"

diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/src/database_activedb.c new/libsemanage/src/database_activedb.c
--- old/libsemanage/src/database_activedb.c	2006-01-13 06:37:33.000000000 -0700
+++ new/libsemanage/src/database_activedb.c	2006-01-17 06:25:45.000000000 -0700
@@ -41,7 +41,7 @@ static int dbase_activedb_cache(
 	unsigned int i = 0;
 
 	/* Already cached */
-	if (dbase_llist_is_cached(&dbase->llist))
+	if (!dbase_llist_needs_resync(handle, &dbase->llist))
 		return STATUS_SUCCESS;
 
 	dbase_llist_cache_init(&dbase->llist);
@@ -57,8 +57,11 @@ static int dbase_activedb_cache(
 		rtable->free(records[i]);
 	}
 
+	/* Update cache serial */
+	if (dbase_llist_set_serial(handle, &dbase->llist) < 0)
+		goto err;
+
 	free(records);
-	dbase_llist_set_cached(&dbase->llist, 1);
 	return STATUS_SUCCESS;
 
 	err:
@@ -81,8 +84,7 @@ static int dbase_activedb_flush(
 	unsigned int i;
 
 	/* Not cached, or not modified - flush is not necessary */
-	if (!dbase_llist_is_cached(&dbase->llist) ||
-	    !dbase_llist_is_modified(&dbase->llist))
+	if (!dbase_llist_is_modified(&dbase->llist))
 		return STATUS_SUCCESS;
 
 	/* Fetch list */
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/src/database.c new/libsemanage/src/database.c
--- old/libsemanage/src/database.c	2006-01-13 06:37:33.000000000 -0700
+++ new/libsemanage/src/database.c	2006-01-17 06:14:17.000000000 -0700
@@ -49,12 +49,11 @@ static inline int exit_ro(
 	semanage_handle_t* handle,
 	dbase_config_t* dconfig) {
 
-	int commit_num = semanage_get_commit_number(handle);
+	int commit_num = handle->funcs->get_serial(handle); 
 
-	if (!handle->is_in_transaction) {
+	if (!handle->is_in_transaction) 
 		semanage_release_active_lock(handle);
-		dconfig->dtable->drop_cache(dconfig->dbase);
-	}
+
 	return commit_num;
 }
 
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2006-01-13 06:37:33.000000000 -0700
+++ new/libsemanage/src/database_file.c	2006-01-17 06:24:52.000000000 -0700
@@ -73,7 +73,7 @@ static int dbase_file_cache(
 	char* fname = NULL;
 
 	/* Already cached */
-	if (dbase_llist_is_cached(&dbase->llist))
+	if (!dbase_llist_needs_resync(handle, &dbase->llist))
 		return STATUS_SUCCESS;
 
 	dbase_llist_cache_init(&dbase->llist);
@@ -115,11 +115,14 @@ static int dbase_file_cache(
 
 	} while (pstatus != STATUS_NODATA);
 
+	/* Update cache serial */
+	if (dbase_llist_set_serial(handle, &dbase->llist) < 0)
+		goto err;
+
 	rtable->free(process_record);
 	parse_close(parse_info);
 	parse_release(parse_info);
 	free(fname);
-	dbase_llist_set_cached(&dbase->llist, 1);
 	return STATUS_SUCCESS;
 
 	err:
@@ -142,8 +145,7 @@ static int dbase_file_flush(
 	char* fname = NULL;
 	FILE* str = NULL;
 
-	if (!dbase_llist_is_cached(&dbase->llist) ||
-	    !dbase_llist_is_modified(&dbase->llist))
+	if (!dbase_llist_is_modified(&dbase->llist))
 		return STATUS_SUCCESS;
 
 	if (construct_filename(handle, dbase, &fname) < 0)
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/src/database.h new/libsemanage/src/database.h
--- old/libsemanage/src/database.h	2006-01-13 06:37:33.000000000 -0700
+++ new/libsemanage/src/database.h	2006-01-17 06:14:08.000000000 -0700
@@ -181,7 +181,9 @@ typedef struct dbase_table {
 
 	/* Cache the database (if supported).
 	 * This function must be invoked before using
-	 * any of the database functions above */
+	 * any of the database functions above. It may be invoked
+	 * multiple times, and will update the cache if a commit
+	 * occured between invocations */
 	int (*cache) (
 		struct semanage_handle* handle,
 		dbase_t* dbase);
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/src/database_join.c new/libsemanage/src/database_join.c
--- old/libsemanage/src/database_join.c	2006-01-17 09:05:06.000000000 -0700
+++ new/libsemanage/src/database_join.c	2006-01-17 09:04:51.000000000 -0700
@@ -55,7 +55,7 @@ static int dbase_join_cache(
 	unsigned int rcount1 = 0, rcount2 = 0, i = 0, j = 0;
 
 	/* Already cached */
-	if (dbase_llist_is_cached(&dbase->llist))
+	if (!dbase_llist_needs_resync(handle, &dbase->llist))
 		return STATUS_SUCCESS;
 	
 	dbase_llist_cache_init(&dbase->llist);
@@ -135,7 +135,9 @@ static int dbase_join_cache(
 		record = NULL;
 	}
 
-	dbase_llist_set_cached(&dbase->llist, 1);
+	/* Update cache serial */
+	if (dbase_llist_set_serial(handle, &dbase->llist) < 0)
+		goto err;
 
 	for (i=0; i < rcount1; i++)
 		rtable1->free(records1[i]);
@@ -179,8 +181,7 @@ static int dbase_join_flush(
 	record2_t* record2 = NULL;
 
 	/* No effect of flush */
-	if (!dbase_llist_is_cached(&dbase->llist) ||
-	    !dbase_llist_is_modified(&dbase->llist))
+	if (!dbase_llist_is_modified(&dbase->llist))
 		return STATUS_SUCCESS;
 
 	/* Then clear all records from the cache.
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/src/database_llist.c new/libsemanage/src/database_llist.c
--- old/libsemanage/src/database_llist.c	2006-01-13 06:37:33.000000000 -0700
+++ new/libsemanage/src/database_llist.c	2006-01-17 08:17:07.000000000 -0700
@@ -13,6 +13,27 @@ typedef struct dbase_llist dbase_t;
 #include "handle.h"
 #include "database_llist.h"
 
+int dbase_llist_needs_resync(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase) {
+
+	int cache_serial;
+
+	if (dbase->cache_serial < 0)
+		return 1;
+
+	cache_serial = handle->funcs->get_serial(handle);
+	if (cache_serial < 0)
+		return 1;
+
+	if (cache_serial != dbase->cache_serial) {
+		dbase_llist_drop_cache(dbase);
+		dbase->cache_serial = -1;
+		return 1;
+	}
+	return 0;
+}
+
 /* Helper for adding records to the cache */
 int dbase_llist_cache_prepend(
 	semanage_handle_t* handle, 
@@ -52,7 +73,7 @@ int dbase_llist_cache_prepend(
 void dbase_llist_drop_cache(
 	dbase_llist_t* dbase) {
 
-	if (!dbase->cached)
+	if (dbase->cache_serial < 0) 
 		return;
 
 	cache_entry_t *prev, *ptr = dbase->cache;
@@ -63,10 +84,24 @@ void dbase_llist_drop_cache(
 		free(prev);
 	}
 
-	dbase->cached = 0;
+	dbase->cache_serial = -1;
 	dbase->modified = 0;
-}	
+}
 
+int dbase_llist_set_serial(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase) {
+
+	int cache_serial = handle->funcs->get_serial(handle);
+	if (cache_serial < 0) {
+		ERR(handle, "could not update cache serial");
+		return STATUS_ERR;
+	}
+
+	dbase->cache_serial = cache_serial;
+	return STATUS_SUCCESS;
+}
+	
 /* Helper for finding records in the cache */
 static int dbase_llist_cache_locate(
 	semanage_handle_t* handle,
@@ -292,7 +327,7 @@ int dbase_llist_clear(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase) {
 
-	if (dbase->cached) {
+	if (dbase->cache_serial >= 0) {
 		cache_entry_t *prev, *ptr = dbase->cache;
 		while (ptr != NULL) {
 			prev = ptr;
@@ -305,9 +340,7 @@ int dbase_llist_clear(
 	dbase->cache = NULL;
 	dbase->cache_tail = NULL;
 	dbase->cache_sz = 0;
-	dbase->cached = 1;
-        dbase->modified = 1;
-	handle = NULL;
+	dbase->modified = 1;
 	return STATUS_SUCCESS;
 }
 
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/src/database_llist.h new/libsemanage/src/database_llist.h
--- old/libsemanage/src/database_llist.h	2006-01-13 06:37:33.000000000 -0700
+++ new/libsemanage/src/database_llist.h	2006-01-17 06:24:12.000000000 -0700
@@ -25,7 +25,7 @@ typedef struct dbase_llist {
 	cache_entry_t* cache_tail;
 
 	unsigned int cache_sz;
-	int cached;
+	int cache_serial;
 	int modified;
 } dbase_llist_t;
 
@@ -37,7 +37,7 @@ static inline void dbase_llist_cache_ini
 	dbase->cache = NULL;
 	dbase->cache_tail = NULL;
 	dbase->cache_sz = 0;
-	dbase->cached = 0;
+	dbase->cache_serial = -1;
 	dbase->modified = 0;
 }
 
@@ -56,16 +56,13 @@ extern int dbase_llist_cache_prepend(
 	dbase_llist_t* dbase,
 	const record_t* data);
 
-static inline int dbase_llist_is_cached(
-	dbase_llist_t* dbase) {
-	return dbase->cached;
-}
+extern int dbase_llist_needs_resync(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase);
 
-static inline void dbase_llist_set_cached(
-	dbase_llist_t* dbase,
-	int status) {
-	dbase->cached = status;
-}
+extern int dbase_llist_set_serial(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase);
 
 static inline void dbase_llist_set_modified(
 	dbase_llist_t* dbase,
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2006-01-13 06:37:33.000000000 -0700
+++ new/libsemanage/src/database_policydb.c	2006-01-17 08:59:14.000000000 -0700
@@ -35,11 +35,57 @@ struct dbase_policydb {
 	record_policydb_table_t* rptable;
 
 	sepol_policydb_t* policydb;
-	int cached;
+
+	int cache_serial;
 	int modified;
 	int attached;
 };
 
+static void dbase_policydb_drop_cache(
+	dbase_policydb_t* dbase) {
+
+	if (dbase->cache_serial >= 0) {
+		sepol_policydb_free(dbase->policydb);
+		dbase->cache_serial = -1;
+		dbase->modified = 0;
+	}
+}
+
+static int dbase_policydb_set_serial(
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase) {
+
+	int cache_serial = handle->funcs->get_serial(handle);
+	if (cache_serial < 0) {
+		ERR(handle, "could not update cache serial");
+		return STATUS_ERR;
+	}
+
+	dbase->cache_serial = cache_serial;
+	return STATUS_SUCCESS;
+}
+
+static int dbase_policydb_needs_resync(
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase) {
+
+	int cache_serial;
+
+	if (dbase->cache_serial < 0)
+		return 1;
+		
+	cache_serial = handle->funcs->get_serial(handle);
+	if (cache_serial < 0)
+		return 1;
+
+	if (cache_serial != dbase->cache_serial) {
+		dbase_policydb_drop_cache(dbase);
+		dbase->cache_serial = -1;
+		return 1;
+	}
+	return 0;
+}
+
 static int construct_filename(
 	semanage_handle_t* handle,
 	dbase_policydb_t* dbase,
@@ -70,8 +116,11 @@ static int dbase_policydb_cache(
 	sepol_policy_file_t* pf = NULL;
 	char* fname = NULL;
 
-	/* Already cached */
-	if (dbase->cached || dbase->attached)
+	/* Check if cache is needed */
+	if (dbase->attached)
+		return STATUS_SUCCESS;
+
+	if (!dbase_policydb_needs_resync(handle, dbase))
 		return STATUS_SUCCESS;
 	
 	if (construct_filename(handle, dbase, &fname) < 0) 
@@ -109,11 +158,13 @@ static int dbase_policydb_cache(
 		fclose(fp);
 	}
 
-	/* Either way, update the database policydb */	
-	dbase->policydb = policydb;
+	/* Update cache serial */
+	if (dbase_policydb_set_serial(handle, dbase) < 0)
+		goto err;
 
+	/* Update the database policydb */	
+	dbase->policydb = policydb;
 	free(fname);
-	dbase->cached = 1;
 	return STATUS_SUCCESS;
 
 	err:
@@ -124,14 +175,13 @@ static int dbase_policydb_cache(
 	sepol_policy_file_free(pf);
 	free(fname);
 	return STATUS_ERR;
-
 }
 
 static int dbase_policydb_flush(
 	semanage_handle_t* handle,	
 	dbase_policydb_t* dbase) {
 
-	if (!dbase->modified || !dbase->cached)
+	if (!dbase->modified)
 		return STATUS_SUCCESS;
 
 	dbase->modified = 0;
@@ -148,16 +198,6 @@ static int dbase_policydb_is_modified(
 	return dbase->modified;
 }
 
-static void dbase_policydb_drop_cache(
-	dbase_policydb_t* dbase) {
-
-	if (dbase->cached) {
-		sepol_policydb_free(dbase->policydb);
-		dbase->cached = 0;
-		dbase->modified = 0;
-	}
-}
-
 int dbase_policydb_init(
 	semanage_handle_t* handle,
 	const char* suffix,
@@ -175,7 +215,7 @@ int dbase_policydb_init(
 	tmp_dbase->rtable = rtable;
 	tmp_dbase->rptable = rptable;
 	tmp_dbase->policydb = NULL;
-	tmp_dbase->cached = 0;
+	tmp_dbase->cache_serial = -1;
 	tmp_dbase->modified = 0;
 	tmp_dbase->attached = 0;
 	*dbase = tmp_dbase;
@@ -216,6 +256,7 @@ void dbase_policydb_detach(
 	dbase_policydb_t* dbase) {
 
 	dbase->attached = 0;
+	dbase->modified = 0;
 }
 
 static int dbase_policydb_add (
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2006-01-13 06:37:33.000000000 -0700
+++ new/libsemanage/src/direct_api.c	2006-01-17 08:14:55.000000000 -0700
@@ -61,6 +61,7 @@ static int semanage_direct_list(semanage
 				semanage_module_info_t **modinfo, int *num_modules);
 
 static struct semanage_policy_table direct_funcs = {
+	.get_serial = semanage_get_commit_number,
 	.destroy = semanage_direct_destroy,
 	.disconnect = semanage_direct_disconnect,
 	.begin_trans = semanage_direct_begintrans,
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/src/handle.h new/libsemanage/src/handle.h
--- old/libsemanage/src/handle.h	2006-01-13 06:37:33.000000000 -0700
+++ new/libsemanage/src/handle.h	2006-01-17 05:47:47.000000000 -0700
@@ -34,7 +34,6 @@
 
 struct semanage_handle {
 	int con_id;             /* Connection ID */
-	int policy_serial;      /* Policy serial number at connect time */
 
 	/* Error handling */
 	int msg_level;
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2006-01-13 06:37:33.000000000 -0700
+++ new/libsemanage/src/policy_components.c	2006-01-17 06:13:19.000000000 -0700
@@ -211,10 +211,6 @@ int semanage_commit_components(
 			goto err;
 	}
 
-	/* Drop cache, because we're leaving transaction soon */
-	for (i=0; i < CCOUNT; i++)
-		components[i]->dtable->drop_cache(components[i]->dbase);
-
 	return STATUS_SUCCESS;
 
 	err:
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/src/policy.h new/libsemanage/src/policy.h
--- old/libsemanage/src/policy.h	2005-11-09 07:52:55.000000000 -0700
+++ new/libsemanage/src/policy.h	2006-01-17 05:48:32.000000000 -0700
@@ -30,6 +30,10 @@ struct semanage_handle;
 /* Backend dependent portion */
 struct semanage_policy_table {
 
+	/* Returns the current policy serial/commit number
+	 * A negative number is returned in case of failre */
+	int (*get_serial)(struct semanage_handle*);
+
 	/* Destroy a connection */	
         void (*destroy)(struct semanage_handle*);
 

--------------080505070205020200080208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
