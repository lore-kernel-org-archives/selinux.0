Subject: [PATCH] newrole: use pam session management services
From: Janak Desai <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 28 Jul 2006 13:48:56 -0400
Message-Id: <1154108936.7907.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This patch updates newrole to allow the use of pam session management
services. Currently newrole only uses the authentication services of
pam. Session management services are needed to allow pam_namespace
to appropriately reconfigure polyinstantiated namespace for the
new session being established with newrole.  It applies on top of the
07/28/06 version of policycoreutils (policycoreutils-1.30.17-5) in
rawhide. 

Signed-off-by: Janak Desai <janak@us.ibm.com>

---

 newrole.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff -Naurp policycoreutils-1.30.17/newrole/newrole.c policycoreutils-1.30.17+patch/newrole/newrole.c
--- policycoreutils-1.30.17/newrole/newrole.c	2006-07-28 15:43:28.000000000 +0000
+++ policycoreutils-1.30.17+patch/newrole/newrole.c	2006-07-28 15:57:00.000000000 +0000
@@ -158,6 +158,7 @@ static char *build_new_range(char *newle
 #define SERVICE_NAME "newrole"	/* the name of this program for PAM */
 
 int authenticate_via_pam(const struct passwd *, const char *);
+int namespace_via_pam(const struct passwd *);
 
 /* authenticate_via_pam()
  *
@@ -231,6 +232,58 @@ int authenticate_via_pam(const struct pa
 
 }				/* authenticate_via_pam() */
 
+/* namespace_via_pam()
+ *
+ * in:     pw - struct containing data from our user's line in
+ *                         the passwd file.
+ * out:    nothing
+ * return: value   condition
+ *         -----   ---------
+ *           1     PAM thinks that the namespace setup was successful
+ *           0     otherwise
+ *
+ * This function uses PAM to setup namespace if polyinstantiated
+ * directories are configured on the system.
+ *
+ */
+
+int namespace_via_pam(const struct passwd *pw)
+{
+
+	int result = 0;	/* set result to 0 (namespace not set) by default */
+	int rc;		/* pam return code */
+	pam_handle_t *pam_handle; /* opaque handle used by all PAM functions */
+
+	/* This is a jump table of functions for PAM to use when it wants to *
+	 * communicate with the user.  We'll be using misc_conv(), which is  *
+	 * provided for us via pam_misc.h.                                   */
+	struct pam_conv pam_conversation = {
+		misc_conv,
+		NULL
+	};
+
+	/* Make `p_pam_handle' a valid PAM handle so we can use it when *
+	 * calling PAM functions.                                       */
+	rc = pam_start(SERVICE_NAME, pw->pw_name, &pam_conversation,
+		&pam_handle);
+	if(rc != PAM_SUCCESS) {
+		fprintf(stderr, _("failed to initialize PAM\n"));
+		exit(-1);
+	}
+
+	/* Ask PAM to setup session for user running this program */
+	rc = pam_open_session(pam_handle,0);
+		if(rc == PAM_SUCCESS) {
+		result = 1;  /* Namespace setup OK! */
+	}
+
+	/* We're done with PAM.  Free `pam_handle'. */
+	pam_end(pam_handle, rc);
+
+	return(result);
+
+} 				/* namespace_via_pam() */
+
 #else				/* else !USE_PAM */
 
 /************************************************************************
@@ -897,6 +950,15 @@ int main(int argc, char *argv[])
 	}
 #endif
 	freecon(old_context);
+
+#ifdef USE_PAM
+	if(!namespace_via_pam(pw)) {
+		fprintf(stderr,_("Namespace setup failed for %s\n"),
+			pw->pw_name);
+		exit(-1);
+	}
+#endif /* USE_PAM */
+
 	execv(argv[optind - 1], argv + optind - 1);
 
 	/* If we reach here, then we failed to exec the new shell. */



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
