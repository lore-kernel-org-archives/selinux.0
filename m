Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2VHJxx6011049
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2003 12:19:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2VHGMSl021013
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2003 17:16:22 GMT
Received: from facesaver.epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h2VHGLFL021010
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2003 17:16:22 GMT
Received: from moss-shockers.ncsc.mil (moss-shockers [144.51.25.21])
	by facesaver.epoch.ncsc.mil (8.12.8/8.12.8) with SMTP id h2VHJuNL017564
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2003 12:19:57 -0500 (EST)
Message-Id: <200303311727.MAA12371@moss-shockers.ncsc.mil>
Date: Mon, 31 Mar 2003 12:27:37 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Using kernel SID (kernel_t domain) in reparent_to_init
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY=Pack_of_Dogs_057_000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Pack_of_Dogs_057_000
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: Hwk+Y3HoMOn8KQNqqt9PEQ==


Re-send, since the original message seems to have been dropped.

------------- Begin Forwarded Message -------------

Date: Fri, 28 Mar 2003 16:22:07 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Using kernel SID (kernel_t domain) in reparent_to_init
To: selinux@tycho.nsa.gov
Mime-Version: 1.0


Stephen Smalley wrote:
> The attached patch for lsm-2.4 changes
> SELinux to use the kernel SID for both reparent_to_init and kmod for
> consistency.  This will require corresponding updates to the policy to
> fold the kmod_t domain into kernel_t.  This change also means that
> certain permissions currently granted to init_t can be moved into
> kernel_t.

The attached patch for selinux/policy folds the kmod_t domain into
kernel_t and removes every_domain from kernel_t.  kmod.te can then be
removed.  These changes have also been committed to the sourceforge CVS
tree.  On a different note, I would think that the .te files in domains/misc 
except for kernel.te should be moved into unused.

------------- End Forwarded Message -------------


--
Stephen Smalley, NSA


--Pack_of_Dogs_057_000
Content-Type: TEXT/plain; name="kthreadpolicy.patch"; charset=us-ascii
Content-Description: kthreadpolicy.patch
Content-MD5: psCoVQ2WerKdlwxHmGvHYQ==

Index: selinux/policy/assert.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux/policy/assert.te,v
retrieving revision 1.6
diff -u -r1.6 assert.te
--- selinux/policy/assert.te	26 Mar 2003 17:25:41 -0000	1.6
+++ selinux/policy/assert.te	28 Mar 2003 20:31:47 -0000
@@ -27,10 +27,10 @@
 neverallow domain ~domain:process transition;
 
 #
-# Verify that only the kmod_t, insmod_t, ifconfig_t, and kernel_t domains 
+# Verify that only the insmod_t, ifconfig_t, and kernel_t domains 
 # have the sys_module capability.
 #
-neverallow ~{ kmod_t insmod_t ifconfig_t kernel_t } self:capability sys_module;
+neverallow ~{ insmod_t ifconfig_t kernel_t } self:capability sys_module;
 
 #
 # Verify that executable types, the system dynamic loaders, and the
@@ -70,7 +70,7 @@
 #
 neverallow ~{ initrc_t admin kernel_t insmod_t } sysctl_t:file { write append };
 neverallow ~{ initrc_t admin } sysctl_fs_t:file { write append };
-neverallow ~{ init_t initrc_t admin kernel_t kmod_t insmod_t } sysctl_kernel_t:file { write append };
+neverallow ~{ init_t initrc_t admin kernel_t insmod_t } sysctl_kernel_t:file { write append };
 neverallow ~{ initrc_t admin } sysctl_net_t:file { write append };
 neverallow ~{ initrc_t admin } sysctl_net_unix_t:file { write append };
 neverallow ~{ initrc_t admin } sysctl_vm_t:file { write append };
Index: selinux/policy/initial_sid_contexts
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux/policy/initial_sid_contexts,v
retrieving revision 1.4
diff -u -r1.4 initial_sid_contexts
--- selinux/policy/initial_sid_contexts	13 Dec 2002 20:55:43 -0000	1.4
+++ selinux/policy/initial_sid_contexts	28 Mar 2003 20:31:47 -0000
@@ -27,7 +27,7 @@
 sid sysctl_net_unix	system_u:object_r:sysctl_net_unix_t
 sid sysctl_vm	system_u:object_r:sysctl_vm_t
 sid sysctl_dev	system_u:object_r:sysctl_dev_t
-sid kmod	system_u:system_r:kmod_t
+sid kmod	system_u:system_r:kernel_t
 sid policy	system_u:object_r:policy_config_t
 sid scmp_packet	system_u:system_r:scmp_packet_t
 
Index: selinux/policy/domains/program/modutil.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux/policy/domains/program/modutil.te,v
retrieving revision 1.14
diff -u -r1.14 modutil.te
--- selinux/policy/domains/program/modutil.te	28 Mar 2003 14:33:50 -0000	1.14
+++ selinux/policy/domains/program/modutil.te	28 Mar 2003 20:31:48 -0000
@@ -108,6 +108,8 @@
 
 uses_shlib(insmod_t)
 
+allow insmod_t initctl_t:fifo_file rw_file_perms;
+
 #################################
 #
 # Rules for the update_modules_t domain.
Index: selinux/policy/domains/misc/kernel.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux/policy/domains/misc/kernel.te,v
retrieving revision 1.5
retrieving revision 1.7
diff -u -r1.5 -r1.7
--- selinux/policy/domains/misc/kernel.te	16 Jan 2003 14:05:50 -0000	1.5
+++ selinux/policy/domains/misc/kernel.te	28 Mar 2003 21:06:17 -0000	1.7
@@ -8,19 +8,21 @@
 #
 
 #
-# kernel_t is the domain of process 0 and the kernel
-# threads started by it. It is also the target type
-# when checking permissions in the system class.
+# kernel_t is the domain of kernel threads.
+# It is also the target type when checking permissions in the system class.
 # 
 type kernel_t, domain;
 role system_r types kernel_t;
-every_domain(kernel_t)
+general_domain_access(kernel_t)
+general_proc_read_access(kernel_t)
+base_file_read_access(kernel_t)
+uses_shlib(kernel_t)
 
 # Use capabilities.
-allow kernel_t self:capability { setuid dac_override sys_admin mknod sys_module };
+allow kernel_t self:capability *;
 
 # Run init in the init_t domain.
-domain_auto_trans(kernel_t, init_exec_t, init_t)
+domain_auto_trans_read(kernel_t, init_exec_t, init_t)
 
 # Share state with the init process.
 allow kernel_t init_t:process share;
@@ -35,6 +37,7 @@
 allow kernel_t domain:process signal;
 
 # Access the console.
+allow kernel_t device_t:dir search;
 allow kernel_t console_device_t:chr_file rw_file_perms;
 
 # Access the initrd filesystem.
@@ -55,4 +58,11 @@
 
 # Reload the policy from the real root.
 allow kernel_t security_t:security load_policy;
+
+# Run insmod (for kernel module loader).
+domain_auto_trans_read(kernel_t,insmod_exec_t,insmod_t)
+
+# /proc/sys/kernel/modprobe is set to /bin/true if not using modules.
+can_exec(kernel_t, bin_t)
+
 

--Pack_of_Dogs_057_000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
