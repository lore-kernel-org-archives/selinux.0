Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0REAwXf006188
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 09:10:58 -0500 (EST)
Received: from web51503.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k0REAuC1015495
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 14:10:56 GMT
Message-ID: <20060127140942.4140.qmail@web51503.mail.yahoo.com>
Date: Fri, 27 Jan 2006 06:09:42 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Adding audit message to newrole
To: SE-Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-305620949-1138370982=:87388"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-305620949-1138370982=:87388
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

I am attaching a patch that lets newrole send messages to the audit system. This
patch needs review as it changes newrole to be setuid root. The patch drops
capabilities immediately after startup.

To enable the patch, you would change the make commands to the following:

make LOG_AUDIT_PRIV="y"
make LOG_AUDIT_PRIV="y" install

You will need recent audit package in order to compile newrole since it uses the
USER_ROLE_CHANGE message type. It is available in version 1.1.2 and later. There
is also a dependency on a kernel patch that is not upstream yet that can be found
here:

https://www.redhat.com/archives/linux-audit/2005-October/msg00059.html

This patch is in the lspp test kernels.

Thanks,
-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-305620949-1138370982=:87388
Content-Type: text/x-patch; name="policycoreutils-1.29.11-newrole-audit.patch"
Content-Description: 3826731321-policycoreutils-1.29.11-newrole-audit.patch
Content-Disposition: inline; filename="policycoreutils-1.29.11-newrole-audit.patch"

diff -ur policycoreutils-1.29.11.orig/newrole/Makefile policycoreutils-1.29.11/newrole/Makefile
--- policycoreutils-1.29.11.orig/newrole/Makefile	2006-01-26 09:36:02.000000000 -0500
+++ policycoreutils-1.29.11/newrole/Makefile	2006-01-27 08:59:49.000000000 -0500
@@ -6,6 +6,10 @@
 LOCALEDIR = /usr/share/locale
 PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
+# If LOG_AUDIT_PRIV is y, then newrole will be made into setuid root program.
+# This is so that we have the CAP_AUDIT_WRITE capability. newrole will
+# shed all privileges and change to the user's uid.
+LOG_AUDIT_PRIV ?= n
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
@@ -21,6 +25,13 @@
 	override CFLAGS += -DUSE_AUDIT
 	LDLIBS += -laudit
 endif
+ifeq (${LOG_AUDIT_PRIV},y)
+	override CFLAGS += -DLOG_AUDIT_PRIV -D_GNU_SOURCE
+	LDLIBS += -lcap
+	MODE := 4555
+else
+	MODE := 555
+endif
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
@@ -30,7 +41,7 @@
 	test -d $(BINDIR)      || install -m 755 -d $(BINDIR)
 	test -d $(ETCDIR)/pam.d || install -m 755 -d $(ETCDIR)/pam.d
 	test -d $(MANDIR)/man1 || install -m 755 -d $(MANDIR)/man1
-	install -m 555 newrole $(BINDIR)
+	install -m $(MODE) newrole $(BINDIR)
 	install -m 644 newrole.1 $(MANDIR)/man1/
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	test -d $(ETCDIR)/pam.d || install -m 755 -d $(ETCDIR)/pam.d
diff -ur policycoreutils-1.29.11.orig/newrole/newrole.c policycoreutils-1.29.11/newrole/newrole.c
--- policycoreutils-1.29.11.orig/newrole/newrole.c	2006-01-26 09:36:02.000000000 -0500
+++ policycoreutils-1.29.11/newrole/newrole.c	2006-01-27 09:00:30.000000000 -0500
@@ -65,6 +65,13 @@
 #ifdef USE_AUDIT
 #include <libaudit.h>
 #endif
+#ifdef LOG_AUDIT_PRIV
+#ifndef USE_AUDIT
+#error LOG_AUDIT_PRIV needs the USE_AUDIT option
+#endif
+#include <sys/prctl.h>
+#include <sys/capability.h>
+#endif
 #ifdef USE_NLS
 #include <locale.h>			    /* for setlocale() */
 #include <libintl.h>			    /* for gettext() */
@@ -325,6 +332,65 @@
   return found;
 }
 
+/*
+ * This function will drop the capabilities so that we are left
+ * only with access to the audit system. If the user is root, we leave
+ * the capabilities alone since they already should have access to the
+ * audit netlink socket.
+ */
+#ifdef LOG_AUDIT_PRIV
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
+    cap_set_flag(tmp_caps, CAP_PERMITTED, 2, tmp_cap_list, CAP_SET);
+    cap_set_flag(tmp_caps, CAP_EFFECTIVE, 2, tmp_cap_list, CAP_SET);
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
+    if (setresuid(uid, uid, uid)) {
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
@@ -363,6 +429,10 @@
   int enforcing;
   sigset_t empty;
 
+#ifdef LOG_AUDIT_PRIV
+  drop_capabilities();
+#endif
+
   /* Empty the signal mask in case someone is blocking a signal */
   sigemptyset( &empty );
   (void) sigprocmask( SIG_SETMASK, &empty, NULL );
@@ -489,8 +559,6 @@
     exit(-1);
   }
 
-  freecon(old_context);
-
   /*
    * Determine the Linux user identity to re-authenticate.
    * If supported and set, use the login uid, as this should be more stable.
@@ -759,6 +827,32 @@
        fprintf(stderr, _("Could not set exec context to %s.\n"), new_context);
        exit(-1);
   }
+#ifdef LOG_AUDIT_PRIV
+  /* Send audit message */
+  {
+    char *msg;
+    int rc;
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
+    rc = audit_log_user_message(audit_fd, AUDIT_USER_ROLE_CHANGE,
+                               msg, NULL, NULL, ttyn, 1);
+    if (rc <= 0) {
+       fprintf(stderr, _("Error sending audit message.\n"));
+       exit(-1);
+    }
+    free(msg);
+    close(audit_fd);
+  }
+#endif
+  freecon(old_context);
   execv(argv[optind-1],argv+optind-1);
 
   /* If we reach here, then we failed to exec the new shell. */

--0-305620949-1138370982=:87388--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
