Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h42BhFI4015463
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 07:43:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h42Bh3Vf003242
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 11:43:04 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h42Bh34D003239
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 11:43:03 GMT
Subject: Re: SELinux Compilation Error on Redhat 8.0 with  LSM 2.5
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Rakesh Tripathi <rtripathi@cougaarsoftware.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <3EB1B834.9080608@cougaarsoftware.com>
References: <3EB1B834.9080608@cougaarsoftware.com>
Content-Type: multipart/mixed; boundary="=-161R1nwBnvFtqiwZz8Tn"
Message-Id: <1051875789.1377.412.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 02 May 2003 07:43:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-161R1nwBnvFtqiwZz8Tn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-05-01 at 20:13, Rakesh Tripathi wrote:
> Hi all,
>  I'm trying to install SELinux on RedHat 8.0 and I get the following 
> compliation  .Any help appreciated.
<snip>
> fs/cramfs/inode.c: In function `get_cramfs_inode':
> fs/cramfs/inode.c:54: incompatible types in assignment

The first attached patch should fix this problem.  Save it to
~/cramfs.patch, cd lsm-2.5, and run 'patch -p1 < ~/cramfs.patch'.  As a
side note, the lsm-2.5 tree will be obsoleted by the mainline 2.5-based
SELinux; see http://www.nsa.gov/selinux/lk for a current snapshot of
it.  However, the mainline 2.5-based SELinux doesn't yet have a full
userland environment.

I expect that you may also run into a problem with building libsecure
due to the change in the stat structure definition.  The second attached
patch may help with that problem.  To use it, save it to
~/newstat.patch, cd selinux, and run 'patch -p1 < ~/newstat.patch'.
This also will be obsoleted by the mainline 2.5-based SELinux, as we no
longer provide an extended stat call.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-161R1nwBnvFtqiwZz8Tn
Content-Disposition: attachment; filename=cramfs.patch
Content-Type: text/plain; name=cramfs.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- lsm-2.5/fs/cramfs/inode.c	Tue Mar 25 09:23:24 2003
+++ linux-2.5/fs/cramfs/inode.c	Tue Apr  8 10:03:35 2003
@@ -43,6 +43,7 @@
 static struct inode *get_cramfs_inode(struct super_block *sb, struct cramfs_inode * cramfs_inode)
 {
 	struct inode * inode = new_inode(sb);
+	static struct timespec zerotime = { 0, 0 };
 
 	if (inode) {
 		inode->i_mode = cramfs_inode->mode;
@@ -51,7 +52,8 @@
 		inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_gid = cramfs_inode->gid;
-		inode->i_mtime = inode->i_atime = inode->i_ctime = 0;
+		/* Struct copy intentional */
+		inode->i_mtime = inode->i_atime = inode->i_ctime = zerotime;
 		inode->i_ino = CRAMINO(cramfs_inode);
 		/* inode->i_nlink is left 1 - arguably wrong for directories,
 		   but it's the best we can do without reading the directory

--=-161R1nwBnvFtqiwZz8Tn
Content-Disposition: attachment; filename=newstat.patch
Content-Type: text/x-patch; name=newstat.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: selinux/libsecure/src/kernel_stat.h
===================================================================
RCS file: /home/pal/CVS/selinux/libsecure/src/kernel_stat.h,v
retrieving revision 1.2
diff -u -r1.2 kernel_stat.h
--- selinux/libsecure/src/kernel_stat.h	27 Nov 2001 12:21:05 -0000	1.2
+++ selinux/libsecure/src/kernel_stat.h	22 Apr 2003 15:47:25 -0000
@@ -15,18 +15,21 @@
     unsigned long int st_size;
     unsigned long int st_blksize;
     unsigned long int st_blocks;
-    unsigned long int st_atime;
-    unsigned long int __unused1;
-#define _HAVE___UNUSED1
-    unsigned long int st_mtime;
-    unsigned long int __unused2;
-#define _HAVE___UNUSED2
-    unsigned long int st_ctime;
-    unsigned long int __unused3;
-#define _HAVE___UNUSED3
+    struct timespec st_atim;
+    struct timespec st_mtim;
+    struct timespec st_ctim;
     unsigned long int __unused4;
 #define _HAVE___UNUSED4
     unsigned long int __unused5;
 #define _HAVE___UNUSED5
   };
 
+#define _HAVE_STAT___UNUSED4
+#define _HAVE_STAT___UNUSED5
+#define _HAVE_STAT___PAD1
+#define _HAVE_STAT___PAD2
+#define _HAVE_STAT_NSEC
+#define _HAVE_STAT64___PAD1
+#define _HAVE_STAT64___PAD2
+#define _HAVE_STAT64___ST_INO
+#define _HAVE_STAT64_NSEC
Index: selinux/libsecure/src/xstat_conv.h
===================================================================
RCS file: /home/pal/CVS/selinux/libsecure/src/xstat_conv.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 xstat_conv.h
--- selinux/libsecure/src/xstat_conv.h	18 Jul 2001 20:38:06 -0000	1.1.1.1
+++ selinux/libsecure/src/xstat_conv.h	22 Apr 2003 15:40:53 -0000
@@ -1,21 +1,26 @@
 /* Convert between the kernel's `struct stat' format, and libc's.
-   Copyright (C) 1991, 1995, 1996, 1997 Free Software Foundation, Inc.
+   Copyright (C) 1991,1995,1996,1997,2000,2002 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
 
    The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Library General Public License as
-   published by the Free Software Foundation; either version 2 of the
-   License, or (at your option) any later version.
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
 
    The GNU C Library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Library General Public License for more details.
+   Lesser General Public License for more details.
 
-   You should have received a copy of the GNU Library General Public
-   License along with the GNU C Library; see the file COPYING.LIB.  If not,
-   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
-   Boston, MA 02111-1307, USA.  */
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <errno.h>
+#define __set_errno(x) (errno) = (x)
+
+#include <string.h>
 
 static inline int
 xstat_conv (int vers, struct kernel_stat *kbuf, void *ubuf)
@@ -35,7 +40,7 @@
 
 	/* Convert to current kernel version of `struct stat'.  */
 	buf->st_dev = kbuf->st_dev;
-#ifdef _HAVE___PAD1
+#ifdef _HAVE_STAT___PAD1
 	buf->__pad1 = 0;
 #endif
 	buf->st_ino = kbuf->st_ino;
@@ -44,35 +49,44 @@
 	buf->st_uid = kbuf->st_uid;
 	buf->st_gid = kbuf->st_gid;
 	buf->st_rdev = kbuf->st_rdev;
-#ifdef _HAVE___PAD2
+#ifdef _HAVE_STAT___PAD2
 	buf->__pad2 = 0;
 #endif
 	buf->st_size = kbuf->st_size;
 	buf->st_blksize = kbuf->st_blksize;
 	buf->st_blocks = kbuf->st_blocks;
+#ifdef _HAVE_STAT_NSEC
+	buf->st_atim.tv_sec = kbuf->st_atim.tv_sec;
+	buf->st_atim.tv_nsec = kbuf->st_atim.tv_nsec;
+	buf->st_mtim.tv_sec = kbuf->st_mtim.tv_sec;
+	buf->st_mtim.tv_nsec = kbuf->st_mtim.tv_nsec;
+	buf->st_ctim.tv_sec = kbuf->st_ctim.tv_sec;
+	buf->st_ctim.tv_nsec = kbuf->st_ctim.tv_nsec;
+#else
 	buf->st_atime = kbuf->st_atime;
-#ifdef _HAVE___UNUSED1
+	buf->st_mtime = kbuf->st_mtime;
+	buf->st_ctime = kbuf->st_ctime;
+#endif
+#ifdef _HAVE_STAT___UNUSED1
 	buf->__unused1 = 0;
 #endif
-	buf->st_mtime = kbuf->st_mtime;
-#ifdef _HAVE___UNUSED2
+#ifdef _HAVE_STAT___UNUSED2
 	buf->__unused2 = 0;
 #endif
-	buf->st_ctime = kbuf->st_ctime;
-#ifdef _HAVE___UNUSED3
+#ifdef _HAVE_STAT___UNUSED3
 	buf->__unused3 = 0;
 #endif
-#ifdef _HAVE___UNUSED4
+#ifdef _HAVE_STAT___UNUSED4
 	buf->__unused4 = 0;
 #endif
-#ifdef _HAVE___UNUSED5
+#ifdef _HAVE_STAT___UNUSED5
 	buf->__unused5 = 0;
 #endif
       }
       break;
 
     default:
-      errno = EINVAL;
+      __set_errno (EINVAL);
       return -1;
     }
 
Index: selinux/libsecure/src/arch/i386/fstat64_secure.c
===================================================================
RCS file: /home/pal/CVS/selinux/libsecure/src/arch/i386/fstat64_secure.c,v
retrieving revision 1.2
diff -u -r1.2 fstat64_secure.c
--- selinux/libsecure/src/arch/i386/fstat64_secure.c	2 Oct 2002 20:28:17 -0000	1.2
+++ selinux/libsecure/src/arch/i386/fstat64_secure.c	22 Apr 2003 15:52:45 -0000
@@ -2,26 +2,19 @@
 #include <fs_secure.h>
 #include <security.h>
 #include <errno.h>
-#include "kernel_stat64.h"
-#include "xstat64_conv.h"
 #include <flask_util.h>
 
 int fstat64_secure(unsigned int fd,
 		   struct stat64 *buf, 
 		   security_id_t *out_sid)
 {
-	struct kernel_stat64 kbuf;
 	unsigned long args[3];
-	long err;
 
 	if (is_flask_enabled()) {	
 		args[0] = (unsigned long)fd;
-		args[1] = (unsigned long)&kbuf;
+		args[1] = (unsigned long)buf;
 		args[2] = (unsigned long)out_sid;
-		err = security(SELINUX_MAGIC, SELINUXCALL_FSTAT64, args);
-		if (err)
-			return err;
-		return xstat64_conv(_STAT_VER_LINUX, &kbuf, buf);
+		return security(SELINUX_MAGIC, SELINUXCALL_FSTAT64, args);
 	} else {
 		/* Compatibility for the modified utilities
 		   until they are fixed. */
Index: selinux/libsecure/src/arch/i386/lstat64_secure.c
===================================================================
RCS file: /home/pal/CVS/selinux/libsecure/src/arch/i386/lstat64_secure.c,v
retrieving revision 1.2
diff -u -r1.2 lstat64_secure.c
--- selinux/libsecure/src/arch/i386/lstat64_secure.c	2 Oct 2002 20:28:17 -0000	1.2
+++ selinux/libsecure/src/arch/i386/lstat64_secure.c	22 Apr 2003 15:53:12 -0000
@@ -2,26 +2,19 @@
 #include <fs_secure.h>
 #include <security.h>
 #include <errno.h>
-#include "kernel_stat64.h"
-#include "xstat64_conv.h"
 #include <flask_util.h>
 
 int lstat64_secure(const char *pathname, 
 		   struct stat64 *buf, 
 		   security_id_t *out_sid)
 {
-	struct kernel_stat64 kbuf;
 	unsigned long args[3];
-	int err;
 	
 	if (is_flask_enabled()) {
 		args[0] = (unsigned long)pathname;
-		args[1] = (unsigned long)&kbuf;
+		args[1] = (unsigned long)buf;
 		args[2] = (unsigned long)out_sid;
-		err = security(SELINUX_MAGIC, SELINUXCALL_LSTAT64, args);
-		if (err)
-			return err; 
-		return xstat64_conv(_STAT_VER_LINUX, &kbuf, buf);
+		return security(SELINUX_MAGIC, SELINUXCALL_LSTAT64, args);
 	} else {
 		/* Compatibility for the modified utilities
 		   until they are fixed. */
Index: selinux/libsecure/src/arch/i386/stat64_secure.c
===================================================================
RCS file: /home/pal/CVS/selinux/libsecure/src/arch/i386/stat64_secure.c,v
retrieving revision 1.2
diff -u -r1.2 stat64_secure.c
--- selinux/libsecure/src/arch/i386/stat64_secure.c	2 Oct 2002 20:28:17 -0000	1.2
+++ selinux/libsecure/src/arch/i386/stat64_secure.c	22 Apr 2003 15:52:50 -0000
@@ -2,26 +2,19 @@
 #include <fs_secure.h>
 #include <security.h>
 #include <errno.h>
-#include "kernel_stat64.h"
-#include "xstat64_conv.h"
 #include <flask_util.h>
 
 int stat64_secure(const char *pathname, 
 		  struct stat64 *buf, 
 		  security_id_t *out_sid)
 {
-	struct kernel_stat64 kbuf;
 	unsigned long args[3];
-	long err;
 
 	if (is_flask_enabled()) {
 		args[0] = (unsigned long)pathname;
-		args[1] = (unsigned long)&kbuf;
+		args[1] = (unsigned long)buf;
 		args[2] = (unsigned long)out_sid;
-		err = security(SELINUX_MAGIC, SELINUXCALL_STAT64, args);
-		if (err)
-			return err;
-		return xstat64_conv(_STAT_VER_LINUX, &kbuf, buf);
+		return security(SELINUX_MAGIC, SELINUXCALL_STAT64, args);
 	} else {
 		/* Compatibility for the modified utilities
 		   until they are fixed. */

--=-161R1nwBnvFtqiwZz8Tn--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
