Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA4ELjWt005959
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 09:21:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA4ELNC7005488
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 14:21:23 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hA4ELNuw005485
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 14:21:23 GMT
Received: from moss-spartans.epoch.ncsc.mil (moss-spartans [144.51.25.121])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA4ELhAn022799
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 09:21:43 -0500 (EST)
Subject: [patch] 2.6.0-test9-selinux1, new inheritance controls
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-n7Qs+u3NG1CK+/xrNqyP"
Message-Id: <1067955702.21113.249.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 04 Nov 2003 09:21:42 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-n7Qs+u3NG1CK+/xrNqyP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The first attached patch against 2.6.0-test9 includes our current set of
changes to the SELinux module.  These changes include:
- Reduce the full capability check for the KDSKBENT/SENT ioctls
to only checking the SELinux permission, as discussed earlier on
the list.
- Remove the use of -include and removes the global.h file, adding
appropriate individual #includes to the various files in the
security/selinux/ss subdirectory.  This fixes SELinux for make O=...
builds.
- Introduce new experimental controls over the inheritance of
signal-related state and resource limits upon context transitions.
These are to provide further protection of domain-changing programs
invoked from less trusted contexts in addition to the existing
protections provided via AT_SECURE.

The second attached patch updates the policy access vector definitions
to include definitions for the new permissions and updates the core
macros to avoid auditing of inheritance-related denials and to avoid
granting setrlimit by default within a domain.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-n7Qs+u3NG1CK+/xrNqyP
Content-Disposition: attachment; filename=2.6.0-test9-selinux1.patch
Content-Type: text/plain; name=2.6.0-test9-selinux1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


 Makefile                                     |    2 
 security/selinux/avc.c                       |   13 ++++-
 security/selinux/hooks.c                     |   60 +++++++++++++++++++++++----
 security/selinux/include/av_perm_to_string.h |    3 +
 security/selinux/include/av_permissions.h    |    3 +
 security/selinux/ss/Makefile                 |    3 -
 security/selinux/ss/avtab.c                  |    4 +
 security/selinux/ss/ebitmap.c                |    3 +
 security/selinux/ss/global.h                 |   18 --------
 security/selinux/ss/hashtab.c                |    3 +
 security/selinux/ss/mls.c                    |    4 +
 security/selinux/ss/policydb.c               |    5 ++
 security/selinux/ss/services.c               |   11 ++++
 security/selinux/ss/sidtab.c                 |    6 ++
 security/selinux/ss/symtab.c                 |    4 +
 15 files changed, 112 insertions(+), 30 deletions(-)

Index: linux-2.6/Makefile
diff -u linux-2.6/Makefile:1.1.1.21 linux-2.6/Makefile:1.23
--- linux-2.6/Makefile:1.1.1.21	Mon Oct 27 10:28:50 2003
+++ linux-2.6/Makefile	Mon Oct 27 14:52:40 2003
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 0
-EXTRAVERSION = -test9
+EXTRAVERSION = -test9-selinux1
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
Index: linux-2.6/security/selinux/avc.c
diff -u linux-2.6/security/selinux/avc.c:1.1.1.2 linux-2.6/security/selinux/avc.c:1.35
--- linux-2.6/security/selinux/avc.c:1.1.1.2	Mon Aug 25 10:58:08 2003
+++ linux-2.6/security/selinux/avc.c	Wed Sep 24 12:15:25 2003
@@ -575,17 +575,26 @@
 			break;
 		case AVC_AUDIT_DATA_FS:
 			if (a->u.fs.dentry) {
+				struct dentry *dentry = a->u.fs.dentry;
 				if (a->u.fs.mnt) {
-					p = d_path(a->u.fs.dentry,
+					p = d_path(dentry,
 						   a->u.fs.mnt,
 						   avc_audit_buffer,
 						   PAGE_SIZE);
 					if (p)
 						printk(" path=%s", p);
+				} else {
+					printk(" name=%s", dentry->d_name.name);
 				}
-				inode = a->u.fs.dentry->d_inode;
+				inode = dentry->d_inode;
 			} else if (a->u.fs.inode) {
+				struct dentry *dentry;
 				inode = a->u.fs.inode;
+				dentry = d_find_alias(inode);
+				if (dentry) {
+					printk(" name=%s", dentry->d_name.name);
+					dput(dentry);
+				}
 			}
 			if (inode)
 				printk(" dev=%s ino=%ld",
Index: linux-2.6/security/selinux/hooks.c
diff -u linux-2.6/security/selinux/hooks.c:1.1.1.5 linux-2.6/security/selinux/hooks.c:1.80
--- linux-2.6/security/selinux/hooks.c:1.1.1.5	Thu Oct  9 08:48:28 2003
+++ linux-2.6/security/selinux/hooks.c	Mon Nov  3 10:20:27 2003
@@ -1515,7 +1515,9 @@
 	struct bprm_security_struct *bsec;
 	u32 sid;
 	struct av_decision avd;
-	int rc;
+	struct itimerval itimer;
+	struct rlimit *rlim, *initrlim;
+	int rc, i;
 
 	secondary_ops->bprm_compute_creds(bprm);
 
@@ -1565,6 +1567,46 @@
 		/* Close files for which the new task SID is not authorized. */
 		flush_unauthorized_files(current->files);
 
+		/* Check whether the new SID can inherit signal state
+		   from the old SID.  If not, clear itimers to avoid
+		   subsequent signal generation and flush and unblock
+		   signals. This must occur _after_ the task SID has
+                  been updated so that any kill done after the flush
+                  will be checked against the new SID. */
+		rc = avc_has_perm(tsec->osid, tsec->sid, SECCLASS_PROCESS,
+				  PROCESS__SIGINH, NULL, NULL);
+		if (rc) {
+			memset(&itimer, 0, sizeof itimer);
+			for (i = 0; i < 3; i++)
+				do_setitimer(i, &itimer, NULL);
+			flush_signals(current);
+			spin_lock_irq(&current->sighand->siglock);
+			flush_signal_handlers(current, 1);
+			sigemptyset(&current->blocked);
+			recalc_sigpending();
+			spin_unlock_irq(&current->sighand->siglock);
+		}
+
+		/* Check whether the new SID can inherit resource limits
+		   from the old SID.  If not, reset all soft limits to
+		   the lower of the current task's hard limit and the init
+		   task's soft limit.  Note that the setting of hard limits 
+		   (even to lower them) can be controlled by the setrlimit 
+		   check. The inclusion of the init task's soft limit into
+	           the computation is to avoid resetting soft limits higher
+		   than the default soft limit for cases where the default
+		   is lower than the hard limit, e.g. RLIMIT_CORE or 
+		   RLIMIT_STACK.*/
+		rc = avc_has_perm(tsec->osid, tsec->sid, SECCLASS_PROCESS,
+				  PROCESS__RLIMITINH, NULL, NULL);
+		if (rc) {
+			for (i = 0; i < RLIM_NLIMITS; i++) {
+				rlim = current->rlim + i;
+				initrlim = init_task.rlim+i;
+				rlim->rlim_cur = min(rlim->rlim_max,initrlim->rlim_cur);
+			}
+		}
+
 		/* Wake up the parent if it is waiting so that it can
 		   recheck wait permission to the new task SID. */
 		wake_up_interruptible(&current->parent->wait_chldexit);
@@ -1992,8 +2034,7 @@
 
 	        case KDSKBENT:
 	        case KDSKBSENT:
-		  	if (!capable(CAP_SYS_TTY_CONFIG))
-				error = -EPERM;
+			error = task_has_capability(current,CAP_SYS_TTY_CONFIG);
 			break;
 
 		/* default case assumes that the command will go
@@ -2206,10 +2247,15 @@
 
 static int selinux_task_setrlimit(unsigned int resource, struct rlimit *new_rlim)
 {
-	/* SELinux does not currently provide a process
-	   resource limit policy based on security contexts.
-	   It does control the use of the CAP_SYS_RESOURCE capability
-	   using the capable hook. */
+	struct rlimit *old_rlim = current->rlim + resource;
+
+	/* Control the ability to change the hard limit (whether
+	   lowering or raising it), so that the hard limit can
+	   later be used as a safe reset point for the soft limit
+	   upon context transitions. See selinux_bprm_compute_creds. */
+	if (old_rlim->rlim_max != new_rlim->rlim_max)
+		return task_has_perm(current, current, PROCESS__SETRLIMIT);
+
 	return 0;
 }
 
Index: linux-2.6/security/selinux/include/av_perm_to_string.h
diff -u linux-2.6/security/selinux/include/av_perm_to_string.h:1.1.1.1 linux-2.6/security/selinux/include/av_perm_to_string.h:1.7
--- linux-2.6/security/selinux/include/av_perm_to_string.h:1.1.1.1	Tue Aug 12 09:05:09 2003
+++ linux-2.6/security/selinux/include/av_perm_to_string.h	Fri Oct 31 12:17:22 2003
@@ -66,6 +66,9 @@
    { SECCLASS_PROCESS, PROCESS__SETEXEC, "setexec" },
    { SECCLASS_PROCESS, PROCESS__SETFSCREATE, "setfscreate" },
    { SECCLASS_PROCESS, PROCESS__NOATSECURE, "noatsecure" },
+   { SECCLASS_PROCESS, PROCESS__SIGINH, "siginh" },
+   { SECCLASS_PROCESS, PROCESS__SETRLIMIT, "setrlimit" },
+   { SECCLASS_PROCESS, PROCESS__RLIMITINH, "rlimitinh" },
    { SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue" },
    { SECCLASS_MSG, MSG__SEND, "send" },
    { SECCLASS_MSG, MSG__RECEIVE, "receive" },
Index: linux-2.6/security/selinux/include/av_permissions.h
diff -u linux-2.6/security/selinux/include/av_permissions.h:1.1.1.1 linux-2.6/security/selinux/include/av_permissions.h:1.4
--- linux-2.6/security/selinux/include/av_permissions.h:1.1.1.1	Tue Aug 12 09:05:08 2003
+++ linux-2.6/security/selinux/include/av_permissions.h	Fri Oct 31 12:17:22 2003
@@ -450,6 +450,9 @@
 #define PROCESS__SETEXEC                          0x00020000UL
 #define PROCESS__SETFSCREATE                      0x00040000UL
 #define PROCESS__NOATSECURE                       0x00080000UL
+#define PROCESS__SIGINH                           0x00100000UL
+#define PROCESS__SETRLIMIT                        0x00200000UL
+#define PROCESS__RLIMITINH                        0x00400000UL
 
 #define IPC__SETATTR                              0x00000008UL
 #define IPC__READ                                 0x00000010UL
Index: linux-2.6/security/selinux/ss/Makefile
diff -u linux-2.6/security/selinux/ss/Makefile:1.1.1.1 linux-2.6/security/selinux/ss/Makefile:1.6
--- linux-2.6/security/selinux/ss/Makefile:1.1.1.1	Tue Aug 12 09:05:06 2003
+++ linux-2.6/security/selinux/ss/Makefile	Tue Oct 28 09:08:27 2003
@@ -2,8 +2,7 @@
 # Makefile for building the SELinux security server as part of the kernel tree.
 #
 
-EXTRA_CFLAGS += -Isecurity/selinux/include -include security/selinux/ss/global.h
-
+EXTRA_CFLAGS += -Isecurity/selinux/include 
 obj-y := ss.o
 
 ss-objs := ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o
Index: linux-2.6/security/selinux/ss/avtab.c
diff -u linux-2.6/security/selinux/ss/avtab.c:1.1.1.2 linux-2.6/security/selinux/ss/avtab.c:1.15
--- linux-2.6/security/selinux/ss/avtab.c:1.1.1.2	Tue Sep  9 08:50:50 2003
+++ linux-2.6/security/selinux/ss/avtab.c	Tue Oct 28 09:08:27 2003
@@ -3,6 +3,10 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/errno.h>
 #include "avtab.h"
 #include "policydb.h"
 
Index: linux-2.6/security/selinux/ss/ebitmap.c
diff -u linux-2.6/security/selinux/ss/ebitmap.c:1.1.1.2 linux-2.6/security/selinux/ss/ebitmap.c:1.13
--- linux-2.6/security/selinux/ss/ebitmap.c:1.1.1.2	Tue Sep  9 08:50:50 2003
+++ linux-2.6/security/selinux/ss/ebitmap.c	Tue Oct 28 09:08:27 2003
@@ -3,6 +3,9 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
 #include "ebitmap.h"
 #include "policydb.h"
 
Index: linux-2.6/security/selinux/ss/global.h
diff -u linux-2.6/security/selinux/ss/global.h:1.1.1.3 linux-2.6/security/selinux/ss/global.h:removed
--- linux-2.6/security/selinux/ss/global.h:1.1.1.3	Tue Sep  9 08:50:51 2003
+++ linux-2.6/security/selinux/ss/global.h	Tue Nov  4 08:09:07 2003
@@ -1,18 +0,0 @@
-#ifndef _SS_GLOBAL_H_
-#define _SS_GLOBAL_H_
-
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/ctype.h>
-#include <linux/in.h>
-#include <linux/spinlock.h>
-#include <linux/sched.h>
-#include <linux/vmalloc.h>
-
-#include "flask.h"
-#include "avc.h"
-#include "avc_ss.h"
-#include "security.h"
-
-#endif /* _SS_GLOBAL_H_ */
Index: linux-2.6/security/selinux/ss/hashtab.c
diff -u linux-2.6/security/selinux/ss/hashtab.c:1.1.1.1 linux-2.6/security/selinux/ss/hashtab.c:1.7
--- linux-2.6/security/selinux/ss/hashtab.c:1.1.1.1	Tue Aug 12 09:05:08 2003
+++ linux-2.6/security/selinux/ss/hashtab.c	Tue Oct 28 09:08:27 2003
@@ -3,6 +3,9 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
 #include "hashtab.h"
 
 struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, void *key),
Index: linux-2.6/security/selinux/ss/mls.c
diff -u linux-2.6/security/selinux/ss/mls.c:1.1.1.2 linux-2.6/security/selinux/ss/mls.c:1.18
--- linux-2.6/security/selinux/ss/mls.c:1.1.1.2	Mon Sep 29 09:14:40 2003
+++ linux-2.6/security/selinux/ss/mls.c	Tue Oct 28 09:08:27 2003
@@ -3,6 +3,10 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/errno.h>
 #include "mls.h"
 #include "policydb.h"
 #include "services.h"
Index: linux-2.6/security/selinux/ss/policydb.c
diff -u linux-2.6/security/selinux/ss/policydb.c:1.1.1.4 linux-2.6/security/selinux/ss/policydb.c:1.26
--- linux-2.6/security/selinux/ss/policydb.c:1.1.1.4	Mon Sep 29 09:14:41 2003
+++ linux-2.6/security/selinux/ss/policydb.c	Tue Oct 28 09:08:27 2003
@@ -3,6 +3,11 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include "security.h"
 #include "policydb.h"
 #include "mls.h"
 
Index: linux-2.6/security/selinux/ss/services.c
diff -u linux-2.6/security/selinux/ss/services.c:1.1.1.2 linux-2.6/security/selinux/ss/services.c:1.30
--- linux-2.6/security/selinux/ss/services.c:1.1.1.2	Thu Oct  9 08:48:31 2003
+++ linux-2.6/security/selinux/ss/services.c	Tue Oct 28 09:08:27 2003
@@ -10,6 +10,17 @@
  *	it under the terms of the GNU General Public License version 2,
  *      as published by the Free Software Foundation.
  */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
+#include <linux/in.h>
+#include <asm/semaphore.h>
+#include "flask.h"
+#include "avc.h"
+#include "avc_ss.h"
+#include "security.h"
 #include "context.h"
 #include "policydb.h"
 #include "sidtab.h"
Index: linux-2.6/security/selinux/ss/sidtab.c
diff -u linux-2.6/security/selinux/ss/sidtab.c:1.1.1.1 linux-2.6/security/selinux/ss/sidtab.c:1.13
--- linux-2.6/security/selinux/ss/sidtab.c:1.1.1.1	Tue Aug 12 09:05:07 2003
+++ linux-2.6/security/selinux/ss/sidtab.c	Tue Oct 28 09:08:27 2003
@@ -3,6 +3,12 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
+#include "flask.h"
+#include "security.h"
 #include "sidtab.h"
 
 #define SIDTAB_HASH(sid) \
Index: linux-2.6/security/selinux/ss/symtab.c
diff -u linux-2.6/security/selinux/ss/symtab.c:1.1.1.1 linux-2.6/security/selinux/ss/symtab.c:1.5
--- linux-2.6/security/selinux/ss/symtab.c:1.1.1.1	Tue Aug 12 09:05:08 2003
+++ linux-2.6/security/selinux/ss/symtab.c	Tue Oct 28 09:08:27 2003
@@ -3,6 +3,10 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/errno.h>
 #include "symtab.h"
 
 static unsigned int symhash(struct hashtab *h, void *key)

--=-n7Qs+u3NG1CK+/xrNqyP
Content-Disposition: attachment; filename=policy-siginh-rlimit.patch
Content-Type: text/plain; name=policy-siginh-rlimit.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


 flask/access_vectors  |    3 +++
 macros/core_macros.te |   12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

Index: policy/flask/access_vectors
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/flask/access_vectors,v
retrieving revision 1.2
retrieving revision 1.3
diff -u -r1.2 -r1.3
--- policy/flask/access_vectors	24 Jun 2003 16:43:54 -0000	1.2
+++ policy/flask/access_vectors	31 Oct 2003 19:59:49 -0000	1.3
@@ -230,6 +230,9 @@
 	setexec
 	setfscreate
 	noatsecure
+	siginh
+	setrlimit
+	rlimitinh
 }
 
 
Index: policy/macros/core_macros.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/core_macros.te,v
retrieving revision 1.2
retrieving revision 1.3
diff -u -r1.2 -r1.3
--- policy/macros/core_macros.te	27 Sep 2003 19:18:25 -0000	1.2
+++ policy/macros/core_macros.te	4 Nov 2003 13:37:34 -0000	1.3
@@ -271,6 +271,16 @@
 dontaudit $1 $3:process noatsecure;
 
 #
+# Do not audit when signal-related state is cleared upon the transition.
+#
+dontaudit $1 $3:process siginh;
+
+#
+# Do not audit when resource limits are reset upon the transition.
+#
+dontaudit $1 $3:process rlimitinh;
+
+#
 # Allow the process to execute the program.
 # 
 allow $1 $2:file { read x_file_perms };
@@ -513,7 +523,7 @@
 # Access other processes in the same domain.
 # Omits ptrace, setexec, and setfscreate.  These must be granted 
 # separately if desired.
-allow $1 self:process ~{ptrace setexec setfscreate};
+allow $1 self:process ~{ptrace setexec setfscreate setrlimit};
 
 # Access /proc/PID files for processes in the same domain.
 allow $1 self:dir r_dir_perms;

--=-n7Qs+u3NG1CK+/xrNqyP--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
