Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9KHfRXZ002351
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2004 13:41:27 -0400 (EDT)
Date: Wed, 20 Oct 2004 10:41:24 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Chris Wright <chrisw@osdl.org>, James Morris <jmorris@redhat.com>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
Message-ID: <20041020104123.J2357@build.pdx.osdl.net>
References: <1098217020.29525.183.camel@moss-spartans.epoch.ncsc.mil> <Xine.LNX.4.44.0410191635070.30036-100000@thoron.boston.redhat.com> <20041019140947.G2357@build.pdx.osdl.net> <1098275010.672.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098275010.672.41.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Wed, Oct 20, 2004 at 08:23:31AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Tue, 2004-10-19 at 17:09, Chris Wright wrote:
> > * James Morris (jmorris@redhat.com) wrote:
> > > Yes, it's the runqueue lock.  One simple possibility would be to convert
> > > the audit code over to use the keventd workqueue, and use
> > > schedule_delayed_work() to kick the audit logging via a timer in this
> > > case.
> > 
> > Yeah, guess that would work, but it's not that nice a solution ;-/
> 
> And requiring security modules to special case CAP_SYS_NICE auditing in
> their capable() hooks and any auditing in their setscheduler() hooks
> seems very unpleasant anyway.  I'd actually favor one of:
> - Fix John's setscheduler patch to hold the lock while extracting
> p->policy, drop it for the security checks, re-take the lock, and verify
> that p->policy hasn't changed (if it has, bail with EPERM, as I can't
> see any legitimate reason for such a race other than an intentional
> malicious attempt to exploit it), or

Unfortunately, policy < 0 is not really POSIX compliant, but it's
documented behaviour, so changing this would change the ABI, and could
break something.  Otherwise, the simplest would be remove that bit
altogether.  Don't think we need to hold lock while sampling the value,
since it should be processor word-sized value, nothing odd on loading
should happen.  It's possible to loop and recheck, but w/out convincing
oneself that livelock is not possible, -EPERM and return seems quite
valid for this very unlikely case.  Untested patch below.

===== kernel/sched.c 1.367 vs edited =====
--- 1.367/kernel/sched.c	2004-10-18 22:26:52 -07:00
+++ edited/kernel/sched.c	2004-10-20 10:26:19 -07:00
@@ -3038,7 +3038,7 @@
 {
 	struct sched_param lp;
 	int retval = -EINVAL;
-	int oldprio;
+	int oldprio, oldpolicy;
 	prio_array_t *array;
 	unsigned long flags;
 	runqueue_t *rq;
@@ -3060,23 +3060,18 @@
 
 	retval = -ESRCH;
 	if (!p)
-		goto out_unlock_tasklist;
-
-	/*
-	 * To be able to change p->policy safely, the apropriate
-	 * runqueue lock must be held.
-	 */
-	rq = task_rq_lock(p, &flags);
+		goto out_unlock;
 
+	/* double check policy once rq lock held */
+	oldpolicy = p->policy;
 	if (policy < 0)
-		policy = p->policy;
+		policy = oldpolicy;
 	else {
 		retval = -EINVAL;
 		if (policy != SCHED_FIFO && policy != SCHED_RR &&
 				policy != SCHED_NORMAL)
 			goto out_unlock;
 	}
-
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
 	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL is 0.
@@ -3098,7 +3093,15 @@
 	retval = security_task_setscheduler(p, policy, &lp);
 	if (retval)
 		goto out_unlock;
-
+	/*
+	 * To be able to change p->policy safely, the apropriate
+	 * runqueue lock must be held.
+	 */
+	rq = task_rq_lock(p, &flags);
+	/* recheck policy now with rq lock held */
+	retval = -EPERM;
+	if (unlikely(oldpolicy != p->policy))
+		goto out_unlock_rq;
 	array = p->array;
 	if (array)
 		deactivate_task(p, task_rq(p));
@@ -3118,12 +3121,10 @@
 		} else if (TASK_PREEMPTS_CURR(p, rq))
 			resched_task(rq->curr);
 	}
-
-out_unlock:
+out_unlock_rq:
 	task_rq_unlock(rq, &flags);
-out_unlock_tasklist:
+out_unlock:
 	read_unlock_irq(&tasklist_lock);
-
 out_nounlock:
 	return retval;
 }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
