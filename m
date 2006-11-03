Message-ID: <454A964F.2050407@us.ibm.com>
Date: Thu, 02 Nov 2006 19:07:27 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 8/8] make newrole suid (take 3)
References: <454A8F35.2020006@us.ibm.com>
In-Reply-To: <454A8F35.2020006@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------020009020100060908080208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020009020100060908080208
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
> 8) Shift to using new defines in the Makefile and in newrole.c
>    Add support for namespaces
>    Remove unused code, cleanup and documentation

This is the 8th of 8 patches.
This patch applies against policycoreutils-1.30.30-1.

This function finalizes all of the changes made by the previous 7 
patches and introduces the namespace support.

Changes:
  * Introduces namespace support and transition_to_caller_uid()
    - New functionality, for polyinstantitation
  * Various bits of cleanup remaining from previous patches

Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>


--------------020009020100060908080208
Content-Type: text/x-diff;
 name="08-enable_namespace.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="08-enable_namespace.patch"

diff -Naur policycoreutils-1.30.30/newrole/Makefile policycoreutils-1.30.30.suid/newrole/Makefile
--- policycoreutils-1.30.30/newrole/Makefile	2006-11-02 12:13:45.000000000 -0600
+++ policycoreutils-1.30.30.suid/newrole/Makefile	2006-11-02 13:06:52.000000000 -0600
@@ -6,11 +6,6 @@
 LOCALEDIR = /usr/share/locale
 PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
-# If LOG_AUDIT_PRIV is y, then newrole will be made into setuid root program.
-# This is so that we have the CAP_AUDIT_WRITE capability. newrole will
-# shed all privileges and change to the user's uid.
-LOG_AUDIT_PRIV ?= n
-
 # Enable capabilities to permit newrole to generate audit records.
 # This will make newrole a setuid root program.
 # The capabilities used are: CAP_AUDIT_WRITE.
@@ -39,7 +34,6 @@
 	override CFLAGS += -DUSE_AUDIT
 	LDLIBS += -laudit
 endif
-
 ifeq (${LSPP_PRIV},y)
 	override AUDIT_LOG_PRIV=y
 	override NAMESPACE_PRIV=y
@@ -59,14 +53,6 @@
 	MODE := 0555
 endif
 
-ifeq (${LOG_AUDIT_PRIV},y)
-	override CFLAGS += -DLOG_AUDIT_PRIV
-	LDLIBS += -lcap
-	MODE := 4555
-else
-	MODE := 555
-endif
-
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
 all: $(TARGETS)
diff -Naur policycoreutils-1.30.30/newrole/newrole.c policycoreutils-1.30.30.suid/newrole/newrole.c
--- policycoreutils-1.30.30/newrole/newrole.c	2006-11-02 13:00:29.000000000 -0600
+++ policycoreutils-1.30.30.suid/newrole/newrole.c	2006-11-02 13:05:23.000000000 -0600
@@ -36,11 +36,6 @@
  * setuid root, so that it can read the shadow passwd file.
  * 
  *
- * option CANTSPELLGDB:
- *
- * If you set CANTSPELLGDB you will turn on some debugging printfs.
- *
- *
  * Authors:  Tim Fraser , 
  *           Anthony Colatrella <amcolat@epoch.ncsc.mil>
  * Various bug fixes by Stephen Smalley <sds@epoch.ncsc.mil>
@@ -48,6 +43,14 @@
  *************************************************************************/
 
 #define _GNU_SOURCE
+
+#if defined(AUDIT_LOG_PRIV) && !defined(USE_AUDIT)
+#error AUDIT_LOG_PRIV needs the USE_AUDIT option
+#endif
+#if defined(NAMESPACE_PRIV) && !defined(USE_PAM)
+#error NAMESPACE_PRIV needs the USE_PAM option
+#endif
+
 #include <stdio.h>
 #include <stdlib.h>		/* for malloc(), realloc(), free() */
 #include <pwd.h>		/* for getpwuid() */
@@ -63,13 +66,11 @@
 #include <selinux/get_default_type.h>
 #include <selinux/get_context_list.h>	/* for SELINUX_DEFAULTUSER */
 #include <signal.h>
+#include <unistd.h>		/* for getuid(), exit(), getopt() */
 #ifdef USE_AUDIT
 #include <libaudit.h>
 #endif
-#ifdef LOG_AUDIT_PRIV
-#ifndef USE_AUDIT
-#error LOG_AUDIT_PRIV needs the USE_AUDIT option
-#endif
+#if defined(AUDIT_LOG_PRIV) || (NAMESPACE_PRIV)
 #include <sys/prctl.h>
 #include <sys/capability.h>
 #endif
@@ -92,18 +93,17 @@
 
 extern char **environ;
 
-char *xstrdup(const char *s)
-{
-	char *s2;
-
-	s2 = strdup(s);
-	if (!s2) {
-		fprintf(stderr, _("Out of memory!\n"));
-		exit(1);
-	}
-	return s2;
-}
-
+/**
+ * Construct from the current range and specified desired level a resulting
+ * range. If the specified level is a range, return that. If it is not, then
+ * construct a range with level as the sensitivity and clearance of the current
+ * context.
+ *
+ * newlevel - the level specified on the command line
+ * range    - the range in the current context
+ *
+ * Returns malloc'd memory
+ */
 static char *build_new_range(char *newlevel, const char *range)
 {
 	char *newrangep = NULL;
@@ -120,9 +120,8 @@
 		return newrangep;
 	}
 
-	/* look for MLS range */
+	/* look for MLS range in current context */
 	tmpptr = strchr(range, '-');
-
 	if (tmpptr) {
 		/* we are inserting into a ranged MLS context */
 		len = strlen(newlevel) + 1 + strlen(tmpptr + 1) + 1;
@@ -260,7 +259,7 @@
 }
 #endif				/* if/else USE_PAM */
 
-/*
+/**
  * This function checks to see if the shell is known in /etc/shells.
  * If so, it returns 1. On error or illegal shell, it returns 0.
  */
@@ -269,7 +268,7 @@
 	int found = 0;
 	const char *buf;
 
-	if (!shell_name)
+	if (! (shell_name && shell_name[0]))
 		return found;
 
 	while ((buf = getusershell()) != NULL) {
@@ -545,7 +544,29 @@
 }
 #endif
 
-#ifdef LOG_AUDIT_PRIV
+#ifdef NAMESPACE_PRIV
+/**
+ * This function will set the uid values to be that of caller's uid, and
+ * will drop any privilages which maybe have been raised.
+ */
+static int transition_to_caller_uid()
+{
+	uid_t uid = getuid();
+
+	if (prctl(PR_SET_KEEPCAPS, 0, 0, 0, 0) < 0) {
+		fprintf(stderr, _("Error resetting KEEPCAPS, aborting\n"));
+		return -1;
+	}
+
+	if (setresuid(uid, uid, uid)) {
+		fprintf(stderr, _("Error changing uid, aborting.\n"));
+		return -1;
+	}
+	return 0;
+}
+#endif
+
+#ifdef AUDIT_LOG_PRIV
 /* Send audit message */
 static
 int send_audit_message(int success, security_context_t old_context,
@@ -1085,62 +1106,67 @@
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
-	if (asprintf(&argv[optind - 1], "-%s", pw.pw_shell) < 0) {
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
+	}
+
+#ifdef NAMESPACE_PRIV
+	/* Ask PAM to setup session for user running this program */
+	pam_status = pam_open_session(pam_handle,0);
+	if (pam_status != PAM_SUCCESS) {
+		fprintf(stderr, "pam_open_session failed with %s\n",
+			pam_strerror(pam_handle, pam_status));
+		goto err_close_pam;
 	}
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
+	freecon(new_context);
 
 	/* Handle environment changes */
 	if (restore_environment(preserve_environment, old_environ, &pw)) {
 		fprintf(stderr, _("Unable to restore the environment, "
 			"aborting\n"));
-		goto err_close_pam;
+		goto err_close_pam_session;
 	}
 	execv(pw.pw_shell, argv + optind - 1);
 
@@ -1150,6 +1176,13 @@
 	 * If we reach here, then we failed to exec the new shell.
 	 */
 	perror(_("failed to exec shell\n"));
+err_close_pam_session:
+#ifdef NAMESPACE_PRIV
+	pam_status = pam_close_session(pam_handle,0);
+	if(pam_status != PAM_SUCCESS)
+		fprintf(stderr, "pam_close_session failed with %s\n",
+			pam_strerror(pam_handle, pam_status));
+#endif
 err_close_pam:
 #ifdef USE_PAM
 	rc = pam_end(pam_handle, pam_status);

--------------020009020100060908080208--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
