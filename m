Subject: [PATCH 1/2] security: Add security hook definitions for
	setmempolicy
From: David Quigley <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, dpquigl@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Tue, 20 Jun 2006 14:30:29 -0400
Message-Id: <1150828229.19385.15.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: David Quigley <dpquigl@tycho.nsa.gov>

This patch adds new security hook definitions for the setmempolicy
operation.  At present, the SELinux hook function implementation for
this hook is identical to the setscheduler implementation, but a
separate hook introduced to allow this check to be specialized in the
future if necessary.

Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>

---

include/linux/security.h |   16 ++++++++++++++++
security/dummy.c         |    6 ++++++
security/selinux/hooks.c |    6 ++++++
3 files changed, 28 insertions(+)

diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-rc6-mm2/include/linux/security.h linux-2.6.17-rc6-mm2-mempolicy/include/linux/security.h
--- linux-2.6.17-rc6-mm2/include/linux/security.h	2006-06-15 09:46:28.000000000 -0400
+++ linux-2.6.17-rc6-mm2-mempolicy/include/linux/security.h	2006-06-20 12:41:08.000000000 -0400
@@ -601,6 +601,11 @@ struct swap_info_struct;
  *	@p.
  *	@p contains the task_struct for process.
  *	Return 0 if permission is granted.
+ * @task_setmempolicy
+ *	Check permission before setting memory policy and/or parameters of
+ *	process @p.
+ *	@p contains the task_struct for process.
+ *	Return 0 if permission is granted.
  * @task_kill:
  *	Check permission before sending signal @sig to @p.  @info can be NULL,
  *	the constant 1, or a pointer to a siginfo structure.  If @info is 1 or
@@ -1220,6 +1225,7 @@ struct security_operations {
 	int (*task_setscheduler) (struct task_struct * p, int policy,
 				  struct sched_param * lp);
 	int (*task_getscheduler) (struct task_struct * p);
+	int (*task_setmempolicy) (struct task_struct * p); 
 	int (*task_kill) (struct task_struct * p,
 			  struct siginfo * info, int sig);
 	int (*task_wait) (struct task_struct * p);
@@ -1865,6 +1871,11 @@ static inline int security_task_getsched
 	return security_ops->task_getscheduler (p);
 }
 
+static inline int security_task_setmempolicy (struct task_struct *p)
+{
+	return security_ops->task_setmempolicy (p);
+}
+
 static inline int security_task_kill (struct task_struct *p,
 				      struct siginfo *info, int sig)
 {
@@ -2512,6 +2523,11 @@ static inline int security_task_getsched
 	return 0;
 }
 
+static inline int security_task_setmempolicy (struct task_struct *p)
+{
+	return 0;
+}
+
 static inline int security_task_kill (struct task_struct *p,
 				      struct siginfo *info, int sig)
 {
diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-rc6-mm2/security/dummy.c linux-2.6.17-rc6-mm2-mempolicy/security/dummy.c
--- linux-2.6.17-rc6-mm2/security/dummy.c	2006-06-15 09:46:29.000000000 -0400
+++ linux-2.6.17-rc6-mm2-mempolicy/security/dummy.c	2006-06-20 12:41:23.000000000 -0400
@@ -537,6 +537,11 @@ static int dummy_task_getscheduler (stru
 	return 0;
 }
 
+static int dummy_task_setmempolicy (struct task_struct *p)
+{
+	return 0;
+}
+
 static int dummy_task_wait (struct task_struct *p)
 {
 	return 0;
@@ -981,6 +986,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, task_setrlimit);
 	set_to_dummy_if_null(ops, task_setscheduler);
 	set_to_dummy_if_null(ops, task_getscheduler);
+	set_to_dummy_if_null(ops, task_setmempolicy);
 	set_to_dummy_if_null(ops, task_wait);
 	set_to_dummy_if_null(ops, task_kill);
 	set_to_dummy_if_null(ops, task_prctl);
diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-rc6-mm2/security/selinux/hooks.c linux-2.6.17-rc6-mm2-mempolicy/security/selinux/hooks.c
--- linux-2.6.17-rc6-mm2/security/selinux/hooks.c	2006-06-15 09:46:29.000000000 -0400
+++ linux-2.6.17-rc6-mm2-mempolicy/security/selinux/hooks.c	2006-06-20 12:41:57.000000000 -0400
@@ -2679,6 +2679,11 @@ static int selinux_task_getscheduler(str
 	return task_has_perm(current, p, PROCESS__GETSCHED);
 }
 
+static int selinux_task_setmempolicy(struct task_struct *p)
+{
+	return task_has_perm(current, p, PROCESS__SETSCHED);
+}
+
 static int selinux_task_kill(struct task_struct *p, struct siginfo *info, int sig)
 {
 	u32 perm;
@@ -4392,6 +4397,7 @@ static struct security_operations selinu
 	.task_setrlimit =		selinux_task_setrlimit,
 	.task_setscheduler =		selinux_task_setscheduler,
 	.task_getscheduler =		selinux_task_getscheduler,
+	.task_setmempolicy =		selinux_task_setmempolicy,
 	.task_kill =			selinux_task_kill,
 	.task_wait =			selinux_task_wait,
 	.task_prctl =			selinux_task_prctl,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
