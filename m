Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D58C10F00
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 21:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846D321925
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 21:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfCUVpl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:45:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbfCUVpk (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 21 Mar 2019 17:45:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 280328124A;
        Thu, 21 Mar 2019 21:45:39 +0000 (UTC)
Received: from llong.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C00B25C57E;
        Thu, 21 Mar 2019 21:45:37 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/4] signal: Make flush_sigqueue() use free_q to release memory
Date:   Thu, 21 Mar 2019 17:45:10 -0400
Message-Id: <20190321214512.11524-3-longman@redhat.com>
In-Reply-To: <20190321214512.11524-1-longman@redhat.com>
References: <20190321214512.11524-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 21 Mar 2019 21:45:39 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It was found that if a process had many pending signals (e.g. millions),
the act of exiting that process might cause its parent to have a hard
lockup especially on a debug kernel with features like KASAN enabled.
It was because the flush_sigqueue() was called in release_task() with
tasklist_lock held and irq disabled.

  [ 3133.105601] NMI watchdog: Watchdog detected hard LOCKUP on cpu 37
    :
  [ 3133.105709] CPU: 37 PID: 11200 Comm: bash Kdump: loaded Not tainted 4.18.0-80.el8.x86_64+debug #1
    :
  [ 3133.105750]  slab_free_freelist_hook+0xa0/0x120
  [ 3133.105758]  kmem_cache_free+0x9d/0x310
  [ 3133.105762]  flush_sigqueue+0x12b/0x1d0
  [ 3133.105766]  release_task.part.14+0xaf7/0x1520
  [ 3133.105784]  wait_consider_task+0x28da/0x3350
  [ 3133.105804]  do_wait+0x3eb/0x8c0
  [ 3133.105819]  kernel_wait4+0xe4/0x1b0
  [ 3133.105834]  __do_sys_wait4+0xe0/0xf0
  [ 3133.105864]  do_syscall_64+0xa5/0x4a0
  [ 3133.105868]  entry_SYSCALL_64_after_hwframe+0x6a/0xdf

[ All the "?" stack trace entries were removed from above. ]

To avoid this dire condition and reduce lock hold time of tasklist_lock,
flush_sigqueue() is modified to pass in a freeing queue pointer so that
the actual freeing of memory objects can be deferred until after the
tasklist_lock is released and irq re-enabled.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/signal.h   |  4 +++-
 kernel/exit.c            | 12 ++++++++----
 kernel/signal.c          | 27 ++++++++++++++++-----------
 security/selinux/hooks.c |  8 ++++++--
 4 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index 9702016734b1..a9562e502122 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -5,6 +5,7 @@
 #include <linux/bug.h>
 #include <linux/signal_types.h>
 #include <linux/string.h>
+#include <linux/slab.h>
 
 struct task_struct;
 
@@ -254,7 +255,8 @@ static inline void init_sigpending(struct sigpending *sig)
 	INIT_LIST_HEAD(&sig->list);
 }
 
-extern void flush_sigqueue(struct sigpending *queue);
+extern void flush_sigqueue(struct sigpending *queue,
+			   struct kmem_free_q_head *head);
 
 /* Test if 'sig' is valid signal. Use this instead of testing _NSIG directly */
 static inline int valid_signal(unsigned long sig)
diff --git a/kernel/exit.c b/kernel/exit.c
index 2166c2d92ddc..ee707a63edfd 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -88,7 +88,8 @@ static void __unhash_process(struct task_struct *p, bool group_dead)
 /*
  * This function expects the tasklist_lock write-locked.
  */
-static void __exit_signal(struct task_struct *tsk)
+static void __exit_signal(struct task_struct *tsk,
+			  struct kmem_free_q_head *free_q)
 {
 	struct signal_struct *sig = tsk->signal;
 	bool group_dead = thread_group_leader(tsk);
@@ -160,14 +161,14 @@ static void __exit_signal(struct task_struct *tsk)
 	 * Do this under ->siglock, we can race with another thread
 	 * doing sigqueue_free() if we have SIGQUEUE_PREALLOC signals.
 	 */
-	flush_sigqueue(&tsk->pending);
+	flush_sigqueue(&tsk->pending, free_q);
 	tsk->sighand = NULL;
 	spin_unlock(&sighand->siglock);
 
 	__cleanup_sighand(sighand);
 	clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
 	if (group_dead) {
-		flush_sigqueue(&sig->shared_pending);
+		flush_sigqueue(&sig->shared_pending, free_q);
 		tty_kref_put(tty);
 	}
 }
@@ -186,6 +187,8 @@ void release_task(struct task_struct *p)
 {
 	struct task_struct *leader;
 	int zap_leader;
+	DEFINE_KMEM_FREE_Q(free_q);
+
 repeat:
 	/* don't need to get the RCU readlock here - the process is dead and
 	 * can't be modifying its own credentials. But shut RCU-lockdep up */
@@ -197,7 +200,7 @@ void release_task(struct task_struct *p)
 
 	write_lock_irq(&tasklist_lock);
 	ptrace_release_task(p);
-	__exit_signal(p);
+	__exit_signal(p, &free_q);
 
 	/*
 	 * If we are the last non-leader member of the thread
@@ -219,6 +222,7 @@ void release_task(struct task_struct *p)
 	}
 
 	write_unlock_irq(&tasklist_lock);
+	kmem_free_up_q(&free_q);
 	cgroup_release(p);
 	release_thread(p);
 	call_rcu(&p->rcu, delayed_put_task_struct);
diff --git a/kernel/signal.c b/kernel/signal.c
index b7953934aa99..04fb202c16bd 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -435,16 +435,19 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags, int override_rlimi
 	return q;
 }
 
-static void __sigqueue_free(struct sigqueue *q)
+static void __sigqueue_free(struct sigqueue *q, struct kmem_free_q_head *free_q)
 {
 	if (q->flags & SIGQUEUE_PREALLOC)
 		return;
 	atomic_dec(&q->user->sigpending);
 	free_uid(q->user);
-	kmem_cache_free(sigqueue_cachep, q);
+	if (free_q)
+		kmem_free_q_add(free_q, sigqueue_cachep, q);
+	else
+		kmem_cache_free(sigqueue_cachep, q);
 }
 
-void flush_sigqueue(struct sigpending *queue)
+void flush_sigqueue(struct sigpending *queue, struct kmem_free_q_head *free_q)
 {
 	struct sigqueue *q;
 
@@ -452,7 +455,7 @@ void flush_sigqueue(struct sigpending *queue)
 	while (!list_empty(&queue->list)) {
 		q = list_entry(queue->list.next, struct sigqueue , list);
 		list_del_init(&q->list);
-		__sigqueue_free(q);
+		__sigqueue_free(q, free_q);
 	}
 }
 
@@ -462,12 +465,14 @@ void flush_sigqueue(struct sigpending *queue)
 void flush_signals(struct task_struct *t)
 {
 	unsigned long flags;
+	DEFINE_KMEM_FREE_Q(free_q);
 
 	spin_lock_irqsave(&t->sighand->siglock, flags);
 	clear_tsk_thread_flag(t, TIF_SIGPENDING);
-	flush_sigqueue(&t->pending);
-	flush_sigqueue(&t->signal->shared_pending);
+	flush_sigqueue(&t->pending, &free_q);
+	flush_sigqueue(&t->signal->shared_pending, &free_q);
 	spin_unlock_irqrestore(&t->sighand->siglock, flags);
+	kmem_free_up_q(&free_q);
 }
 EXPORT_SYMBOL(flush_signals);
 
@@ -488,7 +493,7 @@ static void __flush_itimer_signals(struct sigpending *pending)
 		} else {
 			sigdelset(&signal, sig);
 			list_del_init(&q->list);
-			__sigqueue_free(q);
+			__sigqueue_free(q, NULL);
 		}
 	}
 
@@ -580,7 +585,7 @@ static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *i
 			(info->si_code == SI_TIMER) &&
 			(info->si_sys_private);
 
-		__sigqueue_free(first);
+		__sigqueue_free(first, NULL);
 	} else {
 		/*
 		 * Ok, it wasn't in the queue.  This must be
@@ -728,7 +733,7 @@ static int dequeue_synchronous_signal(kernel_siginfo_t *info)
 still_pending:
 	list_del_init(&sync->list);
 	copy_siginfo(info, &sync->info);
-	__sigqueue_free(sync);
+	__sigqueue_free(sync, NULL);
 	return info->si_signo;
 }
 
@@ -776,7 +781,7 @@ static void flush_sigqueue_mask(sigset_t *mask, struct sigpending *s)
 	list_for_each_entry_safe(q, n, &s->list, list) {
 		if (sigismember(mask, q->info.si_signo)) {
 			list_del_init(&q->list);
-			__sigqueue_free(q);
+			__sigqueue_free(q, NULL);
 		}
 	}
 }
@@ -1749,7 +1754,7 @@ void sigqueue_free(struct sigqueue *q)
 	spin_unlock_irqrestore(lock, flags);
 
 	if (q)
-		__sigqueue_free(q);
+		__sigqueue_free(q, NULL);
 }
 
 int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1d0b37af2444..8ca571a0b2ac 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2548,6 +2548,8 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 	rc = avc_has_perm(&selinux_state,
 			  osid, sid, SECCLASS_PROCESS, PROCESS__SIGINH, NULL);
 	if (rc) {
+		DEFINE_KMEM_FREE_Q(free_q);
+
 		if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
 			memset(&itimer, 0, sizeof itimer);
 			for (i = 0; i < 3; i++)
@@ -2555,13 +2557,15 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 		}
 		spin_lock_irq(&current->sighand->siglock);
 		if (!fatal_signal_pending(current)) {
-			flush_sigqueue(&current->pending);
-			flush_sigqueue(&current->signal->shared_pending);
+			flush_sigqueue(&current->pending, &free_q);
+			flush_sigqueue(&current->signal->shared_pending,
+				       &free_q);
 			flush_signal_handlers(current, 1);
 			sigemptyset(&current->blocked);
 			recalc_sigpending();
 		}
 		spin_unlock_irq(&current->sighand->siglock);
+		kmem_free_up_q(&free_q);
 	}
 
 	/* Wake up the parent if it is waiting so that it can recheck
-- 
2.18.1

