Message-ID: <43C64D9E.4080009@cornell.edu>
Date: Thu, 12 Jan 2006 05:37:50 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Bugfixes
Content-Type: multipart/mixed;
 boundary="------------070509080800010408080706"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070509080800010408080706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Various bugfixes and improvements for recent code:

- rename del_all -> clear, since I like that better
- remove requirement to run cache() prior to clear (change spec, and 
implementation)
  (and stop running it in join, that's ridiculous)
- BUGFIX: add clear pointer to activedb backend method table

- do not test for NULL record after record->split(), split is not 
allowed to return NULL
- remove old FIXME from fcontexts_local

- BUGFIX: clear user_extras (policy) dbase in apply_local_changes() 
function. Otherwise previous changes are left over, and that's not what 
we want - we want build from scratch. This is the equivalent of making a 
new policydb, or the direct_api.c processing that rebuilds the 
file_contexts file from the one in the package.

--------------070509080800010408080706
Content-Type: text/x-patch;
 name="libsemanage.bugfixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.bugfixes.diff"

diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/database_activedb.c new/libsemanage/src/database_activedb.c
--- old/libsemanage/src/database_activedb.c	2006-01-12 03:44:37.000000000 -0700
+++ new/libsemanage/src/database_activedb.c	2006-01-12 05:26:08.000000000 -0700
@@ -157,6 +157,7 @@ dbase_table_t SEMANAGE_ACTIVEDB_DTABLE =
 	.add = (void*) dbase_llist_add,
 	.set = (void*) dbase_llist_set,
 	.del = (void*) dbase_llist_del, 
+	.clear = (void*) dbase_llist_clear,
 	.modify = (void*) dbase_llist_modify, 
 	.query = (void*) dbase_llist_query, 
 	.count = (void*) dbase_llist_count, 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2006-01-12 03:47:32.000000000 -0700
+++ new/libsemanage/src/database_file.c	2006-01-12 05:20:08.000000000 -0700
@@ -228,7 +228,7 @@ dbase_table_t SEMANAGE_FILE_DTABLE = {
 	.add = (void*) dbase_llist_add,
 	.set = (void*) dbase_llist_set,
 	.del = (void*) dbase_llist_del, 
-	.del_all = (void*) dbase_llist_del_all,
+	.clear = (void*) dbase_llist_clear,
 	.modify = (void*) dbase_llist_modify, 
 	.query = (void*) dbase_llist_query, 
 	.count = (void*) dbase_llist_count, 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/database.h new/libsemanage/src/database.h
--- old/libsemanage/src/database.h	2006-01-12 03:47:32.000000000 -0700
+++ new/libsemanage/src/database.h	2006-01-12 05:22:07.000000000 -0700
@@ -110,8 +110,10 @@ typedef struct dbase_table {
 		dbase_t* dbase,
 		const record_key_t* key);
 
-	/* Delete all records */
-	int (*del_all) (
+	/* Clear all records, and leave the database in
+	 * cached, modified state. This function does 
+	 * not require a call to cache() */
+	int (*clear) (
 		struct semanage_handle* handle,
 		dbase_t* dbase);
 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/database_join.c new/libsemanage/src/database_join.c
--- old/libsemanage/src/database_join.c	2006-01-12 04:00:00.000000000 -0700
+++ new/libsemanage/src/database_join.c	2006-01-12 05:26:41.000000000 -0700
@@ -183,23 +183,14 @@ static int dbase_join_flush(
 	    !dbase_llist_is_modified(&dbase->llist))
 		return STATUS_SUCCESS;
 
-	/* First cache any dbase, (which should already be cached
-	 * unless somebody did a drop_cache on the underlying 
-	 * databases while we were working on the join, so this probably 
-	 * doesn't do anything - it's just a precaution) */
-	if (dtable1->cache(handle, dbase1) < 0)
-		goto err;
-	if (dtable2->cache(handle, dbase2) < 0)
-		goto err;
-
 	/* Then clear all records from the cache.
 	 * This is *not* the same as dropping the cache - it's an explicit
 	 * request to delete all current records. We need to do 
 	 * this because we don't store delete deltas for the join,
 	 * so we must re-add all records from scratch */
-	if (dtable1->del_all(handle, dbase1) < 0)
+	if (dtable1->clear(handle, dbase1) < 0)
 		goto err;
-	if (dtable2->del_all(handle, dbase2) < 0)
+	if (dtable2->clear(handle, dbase2) < 0)
 		goto err;
 
 	/* For each record, split, and add parts into their corresponding databases */
@@ -212,10 +203,10 @@ static int dbase_join_flush(
 			&record1, &record2) < 0)
 			goto err;
 
-		if (record1 && dtable1->add(handle, dbase1, rkey, record1) < 0)
+		if (dtable1->add(handle, dbase1, rkey, record1) < 0)
 			goto err;
 	
-		if (record2 && dtable2->add(handle, dbase2, rkey, record2) < 0)
+		if (dtable2->add(handle, dbase2, rkey, record2) < 0)
 			goto err;
 
 		rtable->key_free(rkey);
@@ -294,7 +285,7 @@ dbase_table_t SEMANAGE_JOIN_DTABLE = {
 	.add = (void*) dbase_llist_add,
 	.set = (void*) dbase_llist_set,
 	.del = (void*) dbase_llist_del, 
-	.del_all = (void*) dbase_llist_del_all,
+	.clear = (void*) dbase_llist_clear,
 	.modify = (void*) dbase_llist_modify, 
 	.query = (void*) dbase_llist_query, 
 	.count = (void*) dbase_llist_count, 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/database_llist.c new/libsemanage/src/database_llist.c
--- old/libsemanage/src/database_llist.c	2006-01-12 03:47:32.000000000 -0700
+++ new/libsemanage/src/database_llist.c	2006-01-12 05:21:46.000000000 -0700
@@ -288,21 +288,24 @@ int dbase_llist_del(
 	return STATUS_SUCCESS;
 }
 
-int dbase_llist_del_all(
+int dbase_llist_clear(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase) {
 
-	cache_entry_t *prev, *ptr = dbase->cache;
-	while (ptr != NULL) {
-		prev = ptr;
-		ptr = ptr->next;
-		dbase->rtable->free(prev->data);
-		free(prev);
-        }
+	if (dbase->cached) {
+		cache_entry_t *prev, *ptr = dbase->cache;
+		while (ptr != NULL) {
+			prev = ptr;
+			ptr = ptr->next;
+			dbase->rtable->free(prev->data);
+			free(prev);
+	        }
+	}
 
 	dbase->cache = NULL;
 	dbase->cache_tail = NULL;
 	dbase->cache_sz = 0;
+	dbase->cached = 1;
         dbase->modified = 1;
 	handle = NULL;
 	return STATUS_SUCCESS;
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/database_llist.h new/libsemanage/src/database_llist.h
--- old/libsemanage/src/database_llist.h	2006-01-12 03:47:32.000000000 -0700
+++ new/libsemanage/src/database_llist.h	2006-01-12 05:26:16.000000000 -0700
@@ -138,7 +138,7 @@ extern int dbase_llist_del(
 	dbase_llist_t* dbase,
 	const record_key_t* key);
 
-extern int dbase_llist_del_all(
+extern int dbase_llist_clear(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase);
 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2006-01-12 03:47:32.000000000 -0700
+++ new/libsemanage/src/database_policydb.c	2006-01-12 05:20:22.000000000 -0700
@@ -284,7 +284,7 @@ static int dbase_policydb_del (
 	return STATUS_ERR;
 }
 
-static int dbase_policydb_del_all (
+static int dbase_policydb_clear (
 	semanage_handle_t* handle,
 	dbase_policydb_t* dbase) {
 
@@ -453,7 +453,7 @@ dbase_table_t SEMANAGE_POLICYDB_DTABLE =
 	.add = dbase_policydb_add,
 	.set = dbase_policydb_set,
 	.del = dbase_policydb_del,
-	.del_all = dbase_policydb_del_all,
+	.clear = dbase_policydb_clear,
 	.modify = dbase_policydb_modify, 
 	.query = dbase_policydb_query,
 	.count = dbase_policydb_count,
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/fcontexts_local.c new/libsemanage/src/fcontexts_local.c
--- old/libsemanage/src/fcontexts_local.c	2006-01-11 16:23:42.000000000 -0700
+++ new/libsemanage/src/fcontexts_local.c	2006-01-12 05:23:02.000000000 -0700
@@ -101,8 +101,6 @@ static int validate_handler(
 	const char* type_str = semanage_fcontext_get_type_str(fcon);
 	semanage_context_t* con = semanage_fcontext_get_con(fcon);
 
-	/* FIXME: verify expr? */
-	
 	if (sepol_context_check(handle->sepolh, policydb, con) < 0)
 		goto invalid;
 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2006-01-12 04:29:52.000000000 -0700
+++ new/libsemanage/src/semanage_store.c	2006-01-12 05:28:23.000000000 -0700
@@ -1399,6 +1399,12 @@ int semanage_apply_local_changes(
 	dbase_t* fcdbase = semanage_fcontext_dbase_policy(sh)->dbase;
 	fcdtable->drop_cache(fcdbase);
 
+	/* Clear the users_extra dbase completely */
+	dbase_table_t* uedtable = semanage_user_extra_dbase_policy(sh)->dtable;
+	dbase_t* uedbase = semanage_user_extra_dbase_policy(sh)->dbase;
+	if (uedtable->clear(sh, uedbase) < 0)
+		goto exit;	
+
 	/* Similarly, attaching the policydb will erase any existing cache */	
 	dbase_policydb_attach(semanage_user_base_dbase_policy(sh)->dbase, out);
 	dbase_policydb_attach(semanage_port_dbase_policy(sh)->dbase, out);
@@ -1412,6 +1418,7 @@ int semanage_apply_local_changes(
         dbase_policydb_detach(semanage_iface_dbase_policy(sh)->dbase);
         dbase_policydb_detach(semanage_bool_dbase_policy(sh)->dbase);
 
+	exit:
 	return retval;
 }
 

--------------070509080800010408080706--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
