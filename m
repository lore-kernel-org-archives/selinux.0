Message-ID: <43564695.1050900@tresys.com>
Date: Wed, 19 Oct 2005 09:13:57 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: [PATCH] transaction rollback in lock
Content-Type: multipart/mixed;
 boundary="------------080500050504010908020504"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080500050504010908020504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch moves the transaction rollback into the commit lock.


--------------080500050504010908020504
Content-Type: text/x-patch;
 name="2-rollback-in-lock.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2-rollback-in-lock.diff"

diff -purN -x .svn libsemanage/src/semanage_store.c libsemanage/src/semanage_store.c
--- libsemanage/src/semanage_store.c	2005-10-18 14:56:43.000000000 -0400
+++ libsemanage/src/semanage_store.c	2005-10-18 16:47:29.000000000 -0400
@@ -480,78 +480,6 @@ int semanage_get_modules_names(semanage_
 }
 
 
-/* Prepare the sandbox to be installed by making a backup of the
- * current active directory.  Then copy the sandbox to the active
- * directory.  Return the new commit number on success, negative
- * values on error. */
-static int semanage_commit_sandbox(semanage_handle_t *sh) {
-	int commit_number, fd, retval;
-	char write_buf[32];
-	const char *commit_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_COMMIT_NUM_FILE);
-	ssize_t amount_written;
-	const char *active = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
-	const char *backup = semanage_path(SEMANAGE_PREVIOUS, SEMANAGE_TOPLEVEL);
-	const char *sandbox = semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL);
-	struct stat buf;
-
-	/* update the commit number */
-	if ((commit_number = semanage_get_commit_number(sh)) < 0) {
-		return -1;
-	}
-	commit_number++;
-	memset(write_buf, 0, sizeof(write_buf));
-	snprintf(write_buf, sizeof(write_buf), "%d", commit_number);
-	if ((fd = open(commit_filename, O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR)) == -1) {
-		ERR(sh, "Could not open commit number file %s for writing.", commit_filename);
-		return -1;
-	}
-	amount_written = write(fd, write_buf, sizeof(write_buf));
-	if (amount_written == -1) {
-		ERR(sh, "Error while writing commit number to %s.", commit_filename);
-		close(fd);
-		return -1;
-	}
-	close(fd);
-
-        retval = commit_number;
-
-        if (semanage_get_active_lock(sh) < 0) {
-                return -1;
-        }
-	/* make the backup of the current active directory */
-	if (stat(backup, &buf) == 0) {
-		if (S_ISDIR(buf.st_mode) && 
-		    semanage_remove_directory(backup) != 0) {
-			ERR(sh, "Could not remove previous backup %s.", backup);
-                        retval = -1;
-                        goto cleanup;
-		}
-	}
-	else if (errno != ENOENT) {
-		ERR(sh, "Could not stat directory %s.", backup);
-		retval = -1;
-                goto cleanup;
-	}
-
-	if (rename(active, backup) == -1) {
-		ERR(sh, "Error while renaming %s to %s.", active, backup);
-		retval = -1;
-                goto cleanup;
-	}
-	if (rename(sandbox, active) == -1) {
-		ERR(sh, "Error while renaming %s to %s.", sandbox, active);
-		/* note that if an error occurs during the next
-		 * function then the store will be left in an
-		 * inconsistent state */
-		rename(backup, active);
-		retval = -1;
-                goto cleanup;
-	}
- cleanup:
-        semanage_release_active_lock(sh);
-	return retval;
-}
-
 /******************* routines that run external programs *******************/
 
 /* Appends a single character to a string.  Returns a pointer to the
@@ -863,6 +791,89 @@ static int semanage_install_active(seman
 	return retval;
 }
 
+/* Prepare the sandbox to be installed by making a backup of the
+ * current active directory.  Then copy the sandbox to the active
+ * directory.  Return the new commit number on success, negative
+ * values on error. */
+static int semanage_commit_sandbox(semanage_handle_t *sh) {
+	int commit_number, fd, retval;
+	char write_buf[32];
+	const char *commit_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_COMMIT_NUM_FILE);
+	ssize_t amount_written;
+	const char *active = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
+	const char *backup = semanage_path(SEMANAGE_PREVIOUS, SEMANAGE_TOPLEVEL);
+	const char *sandbox = semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL);
+	struct stat buf;
+
+	/* update the commit number */
+	if ((commit_number = semanage_get_commit_number(sh)) < 0) {
+		return -1;
+	}
+	commit_number++;
+	memset(write_buf, 0, sizeof(write_buf));
+	snprintf(write_buf, sizeof(write_buf), "%d", commit_number);
+	if ((fd = open(commit_filename, O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR)) == -1) {
+		ERR(sh, "Could not open commit number file %s for writing.", commit_filename);
+		return -1;
+	}
+	amount_written = write(fd, write_buf, sizeof(write_buf));
+	if (amount_written == -1) {
+		ERR(sh, "Error while writing commit number to %s.", commit_filename);
+		close(fd);
+		return -1;
+	}
+	close(fd);
+
+        retval = commit_number;
+
+        if (semanage_get_active_lock(sh) < 0) {
+                return -1;
+        }
+	/* make the backup of the current active directory */
+	if (stat(backup, &buf) == 0) {
+		if (S_ISDIR(buf.st_mode) && 
+		    semanage_remove_directory(backup) != 0) {
+			ERR(sh, "Could not remove previous backup %s.", backup);
+                        retval = -1;
+                        goto cleanup;
+		}
+	}
+	else if (errno != ENOENT) {
+		ERR(sh, "Could not stat directory %s.", backup);
+		retval = -1;
+                goto cleanup;
+	}
+
+	if (rename(active, backup) == -1) {
+		ERR(sh, "Error while renaming %s to %s.", active, backup);
+		retval = -1;
+                goto cleanup;
+	}
+	if (rename(sandbox, active) == -1) {
+		ERR(sh, "Error while renaming %s to %s.", sandbox, active);
+		/* note that if an error occurs during the next
+		 * function then the store will be left in an
+		 * inconsistent state */
+		rename(backup, active);
+		retval = -1;
+                goto cleanup;
+	}
+	if (semanage_install_active(sh) != 0) {
+		/* note that if an error occurs during the next three
+		 * function then the store will be left in an
+		 * inconsistent state */
+		rename(active, sandbox);
+		rename(backup, active);
+		semanage_install_active(sh);
+		retval = -1;
+		goto cleanup;
+	}
+
+ cleanup:
+        semanage_release_active_lock(sh);
+	return retval;
+}
+
 /* Takes the kernel policy in a sandbox, move it to the active
  * directory, copy it to the binary policy path, then load it.	Upon
  * error move the active directory back to the sandbox.	 This function
@@ -870,7 +881,7 @@ static int semanage_install_active(seman
  * atomically.	Returns 0 on success, -1 on error.
  */
 int semanage_install_sandbox(semanage_handle_t *sh) {
-	int retval = -1, new_commit_number;
+	int retval = -1;
 
 	if (sh->conf->load_policy == NULL) {
 		ERR(sh, "No load_policy program specified in configuration file.");
@@ -881,25 +892,13 @@ int semanage_install_sandbox(semanage_ha
 		goto cleanup;
 	}
 
-	if ((new_commit_number = semanage_commit_sandbox(sh)) < 0) {
+	if ((retval = semanage_commit_sandbox(sh)) < 0) {
 		goto cleanup;
 	}
-	if (semanage_install_active(sh) != 0) {
-		const char *active = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
-		const char *backup = semanage_path(SEMANAGE_PREVIOUS, SEMANAGE_TOPLEVEL);
-		const char *sandbox = semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL);
-		/* note that if an error occurs during the next three
-		 * function then the store will be left in an
-		 * inconsistent state */
-		rename(active, sandbox);
-		rename(backup, active);
-		semanage_install_active(sh);
-		goto cleanup;
-	}
-	retval = new_commit_number;
 
- cleanup:
+cleanup:
 	return retval;
+
 }
 
 


--------------080500050504010908020504--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
