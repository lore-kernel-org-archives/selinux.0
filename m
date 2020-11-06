Return-Path: <SRS0=8IdP=EM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E16C5DF9D
	for <selinux@archiver.kernel.org>; Fri,  6 Nov 2020 15:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0608D208C7
	for <selinux@archiver.kernel.org>; Fri,  6 Nov 2020 15:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RsQT+l1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbgKFP4y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Nov 2020 10:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgKFP4x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Nov 2020 10:56:53 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD35AC0613D3
        for <selinux@vger.kernel.org>; Fri,  6 Nov 2020 07:56:51 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id u24so1546220pfh.4
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2020 07:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=WDkvhhk+gB3QxGd+Be5zd3cestt1bSfFZfMdeZMOFkc=;
        b=RsQT+l1Cceiubd2ysLWUV8h2As7XbKgBn+u4sFmyjyhXGIMVBe6DeRx88flcGo8KR5
         sl4O41xriDhKiN7umZyVgbPP7suEytMVsyPLWoRrN+8dPEx5fGUYYAauV7AcPfwFeILG
         YfpSyiF/Xb4+rnv8rl3bb8jdRbPq2PTUklekvsdHWSGtsz506hPYmFjiO7wOILQjhLWf
         pruQuuRngXqqcx2P4k/jVpbn414Xqvkp0FEof2WvYhJioCjk82tStmDHF/kgs65P9Kpq
         aYf0/rfT57riU5y656ZoKcC9PuV/Mttvwyzwlp1vQzkrxpQaFbp4xYQkbtW5gWN1zL5S
         mwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WDkvhhk+gB3QxGd+Be5zd3cestt1bSfFZfMdeZMOFkc=;
        b=IO6FHfi8eX9lpWMffZhyWT9pEkahcl96ZcEM+3tQ01qE99jV8kebQm4QvPX/pmJvva
         2zdjK8IRZExuTFrJEKt+albzXjN2inlACML7Dxy38Rz0jzO99kpQoUsUJ7jKqfhb7FTB
         mX7Jr6Em670TNFj2Z+sR4aIxFzrKcIjs9gjMfOc1Z3wmTBJL7VRSzYndw7OBKmNp21j7
         ZK3k5a2XnxzKEcpZlKjHi2A7d1DNw3kkN2zkYkJcQ4bJErmFDrADkxxpR6XaNeBxCtb0
         ggKIOx9FN91LbqF/DUK7QObwhlFdzqJRBhWNk2A6RH/aUUJr8oTj/9IZkV+j4iHMxVaW
         /Iow==
X-Gm-Message-State: AOAM5316oOAq048yjjjk3eGCLkLfIUz2POImeAy4a2rOE3t/N8pGbkIS
        sI5Do1Uc8P8K9I+yLBcyAT7kQKtSjxVEbBzi6w==
X-Google-Smtp-Source: ABdhPJyr6d4kWf9xCCa5Q5B2Li129pMxIihfl7MrB7NAAAhzq/yphrSlonTBTACs7Hm/3feKqNqDhVnqI0/i8x7rGQ==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a17:902:ee85:b029:d6:c43e:2321 with
 SMTP id a5-20020a170902ee85b02900d6c43e2321mr2200868pld.29.1604678211192;
 Fri, 06 Nov 2020 07:56:51 -0800 (PST)
Date:   Fri,  6 Nov 2020 07:56:26 -0800
In-Reply-To: <20201106155626.3395468-1-lokeshgidra@google.com>
Message-Id: <20201106155626.3395468-5-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20201106155626.3395468-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v12 4/4] userfaultfd: use secure anon inodes for userfaultfd
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        nnk@google.com, jeffv@google.com, kernel-team@android.com,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        hch@infradead.org, Daniel Colascione <dancol@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Daniel Colascione <dancol@google.com>

This change gives userfaultfd file descriptors a real security
context, allowing policy to act on them.

Signed-off-by: Daniel Colascione <dancol@google.com>

[Remove owner inode from userfaultfd_ctx]
[Use anon_inode_getfd_secure() instead of anon_inode_getfile_secure()
 in userfaultfd syscall]
[Use inode of file in userfaultfd_read() in resolve_userfault_fork()]

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 fs/userfaultfd.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 000b457ad087..dd78daf06de6 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -972,14 +972,14 @@ static __poll_t userfaultfd_poll(struct file *file, poll_table *wait)
 
 static const struct file_operations userfaultfd_fops;
 
-static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
-				  struct userfaultfd_ctx *new,
+static int resolve_userfault_fork(struct userfaultfd_ctx *new,
+				  struct inode *inode,
 				  struct uffd_msg *msg)
 {
 	int fd;
 
-	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, new,
-			      O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS));
+	fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, new,
+			O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
 	if (fd < 0)
 		return fd;
 
@@ -989,7 +989,7 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
 }
 
 static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
-				    struct uffd_msg *msg)
+				    struct uffd_msg *msg, struct inode *inode)
 {
 	ssize_t ret;
 	DECLARE_WAITQUEUE(wait, current);
@@ -1100,7 +1100,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 	spin_unlock_irq(&ctx->fd_wqh.lock);
 
 	if (!ret && msg->event == UFFD_EVENT_FORK) {
-		ret = resolve_userfault_fork(ctx, fork_nctx, msg);
+		ret = resolve_userfault_fork(fork_nctx, inode, msg);
 		spin_lock_irq(&ctx->event_wqh.lock);
 		if (!list_empty(&fork_event)) {
 			/*
@@ -1160,6 +1160,7 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
 	ssize_t _ret, ret = 0;
 	struct uffd_msg msg;
 	int no_wait = file->f_flags & O_NONBLOCK;
+	struct inode *inode = file_inode(file);
 
 	if (ctx->state == UFFD_STATE_WAIT_API)
 		return -EINVAL;
@@ -1167,7 +1168,7 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
 	for (;;) {
 		if (count < sizeof(msg))
 			return ret ? ret : -EINVAL;
-		_ret = userfaultfd_ctx_read(ctx, no_wait, &msg);
+		_ret = userfaultfd_ctx_read(ctx, no_wait, &msg, inode);
 		if (_ret < 0)
 			return ret ? ret : _ret;
 		if (copy_to_user((__u64 __user *) buf, &msg, sizeof(msg)))
@@ -1985,8 +1986,8 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	/* prevent the mm struct to be freed */
 	mmgrab(ctx->mm);
 
-	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
-			      O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS));
+	fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, ctx,
+			O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
 	if (fd < 0) {
 		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-- 
2.29.1.341.ge80a0c044ae-goog

