Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w44KtLm7032021
 for <selinux@tycho.nsa.gov>; Fri, 4 May 2018 16:55:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID07.oob.disa.mil (Postfix) with SMTP id 40d46935Chz17xpj
 for <selinux@tycho.nsa.gov>; Fri,  4 May 2018 20:55:29 +0000 (UTC)
Received: from USFB3CPA06_EEMSG_MP28.eemsg.mil (unknown [192.168.16.23])
 by USFBF3ID07.oob.disa.mil (Postfix) with ESMTP id 40d4685NZRz17xpy
 for <selinux@tycho.nsa.gov>; Fri,  4 May 2018 20:55:28 +0000 (UTC)
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
 Netfilter Devel List <netfilter-devel@vger.kernel.org>,
 Linux Security Module list <linux-security-module@vger.kernel.org>,
 Integrity Measurement Architecture <linux-integrity@vger.kernel.org>,
 SElinux list <selinux@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
 Steve Grubb <sgrubb@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 David Howells <dhowells@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Date: Fri,  4 May 2018 16:54:37 -0400
Message-Id: <2f0566af8ccafdaf400a3d002cb4aef9b80e44cf.1525466167.git.rgb@redhat.com>
In-Reply-To: <cover.1525466167.git.rgb@redhat.com>
References: <cover.1525466167.git.rgb@redhat.com>
In-Reply-To: <cover.1525466167.git.rgb@redhat.com>
References: <cover.1525466167.git.rgb@redhat.com>
Subject: [PATCH ghak81 RFC V1 4/5] audit: use inline function to set
 audit context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Recognizing that the audit context is an internal audit value, use an
access function to set the audit context pointer for the task
rather than reaching directly into the task struct to set it.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 include/linux/audit.h | 8 ++++++++
 kernel/auditsc.c      | 6 +++---
 kernel/fork.c         | 2 +-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 93e4c61..dba0d45 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -235,6 +235,10 @@ extern void __audit_inode_child(struct inode *parent,
 extern void __audit_seccomp(unsigned long syscall, long signr, int code);
 extern void __audit_ptrace(struct task_struct *t);
 
+static inline void audit_set_context(struct task_struct *task, struct audit_context *ctx)
+{
+	task->audit_context = ctx;
+}
 static inline struct audit_context *audit_context(struct task_struct *task)
 {
 	return task->audit_context;
@@ -472,6 +476,10 @@ static inline bool audit_dummy_context(void)
 {
 	return true;
 }
+static inline void audit_set_context(struct task_struct *task, struct audit_context *ctx)
+{
+	task->audit_context = ctx;
+}
 static inline struct audit_context *audit_context(struct task_struct *task)
 {
 	return NULL;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index a4bbdcc..f294e4a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -865,7 +865,7 @@ static inline struct audit_context *audit_take_context(struct task_struct *tsk,
 		audit_filter_inodes(tsk, context);
 	}
 
-	tsk->audit_context = NULL;
+	audit_set_context(tsk, NULL);
 	return context;
 }
 
@@ -952,7 +952,7 @@ int audit_alloc(struct task_struct *tsk)
 	}
 	context->filterkey = key;
 
-	tsk->audit_context  = context;
+	audit_set_context(tsk, context);
 	set_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
 	return 0;
 }
@@ -1590,7 +1590,7 @@ void __audit_syscall_exit(int success, long return_code)
 		kfree(context->filterkey);
 		context->filterkey = NULL;
 	}
-	tsk->audit_context = context;
+	audit_set_context(tsk, context);
 }
 
 static inline void handle_one(const struct inode *inode)
diff --git a/kernel/fork.c b/kernel/fork.c
index 242c8c9..cd18448 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1713,7 +1713,7 @@ static __latent_entropy struct task_struct *copy_process(
 	p->start_time = ktime_get_ns();
 	p->real_start_time = ktime_get_boot_ns();
 	p->io_context = NULL;
-	p->audit_context = NULL;
+	audit_set_context(p, NULL);
 	cgroup_fork(p);
 #ifdef CONFIG_NUMA
 	p->mempolicy = mpol_dup(p->mempolicy);
-- 
1.8.3.1
