Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FLsCWt029129
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 17:54:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9FLsBmR029069
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 21:54:11 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9FLsBjp029066 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 21:54:11 GMT
Subject: Re: More 2.4 Build problems on RH 9.0
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Richard Herbert Wanner <richard.wanner@cgi.com>
Cc: SELinux NSA <selinux@tycho.nsa.gov>
In-Reply-To: <GMECJOINLDFDGEEPGINLAEGOCKAA.richard.wanner@cgi.com>
References: <GMECJOINLDFDGEEPGINLAEGOCKAA.richard.wanner@cgi.com>
Content-Type: multipart/mixed; boundary="=-n/BeAxrv7SdEjpKgBZJK"
Message-Id: <1066254850.7399.230.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Oct 2003 17:54:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-n/BeAxrv7SdEjpKgBZJK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-10-15 at 17:42, Richard Herbert Wanner wrote:
> cc -o fgetfilecon.o -c Wall -fPIC -I..include fgetfilecon.c
> fgetfilecon.c:7:24: attr/xattr.h: No such file or directory
> fgetfilecon.c: In function 'fgetfilecon':
> fgetfilecon.c:22:warning implicit declaration of function 'fgetxattr'
> make[1]: *** [fgetfilecon.o] Error 1
> make[1]: Leaving directory '/tmp/selinux-usr/libselinux/src
> make: *** [install] Error 2

You can either install libattr-devel or you can apply the attached patch
if your glibc directly supports the xattr calls (likely, unless using an
older glibc or an older set of kernel headers).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-n/BeAxrv7SdEjpKgBZJK
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
 

--=-n/BeAxrv7SdEjpKgBZJK--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
