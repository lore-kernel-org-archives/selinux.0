Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAAFd1Ii000308
	for <selinux@tycho.nsa.gov>; Wed, 10 Nov 2004 10:39:01 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAAFbbLW026717
	for <selinux@tycho.nsa.gov>; Wed, 10 Nov 2004 15:37:37 GMT
Subject: Re: [RFC][PATCH] Control ability to have a writable executable
	mapping
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <1100034309.408.278.camel@moss-spartans.epoch.ncsc.mil>
References: <1100025603.408.203.camel@moss-spartans.epoch.ncsc.mil>
	 <1100034309.408.278.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-WkSZIOGoSTY3YZrYK1QQ"
Message-Id: <1100100906.1972.198.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 10 Nov 2004 10:35:06 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-WkSZIOGoSTY3YZrYK1QQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-11-09 at 16:05, Stephen Smalley wrote:
> Sorry, the last statement isn't accurate; this patch only provides
> SELinux policy control over the ability to have a mapping that is
> simultaneously writable and executable.  One could still create a rw
> mapping and then later change its protection to rx.  For anonymous
> mappings, the patch could be trivially modified to apply the check for
> any PROT_EXEC mapping and thus prevent executable anonymous mappings
> entirely except when explicitly allowed; that seems reasonable.  Private
> file mappings are more problematic.

Ok, based on feedback and some sample code from Roland McGrath (but any
bugs are likely mine), here are revised kernel and policy patches with
the following changes:
- permission name has changed from wxpage to execmem to more accurately
represent the meaning,
- always check this permission for any executable anonymous mapping,
whether presently writable or not,
- check this permission not only for a writable executable private file
mapping, but also for an executable private file mapping that has been
previously written (based on whether a COW has occurred for the
mapping).

This brings the check closer to the goal of controlling the ability to
make executable a mapping that can contain data not covered by file
permission checks.

Constructive comments welcome.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-WkSZIOGoSTY3YZrYK1QQ
Content-Disposition: attachment; filename=sel-execmem.patch
Content-Type: text/x-patch; name=sel-execmem.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6/security/selinux/avc.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/avc.c,v
retrieving revision 1.47
diff -u -r1.47 avc.c
--- linux-2.6/security/selinux/avc.c	27 Oct 2004 20:09:53 -0000	1.47
+++ linux-2.6/security/selinux/avc.c	10 Nov 2004 14:51:22 -0000
@@ -576,6 +576,8 @@
 					vma = vma->vm_next;
 				}
 				up_read(&mm->mmap_sem);
+			} else {
+				audit_log_format(ab, " comm=%s", tsk->comm);
 			}
 			if (tsk != current)
 				mmput(mm);
Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.132
diff -u -r1.132 hooks.c
--- linux-2.6/security/selinux/hooks.c	25 Oct 2004 12:51:44 -0000	1.132
+++ linux-2.6/security/selinux/hooks.c	10 Nov 2004 14:45:22 -0000
@@ -2441,6 +2441,17 @@
 
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
 {
+	if ((prot & PROT_EXEC) && (!file || (!shared && (prot & PROT_WRITE)))) {
+		/*
+		 * We are making executable an anonymous mapping or a
+		 * private file mapping that will be writable or has been 
+		 * written before.  This has an additional check.
+		 */
+		int rc = task_has_perm(current, current, PROCESS__EXECMEM);
+		if (rc)
+			return rc;
+	}
+
 	if (file) {
 		/* read access is always possible with a mapping */
 		u32 av = FILE__READ;
@@ -2478,6 +2489,15 @@
 	if (rc)
 		return rc;
 
+	if (vma->vm_file != NULL && vma->anon_vma != NULL) {
+		/*
+		 * This is a file mapping that has had some COW done.
+		 * Since pages might have been written, apply the check
+		 * for having writable and executable anonymous pages.
+		 */
+		prot |= PROT_WRITE;
+	}
+
 	return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_SHARED);
 }
 
Index: linux-2.6/security/selinux/include/av_perm_to_string.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_perm_to_string.h,v
retrieving revision 1.15
diff -u -r1.15 av_perm_to_string.h
--- linux-2.6/security/selinux/include/av_perm_to_string.h	5 Oct 2004 17:35:29 -0000	1.15
+++ linux-2.6/security/selinux/include/av_perm_to_string.h	10 Nov 2004 14:45:22 -0000
@@ -62,6 +62,7 @@
    S_(SECCLASS_PROCESS, PROCESS__SIGINH, "siginh")
    S_(SECCLASS_PROCESS, PROCESS__SETRLIMIT, "setrlimit")
    S_(SECCLASS_PROCESS, PROCESS__RLIMITINH, "rlimitinh")
+   S_(SECCLASS_PROCESS, PROCESS__EXECMEM, "execmem")
    S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
    S_(SECCLASS_MSG, MSG__SEND, "send")
    S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
Index: linux-2.6/security/selinux/include/av_permissions.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_permissions.h,v
retrieving revision 1.14
diff -u -r1.14 av_permissions.h
--- linux-2.6/security/selinux/include/av_permissions.h	5 Oct 2004 17:35:29 -0000	1.14
+++ linux-2.6/security/selinux/include/av_permissions.h	10 Nov 2004 14:45:22 -0000
@@ -456,6 +456,7 @@
 #define PROCESS__SIGINH                           0x00100000UL
 #define PROCESS__SETRLIMIT                        0x00200000UL
 #define PROCESS__RLIMITINH                        0x00400000UL
+#define PROCESS__EXECMEM                          0x00800000UL
 
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL

--=-WkSZIOGoSTY3YZrYK1QQ
Content-Disposition: attachment; filename=policy-execmem.patch
Content-Type: text/x-patch; name=policy-execmem.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policy/domains/program/modutil.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/modutil.te,v
retrieving revision 1.25
diff -u -r1.25 modutil.te
--- policy/domains/program/modutil.te	8 Nov 2004 20:58:16 -0000	1.25
+++ policy/domains/program/modutil.te	10 Nov 2004 15:02:16 -0000
@@ -123,7 +123,7 @@
 allow insmod_t self:rawip_socket create_socket_perms;
 allow insmod_t self:capability { dac_override kill net_raw sys_module sys_tty_config };
 allow insmod_t domain:process signal;
-allow insmod_t self:process { fork signal_perms };
+allow insmod_t self:process { fork signal_perms execmem };
 allow insmod_t device_t:dir search;
 allow insmod_t etc_runtime_t:file { getattr read };
 
Index: policy/domains/program/unused/prelink.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/prelink.te,v
retrieving revision 1.14
diff -u -r1.14 prelink.te
--- policy/domains/program/unused/prelink.te	8 Nov 2004 20:58:18 -0000	1.14
+++ policy/domains/program/unused/prelink.te	10 Nov 2004 15:02:38 -0000
@@ -11,6 +11,8 @@
 #
 daemon_base_domain(prelink, `, admin')
 
+allow prelink_t self:process execmem;
+
 allow prelink_t fs_t:filesystem getattr;
 
 ifdef(`crond.te', `
Index: policy/domains/program/unused/udev.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/udev.te,v
retrieving revision 1.32
diff -u -r1.32 udev.te
--- policy/domains/program/unused/udev.te	8 Nov 2004 20:58:19 -0000	1.32
+++ policy/domains/program/unused/udev.te	10 Nov 2004 15:02:47 -0000
@@ -13,6 +13,9 @@
 
 general_domain_access(udev_t)
 
+# Why?
+allow udev_t self:process execmem;
+
 etc_domain(udev)
 typealias udev_etc_t alias etc_udev_t;
 type udev_helper_exec_t, file_type, sysadmfile, exec_type;
Index: policy/flask/access_vectors
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/flask/access_vectors,v
retrieving revision 1.13
diff -u -r1.13 access_vectors
--- policy/flask/access_vectors	9 Sep 2004 12:01:52 -0000	1.13
+++ policy/flask/access_vectors	10 Nov 2004 12:15:55 -0000
@@ -240,6 +240,7 @@
 	siginh
 	setrlimit
 	rlimitinh
+	execmem	
 }
 
 
Index: policy/macros/base_user_macros.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/base_user_macros.te,v
retrieving revision 1.34
diff -u -r1.34 base_user_macros.te
--- policy/macros/base_user_macros.te	8 Nov 2004 20:58:20 -0000	1.34
+++ policy/macros/base_user_macros.te	10 Nov 2004 14:54:00 -0000
@@ -33,6 +33,9 @@
 # Grant permissions within the domain.
 general_domain_access($1_t);
 
+# Uncomment to allow loading DSOs that require executable stack.
+#allow $1_t self:process execmem;
+
 #
 # kdeinit wants this access
 #
Index: policy/macros/core_macros.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/core_macros.te,v
retrieving revision 1.24
diff -u -r1.24 core_macros.te
--- policy/macros/core_macros.te	8 Nov 2004 20:58:20 -0000	1.24
+++ policy/macros/core_macros.te	10 Nov 2004 14:54:14 -0000
@@ -617,9 +617,9 @@
 #
 define(`general_domain_access',`
 # Access other processes in the same domain.
-# Omits ptrace, setexec, and setfscreate.  These must be granted 
-# separately if desired.
-allow $1 self:process ~{ptrace setexec setfscreate setrlimit};
+# Omits ptrace, setexec, setfscreate, setrlimit, and execmem.  
+# These must be granted separately if desired.
+allow $1 self:process ~{ptrace setexec setfscreate setrlimit execmem};
 
 # Access /proc/PID files for processes in the same domain.
 allow $1 self:dir r_dir_perms;
Index: policy/macros/program/xserver_macros.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/program/xserver_macros.te,v
retrieving revision 1.37
diff -u -r1.37 xserver_macros.te
--- policy/macros/program/xserver_macros.te	8 Nov 2004 20:58:21 -0000	1.37
+++ policy/macros/program/xserver_macros.te	10 Nov 2004 15:02:22 -0000
@@ -56,6 +56,8 @@
 # for access within the domain
 general_domain_access($1_xserver_t)
 
+allow $1_xserver_t self:process execmem;
+
 allow $1_xserver_t etc_runtime_t:file { getattr read };
 
 ifelse($1, xdm, `

--=-WkSZIOGoSTY3YZrYK1QQ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
