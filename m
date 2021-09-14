Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6EAC433F5
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 03:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A1560F12
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 03:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239040AbhINDfE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Sep 2021 23:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239141AbhINDel (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Sep 2021 23:34:41 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DC0C061767
        for <selinux@vger.kernel.org>; Mon, 13 Sep 2021 20:33:24 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id a66so13232609qkc.1
        for <selinux@vger.kernel.org>; Mon, 13 Sep 2021 20:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=pFa7GQIxXWl0c/uM3483yackGoLHK0NgaO+2cmzz5Nw=;
        b=wEpIkxBpc62PNnC88chQDJ6zl25RE56F/I9noxOjWlQLPwUG7cqnrdLMG7Wlk/LPnd
         Zm0E4bQI9M4k1UtZNyWF7wCSNgsKxaMFD4UNfcxkXMMfDVnjGPQ8M62e5Dnj6Jc6BrpB
         b5LKHdaK4Fq8cywiuL0lJxpzyTt+UP8nP/hFKMZkdqvbul8SNTDL4H34hOfutmA0ICb1
         /410R7ECIcMMAC+kBO8BDZ0co8cHwwCm/YNfySjIvLgDLCHHnV/01gNm1lxD9uFNhedX
         2J9FAsPgQ8h6ts8zlKrCJQXt626+kaQdlnB5snN96wzL4diruTl78Bl8L70wplAugZoJ
         KfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=pFa7GQIxXWl0c/uM3483yackGoLHK0NgaO+2cmzz5Nw=;
        b=5y2KGmFbqII1fL0oV3kVRqVDwoF5rV8R4BX61RE3QBJuiIkskE5SYsyt8i0YMQ3Eb/
         Jby/8bVLFpTZYkTicrv+9nbqo/8Au0FsE3uSgFARrEJkmmfwXQW/upYRqNYLZxatPTjZ
         KxX7MaTUXxfkzSDBYIjMpl+JHIURLtmhdTARHx2rXxrCJssbvMa30EGUudno1Y3TxRAe
         wJcknTD9sXBbZ9l4OCuOHUdoL4wu2U3VKRXLEplnThHMrAnmwQ6Hg3SK5+hA20FY/n+0
         MD8hM5DSWy40EJ0heIC6BPvTYTUbCh9si9lBO1F3z6ZmmOjjAq1wZNImQjE9WmBZwa0V
         9Eqg==
X-Gm-Message-State: AOAM530FE50UqMvnMkKSck3JLC2zPdxE9Blc6PVdiUQ+Esnp2ORuOK6t
        EWCsgA3PHzQTBF1rSE0ssISQ
X-Google-Smtp-Source: ABdhPJw+Gqp/QaKJUPx+eMnsA6HZ3RZzmRCYKVzNF9XtqTZeCyQUZcicJKwDykSIlKMgYCUZ69zReA==
X-Received: by 2002:a05:620a:448e:: with SMTP id x14mr2935347qkp.526.1631590403616;
        Mon, 13 Sep 2021 20:33:23 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id t26sm6530426qkm.0.2021.09.13.20.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 20:33:23 -0700 (PDT)
Subject: [PATCH v3 5/8] io_uring: convert io_uring to the secure anon inode
 interface
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 13 Sep 2021 23:33:22 -0400
Message-ID: <163159040254.470089.7192304410101378968.stgit@olly>
In-Reply-To: <163159032713.470089.11728103630366176255.stgit@olly>
References: <163159032713.470089.11728103630366176255.stgit@olly>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Converting io_uring's anonymous inode to the secure anon inode API
enables LSMs to enforce policy on the io_uring anonymous inodes if
they chose to do so.  This is an important first step towards
providing the necessary mechanisms so that LSMs can apply security
policy to io_uring operations.

Signed-off-by: Paul Moore <paul@paul-moore.com>

---
v3:
- no change
v2:
- no change
v1:
- initial draft
---
 fs/io_uring.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 388754b24785..56cc9aba0d01 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -10155,8 +10155,8 @@ static struct file *io_uring_get_file(struct io_ring_ctx *ctx)
 		return ERR_PTR(ret);
 #endif
 
-	file = anon_inode_getfile("[io_uring]", &io_uring_fops, ctx,
-					O_RDWR | O_CLOEXEC);
+	file = anon_inode_getfile_secure("[io_uring]", &io_uring_fops, ctx,
+					 O_RDWR | O_CLOEXEC, NULL);
 #if defined(CONFIG_UNIX)
 	if (IS_ERR(file)) {
 		sock_release(ctx->ring_sock);

