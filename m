Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9TJA0XZ010856
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 15:10:00 -0400 (EDT)
Message-ID: <4182959B.4080503@trustedcs.com>
Date: Fri, 29 Oct 2004 14:10:19 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, Chad Hanson <chanson@TrustedCS.com>
Subject: dynamic context transitions
Content-Type: multipart/mixed;
 boundary="------------090301010806060603010402"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090301010806060603010402
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

	We would like to propose adding support for a trusted process to
alter its security context dynamically in order to support privilege
bracketing within an application.  We are aware that this idea has been
discussed in the past on the list and entirely understand the concerns
about non-tranquility, but we feel that this feature, and its
implementation, have considerable merit and can be provided with
appropriate controls to mitigate the risks.

       The motivator behind this proposal is to provide a mechanism for a
trusted application (one written to leverage the security policy) to be
able to remove unnecessary privileges when they are no longer needed, as
well as temporarily raise the privilege level to perform certain
operations and then return to a less privileged level.  By privilege
level, we are referring to access to other types/domains and access to
security classes such as system, passwd, and capability.  The former
provides enhanced security for applications/daemons which need access to
many things to initialize, but can then run with much less access to the
system.  The latter method of privilege bracketing helps code audits of
large applications by identifying critical regions of code that require
more privileges to run.

	A goal of SELinux and trusted application programming is to
create smaller programs which can be secured and audited. However, there
are and will continue to be applications which don't fall into this
framework. For these applications, a privilege bracketing approach
provides a more granular security framework than what currently exists
from SELinux today at process level.

	The MLS model is another reason for this functionality. We have
chosen to create MLS policy overrides using a new SELinux MLS capability
class. Trusted MLS applications may require a specific capability to
satisfy or "temporarily" override a policy to change the MLS label of an
object after it has passed "official procedures". A process may also
jump between multiple MLS labels and perform actions at each. This
functionality requires the need for dynamic domain transitions.

      The implementation is fairly straightforward.  You will be allowed
to write  to /proc/PID/attr/current.  This will require the new
permission of "allow XXX_t  self:process setcurrent".  A second check
will then be done to ensure that the  current context is allowed to
dynamically transition to the new context by  requiring the new
permission of "allow XXX_t YYY_t:process dyntransition".  Role allow
rules are checked in the kernel just like exec-based transitions.  There
are also constraints which will not allow a user change or a role
change.  We have also examined the the issues of state inheritance and
have concluded that extra checks along those lines would have no real
security benefit. One note on this topic is that file descriptor access is
re-validated on use. This will prevent lower privileged domains from using
file descriptors, of a type which the more privileged domain only has
access to, that may be open after a dynamic transition.

      Since the ability to perform dynamic transitions is controlled by
separate permission from exec-based transitions (process setcurrent),
policy writers have the ability to not use the new feature.  The chain
of allowable dynamic  transitions is also controlled on a context-pair
basis.  This allows a "dynamic  transition group" to be treated as an
equivalence class for policy analysis.

      In closing, this feature will greatly aid the adoption of Linux
(and SELinux of course) by current developers and users of trusted
operating systems because it provides them with a transition tool to
migrate their current generation applications which use privilege
bracketing.  Without this migration path, applications which are
currently on trusted operating systems today, will probably never make it
to the Linux community.  This would also lead to a greater application
developer base for SELinux now, and the next generation of those
applications can then be designed to be more modular and use more
exec-based transitions.

NOTE: the patch does not include the auto-generated flask .h files.

Thanks.

-- 

Darrel Goeddel
Senior Secure Systems Engineer

Trusted Computer Solutions             E: dgoeddel@trustedcs.com
121 West Goose Alley                   V: 217.384.0028 x19
Urbana, IL  61801                      F: 217.384.0288

--------------090301010806060603010402
Content-Type: text/plain;
 name="setcurrentcon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setcurrentcon.patch"

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /cvsroot/selinux/nsa/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.21
diff -u -u -r1.21 hooks.c
--- linux-2.6/security/selinux/hooks.c	21 Oct 2004 12:59:02 -0000	1.21
+++ linux-2.6/security/selinux/hooks.c	28 Oct 2004 17:47:14 -0000
@@ -4114,10 +4114,9 @@
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
 
@@ -4130,6 +4129,8 @@
 		error = task_has_perm(current, p, PROCESS__SETEXEC);
 	else if (!strcmp(name, "fscreate"))
 		error = task_has_perm(current, p, PROCESS__SETFSCREATE);
+	else if (!strcmp(name, "current"))
+		error = task_has_perm(current, p, PROCESS__SETCURRENT);
 	else
 		error = -EINVAL;
 	if (error)
@@ -4154,6 +4155,18 @@
 		tsec->exec_sid = sid;
 	else if (!strcmp(name, "fscreate"))
 		tsec->create_sid = sid;
+	else if (!strcmp(name, "current")) {
+		if (sid == 0)
+			return -EINVAL;
+
+		/* Check permissions for the transition. */
+		error = avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
+		                     PROCESS__DYNTRANSITION, NULL, NULL);
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
retrieving revision 1.11
diff -u -u -r1.11 services.c
--- linux-2.6/security/selinux/ss/services.c	19 Aug 2004 15:23:55 -0000	1.11
+++ linux-2.6/security/selinux/ss/services.c	28 Oct 2004 17:47:15 -0000
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
retrieving revision 1.12
diff -u -u -r1.12 assert.te
--- selinux-usr/policy/assert.te	24 Aug 2004 19:35:23 -0000	1.12
+++ selinux-usr/policy/assert.te	28 Oct 2004 17:47:15 -0000
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
diff -u -u -r1.7 constraints
--- selinux-usr/policy/constraints	8 Jul 2004 13:59:01 -0000	1.7
+++ selinux-usr/policy/constraints	28 Oct 2004 17:47:15 -0000
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
diff -u -u -r1.12 access_vectors
--- selinux-usr/policy/flask/access_vectors	9 Sep 2004 12:14:39 -0000	1.12
+++ selinux-usr/policy/flask/access_vectors	28 Oct 2004 17:47:15 -0000
@@ -240,6 +240,8 @@
 	siginh
 	setrlimit
 	rlimitinh
+	dyntransition
+	setcurrent
 }
 
 
Index: selinux-usr/policy/macros/global_macros.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/macros/global_macros.te,v
retrieving revision 1.43
diff -u -u -r1.43 global_macros.te
--- selinux-usr/policy/macros/global_macros.te	13 Oct 2004 20:14:04 -0000	1.43
+++ selinux-usr/policy/macros/global_macros.te	28 Oct 2004 17:47:15 -0000
@@ -580,9 +580,9 @@
 allow $1 domain:fifo_file rw_file_perms;
 
 # Act upon any other process.
-allow $1 domain:process ~transition;
+allow $1 domain:process ~{ transition dyntransition };
 # Transition to myself, to make get_ordered_context_list happy.
-allow $1 self:process transition;
+allow $1 self:process { transition dyntransition };
 
 # Create/access any System V IPC objects.
 allow $1 domain:{ sem msgq shm } *;
Index: selinux-usr/policy/targeted/assert.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/targeted/assert.te,v
retrieving revision 1.1
diff -u -u -r1.1 assert.te
--- selinux-usr/policy/targeted/assert.te	12 May 2004 12:56:51 -0000	1.1
+++ selinux-usr/policy/targeted/assert.te	28 Oct 2004 17:47:15 -0000
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
diff -u -u -r1.1 constraints
--- selinux-usr/policy/targeted/constraints	12 May 2004 12:56:51 -0000	1.1
+++ selinux-usr/policy/targeted/constraints	28 Oct 2004 17:47:15 -0000
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
diff -u -u -r1.20 selinux.h
--- selinux-usr/libselinux/include/selinux/selinux.h	14 Oct 2004 20:04:05 -0000	1.20
+++ selinux-usr/libselinux/include/selinux/selinux.h	28 Oct 2004 17:47:15 -0000
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
@@ -0,0 +1,28 @@
+/*
+ * Author: Trusted Computer Solutions, Inc. <chanson@TrustedCS.com>
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
+

--------------090301010806060603010402--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
