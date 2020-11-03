Return-Path: <SRS0=PQdl=EJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20879C2D0A3
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 22:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B75C52242F
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 22:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udaQgtvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgKCWBC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Nov 2020 17:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730575AbgKCWAy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Nov 2020 17:00:54 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E13AC061A48
        for <selinux@vger.kernel.org>; Tue,  3 Nov 2020 14:00:53 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id bg12so1110620plb.16
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2020 14:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5MfBywdxMmsLRrplRDwjfeuNu4Dz7M8KwUBLUxZj6xM=;
        b=udaQgtvyrunQ/CMzN8Xk1IupaOPWUZBksj6LPEJBbqUq0NnJlcBoPovdQ789qBRsN5
         SJoma5dEVWU4sz/3ILN2w3Vk4tQD+DjTVUo3ut+k9a+xr5lty4GvEe+phRftibB0Wa/u
         gJAmkO3kpZHqBgu22n8ZJIGZ+QSxJ8qtc//1EWon96YmBC8zN1K2YIUtTEQ0NOZii1/+
         OBtUDZL/qPbNFDV/nko3qMAArLcvK6oyiJxvehGhKW4ezFBdwrmtRYlBCcqKEMQHhaxP
         MN8n2VC22GpAWN1JERlZLWGzmhVq7rOuyrgD4kSMFO10RFq4rywPvgNYh+R7xhpK6C9A
         Jq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5MfBywdxMmsLRrplRDwjfeuNu4Dz7M8KwUBLUxZj6xM=;
        b=e+yjlov+0nD4H/UWDwWZkfu/kAgH68ZyFMrJzmiAwc+aXMDokx7EGm+qLa1Q8IG1VE
         +3px1CopeuqrPD6/WAEgdbcOICytfkDoL1bgrA7pazLxDEy+7qzoulpVRtaCvjaEAVzt
         kwAaUb4poekU9ZgGmWxgUBewVclk77HcU4Uz9A7G3wl0xB++UivesEGRBS2Cz0vFUAZQ
         1xXvBACFVUVfV7whpDqK5f23QVXjGh+bwmAtgnxAe13KS+0Bn/p/hA5MkVvj8iyuz1Ri
         31Mj3eMq7JZATRHGX5G/znG1SCyeQmhoJd1BDYekB9gYGEUNX1H+GYHAKK+9A0tSLJlN
         Vd0A==
X-Gm-Message-State: AOAM533H2s5SqzizJPasbwe2F6d3eT10W016OYPA+WgKBuLljh1KdnFo
        Mi6VqrpD3WoragmHAmH7NaQu0tLnYGwBIOQ82w==
X-Google-Smtp-Source: ABdhPJyAOAyaXh2xZzoHs7/ZBCmt8D42Q2k0vfbMoTbMpRBhGybVkxXxBcnAzulcfDtjqseSbtRBcpDsBFbYgvG5vQ==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a17:90a:678a:: with SMTP id
 o10mr1283056pjj.180.1604440852797; Tue, 03 Nov 2020 14:00:52 -0800 (PST)
Date:   Tue,  3 Nov 2020 14:00:20 -0800
In-Reply-To: <20201103220020.2399003-1-lokeshgidra@google.com>
Message-Id: <20201103220020.2399003-4-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20201103220020.2399003-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v10 3/3] Use secure anon inodes for userfaultfd
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
        linux-mm@kvack.org, Daniel Colascione <dancol@google.com>
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
---
 fs/userfaultfd.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0e4a3837da52..918535b49475 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -978,14 +978,14 @@ static __poll_t userfaultfd_poll(struct file *file, poll_table *wait)
 
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
 
@@ -995,7 +995,7 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
 }
 
 static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
-				    struct uffd_msg *msg)
+				    struct uffd_msg *msg, struct inode *inode)
 {
 	ssize_t ret;
 	DECLARE_WAITQUEUE(wait, current);
@@ -1106,7 +1106,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 	spin_unlock_irq(&ctx->fd_wqh.lock);
 
 	if (!ret && msg->event == UFFD_EVENT_FORK) {
-		ret = resolve_userfault_fork(ctx, fork_nctx, msg);
+		ret = resolve_userfault_fork(fork_nctx, inode, msg);
 		spin_lock_irq(&ctx->event_wqh.lock);
 		if (!list_empty(&fork_event)) {
 			/*
@@ -1166,6 +1166,7 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
 	ssize_t _ret, ret = 0;
 	struct uffd_msg msg;
 	int no_wait = file->f_flags & O_NONBLOCK;
+	struct inode *inode = file_inode(file);
 
 	if (ctx->state == UFFD_STATE_WAIT_API)
 		return -EINVAL;
@@ -1173,7 +1174,7 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
 	for (;;) {
 		if (count < sizeof(msg))
 			return ret ? ret : -EINVAL;
-		_ret = userfaultfd_ctx_read(ctx, no_wait, &msg);
+		_ret = userfaultfd_ctx_read(ctx, no_wait, &msg, inode);
 		if (_ret < 0)
 			return ret ? ret : _ret;
 		if (copy_to_user((__u64 __user *) buf, &msg, sizeof(msg)))
@@ -1995,8 +1996,8 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
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
2.28.0.1011.ga647a8990f-goog

