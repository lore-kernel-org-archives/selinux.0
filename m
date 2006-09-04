Subject: [PATCH] newrole: use pam session management services - v4
From: Janak Desai <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: sds@tycho.nsa.gov, sgrubb@redhat.com, dwalsh@redaht.com, tmraz@redhat.com,
        ltcgcw@us.ibm.com, klaus@atsec.com
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 04 Sep 2006 17:01:21 -0400
Message-Id: <1157403682.7223.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This patch updates newrole to allow it to use pam session mangement
services. Currently newrole only uses the authenticaion services of
pam. Session management services are needed to allow pam_namespace
to appropriately reconfigure polyinstantiated namespace for the
new session being established with newrole.

For newrole to work correctly with pam_namespace, in addtion to
this patch, a patch to pam_namespace and a patch to the lssp 
policy will also be required. These additional patches will be
posted the selinux mailing list following this patch.

Changes since v3 of this patch, posted on 8/27/06:
    1. Incorporated feedback to v2
       a. Create/install an lspp version of newrole.pamd when
          building with LSPP_PRIV=y
       b. Removed duplicate definition of _GNU_SOURCE
       c. Keep CAP_SYS_ADMIN, CAP_FOWNER, CAP_CHOWN and
          CAP_DAC_OVERRIDE in permitted set and raise them in the
          effective set prior to calling pam session management
          functions.
    2. Forward ported to the latest selinux subversion tree (version 2014)
       on sourceforge and tested with fedora development package
       policycoreutils-1.30.28-1.src.rpm.

Signed-off-by: Janak Desai <janak@us.ibm.com>

---

 Makefile          |   18 +++-
 newrole-lspp.pamd |    5 +
 newrole.c         |  201 ++++++++++++++++++++++++++++++++++++++----------------
 3 files changed, 161 insertions(+), 63 deletions(-)

diff -Naurp policycoreutils/newrole/Makefile policycoreutils+newrolepatch/newrole/Makefile
--- policycoreutils/newrole/Makefile	2006-09-04 15:35:02.000000000 +0000
+++ policycoreutils+newrolepatch/newrole/Makefile	2006-09-04 16:04:11.000000000 +0000
@@ -6,10 +6,12 @@ ETCDIR ?= $(DESTDIR)/etc
 LOCALEDIR = /usr/share/locale
 PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
-# If LOG_AUDIT_PRIV is y, then newrole will be made into setuid root program.
-# This is so that we have the CAP_AUDIT_WRITE capability. newrole will
-# shed all privileges and change to the user's uid.
-LOG_AUDIT_PRIV ?= n
+# If LSPP_PRIV is y, then newrole will be made into setuid root program.
+# This is so that we have the CAP_AUDIT_WRITE capability for creating
+# and audit record and CAP_SYS_ADMIN, CAP_CHOWN, CAP_FOWNER and
+# CAP_DAC_OVERRIDE capabilities for pam_namespace module.
+# newrole will shed all privileges and change to the user's uid.
+LSPP_PRIV ?= n
 VERSION = $(shell cat ../VERSION)
 
 CFLAGS ?= -Werror -Wall -W
@@ -26,8 +28,8 @@ ifeq (${AUDITH}, /usr/include/libaudit.h
 	override CFLAGS += -DUSE_AUDIT
 	LDLIBS += -laudit
 endif
-ifeq (${LOG_AUDIT_PRIV},y)
-	override CFLAGS += -DLOG_AUDIT_PRIV -D_GNU_SOURCE
+ifeq (${LSPP_PRIV},y)
+	override CFLAGS += -DLSPP_PRIV
 	LDLIBS += -lcap
 	MODE := 4555
 else
@@ -46,8 +48,12 @@ install: all
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
diff -Naurp policycoreutils/newrole/newrole-lspp.pamd policycoreutils+newrolepatch/newrole/newrole-lspp.pamd
--- policycoreutils/newrole/newrole-lspp.pamd	1970-01-01 00:00:00.000000000 +0000
+++ policycoreutils+newrolepatch/newrole/newrole-lspp.pamd	2006-09-04 16:04:11.000000000 +0000
@@ -0,0 +1,5 @@
+#%PAM-1.0
+auth       include	system-auth
+account    include	system-auth
+password   include	system-auth
+session    required	pam_namespace.so unmnt_remnt no_unmount_on_close
diff -Naurp policycoreutils/newrole/newrole.c policycoreutils+newrolepatch/newrole/newrole.c
--- policycoreutils/newrole/newrole.c	2006-09-04 15:35:02.000000000 +0000
+++ policycoreutils+newrolepatch/newrole/newrole.c	2006-09-04 16:14:06.000000000 +0000
@@ -66,9 +66,9 @@
 #ifdef USE_AUDIT
 #include <libaudit.h>
 #endif
-#ifdef LOG_AUDIT_PRIV
+#ifdef LSPP_PRIV
 #ifndef USE_AUDIT
-#error LOG_AUDIT_PRIV needs the USE_AUDIT option
+#error LSPP_PRIV needs the USE_AUDIT option
 #endif
 #include <sys/prctl.h>
 #include <sys/capability.h>
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
@@ -176,31 +171,13 @@ int authenticate_via_pam(const struct pa
  *
  */
 
-int authenticate_via_pam(const struct passwd *pw, const char *ttyn)
+int authenticate_via_pam(const char *ttyn, pam_handle_t *pam_handle)
 {
 
-	int result = 0;		/* our result, set to 0 (not authenticated) by default */
 	int rc;			/* pam return code */
-	pam_handle_t *pam_handle;	/* opaque handle used by all PAM functions */
+	int result = 0;		/* our result, set to 0 (not authenticated) by default */
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
@@ -224,10 +201,7 @@ int authenticate_via_pam(const struct pa
 		result = 1;	/* user authenticated OK! */
 	}
 
-	/* We're done with PAM.  Free `pam_handle'. */
       out:
-	pam_end(pam_handle, rc);
-
 	return (result);
 
 }				/* authenticate_via_pam() */
@@ -334,19 +308,34 @@ static int verify_shell(const char *shel
 
 /*
  * This function will drop the capabilities so that we are left
- * only with access to the audit system. If the user is root, we leave
- * the capabilities alone since they already should have access to the
- * audit netlink socket.
+ * only with access to the audit system and the ability to raise
+ * CAP_SYS_ADMIN, CAP_DAC_OVERRIDE, CAP_FOWNER and CAP_CHOWN,
+ * before invoking pam_namespace.  These capabilities are needed
+ * for performing bind mounts/unmounts and to create potential new
+ * instance directories with appropriate DAC attributes. If the
+ * user is root, we leave the capabilities alone since they already
+ * should have access to the audit netlink socket and should have
+ * the ability to create/mount/unmount instance directories.
  */
-#ifdef LOG_AUDIT_PRIV
+#ifdef LSPP_PRIV
 static void drop_capabilities(void)
 {
 	uid_t uid = getuid();
 
 	if (uid) {		/* Non-root path */
 		cap_t new_caps, tmp_caps;
-		cap_value_t cap_list[] = { CAP_AUDIT_WRITE };
-		cap_value_t tmp_cap_list[] = { CAP_AUDIT_WRITE, CAP_SETUID };
+		cap_value_t cap_list_per[] = { CAP_AUDIT_WRITE,
+					       CAP_SYS_ADMIN,
+					       CAP_FOWNER,
+					       CAP_CHOWN,
+					       CAP_DAC_OVERRIDE };
+		cap_value_t cap_list_eff[] = { CAP_AUDIT_WRITE };
+		cap_value_t tmp_cap_list_per[] = { CAP_AUDIT_WRITE, CAP_SETUID,
+						   CAP_SYS_ADMIN, CAP_FOWNER,
+						   CAP_CHOWN,
+						   CAP_DAC_OVERRIDE };
+		cap_value_t tmp_cap_list_eff[] = { CAP_AUDIT_WRITE,
+						   CAP_SETUID };
 
 		new_caps = cap_init();
 		tmp_caps = cap_init();
@@ -355,10 +344,12 @@ static void drop_capabilities(void)
 				_("Error initing capabilities, aborting.\n"));
 			exit(-1);
 		}
-		cap_set_flag(new_caps, CAP_PERMITTED, 1, cap_list, CAP_SET);
-		cap_set_flag(new_caps, CAP_EFFECTIVE, 1, cap_list, CAP_SET);
-		cap_set_flag(tmp_caps, CAP_PERMITTED, 2, tmp_cap_list, CAP_SET);
-		cap_set_flag(tmp_caps, CAP_EFFECTIVE, 2, tmp_cap_list, CAP_SET);
+		cap_set_flag(new_caps, CAP_PERMITTED, 5, cap_list_per, CAP_SET);
+		cap_set_flag(new_caps, CAP_EFFECTIVE, 1, cap_list_eff, CAP_SET);
+		cap_set_flag(tmp_caps, CAP_PERMITTED, 6, tmp_cap_list_per,
+			     CAP_SET);
+		cap_set_flag(tmp_caps, CAP_EFFECTIVE, 2, tmp_cap_list_eff,
+			     CAP_SET);
 
 		/* Keep capabilities across uid change */
 		prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0);
@@ -387,14 +378,56 @@ static void drop_capabilities(void)
 		/* Finish dropping capabilities. */
 		if (cap_set_proc(new_caps)) {
 			fprintf(stderr,
-				_
-				("Error dropping SETUID capability, aborting\n"));
+				_("Error dropping SETUID capability, aborting\n"));
 			exit(-1);
 		}
 		cap_free(new_caps);
 	}
 }
-#endif
+
+/*
+ * This function will raise/drop capabilities, in/from the effective set,
+ * needed by pam_namespace module. These were dropped from the effective
+ * set but retained in the permitted set using drop_capabilities().
+ * pam_namespace module needs CAP_DAC_OVERRIDE to create new instance
+ * directories in instance parent whose mode by default is 000. CAP_FOWNER
+ * and CAP_CHOWN is needed to set owner, group and mode of the newly
+ * created instance. CAP_SYS_ADMIN is needed to bind mount/unmount
+ * instance directories appropriately. Capabilities are raised if the
+ * argument act is set to CAP_SET, and dropped if the argument act is
+ * set to CAP_CLEAR.
+ */
+static void change_pns_effective_caps(cap_flag_value_t act)
+{
+	uid_t uid = getuid();
+
+	if (uid) {		/* Non-root path */
+		cap_t tmp_caps;
+
+		cap_value_t pns_cap_list[] = { CAP_SYS_ADMIN,
+					       CAP_FOWNER,
+					       CAP_CHOWN,
+					       CAP_DAC_OVERRIDE };
+
+		tmp_caps = cap_get_proc();
+
+		if (!tmp_caps) {
+			fprintf(stderr,
+				_("Error getting capabilities, aborting.\n"));
+			exit(-1);
+		}
+
+		cap_set_flag(tmp_caps, CAP_EFFECTIVE, 4, pns_cap_list, act);
+
+		if (cap_set_proc(tmp_caps)) {
+			fprintf(stderr,
+				_("Error dropping capabilities, aborting\n"));
+			exit(-1);
+		}
+		cap_free(tmp_caps);
+	}
+}
+#endif /* LSPP_PRIV */
 
 /************************************************************************
  *
@@ -434,8 +467,20 @@ int main(int argc, char *argv[])
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
 
-#ifdef LOG_AUDIT_PRIV
+#ifdef LSPP_PRIV
 	drop_capabilities();
 #endif
 
@@ -624,8 +669,18 @@ int main(int argc, char *argv[])
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
@@ -821,6 +876,23 @@ int main(int argc, char *argv[])
 		fsetfilecon(fd, tty_context);
 		freecon(tty_context);
 
+#ifdef USE_PAM
+#ifdef LSPP_PRIV
+		change_pns_effective_caps(CAP_SET);
+		rc = pam_close_session(pam_handle,0);
+		if(rc != PAM_SUCCESS) {
+			fprintf(stderr, "pam_close_session failed with %s\n",
+				pam_strerror(pam_handle, rc));
+			pam_end(pam_handle, rc);
+			exit(-1);
+		}
+		change_pns_effective_caps(CAP_CLEAR);
+#endif
+
+		/* We're done with PAM.  Free `pam_handle'. */
+		pam_end(pam_handle, rc);
+#endif
+
 		/* Done! */
 		exit(0);
 	}
@@ -873,7 +945,21 @@ int main(int argc, char *argv[])
 			new_context);
 		exit(-1);
 	}
-#ifdef LOG_AUDIT_PRIV
+
+#ifdef LSPP_PRIV
+	change_pns_effective_caps(CAP_SET);
+
+#ifdef USE_PAM
+	/* Ask PAM to setup session for user running this program */
+	rc = pam_open_session(pam_handle,0);
+	if(rc != PAM_SUCCESS) {
+		fprintf(stderr, "pam_open_session failed with %s\n",
+			pam_strerror(pam_handle, rc));
+		exit(-1);
+	}
+#endif
+	change_pns_effective_caps(CAP_CLEAR);
+
 	/* Send audit message */
 	{
 		char *msg;
@@ -900,6 +986,7 @@ int main(int argc, char *argv[])
 	}
 #endif
 	freecon(old_context);
+
 	execv(pw->pw_shell, argv + optind - 1);
 
 	/* If we reach here, then we failed to exec the new shell. */



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
