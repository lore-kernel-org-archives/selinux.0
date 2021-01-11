Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B451C433E0
	for <selinux@archiver.kernel.org>; Mon, 11 Jan 2021 17:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E8BE22C7C
	for <selinux@archiver.kernel.org>; Mon, 11 Jan 2021 17:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389152AbhAKRHL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Jan 2021 12:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbhAKRHK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Jan 2021 12:07:10 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BD9C0617A5
        for <selinux@vger.kernel.org>; Mon, 11 Jan 2021 09:06:29 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id m8so180174qvt.14
        for <selinux@vger.kernel.org>; Mon, 11 Jan 2021 09:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=TXgIiPGiAVYYkmWDjbujM9saKwN+69Dn3gHiic8vtkI=;
        b=Hh3KmXusdsWf3wOKiqMpN2ZvjtT1zhfgbc8mOIqOlfXaK+rz3Lj2iHAkKJ8bQKB1Mc
         QLerZWDf+pZFuolShf5tDjCPoQBvPEQIDL0Rmri9m6hpbkutx3VD0oKTzwG8xPOhi28x
         ablVvg1ISJmA/9YtTL/T1yVKw79riORs3MSqLf9vTD0XQ63U/6uzW6mgFooId144FiN2
         6Q0lfAnrIL4dUrD7LhKfXZkUOkFEiKhsNn1kt3XZjgDT9QkTr1iFsCnT5qIAUUPbnRsx
         C4IjdRAIgt0NFfcj3Q9Bt1g7dk+B9Sm/gXbsbAdN/F0TE47Ammma0ZBPjkv+NwxUwT5e
         /tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=TXgIiPGiAVYYkmWDjbujM9saKwN+69Dn3gHiic8vtkI=;
        b=ttrwEjWigTGK+2zM8PLBIabvm7CpwIauJ/HAX/ahq/wDrUXwIVtTnVGxaFqQLZKTQY
         w1f+oNIj85EbYnyGAZTji/t1BXE0+rL2aQ6nJQGvtO/3El5qLx0mB0KkP48pEmbUqXVU
         Y9WddgdGu1K/Kqf96yZofzQkY2lj3lEVRT692UyQh2YNlzb1NKqmluLgmm50edUPXudZ
         TaL97kwy3oiqrJEO5xqrovlMZwRaGPsGYALAE1isYIL6XbpYVOx28dL7bXOwhlt/5D14
         vzavBjOIzk1WAi4ERNJUXzNzDvLyXyACOGEpa8G1DBdNDUfQl3U1PccXMTTFU1g/X5Jl
         GFSw==
X-Gm-Message-State: AOAM533wA/QeWQ4v+Lkgjz9q7TcmyU9V5wKRsR5cnEydorChoqD4drsG
        5mdMBWflAFuhRobJYuC5yZCcC1vuIM8=
X-Google-Smtp-Source: ABdhPJxAmFQ24dsyjs2pojqIymYe0/RXgBNqT71U833fC/fpSdZYlD7He0/vi1wGmwzD1P0BK1wByqDxTpk=
Sender: "surenb via sendgmr" <surenb@surenb1.mtv.corp.google.com>
X-Received: from surenb1.mtv.corp.google.com ([100.98.240.136]) (user=surenb
 job=sendgmr) by 2002:ad4:452f:: with SMTP id l15mr209256qvu.49.1610384788888;
 Mon, 11 Jan 2021 09:06:28 -0800 (PST)
Date:   Mon, 11 Jan 2021 09:06:22 -0800
Message-Id: <20210111170622.2613577-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     jannh@google.com, keescook@chromium.org, jeffv@google.com,
        minchan@kernel.org, mhocko@suse.com, shakeelb@google.com,
        rientjes@google.com, edgararriaga@google.com, timmurray@google.com,
        linux-mm@kvack.org, selinux@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

process_madvise currently requires ptrace attach capability.
PTRACE_MODE_ATTACH gives one process complete control over another
process. It effectively removes the security boundary between the
two processes (in one direction). Granting ptrace attach capability
even to a system process is considered dangerous since it creates an
attack surface. This severely limits the usage of this API.
The operations process_madvise can perform do not affect the correctness
of the operation of the target process; they only affect where the data
is physically located (and therefore, how fast it can be accessed).
What we want is the ability for one process to influence another process
in order to optimize performance across the entire system while leaving
the security boundary intact.
Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
and CAP_SYS_NICE for influencing process performance.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Minchan Kim <minchan@kernel.org>
Acked-by: David Rientjes <rientjes@google.com>
---
 mm/madvise.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 6a660858784b..a9bcd16b5d95 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1197,12 +1197,22 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		goto release_task;
 	}
 
-	mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
+	/* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
+	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
 	if (IS_ERR_OR_NULL(mm)) {
 		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
 		goto release_task;
 	}
 
+	/*
+	 * Require CAP_SYS_NICE for influencing process performance. Note that
+	 * only non-destructive hints are currently supported.
+	 */
+	if (!capable(CAP_SYS_NICE)) {
+		ret = -EPERM;
+		goto release_mm;
+	}
+
 	total_len = iov_iter_count(&iter);
 
 	while (iov_iter_count(&iter)) {
@@ -1217,6 +1227,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	if (ret == 0)
 		ret = total_len - iov_iter_count(&iter);
 
+release_mm:
 	mmput(mm);
 release_task:
 	put_task_struct(task);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

