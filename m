Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAUIVoIi019634
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 13:31:50 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAUIVqoh016208
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 18:31:53 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@tcs-sec.com>
In-Reply-To: <1101830525.4401.67.camel@moss-spartans.epoch.ncsc.mil>
References: <4182959B.4080503@trustedcs.com>
	 <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>
	 <20041112184232.GK15243@golconda.mitre.org>
	 <1100527665.31773.41.camel@moss-spartans.epoch.ncsc.mil>
	 <nhau0rm54ra.fsf@malabar.mitre.org>
	 <1100874782.15944.67.camel@moss-spartans.epoch.ncsc.mil>
	 <419E1F76.9080803@trustedcs.com>
	 <1100884644.15944.181.camel@moss-spartans.epoch.ncsc.mil>
	 <41A4A921.9060105@trustedcs.com>
	 <1101310307.22014.148.camel@moss-spartans.epoch.ncsc.mil>
	 <41AB383B.3020006@trustedcs.com>
	 <1101763456.2630.67.camel@moss-spartans.epoch.ncsc.mil>
	 <41ABB3C2.2090809@trustedcs.com>
	 <1101819480.4401.9.camel@moss-spartans.epoch.ncsc.mil>
	 <41AC8E57.9000103@trustedcs.com>
	 <1101830525.4401.67.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-4XHwNKdifiiI9KoIo+ZQ"
Message-Id: <1101839242.4401.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 30 Nov 2004 13:27:22 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-4XHwNKdifiiI9KoIo+ZQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've committed the dynamic context transition support to our tree
(changes to linux-2.6, libselinux, and policy).  It should be available
in the sourceforge CVS tree soon (but the read-only mirrors take time to
sync with the master).  The final version of the kernel patch is
attached for reference.  We'll look into getting the kernel patch
upstreamed after 2.6.10 is released.  Thanks.



-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-4XHwNKdifiiI9KoIo+ZQ
Content-Disposition: attachment; filename=sel-dyntrans.patch
Content-Type: text/x-patch; name=sel-dyntrans.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Binary files linux-2.6/include/linux/.sched.h.swp and linux-2.6-cvs/include/linux/.sched.h.swp differ
diff -X /home/sds/exclude -ru linux-2.6/security/selinux/hooks.c linux-2.6-cvs/security/selinux/hooks.c
--- linux-2.6/security/selinux/hooks.c	2004-11-23 12:34:29.000000000 -0500
+++ linux-2.6-cvs/security/selinux/hooks.c	2004-11-30 12:35:29.000000000 -0500
@@ -4107,10 +4107,9 @@
 	u32 sid = 0;
 	int error;
 
-	if (current != p || !strcmp(name, "current")) {
+	if (current != p) {
 		/* SELinux only allows a process to change its own
-		   security attributes, and it only allows the process
-		   current SID to change via exec. */
+		   security attributes. */
 		return -EACCES;
 	}
 
@@ -4123,6 +4122,8 @@
 		error = task_has_perm(current, p, PROCESS__SETEXEC);
 	else if (!strcmp(name, "fscreate"))
 		error = task_has_perm(current, p, PROCESS__SETFSCREATE);
+	else if (!strcmp(name, "current"))
+		error = task_has_perm(current, p, PROCESS__SETCURRENT);
 	else
 		error = -EINVAL;
 	if (error)
@@ -4147,6 +4148,51 @@
 		tsec->exec_sid = sid;
 	else if (!strcmp(name, "fscreate"))
 		tsec->create_sid = sid;
+	else if (!strcmp(name, "current")) {
+		struct av_decision avd;
+
+		if (sid == 0)
+			return -EINVAL;
+
+		/* Only allow single threaded processes to change context */
+		if (atomic_read(&p->mm->mm_users) != 1) {
+			struct task_struct *g, *t;
+			struct mm_struct *mm = p->mm;
+			read_lock(&tasklist_lock);
+			do_each_thread(g, t)
+				if (t->mm == mm && t != p) {
+					read_unlock(&tasklist_lock);
+					return -EPERM;
+				}
+			while_each_thread(g, t);
+			read_unlock(&tasklist_lock);
+                }
+
+		/* Check permissions for the transition. */
+		error = avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
+		                     PROCESS__DYNTRANSITION, NULL);
+		if (error)
+			return error;
+
+		/* Check for ptracing, and update the task SID if ok.
+		   Otherwise, leave SID unchanged and fail. */
+		task_lock(p);
+		if (p->ptrace & PT_PTRACED) {
+			error = avc_has_perm_noaudit(tsec->ptrace_sid, sid,
+						     SECCLASS_PROCESS,
+						     PROCESS__PTRACE, &avd);
+			if (!error)
+				tsec->sid = sid;
+			task_unlock(p);
+			avc_audit(tsec->ptrace_sid, sid, SECCLASS_PROCESS,
+				  PROCESS__PTRACE, &avd, error, NULL);
+			if (error)
+				return error;
+		} else {
+			tsec->sid = sid;
+			task_unlock(p);
+		}
+	}
 	else
 		return -EINVAL;
 
diff -X /home/sds/exclude -ru linux-2.6/security/selinux/include/av_permissions.h linux-2.6-cvs/security/selinux/include/av_permissions.h
--- linux-2.6/security/selinux/include/av_permissions.h	2004-11-23 12:34:29.000000000 -0500
+++ linux-2.6-cvs/security/selinux/include/av_permissions.h	2004-11-29 16:36:51.000000000 -0500
@@ -456,6 +456,8 @@
 #define PROCESS__SIGINH                           0x00100000UL
 #define PROCESS__SETRLIMIT                        0x00200000UL
 #define PROCESS__RLIMITINH                        0x00400000UL
+#define PROCESS__DYNTRANSITION                    0x00800000UL
+#define PROCESS__SETCURRENT                       0x01000000UL
 
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL
diff -X /home/sds/exclude -ru linux-2.6/security/selinux/include/av_perm_to_string.h linux-2.6-cvs/security/selinux/include/av_perm_to_string.h
--- linux-2.6/security/selinux/include/av_perm_to_string.h	2004-11-23 12:34:29.000000000 -0500
+++ linux-2.6-cvs/security/selinux/include/av_perm_to_string.h	2004-11-29 16:36:51.000000000 -0500
@@ -62,6 +62,8 @@
    S_(SECCLASS_PROCESS, PROCESS__SIGINH, "siginh")
    S_(SECCLASS_PROCESS, PROCESS__SETRLIMIT, "setrlimit")
    S_(SECCLASS_PROCESS, PROCESS__RLIMITINH, "rlimitinh")
+   S_(SECCLASS_PROCESS, PROCESS__DYNTRANSITION, "dyntransition")
+   S_(SECCLASS_PROCESS, PROCESS__SETCURRENT, "setcurrent")
    S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
    S_(SECCLASS_MSG, MSG__SEND, "send")
    S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
diff -X /home/sds/exclude -ru linux-2.6/security/selinux/ss/services.c linux-2.6-cvs/security/selinux/ss/services.c
--- linux-2.6/security/selinux/ss/services.c	2004-11-23 12:34:29.000000000 -0500
+++ linux-2.6-cvs/security/selinux/ss/services.c	2004-11-29 16:11:45.000000000 -0500
@@ -275,7 +275,7 @@
 	 * pair.
 	 */
 	if (tclass == SECCLASS_PROCESS &&
-	    (avd->allowed & PROCESS__TRANSITION) &&
+	    (avd->allowed & (PROCESS__TRANSITION | PROCESS__DYNTRANSITION)) &&
 	    scontext->role != tcontext->role) {
 		for (ra = policydb.role_allow; ra; ra = ra->next) {
 			if (scontext->role == ra->role &&
@@ -283,7 +283,8 @@
 				break;
 		}
 		if (!ra)
-			avd->allowed = (avd->allowed) & ~(PROCESS__TRANSITION);
+			avd->allowed = (avd->allowed) & ~(PROCESS__TRANSITION |
+			                                PROCESS__DYNTRANSITION);
 	}
 
 	return 0;

--=-4XHwNKdifiiI9KoIo+ZQ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
