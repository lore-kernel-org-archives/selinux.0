Message-ID: <454A9608.9030400@us.ibm.com>
Date: Thu, 02 Nov 2006 19:06:16 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 6/8] make newrole suid (take 3)
References: <454A8F35.2020006@us.ibm.com>
In-Reply-To: <454A8F35.2020006@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------010208080304020608010800"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010208080304020608010800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michael C Thompson wrote:
> The 8 patches are as follows:
> 1) Modifications to Makefile to support future patch needs
>    Add newrole-lspp.pamd
> 2) New extract_pw_data function and use in main()
> 3) Add signal handler function
> 4) Update drop_capabilities() and use in main()
> 5) Update the authentication functions and use in main()
>    Add cleanup since pam_start is now left till program end
> 6) Move relabeling tty actions into functions

This is the 6th of 8 patches.
This patch applies against policycoreutils-1.30.30-1.

This patch moves the tty relabeling actions into their own
functions and adds better cleanup to main on error paths.

Changes:
  * Introduces relabel_tty() and restore_tty_label()
    - Move functionality from main() into functions
  * Uses the above new functions in main()
  * Updates the parent process to have better cleanup

Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>


--------------010208080304020608010800
Content-Type: text/x-diff;
 name="06-update_relabeling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="06-update_relabeling.patch"

diff -Naur policycoreutils-1.30.30/newrole/newrole.c policycoreutils-1.30.30.suid/newrole/newrole.c
--- policycoreutils-1.30.30/newrole/newrole.c	2006-11-02 12:38:27.000000000 -0600
+++ policycoreutils-1.30.30.suid/newrole/newrole.c	2006-11-02 12:48:46.000000000 -0600
@@ -522,6 +522,113 @@
 #endif
 
 /**
+ * This function attempts to relabel the tty. If this function fails, then
+ * the fd is closed, the contexts are free'd and -1 is returned. On success,
+ * a valid fd is returned and tty_context and new_tty_context are set.
+ *
+ * This function will not fail if it can not relabel the tty when selinux is
+ * in permissive mode.
+ */
+static int relabel_tty(const char *ttyn, security_context_t new_context,
+			security_context_t *tty_context,
+			security_context_t *new_tty_context)
+{
+	int fd;
+	int enforcing = security_getenforce();
+	security_context_t tty_con = NULL;
+	security_context_t new_tty_con = NULL;
+
+	if (enforcing < 0) {
+		fprintf(stderr, _("Could not determine enforcing mode.\n"));
+		return -1;
+	}
+
+	/* Re-open TTY descriptor */
+	fd = open(ttyn, O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, _("Error!  Could not open %s.\n"), ttyn);
+		return fd;
+	}
+
+	if (fgetfilecon(fd, &tty_con) < 0) {
+		fprintf(stderr, _("%s!  Could not get current context "
+			"for %s, not relabeling tty.\n"),
+			enforcing ? "Error" : "Warning", ttyn);
+		if (enforcing)
+			goto close_fd;
+	}
+
+	if (tty_con &&
+	    (security_compute_relabel(new_context, tty_con,
+				      SECCLASS_CHR_FILE, &new_tty_con) < 0)) {
+		fprintf(stderr,	_("%s!  Could not get new context for %s, "
+			"not relabeling tty.\n"),
+			enforcing ? "Error" : "Warning", ttyn);
+		if (enforcing)
+			goto close_fd;
+	}
+
+	if (new_tty_con)
+		if (fsetfilecon(fd, new_tty_con) < 0) {
+			fprintf(stderr,
+				_("%s!  Could not set new context for %s\n"),
+				enforcing ? "Error" : "Warning", ttyn);
+			freecon(new_tty_con);
+			new_tty_con = NULL;
+			if (enforcing)
+				goto close_fd;
+		}
+
+	*tty_context = tty_con;
+	*new_tty_context = new_tty_con;
+	return fd;
+
+close_fd:
+	freecon(tty_con);
+	close(fd);
+	return -1;
+}
+
+/**
+ * This function attempts to revert the relabeling done to the tty.
+ * fd   - referencing the opened ttyn
+ * ttyn - name of tty to restore
+ * tty_context     - original context of the tty
+ * new_tty_context - context tty was relabeled to
+ *
+ * Returns zero on success, non-zero otherwise
+ */
+static int restore_tty_label(int fd, const char *ttyn,
+			     security_context_t tty_context,
+			     security_context_t new_tty_context)
+{
+	int rc = 0;
+	security_context_t chk_tty_context = NULL;
+
+	if (!new_tty_context)
+		goto skip_relabel;
+
+	/* Verify that the tty still has the context set by newrole. */
+	if ((rc = fgetfilecon(fd, &chk_tty_context)) < 0) {
+		fprintf(stderr, "Could not fgetfilecon %s.\n", ttyn);
+		goto skip_relabel;
+	}
+
+	if ((rc = strcmp(chk_tty_context, new_tty_context))) {
+		fprintf(stderr, _("%s changed labels.\n"), ttyn);
+		goto skip_relabel;
+	}
+
+	if ((rc = fsetfilecon(fd, tty_context)) < 0)
+		fprintf(stderr,
+			_("Warning! Could not restore context for %s\n"), ttyn);
+skip_relabel:
+	freecon(chk_tty_context);
+	return rc;
+}
+
+
+/**
  * Take care of any signal setup
  */
 static int set_signal_handles()
@@ -558,7 +665,6 @@
 	security_context_t old_context = NULL;	/* our original securiy context */
 	security_context_t tty_context = NULL;	/* The current context of tty file */
 	security_context_t new_tty_context = NULL;	/* The new context of tty file */
-	security_context_t chk_tty_context = NULL;
 
 	context_t context;	/* manipulatable form of new_context */
 
@@ -580,6 +686,7 @@
 	pid_t childPid = 0;
 	int fd, rc;
 	int enforcing;
+	char *shell_argv0 = NULL;
 
 #ifdef USE_PAM
 	int pam_status;		   /* pam return code */
@@ -855,110 +962,77 @@
 	}
 
 	/*
+	 * Step 3:  Handle relabeling of the tty.
 	 *
-	 * Step 4:  Handle relabeling of the tty.
-	 *
+	 * Once we authenticate the user, we know that we want to proceed with
+	 * the action. Prior to this point, no changes are made the to system.
 	 */
+	fd = relabel_tty(ttyn, new_context, &tty_context, &new_tty_context);
+	if (fd < 0)
+		goto err_close_pam;
 
-	/* Re-open TTY descriptor */
-	fd = open(ttyn, O_RDWR);
-	if (fd < 0) {
-		fprintf(stderr, _("Error!  Could not open %s.\n"), ttyn);
-		exit(-1);
-	}
-
-	tty_context = NULL;
-	if (fgetfilecon(fd, &tty_context) < 0) {
-		fprintf(stderr,
-			_
-			("%s!  Could not get current context for %s, not relabeling tty.\n"),
-			enforcing ? "Error" : "Warning", ttyn);
-		if (enforcing)
-			exit(-1);
-	}
-#ifdef CANTSPELLGDB
-	if (tty_context)
-		printf("Your tty %s was labeled with context %s\n", ttyn,
-		       tty_context);
-#endif
-
-	new_tty_context = NULL;
-	if (tty_context
-	    &&
-	    (security_compute_relabel
-	     (new_context, tty_context, SECCLASS_CHR_FILE,
-	      &new_tty_context) < 0)) {
-		fprintf(stderr,
-			_
-			("%s!  Could not get new context for %s, not relabeling tty.\n"),
-			enforcing ? "Error" : "Warning", ttyn);
-		if (enforcing)
-			exit(-1);
-	}
-#ifdef CANTSPELLGDB
-	if (new_tty_context)
-		printf("Relabeling tty %s to context %s\n", ttyn,
-		       new_tty_context);
-#endif
-
-	if (new_tty_context) {
-		if (fsetfilecon(fd, new_tty_context) < 0) {
-			fprintf(stderr,
-				_("%s!  Could not set new context for %s\n"),
-				enforcing ? "Error" : "Warning", ttyn);
-			freecon(new_tty_context);
-			new_tty_context = NULL;
-			if (enforcing)
-				exit(-1);
-		}
-	}
-
-	/* Fork, allowing parent to clean up after shell has executed */
+	/*
+	 * Step 4: Fork
+	 *
+	 * Fork, allowing parent to clean up after shell has executed.
+	 * Child: reopen stdin, stdout, stderr and exec shell
+	 * Parnet: wait for child to die and restore tty's context
+	 */
 	childPid = fork();
 	if (childPid < 0) {
+		/* fork failed, no child to worry about */
 		int errsv = errno;
 		fprintf(stderr, _("newrole: failure forking: %s"),
 			strerror(errsv));
-		if (fsetfilecon(fd, tty_context) < 0)
-			fprintf(stderr,
-				_
-				("Warning!  Could not restore context for %s\n"),
-				ttyn);
-		freecon(tty_context);
-		exit(-1);
+		if (restore_tty_label(fd, ttyn, tty_context, new_tty_context))
+			fprintf(stderr, _("Unable to restore tty label...\n"));
+		if (close(fd))
+			fprintf(stderr, _("Failed to close tty properly\n"));
+		goto err_close_pam;
 	} else if (childPid) {
-		/* PARENT */
+		/* PARENT
+		 * It doesn't make senes to exit early on errors at this point,
+		 * since we are doing cleanup which needs to be done.
+		 * We can exit with a bad rc though
+		 */
 		int rc;
+		int exit_code = 0;
+
 		do {
 			rc = wait(NULL);
 		} while (rc < 0 && errno == EINTR);
 
-		if (!new_tty_context || !tty_context)
-			exit(0);
-
-		/* Verify that the tty still has the context set by newrole. */
-		if (fgetfilecon(fd, &chk_tty_context) < 0) {
-			fprintf(stderr, "Could not fgetfilecon %s.\n", ttyn);
-			exit(-1);
-		}
-
-		if (strcmp(chk_tty_context, new_tty_context)) {
-			fprintf(stderr, _("%s changed labels.\n"), ttyn);
-			exit(-1);
+		if (restore_tty_label(fd, ttyn, tty_context, new_tty_context)) {
+			fprintf(stderr, _("Unable to restore tty label...\n"));
+			exit_code = -1;
 		}
-
+		freecon(tty_context);
 		freecon(new_tty_context);
-
-#ifdef CANTSPELLGDB
-		printf("Restoring tty %s back to context %s\n", ttyn,
-		       tty_context);
+		if (close(fd)) {
+			fprintf(stderr, _("Failed to close tty properly\n"));
+			exit_code = -1;
+		}
+#ifdef USE_PAM
+#ifdef NAMESPACE_PRIV
+		pam_status = pam_close_session(pam_handle,0);
+		if (pam_status != PAM_SUCCESS) {
+			fprintf(stderr, "pam_close_session failed with %s\n",
+				pam_strerror(pam_handle, pam_status));
+			exit_code = -1;
+		}
 #endif
-
-		fsetfilecon(fd, tty_context);
-		freecon(tty_context);
-
-		/* Done! */
-		exit(0);
+		rc = pam_end(pam_handle, pam_status);
+		if (rc != PAM_SUCCESS) {
+			fprintf(stderr, "pam_end failed with %s\n",
+				pam_strerror(pam_handle, rc));
+			exit_code = -1;
+		}
+#endif
+		free(pw.pw_name);
+		free(pw.pw_dir);
+		free(pw.pw_shell);
+		free(shell_argv0);
+		return exit_code;
 	}
 
 	/* CHILD */
@@ -1035,5 +1109,6 @@
 	free(pw.pw_name);
 	free(pw.pw_dir);
 	free(pw.pw_shell);
+	free(shell_argv0);
 	return -1;
 }				/* main() */

--------------010208080304020608010800--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
