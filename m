Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA9IhtIi024790
	for <selinux@tycho.nsa.gov>; Tue, 9 Nov 2004 13:43:55 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA9IgWxp001923
	for <selinux@tycho.nsa.gov>; Tue, 9 Nov 2004 18:42:32 GMT
Subject: [RFC][PATCH] Control ability to have a writable executable mapping
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: multipart/mixed; boundary="=-sf5ritlI66rNO8VEowku"
Message-Id: <1100025603.408.203.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 09 Nov 2004 13:40:03 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-sf5ritlI66rNO8VEowku
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

At present, SELinux only applies permission checks to mmap/mprotect for
file mappings, and it only checks write permission to the file if the
mapping is shared, as the caller does not truly require write permission
to the file for a private copy-on-write mapping nor would we want to
grant write permission to all processes that perform such mappings. 
Consequently, SELinux does not currently provide policy control over the
ability of a process to have a writable executable anonymous mapping or
a writable executable private file mapping.  

The attached kernel patch adds a new task->self wxpage permission check
for wx private file mappings and for wx anonymous mappings to address
this gap.  The task->file execute permission check is still applied to
private file mappings even when the wxpage check is performed for
consistency (ensure that policy always allows rx mapping whenever it
allows rwx mapping).  There is also a small change to avc_audit() to
help in policy debugging for these checks, as the exe= information is
suppressed due to the mmap_sem being held by the caller.  Note that
writable executable shared file mappings are still controlled based on
the file write and execute permission checks, not this new check.

The attached policy patch excludes wxpage permission from the
general_domain_access() macro so that it will not be allowed by default
to most domains and adds the wxpage permission selectively to a few
domains based on very preliminary experimentation with this new check. 
You may also find it necessary to uncomment the rule added to
base_user_macros.te by the patch to allow user domains this permission,
as they will otherwise be unable to load DSOs that require an executable
stack (e.g. preliminary experimentation with this check prevented many
gnome applications from running at all due to the inability to load a
particular DSO).

I know that the PAX/selinux integration patch approaches this
differently, applying a check based on the executable file type rather
than the process domain, but I would favor a domain-based check for its
greater generality (ability to handle multiple instances of the same
program in different ways) and more direct representation of the actual
operation (can this process perform this action?).  Admittedly, the
domain-based check does impose a cost on policy writers - you have to
define separate domains vs. just separate file types in order to
selectively allow this permission.  But I believe that this cost is
justified.

Please note that this patch does NOT provide the functionality of PAX,
exec-shield, NX support, etc.  It merely provides SELinux policy control
over the ability to create an executable mapping that can contain data
not covered by file permission checks.

Constructive comments welcome.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-sf5ritlI66rNO8VEowku
Content-Disposition: attachment; filename=sel-wxpage.patch
Content-Type: text/x-patch; name=sel-wxpage.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6/security/selinux/avc.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/avc.c,v
retrieving revision 1.47
diff -u -p -r1.47 avc.c
--- linux-2.6/security/selinux/avc.c	27 Oct 2004 20:09:53 -0000	1.47
+++ linux-2.6/security/selinux/avc.c	8 Nov 2004 21:20:29 -0000
@@ -576,6 +576,8 @@ void avc_audit(u32 ssid, u32 tsid,
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
diff -u -p -r1.132 hooks.c
--- linux-2.6/security/selinux/hooks.c	25 Oct 2004 12:51:44 -0000	1.132
+++ linux-2.6/security/selinux/hooks.c	8 Nov 2004 20:22:41 -0000
@@ -2441,6 +2441,8 @@ static int selinux_file_ioctl(struct fil
 
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
 {
+	int rc;
+
 	if (file) {
 		/* read access is always possible with a mapping */
 		u32 av = FILE__READ;
@@ -2448,12 +2450,29 @@ static int file_map_prot_check(struct fi
 		/* write access only matters if the mapping is shared */
 		if (shared && (prot & PROT_WRITE))
 			av |= FILE__WRITE;
-
-		if (prot & PROT_EXEC)
+	
+		if (prot & PROT_EXEC) {
 			av |= FILE__EXECUTE;
+			/*
+			 * Check ability to have a writable executable 
+			 * mapping.  In the shared mapping case, this 
+			 * is covered by the file-based checks. 
+			 */
+			if (!shared && (prot & PROT_WRITE)) {
+				rc = task_has_perm(current, current, PROCESS__WXPAGE);
+				if (rc)
+					return rc;
+				/* fall through to file-based checks */
+			}
+		}
 
 		return file_has_perm(current, file, av);
+	} else {
+		/* Check ability to have a writable executable mapping. */ 
+		if ((prot & PROT_EXEC) && (prot & PROT_WRITE))
+			return task_has_perm(current, current, PROCESS__WXPAGE);
 	}
+
 	return 0;
 }
 
Index: linux-2.6/security/selinux/include/av_perm_to_string.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_perm_to_string.h,v
retrieving revision 1.15
diff -u -p -r1.15 av_perm_to_string.h
--- linux-2.6/security/selinux/include/av_perm_to_string.h	5 Oct 2004 17:35:29 -0000	1.15
+++ linux-2.6/security/selinux/include/av_perm_to_string.h	8 Nov 2004 20:22:41 -0000
@@ -62,6 +62,7 @@
    S_(SECCLASS_PROCESS, PROCESS__SIGINH, "siginh")
    S_(SECCLASS_PROCESS, PROCESS__SETRLIMIT, "setrlimit")
    S_(SECCLASS_PROCESS, PROCESS__RLIMITINH, "rlimitinh")
+   S_(SECCLASS_PROCESS, PROCESS__WXPAGE, "wxpage")
    S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
    S_(SECCLASS_MSG, MSG__SEND, "send")
    S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
Index: linux-2.6/security/selinux/include/av_permissions.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_permissions.h,v
retrieving revision 1.14
diff -u -p -r1.14 av_permissions.h
--- linux-2.6/security/selinux/include/av_permissions.h	5 Oct 2004 17:35:29 -0000	1.14
+++ linux-2.6/security/selinux/include/av_permissions.h	8 Nov 2004 20:22:41 -0000
@@ -456,6 +456,7 @@
 #define PROCESS__SIGINH                           0x00100000UL
 #define PROCESS__SETRLIMIT                        0x00200000UL
 #define PROCESS__RLIMITINH                        0x00400000UL
+#define PROCESS__WXPAGE                           0x00800000UL
 
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL

--=-sf5ritlI66rNO8VEowku
Content-Disposition: attachment; filename=policy-wxpage.patch
Content-Type: text/x-patch; name=policy-wxpage.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policy/domains/program/modutil.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/modutil.te,v
retrieving revision 1.25
diff -u -r1.25 modutil.te
--- policy/domains/program/modutil.te	8 Nov 2004 20:58:16 -0000	1.25
+++ policy/domains/program/modutil.te	9 Nov 2004 17:26:28 -0000
@@ -123,7 +123,7 @@
 allow insmod_t self:rawip_socket create_socket_perms;
 allow insmod_t self:capability { dac_override kill net_raw sys_module sys_tty_config };
 allow insmod_t domain:process signal;
-allow insmod_t self:process { fork signal_perms };
+allow insmod_t self:process { fork signal_perms wxpage };
 allow insmod_t device_t:dir search;
 allow insmod_t etc_runtime_t:file { getattr read };
 
Index: policy/domains/program/unused/prelink.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/prelink.te,v
retrieving revision 1.14
diff -u -r1.14 prelink.te
--- policy/domains/program/unused/prelink.te	8 Nov 2004 20:58:18 -0000	1.14
+++ policy/domains/program/unused/prelink.te	9 Nov 2004 17:26:29 -0000
@@ -11,6 +11,8 @@
 #
 daemon_base_domain(prelink, `, admin')
 
+allow prelink_t self:process wxpage;
+
 allow prelink_t fs_t:filesystem getattr;
 
 ifdef(`crond.te', `
Index: policy/domains/program/unused/udev.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/udev.te,v
retrieving revision 1.32
diff -u -r1.32 udev.te
--- policy/domains/program/unused/udev.te	8 Nov 2004 20:58:19 -0000	1.32
+++ policy/domains/program/unused/udev.te	9 Nov 2004 17:26:29 -0000
@@ -13,6 +13,9 @@
 
 general_domain_access(udev_t)
 
+# Why?
+allow udev_t self:process wxpage;
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
+++ policy/flask/access_vectors	8 Nov 2004 16:27:39 -0000
@@ -240,6 +240,7 @@
 	siginh
 	setrlimit
 	rlimitinh
+	wxpage
 }
 
 
Index: policy/macros/base_user_macros.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/base_user_macros.te,v
retrieving revision 1.34
diff -u -r1.34 base_user_macros.te
--- policy/macros/base_user_macros.te	8 Nov 2004 20:58:20 -0000	1.34
+++ policy/macros/base_user_macros.te	9 Nov 2004 17:45:54 -0000
@@ -33,6 +33,9 @@
 # Grant permissions within the domain.
 general_domain_access($1_t);
 
+# Uncomment to allow loading DSOs that require executable stack.
+#allow $1_t self:process wxpage;
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
+++ policy/macros/core_macros.te	9 Nov 2004 17:26:31 -0000
@@ -617,9 +617,9 @@
 #
 define(`general_domain_access',`
 # Access other processes in the same domain.
-# Omits ptrace, setexec, and setfscreate.  These must be granted 
-# separately if desired.
-allow $1 self:process ~{ptrace setexec setfscreate setrlimit};
+# Omits ptrace, setexec, setfscreate, setrlimit, and wxpage.  
+# These must be granted separately if desired.
+allow $1 self:process ~{ptrace setexec setfscreate setrlimit wxpage};
 
 # Access /proc/PID files for processes in the same domain.
 allow $1 self:dir r_dir_perms;
Index: policy/macros/program/xserver_macros.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/program/xserver_macros.te,v
retrieving revision 1.37
diff -u -r1.37 xserver_macros.te
--- policy/macros/program/xserver_macros.te	8 Nov 2004 20:58:21 -0000	1.37
+++ policy/macros/program/xserver_macros.te	9 Nov 2004 17:26:31 -0000
@@ -56,6 +56,8 @@
 # for access within the domain
 general_domain_access($1_xserver_t)
 
+allow $1_xserver_t self:process wxpage;
+
 allow $1_xserver_t etc_runtime_t:file { getattr read };
 
 ifelse($1, xdm, `

--=-sf5ritlI66rNO8VEowku--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
