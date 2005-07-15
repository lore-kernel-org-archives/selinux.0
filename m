Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6FKD2gA014368
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 16:13:02 -0400 (EDT)
Received: from e2.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6FK9PrE022565
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 20:09:25 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j6FK9QXV000561
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 16:09:26 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j6FK9Q7d222780
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 16:09:26 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j6FK9Qtv004844
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 16:09:26 -0400
Message-ID: <42D817ED.9000009@us.ibm.com>
Date: Fri, 15 Jul 2005 16:09:17 -0400
From: Janak Desai <janak@us.ibm.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, janak@us.ibm.com
Subject: [PATCH 2/2] unshare system call patch - needed to test pam_namespace
Content-Type: multipart/mixed;
 boundary="------------090509000008030500060603"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090509000008030500060603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is part of the unshare system call patch. This one implements
system call for i386 arch. I do have suggestion for code change for
some other architectures, but since I haven't tested them I haven't
included in the patch.

-Janak

--------------090509000008030500060603
Content-Type: text/plain;
 name="justi2-fsdevel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="justi2-fsdevel"



[PATCH 2/2] unshare system call: System Call setup for i386 arch


Signed-off-by: Janak Desai

-----------------------------------------------------------------------

--------------090509000008030500060603
Content-Type: text/plain;
 name="p2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="p2.patch"

diff -Naurp linux-2.6.12/arch/i386/kernel/syscall_table.S linux-2.6.12-unshare-p2/arch/i386/kernel/syscall_table.S
--- linux-2.6.12/arch/i386/kernel/syscall_table.S	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12-unshare-p2/arch/i386/kernel/syscall_table.S	2005-06-22 13:20:44.000000000 +0000
@@ -289,3 +289,4 @@ ENTRY(sys_call_table)
 	.long sys_add_key
 	.long sys_request_key
 	.long sys_keyctl
+	.long sys_unshare
diff -Naurp linux-2.6.12/include/asm-i386/unistd.h linux-2.6.12-unshare-p2/include/asm-i386/unistd.h
--- linux-2.6.12/include/asm-i386/unistd.h	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12-unshare-p2/include/asm-i386/unistd.h	2005-06-22 13:22:22.000000000 +0000
@@ -294,8 +294,9 @@
 #define __NR_add_key		286
 #define __NR_request_key	287
 #define __NR_keyctl		288
+#define __NR_unshare		289
 
-#define NR_syscalls 289
+#define NR_syscalls 290
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
diff -Naurp linux-2.6.12/include/linux/syscalls.h linux-2.6.12-unshare-p2/include/linux/syscalls.h
--- linux-2.6.12/include/linux/syscalls.h	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12-unshare-p2/include/linux/syscalls.h	2005-06-22 13:24:09.000000000 +0000
@@ -505,4 +505,6 @@ asmlinkage long sys_request_key(const ch
 asmlinkage long sys_keyctl(int cmd, unsigned long arg2, unsigned long arg3,
 			   unsigned long arg4, unsigned long arg5);
 
+asmlinkage long sys_unshare(unsigned long unshare_flags);
+
 #endif

--------------090509000008030500060603--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
