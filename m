Subject: [PATCH 1/3] security:  Extend task_kill hook to handle signals
	sent by AIO completion
From: David Quigley <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Tue, 27 Jun 2006 16:01:36 -0400
Message-Id: <1151438496.1294.7.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: David Quigley <dpquigl@tycho.nsa.gov>

This patch extends the security_task_kill hook to handle signals sent
by AIO completion.  In this case, the SID of the task responsible for
the signal needs to be obtained and saved earlier, so a
security_task_getsecurityid() hook is added, and then this saved value
is passed subsequently to the extended task_kill hook for use in
checking.

Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>
---

 include/linux/security.h |   23 +++++++++++++++++++----
 security/dummy.c         |    6 +++++-
 security/selinux/hooks.c |   21 +++++++++++++++++----
 3 files changed, 41 insertions(+), 9 deletions(-)

diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/include/linux/security.h linux-2.6.17-mm3-kill/include/linux/security.h
--- linux-2.6.17-mm3/include/linux/security.h	2006-06-27 14:53:16.000000000 -0400
+++ linux-2.6.17-mm3-kill/include/linux/security.h	2006-06-27 14:46:36.000000000 -0400
@@ -567,6 +567,9 @@ struct swap_info_struct;
  *	@p.
  *	@p contains the task_struct for the process.
  *	Return 0 if permission is granted.
+ * @task_getsecurityid:
+ *	Retrieve the security identifier of the process @p.
+ *	@p contains the task_struct for the process and place is into @sid.
  * @task_setgroups:
  *	Check permission before setting the supplementary group set of the
  *	current process.
@@ -615,6 +618,7 @@ struct swap_info_struct;
  *	@p contains the task_struct for process.
  *	@info contains the signal information.
  *	@sig contains the signal value.
+ *	@sid contains the sid of the process where the signal originated
  *	Return 0 if permission is granted.
  * @task_wait:
  *	Check permission before allowing a process to reap a child process @p
@@ -1218,6 +1222,7 @@ struct security_operations {
 	int (*task_setpgid) (struct task_struct * p, pid_t pgid);
 	int (*task_getpgid) (struct task_struct * p);
 	int (*task_getsid) (struct task_struct * p);
+	void (*task_getsecurityid) (struct task_struct * p, u32 * sid);
 	int (*task_setgroups) (struct group_info *group_info);
 	int (*task_setnice) (struct task_struct * p, int nice);
 	int (*task_setioprio) (struct task_struct * p, int ioprio);
@@ -1227,7 +1232,7 @@ struct security_operations {
 	int (*task_getscheduler) (struct task_struct * p);
 	int (*task_movememory) (struct task_struct * p);
 	int (*task_kill) (struct task_struct * p,
-			  struct siginfo * info, int sig);
+			  struct siginfo * info, int sig, u32 sid);
 	int (*task_wait) (struct task_struct * p);
 	int (*task_prctl) (int option, unsigned long arg2,
 			   unsigned long arg3, unsigned long arg4,
@@ -1838,6 +1843,11 @@ static inline int security_task_getsid (
 	return security_ops->task_getsid (p);
 }
 
+static inline void security_task_getsecurityid (struct task_struct *p, u32 *sid)
+{
+	security_ops->task_getsecurityid (p, sid);
+}
+
 static inline int security_task_setgroups (struct group_info *group_info)
 {
 	return security_ops->task_setgroups (group_info);
@@ -1877,9 +1887,10 @@ static inline int security_task_movememo
 }
 
 static inline int security_task_kill (struct task_struct *p,
-				      struct siginfo *info, int sig)
+				      struct siginfo *info, int sig,
+				      u32 sid)
 {
-	return security_ops->task_kill (p, info, sig);
+	return security_ops->task_kill (p, info, sig, sid);
 }
 
 static inline int security_task_wait (struct task_struct *p)
@@ -2490,6 +2501,9 @@ static inline int security_task_getsid (
 	return 0;
 }
 
+static inline void security_task_get_securityid (struct task_struct *p, u32 *sid)
+{ }
+
 static inline int security_task_setgroups (struct group_info *group_info)
 {
 	return 0;
@@ -2529,7 +2543,8 @@ static inline int security_task_movememo
 }
 
 static inline int security_task_kill (struct task_struct *p,
-				      struct siginfo *info, int sig)
+				      struct siginfo *info, int sig,
+				      u32 sid)
 {
 	return 0;
 }
diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/security/dummy.c linux-2.6.17-mm3-kill/security/dummy.c
--- linux-2.6.17-mm3/security/dummy.c	2006-06-27 14:53:17.000000000 -0400
+++ linux-2.6.17-mm3-kill/security/dummy.c	2006-06-27 14:46:36.000000000 -0400
@@ -506,6 +506,9 @@ static int dummy_task_getsid (struct tas
 	return 0;
 }
 
+static void dummy_task_getsecurityid (struct task_struct *p, u32 *sid)
+{ }
+
 static int dummy_task_setgroups (struct group_info *group_info)
 {
 	return 0;
@@ -548,7 +551,7 @@ static int dummy_task_wait (struct task_
 }
 
 static int dummy_task_kill (struct task_struct *p, struct siginfo *info,
-			    int sig)
+			    int sig, u32 sid)
 {
 	return 0;
 }
@@ -981,6 +984,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, task_setpgid);
 	set_to_dummy_if_null(ops, task_getpgid);
 	set_to_dummy_if_null(ops, task_getsid);
+	set_to_dummy_if_null(ops, task_getsecurityid);
 	set_to_dummy_if_null(ops, task_setgroups);
 	set_to_dummy_if_null(ops, task_setnice);
 	set_to_dummy_if_null(ops, task_setioprio);
diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/security/selinux/hooks.c linux-2.6.17-mm3-kill/security/selinux/hooks.c
--- linux-2.6.17-mm3/security/selinux/hooks.c	2006-06-27 14:53:17.000000000 -0400
+++ linux-2.6.17-mm3-kill/security/selinux/hooks.c	2006-06-27 14:59:33.000000000 -0400
@@ -45,6 +45,7 @@
 #include <linux/kd.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
+#include <linux/selinux.h>
 #include <linux/tty.h>
 #include <net/icmp.h>
 #include <net/ip.h>		/* for sysctl_local_port_range[] */
@@ -2643,6 +2644,11 @@ static int selinux_task_getsid(struct ta
 	return task_has_perm(current, p, PROCESS__GETSESSION);
 }
 
+static void selinux_task_getsecurityid(struct task_struct *p, u32 *sid)
+{
+	selinux_get_task_sid(p, sid);
+}
+
 static int selinux_task_setgroups(struct group_info *group_info)
 {
 	/* See the comment for setuid above. */
@@ -2699,12 +2705,14 @@ static int selinux_task_movememory(struc
 	return task_has_perm(current, p, PROCESS__SETSCHED);
 }
 
-static int selinux_task_kill(struct task_struct *p, struct siginfo *info, int sig)
+static int selinux_task_kill(struct task_struct *p, struct siginfo *info,
+				int sig, u32 sid)
 {
 	u32 perm;
 	int rc;
+	struct task_security_struct *tsec;
 
-	rc = secondary_ops->task_kill(p, info, sig);
+	rc = secondary_ops->task_kill(p, info, sig, sid);
 	if (rc)
 		return rc;
 
@@ -2715,8 +2723,12 @@ static int selinux_task_kill(struct task
 		perm = PROCESS__SIGNULL; /* null signal; existence test */
 	else
 		perm = signal_to_av(sig);
-
-	return task_has_perm(current, p, perm);
+	tsec = p->security;
+	if (sid)
+		rc = avc_has_perm(sid, tsec->sid, SECCLASS_PROCESS, perm, NULL);
+	else
+		rc = task_has_perm(current, p, perm);
+	return rc;
 }
 
 static int selinux_task_prctl(int option,
@@ -4429,6 +4441,7 @@ static struct security_operations selinu
 	.task_setpgid =			selinux_task_setpgid,
 	.task_getpgid =			selinux_task_getpgid,
 	.task_getsid =		        selinux_task_getsid,
+	.task_getsecurityid =		selinux_task_getsecurityid,
 	.task_setgroups =		selinux_task_setgroups,
 	.task_setnice =			selinux_task_setnice,
 	.task_setioprio =		selinux_task_setioprio,



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
