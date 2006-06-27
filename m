Subject: [PATCH] sched: Add security hooks to mips {get,set}affinity
From: David Quigley <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@iname.org
Content-Type: text/plain
Date: Tue, 27 Jun 2006 16:07:34 -0400
Message-Id: <1151438854.1294.14.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: David Quigley <dpquigl@tycho.nsa.gov>

This patch adds LSM hooks into the setaffinity and getaffinity
functions for the mips architecture to enable security modules to
control these operations between tasks with different security
attributes. This implementation uses the existing task_setscheduler
and task_getscheduler LSM hooks.

Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>
---

 arch/mips/kernel/mips-mt.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/arch/mips/kernel/mips-mt.c linux-2.6.17-mm3-affiniy/arch/mips/kernel/mips-mt.c
--- linux-2.6.17-mm3/arch/mips/kernel/mips-mt.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm3-affiniy/arch/mips/kernel/mips-mt.c	2006-06-27 15:47:46.000000000 -0400
@@ -95,6 +95,10 @@ asmlinkage long mipsmt_sys_sched_setaffi
 		goto out_unlock;
 	}
 
+	retval = security_task_setscheduler(p, 0, NULL);
+	if (retval)
+		goto out_unlock;
+
 	/* Record new user-specified CPU set for future reference */
 	p->thread.user_cpus_allowed = new_mask;
 
@@ -140,8 +144,9 @@ asmlinkage long mipsmt_sys_sched_getaffi
 	p = find_process_by_pid(pid);
 	if (!p)
 		goto out_unlock;
-
-	retval = 0;
+	retval = security_task_getscheduler(p);
+	if (retval)
+		goto out_unlock;
 
 	cpus_and(mask, p->thread.user_cpus_allowed, cpu_possible_map);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
