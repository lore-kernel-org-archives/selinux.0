Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA21424
	for <selinux@tycho.nsa.gov>; Sun, 8 Dec 2002 18:41:16 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA07838
	for <selinux@tycho.nsa.gov>; Sun, 8 Dec 2002 23:38:57 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA07834
	for <selinux@tycho.nsa.gov>; Sun, 8 Dec 2002 23:38:54 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 2282392668
	for <selinux@tycho.nsa.gov>; Mon,  9 Dec 2002 10:41:05 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id EA1A12FE5
	for <selinux@tycho.nsa.gov>; Mon,  9 Dec 2002 00:40:55 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: other architectures
Date: Mon, 9 Dec 2002 00:40:55 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_74RTY92D88ZBQOXYJA0K"
Message-Id: <200212090040.55521.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_74RTY92D88ZBQOXYJA0K
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I have attached a kernel patch I use to add system call numbers for 
sys_security for all architectures.

I have modified my Debian package build scripts to use numbers from this patch 
when compiling the system call code and to use -D_FILE_OFFSET_BITS=32 when 
compiling setfiles on architectures other than i386.  I'll probably try and 
solve this tomorrow.

With these changes the S/390 auto-builder successfully built the selinux-small 
packages a few hours ago!

This means that we are a step closer to getting full Debian support for SE 
Linux (now I may be able to get the main psmisc and procps packages to be 
built with SE Linux support)!


My real aim in this was to get ARM working.  I can compile my own ARM packages 
but the ARM auto-builder is way behind and may not get to my packages for 
weeks.  :(

ARM already had a syscall number reserved so I didn't need a patch for that, 
but I decided to get some things working on S/390 first as it has the fastest 
auto-builders and the S/390 people answer questions faster on mailing lists.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_74RTY92D88ZBQOXYJA0K
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-syscall"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-syscall"

diff -ru linux-2.4.20/include/asm-m68k/unistd.h linux-2.4.20.patched/include/asm-m68k/unistd.h
--- linux-2.4.20/include/asm-m68k/unistd.h	2002-11-29 11:07:37.000000000 +0100
+++ linux-2.4.20.patched/include/asm-m68k/unistd.h	2002-12-08 16:49:12.000000000 +0100
@@ -237,6 +237,7 @@
 #define __NR_removexattr	232
 #define __NR_lremovexattr	233
 #define __NR_fremovexattr	234
+#define __NR_security		235     /* syscall for security modules */
 
 /* user-visible error numbers are in the range -1 - -122: see
    <asm-m68k/errno.h> */
diff -ru linux-2.4.20/include/asm-parisc/unistd.h linux-2.4.20.patched/include/asm-parisc/unistd.h
--- linux-2.4.20/include/asm-parisc/unistd.h	2002-11-29 11:13:42.000000000 +0100
+++ linux-2.4.20.patched/include/asm-parisc/unistd.h	2002-12-08 16:33:44.000000000 +0100
@@ -700,8 +700,9 @@
 #define __NR_acl_set            (__NR_Linux + 205)
 #define __NR_gettid             (__NR_Linux + 206)
 #define __NR_readahead          (__NR_Linux + 207)
+#define __NR_security           (__NR_Linux + 208)  /* syscall for security */
 
-#define __NR_Linux_syscalls     207
+#define __NR_Linux_syscalls     208
 
 #define HPUX_GATEWAY_ADDR       0xC0000004
 #define LINUX_GATEWAY_ADDR      0x100
diff -ru linux-2.4.20/include/asm-ppc/unistd.h linux-2.4.20.patched/include/asm-ppc/unistd.h
--- linux-2.4.20/include/asm-ppc/unistd.h	2002-11-29 11:13:44.000000000 +0100
+++ linux-2.4.20.patched/include/asm-ppc/unistd.h	2002-12-08 16:35:00.000000000 +0100
@@ -241,6 +241,7 @@
 #define __NR_io_submit		230
 #define __NR_io_cancel		231
 #endif
+#define __NR_security		232 /* syscall for security modules */
 
 #define __NR(n)	#n
 
diff -ru linux-2.4.20/include/asm-ppc64/unistd.h linux-2.4.20.patched/include/asm-ppc64/unistd.h
--- linux-2.4.20/include/asm-ppc64/unistd.h	2002-08-03 02:39:45.000000000 +0200
+++ linux-2.4.20.patched/include/asm-ppc64/unistd.h	2002-12-08 16:36:41.000000000 +0100
@@ -232,6 +232,7 @@
 #define __NR_fremovexattr	220
 #define __NR_futex		221
 #endif
+#define __NR_security		232 /* syscall for security modules */
 
 #define __NR(n)	#n
 
diff -ru linux-2.4.20/include/asm-s390/unistd.h linux-2.4.20.patched/include/asm-s390/unistd.h
--- linux-2.4.20/include/asm-s390/unistd.h	2002-08-03 02:39:45.000000000 +0200
+++ linux-2.4.20.patched/include/asm-s390/unistd.h	2002-12-08 16:37:28.000000000 +0100
@@ -217,6 +217,7 @@
  */
 #define __NR_gettid		236
 #define __NR_tkill		237
+#define __NR_security		238 /* reserved for security */
 
 /* user-visible error numbers are in the range -1 - -122: see <asm-s390/errno.h> */
 
diff -ru linux-2.4.20/include/asm-s390x/unistd.h linux-2.4.20.patched/include/asm-s390x/unistd.h
--- linux-2.4.20/include/asm-s390x/unistd.h	2002-08-03 02:39:45.000000000 +0200
+++ linux-2.4.20.patched/include/asm-s390x/unistd.h	2002-12-08 16:38:14.000000000 +0100
@@ -185,6 +185,7 @@
  */
 #define __NR_gettid		236
 #define __NR_tkill		237
+#define __NR_security		238 /* reserved for security */
 
 
 /* user-visible error numbers are in the range -1 - -122: see <asm-s390/errno.h> */
diff -ru linux-2.4.20/include/asm-sh/unistd.h linux-2.4.20.patched/include/asm-sh/unistd.h
--- linux-2.4.20/include/asm-sh/unistd.h	2002-08-03 02:39:45.000000000 +0200
+++ linux-2.4.20.patched/include/asm-sh/unistd.h	2002-12-08 16:38:54.000000000 +0100
@@ -233,6 +233,7 @@
 #define __NR_fcntl64		221
 #define __NR_gettid		222
 #define __NR_tkill		223
+#define __NR_security		224 /* reserved for security */
 
 /* user-visible error numbers are in the range -1 - -125: see <asm-sh/errno.h> */
 
diff -ru linux-2.4.20/include/asm-sparc/unistd.h linux-2.4.20.patched/include/asm-sparc/unistd.h
--- linux-2.4.20/include/asm-sparc/unistd.h	2002-08-03 02:39:45.000000000 +0200
+++ linux-2.4.20.patched/include/asm-sparc/unistd.h	2002-12-08 16:49:53.000000000 +0100
@@ -271,6 +271,7 @@
 #define __NR_fdatasync          253
 #define __NR_nfsservctl         254
 #define __NR_aplib              255
+#define __NR_security           256 /* reserved for security */
 
 #define _syscall0(type,name) \
 type name(void) \
diff -ru linux-2.4.20/include/asm-sparc64/unistd.h linux-2.4.20.patched/include/asm-sparc64/unistd.h
--- linux-2.4.20/include/asm-sparc64/unistd.h	2002-08-03 02:39:45.000000000 +0200
+++ linux-2.4.20.patched/include/asm-sparc64/unistd.h	2002-12-08 16:50:11.000000000 +0100
@@ -273,6 +273,7 @@
 #define __NR_fdatasync          253
 #define __NR_nfsservctl         254
 #define __NR_aplib              255
+#define __NR_security           256 /* reserved for security */
 
 #define _syscall0(type,name) \
 type name(void) \
diff -ru linux-2.4.20/include/asm-x86_64/unistd.h linux-2.4.20.patched/include/asm-x86_64/unistd.h
--- linux-2.4.20/include/asm-x86_64/unistd.h	2002-11-29 11:13:49.000000000 +0100
+++ linux-2.4.20.patched/include/asm-x86_64/unistd.h	2002-12-08 16:46:25.000000000 +0100
@@ -427,7 +427,11 @@
 __SYSCALL(__NR_tuxcall, sys_ni_syscall)
 
 #define __NR_security			185 /* reserved for security */
+#ifdef CONFIG_SELINUX
+__SYSCALL(__NR_security, sys_security)
+#else
 __SYSCALL(__NR_security, sys_ni_syscall)
+#endif
 
 #define __NR_gettid		186
 __SYSCALL(__NR_gettid, sys_gettid)

--------------Boundary-00=_74RTY92D88ZBQOXYJA0K--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
