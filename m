Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA27926
	for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2002 14:58:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA24635
	for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2002 19:56:14 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id TAA24631
	for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2002 19:56:12 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 354BA92668
	for <selinux@tycho.nsa.gov>; Tue, 10 Dec 2002 06:58:30 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id E2E8C6D85
	for <selinux@tycho.nsa.gov>; Mon,  9 Dec 2002 20:58:22 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: ia64
Date: Mon, 9 Dec 2002 20:58:22 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_AHBVPTT77AD7JBVEZO4T"
Message-Id: <200212092058.22530.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_AHBVPTT77AD7JBVEZO4T
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

The attached patch for selinux-small seems to be necessary for ia64.

I still haven't got it to fully compile on ia64, but this patch makes it get a 
lot closer, and I think it's worthy of inclusion in the CVS.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_AHBVPTT77AD7JBVEZO4T
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ru selinux/libsecure/src/kernel_stat.h selinux-small-2002102211/libsecure/src/kernel_stat.h
--- selinux/libsecure/src/kernel_stat.h	Tue Nov 27 05:21:05 2001
+++ selinux-small-2002102211/libsecure/src/kernel_stat.h	Mon Dec  9 12:43:31 2002
@@ -1,4 +1,31 @@
 /* Definition of `struct stat' used in the kernel..  */
+#ifdef __ia64__
+struct kernel_stat
+{
+    unsigned long   st_dev;
+    unsigned long   st_ino;
+    unsigned long   st_nlink;
+    unsigned int    st_mode;
+    unsigned int    st_uid;
+    unsigned int    st_gid;
+/* do not define _HAVE___PAD0 because user-land does not know of pad0 */
+    unsigned int    __pad0;
+    unsigned long   st_rdev;
+    unsigned long   st_size;
+    unsigned long   st_atime;
+    unsigned long   __reserved0;    /* reserved for atime.nanoseconds */
+#define _HAVE___RESERVED0
+    unsigned long   st_mtime;
+    unsigned long   __reserved1;    /* reserved for mtime.nanoseconds */
+#define _HAVE___RESERVED1
+    unsigned long   st_ctime;
+    unsigned long   __reserved2;    /* reserved for ctime.nanoseconds */
+#define _HAVE___RESERVED2
+    unsigned long   st_blksize;
+    long            st_blocks;
+    unsigned long   __unused[3];
+};
+#else
 struct kernel_stat
   {
     unsigned short int st_dev;
@@ -29,4 +56,4 @@
     unsigned long int __unused5;
 #define _HAVE___UNUSED5
   };
-
+#endif
diff -ru selinux/libsecure/src/xstat_conv.h selinux-small-2002102211/libsecure/src/xstat_conv.h
--- selinux/libsecure/src/xstat_conv.h	Wed Jul 18 14:38:06 2001
+++ selinux-small-2002102211/libsecure/src/xstat_conv.h	Mon Dec  9 12:54:29 2002
@@ -51,14 +51,23 @@
 	buf->st_blksize = kbuf->st_blksize;
 	buf->st_blocks = kbuf->st_blocks;
 	buf->st_atime = kbuf->st_atime;
+#ifdef _HAVE___RESERVED0
+	buf->__reserved0 = 0;
+#endif
 #ifdef _HAVE___UNUSED1
 	buf->__unused1 = 0;
 #endif
 	buf->st_mtime = kbuf->st_mtime;
+#ifdef _HAVE___RESERVED1
+	buf->__reserved1 = 0;
+#endif
 #ifdef _HAVE___UNUSED2
 	buf->__unused2 = 0;
 #endif
 	buf->st_ctime = kbuf->st_ctime;
+#ifdef _HAVE___RESERVED2
+	buf->__reserved2 = 0;
+#endif
 #ifdef _HAVE___UNUSED3
 	buf->__unused3 = 0;
 #endif

--------------Boundary-00=_AHBVPTT77AD7JBVEZO4T--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
