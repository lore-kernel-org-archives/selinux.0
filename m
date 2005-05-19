Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4JKKcgA017541
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 16:20:38 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4JKGRDf025854
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 20:16:28 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies [144.51.25.7])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4JKH6RH016650
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 16:17:06 -0400 (EDT)
Subject: Re: [RFC]{Patch 2/5] Polyinstantation
From: Chad Sellers <cdselle@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1115825413.28084.29.camel@moss-huskies.epoch.ncsc.mil>
References: <1115825413.28084.29.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-6lFcA0EsaObEEphcMze8"
Date: Thu, 19 May 2005 16:17:54 -0400
Message-Id: <1116533874.22044.18.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-6lFcA0EsaObEEphcMze8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

New patch for per-user support.

http://www.flux.utah.edu/~sds/util-linux-2.12p-9.3.poly.1.src.rpm

On Wed, 2005-05-11 at 11:30 -0400, Chad Sellers wrote:
> Attached is the patch to util-linux (login), as well as the diff of the
> rawhide spec file for the SRPM.  If you want to download a patched SRPM,
> it is available here:
> 
> http://www.flux.utah.edu/~sds/util-linux-2.12p-9.3.poly.0.src.rpm
> 
> 
-- 
Chad Sellers
cdselle@tycho.nsa.gov

--=-6lFcA0EsaObEEphcMze8
Content-Disposition: attachment; filename=util-linux-2.12p-selinux-poly.patch
Content-Type: text/x-patch; name=util-linux-2.12p-selinux-poly.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -urN util-linux-2.12p.orig/login-utils/login.c util-linux-2.12p/login-utils/login.c
--- util-linux-2.12p.orig/login-utils/login.c	2005-05-04 13:12:41.000000000 -0400
+++ util-linux-2.12p/login-utils/login.c	2005-05-19 09:59:40.000000000 -0400
@@ -173,6 +173,15 @@
 };
 #endif
 
+#ifdef SELINUX_POLY
+#include <sys/syscall.h>
+#include <sys/mount.h>
+#include <linux/unistd.h>
+#include <selinux/selinux.h>
+#define CLONE_NEWNS 0x00020000 /* Flag to create new namespace */
+static inline _syscall2 (int, clone, int, flags, int, arg)
+#endif
+
 #ifndef USE_PAM
 static void getloginname (void);
 static void checknologin (void);
@@ -1144,7 +1153,23 @@
     sigaction(SIGTERM, &sa, &oldsa_term);
     
     closelog();
+#ifdef SELINUX_POLY
+    /*
+     * If building with SELinux support, we want to support polyinstantiated
+     * directories.  To do this we clone the child in a new address space
+     * so we can bind mount as necessary.
+     */
+
+    int need_newns = security_setupns(0,pwd->pw_uid);
+    if (need_newns < 1) {
+      childPid = fork();
+      }
+    else {
+      childPid = clone(CLONE_NEWNS|SIGCHLD, 0);
+      }
+#else
     childPid = fork();
+#endif /* SELINUX_POLY */
     if (childPid < 0) {
        int errsv = errno;
        /* error in fork() */
@@ -1158,7 +1183,7 @@
        sa.sa_handler = SIG_IGN;
        sigaction(SIGQUIT, &sa, NULL);
        sigaction(SIGINT, &sa, NULL);
-       while(wait(NULL) == -1 && errno == EINTR) /**/ ;
+       while (wait(NULL) == -1 && errno == EINTR) /**/ ;
        openlog("login", LOG_ODELAY, LOG_AUTHPRIV);
        PAM_END;
        exit(0);
@@ -1190,6 +1215,13 @@
     }
 #endif
     signal(SIGINT, SIG_DFL);
+
+#ifdef SELINUX_POLY
+    /* Make the appropriate bind mounts.  */
+	if (need_newns > 0) {
+		security_setupns(1,pwd->pw_uid);
+	}
+#endif
     
     /* discard permissions last so can't get killed and drop core */
     if(setuid(pwd->pw_uid) < 0 && pwd->pw_uid) {
diff -urN util-linux-2.12p.orig/login-utils/Makefile util-linux-2.12p/login-utils/Makefile
--- util-linux-2.12p.orig/login-utils/Makefile	2005-05-04 13:12:41.000000000 -0400
+++ util-linux-2.12p/login-utils/Makefile	2005-05-05 09:16:25.000000000 -0400
@@ -56,6 +56,10 @@
 SELINUXOBJS=selinux_utils.o
 endif
 
+# SELinux polyinstantiated mounts.
+# XXX Explicitely enable this stuff for now.
+CFLAGS += -DSELINUX_POLY=1 -g
+
 ifeq "$(HAVE_SHADOW)" "no"
 WHAT_TO_BUILD:=$(WHAT_TO_BUILD) all-putils
 WHAT_TO_INSTALL:=$(WHAT_TO_INSTALL) install-putils

--=-6lFcA0EsaObEEphcMze8
Content-Disposition: attachment; filename=util-linux.spec.diff
Content-Type: text/x-patch; name=util-linux.spec.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

--- util-linux.spec.2.12p.orig	2005-05-04 13:44:02.000000000 -0400
+++ util-linux.spec	2005-05-19 15:40:17.000000000 -0400
@@ -27,7 +27,7 @@
 Summary: A collection of basic system utilities.
 Name: util-linux
 Version: 2.12p
-Release: 9.3
+Release: 9.3.poly.1
 License: distributable
 Group: System Environment/Base
 
@@ -133,6 +133,9 @@
 # patch fixes.
 ########### END upstreamable
 
+# Patch to enable SELinux polyinstantiation
+Patch500: util-linux-2.12p-selinux-poly.patch
+
 Obsoletes: fdisk tunelp
 %ifarch alpha sparc sparc64 sparcv9 s390
 Obsoletes: clock
@@ -255,6 +258,8 @@
 %patch187 -p1
 %patch188 -p1
 
+%patch500 -p1
+
 %build
 unset LINGUAS || :
 

--=-6lFcA0EsaObEEphcMze8--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
