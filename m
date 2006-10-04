Message-ID: <452432FA.1060009@us.ibm.com>
Date: Wed, 04 Oct 2006 17:17:30 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, jdesai@us.ibm.com
Subject: [RFC PATCH] newrole suid breakdown
Content-Type: multipart/mixed;
 boundary="------------070407000806010205050700"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070407000806010205050700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hey all,

So, in light of the concerns regarding making newrole suid, I have taken 
some steps to break up the functionality of newrole. I am sending this 
out for some feedback on this approach, I think it is a step in the 
right direction. This note has become rather lengthy, but seeing as 
we're working on avoiding a "root hole", I hope people can take the time 
to look at it :)

This patch applies against the policycoreutils-1.30.30-1 package.

Changes from 1.30.30-1:
Makefile
  * Took Janak's patch, and broke LSPP_PRIV into two
    subparts, AUDIT_LOG_PRIV and NAMESPACE_PRIV. newrole
    can be built with none, either or both sets of functionality.
  * Included the newrole-lspp.pamd install step from Janak's patch

newrole-lspp.pamd
  * Taken straight from Janak's patch

newrole.c
  * NAMESPACE_PRIV requires USE_PAM
  * Updated authenticate_via_pam as per Janak's patch
  * drop_capabilities has three flavors: AUDIT_LOG_PRIV, NAMESPACE_PRIV
    and neither. AUDIT_LOG_PRIV is a subset of the capabilities of
    NAMESPACE_PRIV
  * drop_capabilities has been restructured to return an int
  * New function transition_to_caller_uid()
  * pam usage changes as per Janak's patch
  * change_pns_effective_caps() (from Janak's patches) is removed in
    favor of retaining euid of 0 until shell exec

A few comments:
Most of this work is based off of Janak's patches, so there will be a 
decent amount of familiar code. The most notable difference is the 
existence of two separate drop_capabilities() functions and 
change_pns_effective_caps() has been removed. I added a new 
drop_capabilities so that the capabilities needed to do only auditing 
and handling namespaces are clearly differentiated.

The new drop_capabilities retains in the EFFECTIVE set all of the 
capabilities it will need to affect namespaces. I don't really see the 
value gained from raising and lowering the capabilities mid-execution, 
if someone is able to attack newrole and execute arbitrary code, they 
can simply raise those capabilities from the PERMITTED set. If you would 
like this changed to be more paranoid, let me know.

The removal of change_pns_effective_caps() was done in favor of 
maintaining the euid of 0 for nearly the lifetime of the application, 
only switching to the caller uid before the shell exec. This is 
functionally permissible since we retain CAP_DAC_OVERRIDE (otherwise 
being euid 0 without this cap breaks opening the tty). For the same 
reasons as above, I don't see the reason to be non-euid 0 for the 
lifetime of the app since it is desired to be able to change euid to 0 
for the pam_namespace actions, and it should be changed to the caller's 
uid prior to the exec.


 From what I have seen, the points of possible attack (i.e. input) to 
newrole include:
* command line options
* reading the password from stdin
* reading the contents of /etc/passwd and /etc/shell

I doubt this is an exhaustive list. Since /etc/passwd and /etc/shell are 
restricted to root-only write, I've discounted these. Since we require 
PAM to do namespaces, which will cause PAM to handle the password check, 
we should be able to defer any vulnerabilities to PAM, and I would hope 
that PAM is secure.

This leaves command line options. These are parsed with getopt_long, and 
are currently passed into libselinux without any scrubbing. Since 
SELinux doesn't apply a limit on the length of its context strings, is 
there any checks that need to be done before handing these strings into 
libselinux?


The cleanup process for errors within newrole currently does not make a 
call to pam_end (after pam_start). Is this an issue? There are also 
other cases where cleanup isn't really handled as nicely as it could. 
Since this is a user-space app, a lot of cleanup is handled by the 
kernel, but I do have some patches that go a ways to begin cleaning this 
sort of thing up. Are they desirable?


I have tested all 4 ways of compiling newrole (no priv, AUDIT_LOG_PRIV, 
NAMESPACE_PRIV, LSPP_PRIV (both)), and it functions as expected. As for 
code quality and security, if this is to be suid, I would like to see it 
be as clean and tight as possible :)

Thanks,
Mike


--------------070407000806010205050700
Content-Type: text/x-diff;
 name="newrole_suid_breakdown.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="newrole_suid_breakdown.patch"

diff -Naur policycoreutils-1.30.30/newrole/Makefile policycoreutils-1.30.30.dev/newrole/Makefile
--- policycoreutils-1.30.30/newrole/Makefile	2006-09-29 10:50:27.000000000 -0500
+++ policycoreutils-1.30.30.dev/newrole/Makefile	2006-10-04 16:38:33.000000000 -0500
@@ -6,10 +6,18 @@
 LOCALEDIR = /usr/share/locale
 PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
-# If LOG_AUDIT_PRIV is y, then newrole will be made into setuid root program.
-# This is so that we have the CAP_AUDIT_WRITE capability. newrole will
-# shed all privileges and change to the user's uid.
-LOG_AUDIT_PRIV ?= n
+# Enable capabilities to permit newrole to generate audit records.
+# This will make newrole a setuid root program.
+# The capabilities used are: CAP_AUDIT_WRITE.
+AUDIT_LOG_PRIV ?= n
+# Enable capabilities to permit newrole to utilitize the pam_namespace module.
+# This will make newrole a setuid root program.
+# The capabilities used are: CAP_SYS_ADMIN, CAP_CHOWN, CAP_FOWNER and
+# CAP_DAC_OVERRIDE. 
+NAMESPACE_PRIV ?= n
+# If LSPP_PRIV is y, then newrole will be made into setuid root program.
+# Enabling this option will force AUDIT_LOG_PRIV and NAMESPACE_PRIV to be y.
+LSPP_PRIV ?= n
 VERSION = $(shell cat ../VERSION)
 
 CFLAGS ?= -Werror -Wall -W
@@ -26,10 +34,21 @@
 	override CFLAGS += -DUSE_AUDIT
 	LDLIBS += -laudit
 endif
-ifeq (${LOG_AUDIT_PRIV},y)
-	override CFLAGS += -DLOG_AUDIT_PRIV
-	LDLIBS += -lcap
+ifeq (${LSPP_PRIV},y)
+	override AUDIT_LOG_PRIV=y
+	override NAMESPACE_PRIV=y
+endif
+ifeq (${AUDIT_LOG_PRIV},y)
+	override CFLAGS += -DAUDIT_LOG_PRIV
+	IS_SUID=y
+endif
+ifeq (${NAMESPACE_PRIV},y)
+	override CFLAGS += -DNAMESPACE_PRIV
+	IS_SUID=y
+endif
+ifeq (${IS_SUID},y)
 	MODE := 4555
+	LDLIBS += -lcap
 else
 	MODE := 555
 endif
@@ -46,8 +65,12 @@
 	install -m 644 newrole.1 $(MANDIR)/man1/
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	test -d $(ETCDIR)/pam.d || install -m 755 -d $(ETCDIR)/pam.d
+ifeq (${LSPP_PRIV},y)
+	install -m 644 newrole-lspp.pamd $(ETCDIR)/pam.d/newrole
+else
 	install -m 644 newrole.pamd $(ETCDIR)/pam.d/newrole
 endif
+endif
 
 clean:
 	rm -f $(TARGETS) *.o 
diff -Naur policycoreutils-1.30.30/newrole/newrole.c policycoreutils-1.30.30.dev/newrole/newrole.c
--- policycoreutils-1.30.30/newrole/newrole.c	2006-09-29 10:50:27.000000000 -0500
+++ policycoreutils-1.30.30.dev/newrole/newrole.c	2006-10-04 16:37:04.000000000 -0500
@@ -48,6 +48,14 @@
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
@@ -66,10 +74,7 @@
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
@@ -158,8 +163,6 @@
 
 #define SERVICE_NAME "newrole"	/* the name of this program for PAM */
 
-int authenticate_via_pam(const struct passwd *, const char *);
-
 /* authenticate_via_pam()
  *
  * in:     pw - struct containing data from our user's line in 
@@ -176,31 +179,13 @@
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
-
 	if (strncmp(ttyn, "/dev/", 5) == 0)
 		tty_name = ttyn + 5;
 	else
@@ -224,10 +209,7 @@
 		result = 1;	/* user authenticated OK! */
 	}
 
-	/* We're done with PAM.  Free `pam_handle'. */
       out:
-	pam_end(pam_handle, rc);
-
 	return (result);
 
 }				/* authenticate_via_pam() */
@@ -246,8 +228,6 @@
 
 #define PASSWORD_PROMPT _("Password:")	/* prompt for getpass() */
 
-int authenticate_via_shadow_passwd(const struct passwd *);
-
 /* authenticate_via_shadow_passwd()
  *
  * in:     pw - struct containing data from our user's line in 
@@ -338,65 +318,153 @@
  * the capabilities alone since they already should have access to the
  * audit netlink socket.
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
+	/* Non-root path */
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
+	if ((rc = prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0))) {
+		fprintf(stderr, _("Error setting KEEPCAPS, aborting\n"));
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
+	}
+out:
+	if (cap_free(tmp_caps) || cap_free(new_caps))
+		fprintf(stderr, _("Error freeing caps\n"));
+	return rc;
+}
+#elif defined(NAMESPACE_PRIV)
+/*
+ * This function will drop the capabilities so that we are left
+ * only with access to the audit system and the ability to raise
+ * CAP_SYS_ADMIN, CAP_DAC_OVERRIDE, CAP_FOWNER and CAP_CHOWN,
+ * before invoking pam_namespace.  These capabilities are needed
+ * for performing bind mounts/unmounts and to create potential new
+ * instance directories with appropriate DAC attributes. If the
+ * user is root, we leave the capabilities alone since they already
+ * should have access to the audit netlink socket and should have
+ * the ability to create/mount/unmount instance directories.
+ */
+static int drop_capabilities(void)
+{
+	int rc = 0;
+	cap_t new_caps;
+	cap_value_t cap_list[] = { CAP_AUDIT_WRITE, CAP_SETUID,
+				   CAP_SYS_ADMIN, CAP_FOWNER, CAP_CHOWN,
+				   CAP_DAC_OVERRIDE };
+	uid_t uid = getuid();
+
+	if (!uid)
+		return 0;
+
+	/* Non-root path */
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
+}
+#endif
+
+#ifdef NAMESPACE_PRIV
+/*
+ * This function will set the uid values to be that of caller's uid, and
+ * will drop any privilages which maybe have been raised.
+ */
+static int transition_to_caller_uid()
+{
+	int rc;
+	uid_t uid = getuid();
+
+	/* Change uid */
+	if ((rc = setresuid(uid, uid, uid))) {
+		fprintf(stderr, _("Error changing uid, aborting.\n"));
+		goto out;
 	}
+out:
+	return rc;
 }
 #endif
 
-#ifdef LOG_AUDIT_PRIV
+#ifdef AUDIT_LOG_PRIV
 /* Send audit message */
 static
 int send_audit_message(int success, security_context_t old_context,
@@ -481,11 +549,22 @@
 	int fd;
 	int enforcing;
 	sigset_t empty;
+#ifdef USE_PAM
+	int rc;			/* pam return code */
+	pam_handle_t *pam_handle;  /* opaque handle used by all PAM functions */
 
-#ifdef LOG_AUDIT_PRIV
-	drop_capabilities();
+	/* This is a jump table of functions for PAM to use when it wants to *
+	 * communicate with the user.  We'll be using misc_conv(), which is  *
+	 * provided for us via pam_misc.h.                                   */
+	struct pam_conv pam_conversation = {
+		misc_conv,
+		NULL
+	};
 #endif
 
+	if (drop_capabilities())
+		return -1;
+
 	/* Empty the signal mask in case someone is blocking a signal */
 	sigemptyset(&empty);
 	(void)sigprocmask(SIG_SETMASK, &empty, NULL);
@@ -673,7 +752,16 @@
 	 * by policy).  Trusted path mechanism would be preferred.
 	 */
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
@@ -870,6 +958,21 @@
 		fsetfilecon(fd, tty_context);
 		freecon(tty_context);
 
+#ifdef USE_PAM
+#ifdef NAMESPACE_PRIV
+		rc = pam_close_session(pam_handle,0);
+		if(rc != PAM_SUCCESS) {
+			fprintf(stderr, "pam_close_session failed with %s\n",
+				pam_strerror(pam_handle, rc));
+			pam_end(pam_handle, rc);
+			exit(-1);
+		}
+#endif
+
+		/* We're done with PAM.  Free `pam_handle'. */
+		pam_end(pam_handle, rc);
+#endif
+
 		/* Done! */
 		exit(0);
 	}
@@ -922,9 +1025,23 @@
 			new_context);
 		exit(-1);
 	}
+#ifdef NAMESPACE_PRIV
+	/* Ask PAM to setup session for user running this program */
+	rc = pam_open_session(pam_handle,0);
+	if(rc != PAM_SUCCESS) {
+		fprintf(stderr, "pam_open_session failed with %s\n",
+			pam_strerror(pam_handle, rc));
+		exit(-1);
+	}
+#endif
+
 	if (send_audit_message(1, old_context, new_context, ttyn))
 		exit(-1);
 	freecon(old_context);
+#ifdef NAMESPACE_PRIV
+	if (transition_to_caller_uid())
+		exit(-1);
+#endif
 	execv(pw->pw_shell, argv + optind - 1);
 
 	/* If we reach here, then we failed to exec the new shell. */
diff -Naur policycoreutils-1.30.30/newrole/newrole-lspp.pamd policycoreutils-1.30.30.dev/newrole/newrole-lspp.pamd
--- policycoreutils-1.30.30/newrole/newrole-lspp.pamd	1969-12-31 18:00:00.000000000 -0600
+++ policycoreutils-1.30.30.dev/newrole/newrole-lspp.pamd	2006-10-04 16:11:21.000000000 -0500
@@ -0,0 +1,5 @@
+#%PAM-1.0
+auth       include	system-auth
+account    include	system-auth
+password   include	system-auth
+session    required	pam_namespace.so unmnt_remnt no_unmount_on_close

--------------070407000806010205050700--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
