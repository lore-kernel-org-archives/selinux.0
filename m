Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4JKLCgA017585
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 16:21:13 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4JKH2Df025876
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 20:17:02 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies [144.51.25.7])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4JKHfRH016686
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 16:17:41 -0400 (EDT)
Subject: Re: [RFC]{Patch 3/5] Polyinstantation
From: Chad Sellers <cdselle@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1115825429.28084.30.camel@moss-huskies.epoch.ncsc.mil>
References: <1115825429.28084.30.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-yXfv/1a/cNQt+yrzu0Vk"
Date: Thu, 19 May 2005 16:18:28 -0400
Message-Id: <1116533908.22044.20.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-yXfv/1a/cNQt+yrzu0Vk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

New patch for per-user support.

http://www.flux.utah.edu/~sds/coreutils-5.2.1-44.poly.1.src.rpm

On Wed, 2005-05-11 at 11:30 -0400, Chad Sellers wrote:
> Attached is the patch to coreutils (su), as well as the diff of the
> rawhide spec file for the SRPM.  If you want to download a patched SRPM,
> it is available here:
> 
> http://www.flux.utah.edu/~sds/coreutils-5.2.1-44.poly.0.src.rpm
> 
-- 
Chad Sellers
cdselle@tycho.nsa.gov

--=-yXfv/1a/cNQt+yrzu0Vk
Content-Disposition: attachment; filename=coreutils-5.2.1-selinux-poly.patch
Content-Type: text/x-patch; name=coreutils-5.2.1-selinux-poly.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -urN coreutils-5.2.1.orig/src/Makefile.am coreutils-5.2.1/src/Makefile.am
--- coreutils-5.2.1.orig/src/Makefile.am	2005-05-05 09:34:35.000000000 -0400
+++ coreutils-5.2.1/src/Makefile.am	2005-05-05 10:37:04.000000000 -0400
@@ -73,8 +73,8 @@
 
 uptime_LDADD = $(LDADD) $(GETLOADAVG_LIBS)
 
-su_LDADD = $(LDADD) $(LIB_CRYPT) @LIB_PAM@
-runuser_LDADD = $(LDADD) $(LIB_CRYPT) 
+su_LDADD = $(LDADD) $(LIB_CRYPT) @LIB_PAM@ @LIB_SELINUX@
+runuser_LDADD = $(LDADD) $(LIB_CRYPT) @LIB_SELINUX@
 
 $(PROGRAMS): ../lib/libfetish.a
 
diff -urN coreutils-5.2.1.orig/src/su.c coreutils-5.2.1/src/su.c
--- coreutils-5.2.1.orig/src/su.c	2005-05-05 09:34:34.000000000 -0400
+++ coreutils-5.2.1/src/su.c	2005-05-19 10:08:44.000000000 -0400
@@ -168,6 +168,15 @@
 /* The user to become if none is specified.  */
 #define DEFAULT_USER "root"
 
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
 char *crypt ();
 #endif
@@ -500,8 +509,36 @@
   if(pam_copyenv(pamh) != PAM_SUCCESS)
      fprintf (stderr, "error copying PAM environment\n");
   
+#ifdef SELINUX_POLY
+/*
+ * If building with SELinux support, we want to support polyinstantiated
+ * directories.  To do this we clone the child in a new address space
+ * so we can bind mount as necessary.
+*/
+
+  int need_newns = security_setupns(0,pw->pw_uid);
+  if (need_newns < 1) {
+    child = fork();
+  }
+  else {
+    child = clone(CLONE_NEWNS|SIGCHLD, 0);
+  }
+#else
   child = fork();
+#endif
   if (child == 0) {  /* child shell */
+#ifdef SELINUX_POLY
+/*
+ * Make the appropriate bind mounts
+*/
+  if (need_newns > 0) {
+    setfsuid(0);
+    setfsgid(0);
+    security_setupns(1,pw->pw_uid);
+    setfsuid(pw->pw_uid);
+    setfsgid(pw->pw_gid);
+  }
+#endif
   change_identity (pw);
   pam_end(pamh, 0);
 #endif

--=-yXfv/1a/cNQt+yrzu0Vk
Content-Disposition: attachment; filename=coreutils.spec.diff
Content-Type: text/x-patch; name=coreutils.spec.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

--- coreutils.orig/SPECS/coreutils.spec	2005-03-29 08:47:26.000000000 -0500
+++ coreutils/SPECS/coreutils.spec	2005-05-19 15:41:10.000000000 -0400
@@ -4,7 +4,7 @@
 Summary: The GNU core utilities: a set of tools commonly used in shell scripts
 Name:    coreutils
 Version: 5.2.1
-Release: 44
+Release: 44.poly.1
 License: GPL
 Group:   System Environment/Base
 Url:     http://www.gnu.org/software/coreutils/
@@ -58,6 +58,7 @@
 
 #SELINUX Patch
 Patch950: coreutils-selinux.patch
+Patch951: coreutils-5.2.1-selinux-poly.patch
 
 BuildRoot: %_tmppath/%{name}-root
 BuildRequires:	gettext libtermcap-devel bison
@@ -121,6 +122,7 @@
 
 #SELinux
 %patch950 -p1 -b .selinux
+%patch951 -p1
 
 # Don't run basic-1 test, since it breaks when run in the background
 # (bug #102033).
@@ -130,9 +132,9 @@
 
 %build
 %ifarch s390 s390x
-export CFLAGS="$RPM_OPT_FLAGS -fPIC"
+export CFLAGS="$RPM_OPT_FLAGS -fPIC -DSELINUX_POLY=1"
 %else
-export CFLAGS="$RPM_OPT_FLAGS -fpic"
+export CFLAGS="$RPM_OPT_FLAGS -fpic -DSELINUX_POLY=1"
 %endif
 %{expand:%%global optflags %{optflags} -D_GNU_SOURCE=1}
 touch aclocal.m4 configure config.hin Makefile.in */Makefile.in */*/Makefile.in

--=-yXfv/1a/cNQt+yrzu0Vk--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
