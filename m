Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3417C4332E
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 22:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFD8223AA3
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 22:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbhAHWXz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Jan 2021 17:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbhAHWXy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Jan 2021 17:23:54 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91507C0617A9
        for <selinux@vger.kernel.org>; Fri,  8 Jan 2021 14:22:34 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id s66so10362876qkh.10
        for <selinux@vger.kernel.org>; Fri, 08 Jan 2021 14:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Cge7zJHdUeDRqJYsTUJX6Q9Nj8WIU/VuWZZ/mr14Zmg=;
        b=v+yhPZ9NrwpjtqFQ7CSlkBzImFQFcSd4kKZnF9rH26V1lt8Qg5cxRh9hRixcXcfRMw
         0Lf4CGMVNWArdhaWV7eqSVrmfWNHHTG2GqQUTUsKER8HcbWrgI4EsRu5u2xMbMBOLdZG
         enbMJD0O3lLJC5+hBXKZ8fQwnsqWrrT2xzKwjSR7ktKRt3ZgfCjPaIhCFd40+Q/Q1AXX
         duBQJXo4lJu5e1RWyxAFuv8sOpAPa3wlcLbISobyv2qg71lRq319UEt7shp1nVAZunCT
         B4okVewDiZl6jt55qYk8Q7SKQwfY2JZURmXUoti7gE+lMfdtRPy3fxppwAJ6HgysnKOH
         2xPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Cge7zJHdUeDRqJYsTUJX6Q9Nj8WIU/VuWZZ/mr14Zmg=;
        b=J6nXZnIqc7a96OIQYLzBXT5lvseqRTW0/6oeo8mKNrvfM7IOmFLGt9Gb5jbow+o7Hj
         q1i1B4bHq5tdFXuAYVQ8FbHPBa6QP0TOP0KFXdSlpecK+olATwPcsyxlYK5ZwKdAWXEq
         WIumzdbR1UesYvrqC6hpROSf4y6eIQfTLwNoF3yEOIFjflBjcBIPpAov/3eH0ngQr7xn
         k2nAi0+/noVL8R8U6FQNK1oyN0+g0dhZCIWKM+urFBpRC60J/rPM0wFq6y/GJ62PB+qW
         +3Tb+2lafM6/P9/EZ7Tgv+U+n5rt+hqQaUahRwmpcYPsO32ojs06ew418/YeN9/bn2Yx
         +myg==
X-Gm-Message-State: AOAM533UudC+/b+xIDhUex9P/Oef2n4Rfrsv1DzZYYiJl3d0ERxUtFr9
        eO4fDMoUcCojxyIwATow1Y4mHMJJxrwXBhU97g==
X-Google-Smtp-Source: ABdhPJxrcozKHrR0xcQ3FM8Iv9GH5ysTauNVEag5mDoPrcF3rxvRgJusdDawbqRfPuHDtVtP8Oko7A7c/uJcaebjSA==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6214:13e2:: with SMTP id
 ch2mr5888288qvb.57.1610144553679; Fri, 08 Jan 2021 14:22:33 -0800 (PST)
Date:   Fri,  8 Jan 2021 14:22:23 -0800
In-Reply-To: <20210108222223.952458-1-lokeshgidra@google.com>
Message-Id: <20210108222223.952458-5-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20210108222223.952458-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v15 4/4] userfaultfd: use secure anon inodes for userfaultfd
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        jeffv@google.com, kernel-team@android.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Daniel Colascione <dancol@google.com>

This change gives userfaultfd file descriptors a real security
context, allowing policy to act on them.

Signed-off-by: Daniel Colascione <dancol@google.com>

[LG: Remove owner inode from userfaultfd_ctx]
[LG: Use anon_inode_getfd_secure() instead of anon_inode_getfile_secure()
 in userfaultfd syscall]
[LG: Use inode of file in userfaultfd_read() in resolve_userfault_fork()]

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 fs/userfaultfd.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 894cc28142e7..0be8cdd4425a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -979,14 +979,14 @@ static __poll_t userfaultfd_poll(struct file *file, poll_table *wait)
 
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
 
@@ -996,7 +996,7 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
 }
 
 static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
-				    struct uffd_msg *msg)
+				    struct uffd_msg *msg, struct inode *inode)
 {
 	ssize_t ret;
 	DECLARE_WAITQUEUE(wait, current);
@@ -1107,7 +1107,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 	spin_unlock_irq(&ctx->fd_wqh.lock);
 
 	if (!ret && msg->event == UFFD_EVENT_FORK) {
-		ret = resolve_userfault_fork(ctx, fork_nctx, msg);
+		ret = resolve_userfault_fork(fork_nctx, inode, msg);
 		spin_lock_irq(&ctx->event_wqh.lock);
 		if (!list_empty(&fork_event)) {
 			/*
@@ -1167,6 +1167,7 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
 	ssize_t _ret, ret = 0;
 	struct uffd_msg msg;
 	int no_wait = file->f_flags & O_NONBLOCK;
+	struct inode *inode = file_inode(file);
 
 	if (ctx->state == UFFD_STATE_WAIT_API)
 		return -EINVAL;
@@ -1174,7 +1175,7 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
 	for (;;) {
 		if (count < sizeof(msg))
 			return ret ? ret : -EINVAL;
-		_ret = userfaultfd_ctx_read(ctx, no_wait, &msg);
+		_ret = userfaultfd_ctx_read(ctx, no_wait, &msg, inode);
 		if (_ret < 0)
 			return ret ? ret : _ret;
 		if (copy_to_user((__u64 __user *) buf, &msg, sizeof(msg)))
@@ -1999,8 +2000,8 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
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
2.30.0.284.gd98b1dd5eaa7-goog

