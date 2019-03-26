Return-Path: <SRS0=N/SO=R5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC7BC43381
	for <selinux@archiver.kernel.org>; Tue, 26 Mar 2019 13:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFBD2075D
	for <selinux@archiver.kernel.org>; Tue, 26 Mar 2019 13:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfCZNaP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:30:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfCZNaP (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 26 Mar 2019 09:30:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CD7383F4C;
        Tue, 26 Mar 2019 13:30:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.68])
        by smtp.corp.redhat.com (Postfix) with SMTP id 68DF53843;
        Tue, 26 Mar 2019 13:29:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 26 Mar 2019 14:30:02 +0100 (CET)
Date:   Tue, 26 Mar 2019 14:29:55 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH 2/4] signal: Make flush_sigqueue() use free_q to release
 memory
Message-ID: <20190326132955.GA16837@redhat.com>
References: <20190321214512.11524-1-longman@redhat.com>
 <20190321214512.11524-3-longman@redhat.com>
 <20190322015208.GD19508@bombadil.infradead.org>
 <20190322111642.GA28876@redhat.com>
 <d9e02cc4-3162-57b0-7924-9642aecb8f49@redhat.com>
 <01000169a686689d-bc18fecd-95e1-4b3e-8cd5-dad1b1c570cc-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000169a686689d-bc18fecd-95e1-4b3e-8cd5-dad1b1c570cc-000000@email.amazonses.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 26 Mar 2019 13:30:15 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Sorry, I am sick and can't work, hopefully I'll return tomorrow.

On 03/22, Christopher Lameter wrote:
>
> On Fri, 22 Mar 2019, Waiman Long wrote:
>
> > I am looking forward to it.
>
> There is also alrady rcu being used in these paths. kfree_rcu() would not
> be enough? It is an estalished mechanism that is mature and well
> understood.

But why do we want to increase the number of rcu callbacks in flight?

For the moment, lets discuss the exiting tasks only. The only reason why
flush_sigqueue(&tsk->pending) needs spin_lock_irq() is the race with
release_posix_timer()->sigqueue_free() from another thread which can remove
a SIGQUEUE_PREALLOC'ed sigqueue from list. With the simple patch below
flush_sigqueue() can be called lockless with irqs enabled.

However, this change is not enough, we need to do something similar with
do_sigaction()->flush_sigqueue_mask(), and this is less simple.

So I won't really argue with kfree_rcu() but I am not sure this is the best
option.

Oleg.


--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -85,6 +85,17 @@ static void __unhash_process(struct task_struct *p, bool group_dead)
 	list_del_rcu(&p->thread_node);
 }
 
+// Rename me and move into signal.c
+void remove_prealloced(struct sigpending *queue)
+{
+	struct sigqueue *q, *t;
+
+	list_for_each_entry_safe(q, t, &queue->list, list) {
+		if (q->flags & SIGQUEUE_PREALLOC)
+			list_del_init(&q->list);
+	}
+}
+
 /*
  * This function expects the tasklist_lock write-locked.
  */
@@ -160,16 +171,15 @@ static void __exit_signal(struct task_struct *tsk)
 	 * Do this under ->siglock, we can race with another thread
 	 * doing sigqueue_free() if we have SIGQUEUE_PREALLOC signals.
 	 */
-	flush_sigqueue(&tsk->pending);
+	if (!group_dead)
+		remove_prealloced(&tsk->pending);
 	tsk->sighand = NULL;
 	spin_unlock(&sighand->siglock);
 
 	__cleanup_sighand(sighand);
 	clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
-	if (group_dead) {
-		flush_sigqueue(&sig->shared_pending);
+	if (group_dead)
 		tty_kref_put(tty);
-	}
 }
 
 static void delayed_put_task_struct(struct rcu_head *rhp)
@@ -221,6 +231,11 @@ void release_task(struct task_struct *p)
 	write_unlock_irq(&tasklist_lock);
 	cgroup_release(p);
 	release_thread(p);
+
+	flush_sigqueue(&p->pending);
+	if (thread_group_leader(p))
+		flush_sigqueue(&p->signal->shared_pending);
+
 	call_rcu(&p->rcu, delayed_put_task_struct);
 
 	p = leader;

