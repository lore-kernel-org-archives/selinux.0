Subject: [PATCH] newrole: use pam session management services - v2
From: Janak Desai <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: sds@tycho.nsa.gov
Cc: kmacmillan@mentalrootkit.com, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 16 Aug 2006 18:19:38 -0400
Message-Id: <1155766779.25266.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This patch updates newrole to allow it to use pam session mangement
services. Currently newrole only uses the authenticaion services of
pam. Session management services are needed to allow pam_namespace
to appropriately reconfigure polyinstantiated namespace for the
new session being established with nerole.

The only change to this patch since it was posted on this list on
7/27/06 is the forward porting to the latest selinux subversion 
tree (version 1986) on sourceforge. 

Signed-off-by: Janak Desai <janak@us.ibm.com>

---

 newrole.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff -Naurp policycoreutils/newrole/newrole.c policycoreutils+newrolepatch/newrole/newrole.c
--- policycoreutils/newrole/newrole.c	2006-08-16 16:59:23.000000000 +0000
+++ policycoreutils+newrolepatch/newrole/newrole.c	2006-08-16 16:56:57.000000000 +0000
@@ -159,6 +159,7 @@ static char *build_new_range(char *newle
 #define SERVICE_NAME "newrole"	/* the name of this program for PAM */
 
 int authenticate_via_pam(const struct passwd *, const char *);
+int namespace_via_pam(const struct passwd *);
 
 /* authenticate_via_pam()
  *
@@ -232,6 +233,58 @@ int authenticate_via_pam(const struct pa
 
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
@@ -900,6 +953,15 @@ int main(int argc, char *argv[])
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
 	execv(pw->pw_shell, argv + optind - 1);
 
 	/* If we reach here, then we failed to exec the new shell. */



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
