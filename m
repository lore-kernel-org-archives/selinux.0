Message-ID: <435AC7F5.7030602@cornell.edu>
Date: Sat, 22 Oct 2005 19:15:01 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>,
   Karl MacMillan <kmacmillan@tresys.com>
Subject: [ SEMANAGE 2 ] Fix dbase transactions
Content-Type: multipart/mixed;
 boundary="------------040606050306030103040108"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040606050306030103040108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes transactions (hopefully). After this patch (and the 
other 7 previously sent), I can successfully modify selinux users, and 
write the changes to local file, as well as load them in policy (with 
the if0-ed code)

Changes:
- do not drop cache when exiting read-only functions in-transaction
- do not acquire (or release) lock when working with read-only functions 
in-transaction
- drop cache after commit of components (do not wait for disconnect)
- do not call database functions within other database functions 
(enter_ro/exit_ro/enter_rw) are not reentrant
- fix memory leak on file_cache
- fix whitespace bug in user_print
- other minor tweaks

============

Note on in-transaction queries:
In transaction queries are good, because the cache is preserved on exit 
(after this patch). Therefore, subsequent reads do not have to rebuild 
the cache. So, if you wanted to call a bunch of read functions, it would 
be a good idea to do so in a transaction. However:

- in transaction queries on local objects reflect changes made during 
the transaction
- in transaction queries on policy objects do not reflect changes made 
during the transaction (because those are written on commit).


--------------040606050306030103040108
Content-Type: text/x-patch;
 name="libsemanage.fix_transactions.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.fix_transactions.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-10-22 14:55:38.000000000 -0400
+++ new/libsemanage/src/database_file.c	2005-10-22 18:37:51.000000000 -0400
@@ -84,13 +84,6 @@ static int dbase_file_cache(
 	semanage_handle_t* handle,
 	dbase_file_t* dbase) {
 
-	/* Already cached */
-	if (dbase->cached)
-		return STATUS_SUCCESS;
-	
-	dbase->cache_sz = 0;
-	dbase->cache = NULL;
-
 	int perr_fatal = 0;
 	/* FIXME: pass from caller? */
 
@@ -104,6 +97,9 @@ static int dbase_file_cache(
 	if (dbase->cached)
 		return STATUS_SUCCESS;
 
+	dbase->cache_sz = 0;
+	dbase->cache = NULL;
+
 	if (construct_filename(handle, dbase, &fname) < 0)
 		goto err;
 
@@ -132,19 +128,22 @@ static int dbase_file_cache(
 			continue;
 
 		/* End of file */
-		else if (pstatus == STATUS_NODATA)
+		else if (pstatus == STATUS_NODATA) 
 			break;
 
 		/* Add record to list */
 		if (dbase_file_cache_add(dbase, process_record) < 0)
 			goto err;
+		process_record = NULL;
 
 	} while (pstatus != STATUS_NODATA);
 
+	dbase->rtable->free(process_record);
 	parse_close(parse_info);
 	parse_release(parse_info);
 	free(fname);
 	dbase->cached = 1;
+
 	return STATUS_SUCCESS;
 
 	err:
@@ -222,18 +221,20 @@ static int enter_ro(
 	semanage_handle_t* handle,
 	dbase_file_t* dbase) {
 
-	if (semanage_get_active_lock(handle) < 0) {
-		ERR(handle, "could not get the active lock");
-		goto err;
+	if (!handle->is_in_transaction) {
+		if (semanage_get_active_lock(handle) < 0) {
+			ERR(handle, "could not get the active lock");
+			goto err;
+		}
 	}
-
+	
 	if (dbase_file_cache(handle, dbase) < 0) 
 		goto err;
 
 	return STATUS_SUCCESS;
 
 	err:
-	ERR(handle, "could not enter read-only operation");
+	ERR(handle, "could not enter read-only section");
 	return STATUS_ERR;
 }
 
@@ -241,8 +242,10 @@ static inline void exit_ro(
 	semanage_handle_t* handle,
 	dbase_file_t* dbase) {
 
-	semanage_release_active_lock(handle);
-	dbase_file_drop_cache(handle, dbase);
+	if (!handle->is_in_transaction) {
+		semanage_release_active_lock(handle);
+		dbase_file_drop_cache(handle, dbase);
+	}
 }
 
 static int enter_rw(
@@ -250,16 +253,18 @@ static int enter_rw(
 	dbase_file_t* dbase) {
 
 	if (!handle->is_in_transaction) {
-		/* FIXME: handle error */
-		return STATUS_ERR;
+		ERR(handle, "this operation requires a transaction");
+		goto err;
 	}
 
-	if (dbase_file_cache(handle, dbase) < 0) {
-		/* FIXME: handle error */
-		return STATUS_ERR;
-	}
+	if (dbase_file_cache(handle, dbase) < 0) 
+		goto err;
 
 	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not enter read-write section");
+	return STATUS_ERR;
 }
 
 /* Helper for finding records in the cache */
@@ -358,15 +363,17 @@ static int dbase_file_add(
 	record_key_t* key,
 	record_t* data) {
 
-	int exists;
+	int status;
+	cache_entry_t* entry;
 
 	if (enter_rw(handle, dbase) < 0)
 		goto err;
 
-	if (dbase_file_exists(handle, dbase, key, &exists) < 0)
+	status = dbase_file_cache_locate(handle, dbase, key, &entry);
+	if (status < 0)
 		goto err;
 
-	else if (exists) {
+	if (status != STATUS_NODATA) {
 		/* FIXME: handle error condition */
 		goto err;
 	}
@@ -418,8 +425,10 @@ static int dbase_file_modify(
 	status = dbase_file_cache_locate(handle, dbase, key, &entry);
 	if (status < 0)
 		goto err;
-	if (status == STATUS_NODATA)
-		return dbase_file_add(handle, dbase, key, data);
+	if (status == STATUS_NODATA) {
+		if (dbase_file_cache_add(dbase, data) < 0)
+			goto err;
+	}
 	else
 		entry->data = data;
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2005-10-22 14:55:38.000000000 -0400
+++ new/libsemanage/src/database_policydb.c	2005-10-22 18:25:28.000000000 -0400
@@ -158,9 +158,11 @@ static int enter_ro(
 	semanage_handle_t* handle,
 	dbase_policydb_t* dbase) {
 
-	if (semanage_get_active_lock(handle) < 0) {
-		ERR(handle, "could not obtain the active lock");
-		goto err;
+	if (!handle->is_in_transaction) {
+		if (semanage_get_active_lock(handle) < 0) {
+			ERR(handle, "could not obtain the active lock");
+			goto err;
+		}
 	}
 
 	if (dbase_policydb_cache(handle, dbase) < 0) 
@@ -170,7 +172,7 @@ static int enter_ro(
 
 
 	err:
-	ERR(handle, "could not begin read-only operation");
+	ERR(handle, "could not begin read-only section");
 	return STATUS_ERR;
 }
 
@@ -178,8 +180,10 @@ static inline void exit_ro(
 	semanage_handle_t* handle,
 	dbase_policydb_t* dbase) {
 
-	semanage_release_active_lock(handle);
-	dbase_policydb_drop_cache(handle, dbase);
+	if (!handle->is_in_transaction) {
+		semanage_release_active_lock(handle);
+		dbase_policydb_drop_cache(handle, dbase);
+	}
 }
 
 static int enter_rw(
@@ -187,16 +191,19 @@ static int enter_rw(
 	dbase_policydb_t* dbase) {
 
 	if (!handle->is_in_transaction) {
-		/* FIXME: handle error */
-		return STATUS_ERR;
+		ERR(handle, "this operation requires a transaction");
+		goto err;
 	}
 
-	if (dbase_policydb_cache(handle, dbase) < 0) {
-		/* FIXME: handle error */
-		return STATUS_ERR;
-	}
+	if (dbase_policydb_cache(handle, dbase) < 0)
+		goto err;
 
 	return STATUS_SUCCESS;	
+
+	err:
+	ERR(handle, "unable to enter read-write section");
+	return STATUS_ERR;
+
 }
 
 int dbase_policydb_init(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2005-10-22 14:55:38.000000000 -0400
+++ new/libsemanage/src/policy_components.c	2005-10-22 18:37:28.000000000 -0400
@@ -122,15 +122,23 @@ int semanage_commit_components(
 	};
 
 	for (i = 0; i < CCOUNT; i++) {
+		/* Flush to disk */
 		if (components[i]->dtable->flush(
 			handle, components[i]->dbase) < 0)
-			goto err;		 
+			goto err;
 	}
 
+
+	/* Drop cache, because we're leaving transaction soon */
+	for (i=0; i < CCOUNT; i++)
+		components[i]->dtable->drop_cache(
+			handle, components[i]->dbase);
+
+
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "could not commit local modifications");
 
 	for (i=0; i < CCOUNT; i++) 
 		components[i]->dtable->drop_cache(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/users_file.c	2005-10-22 18:01:24.000000000 -0400
@@ -31,7 +31,7 @@ static int user_print(
 	const char* mls_level = semanage_user_get_mlslevel(user);
 	const char* mls_range = semanage_user_get_mlsrange(user);
 
-	if (fprintf(str, "user %s roles { %s", name, def_role) < 0)
+	if (fprintf(str, "user %s roles { %s ", name, def_role) < 0)
 		goto err;
 
 	if (semanage_user_get_roles(user, &roles, &nroles) < 0)
@@ -43,7 +43,7 @@ static int user_print(
 			goto err;
 	}
 
-	if (fprintf(str, "}") < 0)
+	if (fprintf(str, "} ") < 0)
 		goto err;
 
 	/* MLS */

--------------040606050306030103040108--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
