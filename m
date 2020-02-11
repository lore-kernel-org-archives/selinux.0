Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E990C352A3
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 22:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2454C2082F
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 22:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umSesbTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgBKW4W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:56:22 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:56881 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgBKW4U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 17:56:20 -0500
Received: by mail-qt1-f202.google.com with SMTP id c22so7702383qtn.23
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 14:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=/wUiaE4lRYXVr4XT55eq69Fhu4cwbqd4vz3JObgWLSw=;
        b=umSesbTGPsu+nvuQqZ8fY1eTSikUabPzN6xXg7xZJNBVLypMGXMDDOtJRe0wHcws/7
         KVx131mQiaayMu32w+j2ucPHb9I5Eb8itpDFy9EHwUOdRgdnnhnKXgs7u72L/EpOwS2f
         JvJl3PKDTd9Y1naPldNOTFfg9IraAiaHTbUmM5seXxpMlK9aTnTnuqYp3Ud/ljRBeBkc
         WuPfeFuw2yoyip+1AA+8LQghHTNqWGHBzKnlUmuoOyGwGYsCIsIDAnf0JEf3eQDlIhI2
         yKiZaipNfTJ1ATmOxT4/Zj07VxlViiwp1X4wBvuGy6Hc65x02f0NtCx8qf1iy1MOde2k
         odTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=/wUiaE4lRYXVr4XT55eq69Fhu4cwbqd4vz3JObgWLSw=;
        b=K7OG/k8XPCrNm2dUI7vPka1X/tYKA6UapLvsv5HzOtrIhbaTnf7KBu47Sy96+MvMcP
         Z0k7Iuw6ypX8RjVTEgCao1eoionFMtyr66+Ft2GoWIk/Knn1Gcy0zT3MFr6nF5t5j5So
         SHr76hkTjy/ZpgRHkW5NtI5WF4qDg3664JcAoA01Oi4FhHVln+0Slex0rLx7OFm5pR9M
         Xpvvv2d70daUlcCeBoyvacJMR1zCLdvgpH+5obNvkJ1XPbi7s5MIt/n7dNW2ZXMBYYF4
         3b7ZeJA1kp3uh5z/AqQ3qZoav8VQIIbSx7+5hUtsxr9eKljJyBa6RVcBI/+XOtfS2lkl
         Gieg==
X-Gm-Message-State: APjAAAXOkYpCZCXOk3JSyNK6KrtSVuBmguDca7wxrZcOBOFJ2txg4+YH
        9wMdHeflSkzFhji6DqiWtranUbaHbj4=
X-Google-Smtp-Source: APXvYqyZXCjauD7MRkh/uIhajsG5EI06HCT6AH+BThgzhc0Md1s+7ziwiBW5p3VuX5RjLJnrFmjTcG1OTEs=
X-Received: by 2002:ac8:34b2:: with SMTP id w47mr16528854qtb.142.1581461779511;
 Tue, 11 Feb 2020 14:56:19 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:55:45 -0800
In-Reply-To: <20200211225547.235083-1-dancol@google.com>
Message-Id: <20200211225547.235083-5-dancol@google.com>
Mime-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2 4/6] Wire UFFD up to SELinux
From:   Daniel Colascione <dancol@google.com>
To:     dancol@google.com, timmurray@google.com, nosh@google.com,
        nnk@google.com, lokeshgidra@google.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This change gives userfaultfd file descriptors a real security
context, allowing policy to act on them.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/userfaultfd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 07b0f6e03849..11227b94a5a7 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1020,6 +1020,8 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
 {
 	int fd;
 
+	/* Regular inode here is okay: only CAP_SYS_PTRACE callers
+	 * can monitor forks.  */
 	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, new,
 			      O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS));
 	if (fd < 0)
@@ -1972,8 +1974,9 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	/* prevent the mm struct to be freed */
 	mmgrab(ctx->mm);
 
-	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
-			      O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS));
+	fd = anon_inode_getfd2("[userfaultfd]", &userfaultfd_fops, ctx,
+			       O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS),
+			       ANON_INODE_SECURE);
 	if (fd < 0) {
 		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-- 
2.25.0.225.g125e21ebc7-goog

