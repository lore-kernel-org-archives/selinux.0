Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iATEs6Ii011081
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2004 09:54:06 -0500 (EST)
Message-ID: <41AB383B.3020006@trustedcs.com>
Date: Mon, 29 Nov 2004 08:54:51 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@tcs-sec.com>
Subject: Re: dynamic context transitions
References: <4182959B.4080503@trustedcs.com>	 <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>	 <20041112184232.GK15243@golconda.mitre.org>	 <1100527665.31773.41.camel@moss-spartans.epoch.ncsc.mil>	 <nhau0rm54ra.fsf@malabar.mitre.org>	 <1100874782.15944.67.camel@moss-spartans.epoch.ncsc.mil>	 <419E1F76.9080803@trustedcs.com>	 <1100884644.15944.181.camel@moss-spartans.epoch.ncsc.mil>	 <41A4A921.9060105@trustedcs.com> <1101310307.22014.148.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1101310307.22014.148.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------080502060208070301040008"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080502060208070301040008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> Yes, please make that change and confirm via testing that it properly
> blocks attempts by multi-threaded processes to set their current
> context.
> 

The new patch is attached.  I also made a change to the general_domain_access 
macro to not grant setcurrent to self - a separate can_setcon macro has been 
added to grant this.  Dynamic transitions are denied for a multi-threaded 
process (with more than one "kernel thread").  A process can switch its context 
before spawning other threads and after all other threads have exited, but not 
while any other threads exist.

-- 

Darrel

--------------080502060208070301040008
Content-Type: text/plain;
 name="setcurrentcon_new.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setcurrentcon_new.patch"

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /cvsroot/selinux/nsa/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.23
diff -u -r1.23 hooks.c
--- linux-2.6/security/selinux/hooks.c	23 Nov 2004 17:42:43 -0000	1.23
+++ linux-2.6/security/selinux/hooks.c	27 Nov 2004 18:45:21 -0000
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
@@ -4147,6 +4148,22 @@
 		tsec->exec_sid = sid;
 	else if (!strcmp(name, "fscreate"))
 		tsec->create_sid = sid;
+	else if (!strcmp(name, "current")) {
+		if (sid == 0)
+			return -EINVAL;
+
+		/* Only allow single threaded processes to change context */
+		if (!thread_group_empty(p))
+			return -EPERM;
+
+		/* Check permissions for the transition. */
+		error = avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
+		                     PROCESS__DYNTRANSITION, NULL);
+		if (error)
+			return error;
+
+		tsec->sid = sid;
+	}
 	else
 		return -EINVAL;
 
Index: linux-2.6/security/selinux/ss/services.c
===================================================================
RCS file: /cvsroot/selinux/nsa/linux-2.6/security/selinux/ss/services.c,v
retrieving revision 1.12
diff -u -r1.12 services.c
--- linux-2.6/security/selinux/ss/services.c	23 Nov 2004 17:42:45 -0000	1.12
+++ linux-2.6/security/selinux/ss/services.c	27 Nov 2004 18:45:22 -0000
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
Index: selinux-usr/policy/assert.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/assert.te,v
retrieving revision 1.15
diff -u -r1.15 assert.te
--- selinux-usr/policy/assert.te	19 Nov 2004 19:25:12 -0000	1.15
+++ selinux-usr/policy/assert.te	27 Nov 2004 18:45:22 -0000
@@ -24,7 +24,7 @@
 # Verify that every type that can be entered by
 # a domain is also tagged as a domain.
 #
-neverallow domain ~domain:process transition;
+neverallow domain ~domain:process { transition dyntransition };
 
 #
 # Verify that only the insmod_t and kernel_t domains 
Index: selinux-usr/policy/constraints
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/constraints,v
retrieving revision 1.7
diff -u -r1.7 constraints
--- selinux-usr/policy/constraints	8 Jul 2004 13:59:01 -0000	1.7
+++ selinux-usr/policy/constraints	27 Nov 2004 18:45:23 -0000
@@ -53,6 +53,9 @@
 	 or (t1 == priv_system_role and r2 == system_r )
         );
 
+constrain process dyntransition
+	( u1 == u2 and r1 == r2);
+
 #
 # Restrict the ability to label objects with other
 # user identities to a few privileged types.
Index: selinux-usr/policy/flask/access_vectors
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/flask/access_vectors,v
retrieving revision 1.12
diff -u -r1.12 access_vectors
--- selinux-usr/policy/flask/access_vectors	9 Sep 2004 12:14:39 -0000	1.12
+++ selinux-usr/policy/flask/access_vectors	27 Nov 2004 18:45:23 -0000
@@ -240,6 +240,8 @@
 	siginh
 	setrlimit
 	rlimitinh
+	dyntransition
+	setcurrent
 }
 
 
Index: selinux-usr/policy/macros/core_macros.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/macros/core_macros.te,v
retrieving revision 1.23
diff -u -r1.23 core_macros.te
--- selinux-usr/policy/macros/core_macros.te	23 Nov 2004 20:56:07 -0000	1.23
+++ selinux-usr/policy/macros/core_macros.te	27 Nov 2004 18:45:24 -0000
@@ -627,9 +627,9 @@
 #
 define(`general_domain_access',`
 # Access other processes in the same domain.
-# Omits ptrace, setexec, and setfscreate.  These must be granted 
+# Omits ptrace, setcurrent, setexec, and setfscreate.  These must be granted 
 # separately if desired.
-allow $1 self:process ~{ptrace setexec setfscreate setrlimit};
+allow $1 self:process ~{ptrace setcurrent setexec setfscreate setrlimit};
 
 # Access /proc/PID files for processes in the same domain.
 allow $1 self:dir r_dir_perms;
Index: selinux-usr/policy/macros/global_macros.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/macros/global_macros.te,v
retrieving revision 1.48
diff -u -r1.48 global_macros.te
--- selinux-usr/policy/macros/global_macros.te	24 Nov 2004 19:44:37 -0000	1.48
+++ selinux-usr/policy/macros/global_macros.te	27 Nov 2004 18:45:25 -0000
@@ -42,6 +42,21 @@
 ')
 
 ##################################
+#
+# can_setcon(domain)
+#
+# Authorize a domain to set its current context
+# (via /proc/pid/attr/current).
+#
+define(`can_setcon',`
+allow $1 self:process setcurrent;
+allow $1 proc_t:dir search;
+allow $1 proc_t:{ file lnk_file } read;
+allow $1 self:dir search;
+allow $1 self:file { getattr read write };
+')
+
+##################################
 # read_sysctl(domain)
 #
 # Permissions for reading sysctl variables.
@@ -525,7 +540,7 @@
 allow $1 domain:fifo_file rw_file_perms;
 
 # Act upon any other process.
-allow $1 domain:process ~transition;
+allow $1 domain:process ~{ transition dyntransition };
 # Transition to myself, to make get_ordered_context_list happy.
 allow $1 self:process transition;
 
Index: selinux-usr/policy/targeted/assert.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/targeted/assert.te,v
retrieving revision 1.1
diff -u -r1.1 assert.te
--- selinux-usr/policy/targeted/assert.te	12 May 2004 12:56:51 -0000	1.1
+++ selinux-usr/policy/targeted/assert.te	27 Nov 2004 18:45:25 -0000
@@ -31,7 +31,7 @@
 # Verify that every type that can be entered by
 # a domain is also tagged as a domain.
 #
-neverallow domain ~domain:process transition;
+neverallow domain ~domain:process { transition dyntransition};
 
 # for gross mistakes in policy
 neverallow domain domain:dir ~r_dir_perms;
Index: selinux-usr/policy/targeted/constraints
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/targeted/constraints,v
retrieving revision 1.1
diff -u -r1.1 constraints
--- selinux-usr/policy/targeted/constraints	12 May 2004 12:56:51 -0000	1.1
+++ selinux-usr/policy/targeted/constraints	27 Nov 2004 18:45:25 -0000
@@ -39,6 +39,9 @@
 constrain process transition 
 	( r1 == r2 or t1 == privrole );
 
+constrain process dyntransition
+	( u1 == u2 and r1 == r2);
+
 #
 # Restrict the ability to label objects with other
 # user identities to a few privileged types.
Index: selinux-usr/libselinux/include/selinux/selinux.h
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/libselinux/include/selinux/selinux.h,v
retrieving revision 1.20
diff -u -r1.20 selinux.h
--- selinux-usr/libselinux/include/selinux/selinux.h	14 Oct 2004 20:04:05 -0000	1.20
+++ selinux-usr/libselinux/include/selinux/selinux.h	27 Nov 2004 18:45:26 -0000
@@ -23,6 +23,9 @@
    Caller must free via freecon. */
 extern int getcon(security_context_t *con);
 
+/* Set current security context */
+extern int setcon(security_context_t con);
+
 /* Get context of process identified by pid, and 
    set *con to refer to it.  Caller must free via freecon. */
 extern int getpidcon(pid_t pid, security_context_t *con);
--- /dev/null	2003-09-15 08:40:47.000000000 -0500
+++ selinux-usr/libselinux/src/setcon.c	2004-10-28 10:48:14.000000000 -0500
@@ -0,0 +1,27 @@
+/*
+ * Author: Trusted Computer Solutions, Inc. <chanson@trustedcs.com>
+ */
+
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <selinux/selinux.h>
+
+int setcon(security_context_t context)
+{
+	int fd;
+	ssize_t ret;
+
+	fd = open("/proc/self/attr/current", O_RDWR);
+	if (fd < 0)
+		return -1;
+	if (context) 
+		ret = write(fd, context, strlen(context)+1);
+	else
+		ret = -1; /* we can not clear this one */
+	close(fd);
+	if (ret < 0)
+		return -1;
+	else
+		return 0;
+}

--------------080502060208070301040008--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
