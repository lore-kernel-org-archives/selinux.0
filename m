Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D43C433E0
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 21:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A612388B
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 21:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbhAHU7n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbhAHU7n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Jan 2021 15:59:43 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C2FC061574
        for <selinux@vger.kernel.org>; Fri,  8 Jan 2021 12:59:02 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id m8so9144085qvk.1
        for <selinux@vger.kernel.org>; Fri, 08 Jan 2021 12:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=pg2+obVmDdZw2cVJ7QAMiVijjbCTy6dUmk2h4J5JypM=;
        b=bGwlBNOlqsBerbH0/KNUcpimkFnfnQdqlYIwG/BNL3IRka1C9Q54SMbgiR+Ihs0Qqf
         PBF2zL6u4tLZSFtNLHF1Y0SodUbYkNODtyJVn/SXmybjq9qupbwXkiNw8G5ljf6WIAt8
         /901fZEST9OlaVA/TLox3tLuLqNOXg2+Gzuh5jXpQBI3rTiltYyjnxEjs7Oe1mrK7Wn8
         fnmaaRZKXRRVIOYHKaOXzCtrgHfvIEtCkST1wmua8yZ4JAe0h2Gq+ChYdP0EE4/76B7x
         nVdrfwoVbCqshvN6rbO9uFv5X4iQBwH5vAK+6sepxIIXUWCfOjOkubfSgSBhLwaFeQHh
         m9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=pg2+obVmDdZw2cVJ7QAMiVijjbCTy6dUmk2h4J5JypM=;
        b=AbDzQICXFheCtqToPBn8gyDSr9jLWFGIsd62p4goVJ2h5Y2cQPnlnM5vofOpooDqj+
         CGgWa7ejqsROOw/HxE+3flDwAykapeoTAKtKMHeOtX/quWHWmo73WFyJ/zAUlWBW4HH+
         CRDxshdI9LWRUly4Czs2E6Oj6C7rXjbwz+FIh8tq12a2j5uIZcbkDPHBfMmgKP6St2mV
         /SEoyqdOwlPTzq45+Wj1CDx8aPleMjF8dS1jJGGIsW55BPkRP32TnkG0S8oMmoq1QUxY
         zun7cMcYdNEGe3H7TynBT5ip/je7Wsg8BwRcikAVR77rzwVgKJA5f+5D2gdoYcePKAay
         E66Q==
X-Gm-Message-State: AOAM5315sIlbuehfjXMB+GUjqLlwaN/Elym1rhxJwUSOxXCTQ1Iqk+8/
        IHCFOpqCwQz6WgAHW9EKDApdyqdRSDE=
X-Google-Smtp-Source: ABdhPJzkhcWm36Y5z3eQqRcs4DfyJUCy0+z8bCk7zQYdPc0oJNglTollph0feYqWo91RO0orZmPxFLLqhs4=
Sender: "surenb via sendgmr" <surenb@surenb1.mtv.corp.google.com>
X-Received: from surenb1.mtv.corp.google.com ([100.98.240.136]) (user=surenb
 job=sendgmr) by 2002:ad4:4888:: with SMTP id bv8mr5409095qvb.0.1610139542143;
 Fri, 08 Jan 2021 12:59:02 -0800 (PST)
Date:   Fri,  8 Jan 2021 12:58:57 -0800
Message-Id: <20210108205857.1471269-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
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
---
 mm/madvise.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 6a660858784b..c2d600386902 100644
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
+		goto release_task;
+	}
+
 	total_len = iov_iter_count(&iter);
 
 	while (iov_iter_count(&iter)) {
-- 
2.30.0.284.gd98b1dd5eaa7-goog

