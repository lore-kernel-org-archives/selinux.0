Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AAAC433FE
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 23:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B83161279
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 23:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhKJXD3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Nov 2021 18:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbhKJXD2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Nov 2021 18:03:28 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F21C061767
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 15:00:40 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id 13-20020ac8560d000000b0029f69548889so3240966qtr.3
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 15:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=B5qR9IFfPYyqZzAR1NtxHfHPCrwSatA1W5mjCxV+NDo=;
        b=dxpfCGJxE0aLuP6SejLibiTWJsNl6eV6c/7AD/qBuov+nxRRy9M+Huw3sdeCqSw3xv
         untZb7uJRe2oloH8KlA+ToFNZyo1bQX1//VSPZG1xBzkjFFmXQ8FUT0loiOBRk/qzJQ+
         vUFvWT9J8gW7RNdvL06j01uuCWnmRV4JaOhGfxGF/4xo3f7jewGnfVu/v8rQDnTqCv63
         vbIOKJhptN6quN5JVzvqlOdqkPmVW0QhGrE+OVgPBU+w1jzf9h4Q2dIgNefrreNPlTZt
         NOf9feJkkaU36k5lWJJBZaNmDy6lqNrPoJ4cLXDaA8pj5JkDO/RivBeoALWPLGPNC18B
         RCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=B5qR9IFfPYyqZzAR1NtxHfHPCrwSatA1W5mjCxV+NDo=;
        b=d9Kk+nLzsq+Kwk2cyVGn6Iw3kS7SMkOpAusLEOVSofU1swJwaqDN7D/GSzUmMdWxw5
         edhNI+rCs2woOReWvDfEvqpa/zErlZwR0iPkOYJOtQBLd1DfOych42dn2Wl+oYu3ZXo9
         4ZSD8dn1qoyHdw3+P+hQBK1L9l5SMOQxH9pnAafU6ph8t/gKeyVyxRJTKjH4TYEE+RcB
         U4VLj0yVLnUnrxWUwKRuxUyAOQw3WElBIi44+MBzeFZ2l8zvxvJcMH1rUaM44hb/ms+X
         07z8nmZQm90B5MJWuIv2OJPpBW4sgJ5HGYPSlWf6F/2FiZuT3pbODNQupoLf8Tt1O2Ap
         7CsQ==
X-Gm-Message-State: AOAM5301iR24m66rwQ8RDY/OAROkNn/ehmBxs4PbckMkdAen5E7l80vm
        s5Z+qoXlp465nH2sENPwgmJ+Yb9fLA==
X-Google-Smtp-Source: ABdhPJxNeI9pPQMczNqh7lTEOTjZOwslOwZWyiK/KZOlDPOiuxMgX0yqvhob/VWngaHy4gSf0G3hdmOstQ==
X-Received: from tkjos-desktop.mtv.corp.google.com ([2620:15c:211:200:4a73:99b6:9694:8c4d])
 (user=tkjos job=sendgmr) by 2002:a05:622a:20d:: with SMTP id
 b13mr2915118qtx.368.1636585239970; Wed, 10 Nov 2021 15:00:39 -0800 (PST)
Date:   Wed, 10 Nov 2021 15:00:34 -0800
Message-Id: <20211110230036.3274365-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 5.10 1/3] binder: use euid from cred instead of using task
From:   Todd Kjos <tkjos@google.com>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        christian@brauner.io, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, keescook@chromium.org, jannh@google.com,
        jeffv@google.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

commit 29bc22ac5e5bc63275e850f0c8fc549e3d0e306b upstream.

Save the 'struct cred' associated with a binder process
at initial open to avoid potential race conditions
when converting to an euid.

Set a transaction's sender_euid from the 'struct cred'
saved at binder_open() instead of looking up the euid
from the binder proc's 'struct task'. This ensures
the euid is associated with the security context that
of the task that opened binder.

Cc: stable@vger.kernel.org # 4.4+
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Signed-off-by: Todd Kjos <tkjos@google.com>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Suggested-by: Jann Horn <jannh@google.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Change-Id: I91922e7f359df5901749f1b09094c3c68d45aed4
---
 drivers/android/binder.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 65b22b5af51a..4e33f6e42ac4 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -420,6 +420,9 @@ enum binder_deferred_state {
  *                        (invariant after initialized)
  * @tsk                   task_struct for group_leader of process
  *                        (invariant after initialized)
+ * @cred                  struct cred associated with the `struct file`
+ *                        in binder_open()
+ *                        (invariant after initialized)
  * @deferred_work_node:   element for binder_deferred_list
  *                        (protected by binder_deferred_lock)
  * @deferred_work:        bitmap of deferred work to perform
@@ -465,6 +468,7 @@ struct binder_proc {
 	struct list_head waiting_threads;
 	int pid;
 	struct task_struct *tsk;
+	const struct cred *cred;
 	struct hlist_node deferred_work_node;
 	int deferred_work;
 	bool is_dead;
@@ -3088,7 +3092,7 @@ static void binder_transaction(struct binder_proc *proc,
 		t->from = thread;
 	else
 		t->from = NULL;
-	t->sender_euid = task_euid(proc->tsk);
+	t->sender_euid = proc->cred->euid;
 	t->to_proc = target_proc;
 	t->to_thread = target_thread;
 	t->code = tr->code;
@@ -4703,6 +4707,7 @@ static void binder_free_proc(struct binder_proc *proc)
 	}
 	binder_alloc_deferred_release(&proc->alloc);
 	put_task_struct(proc->tsk);
+	put_cred(proc->cred);
 	binder_stats_deleted(BINDER_STAT_PROC);
 	kfree(proc);
 }
@@ -5220,6 +5225,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	spin_lock_init(&proc->outer_lock);
 	get_task_struct(current->group_leader);
 	proc->tsk = current->group_leader;
+	proc->cred = get_cred(filp->f_cred);
 	INIT_LIST_HEAD(&proc->todo);
 	proc->default_priority = task_nice(current);
 	/* binderfs stashes devices in i_private */
-- 
2.34.0.rc0.344.g81b53c2807-goog

