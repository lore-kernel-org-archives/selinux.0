Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6VI9jHa004526
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 14:09:45 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6VI9iDW017064
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 18:09:44 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h6VI9ieN017061 for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 18:09:44 GMT
Subject: Re: Problems compiling libsecure
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: drm2@dss.state.va.us
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200307311353.59002.drm2@dss.state.va.us>
References: <200307311353.59002.drm2@dss.state.va.us>
Content-Type: multipart/mixed; boundary="=-DGWlAmOeeK48EvCp75a1"
Message-Id: <1059674982.1052.252.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 31 Jul 2003 14:09:42 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-DGWlAmOeeK48EvCp75a1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-07-31 at 13:53, Don Mills wrote:
> To any helpful soul:
> 	I am trying to compile and install the latest SE linux (2003071106) from the 
> lsm-2.4-selinux-2003071106.tgz package.  I am following the step by step 
> instructions rather than the quick install, and everything is proceeding fine 
> until I attempt to compile libsecure whereupon I get(pardon my linewrap): 
> 
> cc -o fstat_secure.o -c -I../include -I/usr/local/selinux/include\ 
> fstat_secure.c
> In file included from fstat_secure.c:5:
> xstat_conv.h: In function `xstat_conv':
> xstat_conv.h:59: structure has no member named `st_atim'
> xstat_conv.h:60: structure has no member named `st_atim'
> xstat_conv.h:61: structure has no member named `st_mtim'
> xstat_conv.h:62: structure has no member named `st_mtim'
> xstat_conv.h:63: structure has no member named `st_ctim'
> xstat_conv.h:64: structure has no member named `st_ctim'
> make[1]: *** [fstat_secure.o] Error 1
> 
> Now I don't profess to be a C programmer (or even close!) but I think that bit 
> of code is calling for the kernel's stat structure?  I tried copying the 
> lsm-2.4 /include/asm/stat* to the libsecure/include but no help there...I 
> also tried commenting out various includes from kernel_stat.h but no help 
> there either.
> Other possibly helpful info: compiling on 2.4.7 kernel w/ gcc 2.96 20000731 
> (old RedHat 7.1 laptop).  Any thoughts?

The stat structure definition changed in more recent glibc's.  To make
it work with your older glibc, save the attached patch to
~/oldstat.patch, cd selinux/libsecure, and run 'patch -p1 <
~/oldstat.patch'.  Then try building it again.

This issue (and libsecure) will be obsoleted by the back port of the
2.5/6 SELinux API changes and xattr support to the 2.4-based SELinux,
coming soon.  At that point, the same userland and policy should be
useable for both versions of SELinux.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-DGWlAmOeeK48EvCp75a1
Content-Disposition: attachment; filename=oldstat.patch
Content-Type: text/x-patch; name=oldstat.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libsecure/src/kernel_stat.h
===================================================================
RCS file: /home/pal/CVS/selinux/libsecure/src/kernel_stat.h,v
retrieving revision 1.3
diff -u -r1.3 kernel_stat.h
--- libsecure/src/kernel_stat.h	18 Jun 2003 13:56:00 -0000	1.3
+++ libsecure/src/kernel_stat.h	31 Jul 2003 18:05:33 -0000
@@ -15,21 +15,18 @@
     unsigned long int st_size;
     unsigned long int st_blksize;
     unsigned long int st_blocks;
-    struct timespec st_atim;
-    struct timespec st_mtim;
-    struct timespec st_ctim;
+    unsigned long int st_atime;
+    unsigned long int __unused1;
+#define _HAVE___UNUSED1
+    unsigned long int st_mtime;
+    unsigned long int __unused2;
+#define _HAVE___UNUSED2
+    unsigned long int st_ctime;
+    unsigned long int __unused3;
+#define _HAVE___UNUSED3
     unsigned long int __unused4;
 #define _HAVE___UNUSED4
     unsigned long int __unused5;
 #define _HAVE___UNUSED5
   };
 
-#define _HAVE_STAT___UNUSED4
-#define _HAVE_STAT___UNUSED5
-#define _HAVE_STAT___PAD1
-#define _HAVE_STAT___PAD2
-#define _HAVE_STAT_NSEC
-#define _HAVE_STAT64___PAD1
-#define _HAVE_STAT64___PAD2
-#define _HAVE_STAT64___ST_INO
-#define _HAVE_STAT64_NSEC
Index: libsecure/src/xstat_conv.h
===================================================================
RCS file: /home/pal/CVS/selinux/libsecure/src/xstat_conv.h,v
retrieving revision 1.2
diff -u -r1.2 xstat_conv.h
--- libsecure/src/xstat_conv.h	18 Jun 2003 13:56:00 -0000	1.2
+++ libsecure/src/xstat_conv.h	31 Jul 2003 18:05:33 -0000
@@ -1,26 +1,21 @@
 /* Convert between the kernel's `struct stat' format, and libc's.
-   Copyright (C) 1991,1995,1996,1997,2000,2002 Free Software Foundation, Inc.
+   Copyright (C) 1991, 1995, 1996, 1997 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
 
    The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Lesser General Public
-   License as published by the Free Software Foundation; either
-   version 2.1 of the License, or (at your option) any later version.
+   modify it under the terms of the GNU Library General Public License as
+   published by the Free Software Foundation; either version 2 of the
+   License, or (at your option) any later version.
 
    The GNU C Library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Lesser General Public License for more details.
+   Library General Public License for more details.
 
-   You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
-   02111-1307 USA.  */
-
-#include <errno.h>
-#define __set_errno(x) (errno) = (x)
-
-#include <string.h>
+   You should have received a copy of the GNU Library General Public
+   License along with the GNU C Library; see the file COPYING.LIB.  If not,
+   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+   Boston, MA 02111-1307, USA.  */
 
 static inline int
 xstat_conv (int vers, struct kernel_stat *kbuf, void *ubuf)
@@ -40,7 +35,7 @@
 
 	/* Convert to current kernel version of `struct stat'.  */
 	buf->st_dev = kbuf->st_dev;
-#ifdef _HAVE_STAT___PAD1
+#ifdef _HAVE___PAD1
 	buf->__pad1 = 0;
 #endif
 	buf->st_ino = kbuf->st_ino;
@@ -49,44 +44,35 @@
 	buf->st_uid = kbuf->st_uid;
 	buf->st_gid = kbuf->st_gid;
 	buf->st_rdev = kbuf->st_rdev;
-#ifdef _HAVE_STAT___PAD2
+#ifdef _HAVE___PAD2
 	buf->__pad2 = 0;
 #endif
 	buf->st_size = kbuf->st_size;
 	buf->st_blksize = kbuf->st_blksize;
 	buf->st_blocks = kbuf->st_blocks;
-#ifdef _HAVE_STAT_NSEC
-	buf->st_atim.tv_sec = kbuf->st_atim.tv_sec;
-	buf->st_atim.tv_nsec = kbuf->st_atim.tv_nsec;
-	buf->st_mtim.tv_sec = kbuf->st_mtim.tv_sec;
-	buf->st_mtim.tv_nsec = kbuf->st_mtim.tv_nsec;
-	buf->st_ctim.tv_sec = kbuf->st_ctim.tv_sec;
-	buf->st_ctim.tv_nsec = kbuf->st_ctim.tv_nsec;
-#else
 	buf->st_atime = kbuf->st_atime;
-	buf->st_mtime = kbuf->st_mtime;
-	buf->st_ctime = kbuf->st_ctime;
-#endif
-#ifdef _HAVE_STAT___UNUSED1
+#ifdef _HAVE___UNUSED1
 	buf->__unused1 = 0;
 #endif
-#ifdef _HAVE_STAT___UNUSED2
+	buf->st_mtime = kbuf->st_mtime;
+#ifdef _HAVE___UNUSED2
 	buf->__unused2 = 0;
 #endif
-#ifdef _HAVE_STAT___UNUSED3
+	buf->st_ctime = kbuf->st_ctime;
+#ifdef _HAVE___UNUSED3
 	buf->__unused3 = 0;
 #endif
-#ifdef _HAVE_STAT___UNUSED4
+#ifdef _HAVE___UNUSED4
 	buf->__unused4 = 0;
 #endif
-#ifdef _HAVE_STAT___UNUSED5
+#ifdef _HAVE___UNUSED5
 	buf->__unused5 = 0;
 #endif
       }
       break;
 
     default:
-      __set_errno (EINVAL);
+      errno = EINVAL;
       return -1;
     }
 
Index: libsecure/src/arch/i386/fstat64_secure.c
===================================================================
RCS file: /home/pal/CVS/selinux/libsecure/src/arch/i386/fstat64_secure.c,v
retrieving revision 1.3
diff -u -r1.3 fstat64_secure.c
--- libsecure/src/arch/i386/fstat64_secure.c	18 Jun 2003 13:56:02 -0000	1.3
+++ libsecure/src/arch/i386/fstat64_secure.c	31 Jul 2003 18:05:33 -0000
@@ -2,19 +2,26 @@
 #include <fs_secure.h>
 #include <security.h>
 #include <errno.h>
+#include "kernel_stat64.h"
+#include "xstat64_conv.h"
 #include <flask_util.h>
 
 int fstat64_secure(unsigned int fd,
 		   struct stat64 *buf, 
 		   security_id_t *out_sid)
 {
+	struct kernel_stat64 kbuf;
 	unsigned long args[3];
+	long err;
 
 	if (is_flask_enabled()) {	
 		args[0] = (unsigned long)fd;
-		args[1] = (unsigned long)buf;
+		args[1] = (unsigned long)&kbuf;
 		args[2] = (unsigned long)out_sid;
-		return security(SELINUX_MAGIC, SELINUXCALL_FSTAT64, args);
+		err = security(SELINUX_MAGIC, SELINUXCALL_FSTAT64, args);
+		if (err)
+			return err;
+		return xstat64_conv(_STAT_VER_LINUX, &kbuf, buf);
 	} else {
 		/* Compatibility for the modified utilities
 		   until they are fixed. */
Index: libsecure/src/arch/i386/lstat64_secure.c
===================================================================
RCS file: /home/pal/CVS/selinux/libsecure/src/arch/i386/lstat64_secure.c,v
retrieving revision 1.3
diff -u -r1.3 lstat64_secure.c
--- libsecure/src/arch/i386/lstat64_secure.c	18 Jun 2003 13:56:02 -0000	1.3
+++ libsecure/src/arch/i386/lstat64_secure.c	31 Jul 2003 18:05:33 -0000
@@ -2,19 +2,26 @@
 #include <fs_secure.h>
 #include <security.h>
 #include <errno.h>
+#include "kernel_stat64.h"
+#include "xstat64_conv.h"
 #include <flask_util.h>
 
 int lstat64_secure(const char *pathname, 
 		   struct stat64 *buf, 
 		   security_id_t *out_sid)
 {
+	struct kernel_stat64 kbuf;
 	unsigned long args[3];
+	int err;
 	
 	if (is_flask_enabled()) {
 		args[0] = (unsigned long)pathname;
-		args[1] = (unsigned long)buf;
+		args[1] = (unsigned long)&kbuf;
 		args[2] = (unsigned long)out_sid;
-		return security(SELINUX_MAGIC, SELINUXCALL_LSTAT64, args);
+		err = security(SELINUX_MAGIC, SELINUXCALL_LSTAT64, args);
+		if (err)
+			return err; 
+		return xstat64_conv(_STAT_VER_LINUX, &kbuf, buf);
 	} else {
 		/* Compatibility for the modified utilities
 		   until they are fixed. */
Index: libsecure/src/arch/i386/stat64_secure.c
===================================================================
RCS file: /home/pal/CVS/selinux/libsecure/src/arch/i386/stat64_secure.c,v
retrieving revision 1.3
diff -u -r1.3 stat64_secure.c
--- libsecure/src/arch/i386/stat64_secure.c	18 Jun 2003 13:56:02 -0000	1.3
+++ libsecure/src/arch/i386/stat64_secure.c	31 Jul 2003 18:05:33 -0000
@@ -2,19 +2,26 @@
 #include <fs_secure.h>
 #include <security.h>
 #include <errno.h>
+#include "kernel_stat64.h"
+#include "xstat64_conv.h"
 #include <flask_util.h>
 
 int stat64_secure(const char *pathname, 
 		  struct stat64 *buf, 
 		  security_id_t *out_sid)
 {
+	struct kernel_stat64 kbuf;
 	unsigned long args[3];
+	long err;
 
 	if (is_flask_enabled()) {
 		args[0] = (unsigned long)pathname;
-		args[1] = (unsigned long)buf;
+		args[1] = (unsigned long)&kbuf;
 		args[2] = (unsigned long)out_sid;
-		return security(SELINUX_MAGIC, SELINUXCALL_STAT64, args);
+		err = security(SELINUX_MAGIC, SELINUXCALL_STAT64, args);
+		if (err)
+			return err;
+		return xstat64_conv(_STAT_VER_LINUX, &kbuf, buf);
 	} else {
 		/* Compatibility for the modified utilities
 		   until they are fixed. */

--=-DGWlAmOeeK48EvCp75a1--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
