Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4202DC433ED
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1024A611CE
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbhDSPQo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239396AbhDSPQm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 11:16:42 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80E3C06174A
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:10 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z25so3592119qtn.8
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yT1pgVzVhgcQ0yx0VNCZ0mT9YDDPJwzu+O7bptRkNJ8=;
        b=OxDGQrt9Ll8t1pqS6kktsN9S8kH2e7muWC85Lq8FScEK8zWeyn+fFP3S+RMU8j5nOJ
         7U+4I0BbNB0zaUq2SwMo/u8dF1wAWtLjp0o+oRNhH8KxY1+qquDN+mz3kiIypZMsoFiJ
         RpZ5b76eatnlLtU7ztktcbDQvp6w2XdUIkYV1w+rd+QszM9YalCw5mvJeM/te3tovMMQ
         1G0YtKFu/z9WGne9zfJjk+2dVaKojtE00FMTCwiZmtqllx/AmFpJZhJgPl8nB4AyFJiY
         itIVzB8eisJYUT/V2oRs4O+G9/CJDntUH7WNWtXEpn/GcPkE382KpCCfVkU+FLzB/Yuo
         UQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yT1pgVzVhgcQ0yx0VNCZ0mT9YDDPJwzu+O7bptRkNJ8=;
        b=rb9kIJeuRoEIpG2EUhY1az1N+vFMddRwOG8pzgEPUYJ0e3eXUOytOYjbx0dtZk3RiJ
         h2NYbJcYJTwGz/oIZTEDyYdS7R3PW840UIiUa7Vu85JdtY3LgF0LIrMvsOHiVz3okaQa
         WGoR+Jon357F0nz093NU+ARQVf5y2Ky6XZCbiT4H/EsJDy4D8j4HNXqn0R93uRwhzci9
         XBIJmCV16prdQMRGRECgDKhBSGjYgQUPv7vN8oCWVNfySEdd+Ze4MAPfKBkZGXULSGaP
         OrezYi/6u6ObdI9MMtQSw6NZ41XSleXEVa9xN2E1/ReYXqXe3/3Ykl6RVjP8iBKH9ss6
         UG5Q==
X-Gm-Message-State: AOAM531uXGhR3PEB3paCtroeWrO8dp4mmHSpimNC6LntU28bVE7MW5fp
        qHIezlYVCwrTe5wV0AWrftUXZPrJRKN5JQ==
X-Google-Smtp-Source: ABdhPJyDLewqTsaB/gHBdcSfFf4l8NY8JpoC/YrwSav3ybHNmSO7/RVJjliC+mKhbr8MJLza+3a/ZA==
X-Received: by 2002:a05:622a:210:: with SMTP id b16mr12528667qtx.377.1618845369901;
        Mon, 19 Apr 2021 08:16:09 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d68sm9840584qkf.93.2021.04.19.08.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:16:09 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 01/11 v2] libsepol/cil: Fix out-of-bound read of file context pattern ending with "\"
Date:   Mon, 19 Apr 2021 11:15:47 -0400
Message-Id: <20210419151557.87561-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210419151557.87561-1-jwcart2@gmail.com>
References: <20210419151557.87561-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Based on patch by Nicolas Iooss, who writes:
  OSS-Fuzz found a Heap-buffer-overflow in the CIL compiler when trying
  to compile the following policy:

    (sid SID)
    (sidorder(SID))
    (filecon "\" any ())
    (filecon "" any ())

  When cil_post_fc_fill_data() processes "\", it goes beyond the NUL
  terminator of the string. Fix this by returning when '\0' is read
  after a backslash.

To be consistent with the function compute_diffdata() in
refpolicy/support/fc_sort.py, also increment str_len in this case.

Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28484
Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_post.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index d2ecbd43..fd4758dc 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -186,6 +186,13 @@ static void cil_post_fc_fill_data(struct fc_data *fc, const char *path)
 			break;
 		case '\\':
 			c++;
+			if (path[c] == '\0') {
+				if (!fc->meta) {
+					fc->stem_len++;
+				}
+				fc->str_len++;
+				return;
+			}
 			/* FALLTHRU */
 		default:
 			if (!fc->meta) {
-- 
2.26.3

