Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h82NkGLa020466
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 19:46:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h82NiipQ022296
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 23:44:44 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id h82NihQX022293
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 23:44:43 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id h82NkDl01987
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 19:46:14 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.64.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h82NkCs16286
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 19:46:12 -0400
Received: from thoron.boston.redhat.com (thoron.boston.redhat.com [172.16.65.238])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id h82NkBkA019063
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 19:46:12 -0400
Date: Tue, 2 Sep 2003 19:46:11 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: selinux@tycho.nsa.gov
Subject: Enable SELinux via boot parameter
Message-ID: <Pine.LNX.4.44.0309021942550.11746-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch against 2.6.0-test4 adds an 'selinux' boot parameter which must 
be used to actually enable SELinux.  It has been sent to Andrew Morton and 
is also in the NSA tree.

The purpose of the patch is to allow a vendor to ship a single kernel
image with SELinux built-in, without requiring the user to use it.

Without specifying selinux=1 as a boot parameter, SELinux will not
register with LSM and selinuxfs will not be registered as a filesystem.  
This causes SELinux to be bypassed entirely from then on, and no
performance overhead is imposed.  Other security modules may then also be 
loaded if needed.


- James
-- 
James Morris
<jmorris@redhat.com>

diff -urN -X dontdiff linux-2.6.0-test4.orig/security/selinux/hooks.c linux-2.6.0-test4.w1/security/selinux/hooks.c
--- linux-2.6.0-test4.orig/security/selinux/hooks.c	2003-08-23 11:53:14.000000000 +1000
+++ linux-2.6.0-test4.w1/security/selinux/hooks.c	2003-09-02 23:28:48.000000000 +1000
@@ -73,6 +73,15 @@
 __setup("enforcing=", enforcing_setup);
 #endif
 
+int selinux_enabled = 0;
+
+static int __init selinux_enabled_setup(char *str)
+{
+	selinux_enabled = simple_strtol(str, NULL, 0);
+	return 1;
+}
+__setup("selinux=", selinux_enabled_setup);
+
 /* Original (dummy) security module. */
 static struct security_operations *original_ops = NULL;
 
@@ -3354,6 +3363,11 @@
 {
 	struct task_security_struct *tsec;
 
+	if (!selinux_enabled) {
+		printk(KERN_INFO "SELinux:  Not enabled at boot.\n");
+		return 0;
+	}
+
 	printk(KERN_INFO "SELinux:  Initializing.\n");
 
 	/* Set the security state for the initial task. */
diff -urN -X dontdiff linux-2.6.0-test4.orig/security/selinux/Kconfig linux-2.6.0-test4.w1/security/selinux/Kconfig
--- linux-2.6.0-test4.orig/security/selinux/Kconfig	2003-08-11 01:06:37.000000000 +1000
+++ linux-2.6.0-test4.w1/security/selinux/Kconfig	2003-09-02 23:40:36.128086552 +1000
@@ -3,11 +3,14 @@
 	depends on SECURITY
 	default n
 	help
-	  This enables NSA Security-Enhanced Linux (SELinux).
+	  This selects NSA Security-Enhanced Linux (SELinux).
 	  You will also need a policy configuration and a labeled filesystem.
 	  You can obtain the policy compiler (checkpolicy), the utility for
 	  labeling filesystems (setfiles), and an example policy configuration
 	  from http://www.nsa.gov/selinux.
+	  SELinux needs to be explicitly enabled on the kernel command line with
+	  selinux=1.  If you specify selinux=0 or do not use this parameter,
+	  SELinux will not be enabled.
 	  If you are unsure how to answer this question, answer N.
 
 config SECURITY_SELINUX_DEVELOP
diff -urN -X dontdiff linux-2.6.0-test4.orig/security/selinux/selinuxfs.c linux-2.6.0-test4.w1/security/selinux/selinuxfs.c
--- linux-2.6.0-test4.orig/security/selinux/selinuxfs.c	2003-08-11 01:06:37.000000000 +1000
+++ linux-2.6.0-test4.w1/security/selinux/selinuxfs.c	2003-09-02 23:23:02.000000000 +1000
@@ -17,6 +17,8 @@
 #include "security.h"
 #include "objsec.h"
 
+extern int selinux_enabled;
+
 /* Check whether a task is allowed to use a security operation. */
 int task_has_security(struct task_struct *tsk,
 		      u32 perms)
@@ -587,7 +589,7 @@
 
 static int __init init_sel_fs(void)
 {
-	return register_filesystem(&sel_fs_type);
+	return selinux_enabled ? register_filesystem(&sel_fs_type) : 0;
 }
 
 __initcall(init_sel_fs);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
