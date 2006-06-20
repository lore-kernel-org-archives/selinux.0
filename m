Subject: [PATCH] cpuset: Add security hook call to mediate attach_task
From: David Quigley <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Tue, 20 Jun 2006 12:54:10 -0400
Message-Id: <1150822450.15368.18.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: David Quigley <dpquigl@tycho.nsa.gov>

This patch adds a security hook call to enable security modules to
control the ability to attach a task to a cpuset.  While limited control
over this operation is possible via permission checks on the pseudo fs
interface, those checks are not sufficient to control access to the
target task, which is looked up in this function.  The existing
task_setscheduler hook is re-used for this operation since this falls
under the same class of operations.

Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>

---

 kernel/cpuset.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-rc6-mm2/kernel/cpuset.c linux-2.6.17-rc6-mm2-attach/kernel/cpuset.c
--- linux-2.6.17-rc6-mm2/kernel/cpuset.c	2006-06-15 09:46:28.000000000 -0400
+++ linux-2.6.17-rc6-mm2-attach/kernel/cpuset.c	2006-06-15 09:52:43.000000000 -0400
@@ -41,6 +41,7 @@
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
@@ -1177,6 +1178,7 @@ static int attach_task(struct cpuset *cs
 	cpumask_t cpus;
 	nodemask_t from, to;
 	struct mm_struct *mm;
+	int retval;
 
 	if (sscanf(pidbuf, "%d", &pid) != 1)
 		return -EIO;
@@ -1205,6 +1207,12 @@ static int attach_task(struct cpuset *cs
 		get_task_struct(tsk);
 	}
 
+	retval = security_task_setscheduler(tsk, 0, NULL);
+	if (retval) {
+		put_task_struct(tsk);
+		return retval;
+	}
+
 	mutex_lock(&callback_mutex);
 
 	task_lock(tsk);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
