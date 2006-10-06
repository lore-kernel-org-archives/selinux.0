Message-ID: <4526D5C6.3090505@us.ibm.com>
Date: Fri, 06 Oct 2006 17:16:38 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 2/4] make newrole suid
Content-Type: multipart/mixed;
 boundary="------------030103040708080908050608"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030103040708080908050608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is the 2nd of 4 patches.
This patch applies against policycoreutils-1.30.30-1.

Changes:
  * main is changed in the following ways:
    - remove the duplicated functionality for patch 1/4
    - set to call the new functions
    - introduces better error handling and cleanup paths

Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>



--------------030103040708080908050608
Content-Type: text/x-diff;
 name="01-update_main.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-update_main.patch"

diff -Naur policycoreutils-1.30.30/newrole/newrole.c policycoreutils-1.30.30.suid/newrole/newrole.c
--- policycoreutils-1.30.30/newrole/newrole.c	2006-10-06 17:01:10.000000000 -0500
+++ policycoreutils-1.30.30.suid/newrole/newrole.c	2006-10-06 17:00:18.000000000 -0500
@@ -882,47 +882,43 @@
 
 int main(int argc, char *argv[])
 {
+	security_context_t new_context = NULL;	/* target security context */
+	security_context_t old_context = NULL;	/* original securiy context */
+	security_context_t tty_context = NULL;	/* current context of tty */
+	security_context_t new_tty_context = NULL; /* new context of tty */
 
-	security_context_t new_context = NULL;	/* our target security context */
-	security_context_t old_context = NULL;	/* our original securiy context */
-	security_context_t tty_context = NULL;	/* The current context of tty file */
-	security_context_t new_tty_context = NULL;	/* The new context of tty file */
-	security_context_t chk_tty_context = NULL;
-
-	context_t context;	/* manipulatable form of new_context */
-
-	struct passwd *pw;	/* struct derived from passwd file line */
-	struct passwd pw_copy;
-
-	int clflag;		/* holds codes for command line flags */
-	int flag_index;		/* flag index in argv[] */
-	const struct option long_options[] = {	/* long option flags for getopt() */
-		{"role", 1, 0, 'r'},
-		{"type", 1, 0, 't'},
-		{"level", 1, 0, 'l'},
-		{"version", 0, 0, 'V'},
-		{NULL, 0, 0, 0}
-	};
-	char *role_s = NULL;	/* role spec'd by user in argv[] */
-	char *type_s = NULL;	/* type spec'd by user in argv[] */
-	char *level_s = NULL;	/* level spec'd by user in argv[] */
+	struct passwd pw;	/* struct derived from passwd file line */
 	char *ttyn = NULL;	/* tty path */
-	pid_t childPid = 0;
-	uid_t uid;
+
 	int fd;
-	int enforcing;
-	sigset_t empty;
+	int rc;
+	pid_t childPid = 0;
+	char *shell_argv0 = NULL;
 
-#ifdef LOG_AUDIT_PRIV
-	drop_capabilities();
-#endif
+#ifdef USE_PAM
+	int pam_status;		   /* pam return code */
+	pam_handle_t *pam_handle;  /* opaque handle used by all PAM functions */
 
-	/* Empty the signal mask in case someone is blocking a signal */
-	sigemptyset(&empty);
-	(void)sigprocmask(SIG_SETMASK, &empty, NULL);
+	/* This is a jump table of functions for PAM to use when it wants to *
+	 * communicate with the user.  We'll be using misc_conv(), which is  *
+	 * provided for us via pam_misc.h.                                   */
+	struct pam_conv pam_conversation = {
+		misc_conv,
+		NULL
+	};
+#endif
 
-	/* Terminate on SIGHUP. */
-	signal(SIGHUP, SIG_DFL);
+	/*
+	 * Step 0: Setup
+	 *
+	 * Do some intial setup, including dropping capabilities, checking
+	 * if it makes sense to continue to run newrole, and setting up
+	 * a scrubbed environment.
+	 */
+	if (set_signal_handles())
+		return -1;
+	if (drop_capabilities())
+		return -1;
 
 #ifdef USE_NLS
 	setlocale(LC_ALL, "");
@@ -930,435 +926,235 @@
 	textdomain(PACKAGE);
 #endif
 
-	/*
-	 *
-	 * Step 1:  Handle command-line arguments.
-	 *
-	 */
-
 	if (!is_selinux_enabled()) {
-		fprintf(stderr,
-			_
-			("Sorry, newrole may be used only on a SELinux kernel.\n"));
-		exit(-1);
+		fprintf(stderr, _("Sorry, newrole may be used only on "
+			"a SELinux kernel.\n"));
+		return -1;
 	}
-	enforcing = security_getenforce();
-	if (enforcing < 0) {
+
+	if (security_getenforce()) {
 		fprintf(stderr, _("Could not determine enforcing mode.\n"));
-		exit(-1);
+		return -1;
 	}
 
-	while (1) {
-		clflag =
-		    getopt_long(argc, argv, "r:t:l:V", long_options,
-				&flag_index);
-		if (clflag == -1)
-			break;
-
-		switch (clflag) {
-		case 'V':
-			printf("newrole: %s version %s\n", PACKAGE, VERSION);
-			exit(0);
-			break;
-		case 'r':
-			/* If role_s is already set, the user spec'd multiple roles - bad. */
-			if (role_s) {
-				fprintf(stderr,
-					_("Error: multiple roles specified\n"));
-				exit(-1);
-			}
-			role_s = optarg;	/* save the role string spec'd by user */
-			break;
-
-		case 't':
-			/* If type_s is already set, the user spec'd multiple types - bad. */
-			if (type_s) {
-				fprintf(stderr,
-					_("Error: multiple types specified\n"));
-				exit(-1);
-			}
-			type_s = optarg;	/* save the type string spec'd by user */
-			break;
-
-		case 'l':
-			if (!is_selinux_mls_enabled()) {
-				fprintf(stderr,
-					_
-					("Sorry, -l may be used with SELinux MLS support.\n"));
-				exit(-1);
-			}
-			/* If level_s is already set, the user spec'd multiple levels - bad. */
-			if (level_s) {
-				fprintf(stderr,
-					_
-					("Error: multiple levels specified\n"));
-				exit(-1);
-			}
-			level_s = optarg;	/* save the level string spec'd by user */
-			break;
-
-		default:
-			fprintf(stderr, "%s\n", USAGE_STRING);
-			exit(-1);
-		}		/* switch( clflag ) */
-	}			/* while command-line flags remain for newrole */
-
-	/* Verify that the combination of command-line arguments we were *
-	 * given is a viable one.                                        */
-	if (!(role_s || type_s || level_s)) {
-		fprintf(stderr, "%s\n", USAGE_STRING);
-		exit(-1);
-	}
-
-	/* Fill in a default type if one hasn't been specified */
-	if (role_s && !type_s) {
-		if (get_default_type(role_s, &type_s)) {
-			fprintf(stderr, _("Couldn't get default type.\n"));
-			send_audit_message(0, old_context, new_context, ttyn);
-			exit(-1);
-		}
-#ifdef CANTSPELLGDB
-		printf("Your type will be %s.\n", type_s);
-#endif
+	if (extract_pw_data(&pw))
+		return -1;
+
+	if (sanitize_environment(&pw)) {
+		fprintf(stderr, _("Unable to sanitize the environment, "
+			"aborting\n"));
+		goto err_free;
 	}
 
 	/*
+	 * Step 1: Parse command line and valid arguments
 	 *
-	 * Step 2:  Authenticate the user.
-	 *
+	 * old_context and ttyn are required for audit logging,
+	 * context validation and pam
 	 */
-
-	/*
-	 * Get the context of the caller, and extract
-	 * the username from the context.  Don't rely on the Linux
-	 * uid information - it isn't trustworthy.
-	 */
-
-	/* Put the caller's context into `old_context'. */
-	if (0 != (getprevcon(&old_context))) {
+	if (getprevcon(&old_context)) {
 		fprintf(stderr, _("failed to get old_context.\n"));
-		exit(-1);
-	}
-#ifdef CANTSPELLGDB
-	printf("Your old context was %s\n", old_context);
-#endif
-
-	/* 
-	 * Create a context structure so that we extract and modify 
-	 * components easily. 
-	 */
-	context = context_new(old_context);
-	if (context == 0) {
-		fprintf(stderr, _("failed to get new context.\n"));
-		exit(-1);
+		goto err_free;
 	}
 
-	/*
-	 * Determine the Linux user identity to re-authenticate.
-	 * If supported and set, use the login uid, as this should be more stable.
-	 * Otherwise, use the real uid.
-	 * The SELinux user identity is no longer used, as Linux users are now
-	 * mapped to SELinux users via seusers and the SELinux user identity space
-	 * is separate.
-	 */
-#ifdef USE_AUDIT
-	uid = audit_getloginuid();
-	if (uid == (uid_t) - 1)
-		uid = getuid();
-#else
-	uid = getuid();
-#endif
-
-	/* Get the passwd info for the Linux user identity. */
-	pw = getpwuid(uid);
-	if (!pw) {
-		fprintf(stderr,
-			_("cannot find your entry in the passwd file.\n"));
-		exit(-1);
-	}
-	pw_copy = *pw;
-	pw = &pw_copy;
-	pw->pw_name = xstrdup(pw->pw_name);
-	pw->pw_dir = xstrdup(pw->pw_dir);
-	pw->pw_shell = xstrdup(pw->pw_shell);
-
-	if (verify_shell(pw->pw_shell) == 0) {
-		fprintf(stderr, _("Error!  Shell is not valid.\n"));
-		exit(-1);
-	}
-
-	/* Get the tty name. Pam will need it. */
 	ttyn = ttyname(0);
 	if (!ttyn || *ttyn == '\0') {
 		fprintf(stderr,
 			_("Error!  Could not retrieve tty information.\n"));
-		exit(-1);
+		goto err_free;
 	}
 
-	printf(_("Authenticating %s.\n"), pw->pw_name);
+	if (parse_command_line_arguments(argc, argv, ttyn, old_context,
+					 &new_context))
+		goto err_free;
 
-	/* 
+	/*
+	 * Step 2:  Authenticate the user.
+	 *
 	 * Re-authenticate the user running this program.
 	 * This is just to help confirm user intent (vs. invocation by
 	 * malicious software), not to authorize the operation (which is covered
 	 * by policy).  Trusted path mechanism would be preferred.
 	 */
+	printf(_("Authenticating %s.\n"), pw.pw_name);
 #ifdef USE_PAM
-	if (!authenticate_via_pam(pw, ttyn))
-#else				/* !USE_PAM */
-	if (!authenticate_via_shadow_passwd(pw))
-#endif				/* if/else USE_PAM */
+	pam_status = pam_start(SERVICE_NAME, pw.pw_name, &pam_conversation,
+			       &pam_handle);
+	if (pam_status != PAM_SUCCESS) {
+		fprintf(stderr, _("failed to initialize PAM\n"));
+		goto err_free;
+	}
+
+	if (!authenticate_via_pam(ttyn, pam_handle))
+#else
+	if (!authenticate_via_shadow_passwd(pw.pw_name))
+#endif
 	{
 		fprintf(stderr, _("newrole: incorrect password for %s\n"),
-			pw->pw_name);
-		return (-1);
+			pw.pw_name);
+		goto err_close_pam;
 	}
-	/* If we reach here, then we have authenticated the user. */
-#ifdef CANTSPELLGDB
-	printf("You are authenticated!\n");
-#endif
 
 	/*
+	 * Step 3:  Handle relabeling of the tty.
 	 *
-	 * Step 3:  Construct a new context based on our old context and the
-	 *          arguments specified on the command line.
-	 *
+	 * Once we authenticate the user, we know that we want to proceed with
+	 * the action. Prior to this point, no changes are made the to system.
 	 */
-
-	/* The first step in constructing a new context for the new shell we  *
-	 * plan to exec is to take our old context in `context' as a   *
-	 * starting point, and modify it according to the options the user *
-	 * specified on the command line.                                  */
-
-	/* If the user specified a new role on the command line (if `role_s'   *
-	 * is set), then replace the old role in `context' with this new role. */
-	if (role_s) {
-		if (context_role_set(context, role_s)) {
-			fprintf(stderr, _("failed to set new role %s\n"),
-				role_s);
-			exit(-1);
-		}
-#ifdef CANTSPELLGDB
-		printf("Your new role is %s\n", context_role_get(context));
-#endif
-	}
-
-	/* if user specified new role */
-	/* If the user specified a new type on the command line (if `type_s'   *
-	 * is set), then replace the old type in `context' with this new type. */
-	if (type_s) {
-		if (context_type_set(context, type_s)) {
-			fprintf(stderr, _("failed to set new type %s\n"),
-				type_s);
-			exit(-1);
-		}
-#ifdef CANTSPELLGDB
-		printf("Your new type is %s\n", context_type_get(context));
-#endif
-	}
-
-	/* if user specified new type */
-	/* If the user specified a new level on the command line (if `level_s'   *
-	 * is set), then replace the old level in `context' with this new level. */
-	if (level_s) {
-		char *range_s =
-		    build_new_range(level_s, context_range_get(context));
-		if (!range_s) {
-			fprintf(stderr,
-				_("failed to build new range with level %s\n"),
-				level_s);
-			exit(-1);
-		}
-		if (context_range_set(context, range_s)) {
-			fprintf(stderr, _("failed to set new range %s\n"),
-				range_s);
-			free(range_s);
-			exit(-1);
-		}
-		free(range_s);
-#ifdef CANTSPELLGDB
-		printf("Your new range is %s\n", context_range_get(context));
-#endif
-	}
-
-	/* if user specified new level */
-	/* The second step in creating the new context is to convert our modified *
-	 * `context' structure back to a context string and then to a Context.    */
-	if (!(new_context = context_str(context))) {
-		fprintf(stderr, _("failed to convert new context to string\n"));
-		exit(-1);
-	}
-#ifdef CANTSPELLGDB
-	printf("Your new context is %s\n", new_context);
-#endif
-
-	if (security_check_context(new_context) < 0) {
-		fprintf(stderr, _("%s is not a valid context\n"), new_context);
-		send_audit_message(0, old_context, new_context, ttyn);
-		exit(-1);
-	}
+	fd = relabel_tty(ttyn, new_context, &tty_context, &new_tty_context);
+	if (fd < 0)
+		goto err_close_pam;
 
 	/*
+	 * Step 4: Fork
 	 *
-	 * Step 4:  Handle relabeling of the tty.
-	 *
+	 * Fork, allowing parent to clean up after shell has executed.
+	 * Child: reopen stdin, stdout, stderr and exec shell
+	 * Parnet: wait for child to die and restore tty's context
 	 */
-
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
-
-	close(fd);
-
-	/* Close and reopen descriptors 0 through 2 */
-	if (close(0) || close(1) || close(2)) {
+	/* Close the tty and reopen descriptors 0 through 2 */
+	if (close(fd) || close(0) || close(1) || close(2)) {
 		fprintf(stderr, _("Could not close descriptors.\n"));
-		exit(-1);
+		goto err_close_pam;
 	}
 	fd = open(ttyn, O_RDONLY);
-	if (fd != 0) {
-		exit(-1);
-	}
+	if (fd != 0)
+		goto err_close_pam;
 	fd = open(ttyn, O_WRONLY);
-	if (fd != 1) {
-		exit(-1);
-	}
+	if (fd != 1)
+		goto err_close_pam;
 	fd = open(ttyn, O_WRONLY);
-	if (fd != 2) {
-		exit(-1);
-	}
+	if (fd != 2)
+		goto err_close_pam;
 
 	/*
-	 *
 	 * Step 5:  Execute a new shell with the new context in `new_context'. 
 	 *
+	 * Establish context, namesapce and any options for the new shell
 	 */
-
 	if (optind < 1)
 		optind = 1;
-	if (asprintf(&argv[optind - 1], "-%s", pw->pw_shell) < 0) {
-		fprintf(stderr, _("Error allocating shell.\n"));
-		exit(-1);
-	}
-#ifdef CANTSPELLGDB
-	{
-		int i;
-		printf("Executing ");
-		for (i = optind - 1; i < argc; i++)
-			printf("%s ", argv[i]);
-		printf("with context %s\n", new_context);
+
+	/* This is ugly, but use newrole's argv for the exec'd shells argv */
+	if (asprintf(&shell_argv0, "-%s", pw.pw_shell) < 0) {
+		fprintf(stderr, _("Error allocating shell's argv0.\n"));
+		shell_argv0 = NULL;
+		goto err_close_pam;
 	}
-#endif
-	if (setexeccon(new_context) < 0) {
+	argv[optind-1] = shell_argv0;
+
+	if (setexeccon(new_context)) {
 		fprintf(stderr, _("Could not set exec context to %s.\n"),
 			new_context);
-		exit(-1);
+		goto err_close_pam;
 	}
+
+#ifdef NAMESPACE_PRIV
+	/* Ask PAM to setup session for user running this program */
+	pam_status = pam_open_session(pam_handle,0);
+	if (pam_status != PAM_SUCCESS) {
+		fprintf(stderr, "pam_open_session failed with %s\n",
+			pam_strerror(pam_handle, pam_status));
+		goto err_close_pam;
+	}
+#endif
+
 	if (send_audit_message(1, old_context, new_context, ttyn))
-		exit(-1);
+		goto err_close_pam_session;
+#ifdef NAMESPACE_PRIV
+	if (transition_to_caller_uid())
+		goto err_close_pam_session;
+#endif
 	freecon(old_context);
-	execv(pw->pw_shell, argv + optind - 1);
+	freecon(new_context);
+	execv(pw.pw_shell, argv + optind - 1);
 
-	/* If we reach here, then we failed to exec the new shell. */
+	/*
+	 * Error path cleanup
+	 *
+	 * If we reach here, then we failed to exec the new shell.
+	 */
 	perror(_("failed to exec shell\n"));
-	return (-1);
+err_close_pam_session:
+#ifdef NAMESPACE_PRIV
+	pam_status = pam_close_session(pam_handle,0);
+	if(pam_status != PAM_SUCCESS)
+		fprintf(stderr, "pam_close_session failed with %s\n",
+			pam_strerror(pam_handle, pam_status));
+#endif
+err_close_pam:
+#ifdef USE_PAM
+	rc = pam_end(pam_handle, pam_status);
+	if (rc != PAM_SUCCESS)
+		fprintf(stderr, "pam_end failed with %s\n",
+			pam_strerror(pam_handle, rc));
+#endif
+err_free:
+	freecon(tty_context);
+	freecon(new_tty_context);
+	freecon(old_context);
+	freecon(new_context);
+	free(pw.pw_name);
+	free(pw.pw_dir);
+	free(pw.pw_shell);
+	free(shell_argv0);
+	return -1;
 }				/* main() */

--------------030103040708080908050608--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
