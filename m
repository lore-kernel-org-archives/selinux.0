Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CF2C2D0E5
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 20:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2EE2076A
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 20:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lPpmx9yP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgCZUG4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:06:56 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:45552 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgCZUG4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 16:06:56 -0400
Received: by mail-vk1-f202.google.com with SMTP id j68so2554712vkj.12
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y8Q8F3IH8c2hotjV+QMJ3kSw7Jeojd38t24yU7GezVM=;
        b=lPpmx9yPrL/MYyExIQJGT42ZfXmoCaxGEUrGYFUYgtzqZErnqz25tEHuBVs6UbKG03
         cbq05kXjAStd0QUwzzsPx/m4hLKByFqoRBu0ZMko8DOGfpMbfqphPTAc1n4aoSx+jUiD
         GUkRqspDcIHkNyB21E+AmXM76aByOoFTLmj5Z68AhLoDMFd2yhNWF9wo2X0u1uuBOqyP
         yWaZ/1SYoC2exZSC6kN0hyxiU7LLLW36qCYgUEFeqhpAMNQye8oOAMZk5AE/478eAua1
         38w9tfa8n6lzqlf4LQ8lmPqLhDyBDGb2agpgeh/LtUoaVTpE4nt/fnX+IkzbBesH8+78
         Azyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y8Q8F3IH8c2hotjV+QMJ3kSw7Jeojd38t24yU7GezVM=;
        b=pPp+sRMOa1zf69M14Bg/6wk+mp8x1cJrm14e0N2zFv8pdP/kqb5LthV5irzyYEqkXZ
         Ot17Vwa2nMPAbK+TiquukxZ/be8UpOnzgTyYrRba9wTC3A6IUt3DsKmFo0jlgYiT+71X
         1GK98iPAJcO5UOUtnuJUHeYxO6AbK76xUIqZ4wEKsCOEIiVplyzMAGYSKMghL+53bxVv
         OlkmE4ZOTTNXjQlUF8nPTEbK84KSvUCOQSOp6SZLb9yX8+oDWcEFnrW6nqSzcNECIlmr
         N8thUqH/Uffl1l0JGCtIWHyqPuQKmw7CDd/lVR/bCPrs1MXBkvypNpld5+eQobzIynmw
         rvXQ==
X-Gm-Message-State: ANhLgQ3tBYlSxzerFwfox6yyRMkQtOzwmLsPoOPSYOkdRD02slBm2vaZ
        34idBxvhwYMManY1BZ/pQ0quzrwGtDs=
X-Google-Smtp-Source: ADFU+vusyX36d2CY3Mx/oaqEexC02/Z3H/IlNDB9bKUbWp7T4L1OJf34Zf2nIPvcXbTAxx7+cBlBgkr2U4g=
X-Received: by 2002:ab0:424:: with SMTP id 33mr8765913uav.143.1585253213293;
 Thu, 26 Mar 2020 13:06:53 -0700 (PDT)
Date:   Thu, 26 Mar 2020 13:06:34 -0700
In-Reply-To: <20200326200634.222009-1-dancol@google.com>
Message-Id: <20200326200634.222009-4-dancol@google.com>
Mime-Version: 1.0
References: <20200326181456.132742-1-dancol@google.com> <20200326200634.222009-1-dancol@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v4 3/3] Wire UFFD up to SELinux
From:   Daniel Colascione <dancol@google.com>
To:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com,
        jmorris@namei.org
Cc:     Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This change gives userfaultfd file descriptors a real security
context, allowing policy to act on them.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/userfaultfd.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 37df7c9eedb1..78ff5d898733 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -76,6 +76,8 @@ struct userfaultfd_ctx {
 	bool mmap_changing;
 	/* mm with one ore more vmas attached to this userfaultfd_ctx */
 	struct mm_struct *mm;
+	/* The inode that owns this context --- not a strong reference.  */
+	const struct inode *owner;
 };
 
 struct userfaultfd_fork_ctx {
@@ -1022,8 +1024,10 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
 {
 	int fd;
 
-	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, new,
-			      O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS));
+	fd = anon_inode_getfd_secure(
+		"[userfaultfd]", &userfaultfd_fops, new,
+		O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS),
+		ctx->owner);
 	if (fd < 0)
 		return fd;
 
@@ -1945,6 +1949,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 
 SYSCALL_DEFINE1(userfaultfd, int, flags)
 {
+	struct file *file;
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
@@ -1974,8 +1979,25 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	/* prevent the mm struct to be freed */
 	mmgrab(ctx->mm);
 
-	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
-			      O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS));
+	file = anon_inode_getfile_secure(
+		"[userfaultfd]", &userfaultfd_fops, ctx,
+		O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS),
+		NULL);
+	if (IS_ERR(file)) {
+		fd = PTR_ERR(file);
+		goto out;
+	}
+
+	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		fput(file);
+		goto out;
+	}
+
+	ctx->owner = file_inode(file);
+	fd_install(fd, file);
+
+out:
 	if (fd < 0) {
 		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-- 
2.25.1.696.g5e7596f4ac-goog

