Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6QEt8T5016492
 for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2016 10:55:08 -0400
Received: by mail-pa0-f48.google.com with SMTP id ks6so595647pab.0
 for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2016 07:54:48 -0700 (PDT)
From: Jeff Vander Stoep <jeffv@google.com>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, linux-audit@redhat.com,
 Jeff Vander Stoep <jeffv@google.com>
Subject: [PATCH] security: lsm_audit: print pid and tid
Date: Tue, 26 Jul 2016 07:54:30 -0700
Message-Id: <1469544870-11574-1-git-send-email-jeffv@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

dump_common_audit_data() currently contains a field for pid, but the
value printed is actually the thread ID, tid. Update this value to
return the task group ID. Add a new field for tid. With this change
the values printed by audit now match the values returned by the
getpid() and gettid() syscalls.

Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
 security/lsm_audit.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index cccbf30..57f26c1 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -220,7 +220,8 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	 */
 	BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
 
-	audit_log_format(ab, " pid=%d comm=", task_pid_nr(current));
+	audit_log_format(ab, " pid=%d tid=%d comm=", task_tgid_vnr(tsk),
+			task_pid_vnr(tsk));
 	audit_log_untrustedstring(ab, memcpy(comm, current->comm, sizeof(comm)));
 
 	switch (a->type) {
@@ -294,10 +295,12 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	case LSM_AUDIT_DATA_TASK: {
 		struct task_struct *tsk = a->u.tsk;
 		if (tsk) {
-			pid_t pid = task_pid_nr(tsk);
+			pid_t pid = task_tgid_vnr(tsk);
 			if (pid) {
 				char comm[sizeof(tsk->comm)];
 				audit_log_format(ab, " opid=%d ocomm=", pid);
+				audit_log_format(ab, " opid=%d otid=%d ocomm=",
+						pid, task_pid_vnr(tsk));
 				audit_log_untrustedstring(ab,
 				    memcpy(comm, tsk->comm, sizeof(comm)));
 			}
-- 
2.8.0.rc3.226.g39d4020
