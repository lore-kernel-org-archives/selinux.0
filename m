Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB1H73Ii025659
	for <selinux@tycho.nsa.gov>; Wed, 1 Dec 2004 12:07:03 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB1H5UYO009326
	for <selinux@tycho.nsa.gov>; Wed, 1 Dec 2004 17:05:30 GMT
Subject: Re: [RFC][PATCH] Control ability to have a writable executable
	mapping
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <1100100906.1972.198.camel@moss-spartans.epoch.ncsc.mil>
References: <1100025603.408.203.camel@moss-spartans.epoch.ncsc.mil>
	 <1100034309.408.278.camel@moss-spartans.epoch.ncsc.mil>
	 <1100100906.1972.198.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-XbacDuPtmn8jIOGmyixf"
Message-Id: <1101920545.24332.44.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 01 Dec 2004 12:02:25 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-XbacDuPtmn8jIOGmyixf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-11-10 at 10:35, Stephen Smalley wrote:
> Ok, based on feedback and some sample code from Roland McGrath (but any
> bugs are likely mine), here are revised kernel and policy patches with
> the following changes:
> - permission name has changed from wxpage to execmem to more accurately
> represent the meaning,
> - always check this permission for any executable anonymous mapping,
> whether presently writable or not,
> - check this permission not only for a writable executable private file
> mapping, but also for an executable private file mapping that has been
> previously written (based on whether a COW has occurred for the
> mapping).
> 
> This brings the check closer to the goal of controlling the ability to
> make executable a mapping that can contain data not covered by file
> permission checks.
> 
> Constructive comments welcome.

I've attached the final form of the kernel patch (and a corresponding
policy patch) that is being committed to our tree.  This patch differs
from the previous version in that it splits the single execmem
permission check into two separate permission checks:
1) a task->self execmem check for making executable anonymous mappings
and for making writable executable private file mappings, and
2) a task->file execmod check for making executable previously written
private file mappings (e.g. text relocations).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-XbacDuPtmn8jIOGmyixf
Content-Disposition: attachment; filename=05-execmem.patch
Content-Type: text/x-patch; name=05-execmem.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.139
diff -u -p -r1.139 hooks.c
--- linux-2.6/security/selinux/hooks.c	30 Nov 2004 17:39:08 -0000	1.139
+++ linux-2.6/security/selinux/hooks.c	30 Nov 2004 21:30:04 -0000
@@ -2465,6 +2465,17 @@ static int selinux_file_ioctl(struct fil
 
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
 {
+	if ((prot & PROT_EXEC) && (!file || (!shared && (prot & PROT_WRITE)))) {
+		/*
+		 * We are making executable an anonymous mapping or a
+		 * private file mapping that will also be writable.
+		 * This has an additional check.
+		 */
+		int rc = task_has_perm(current, current, PROCESS__EXECMEM);
+		if (rc)
+			return rc;
+	}
+
 	if (file) {
 		/* read access is always possible with a mapping */
 		u32 av = FILE__READ;
@@ -2502,6 +2513,18 @@ static int selinux_file_mprotect(struct 
 	if (rc)
 		return rc;
 
+	if (vma->vm_file != NULL && vma->anon_vma != NULL && (prot & PROT_EXEC)) {
+		/*
+		 * We are making executable a file mapping that has 
+		 * had some COW done. Since pages might have been written, 
+		 * check ability to execute the possibly modified content.
+		 * This typically should only occur for text relocations.
+		 */
+		int rc = file_has_perm(current, vma->vm_file, FILE__EXECMOD);
+		if (rc)
+			return rc;		
+	}
+
 	return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_SHARED);
 }
 
Index: linux-2.6/security/selinux/include/av_perm_to_string.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_perm_to_string.h,v
retrieving revision 1.18
diff -u -p -r1.18 av_perm_to_string.h
--- linux-2.6/security/selinux/include/av_perm_to_string.h	29 Nov 2004 21:37:36 -0000	1.18
+++ linux-2.6/security/selinux/include/av_perm_to_string.h	30 Nov 2004 21:32:19 -0000
@@ -16,6 +16,7 @@
    S_(SECCLASS_DIR, DIR__RMDIR, "rmdir")
    S_(SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, "execute_no_trans")
    S_(SECCLASS_FILE, FILE__ENTRYPOINT, "entrypoint")
+   S_(SECCLASS_FILE, FILE__EXECMOD, "execmod")
    S_(SECCLASS_FD, FD__USE, "use")
    S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__CONNECTTO, "connectto")
    S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__NEWCONN, "newconn")
@@ -64,6 +65,7 @@
    S_(SECCLASS_PROCESS, PROCESS__RLIMITINH, "rlimitinh")
    S_(SECCLASS_PROCESS, PROCESS__DYNTRANSITION, "dyntransition")
    S_(SECCLASS_PROCESS, PROCESS__SETCURRENT, "setcurrent")
+   S_(SECCLASS_PROCESS, PROCESS__EXECMEM, "execmem")
    S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
    S_(SECCLASS_MSG, MSG__SEND, "send")
    S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
Index: linux-2.6/security/selinux/include/av_permissions.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_permissions.h,v
retrieving revision 1.17
diff -u -p -r1.17 av_permissions.h
--- linux-2.6/security/selinux/include/av_permissions.h	29 Nov 2004 21:37:36 -0000	1.17
+++ linux-2.6/security/selinux/include/av_permissions.h	30 Nov 2004 21:32:19 -0000
@@ -105,6 +105,7 @@
 
 #define FILE__EXECUTE_NO_TRANS                    0x00020000UL
 #define FILE__ENTRYPOINT                          0x00040000UL
+#define FILE__EXECMOD                             0x00080000UL
 
 #define LNK_FILE__IOCTL                           0x00000001UL
 #define LNK_FILE__READ                            0x00000002UL
@@ -458,6 +459,7 @@
 #define PROCESS__RLIMITINH                        0x00400000UL
 #define PROCESS__DYNTRANSITION                    0x00800000UL
 #define PROCESS__SETCURRENT                       0x01000000UL
+#define PROCESS__EXECMEM                          0x02000000UL
 
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL

--=-XbacDuPtmn8jIOGmyixf
Content-Disposition: attachment; filename=policy-execmem.patch
Content-Type: text/x-patch; name=policy-execmem.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policy/domains/program/modutil.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/modutil.te,v
retrieving revision 1.25
diff -u -r1.25 modutil.te
--- policy/domains/program/modutil.te	8 Nov 2004 20:58:16 -0000	1.25
+++ policy/domains/program/modutil.te	30 Nov 2004 21:30:27 -0000
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
+++ policy/domains/program/unused/prelink.te	30 Nov 2004 21:30:27 -0000
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
+++ policy/domains/program/unused/udev.te	1 Dec 2004 16:42:27 -0000
@@ -13,6 +13,9 @@
 
 general_domain_access(udev_t)
 
+# for alsactl
+allow udev_t self:process execmem;
+
 etc_domain(udev)
 typealias udev_etc_t alias etc_udev_t;
 type udev_helper_exec_t, file_type, sysadmfile, exec_type;
Index: policy/flask/access_vectors
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/flask/access_vectors,v
retrieving revision 1.16
diff -u -r1.16 access_vectors
--- policy/flask/access_vectors	29 Nov 2004 21:37:03 -0000	1.16
+++ policy/flask/access_vectors	30 Nov 2004 21:31:06 -0000
@@ -118,6 +118,7 @@
 {
 	execute_no_trans
 	entrypoint
+	execmod
 }
 
 class lnk_file
@@ -242,6 +243,7 @@
 	rlimitinh
 	dyntransition
 	setcurrent
+	execmem
 }
 
 
Index: policy/macros/base_user_macros.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/base_user_macros.te,v
retrieving revision 1.39
diff -u -r1.39 base_user_macros.te
--- policy/macros/base_user_macros.te	29 Nov 2004 19:01:25 -0000	1.39
+++ policy/macros/base_user_macros.te	1 Dec 2004 16:43:02 -0000
@@ -33,6 +33,12 @@
 # Grant permissions within the domain.
 general_domain_access($1_t);
 
+# Allow loading DSOs that require executable stack.
+allow $1_t self:process execmem;
+
+# Allow text relocations on system shared libraries, e.g. libGL.
+allow $1_t shlib_t:file execmod;
+
 #
 # kdeinit wants this access
 #
Index: policy/macros/core_macros.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/core_macros.te,v
retrieving revision 1.27
diff -u -r1.27 core_macros.te
--- policy/macros/core_macros.te	29 Nov 2004 19:48:10 -0000	1.27
+++ policy/macros/core_macros.te	30 Nov 2004 21:31:46 -0000
@@ -627,9 +627,9 @@
 #
 define(`general_domain_access',`
 # Access other processes in the same domain.
-# Omits ptrace, setcurrent, setexec, and setfscreate.  These must be granted 
-# separately if desired.
-allow $1 self:process ~{ptrace setcurrent setexec setfscreate setrlimit};
+# Omits ptrace, setcurrent, setexec, setfscreate, setrlimit, and execmem.  
+# These must be granted separately if desired.
+allow $1 self:process ~{ptrace setcurrent setexec setfscreate setrlimit execmem};
 
 # Access /proc/PID files for processes in the same domain.
 allow $1 self:dir r_dir_perms;
Index: policy/macros/program/xserver_macros.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/program/xserver_macros.te,v
retrieving revision 1.38
diff -u -r1.38 xserver_macros.te
--- policy/macros/program/xserver_macros.te	19 Nov 2004 22:03:34 -0000	1.38
+++ policy/macros/program/xserver_macros.te	30 Nov 2004 21:30:27 -0000
@@ -58,6 +58,8 @@
 # for access within the domain
 general_domain_access($1_xserver_t)
 
+allow $1_xserver_t self:process execmem;
+
 allow $1_xserver_t etc_runtime_t:file { getattr read };
 
 ifelse($1, xdm, `

--=-XbacDuPtmn8jIOGmyixf--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
