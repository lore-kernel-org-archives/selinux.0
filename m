Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A65C04FF3
	for <selinux@archiver.kernel.org>; Fri, 21 May 2021 21:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BECA613EA
	for <selinux@archiver.kernel.org>; Fri, 21 May 2021 21:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhEUVv1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 May 2021 17:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhEUVv0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 May 2021 17:51:26 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961C6C061574
        for <selinux@vger.kernel.org>; Fri, 21 May 2021 14:50:02 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g8so8885191qtp.4
        for <selinux@vger.kernel.org>; Fri, 21 May 2021 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=f09L8q774yElps/q7XGUKb4sfj1FooPKo1rTwaATVjY=;
        b=znVcls6DkVB0sVL6+jD/9JcWr4lkoF/HyhjCDR7szM/mtlcELz5tjynwyvADsaeGjJ
         Ci2ZtktqdQ7vvAHG1CkmU+JYeu8VskETW6DKJLrZC+AJ7gCBEKCtx5lBAfBs7soiX0un
         VSX4OhKcQ59USVuY3Mg8EmSpc7+09aWtrqR/2nogTANEz57o8MP5acAV8J3AkOhIYWR6
         mRYJuxpkX4TG7NBxpMvcjB+0Ibl+aSyGFL+7KxBf3VKvwF4K1BUGSzWscUpnPOJXPQ7G
         F5Kb9PuJ/awOhVz17CLccVCBrJiePX4RhA74wRaXJutgnHX5NMdqM8BbBKLHP4ooNk8B
         8ABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=f09L8q774yElps/q7XGUKb4sfj1FooPKo1rTwaATVjY=;
        b=ayg5kZEKl1VbJimAEzkjig/w4i22IPviGZHKB1fIyMeFv4x8BkQh3HPfEpYgBHETt+
         VcxjR+yhUZbMdjdZWMFnSW/JrkAPYalIn2dRcE/V8i4qyeT8cfV9hZwuvXLHi1kBHeu1
         M+SzHAo1yxkXeN8qhiwU/p1theqPw+LwFZLtRqPx7/zkL4IeNEncWCItI2IXUNEzVt5Z
         A8XwHy9Ja0mJ1sCIHUzKU1aLITAKf05lVnfwqOduSr5nwTyXr7e0CyTfNQTLm/w53c95
         J99Fz740dxhV+ODJC/cP/QgbdfYZ/XWFOxV5YY1PcMIpt0z21nuDnZ01Mo9xZdKTKlyo
         t8QA==
X-Gm-Message-State: AOAM532GMPASsH9k2suIFJgtnNzvOULOko3ip8GZ+V3lkTwFKU7l1Cht
        gbj4v8SM1qkiO7F/ooOW1cVr
X-Google-Smtp-Source: ABdhPJxuLAQxlJc3vlIKo5MhSE0jYBBMFo/5T/BQwD64uE91fX+g/jksNikqD/j2cApaI8yZp4SBOA==
X-Received: by 2002:a05:622a:144b:: with SMTP id v11mr14090251qtx.372.1621633801743;
        Fri, 21 May 2021 14:50:01 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id s20sm5846297qke.2.2021.05.21.14.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:50:01 -0700 (PDT)
Subject: [RFC PATCH 3/9] audit: dev/test patch to force io_uring auditing
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Fri, 21 May 2021 17:50:00 -0400
Message-ID: <162163380070.8379.13984065725601277137.stgit@sifl>
In-Reply-To: <162163367115.8379.8459012634106035341.stgit@sifl>
References: <162163367115.8379.8459012634106035341.stgit@sifl>
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
index 729849d41631..d8aa2c690bf9 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1898,6 +1898,10 @@ void __audit_uring_exit(int success, long code)
 		audit_log_uring(ctx);
 		return;
 	}
+#if 1
+	/* XXX - temporary hack to force record generation */
+	ctx->current_state = AUDIT_RECORD_CONTEXT;
+#endif
 
 	/* this may generate CONFIG_CHANGE records */
 	if (!list_empty(&ctx->killed_trees))

