Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09DVAoJ020331
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 08:31:10 -0500
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: [PATCH] LSM: Pass commname via get_task_comm()
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-Id: <201401092230.HHH60427.SVQFOOtFLMJHOF@I-love.SAKURA.ne.jp>
Date: Thu, 9 Jan 2014 22:30:44 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: james.l.morris@oracle.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Can dump_common_audit_data() be called from interrupt context?
If yes, we cannot use get_task_comm().
Please run your testcases with lockdep-related debug options enabled.
--------------------
>From d63a8597bb1f24aac836ef031e7b6a3958406655 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 24 Dec 2013 17:34:08 +0900
Subject: [PATCH] LSM: Pass commname via get_task_comm()

When we pass task->comm to audit_log_untrustedstring(), we need to pass it via
get_task_comm() because task->comm can be changed to contain control character
by other threads after audit_log_untrustedstring() confirmed that task->comm
does not contain control character.

Pass task->comm via get_task_comm().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/lsm_audit.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 9a62045..6291c67 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -212,6 +212,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 				   struct common_audit_data *a)
 {
 	struct task_struct *tsk = current;
+	char name[TASK_COMM_LEN];
 
 	/*
 	 * To keep stack sizes in check force programers to notice if they
@@ -221,7 +222,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
 
 	audit_log_format(ab, " pid=%d comm=", tsk->pid);
-	audit_log_untrustedstring(ab, tsk->comm);
+	audit_log_untrustedstring(ab, get_task_comm(name, tsk));
 
 	switch (a->type) {
 	case LSM_AUDIT_DATA_NONE:
@@ -280,7 +281,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		tsk = a->u.tsk;
 		if (tsk && tsk->pid) {
 			audit_log_format(ab, " pid=%d comm=", tsk->pid);
-			audit_log_untrustedstring(ab, tsk->comm);
+			audit_log_untrustedstring(ab, get_task_comm(name, tsk));
 		}
 		break;
 	case LSM_AUDIT_DATA_NET:
-- 
1.7.1
