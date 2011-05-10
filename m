Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4AHGVfl009263
	for <selinux@tycho.nsa.gov>; Tue, 10 May 2011 13:16:31 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p4AHGTFP007041
	for <selinux@tycho.nsa.gov>; Tue, 10 May 2011 17:16:30 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] SELinux: Fix an RCU dereference warning in
 selinux_setprocattr()
To: jmorris@namei.org
Cc: selinux@tycho.nsa.gov, oleg@redhat.com,
        David Howells <dhowells@redhat.com>
Date: Tue, 10 May 2011 18:16:24 +0100
Message-ID: <20110510171624.2404.34852.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix an RCU dereference warning in selinux_setprocattr() due to
tracehook_tracer_task() requiring to be called with the RCU read lock held.

The caller holds task_struct::alloc_lock on the current process, but it's not
clear whether that should be sufficient.  Looking at ptrace_detach(), it does
not appear to be (holding tasklist_lock should be), but the alloc_lock isn't
taken whilst ptrace is attaching/detaching.

Deal with this by wrapping the call in the RCU read lock in addition to a
spinlock.  If we do this, then we don't need the lock of task_sid(), so a
__task_sid() is added that assumes the caller holds the lock and
selinux_setprocattr() is made to use that.

I wonder...  should it be possible to dispense with the call to task_lock()
entirely and depend on just the RCU read lock?

The report looks like the following:

===================================================
[ INFO: suspicious rcu_dereference_check() usage. ]
---------------------------------------------------
include/linux/tracehook.h:182 invoked rcu_dereference_check() without protection!

other info that might help us debug this:

rcu_scheduler_active = 1, debug_locks = 0
2 locks held by child/2672:
 #0:  (&sig->cred_guard_mutex){+.+.+.}, at: [<ffffffff811d4200>] proc_pid_attr_write+0x10b/0x1b9
 #1:  (&(&p->alloc_lock)->rlock){+.+...}, at: [<ffffffff81313f03>] selinux_setprocattr+0x52e/0x7b0

stack backtrace:
Pid: 2672, comm: child Not tainted 2.6.39-rc7-fsdevel+ #672
Call Trace:
 [<ffffffff81096b4f>] lockdep_rcu_dereference+0xf7/0x107
 [<ffffffff81313f8d>] selinux_setprocattr+0x5b8/0x7b0
 [<ffffffff8130c697>] security_setprocattr+0x1d/0x26
 [<ffffffff811d422b>] proc_pid_attr_write+0x136/0x1b9
 [<ffffffff8115a277>] vfs_write+0xe7/0x1cf
 [<ffffffff8115a683>] sys_write+0x5f/0x9b
 [<ffffffff816dd9eb>] system_call_fastpath+0x16/0x1b

This can be reproduced by running the SELinux testsuite.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/selinux/hooks.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8fb2488..38dd539 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -171,6 +171,15 @@ static inline u32 cred_sid(const struct cred *cred)
 }
 
 /*
+ * Get the objective security ID of a task for a caller who is holding the RCU
+ * read lock.
+ */
+static inline u32 __task_sid(const struct task_struct *task)
+{
+	return cred_sid(__task_cred(task));
+}
+
+/*
  * get the objective security ID of a task
  */
 static inline u32 task_sid(const struct task_struct *task)
@@ -178,7 +187,7 @@ static inline u32 task_sid(const struct task_struct *task)
 	u32 sid;
 
 	rcu_read_lock();
-	sid = cred_sid(__task_cred(task));
+	sid = __task_sid(task);
 	rcu_read_unlock();
 	return sid;
 }
@@ -5295,11 +5304,13 @@ static int selinux_setprocattr(struct task_struct *p,
 		/* Check for ptracing, and update the task SID if ok.
 		   Otherwise, leave SID unchanged and fail. */
 		ptsid = 0;
+		rcu_read_lock();
 		task_lock(p);
 		tracer = tracehook_tracer_task(p);
 		if (tracer)
-			ptsid = task_sid(tracer);
+			ptsid = __task_sid(p);
 		task_unlock(p);
+		rcu_read_unlock();
 
 		if (tracer) {
 			error = avc_has_perm(ptsid, sid, SECCLASS_PROCESS,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
