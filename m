Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2HMVTx6002573
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 17:31:29 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2HMVS9P028218
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 22:31:28 GMT
Received: from facesaver.epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h2HMVRP7028215 for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 22:31:27 GMT
Received: from moss-shockers.ncsc.mil (moss-shockers [144.51.25.21])
	by facesaver.epoch.ncsc.mil (8.12.8/8.12.8) with SMTP id h2HMVPNL008436
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 17:31:25 -0500 (EST)
Message-Id: <200303172239.RAA26135@moss-shockers.ncsc.mil>
Date: Mon, 17 Mar 2003 17:39:07 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: ptrace flaw
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY=Ostentation_of_Peacocks_479_000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Ostentation_of_Peacocks_479_000
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: R4GwR3TtzsU/mNLTaaoN7w==


As some of you may have already noticed, Alan Cox has posted a patch
for a flaw in ptrace in the Linux 2.4 kernel to the linux-kernel
mailing list.  See
http://marc.theaimsgroup.com/?l=linux-kernel&m=104791735604202&w=2.
That patch has been merged into the sourceforge lsm-2.4 CVS tree, along
with a corresponding change to the SELinux kernel code.  The patch to
the SELinux kernel code (not including the patch posted by Alan) is
also attached to this message as the first attachment.

A short term workaround if you can't immediately update your kernel
would be to disable ptrace permission in the policy entirely, as in the
second attached patch.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

--Ostentation_of_Peacocks_479_000
Content-Type: TEXT/plain; name="selinux-ptrace.patch"; charset=us-ascii; x-unix-mode=0644
Content-Description: selinux-ptrace.patch
Content-MD5: CnTcMx0v08PU+iF9h8g8JA==

Index: lsm-2.4/security/selinux/hooks.c
diff -u lsm-2.4/security/selinux/hooks.c:1.80 lsm-2.4/security/selinux/hooks.c:1.85
--- lsm-2.4/security/selinux/hooks.c:1.80	Fri Feb 14 15:34:46 2003
+++ lsm-2.4/security/selinux/hooks.c	Mon Mar 17 16:58:06 2003
@@ -1652,13 +1652,17 @@
 		/* Check ptrace permission between the parent and 
 		   the new SID for this process if this process is 
 		   being traced. */
+		task_lock(current);
 		if (current->ptrace & PT_PTRACED) {
 			psec = current->p_pptr->security;
 			rc = avc_has_perm(psec->sid, newsid, 
 					  SECCLASS_PROCESS, PROCESS__PTRACE);
-			if (rc)
+			if (rc) {
+				task_unlock(current);
 				return rc;
+			}
 		}
+		task_unlock(current);
 
 		/* Check share permission between the old and new SIDs
 		   of the process if the process will share state. */
@@ -1730,8 +1734,9 @@
 
 static void selinux_bprm_compute_creds(struct linux_binprm *bprm)
 {
-	struct task_security_struct *tsec;
+	struct task_security_struct *tsec, *psec;
 	security_id_t sid;
+	int rc;
 
 	secondary_ops->bprm_compute_creds(bprm);
 
@@ -1743,6 +1748,19 @@
 
 	tsec->osid = tsec->sid;
 	if (tsec->sid != sid) {
+		task_lock(current);
+		current->mm->dumpable = 0;
+		if (current->ptrace & PT_PTRACED) {
+			psec = current->p_pptr->security;
+			rc = avc_has_perm(psec->sid, sid, 
+					  SECCLASS_PROCESS, PROCESS__PTRACE);
+			if (rc) {
+				task_unlock(current);
+				return;
+			}
+		}
+		task_unlock(current);
+
 		tsec->sid = sid;
 
 		flush_unauthorized_files(current->files);

--Ostentation_of_Peacocks_479_000
Content-Type: TEXT/plain; name="noptrace.patch"; charset=us-ascii; x-unix-mode=0644
Content-Description: noptrace.patch
Content-MD5: 3fLEfEsl+M//8R2lWuDaGw==

Index: selinux/policy/macros/global_macros.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux/policy/macros/global_macros.te,v
retrieving revision 1.20
diff -u -r1.20 global_macros.te
--- selinux/policy/macros/global_macros.te	16 Jan 2003 14:05:50 -0000	1.20
+++ selinux/policy/macros/global_macros.te	17 Mar 2003 22:15:04 -0000
@@ -582,7 +582,7 @@
 #
 define(`general_domain_access',`
 # Access other processes in the same domain.
-allow $1 self:process *;
+allow $1 self:process ~ptrace;
 
 # Access /proc/PID files for processes in the same domain.
 allow $1 self:dir r_dir_perms;

--Ostentation_of_Peacocks_479_000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
