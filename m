Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13345C35242
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 22:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6242073C
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 22:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WeWDMgIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgBKW4Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:56:24 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:57230 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgBKW4X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 17:56:23 -0500
Received: by mail-pf1-f202.google.com with SMTP id r29so127386pfl.23
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 14:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=zuajClpY4n8pjVJyU4VcQsX18SP0Y8Sji2fDd6chARE=;
        b=WeWDMgIwDwbj7/AXWD1nXsQn6GX/nkkwQPg4D8SaZzdpux/IoFOYqW+cPEdoZXKA+z
         KeyUCv3fQ3BRHWHWuuiFxseX9APuVA3h8PGUbRZUh0l3He+njmrEg5cSm/IGa4tv+6Tm
         I50x1iyZueTqfd07v6Uq2TOxUr049ueKUeUSlpfmn1QnCWByi3jR0lnGyH60rSEo5Ri9
         +r05f2myW4dtsdTS2k9fi5i5grbiS2UUw7IMdRJU2i1ST+/XyzYGRpXwXW2Y5w0D9TbP
         fsD2J9d+UsZnC4Cc7LQtwcEX9aAg8yO14OPMXom6LPmXosZmilC9gWbzfXSkRwxCCAPx
         85QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=zuajClpY4n8pjVJyU4VcQsX18SP0Y8Sji2fDd6chARE=;
        b=AZI7jNxgbkgbLnFLCTc9zBANvv68DNHJc0pomkDycJbO7t3Db85abmopOKdC6w1+nH
         1TAipdjy8CBVMZ6/jjlsjv+MKvIr2/GggvtU3ADNW/YNGRpFI6Qzhh/GCL40GaKss9Ri
         Ww0bq/Arg5rO8VG54u304zGETGYy7n1uDX6jtULQTtpGp5fGFrBHRjvWPQo74TusJtJi
         9B/lhPxP2MIYuGGaNBmhFWTpD+k+2slsDkdpXM4rJ1ewl8eTGoFnJKN/1Q1dhc6ynAtg
         8LW1Pya4hA/KYqKi1wnMevS0vBZx6Q/6jRiJf0KZqI7AYx9uD4tFkXdEbckE8gKbj7Gu
         Y8xQ==
X-Gm-Message-State: APjAAAXT16w1K9ga+5YJ0JwMh11W5aXdfBfX+CwEzxGFlyZkD9TihkQc
        5DSkmD//OdtuCvyJiq2fR611evZLemg=
X-Google-Smtp-Source: APXvYqxGjLt1U5Fk+LSI+2JB0pVm97WGbcPVZqZFDRBBOx6SwjGavrdX+xsJLI7S/No1RnNsl9FHCebL6nw=
X-Received: by 2002:a63:4525:: with SMTP id s37mr9086010pga.418.1581461781964;
 Tue, 11 Feb 2020 14:56:21 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:55:46 -0800
In-Reply-To: <20200211225547.235083-1-dancol@google.com>
Message-Id: <20200211225547.235083-6-dancol@google.com>
Mime-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2 5/6] Let userfaultfd opt out of handling kernel-mode faults
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

userfaultfd handles page faults from both user and kernel code.  Add a
new UFFD_USER_MODE_ONLY flag for userfaultfd(2) that makes the
resulting userfaultfd object refuse to handle faults from kernel mode,
treating these faults as if SIGBUS were always raised, causing the
kernel code to fail with EFAULT.

A future patch adds a knob allowing administrators to give some
processes the ability to create userfaultfd file objects only if they
pass UFFD_USER_MODE_ONLY, reducing the likelihood that these processes
will exploit userfaultfd's ability to delay kernel page faults to open
timing windows for future exploits.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/userfaultfd.c                 | 7 ++++++-
 include/uapi/linux/userfaultfd.h | 9 +++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 11227b94a5a7..47825a804d63 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -389,6 +389,9 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	if (ctx->features & UFFD_FEATURE_SIGBUS)
 		goto out;
+	if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
+	    ctx->flags & UFFD_USER_MODE_ONLY)
+		goto out;
 
 	/*
 	 * If it's already released don't get it. This avoids to loop
@@ -1945,6 +1948,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 
 SYSCALL_DEFINE1(userfaultfd, int, flags)
 {
+	static const int uffd_flags = UFFD_USER_MODE_ONLY;
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
@@ -1954,10 +1958,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	BUG_ON(!current->mm);
 
 	/* Check the UFFD_* constants for consistency.  */
+	BUILD_BUG_ON(uffd_flags & UFFD_SHARED_FCNTL_FLAGS);
 	BUILD_BUG_ON(UFFD_CLOEXEC != O_CLOEXEC);
 	BUILD_BUG_ON(UFFD_NONBLOCK != O_NONBLOCK);
 
-	if (flags & ~UFFD_SHARED_FCNTL_FLAGS)
+	if (flags & ~(UFFD_SHARED_FCNTL_FLAGS | uffd_flags))
 		return -EINVAL;
 
 	ctx = kmem_cache_alloc(userfaultfd_ctx_cachep, GFP_KERNEL);
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 48f1a7c2f1f0..fe3565eae617 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -231,4 +231,13 @@ struct uffdio_zeropage {
 	__s64 zeropage;
 };
 
+/*
+ * Flags for the userfaultfd(2) system call itself.
+ */
+
+/*
+ * Create a userfaultfd that can handle page faults only in user mode.
+ */
+#define UFFD_USER_MODE_ONLY 1
+
 #endif /* _LINUX_USERFAULTFD_H */
-- 
2.25.0.225.g125e21ebc7-goog

