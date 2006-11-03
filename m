Message-ID: <454A9566.1000304@us.ibm.com>
Date: Thu, 02 Nov 2006 19:03:34 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 2/8] make newrole suid (take 3)
References: <454A8F35.2020006@us.ibm.com>
In-Reply-To: <454A8F35.2020006@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------030508030202090602000807"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030508030202090602000807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michael C Thompson wrote:
> The 8 patches are as follows:
> 1) Modifications to Makefile to support future patch needs
>    Add newrole-lspp.pamd
> 2) New extract_pw_data function and use in main()

This is the 2nd of 8 patches.
This patch applies against policycoreutils-1.30.30-1.

This patch moves the parse /etc/passwd functionality from
main() into a separate function.

Changes:
  * Introduces the extract_pw_data() function and uses it in main()

Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>


--------------030508030202090602000807
Content-Type: text/x-diff;
 name="02-extract_passwd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-extract_passwd.patch"

diff -Naur policycoreutils-1.30.30/newrole/newrole.c policycoreutils-1.30.30.suid/newrole/newrole.c
--- policycoreutils-1.30.30/newrole/newrole.c	2006-09-29 10:50:27.000000000 -0500
+++ policycoreutils-1.30.30.suid/newrole/newrole.c	2006-11-02 12:19:12.000000000 -0600
@@ -332,6 +332,61 @@
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
+	pw->pw_name = strdup(pw->pw_name);
+	pw->pw_dir = strdup(pw->pw_dir);
+	pw->pw_shell = strdup(pw->pw_shell);
+
+	if (! (pw->pw_name && pw->pw_dir && pw->pw_shell)) {
+		fprintf(stderr, _("Out of memory!\n"));
+		goto out_free;
+	}
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
 /*
  * This function will drop the capabilities so that we are left
  * only with access to the audit system. If the user is root, we leave
@@ -460,8 +515,7 @@
 
 	context_t context;	/* manipulatable form of new_context */
 
-	struct passwd *pw;	/* struct derived from passwd file line */
-	struct passwd pw_copy;
+	struct passwd pw;	/* struct derived from passwd file line */
 
 	int clflag;		/* holds codes for command line flags */
 	int flag_index;		/* flag index in argv[] */
@@ -639,22 +693,8 @@
 #endif
 
 	/* Get the passwd info for the Linux user identity. */
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
+	if (extract_pw_data(&pw))
+		return -1;
 
 	/* Get the tty name. Pam will need it. */
 	ttyn = ttyname(0);
@@ -664,7 +704,7 @@
 		exit(-1);
 	}
 
-	printf(_("Authenticating %s.\n"), pw->pw_name);
+	printf(_("Authenticating %s.\n"), pw.pw_name);
 
 	/* 
 	 * Re-authenticate the user running this program.
@@ -673,13 +713,13 @@
 	 * by policy).  Trusted path mechanism would be preferred.
 	 */
 #ifdef USE_PAM
-	if (!authenticate_via_pam(pw, ttyn))
+	if (!authenticate_via_pam(&pw, ttyn))
 #else				/* !USE_PAM */
-	if (!authenticate_via_shadow_passwd(pw))
+	if (!authenticate_via_shadow_passwd(&pw))
 #endif				/* if/else USE_PAM */
 	{
 		fprintf(stderr, _("newrole: incorrect password for %s\n"),
-			pw->pw_name);
+			pw.pw_name);
 		return (-1);
 	}
 	/* If we reach here, then we have authenticated the user. */
@@ -904,7 +944,7 @@
 
 	if (optind < 1)
 		optind = 1;
-	if (asprintf(&argv[optind - 1], "-%s", pw->pw_shell) < 0) {
+	if (asprintf(&argv[optind - 1], "-%s", pw.pw_shell) < 0) {
 		fprintf(stderr, _("Error allocating shell.\n"));
 		exit(-1);
 	}
@@ -925,7 +965,7 @@
 	if (send_audit_message(1, old_context, new_context, ttyn))
 		exit(-1);
 	freecon(old_context);
-	execv(pw->pw_shell, argv + optind - 1);
+	execv(pw.pw_shell, argv + optind - 1);
 
 	/* If we reach here, then we failed to exec the new shell. */
 	perror(_("failed to exec shell\n"));

--------------030508030202090602000807--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
