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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BE4C433ED
	for <selinux@archiver.kernel.org>; Sun, 25 Apr 2021 08:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D9F613D1
	for <selinux@archiver.kernel.org>; Sun, 25 Apr 2021 08:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhDYIgZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 25 Apr 2021 04:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhDYIgZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 25 Apr 2021 04:36:25 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8C8C061574;
        Sun, 25 Apr 2021 01:35:45 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q2so4996431pfk.9;
        Sun, 25 Apr 2021 01:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bP0ylHzIuId6cFa3yNjrcjBn2O4Zdws4nrIAmBWVJc4=;
        b=c6zXauhvHAB4KQJ3ZTHi7bIwCqE7Y/c1UxMRfuFdFzCjwBVk9D7ZeUC10qHF4kVOxX
         MyAST7u/Hnbq171+Q7vhZeu3ObEj0VDX0YH4PiiaJuNXPhZ2HjFNJEuR3ptz9vAcQhU0
         6CaSeC3ejt27G0FayF9HCZ9xs02tdiPXFHMVO99n7r3fo7kupzy82Qett08nmKGBM+lG
         tPmc3yntvAqp0hycOAX8d8psuu7yTrNjSgSpAgqB+ivu7taPzeyA+ihB9vbWfS028JVN
         Qci1UHRMioN1NBaJhyBNzfCeaXZRTkv6jJeLuDMiZqB5I8Spj0Z1fzqgJiAqUWKI6MOe
         ZGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bP0ylHzIuId6cFa3yNjrcjBn2O4Zdws4nrIAmBWVJc4=;
        b=an2TMaKWTjJBSYb6GA/3Q5yu/rPbRfXxSZ0IphTt4KcQPkV3zVBqxsKoabgg4GtvL3
         9Thv8K44TFgFfBxIbD22kyr23EQ96NDjoK5THKPOMtRfxfWGYtj5yEgS9NGirh8ZjgWm
         ZT1/bKuCY0DaqF6+5riaLUEqf+4Vax2OAQJ/Lld5sohwtUAWY+TD+60ztFGtqR19CHrd
         UtChwiV79ajztO51lcs+a8BVIGZnlFVmmaNd0GF2i/sbpXPrFuj/6Qb8Oti3F2TBU9an
         LuyBrbpE3AfIbP6D5pDcsBrKL0eQQsE803ru0dIYjQlPZBboiztKGj+PDiV75GZb7kd9
         wAhg==
X-Gm-Message-State: AOAM533SfTpdAtcC5REGv/tUVcsVDNSoTrd1j7xTDZUw1JLzVnhvu22K
        cy+dUY4f5uALNeB5Nc3SObhStWpncq/YUauU
X-Google-Smtp-Source: ABdhPJxUGgDG7HI/5qmWgu4xkphkn1LN4f2cmKUaX7KtLt26y7W6Ez+Zl/wEnsPuh6O2f2/ulArgCQ==
X-Received: by 2002:a63:330b:: with SMTP id z11mr11632225pgz.32.1619339745167;
        Sun, 25 Apr 2021 01:35:45 -0700 (PDT)
Received: from localhost.localdomain ([49.37.83.82])
        by smtp.gmail.com with ESMTPSA id nv7sm11235629pjb.18.2021.04.25.01.35.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Apr 2021 01:35:44 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH v2] selinux: Corrected comment to match kernel-doc comment
Date:   Sun, 25 Apr 2021 14:05:37 +0530
Message-Id: <1619339737-4824-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Minor documentation update.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 security/selinux/avc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index ad451cf..c90f455 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -819,7 +819,7 @@ int __init avc_add_callback(int (*callback)(u32 event), u32 events)
 }
 
 /**
- * avc_update_node Update an AVC entry
+ * avc_update_node - Update an AVC entry
  * @event : Updating event
  * @perms : Permission mask bits
  * @ssid,@tsid,@tclass : identifier of an AVC entry
-- 
1.9.1

