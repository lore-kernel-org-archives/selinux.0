Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA4D6pWt005558
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 08:06:51 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hA4D6nKl015763
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 13:06:50 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hA4D6n5m015757 for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 13:06:49 GMT
Subject: Re: selinux/2.6 on knoppix 3.3
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dhruv Gami <dgami@uncc.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <3FA69267.40408@uncc.edu>
References: <3FA69267.40408@uncc.edu>
Content-Type: multipart/mixed; boundary="=-x71fcHdfTMA64g7dJacf"
Message-Id: <1067951208.21113.175.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 04 Nov 2003 08:06:48 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-x71fcHdfTMA64g7dJacf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-11-03 at 12:37, Dhruv Gami wrote:
> hello everyone,
> 
> im a new user for selinux, and am trying to compile selinux for kernel 
> 2.6 on a knoppix 3.3 hdinstall (its basically a debian install).
> 
> I managed to compile the kernel (2.6), but only after removing certain 
> modules which were preventing compilation of the kernel.
> 
> Now when i tried to compile the selinux-usr packages, libselinux asks 
> for attr/xattr.h in some of the files, and i am unable to find libattr 
> for debian. i tried googling for it, but only found RPM packages for 
> libattr.
> 
> am i doing something wrong here ? am i supposed to install/use something 
> else ?

If you have a modern glibc (>= 2.3) built against recent kernel headers
(>= 2.4.20), then you can just apply the attached patch to libselinux
and build it without libattr.  Otherwise, you need to obtain libattr. 
Note that the sourceforge CVS tree already includes this change (and
several others). 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-x71fcHdfTMA64g7dJacf
Content-Disposition: attachment; filename=libselinux-attr.patch
Content-Type: text/x-patch; name=libselinux-attr.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/src/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/Makefile,v
retrieving revision 1.14
diff -u -r1.14 Makefile
--- libselinux/src/Makefile	8 Oct 2003 19:30:44 -0000	1.14
+++ libselinux/src/Makefile	9 Oct 2003 19:45:08 -0000
@@ -20,7 +20,7 @@
 	ranlib $@
 
 $(LIBSO): $(OBJS)
-	$(CC) $(LDFLAGS) -shared -o $@ $^ -lattr -Wl,-soname,$(LIBSO) 
+	$(CC) $(LDFLAGS) -shared -o $@ $^ -Wl,-soname,$(LIBSO) 
 	ln -sf $@ $(TARGET) 
 
 %.o:  %.c
Index: libselinux/src/fgetfilecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/fgetfilecon.c,v
retrieving revision 1.4
diff -u -r1.4 fgetfilecon.c
--- libselinux/src/fgetfilecon.c	17 Jul 2003 14:03:27 -0000	1.4
+++ libselinux/src/fgetfilecon.c	9 Oct 2003 19:44:51 -0000
@@ -4,7 +4,7 @@
 #include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
-#include <attr/xattr.h>
+#include <sys/xattr.h>
 #include "policy.h"
 
 int fgetfilecon(int fd, security_context_t *context)
Index: libselinux/src/fsetfilecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/fsetfilecon.c,v
retrieving revision 1.1
diff -u -r1.1 fsetfilecon.c
--- libselinux/src/fsetfilecon.c	28 Apr 2003 14:09:37 -0000	1.1
+++ libselinux/src/fsetfilecon.c	9 Oct 2003 19:44:51 -0000
@@ -4,7 +4,7 @@
 #include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
-#include <attr/xattr.h>
+#include <sys/xattr.h>
 #include "policy.h"
 
 int fsetfilecon(int fd, security_context_t context)
Index: libselinux/src/getfilecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/getfilecon.c,v
retrieving revision 1.4
diff -u -r1.4 getfilecon.c
--- libselinux/src/getfilecon.c	17 Jul 2003 14:03:28 -0000	1.4
+++ libselinux/src/getfilecon.c	9 Oct 2003 19:44:51 -0000
@@ -4,7 +4,7 @@
 #include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
-#include <attr/xattr.h>
+#include <sys/xattr.h>
 #include "policy.h"
 
 int getfilecon(const char *path, security_context_t *context)
Index: libselinux/src/lgetfilecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/lgetfilecon.c,v
retrieving revision 1.4
diff -u -r1.4 lgetfilecon.c
--- libselinux/src/lgetfilecon.c	17 Jul 2003 14:03:28 -0000	1.4
+++ libselinux/src/lgetfilecon.c	9 Oct 2003 19:44:51 -0000
@@ -4,7 +4,7 @@
 #include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
-#include <attr/xattr.h>
+#include <sys/xattr.h>
 #include "policy.h"
 
 int lgetfilecon(const char *path, security_context_t *context)
Index: libselinux/src/lsetfilecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/lsetfilecon.c,v
retrieving revision 1.1
diff -u -r1.1 lsetfilecon.c
--- libselinux/src/lsetfilecon.c	28 Apr 2003 14:09:37 -0000	1.1
+++ libselinux/src/lsetfilecon.c	9 Oct 2003 19:44:51 -0000
@@ -4,7 +4,7 @@
 #include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
-#include <attr/xattr.h>
+#include <sys/xattr.h>
 #include "policy.h"
 
 int lsetfilecon(const char *path, security_context_t context)
Index: libselinux/src/setfilecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/setfilecon.c,v
retrieving revision 1.1
diff -u -r1.1 setfilecon.c
--- libselinux/src/setfilecon.c	28 Apr 2003 14:09:37 -0000	1.1
+++ libselinux/src/setfilecon.c	9 Oct 2003 19:44:51 -0000
@@ -4,7 +4,7 @@
 #include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
-#include <attr/xattr.h>
+#include <sys/xattr.h>
 #include "policy.h"
 
 int setfilecon(const char *path, security_context_t context)
Index: libselinux/utils/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/utils/Makefile,v
retrieving revision 1.5
diff -u -r1.5 Makefile
--- libselinux/utils/Makefile	7 Jul 2003 12:53:42 -0000	1.5
+++ libselinux/utils/Makefile	9 Oct 2003 19:45:14 -0000
@@ -4,7 +4,7 @@
 
 CFLAGS = -Wall
 override CFLAGS += -I../include
-LDLIBS += -L../src -lselinux -lattr
+LDLIBS += -L../src -lselinux 
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 

--=-x71fcHdfTMA64g7dJacf--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
