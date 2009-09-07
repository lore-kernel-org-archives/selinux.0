Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n87EWoVB014708
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 10:32:50 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n87EWA1t016900
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 14:32:10 GMT
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Cc: Manoj Srivastava <srivasta@debian.org>
Subject: [PATCH] Add functionality to upstart to load policy early in boot
Date: Mon,  7 Sep 2009 09:16:32 -0500
Message-Id: <1252332992-5271-1-git-send-email-srivasta@golden-gryphon.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Manoj Srivastava <srivasta@debian.org>


         As has been reported, Debian is planning on moving to upstart
 for the next release. Debian does not require a system to have an
 initramfs (custom kernels which do not need initramfs and/or modules
 are supported), so it is desirable to have /sbin/init load policy early
 in the boot process, and sysvinit has already been patched like this.
 I am sending this in for comment and review.

This patch is applied conditionally, and unless WITH_SELINUX is defined
when make is called (that is, at compile time), it does nothing. If
WITH_SELINUX is set to 'yes' at compile time, this patch, analogous to
that in sysvinit, checks early to see if SELinux is enabled on the
machine, and then tries to load policy, If loading policy fails,and if
SELinux is in enforcing mode, it prevents startup.

If the machine does not have selinux enabled at run time, nothing
happens.

Signed-off-by: Manoj Srivastava <srivasta@debian.org>
---
 init/Makefile.am |   12 ++++++++++--
 init/Makefile.in |   12 ++++++++++--
 init/main.c      |   22 ++++++++++++++++++++++
 3 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/init/Makefile.am b/init/Makefile.am
index c1a8a3c..6119998 100644
--- a/init/Makefile.am
+++ b/init/Makefile.am
@@ -5,7 +5,15 @@ initconfdir = $(sysconfdir)/init
 AM_CFLAGS = \
 	$(DBUS_CFLAGS)
 
-AM_CPPFLAGS = \
+ifeq ($(WITH_SELINUX),yes)
+  SELINUX_DEF=-DWITH_SELINUX
+  INIT_SELIBS=-lsepol -lselinux
+else
+  SELINUX_DEF=
+  INIT_SELIBS=
+endif
+
+AM_CPPFLAGS = $(SELINUX_DEF) \
 	-DLOCALEDIR="\"$(localedir)\"" \
 	-DCONFFILE="\"$(sysconfdir)/init.conf\"" \
 	-DCONFDIR="\"$(initconfdir)\"" \
@@ -58,7 +66,7 @@ init_LDADD = \
 	../nih-dbus/libnih-dbus.la \
 	$(LTLIBINTL) \
 	$(DBUS_LIBS) \
-	-lrt
+	$(INIT_SELIBS) -lrt
 
 
 com_ubuntu_Upstart_OUTPUTS = \
diff --git a/init/Makefile.in b/init/Makefile.in
index 4042358..a0b79cf 100644
--- a/init/Makefile.in
+++ b/init/Makefile.in
@@ -426,7 +426,15 @@ initconfdir = $(sysconfdir)/init
 AM_CFLAGS = \
 	$(DBUS_CFLAGS)
 
-AM_CPPFLAGS = \
+ifeq ($(WITH_SELINUX),yes)
+  SELINUX_DEF=-DWITH_SELINUX
+  INIT_SELIBS=-lsepol -lselinux
+else
+  SELINUX_DEF=
+  INIT_SELIBS=
+endif
+
+AM_CPPFLAGS = $(SELINUX_DEF) \
 	-DLOCALEDIR="\"$(localedir)\"" \
 	-DCONFFILE="\"$(sysconfdir)/init.conf\"" \
 	-DCONFDIR="\"$(initconfdir)\"" \
@@ -477,7 +485,7 @@ init_LDADD = \
 	../nih-dbus/libnih-dbus.la \
 	$(LTLIBINTL) \
 	$(DBUS_LIBS) \
-	-lrt
+	$(INIT_SELIBS) -lrt
 
 com_ubuntu_Upstart_OUTPUTS = \
 	com.ubuntu.Upstart.c \
diff --git a/init/main.c b/init/main.c
index 2836583..6e76637 100644
--- a/init/main.c
+++ b/init/main.c
@@ -58,6 +58,9 @@
 #include "conf.h"
 #include "control.h"
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#endif
 
 /* Prototypes for static functions */
 #ifndef DEBUG
@@ -107,6 +110,9 @@ main (int   argc,
 {
 	char **args;
 	int    ret;
+#ifdef WITH_SELINUX
+        int    enforce = 0;
+#endif
 
 	argv0 = argv[0];
 	nih_main_init (argv0);
@@ -137,6 +143,22 @@ main (int   argc,
 		exit (1);
 	}
 
+#ifdef WITH_SELINUX
+        if (getenv("SELINUX_INIT") == NULL && !is_selinux_enabled()) {
+          putenv("SELINUX_INIT=YES");
+          if (selinux_init_load_policy(&enforce) == 0 ) {
+            execv(argv0, argv);
+          } else {
+            if (enforce > 0) {
+              /* SELinux in enforcing mode but load_policy failed */
+              /* At this point, we probably can't open /dev/console, so log() won't work */
+              fprintf(stderr,"Unable to load SELinux Policy. Machine is in enforcing mode. Halting now.\n");
+              exit(1);
+            }
+          }
+        }
+#endif
+
 	/* Clear our arguments from the command-line, so that we show up in
 	 * ps or top output as /sbin/init, with no extra flags.
 	 *
-- 
1.6.3.3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
