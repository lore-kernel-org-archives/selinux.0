Message-ID: <4526D531.1090409@us.ibm.com>
Date: Fri, 06 Oct 2006 17:14:09 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 1/4] make newrole suid
Content-Type: multipart/mixed;
 boundary="------------050600050609000600030100"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050600050609000600030100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is the 1st of 4 patches.
This patch applies against policycoreutils-1.30.30-1.

Changes:
  * This patch breaks up the operations performed by newrole
    into functions. They are called in patch 2/4.
  * The following functions do not new functionality:
    - extract_pw_data
    - relabel_tty
    - restore_tty_label
    - parse_command_line_arguments
  * The following functions do add new functionality:
    - xsetenv
    - sanitize_environment
    - transition_to_caller_uid
    - set_signal_handles

The new (and existing) functionality should be adequately documented in 
the code. If it is not clear, I consider that to be a failure of the 
code, and please let me know.

Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>


--------------050600050609000600030100
Content-Type: text/x-diff;
 name="00-new_funcs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="00-new_funcs.patch"

diff -Naur policycoreutils-1.30.30/newrole/newrole.c policycoreutils-1.30.30.suid/newrole/newrole.c
--- policycoreutils-1.30.30/newrole/newrole.c	2006-09-29 10:50:27.000000000 -0500
+++ policycoreutils-1.30.30.suid/newrole/newrole.c	2006-10-06 16:58:06.000000000 -0500
@@ -101,6 +101,25 @@
 	return s2;
 }
 
+/**
+ * Returns zero on success, non-zero otherwise
+ */
+static int xsetenv(char const *name, char const *val)
+{
+	size_t namelen = strlen(name);
+	size_t vallen = strlen(val);
+	char *string = malloc(namelen + 1 + vallen + 1);
+
+	if (!string)
+		return -1;
+	strcpy(string, name);
+	string[namelen] = '=';
+	strcpy(string + namelen + 1, val);
+	if (putenv (string) != 0)
+		return -1;
+	return 0;
+}
+
 static char *build_new_range(char *newlevel, const char *range)
 {
 	char *newrangep = NULL;
@@ -332,6 +351,115 @@
 	return found;
 }
 
+/**
+ * Determine the Linux user identity to re-authenticate.
+ * If supported and set, use the login uid, as this should be more stable.
+ * Otherwise, use the real uid.
+ *
+ * This function assigns malloc'd memory into the pw_copy struct.
+ * Returns zero on success, non-zero otherwise
+ */
+int extract_pw_data(struct passwd *pw_copy)
+{
+	uid_t uid;
+	struct passwd *pw;
+
+#ifdef USE_AUDIT
+	uid = audit_getloginuid();
+	if (uid == (uid_t) - 1)
+		uid = getuid();
+#else
+	uid = getuid();
+#endif
+
+	setpwent();
+	pw = getpwuid(uid);
+	endpwent();
+	if (!(pw && pw->pw_name && pw->pw_name[0] && pw->pw_shell
+	      && pw->pw_shell[0] && pw->pw_dir && pw->pw_dir[0])) {
+		fprintf(stderr,
+			_("cannot find valid entry in the passwd file.\n"));
+		return -1;
+	}
+
+	*pw_copy = *pw;
+	pw = pw_copy;
+	pw->pw_name = xstrdup(pw->pw_name);
+	pw->pw_dir = xstrdup(pw->pw_dir);
+	pw->pw_shell = xstrdup(pw->pw_shell);
+
+	if (! (pw->pw_name && pw->pw_dir && pw->pw_shell))
+		goto out_free;
+
+	if (verify_shell(pw->pw_shell) == 0) {
+		fprintf(stderr, _("Error!  Shell is not valid.\n"));
+		goto out_free;
+	}
+	return 0;
+
+out_free:
+	free(pw->pw_name);
+	free(pw->pw_dir);
+	free(pw->pw_shell);
+	return -1;
+}
+
+/**
+ * Unset all environment variables except:
+ * TERM, DISPLAY and XAUTHORITY - if they are set, preserve values
+ * HOME, SHELL, USER and LOGNAME - set to contents of /etc/passwd
+ * PATH - set to default value DEFAULT_PATH
+ *
+ * Returns zero on success, non-zero otherwise
+ */
+static int sanitize_environment(const struct passwd *pw)
+{
+	char const *term_env = getenv("TERM");
+	char const *display_env = getenv("DISPLAY");
+	char const *xauthority_env = getenv("XAUTHORITY");
+	char *term = NULL;		/* temporary container */
+	char *display = NULL;		/* temporary container */
+	char *xauthority = NULL;	/* temporary container */
+	int rc;
+
+	/* Save the variable values we want */
+	if (term_env)
+		term = xstrdup(term_env);
+	if (display_env)
+		display = xstrdup(display_env);
+	if (xauthority_env)
+		xauthority = xstrdup(xauthority_env);
+	if ((term_env && !term) || (display_env && !display) ||
+	     (xauthority_env && !xauthority)) {
+		rc = -1;
+		goto out;
+	}
+
+	/* Clear everything from the env */
+	if ((rc = clearenv())) {
+		fprintf(stderr, _("Unable to clear environment\n"));
+		goto out;
+	}
+
+	/* Restore that which we saved */
+	if (term)
+		rc |= xsetenv("TERM", term);
+	if (display)
+		rc |= xsetenv("DISPLAY", display);
+	if (xauthority)
+		rc |= xsetenv("XAUTHORITY", xauthority);
+	rc |= xsetenv("HOME", pw->pw_dir);
+	rc |= xsetenv("SHELL", pw->pw_shell);
+	rc |= xsetenv("USER", pw->pw_name);
+	rc |= xsetenv("LOGNAME", pw->pw_name);
+	rc |= xsetenv("PATH", DEFAULT_PATH);
+out:
+	free(term);
+	free(display);
+	free(xauthority);
+	return rc;
+}
+
 /*
  * This function will drop the capabilities so that we are left
  * only with access to the audit system. If the user is root, we leave
@@ -396,6 +524,23 @@
 }
 #endif
 
+#ifdef NAMESPACE_PRIV
+/**
+ * This function will set the uid values to be that of caller's uid, and
+ * will drop any privilages which maybe have been raised.
+ */
+static int transition_to_caller_uid()
+{
+	uid_t uid = getuid();
+
+	if (setresuid(uid, uid, uid)) {
+		fprintf(stderr, _("Error changing uid, aborting.\n"));
+		return -1;
+	}
+	return 0;
+}
+#endif
+
 #ifdef LOG_AUDIT_PRIV
 /* Send audit message */
 static
@@ -443,6 +588,292 @@
 }
 #endif
 
+/**
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
+/**
+ * Parses and validates the provided command line options and
+ * constructs a new context based on our old context and the
+ * arguments specified on the command line. On success
+ * new_context will be set to valid values, otherwise its value
+ * is left unchanged.
+ *
+ * Returns zero on success, non-zero otherwise.
+ */
+static int parse_command_line_arguments(int argc, char **argv, char *ttyn,
+					security_context_t old_context,
+					security_context_t *new_context)
+{
+	int flag_index;		/* flag index in argv[] */
+	int clflag;		/* holds codes for command line flags */
+	char *role_s = NULL;	/* role spec'd by user in argv[] */
+	char *type_s = NULL;	/* type spec'd by user in argv[] */
+	char *type_ptr = NULL;	/* stores malloc'd data from get_default_type */
+	char *level_s = NULL;	/* level spec'd by user in argv[] */
+	char *range_ptr = NULL;
+	security_context_t new_con = NULL;
+	context_t context = NULL; /* manipulatable form of new_context */
+	const struct option long_options[] = {
+		{"role", 1, 0, 'r'},
+		{"type", 1, 0, 't'},
+		{"level", 1, 0, 'l'},
+		{"version", 0, 0, 'V'},
+		{NULL, 0, 0, 0}
+	};
+
+	while (1) {
+		clflag = getopt_long(argc, argv, "r:t:l:V", long_options,
+				     &flag_index);
+		if (clflag == -1)
+			break;
+
+		switch (clflag) {
+		case 'V':
+			printf("newrole: %s version %s\n", PACKAGE, VERSION);
+			exit(0);
+			break;
+		case 'r':
+			if (role_s) {
+				fprintf(stderr,
+					_("Error: multiple roles specified\n"));
+				return -1;
+			}
+			role_s = optarg;
+			break;
+		case 't':
+			if (type_s) {
+				fprintf(stderr,
+					_("Error: multiple types specified\n"));
+				return -1;
+			}
+			type_s = optarg;
+			break;
+		case 'l':
+			if (!is_selinux_mls_enabled()) {
+				fprintf(stderr, _("Sorry, -l may be used with "
+					"SELinux MLS support.\n"));
+				return -1;
+			}
+			if (level_s) {
+				fprintf(stderr, _("Error: multiple levels "
+					"specified\n"));
+				return -1;
+			}
+			level_s = optarg;
+			break;
+		default:
+			fprintf(stderr, "%s\n", USAGE_STRING);
+			return -1;
+		}
+	}
+
+	/* Verify that the combination of command-line arguments are viable */
+	if (!(role_s || type_s || level_s)) {
+		fprintf(stderr, "%s\n", USAGE_STRING);
+		return -1;
+	}
+
+	/* Fill in a default type if one hasn't been specified. */
+	if (role_s && !type_s) {
+	 	/* get_default_type() returns malloc'd memory */
+		if (get_default_type(role_s, &type_ptr)) {
+			fprintf(stderr, _("Couldn't get default type.\n"));
+			send_audit_message(0, old_context, new_con, ttyn);
+			return -1;
+		}
+		type_s = type_ptr;
+	}
+
+	/* Create a temporary new context structure we extract and modify */
+	context = context_new(old_context);
+	if (!context) {
+		fprintf(stderr, _("failed to get new context.\n"));
+		goto err_free;
+	}
+
+	/* Modify the temporary new context */
+	if (role_s)
+		if (context_role_set(context, role_s)) {
+			fprintf(stderr, _("failed to set new role %s\n"),
+				role_s);
+			goto err_free;
+		}
+
+	if (type_s)
+		if (context_type_set(context, type_s)) {
+			fprintf(stderr, _("failed to set new type %s\n"),
+				type_s);
+			goto err_free;
+		}
+
+	if (level_s) {
+		range_ptr = build_new_range(level_s,context_range_get(context));
+		if (!range_ptr) {
+			fprintf(stderr,
+				_("failed to build new range with level %s\n"),
+				level_s);
+			goto err_free;
+		}
+		if (context_range_set(context, range_ptr)) {
+			fprintf(stderr, _("failed to set new range %s\n"),
+				range_ptr);
+			goto err_free;
+		}
+	}
+
+	/* Construct the final new context */
+	if (!(new_con = context_str(context))) {
+		fprintf(stderr, _("failed to convert new context to string\n"));
+		goto err_free;
+	}
+
+	if (security_check_context(new_con) < 0) {
+		fprintf(stderr, _("%s is not a valid context\n"), new_con);
+		send_audit_message(0, old_context, new_con, ttyn);
+		goto err_free;
+	}
+
+	*new_context = xstrdup(new_con);
+	if (!*new_context) {
+		fprintf(stderr, _("Unable to allocate memory for new_context"));
+		goto err_free;
+	}
+
+	free(type_ptr);
+	free(range_ptr);
+	context_free(context);
+	return 0;
+
+err_free:
+	free(type_ptr);
+	free(range_ptr);
+	freecon(new_con);
+	context_free(context);
+	return -1;
+}
+
+/**
+ * Take care of any signal setup
+ */
+static int set_signal_handles()
+{
+	sigset_t empty;
+
+	/* Empty the signal mask in case someone is blocking a signal */
+	if (sigemptyset(&empty)) {
+		fprintf(stderr, _("Unable to obtain empty signal set\n"));
+		return -1;
+	}
+
+	(void)sigprocmask(SIG_SETMASK, &empty, NULL);
+
+	/* Terminate on SIGHUP. */
+	if (signal(SIGHUP, SIG_DFL) == SIG_ERR) {
+		fprintf(stderr, _("Unable to set SIGHUP handler\n"));
+		return -1;
+	}
+
+	return 0;
+}
+
 /************************************************************************
  *
  * All code used for both PAM and shadow passwd goes in this section.

--------------050600050609000600030100--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
