Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA25873
	for <selinux@tycho.nsa.gov>; Wed, 5 Feb 2003 17:47:08 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h15Ml7I06628
	for <selinux@tycho.nsa.gov>; Wed, 5 Feb 2003 22:47:07 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h15Ml5f06624 for <selinux@tycho.nsa.gov>; Wed, 5 Feb 2003 22:47:06 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 14779924E5
	for <selinux@tycho.nsa.gov>; Thu,  6 Feb 2003 09:47:03 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 923164278
	for <selinux@tycho.nsa.gov>; Wed,  5 Feb 2003 23:46:55 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: arm
Date: Wed, 5 Feb 2003 23:46:55 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fRZQ+XLKm/8TLJg"
Message-Id: <200302052346.55188.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_fRZQ+XLKm/8TLJg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have my iPaQ booting a SE Linux kernel and loading policy.  I haven't 
labelled the file systems so it doesn't do anything useful yet, but progress 
is going well.

I've attached a patch that applies on top of 2.4.19 with the latest ARM 
patches and the 2.4.20 kernel patch back-ported to 2.4.19.

On http://www.coker.com.au/selinux/kern/ I have a file arm.bz2 which is a 
combination of all the 2.4.19 ARM patches I am using, and a file 
arm-lsm.diff.bz2 which applies on top of that for all LSM functionality plus 
the attached patch.

Most of the attached patch should be good for merging into the LSM patch tree.  
There are a couple of bits that break non-SE compilation, but they are easily 
fixed.

Also I have not actually called a SE Linux sys-call yet.  So there may be some 
horrible bug in that regard.  Hopefully tomorrow I'll get a labeled file 
system on my iPaQ and a modified login and I'll test these things out 
properly.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_fRZQ+XLKm/8TLJg
Content-Type: text/x-diff;
  charset="us-ascii";
  name="arm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="arm.diff"

diff -ruN linux-2.4.19-arm/arch/arm/config.in linux-2.4.19-arm-lsm/arch/arm/config.in
--- linux-2.4.19-arm/arch/arm/config.in	2003-02-05 23:25:59.000000000 +0100
+++ linux-2.4.19-arm-lsm/arch/arm/config.in	2003-02-05 23:24:37.000000000 +0100
@@ -818,4 +818,5 @@
 dep_bool '    Kernel low-level debugging messages via UART2' CONFIG_DEBUG_CLPS711X_UART2 $CONFIG_DEBUG_LL $CONFIG_ARCH_CLPS711X
 endmenu
 
+source security/Config.in
 source lib/Config.in
diff -ruN linux-2.4.19-arm/arch/arm/kernel/calls.S linux-2.4.19-arm-lsm/arch/arm/kernel/calls.S
--- linux-2.4.19-arm/arch/arm/kernel/calls.S	2003-02-05 23:25:59.000000000 +0100
+++ linux-2.4.19-arm-lsm/arch/arm/kernel/calls.S	2003-02-02 21:06:19.000000000 +0100
@@ -237,7 +237,7 @@
 /* 220 */	.long	SYMBOL_NAME(sys_madvise)
 		.long	SYMBOL_NAME(sys_fcntl64)
 		.long	SYMBOL_NAME(sys_ni_syscall) /* TUX */
-		.long	SYMBOL_NAME(sys_ni_syscall) /* Security */
+		.long	SYMBOL_NAME(sys_security_selinux_wrapper) /* Security */
 		.long	SYMBOL_NAME(sys_gettid)
 /* 225 */	.long	SYMBOL_NAME(sys_readahead)
 __syscall_end:
diff -ruN linux-2.4.19-arm/arch/arm/kernel/entry-common.S linux-2.4.19-arm-lsm/arch/arm/kernel/entry-common.S
--- linux-2.4.19-arm/arch/arm/kernel/entry-common.S	2002-02-25 20:37:52.000000000 +0100
+++ linux-2.4.19-arm-lsm/arch/arm/kernel/entry-common.S	2003-02-05 01:20:31.000000000 +0100
@@ -216,6 +216,10 @@
 		add	r3, sp, #S_OFF
 		b	SYMBOL_NAME(sys_execve)
 
+sys_security_selinux_wrapper:
+		add	r3, sp, #S_OFF
+		b	SYMBOL_NAME(sys_security_selinux_worker)
+
 sys_clone_wapper:
 		add	r2, sp, #S_OFF
 		b	SYMBOL_NAME(sys_clone)
diff -ruN linux-2.4.19-arm/security/selinux/arch/arm/Makefile linux-2.4.19-arm-lsm/security/selinux/arch/arm/Makefile
--- linux-2.4.19-arm/security/selinux/arch/arm/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.19-arm-lsm/security/selinux/arch/arm/Makefile	2003-02-02 20:53:33.000000000 +0100
@@ -0,0 +1,8 @@
+O_TARGET := security.o
+
+obj-y := wrapper.o
+
+EXTRA_CFLAGS += -I../../include 
+
+include $(TOPDIR)/Rules.make
+
diff -ruN linux-2.4.19-arm/security/selinux/arch/arm/wrapper.c linux-2.4.19-arm-lsm/security/selinux/arch/arm/wrapper.c
--- linux-2.4.19-arm/security/selinux/arch/arm/wrapper.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.19-arm-lsm/security/selinux/arch/arm/wrapper.c	2003-02-02 21:12:12.000000000 +0100
@@ -0,0 +1,30 @@
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include "../../selinux_plug.h"
+
+long sys_execve_secure(const char *path,
+		       char **argv,
+		       char **envp,
+		       security_id_t sid,
+		       struct pt_regs *regp)
+{
+	int error;
+	char * filename;
+	struct task_security_struct *tsec;
+
+	tsec = current->security;
+
+	filename = getname(path);
+	error = PTR_ERR(filename);
+	if (IS_ERR(filename))
+		goto out;
+	tsec->in_sid[0] = sid;
+	error = do_execve(filename, argv, envp, regp);
+	tsec->in_sid[0] = 0;
+	if (error == 0)
+		current->ptrace &= ~PT_DTRACE;
+	putname(filename);
+out:
+	return error;
+}
diff -ruN linux-2.4.19-arm/security/selinux/include/asm-arm/flask/syscallaccess.h linux-2.4.19-arm-lsm/security/selinux/include/asm-arm/flask/syscallaccess.h
--- linux-2.4.19-arm/security/selinux/include/asm-arm/flask/syscallaccess.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.19-arm-lsm/security/selinux/include/asm-arm/flask/syscallaccess.h	2003-02-05 01:16:50.000000000 +0100
@@ -0,0 +1,25 @@
+/* -*- linux-c -*- */
+
+#ifndef _ASM_FLASK_SYSCALLACCESS_H_
+#define _ASM_FLASK_SYSCALLACCESS_H_
+
+extern void *sys_call_table[];
+
+#define SELINUX_SYSCALL_GET(x) sys_call_table[x]
+#define SELINUX_SYSCALL_SET(x, y)
+
+#define SECURITY_SELINUX_OR_WORKER \
+asmlinkage int sys_security_selinux_worker(unsigned int magic, \
+                                 unsigned int call, \
+                                 unsigned long* args, \
+                                 struct pt_regs* regp)
+
+#define SECURITY_EXECVE_SECURE sys_execve_secure((char *)a0, (char**)a1, \
+                                        (char**)a[2], a[3], regp)
+
+extern long sys_execve_secure(const char *path,
+			      char **argv,
+			      char **envp,
+			      security_id_t sid,
+			      struct pt_regs *regp);
+#endif

--Boundary-00=_fRZQ+XLKm/8TLJg--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
