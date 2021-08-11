Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE83C4338F
	for <selinux@archiver.kernel.org>; Wed, 11 Aug 2021 20:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF316104F
	for <selinux@archiver.kernel.org>; Wed, 11 Aug 2021 20:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhHKUtI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Aug 2021 16:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhHKUtH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Aug 2021 16:49:07 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C9EC06179F
        for <selinux@vger.kernel.org>; Wed, 11 Aug 2021 13:48:32 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id a19so3940414qkg.2
        for <selinux@vger.kernel.org>; Wed, 11 Aug 2021 13:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=oJfOMvx0uEFscU0brP+7VtymqCG/HAA8OTlifE5lNnk=;
        b=PrBT2AwIUDaPO6CxI814Rh7g6Nu8bCNW1gJiXz17DTvp38dIPF+L2ocO/ntU+pXtsq
         42vzpkTXpkmMmVlq4BS0eU5uZLI7AsMRIZCTy/kG6GHs8OvkB+GU4u1e/AThB8+QW/x0
         D8bXj8m53tV4KxbZBirJyuSv3J+9JxUC+D2TzaW7f/uWdh7yevZTHMO0Hns59fTIRiDA
         vUzpJaqN40NnA8/2PY7pbMwz9m8BkOD67EX5cuelUGoAyJOof9Gx1AJV4opAvNfKk/N5
         OVAKdJNLUD2jiWVZGgjM6FliZGX1MZk1bt89ooI/GSB4Z+/O4yj5SppHutBe8lin9UrA
         S/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oJfOMvx0uEFscU0brP+7VtymqCG/HAA8OTlifE5lNnk=;
        b=dUZOP5eGR7320SQa6GmO5FoxqjfjtqPdCsBgbSCvo577XjNB1V8dUQkCui1iMd1hiO
         6/8ZwXlt8/7dy7nTpa1Gm3Mp1GLnETjwRnP6J/evG6tCYGaoQpCD9H7qCH4gB0Pru1su
         Jsru/0QgILCYaLjk4DqvfCnqzIWgN8C9uoubMXWEGpiuPplQCD6eNP10Zs2o1pob7NDO
         T3Gk46cjpqf/4RKiUEaXssZRCJfWhHHUA3ec0Lzfqjv5omVvBfFMSJO4Z4h+cJgrWYdf
         u4067vk+cPx2D4L4QeQVQEM8WaxE6PNdkNFs0UJsF/BgGR8PMtBvvDJYNv+cCkDgqjny
         fkgQ==
X-Gm-Message-State: AOAM531L7cb+GvuUzeijKZhFbYZG6jHlDeThBLdk2vDhFCoHiQXhl5yl
        fQxv7T0bJKK4dEtkiBAIAcIV
X-Google-Smtp-Source: ABdhPJzzhfs/yUlyri5MFzz7505Xzt/eUwGcehJ2Tq55xKSsoEBrv6Y2qpnl2GQj3kxSgYUK1Ypn1w==
X-Received: by 2002:a05:620a:21cc:: with SMTP id h12mr978924qka.370.1628714911280;
        Wed, 11 Aug 2021 13:48:31 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id d6sm183892qtn.30.2021.08.11.13.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 13:48:30 -0700 (PDT)
Subject: [RFC PATCH v2 3/9] audit: dev/test patch to force io_uring auditing
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Date:   Wed, 11 Aug 2021 16:48:30 -0400
Message-ID: <162871491017.63873.478910064364009157.stgit@olly>
In-Reply-To: <162871480969.63873.9434591871437326374.stgit@olly>
References: <162871480969.63873.9434591871437326374.stgit@olly>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

WARNING - This patch is intended only to aid in the initial dev/test
of the audit/io_uring support, it is not intended to be merged.

With this patch, you can emit io_uring operation audit records with
the following commands (the first clears any blocking rules):

  % auditctl -D
  % auditctl -a exit,always -S io_uring_enter

Signed-off-by: DO NOT COMMIT
---
 kernel/auditsc.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 62fb502da3fc..928f1dd12460 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1910,6 +1910,10 @@ void __audit_uring_exit(int success, long code)
 		audit_log_uring(ctx);
 		return;
 	}
+#if 1
+	/* XXX - temporary hack to force record generation */
+	ctx->current_state = AUDIT_STATE_RECORD;
+#endif
 
 	/* this may generate CONFIG_CHANGE records */
 	if (!list_empty(&ctx->killed_trees))

