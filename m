Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h83GVCLa028097
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 12:31:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h83GVAev006266
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 16:31:11 GMT
Date: Wed, 3 Sep 2003 12:31:04 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Tom <tom@lemuria.org>
cc: SELinux Mail List <selinux@tycho.nsa.gov>,
   Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Enable SELinux via boot parameter
In-Reply-To: <20030903145423.D3990@lemuria.org>
Message-ID: <Pine.LNX.4.44.0309031217030.15283-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Sep 2003, Tom wrote:

> I'd love to have a way to ensure that if _this_ kernel was booted, it
> _does_ use SE.


Ok, the patch below (against 2.6.0-test4-mm5) makes the boot parameter a 
configuration option (defaulting to N).  Also, the logic is inverted so 
that even with the option enabled, you have to use selinux=0 to bypass 
SELinux.

This seems to be a safer approach: two explicit actions (one compile time
and one runtime) are thus required to disable SELinux if it has been
configured for the kernel image.

This should also address the consistency issue where various kernels may
or may not provide the boot parameter option (i.e. you will never need to 
use selinux=1 to enable SELinux).

Comments?

- James
-- 
James Morris
<jmorris@redhat.com>

diff -urN -X dontdiff linux-2.6.0-test4-mm5.orig/security/selinux/hooks.c linux-2.6.0-test4-mm5.w1/security/selinux/hooks.c
--- linux-2.6.0-test4-mm5.orig/security/selinux/hooks.c	2003-09-04 01:48:01.000000000 +1000
+++ linux-2.6.0-test4-mm5.w1/security/selinux/hooks.c	2003-09-04 02:08:21.340250584 +1000
@@ -73,7 +73,8 @@
 __setup("enforcing=", enforcing_setup);
 #endif
 
-int selinux_enabled = 0;
+#ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
+int selinux_enabled = 1;
 
 static int __init selinux_enabled_setup(char *str)
 {
@@ -81,6 +82,7 @@
 	return 1;
 }
 __setup("selinux=", selinux_enabled_setup);
+#endif
 
 /* Original (dummy) security module. */
 static struct security_operations *original_ops = NULL;
@@ -3357,7 +3359,7 @@
 	struct task_security_struct *tsec;
 
 	if (!selinux_enabled) {
-		printk(KERN_INFO "SELinux:  Not enabled at boot.\n");
+		printk(KERN_INFO "SELinux:  Disabled at boot.\n");
 		return 0;
 	}
 
diff -urN -X dontdiff linux-2.6.0-test4-mm5.orig/security/selinux/include/security.h linux-2.6.0-test4-mm5.w1/security/selinux/include/security.h
--- linux-2.6.0-test4-mm5.orig/security/selinux/include/security.h	2003-08-11 01:06:37.000000000 +1000
+++ linux-2.6.0-test4-mm5.w1/security/selinux/include/security.h	2003-09-04 02:03:53.000000000 +1000
@@ -14,6 +14,12 @@
 
 #define SELINUX_MAGIC 0xf97cff8c
 
+#ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
+extern int selinux_enabled;
+#else
+#define selinux_enabled 1
+#endif
+
 int security_load_policy(void * data, size_t len);
 
 struct av_decision {
diff -urN -X dontdiff linux-2.6.0-test4-mm5.orig/security/selinux/Kconfig linux-2.6.0-test4-mm5.w1/security/selinux/Kconfig
--- linux-2.6.0-test4-mm5.orig/security/selinux/Kconfig	2003-09-04 01:48:01.000000000 +1000
+++ linux-2.6.0-test4-mm5.w1/security/selinux/Kconfig	2003-09-04 02:11:35.884675336 +1000
@@ -8,11 +8,22 @@
 	  You can obtain the policy compiler (checkpolicy), the utility for
 	  labeling filesystems (setfiles), and an example policy configuration
 	  from http://www.nsa.gov/selinux.
-	  SELinux needs to be explicitly enabled on the kernel command line with
-	  selinux=1.  If you specify selinux=0 or do not use this parameter,
-	  SELinux will not be enabled.
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_SELINUX_BOOTPARAM
+	bool "NSA SELinux boot parameter"
+	depends on SECURITY_SELINUX
+	default n
+	help
+	  This option adds a kernel parameter 'selinux', which allows SELinux
+	  to be disabled at boot.  If this option is selected, SELinux
+	  functionality can be disabled with selinux=0 on the kernel
+	  command line.  The purpose of this option is to allow a single
+	  kernel image to be distributed with SELinux built in, but not
+	  necessarily enabled.
+	  
+	  If you are unsure how to answer this question, answer N.
+	  
 config SECURITY_SELINUX_DEVELOP
 	bool "NSA SELinux Development Support"
 	depends on SECURITY_SELINUX
diff -urN -X dontdiff linux-2.6.0-test4-mm5.orig/security/selinux/selinuxfs.c linux-2.6.0-test4-mm5.w1/security/selinux/selinuxfs.c
--- linux-2.6.0-test4-mm5.orig/security/selinux/selinuxfs.c	2003-09-04 01:48:01.000000000 +1000
+++ linux-2.6.0-test4-mm5.w1/security/selinux/selinuxfs.c	2003-09-04 01:53:58.000000000 +1000
@@ -17,8 +17,6 @@
 #include "security.h"
 #include "objsec.h"
 
-extern int selinux_enabled;
-
 /* Check whether a task is allowed to use a security operation. */
 int task_has_security(struct task_struct *tsk,
 		      u32 perms)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
