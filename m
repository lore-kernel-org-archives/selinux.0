Subject: Re: [PATCH] Fix commit locking, rename read_lock to active_lock
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-pOFqg6r4YOvkzL1HcWck"
Date: Tue, 18 Oct 2005 12:50:57 -0400
Message-Id: <1129654257.603.0.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-pOFqg6r4YOvkzL1HcWck
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes a lock deficiency in the sandbox commit function as
well as renaming read_lock to active_lock to more accurately portray
what its purpose is.

--=-pOFqg6r4YOvkzL1HcWck
Content-Disposition: attachment; filename=1-lock-fixes.diff
Content-Type: text/x-patch; name=1-lock-fixes.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -purN -x .svn libsemanage/src/database_file.c libsemanage/src/database_file.c
--- libsemanage/src/database_file.c	2005-10-18 11:02:33.000000000 -0400
+++ libsemanage/src/database_file.c	2005-10-18 11:37:33.000000000 -0400
@@ -218,7 +218,7 @@ static int enter_ro(
 	semanage_handle_t* handle,
 	dbase_file_t* dbase) {
 
-	if (semanage_get_read_lock(handle) < 0) {
+	if (semanage_get_active_lock(handle) < 0) {
 		/* FIXME: handle error */
 		return STATUS_ERR;
 	}
@@ -235,7 +235,7 @@ static inline void exit_ro(
 	semanage_handle_t* handle,
 	dbase_file_t* dbase) {
 
-	semanage_release_read_lock(handle);
+	semanage_release_active_lock(handle);
 	dbase_file_drop_cache(handle, dbase);
 }
 
diff -purN -x .svn libsemanage/src/database_policydb.c libsemanage/src/database_policydb.c
--- libsemanage/src/database_policydb.c	2005-10-18 11:05:25.000000000 -0400
+++ libsemanage/src/database_policydb.c	2005-10-18 11:37:33.000000000 -0400
@@ -160,7 +160,7 @@ static int enter_ro(
 		return STATUS_ERR;
 	}
 	
-	if (semanage_get_read_lock(handle) < 0) {
+	if (semanage_get_active_lock(handle) < 0) {
 		/* FIXME: handle error */
 		return STATUS_ERR;
 	}
@@ -177,7 +177,7 @@ static inline void exit_ro(
 	semanage_handle_t* handle,
 	dbase_policydb_t* dbase) {
 
-	semanage_release_read_lock(handle);
+	semanage_release_active_lock(handle);
 	dbase_policydb_drop_cache(handle, dbase);
 }
 
diff -purN -x .svn libsemanage/src/direct_api.c libsemanage/src/direct_api.c
--- libsemanage/src/direct_api.c	2005-10-18 11:05:39.000000000 -0400
+++ libsemanage/src/direct_api.c	2005-10-18 11:12:57.000000000 -0400
@@ -85,7 +85,7 @@ int semanage_direct_connect(semanage_han
 		goto err;
 
 	sh->conn.module.translock_file_fd = -1;
-	sh->conn.module.readlock_file_fd = -1;
+	sh->conn.module.activelock_file_fd = -1;
 
 	/* set up function pointers */
 	sh->funcs = &direct_funcs;
@@ -527,9 +527,12 @@ static int semanage_direct_list(semanage
 	*modinfo = NULL;
 	*num_modules = 0;
 
-	if (semanage_get_read_lock(sh) < 0) {
-		return -1;
-	}
+        /* get the read lock when reading from the active
+           (non-transaction) directory */
+	if (!sh->is_in_transaction) 
+		if (semanage_get_active_lock(sh) < 0) 
+			return -1;
+
 	if (semanage_get_modules_names(sh, &module_filenames, &num_mod_files) == -1) {
 		goto cleanup;
 	}
@@ -585,6 +588,8 @@ static int semanage_direct_list(semanage
 		free(module_filenames[i]);
 	}
 	free(module_filenames);
-	semanage_release_read_lock(sh);
+        if (!sh->is_in_transaction) {
+                semanage_release_active_lock(sh);
+        }
 	return retval;
 }
diff -purN -x .svn libsemanage/src/policy.h libsemanage/src/policy.h
--- libsemanage/src/policy.h	2005-10-17 10:22:05.000000000 -0400
+++ libsemanage/src/policy.h	2005-10-17 16:45:02.000000000 -0400
@@ -30,7 +30,7 @@ struct semanage_handle;
 /* Connection Locking */
 struct semanage_module_conn {
 	int translock_file_fd;
-	int readlock_file_fd;
+	int activelock_file_fd;
 };
 
 /* Backend dependent portion */
diff -purN -x .svn libsemanage/src/semanage_store.c libsemanage/src/semanage_store.c
--- libsemanage/src/semanage_store.c	2005-10-18 11:06:10.000000000 -0400
+++ libsemanage/src/semanage_store.c	2005-10-18 11:12:57.000000000 -0400
@@ -485,7 +485,7 @@ int semanage_get_modules_names(semanage_
  * directory.  Return the new commit number on success, negative
  * values on error. */
 static int semanage_commit_sandbox(semanage_handle_t *sh) {
-	int commit_number, fd;
+	int commit_number, fd, retval;
 	char write_buf[32];
 	const char *commit_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_COMMIT_NUM_FILE);
 	ssize_t amount_written;
@@ -513,22 +513,30 @@ static int semanage_commit_sandbox(seman
 	}
 	close(fd);
 
+        retval = commit_number;
+
+        if (semanage_get_active_lock(sh) < 0) {
+                return -1;
+        }
 	/* make the backup of the current active directory */
 	if (stat(backup, &buf) == 0) {
 		if (S_ISDIR(buf.st_mode) && 
 		    semanage_remove_directory(backup) != 0) {
 			ERR(sh, "Could not remove previous backup %s.", backup);
-			return -1;
+                        retval = -1;
+                        goto cleanup;
 		}
 	}
 	else if (errno != ENOENT) {
 		ERR(sh, "Could not stat directory %s.", backup);
-		return -1;
+		retval = -1;
+                goto cleanup;
 	}
 
 	if (rename(active, backup) == -1) {
 		ERR(sh, "Error while renaming %s to %s.", active, backup);
-		return -1;
+		retval = -1;
+                goto cleanup;
 	}
 	if (rename(sandbox, active) == -1) {
 		ERR(sh, "Error while renaming %s to %s.", sandbox, active);
@@ -536,9 +544,12 @@ static int semanage_commit_sandbox(seman
 		 * function then the store will be left in an
 		 * inconsistent state */
 		rename(backup, active);
-		return -1;
+		retval = -1;
+                goto cleanup;
 	}
-	return commit_number;
+ cleanup:
+        semanage_release_active_lock(sh);
+	return retval;
 }
 
 /******************* routines that run external programs *******************/
@@ -965,19 +976,19 @@ int semanage_get_trans_lock(semanage_han
 	}
 }
 
-/* Locking for the module store for store reading; this also includes
+/* Locking for the module store for active store reading; this also includes
  * the file containing the commit number.  This is very basic locking
  * of the module store and doesn't do anything if the module store is
  * being manipulated with a program not using this library (but the
  * policy should prevent that).	 Returns 0 on success, -1 if it could
  * not obtain a lock.
  */
-int semanage_get_read_lock(semanage_handle_t *sh) {
+int semanage_get_active_lock(semanage_handle_t *sh) {
 	const char *lock_file = semanage_files[SEMANAGE_READ_LOCK];
 
-	sh->conn.module.readlock_file_fd =
+	sh->conn.module.activelock_file_fd =
 	    semanage_get_lock(sh, "read lock", lock_file);
-	if (sh->conn.module.readlock_file_fd >= 0) {
+	if (sh->conn.module.activelock_file_fd >= 0) {
 		return 0;
 	}
 	else {
@@ -997,11 +1008,11 @@ void semanage_release_trans_lock(semanag
 
 /* Releases the read lock.  Does nothing if there was not one already
  * there. */
-void semanage_release_read_lock(semanage_handle_t *sh) {
-	if (sh->conn.module.readlock_file_fd >= 0) {
-		lockf(sh->conn.module.readlock_file_fd, F_ULOCK, 0);
-		close(sh->conn.module.readlock_file_fd);
-		sh->conn.module.readlock_file_fd = -1;
+void semanage_release_active_lock(semanage_handle_t *sh) {
+	if (sh->conn.module.activelock_file_fd >= 0) {
+		lockf(sh->conn.module.activelock_file_fd, F_ULOCK, 0);
+		close(sh->conn.module.activelock_file_fd);
+		sh->conn.module.activelock_file_fd = -1;
 	}
 }
 
diff -purN -x .svn libsemanage/src/semanage_store.h libsemanage/src/semanage_store.h
--- libsemanage/src/semanage_store.h	2005-10-11 13:51:04.000000000 -0400
+++ libsemanage/src/semanage_store.h	2005-10-17 16:45:02.000000000 -0400
@@ -63,9 +63,9 @@ int semanage_install_sandbox(semanage_ha
 
 /* lock file routines */
 int semanage_get_trans_lock(semanage_handle_t *sh);
-int semanage_get_read_lock(semanage_handle_t *sh);
+int semanage_get_active_lock(semanage_handle_t *sh);
 void semanage_release_trans_lock(semanage_handle_t *sh);
-void semanage_release_read_lock(semanage_handle_t *sh);
+void semanage_release_active_lock(semanage_handle_t *sh);
 int semanage_get_commit_number(semanage_handle_t *sh);
 
 

--=-pOFqg6r4YOvkzL1HcWck--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
