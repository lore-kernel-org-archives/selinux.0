Subject: [PATCH] sched: Add security hooks to {get,set}affinity
From: David Quigley <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@redhat.com
Content-Type: text/plain
Date: Tue, 20 Jun 2006 12:51:25 -0400
Message-Id: <1150822285.15368.15.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: David Quigley <dpquigl@tycho.nsa.gov>

This patch adds LSM hooks into the setaffinity and getaffinity
functions to enable security modules to control these operations
between tasks with different security attributes. This implementation
uses the existing task_setscheduler and task_getscheduler LSM hooks.

Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>
---

kernel/sched.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-rc6-mm2/kernel/sched.c linux-2.6.17-rc6-mm2-affinity/kernel/sched.c
--- linux-2.6.17-rc6-mm2/kernel/sched.c	2006-06-15 09:46:28.000000000 -0400
+++ linux-2.6.17-rc6-mm2-affinity/kernel/sched.c	2006-06-15 09:51:55.000000000 -0400
@@ -4266,6 +4266,10 @@ long sched_setaffinity(pid_t pid, cpumas
 			!capable(CAP_SYS_NICE))
 		goto out_unlock;
 
+	retval = security_task_setscheduler(p, 0, NULL);
+	if (retval)
+		goto out_unlock;
+
 	cpus_allowed = cpuset_cpus_allowed(p);
 	cpus_and(new_mask, new_mask, cpus_allowed);
 	retval = set_cpus_allowed(p, new_mask);
@@ -4334,7 +4338,10 @@ long sched_getaffinity(pid_t pid, cpumas
 	if (!p)
 		goto out_unlock;
 
-	retval = 0;
+	retval = security_task_getscheduler(p);
+	if (retval)
+		goto out_unlock;
+
 	cpus_and(*mask, p->cpus_allowed, cpu_online_map);
 
 out_unlock:


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
