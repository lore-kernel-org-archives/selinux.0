Message-ID: <4526D69A.3050302@us.ibm.com>
Date: Fri, 06 Oct 2006 17:20:10 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 3/4] make newrole suid
Content-Type: multipart/mixed;
 boundary="------------000702090208060409080509"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000702090208060409080509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is the 3rd of 4 patches.
This patch applies against policycoreutils-1.30.30-1.

Changes:
  * Updated the #defines, these will be added to the Makefile in
    patch 4/4
  * Mostly cleanup of existing functionality
  * Added some function documentation
  * Drop capabilities is split into three versions
    (AUDIT, NAMESPACE and neither)

Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>



--------------000702090208060409080509
Content-Type: text/x-diff;
 name="02-cleanup_existing_func.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-cleanup_existing_func.patch"

diff -Naur policycoreutils-1.30.30/newrole/newrole.c policycoreutils-1.30.30.suid/newrole/newrole.c
--- policycoreutils-1.30.30/newrole/newrole.c	2006-10-06 17:03:28.000000000 -0500
+++ policycoreutils-1.30.30.suid/newrole/newrole.c	2006-10-06 17:04:02.000000000 -0500
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
@@ -86,18 +87,20 @@
 
 /* USAGE_STRING describes the command-line args of this program. */
 #define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l level ] [ -V ] [ -- args ]"
-
+#define DEFAULT_PATH "/bin:/usr/bin:/usr/local/bin"
 #define DEFAULT_CONTEXT_SIZE 255	/* first guess at context size */
 
-char *xstrdup(const char *s)
+
+/**
+ * Returns valid pointer on success, NULL on failure
+ */
+static char *xstrdup(const char *s)
 {
 	char *s2;
 
 	s2 = strdup(s);
-	if (!s2) {
+	if (!s2)
 		fprintf(stderr, _("Out of memory!\n"));
-		exit(1);
-	}
 	return s2;
 }
 
@@ -120,6 +123,17 @@
 	return 0;
 }
 
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
@@ -136,9 +150,8 @@
 		return newrangep;
 	}
 
-	/* look for MLS range */
+	/* look for MLS range in current context */
 	tmpptr = strchr(range, '-');
-
 	if (tmpptr) {
 		/* we are inserting into a ranged MLS context */
 		len = strlen(newlevel) + 1 + strlen(tmpptr + 1) + 1;
@@ -169,16 +182,11 @@
  * All PAM code goes in this section.
  *
  ************************************************************************/
-
-#include <unistd.h>		/* for getuid(), exit(), getopt() */
-
 #include <security/pam_appl.h>	/* for PAM functions */
 #include <security/pam_misc.h>	/* for misc_conv PAM utility function */
 
 #define SERVICE_NAME "newrole"	/* the name of this program for PAM */
 
-int authenticate_via_pam(const struct passwd *, const char *);
-
 /* authenticate_via_pam()
  *
  * in:     pw - struct containing data from our user's line in 
@@ -192,63 +200,39 @@
  * This function uses PAM to authenticate the user running this
  * program.  This is the only function in this program that makes PAM
  * calls.
- *
  */
-
-int authenticate_via_pam(const struct passwd *pw, const char *ttyn)
+int authenticate_via_pam(const char *ttyn, pam_handle_t *pam_handle)
 {
 
-	int result = 0;		/* our result, set to 0 (not authenticated) by default */
-	int rc;			/* pam return code */
-	pam_handle_t *pam_handle;	/* opaque handle used by all PAM functions */
+	int result = 0;		/* set to 0 (not authenticated) by default */
+	int pam_rc;		/* pam return code */
 	const char *tty_name;
 
-	/* This is a jump table of functions for PAM to use when it wants to *
-	 * communicate with the user.  We'll be using misc_conv(), which is  *
-	 * provided for us via pam_misc.h.                                   */
-	struct pam_conv pam_conversation = {
-		misc_conv,
-		NULL
-	};
-
-	/* Make `p_pam_handle' a valid PAM handle so we can use it when *
-	 * calling PAM functions.                                       */
-	rc = pam_start(SERVICE_NAME,
-		       pw->pw_name, &pam_conversation, &pam_handle);
-	if (rc != PAM_SUCCESS) {
-		fprintf(stderr, _("failed to initialize PAM\n"));
-		exit(-1);
-	}
-
 	if (strncmp(ttyn, "/dev/", 5) == 0)
 		tty_name = ttyn + 5;
 	else
 		tty_name = ttyn;
 
-	rc = pam_set_item(pam_handle, PAM_TTY, tty_name);
-	if (rc != PAM_SUCCESS) {
+	pam_rc = pam_set_item(pam_handle, PAM_TTY, tty_name);
+	if (pam_rc != PAM_SUCCESS) {
 		fprintf(stderr, _("failed to set PAM_TTY\n"));
 		goto out;
 	}
 
 	/* Ask PAM to authenticate the user running this program */
-	rc = pam_authenticate(pam_handle, 0);
-	if (rc != PAM_SUCCESS) {
+	pam_rc = pam_authenticate(pam_handle, 0);
+	if (pam_rc != PAM_SUCCESS) {
 		goto out;
 	}
 
 	/* Ask PAM to verify acct_mgmt */
-	rc = pam_acct_mgmt(pam_handle, 0);
-	if (rc == PAM_SUCCESS) {
+	pam_rc = pam_acct_mgmt(pam_handle, 0);
+	if (pam_rc == PAM_SUCCESS) {
 		result = 1;	/* user authenticated OK! */
 	}
 
-	/* We're done with PAM.  Free `pam_handle'. */
       out:
-	pam_end(pam_handle, rc);
-
-	return (result);
-
+	return result;
 }				/* authenticate_via_pam() */
 
 #else				/* else !USE_PAM */
@@ -258,19 +242,14 @@
  * All shadow passwd code goes in this section.
  *
  ************************************************************************/
-
-#include <unistd.h>		/* for getuid(), exit(), crypt() */
 #include <shadow.h>		/* for shadow passwd functions */
 #include <string.h>		/* for strlen(), memset() */
 
 #define PASSWORD_PROMPT _("Password:")	/* prompt for getpass() */
 
-int authenticate_via_shadow_passwd(const struct passwd *);
-
 /* authenticate_via_shadow_passwd()
  *
- * in:     pw - struct containing data from our user's line in 
- *                         the passwd file.
+ * in:     uname - the calling user's user name
  * out:    nothing
  * return: value   condition
  *         -----   ---------
@@ -280,51 +259,37 @@
  *
  * This function uses the shadow passwd file to thenticate the user running
  * this program.
- *
  */
-
-int authenticate_via_shadow_passwd(const struct passwd *pw)
+int authenticate_via_shadow_passwd(const char *uname)
 {
-
-	struct spwd *p_shadow_line;	/* struct derived from shadow passwd file line */
-	char *unencrypted_password_s;	/* unencrypted password input by user */
-	char *encrypted_password_s;	/* user's password input after being crypt()ed */
-
-	/* Make `p_shadow_line' point to the data from the current user's *
-	 * line in the shadow passwd file.                                */
-	setspent();		/* Begin access to the shadow passwd file. */
-	p_shadow_line = getspnam(pw->pw_name);
-	endspent();		/* End access to the shadow passwd file. */
+	struct spwd *p_shadow_line;
+	char *unencrypted_password_s;
+	char *encrypted_password_s;
+
+	setspent();
+	p_shadow_line = getspnam(uname);
+	endspent();
 	if (!(p_shadow_line)) {
-		fprintf(stderr,
-			_
-			("Cannot find your entry in the shadow passwd file.\n"));
-		exit(-1);
+		fprintf(stderr, _("Cannot find your entry in the shadow "
+			"passwd file.\n"));
+		return 0;
 	}
 
 	/* Ask user to input unencrypted password */
 	if (!(unencrypted_password_s = getpass(PASSWORD_PROMPT))) {
 		fprintf(stderr, _("getpass cannot open /dev/tty\n"));
-		exit(-1);
+		return 0;
 	}
 
-	/* Use crypt() to encrypt user's input password.  Clear the *
-	 * unencrypted password as soon as we're done, so it is not * 
-	 * visible to memory snoopers.                              */
+	/* Use crypt() to encrypt user's input password. */
 	encrypted_password_s = crypt(unencrypted_password_s,
 				     p_shadow_line->sp_pwdp);
 	memset(unencrypted_password_s, 0, strlen(unencrypted_password_s));
-
-	/* Return 1 (authenticated) iff the encrypted version of the user's *
-	 * input password matches the encrypted password stored in the      *
-	 * shadow password file.                                            */
 	return (!strcmp(encrypted_password_s, p_shadow_line->sp_pwdp));
-
-}				/* authenticate_via_shadow_passwd() */
-
+}
 #endif				/* if/else USE_PAM */
 
-/*
+/**
  * This function checks to see if the shell is known in /etc/shells.
  * If so, it returns 1. On error or illegal shell, it returns 0.
  */
@@ -333,7 +298,7 @@
 	int found = 0;
 	const char *buf;
 
-	if (!shell_name)
+	if (! (shell_name && shell_name[0]))
 		return found;
 
 	while ((buf = getusershell()) != NULL) {
@@ -460,67 +425,138 @@
 	return rc;
 }
 
-/*
+/**
  * This function will drop the capabilities so that we are left
  * only with access to the audit system. If the user is root, we leave
  * the capabilities alone since they already should have access to the
  * audit netlink socket.
+ *
+ * Returns zero on success, non-zero otherwise
  */
-#ifdef LOG_AUDIT_PRIV
-static void drop_capabilities(void)
+#if defined(AUDIT_LOG_PRIV) && !defined(NAMESPACE_PRIV)
+static int drop_capabilities(void)
 {
+	int rc = 0;
+	cap_t new_caps, tmp_caps;
+	cap_value_t cap_list[] = { CAP_AUDIT_WRITE };
+	cap_value_t tmp_cap_list[] = { CAP_AUDIT_WRITE, CAP_SETUID };
 	uid_t uid = getuid();
 
-	if (uid) {		/* Non-root path */
-		cap_t new_caps, tmp_caps;
-		cap_value_t cap_list[] = { CAP_AUDIT_WRITE };
-		cap_value_t tmp_cap_list[] = { CAP_AUDIT_WRITE, CAP_SETUID };
-
-		new_caps = cap_init();
-		tmp_caps = cap_init();
-		if (!new_caps || !tmp_caps) {
-			fprintf(stderr,
-				_("Error initing capabilities, aborting.\n"));
-			exit(-1);
-		}
-		cap_set_flag(new_caps, CAP_PERMITTED, 1, cap_list, CAP_SET);
-		cap_set_flag(new_caps, CAP_EFFECTIVE, 1, cap_list, CAP_SET);
-		cap_set_flag(tmp_caps, CAP_PERMITTED, 2, tmp_cap_list, CAP_SET);
-		cap_set_flag(tmp_caps, CAP_EFFECTIVE, 2, tmp_cap_list, CAP_SET);
+	if (!uid)
+		return 0;
 
-		/* Keep capabilities across uid change */
-		prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0);
+	/* Non-root caller, suid root path */
+	new_caps = cap_init();
+	tmp_caps = cap_init();
+	if (!new_caps || !tmp_caps) {
+		fprintf(stderr, _("Error initing capabilities, aborting.\n"));
+		return -1;
+	}
+	rc |= cap_set_flag(new_caps, CAP_PERMITTED, 1, cap_list, CAP_SET);
+	rc |= cap_set_flag(new_caps, CAP_EFFECTIVE, 1, cap_list, CAP_SET);
+	rc |= cap_set_flag(tmp_caps, CAP_PERMITTED, 2, tmp_cap_list, CAP_SET);
+	rc |= cap_set_flag(tmp_caps, CAP_EFFECTIVE, 2, tmp_cap_list, CAP_SET);
+	if (rc) {
+		fprintf(stderr, _("Error setting capabilities, aborting\n"));
+		goto out;
+	}
 
-		/* We should still have root's caps, so drop most capabilities now */
-		if (cap_set_proc(tmp_caps)) {
-			fprintf(stderr,
-				_("Error dropping capabilities, aborting\n"));
-			exit(-1);
-		}
-		cap_free(tmp_caps);
+	/* Keep capabilities across uid change */
+	if (prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0)) {
+		fprintf(stderr, _("Error setting KEEPCAPS, aborting\n"));
+		rc = -1;
+		goto out;
+	}
 
-		/* Change uid */
-		if (setresuid(uid, uid, uid)) {
-			fprintf(stderr, _("Error changing uid, aborting.\n"));
-			exit(-1);
-		}
+	/* Does this temporary change really buy us much? */
+	/* We should still have root's caps, so drop most capabilities now */
+	if ((rc = cap_set_proc(tmp_caps))) {
+		fprintf(stderr, _("Error dropping capabilities, aborting\n"));
+		goto out;
+	}
 
-		/* Now get rid of this ability */
-		if (prctl(PR_SET_KEEPCAPS, 0, 0, 0, 0) < 0) {
-			fprintf(stderr,
-				_("Error resetting KEEPCAPS, aborting\n"));
-			exit(-1);
-		}
+	/* Change uid */
+	if ((rc = setresuid(uid, uid, uid))) {
+		fprintf(stderr, _("Error changing uid, aborting.\n"));
+		goto out;
+	}
 
-		/* Finish dropping capabilities. */
-		if (cap_set_proc(new_caps)) {
-			fprintf(stderr,
-				_
-				("Error dropping SETUID capability, aborting\n"));
-			exit(-1);
-		}
-		cap_free(new_caps);
+	/* Now get rid of this ability */
+	if ((rc = prctl(PR_SET_KEEPCAPS, 0, 0, 0, 0) < 0)) {
+		fprintf(stderr, _("Error resetting KEEPCAPS, aborting\n"));
+		goto out;
+	}
+
+	/* Finish dropping capabilities. */
+	if ((rc = cap_set_proc(new_caps))) {
+		fprintf(stderr,
+			_("Error dropping SETUID capability, aborting\n"));
+		goto out;
 	}
+out:
+	if (cap_free(tmp_caps) || cap_free(new_caps))
+		fprintf(stderr, _("Error freeing caps\n"));
+	return rc;
+}
+#elif defined(NAMESPACE_PRIV)
+/**
+ * This function will drop the capabilities so that we are left
+ * only with access to the audit system and the ability to raise
+ * CAP_SYS_ADMIN, CAP_DAC_OVERRIDE, CAP_FOWNER and CAP_CHOWN,
+ * before invoking pam_namespace.  These capabilities are needed
+ * for performing bind mounts/unmounts and to create potential new
+ * instance directories with appropriate DAC attributes. If the
+ * user is root, we leave the capabilities alone since they already
+ * should have access to the audit netlink socket and should have
+ * the ability to create/mount/unmount instance directories.
+ *
+ * Returns zero on success, non-zero otherwise
+ */
+static int drop_capabilities(void)
+{
+	int rc = 0;
+	cap_t new_caps;
+	cap_value_t cap_list[] = { CAP_AUDIT_WRITE, CAP_SETUID,
+				   CAP_SYS_ADMIN, CAP_FOWNER, CAP_CHOWN,
+				   CAP_DAC_OVERRIDE };
+
+	if (!getuid())
+		return 0;
+
+	/* Non-root caller, suid root path */
+	new_caps = cap_init();
+	if (!new_caps) {
+		fprintf(stderr, _("Error initing capabilities, aborting.\n"));
+		return -1;
+	}
+	rc |= cap_set_flag(new_caps, CAP_PERMITTED, 6, cap_list, CAP_SET);
+	rc |= cap_set_flag(new_caps, CAP_EFFECTIVE, 6, cap_list, CAP_SET);
+	if (rc) {
+		fprintf(stderr, _("Error setting capabilities, aborting\n"));
+		goto out;
+	}
+
+	/* Ensure that caps are dropped after setuid call */
+	if ((rc = prctl(PR_SET_KEEPCAPS, 0, 0, 0, 0) < 0)) {
+		fprintf(stderr, _("Error resetting KEEPCAPS, aborting\n"));
+		goto out;
+	}
+
+	/* We should still have root's caps, so drop most capabilities now */
+	if ((rc = cap_set_proc(new_caps))) {
+		fprintf(stderr, _("Error dropping capabilities, aborting\n"));
+		goto out;
+	}
+out:
+	if (cap_free(new_caps))
+		fprintf(stderr, _("Error freeing caps\n"));
+	return rc;
+}
+
+#else
+static inline int drop_capabilities(void)
+{
+	return 0;
 }
 #endif
 
@@ -541,7 +577,7 @@
 }
 #endif
 
-#ifdef LOG_AUDIT_PRIV
+#ifdef AUDIT_LOG_PRIV
 /* Send audit message */
 static
 int send_audit_message(int success, security_context_t old_context,
@@ -577,12 +613,10 @@
 }
 #else
 static inline
-    int send_audit_message(int success __attribute__ ((unused)),
-			   security_context_t old_context
-			   __attribute__ ((unused)),
-			   security_context_t new_context
-			   __attribute__ ((unused)), const char *ttyn
-			   __attribute__ ((unused)))
+int send_audit_message(int success __attribute__ ((unused)),
+		       security_context_t old_context __attribute__ ((unused)),
+		       security_context_t new_context __attribute__ ((unused)),
+		       const char *ttyn __attribute__ ((unused)))
 {
 	return 0;
 }

--------------000702090208060409080509--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
