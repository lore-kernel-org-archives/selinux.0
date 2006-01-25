Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0PHl5Xf012459
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 12:47:06 -0500 (EST)
Received: from web51506.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k0PHl0vt006238
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 17:47:01 GMT
Message-ID: <20060125174634.31763.qmail@web51506.mail.yahoo.com>
Date: Wed, 25 Jan 2006 09:46:34 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Adding audit messge to newrole 
To: SE-Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1057744615-1138211194=:31721"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1057744615-1138211194=:31721
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

I am attaching a patch that lets newrole send messages to the audit system. This
patch needs review as it changes newrole to be setuid root. The patch drops
capabilities immediately after startup. This patch depends on USE_AUDIT already
being defined by the Makefile.

You will need recent audit package in order to compile newrole since it uses the
USER_ROLE_CHANGE message type. It is available in version 1.1.2 and later. 

Thanks,
-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1057744615-1138211194=:31721
Content-Type: text/x-patch; name="policycoreutils-1.29.9-newrole-audit.patch"
Content-Description: 374981619-policycoreutils-1.29.9-newrole-audit.patch
Content-Disposition: inline; filename="policycoreutils-1.29.9-newrole-audit.patch"

diff -ur policycoreutils-1.29.9.orig/newrole/Makefile policycoreutils-1.29.9/newrole/Makefile
--- policycoreutils-1.29.9.orig/newrole/Makefile	2006-01-25 11:24:30.000000000 -0500
+++ policycoreutils-1.29.9/newrole/Makefile	2006-01-25 11:24:50.000000000 -0500
@@ -8,7 +8,7 @@
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lselinux -lsepol -L$(PREFIX)/lib
+LDLIBS += -lselinux -lsepol -L$(PREFIX)/lib -lcap -laudit
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
 	LDLIBS += -lpam -lpam_misc
@@ -26,7 +26,7 @@
 	test -d $(BINDIR)      || install -m 755 -d $(BINDIR)
 	test -d $(ETCDIR)/pam.d || install -m 755 -d $(ETCDIR)/pam.d
 	test -d $(MANDIR)/man1 || install -m 755 -d $(MANDIR)/man1
-	install -m 555 newrole $(BINDIR)
+	install -m 4555 newrole $(BINDIR)
 	install -m 644 newrole.1 $(MANDIR)/man1/
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	test -d $(ETCDIR)/pam.d || install -m 755 -d $(ETCDIR)/pam.d
diff -ur policycoreutils-1.29.9.orig/newrole/newrole.c policycoreutils-1.29.9/newrole/newrole.c
--- policycoreutils-1.29.9.orig/newrole/newrole.c	2006-01-25 11:24:30.000000000 -0500
+++ policycoreutils-1.29.9/newrole/newrole.c	2006-01-25 12:20:18.000000000 -0500
@@ -56,6 +58,10 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+#ifdef USE_AUDIT
+#include <sys/prctl.h>
+#include <sys/capability.h>
+#endif
 #include <selinux/selinux.h>      /* for is_selinux_enabled() */
 #include <selinux/flask.h>        /* for SECCLASS_CHR_FILE */
 #include <selinux/context.h>      /* for context-mangling functions */
@@ -322,6 +328,65 @@
   return found;
 }
 
+/*
+ * This function will drop the capabilities so that we are left
+ * only with access to the audit system. If the user is root, we leave
+ * the capabilities alone since they already should have access to the
+ * audit netlink socket.
+ */
+#ifdef USE_AUDIT
+static void drop_capabilities(void)
+{
+  uid_t uid = getuid();
+
+  if (uid) { /* Non-root path */
+    cap_t new_caps, tmp_caps;
+    cap_value_t cap_list[] = { CAP_AUDIT_WRITE };
+    cap_value_t tmp_cap_list[] = { CAP_AUDIT_WRITE, CAP_SETUID };
+
+    new_caps = cap_init();
+    tmp_caps = cap_init();
+    if (!new_caps || !tmp_caps) {
+      fprintf(stderr, _("Error initing capabilities, aborting.\n"));
+      exit(-1);
+    }
+    cap_set_flag(new_caps, CAP_PERMITTED, 1, cap_list, CAP_SET);
+    cap_set_flag(new_caps, CAP_EFFECTIVE, 1, cap_list, CAP_SET);
+    cap_set_flag(tmp_caps, CAP_PERMITTED, 1, tmp_cap_list, CAP_SET);
+    cap_set_flag(tmp_caps, CAP_EFFECTIVE, 1, tmp_cap_list, CAP_SET);
+
+    /* Keep capabilities across uid change */
+    prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0);
+
+    /* We should still have root's caps, so drop most capabilities now */
+    if (cap_set_proc(tmp_caps)) {
+      fprintf(stderr, _("Error dropping capabilities, aborting\n"));
+      exit(-1);
+    }
+    cap_free(tmp_caps);
+
+    /* Change uid */
+    if (setuid(uid)) {
+      fprintf(stderr, _("Error changing uid, aborting.\n"));
+      exit(-1);
+    }
+
+    /* Now get rid of this ability */
+    if (prctl(PR_SET_KEEPCAPS, 0, 0, 0, 0) < 0) {
+      fprintf(stderr, _("Error resetting KEEPCAPS, aborting\n"));
+      exit(-1);
+    }
+
+    /* Finish dropping capabilities. */
+    if (cap_set_proc(new_caps)) {
+      fprintf(stderr, _("Error dropping SETUID capability, aborting\n"));
+      exit(-1);
+    }
+    cap_free(new_caps);
+  }
+}
+#endif
+
 /************************************************************************
  *
  * All code used for both PAM and shadow passwd goes in this section.
@@ -360,6 +425,10 @@
   int enforcing;
   sigset_t empty;
 
+#ifdef USE_AUDIT
+  drop_capabilities();
+#endif
+
   /* Empty the signal mask in case someone is blocking a signal */
   sigemptyset( &empty );
   (void) sigprocmask( SIG_SETMASK, &empty, NULL );
@@ -486,7 +555,6 @@
     exit(-1);
   }
 
-  freecon(old_context);
   /* Make `pw' point to a structure containing the data              *
    * from our user's line in the passwd file.  If the current user's
    * SELinux user identity is the default (SELINUX_DEFAULTUSER), then
@@ -743,6 +811,31 @@
        fprintf(stderr, _("Could not set exec context to %s.\n"), new_context);
        exit(-1);
   }
+#ifdef USE_AUDIT
+  /* Send audit message */
+  {
+    char *msg;
+    int audit_fd = audit_open();
+    if (audit_fd < 0) {
+       fprintf(stderr, _("Error connecting to audit system.\n"));
+       exit(-1);
+    }
+    if (asprintf(&msg, "newrole: old-context=%s new-context=%s",
+             old_context, new_context) < 0) {
+       fprintf(stderr, _("Error allocating memory.\n"));
+       exit(-1);
+    }
+    if (audit_log_user_message(audit_fd, AUDIT_USER_ROLE_CHANGE,
+                               msg, NULL, NULL, ttyn, 1) <= 0) {
+       fprintf(stderr, _("Error sending audit message.\n"));
+       free(msg);
+       exit(-1);
+    }
+    free(msg);
+    close(audit_fd);
+  }
+#endif
+  freecon(old_context);
   execv(argv[optind-1],argv+optind-1);
 
   /* If we reach here, then we failed to exec the new shell. */

--0-1057744615-1138211194=:31721--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
