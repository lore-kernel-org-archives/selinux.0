Message-ID: <454A95E1.8040900@us.ibm.com>
Date: Thu, 02 Nov 2006 19:05:37 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 5/8] make newrole suid (take 3)
References: <454A8F35.2020006@us.ibm.com>
In-Reply-To: <454A8F35.2020006@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------040008020407050201080404"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040008020407050201080404
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

This is the 5th of 8 patches.
This patch applies against policycoreutils-1.30.30-1.

This patch updates the authentication functions so that they are
cleaner, and moves pam_start() into main() in prep for namespace
support.

Changes:
  * Updates the authentication functions
    - Noteably, pam_start is now done in main()
    - Removed a lot of very obvious comments and clutter
  * Adds pam variables to main()
  * Adds pam_start() to main()
  * Adds cleanup gotos to main() for pam_end() and missing frees

Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>


--------------040008020407050201080404
Content-Type: text/x-diff;
 name="05-update_authentication.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="05-update_authentication.patch"

diff -Naur policycoreutils-1.30.30/newrole/newrole.c policycoreutils-1.30.30.suid/newrole/newrole.c
--- policycoreutils-1.30.30/newrole/newrole.c	2006-11-02 12:28:46.000000000 -0600
+++ policycoreutils-1.30.30.suid/newrole/newrole.c	2006-11-02 12:37:17.000000000 -0600
@@ -150,16 +150,11 @@
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
@@ -173,63 +168,39 @@
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
@@ -239,19 +210,14 @@
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
@@ -261,48 +227,34 @@
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
 
 /*
@@ -626,10 +578,22 @@
 	char *level_s = NULL;	/* level spec'd by user in argv[] */
 	char *ttyn = NULL;	/* tty path */
 	pid_t childPid = 0;
-	uid_t uid;
-	int fd;
+	int fd, rc;
 	int enforcing;
 
+#ifdef USE_PAM
+	int pam_status;		   /* pam return code */
+	pam_handle_t *pam_handle;  /* opaque handle used by all PAM functions */
+
+	/* This is a jump table of functions for PAM to use when it wants to *
+	 * communicate with the user.  We'll be using misc_conv(), which is  *
+	 * provided for us via pam_misc.h.                                   */
+	struct pam_conv pam_conversation = {
+		misc_conv,
+		NULL
+	};
+#endif
+
 	/*
 	 * Step 0: Setup
 	 *
@@ -771,26 +735,6 @@
 		exit(-1);
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
-	if (extract_pw_data(&pw))
-		return -1;
-
 	/* Get the tty name. Pam will need it. */
 	ttyn = ttyname(0);
 	if (!ttyn || *ttyn == '\0') {
@@ -799,28 +743,36 @@
 		exit(-1);
 	}
 
-	printf(_("Authenticating %s.\n"), pw.pw_name);
+	/* Get the passwd info for the Linux user identity. */
+	if (extract_pw_data(&pw))
+		return -1;
 
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
-	if (!authenticate_via_pam(&pw, ttyn))
-#else				/* !USE_PAM */
-	if (!authenticate_via_shadow_passwd(&pw))
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
 			pw.pw_name);
-		return (-1);
+		goto err_close_pam;
 	}
-	/* If we reach here, then we have authenticated the user. */
-#ifdef CANTSPELLGDB
-	printf("You are authenticated!\n");
-#endif
 
 	/*
 	 *
@@ -1062,7 +1014,26 @@
 	freecon(old_context);
 	execv(pw.pw_shell, argv + optind - 1);
 
-	/* If we reach here, then we failed to exec the new shell. */
+	/*
+	 * Error path cleanup
+	 *
+	 * If we reach here, then we failed to exec the new shell.
+	 */
 	perror(_("failed to exec shell\n"));
-	return (-1);
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
+	return -1;
 }				/* main() */

--------------040008020407050201080404--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
