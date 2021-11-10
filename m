Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4610C433FE
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 23:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD82261268
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 23:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbhKJXDJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Nov 2021 18:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbhKJXDF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Nov 2021 18:03:05 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730FBC061205
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 15:00:17 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id z19-20020aa79593000000b0049472f5e52dso2747546pfj.13
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 15:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2l2vfSk9noud27fza1jTmzfBpZWxrMJkzDQXI8UVNOI=;
        b=ck6Z8uYzej/4+oPc/kvulx+Et7Mr8ngkMyTs+OcSpmwgkcmIKy5CxaT6eB1o4Dw/bD
         +LF7Hlf0cU44kBTUJe8ctxy7W434zCe0EKUDc+gtcizY4OeAyKYuadHviz426NuTiJHg
         qE62VPjHShdVR0UndKg5W07O7DMIcUywM8RffPODtyqXEcnUSSIVzx3/xFhDH3DR1u7L
         5S0LUc7UJ2gyDCpNK+7OBshsQg/VXADB2lt2EV1djOL8gj8EZCgWe8mSczrNeU/u3uRJ
         ipcDUcRi7OG8KPx+t4FWf3FiY27EikOPxB9D6++N3I5hxqDg8LiPUGc+XhufXTILzfvx
         jlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2l2vfSk9noud27fza1jTmzfBpZWxrMJkzDQXI8UVNOI=;
        b=Hd026/FxJr7+w8ESKDz+YWUZRw4uSNjZSjXdpvCTep6hnvJ8Jh2tXEk+IYZu8OnKGL
         fRyS+wQnyY+V4GNEGlGST23kFOXQzUxe8G/CmT3MTd1mKhDGkR6fuY4737f/wconsgnR
         EWq0rfWWObyOa4L6YWFBM3Gza2EfEU5SH277YOD5dUvBHVdpUPevIdKKt1KmBmaNERiY
         sLbmHQo6obm2y3Ep7G1pPymbTGsiD3CaJONRRyAfOWbmgjlI0N5ZPcRxprAjqEpwTE8e
         8jBQIgDXspbe5WOrEqcD06X/41NYnzpe7BxcDSyWhTGjjVnCIlRP7JYsA33+cB7QmS4W
         X2Fw==
X-Gm-Message-State: AOAM532SdGXHmlbwfmkbDxzYIbWBgVhcCmjsAuPamZa1c4vZlaTF5sxG
        YR4IW+jTegL+77jWd6qauR5mBgaasA==
X-Google-Smtp-Source: ABdhPJyNhiR0WCLprzojB+bzsoIu+VAQJAFJNw45gZ1HbjTQT04eNyWkTiTQyluaemVlbTwtyhfRpHxe7Q==
X-Received: from tkjos-desktop.mtv.corp.google.com ([2620:15c:211:200:4a73:99b6:9694:8c4d])
 (user=tkjos job=sendgmr) by 2002:a17:903:1c3:b0:142:3ae:5c09 with SMTP id
 e3-20020a17090301c300b0014203ae5c09mr2835269plh.52.1636585216973; Wed, 10 Nov
 2021 15:00:16 -0800 (PST)
Date:   Wed, 10 Nov 2021 15:00:12 -0800
Message-Id: <20211110230013.3271596-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 4.19 1/2] binder: use euid from cred instead of using task
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
index cda4f7eb58ea..58e497db26b4 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -483,6 +483,9 @@ enum binder_deferred_state {
  * @files                 files_struct for process
  *                        (protected by @files_lock)
  * @files_lock            mutex to protect @files
+ * @cred                  struct cred associated with the `struct file`
+ *                        in binder_open()
+ *                        (invariant after initialized)
  * @deferred_work_node:   element for binder_deferred_list
  *                        (protected by binder_deferred_lock)
  * @deferred_work:        bitmap of deferred work to perform
@@ -529,6 +532,7 @@ struct binder_proc {
 	struct task_struct *tsk;
 	struct files_struct *files;
 	struct mutex files_lock;
+	const struct cred *cred;
 	struct hlist_node deferred_work_node;
 	int deferred_work;
 	bool is_dead;
@@ -2962,7 +2966,7 @@ static void binder_transaction(struct binder_proc *proc,
 		t->from = thread;
 	else
 		t->from = NULL;
-	t->sender_euid = task_euid(proc->tsk);
+	t->sender_euid = proc->cred->euid;
 	t->to_proc = target_proc;
 	t->to_thread = target_thread;
 	t->code = tr->code;
@@ -4341,6 +4345,7 @@ static void binder_free_proc(struct binder_proc *proc)
 	BUG_ON(!list_empty(&proc->delivered_death));
 	binder_alloc_deferred_release(&proc->alloc);
 	put_task_struct(proc->tsk);
+	put_cred(proc->cred);
 	binder_stats_deleted(BINDER_STAT_PROC);
 	kfree(proc);
 }
@@ -4799,6 +4804,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	get_task_struct(current->group_leader);
 	proc->tsk = current->group_leader;
 	mutex_init(&proc->files_lock);
+	proc->cred = get_cred(filp->f_cred);
 	INIT_LIST_HEAD(&proc->todo);
 	proc->default_priority = task_nice(current);
 	binder_dev = container_of(filp->private_data, struct binder_device,
-- 
2.34.0.rc0.344.g81b53c2807-goog

