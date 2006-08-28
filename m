Subject: [PATCH] newrole: use pam session management services -v3
From: Janak Desai <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: sds@tycho.nsa.gov, sgrubb@redhat.com
Cc: klaus@atsec.com, chanson@TrustedCS.com, kmacmillan@redhat.com,
        dwalsh@redhat.com, ltcgcw@us.ibm.com, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sun, 27 Aug 2006 22:14:29 -0400
Message-Id: <1156731269.25806.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This patch updates newrole to allow it to use pam session mangement
services. Currently newrole only uses the authenticaion services of
pam. Session management services are needed to allow pam_namespace
to appropriately reconfigure polyinstantiated namespace for the
new session being established with nerole.

Changes since v2 of this patch, posted on 8/16/06:
    1. Restructured to use pam_start and pam_end only once
    2. Updated to use pam_open_session and pam_close_session appropriately
    3. Removed system-auth and pam_xauth session services from newrole.pamd.
       These were not used since newrole did not have session management
       support, and could result in unintended behavior now that session
       management support is enabled with this patch.
    4. Forward ported to the latest selinux subversion tree (version 2000)
       on sourceforge. 

Signed-off-by: Janak Desai <janak@us.ibm.com>

---

 newrole.c    |   95 +++++++++++++++++++++++++++++++++++------------------------
 newrole.pamd |    2 -
 2 files changed, 57 insertions(+), 40 deletions(-)

diff -Naurp policycoreutils/newrole/newrole.c policycoreutils+newrolepatch/newrole/newrole.c
--- policycoreutils/newrole/newrole.c	2006-08-27 21:22:13.000000000 +0000
+++ policycoreutils+newrolepatch/newrole/newrole.c	2006-08-27 21:22:56.000000000 +0000
@@ -84,6 +84,17 @@
 #define PACKAGE "policycoreutils"	/* the name of this package lang translation */
 #endif
 
+#ifdef USE_PAM
+#include <unistd.h>             /* for getuid(), exit(), getopt() */
+
+#include <security/pam_appl.h>  /* for PAM functions */
+#include <security/pam_misc.h>  /* for misc_conv PAM utility function */
+
+#define SERVICE_NAME "newrole"  /* the name of this program for PAM */
+
+int authenticate_via_pam(const char *, pam_handle_t *);
+#endif
+
 /* USAGE_STRING describes the command-line args of this program. */
 #define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l level ] [ -V ] [ -- args ]"
 
@@ -144,22 +155,6 @@ static char *build_new_range(char *newle
 }
 
 #ifdef USE_PAM
-
-/************************************************************************
- *
- * All PAM code goes in this section.
- *
- ************************************************************************/
-
-#include <unistd.h>		/* for getuid(), exit(), getopt() */
-
-#include <security/pam_appl.h>	/* for PAM functions */
-#include <security/pam_misc.h>	/* for misc_conv PAM utility function */
-
-#define SERVICE_NAME "newrole"	/* the name of this program for PAM */
-
-int authenticate_via_pam(const struct passwd *, const char *);
-
 /* authenticate_via_pam()
  *
  * in:     pw - struct containing data from our user's line in 
@@ -176,30 +171,13 @@ int authenticate_via_pam(const struct pa
  *
  */
 
-int authenticate_via_pam(const struct passwd *pw, const char *ttyn)
+int authenticate_via_pam(const char *ttyn, pam_handle_t *pam_handle)
 {
 
 	int result = 0;		/* our result, set to 0 (not authenticated) by default */
 	int rc;			/* pam return code */
-	pam_handle_t *pam_handle;	/* opaque handle used by all PAM functions */
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
 
 	if (strncmp(ttyn, "/dev/", 5) == 0)
 		tty_name = ttyn + 5;
@@ -224,10 +202,7 @@ int authenticate_via_pam(const struct pa
 		result = 1;	/* user authenticated OK! */
 	}
 
-	/* We're done with PAM.  Free `pam_handle'. */
       out:
-	pam_end(pam_handle, rc);
-
 	return (result);
 
 }				/* authenticate_via_pam() */
@@ -434,6 +409,18 @@ int main(int argc, char *argv[])
 	int fd;
 	int enforcing;
 	sigset_t empty;
+#ifdef USE_PAM
+	int rc;			/* pam return code */
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
 
 #ifdef LOG_AUDIT_PRIV
 	drop_capabilities();
@@ -624,8 +611,18 @@ int main(int argc, char *argv[])
 	 * malicious software), not to authorize the operation (which is covered
 	 * by policy).  Trusted path mechanism would be preferred.
 	 */
+
 #ifdef USE_PAM
-	if (!authenticate_via_pam(pw, ttyn))
+	/* Make `p_pam_handle' a valid PAM handle so we can use it when *
+	 * calling PAM functions.                                       */
+	rc = pam_start(SERVICE_NAME,
+		       pw->pw_name, &pam_conversation, &pam_handle);
+	if (rc != PAM_SUCCESS) {
+		fprintf(stderr, _("failed to initialize PAM\n"));
+		exit(-1);
+	}
+
+	if (!authenticate_via_pam(ttyn, pam_handle))
 #else				/* !USE_PAM */
 	if (!authenticate_via_shadow_passwd(pw))
 #endif				/* if/else USE_PAM */
@@ -797,6 +794,18 @@ int main(int argc, char *argv[])
 			rc = wait(NULL);
 		} while (rc < 0 && errno == EINTR);
 
+#ifdef USE_PAM
+		rc = pam_close_session(pam_handle,0);
+		if(rc != PAM_SUCCESS) {
+			fprintf(stderr, "pam_close_session failed\n");
+			pam_end(pam_handle, rc);
+			exit(-1);
+		}
+
+		/* We're done with PAM.  Free `pam_handle'. */
+		pam_end(pam_handle, rc);
+#endif
+
 		if (!new_tty_context || !tty_context)
 			exit(0);
 
@@ -900,6 +909,16 @@ int main(int argc, char *argv[])
 	}
 #endif
 	freecon(old_context);
+
+#ifdef USE_PAM
+	/* Ask PAM to setup session for user running this program */
+	rc = pam_open_session(pam_handle,0);
+	if(rc != PAM_SUCCESS) {
+		fprintf(stderr, _("Namespace setup failed.\n"));
+		exit(-1);
+	}
+#endif
+
 	execv(pw->pw_shell, argv + optind - 1);
 
 	/* If we reach here, then we failed to exec the new shell. */
diff -Naurp policycoreutils/newrole/newrole.pamd policycoreutils+newrolepatch/newrole/newrole.pamd
--- policycoreutils/newrole/newrole.pamd	2006-08-27 21:22:13.000000000 +0000
+++ policycoreutils+newrolepatch/newrole/newrole.pamd	2006-08-27 21:22:56.000000000 +0000
@@ -2,5 +2,3 @@
 auth       include	system-auth
 account    include	system-auth
 password   include	system-auth
-session    include	system-auth
-session    optional	pam_xauth.so



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
