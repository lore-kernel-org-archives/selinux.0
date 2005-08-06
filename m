Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j77BeqOb007910
	for <selinux@tycho.nsa.gov>; Sun, 7 Aug 2005 07:41:07 -0400 (EDT)
Received: from glaurung.internal.golden-gryphon.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j77BWSi5000733
	for <selinux@tycho.nsa.gov>; Sun, 7 Aug 2005 11:32:29 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.4/8.13.4/Debian-3) with ESMTP id j76HUpHx011132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Sat, 6 Aug 2005 12:30:51 -0500
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Cleaner patch for for libselinux  IA64  build failure
Date: Sat, 06 Aug 2005 12:30:51 -0500
Message-ID: <87u0i32cs4.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        This is a slightly cleaner patch, and has the advantage of
 actually working ;-)

        manoj

diff -u -Nrua libselinux-1.24-1/utils/setupns.c libselinux-1.24-1.1/utils/setupns.c
--- libselinux-1.24-1/utils/setupns.c	2005-06-13 22:29:43.000000000 +0200
+++ libselinux-1.24-1.1/utils/setupns.c	2005-08-05 10:50:04.000000000 +0200
@@ -13,7 +13,17 @@
 
 #include <linux/unistd.h>
 #define CLONE_NEWNS 0x00020000 /* Flag to create new namespace */
+
+#ifndef __ia64__
 static inline _syscall2 (int, clone, int, flags, int, arg)
+#else /* There is no _syscall2 in ia64 */
+#include "ia64-inline-syscall.h"
+static inline int
+clone (int flags, int arg)
+{
+    return INLINE_SYSCALL (clone2, 6, flags, NULL, arg, NULL, NULL, NULL);
+}
+#endif
 
 char *progname;
 
diff -u -Nrua libselinux-1.24-1/utils/ia64-inline-syscall.h libselinux-1.24-1.1/utils/ia64-inline-syscall.h
--- libselinux-1.24-1/utils/ia64-inline-syscall.h	1970-01-01 01:00:00.000000000 +0100
+++ libselinux-1.24-1.1/utils/ia64-inline-syscall.h	2005-08-05 11:51:15.000000000 +0200
@@ -0,0 +1,98 @@
+/*
+ * This file was sent to Debian Bug#320193 by Florian Weimer
+ * <fw@deneb.enyo.de>. See debian/copyright for copyright info.
+ */
+
+/* The following code has been copied from GNU libc 2.3.2, Debian
+ * version 2.3.2.ds1-18,, file sysdeps/unix/sysv/linux/ia64/sysdep.h.
+ * The __set_errno call has been replaced with an assignment to the
+ * errno location.
+ *
+ * We cannot use __clone2 because it requires a callback and
+ * automatically invokes _exit in the child.  Even if we used longjmp to
+ * work around this problem, we are still using an internal GNU libc
+ * interface.  The kernel interface used below should be fairly stable.
+ *
+ * BEGIN OF GNU LIBC EXCERPT
+ */
+#define BREAK_INSN_1(num) "break " #num ";;\n\t"
+#define BREAK_INSN(num) BREAK_INSN_1(num)
+
+/* On IA-64 we have stacked registers for passing arguments.  The
+   "out" registers end up being the called function's "in"
+   registers.
+
+   Also, since we have plenty of registers we have two return values
+   from a syscall.  r10 is set to -1 on error, whilst r8 contains the
+   (non-negative) errno on error or the return value on success.
+ */
+#undef INLINE_SYSCALL
+#define INLINE_SYSCALL(name, nr, args...)                       \
+  ({                                                            \
+    register long _r8 asm ("r8");                               \
+    register long _r10 asm ("r10");                             \
+    register long _r15 asm ("r15") = __NR_##name;               \
+    long _retval;                                               \
+    LOAD_ARGS_##nr (args);                                      \
+    __asm __volatile (BREAK_INSN (__BREAK_SYSCALL)              \
+                      : "=r" (_r8), "=r" (_r10), "=r" (_r15)    \
+                        ASM_OUTARGS_##nr                        \
+                      : "2" (_r15) ASM_ARGS_##nr                \
+                      : "memory" ASM_CLOBBERS_##nr);            \
+    _retval = _r8;                                              \
+    if (_r10 == -1)                                             \
+      {                                                         \
+        errno = _retval;                                        \
+        _retval = -1;                                           \
+      }                                                         \
+    _retval; })
+
+#define ASM_OUTARGS_0
+#define ASM_OUTARGS_1   ASM_OUTARGS_0, "=r" (_out0)
+#define ASM_OUTARGS_2   ASM_OUTARGS_1, "=r" (_out1)
+#define ASM_OUTARGS_3   ASM_OUTARGS_2, "=r" (_out2)
+#define ASM_OUTARGS_4   ASM_OUTARGS_3, "=r" (_out3)
+#define ASM_OUTARGS_5   ASM_OUTARGS_4, "=r" (_out4)
+#define ASM_OUTARGS_6   ASM_OUTARGS_5, "=r" (_out5)
+
+#define ASM_ARGS_0
+#define ASM_ARGS_1      ASM_ARGS_0, "3" (_out0)
+#define ASM_ARGS_2      ASM_ARGS_1, "4" (_out1)
+#define ASM_ARGS_3      ASM_ARGS_2, "5" (_out2)
+#define ASM_ARGS_4      ASM_ARGS_3, "6" (_out3)
+#define ASM_ARGS_5      ASM_ARGS_4, "7" (_out4)
+#define ASM_ARGS_6      ASM_ARGS_5, "8" (_out5)
+
+#define ASM_CLOBBERS_6  , "out6", "out7",                               \
+  /* Non-stacked integer registers, minus r8, r10, r15.  */             \
+  "r2", "r3", "r9", "r11", "r12", "r13", "r14", "r16", "r17", "r18",    \
+  "r19", "r20", "r21", "r22", "r23", "r24", "r25", "r26", "r27",        \
+  "r28", "r29", "r30", "r31",                                           \
+  /* Predicate registers.  */                                           \
+  "p6", "p7", "p8", "p9", "p10", "p11", "p12", "p13", "p14", "p15",     \
+  /* Non-rotating fp registers.  */                                     \
+  "f6", "f7", "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",     \
+  /* Branch registers.  */                                              \
+  "b6", "b7"
+
+#define LOAD_ARGS_0()   do { } while (0)
+#define LOAD_ARGS_1(out0)                               \
+  register long _out0 asm ("out0") = (long) (out0);     \
+  LOAD_ARGS_0 ()
+#define LOAD_ARGS_2(out0, out1)                         \
+  register long _out1 asm ("out1") = (long) (out1);     \
+  LOAD_ARGS_1 (out0)
+#define LOAD_ARGS_3(out0, out1, out2)                   \
+  register long _out2 asm ("out2") = (long) (out2);     \
+  LOAD_ARGS_2 (out0, out1)
+#define LOAD_ARGS_4(out0, out1, out2, out3)             \
+  register long _out3 asm ("out3") = (long) (out3);     \
+  LOAD_ARGS_3 (out0, out1, out2)
+#define LOAD_ARGS_5(out0, out1, out2, out3, out4)       \
+  register long _out4 asm ("out4") = (long) (out4);     \
+  LOAD_ARGS_4 (out0, out1, out2, out3)
+#define LOAD_ARGS_6(out0, out1, out2, out3, out4, out5) \
+  register long _out5 asm ("out5") = (long) (out5);     \
+  LOAD_ARGS_5 (out0, out1, out2, out3, out4)
+
+/*  END OF GNU LIBC EXCERPT */

-- 
Those who in quarrels interpose, must often wipe a bloody nose.
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
