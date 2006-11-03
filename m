Message-ID: <454A9629.6060600@us.ibm.com>
Date: Thu, 02 Nov 2006 19:06:49 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 7/8] make newrole suid (take 3)
References: <454A8F35.2020006@us.ibm.com>
In-Reply-To: <454A8F35.2020006@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------050904040805050309050808"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050904040805050309050808
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
> 7) Move command-line argument parsing into a function
>    Clear the environment during execution
>    Add support for preserving the environment (-p)

This is the 7th of 8 patches.
This patch applies against policycoreutils-1.30.30-1.

This function introduces a sanitized environment during the life-time
of newrole's execution, and sets the environment to either the preserved
environment or a minimal environment before shell execution.

Changes:
  * Introduces restore_environment()
    - New functionality, for preserving the environment or sanitizing it
  * Introduces parse_command_line_arguments()
    - Move functionality from main() into parse_command_line_arguments
  * Uses the above new functions in main()

Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>


--------------050904040805050309050808
Content-Type: text/x-diff;
 name="07-add_preserve_env.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="07-add_preserve_env.patch"

diff -Naur policycoreutils-1.30.30/newrole/newrole.c policycoreutils-1.30.30.suid/newrole/newrole.c
--- policycoreutils-1.30.30/newrole/newrole.c	2006-11-02 12:48:59.000000000 -0600
+++ policycoreutils-1.30.30.suid/newrole/newrole.c	2006-11-02 12:58:52.000000000 -0600
@@ -85,10 +85,13 @@
 #endif
 
 /* USAGE_STRING describes the command-line args of this program. */
-#define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l level ] [ -V ] [ -- args ]"
+#define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l level ] [ -p ] [ -V ] [ -- args ]"
 
+#define DEFAULT_PATH "/usr/bin:/bin"
 #define DEFAULT_CONTEXT_SIZE 255	/* first guess at context size */
 
+extern char **environ;
+
 char *xstrdup(const char *s)
 {
 	char *s2;
@@ -340,6 +343,74 @@
 }
 
 /**
+ * Either restore the original environment, or set up a minimal one.
+ *
+ * The minimal environment contains:
+ * TERM, DISPLAY and XAUTHORITY - if they are set, preserve values
+ * HOME, SHELL, USER and LOGNAME - set to contents of /etc/passwd
+ * PATH - set to default value DEFAULT_PATH
+ *
+ * Returns zero on success, non-zero otherwise
+ */
+static int restore_environment(int preserve_environment,
+			       char **old_environ, const struct passwd *pw)
+{
+	char const *term_env;
+	char const *display_env;
+	char const *xauthority_env;
+	char *term = NULL;		/* temporary container */
+	char *display = NULL;		/* temporary container */
+	char *xauthority = NULL;	/* temporary container */
+	int rc;
+
+	environ = old_environ;
+
+	if (preserve_environment)
+		return 0;
+
+	term_env = getenv("TERM");
+	display_env = getenv("DISPLAY");
+	xauthority_env = getenv("XAUTHORITY");
+
+	/* Save the variable values we want */
+	if (term_env)
+		term = strdup(term_env);
+	if (display_env)
+		display = strdup(display_env);
+	if (xauthority_env)
+		xauthority = strdup(xauthority_env);
+	if ((term_env && !term) || (display_env && !display) ||
+	     (xauthority_env && !xauthority)) {
+		rc = -1;
+		goto out;
+	}
+
+	/* Construct a new environment */
+	if ((rc = clearenv())) {
+		fprintf(stderr, _("Unable to clear environment\n"));
+		goto out;
+	}
+
+	/* Restore that which we saved */
+	if (term)
+		rc |= setenv("TERM", term, 1);
+	if (display)
+		rc |= setenv("DISPLAY", display, 1);
+	if (xauthority)
+		rc |= setenv("XAUTHORITY", xauthority, 1);
+	rc |= setenv("HOME", pw->pw_dir, 1);
+	rc |= setenv("SHELL", pw->pw_shell, 1);
+	rc |= setenv("USER", pw->pw_name, 1);
+	rc |= setenv("LOGNAME", pw->pw_name, 1);
+	rc |= setenv("PATH", DEFAULT_PATH, 1);
+out:
+	free(term);
+	free(display);
+	free(xauthority);
+	return rc;
+}
+
+/**
  * This function will drop the capabilities so that we are left
  * only with access to the audit system. If the user is root, we leave
  * the capabilities alone since they already should have access to the
@@ -627,6 +698,172 @@
 	return rc;
 }
 
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
+					security_context_t *new_context,
+					int *preserve_environment)
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
+		{"preserve-environment", 0, 0, 'p'},
+		{"version", 0, 0, 'V'},
+		{NULL, 0, 0, 0}
+	};
+
+	*preserve_environment = 0;
+	while (1) {
+		clflag = getopt_long(argc, argv, "r:t:l:pV", long_options,
+				     &flag_index);
+		if (clflag == -1)
+			break;
+
+		switch (clflag) {
+		case 'V':
+			printf("newrole: %s version %s\n", PACKAGE, VERSION);
+			exit(0);
+			break;
+		case 'p':
+			*preserve_environment = 1;
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
+	*new_context = strdup(new_con);
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
+	/* Don't free new_con, context_free(context) handles this */
+	context_free(context);
+	return -1;
+}
 
 /**
  * Take care of any signal setup
@@ -660,32 +897,20 @@
 
 int main(int argc, char *argv[])
 {
-
-	security_context_t new_context = NULL;	/* our target security context */
-	security_context_t old_context = NULL;	/* our original securiy context */
-	security_context_t tty_context = NULL;	/* The current context of tty file */
-	security_context_t new_tty_context = NULL;	/* The new context of tty file */
-
-	context_t context;	/* manipulatable form of new_context */
+	security_context_t new_context = NULL;	/* target security context */
+	security_context_t old_context = NULL;	/* original securiy context */
+	security_context_t tty_context = NULL;	/* current context of tty */
+	security_context_t new_tty_context = NULL; /* new context of tty */
 
 	struct passwd pw;	/* struct derived from passwd file line */
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
 	char *ttyn = NULL;	/* tty path */
+
+	char **old_environ;
+	int preserve_environment;
+
+	int fd;
+	int rc;
 	pid_t childPid = 0;
-	int fd, rc;
-	int enforcing;
 	char *shell_argv0 = NULL;
 
 #ifdef USE_PAM
@@ -719,139 +944,40 @@
 	textdomain(PACKAGE);
 #endif
 
-	/*
-	 *
-	 * Step 1:  Handle command-line arguments.
-	 *
-	 */
+	old_environ = environ;
+	environ = NULL;
 
 	if (!is_selinux_enabled()) {
-		fprintf(stderr,
-			_
-			("Sorry, newrole may be used only on a SELinux kernel.\n"));
-		exit(-1);
-	}
-	enforcing = security_getenforce();
-	if (enforcing < 0) {
-		fprintf(stderr, _("Could not determine enforcing mode.\n"));
-		exit(-1);
-	}
-
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
+		fprintf(stderr, _("Sorry, newrole may be used only on "
+			"a SELinux kernel.\n"));
+		return -1;
 	}
 
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
+	if (security_getenforce() < 0) {
+		fprintf(stderr, _("Could not determine enforcing mode.\n"));
+		return -1;
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
+		return -1;
 	}
 
-	/* Get the tty name. Pam will need it. */
 	ttyn = ttyname(0);
 	if (!ttyn || *ttyn == '\0') {
 		fprintf(stderr,
 			_("Error!  Could not retrieve tty information.\n"));
-		exit(-1);
+		return -1;
 	}
 
-	/* Get the passwd info for the Linux user identity. */
-	if (extract_pw_data(&pw))
+	if (parse_command_line_arguments(argc, argv, ttyn, old_context,
+					 &new_context, &preserve_environment))
 		return -1;
 
 	/*
@@ -862,6 +988,9 @@
 	 * malicious software), not to authorize the operation (which is covered
 	 * by policy).  Trusted path mechanism would be preferred.
 	 */
+	if (extract_pw_data(&pw))
+		goto err_free;
+
 	printf(_("Authenticating %s.\n"), pw.pw_name);
 #ifdef USE_PAM
 	pam_status = pam_start(SERVICE_NAME, pw.pw_name, &pam_conversation,
@@ -882,86 +1011,6 @@
 	}
 
 	/*
-	 *
-	 * Step 3:  Construct a new context based on our old context and the
-	 *          arguments specified on the command line.
-	 *
-	 */
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
-
-	/*
 	 * Step 3:  Handle relabeling of the tty.
 	 *
 	 * Once we authenticate the user, we know that we want to proceed with
@@ -1086,6 +1135,13 @@
 	if (send_audit_message(1, old_context, new_context, ttyn))
 		exit(-1);
 	freecon(old_context);
+
+	/* Handle environment changes */
+	if (restore_environment(preserve_environment, old_environ, &pw)) {
+		fprintf(stderr, _("Unable to restore the environment, "
+			"aborting\n"));
+		goto err_close_pam;
+	}
 	execv(pw.pw_shell, argv + optind - 1);
 
 	/*

--------------050904040805050309050808--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
