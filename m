Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7ULDWqB017966
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 17:13:32 -0400
Subject: [PATCH] audit: consistently record PIDs with task_tgid_nr()
From: Paul Moore <pmoore@redhat.com>
To: Jeff Vander Stoep <jeffv@google.com>, linux-audit@redhat.com
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Date: Tue, 30 Aug 2016 17:13:21 -0400
Message-ID: <147259160184.15526.16504125805093739705.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

Unfortunately we record PIDs in audit records using a variety of
methods despite the correct way being the use of task_tgid_nr().
This patch converts all of these callers, except for the case of
AUDIT_SET in audit_receive_msg() (see the comment in the code).

Reported-by: Jeff Vander Stoep <jeffv@google.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 kernel/audit.c       |    8 +++++++-
 kernel/auditsc.c     |   12 ++++++------
 security/lsm_audit.c |    4 ++--
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 8d528f9..02bde12 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -877,6 +877,12 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				return err;
 		}
 		if (s.mask & AUDIT_STATUS_PID) {
+			/* NOTE: we are using task_tgid_vnr() below because
+			 *       the s.pid value is relative to the namespace
+			 *       of the caller; at present this doesn't matter
+			 *       much since you can really only run auditd
+			 *       from the initial pid namespace, but something
+			 *       to keep in mind if this changes */
 			int new_pid = s.pid;
 			pid_t requesting_pid = task_tgid_vnr(current);
 
@@ -1917,7 +1923,7 @@ void audit_log_task_info(struct audit_buffer *ab, struct task_struct *tsk)
 			 " euid=%u suid=%u fsuid=%u"
 			 " egid=%u sgid=%u fsgid=%u tty=%s ses=%u",
 			 task_ppid_nr(tsk),
-			 task_pid_nr(tsk),
+			 task_tgid_nr(tsk),
 			 from_kuid(&init_user_ns, audit_get_loginuid(tsk)),
 			 from_kuid(&init_user_ns, cred->uid),
 			 from_kgid(&init_user_ns, cred->gid),
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 2672d10..3824b1b 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -455,7 +455,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 
 		switch (f->type) {
 		case AUDIT_PID:
-			pid = task_pid_nr(tsk);
+			pid = task_tgid_nr(tsk);
 			result = audit_comparator(pid, f->op, f->val);
 			break;
 		case AUDIT_PPID:
@@ -1993,7 +1993,7 @@ static void audit_log_set_loginuid(kuid_t koldloginuid, kuid_t kloginuid,
 	loginuid = from_kuid(&init_user_ns, kloginuid),
 	tty = audit_get_tty(current);
 
-	audit_log_format(ab, "pid=%d uid=%u", task_pid_nr(current), uid);
+	audit_log_format(ab, "pid=%d uid=%u", task_tgid_nr(current), uid);
 	audit_log_task_context(ab);
 	audit_log_format(ab, " old-auid=%u auid=%u tty=%s old-ses=%u ses=%u res=%d",
 			 oldloginuid, loginuid, tty ? tty_name(tty) : "(none)",
@@ -2220,7 +2220,7 @@ void __audit_ptrace(struct task_struct *t)
 {
 	struct audit_context *context = current->audit_context;
 
-	context->target_pid = task_pid_nr(t);
+	context->target_pid = task_tgid_nr(t);
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
@@ -2245,7 +2245,7 @@ int __audit_signal_info(int sig, struct task_struct *t)
 
 	if (audit_pid && t->tgid == audit_pid) {
 		if (sig == SIGTERM || sig == SIGHUP || sig == SIGUSR1 || sig == SIGUSR2) {
-			audit_sig_pid = task_pid_nr(tsk);
+			audit_sig_pid = task_tgid_nr(tsk);
 			if (uid_valid(tsk->loginuid))
 				audit_sig_uid = tsk->loginuid;
 			else
@@ -2345,7 +2345,7 @@ int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
 void __audit_log_capset(const struct cred *new, const struct cred *old)
 {
 	struct audit_context *context = current->audit_context;
-	context->capset.pid = task_pid_nr(current);
+	context->capset.pid = task_tgid_nr(current);
 	context->capset.cap.effective   = new->cap_effective;
 	context->capset.cap.inheritable = new->cap_effective;
 	context->capset.cap.permitted   = new->cap_permitted;
@@ -2377,7 +2377,7 @@ static void audit_log_task(struct audit_buffer *ab)
 			 from_kgid(&init_user_ns, gid),
 			 sessionid);
 	audit_log_task_context(ab);
-	audit_log_format(ab, " pid=%d comm=", task_pid_nr(current));
+	audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
 	audit_log_untrustedstring(ab, get_task_comm(comm, current));
 	audit_log_d_path_exe(ab, current->mm);
 }
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index cccbf30..45d927a 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -220,7 +220,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	 */
 	BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
 
-	audit_log_format(ab, " pid=%d comm=", task_pid_nr(current));
+	audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
 	audit_log_untrustedstring(ab, memcpy(comm, current->comm, sizeof(comm)));
 
 	switch (a->type) {
@@ -294,7 +294,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	case LSM_AUDIT_DATA_TASK: {
 		struct task_struct *tsk = a->u.tsk;
 		if (tsk) {
-			pid_t pid = task_pid_nr(tsk);
+			pid_t pid = task_tgid_nr(tsk);
 			if (pid) {
 				char comm[sizeof(tsk->comm)];
 				audit_log_format(ab, " opid=%d ocomm=", pid);
