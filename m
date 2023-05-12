Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2177C7EE25
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 10:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbjELKXy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 06:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbjELKXs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 06:23:48 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18821160A
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:23:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-965f7bdab6bso1631240166b.3
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683887012; x=1686479012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtuF1WyPLprLSufpJla68O/unTeza43ZzPUlJs2Z33s=;
        b=FAR/A+5VNDsS0x87iXvSuKv2vZ+z69eSsWGJm/dEJZeGCqZ5wejWXu8vxVjusemI7r
         Z4WXqir3V9WF9qTx85VdPnITJGmNf/4eQhhP/NXFTaoOlXxuYagwOeqZaaZQNwDJVjeH
         aHQktfUfoDQNZSwUrrifJaj7Udj0r+gwodZNL/aJ0ajirSG0XN4+MrBq/d9Q0Uw21Cqe
         Fr9rfkY5Xybn6WhlserKdvT1qr3CLJJMDx/RDvXmBHbMwvBUO6E5FGo80Qwux+AXhXXL
         n3B2w5cA4XciKbpK1UU2dLGuZ2xAnRKITJRg2lB1XV7XFrMlboUV1tU+0R2g5wlwD0eU
         ZkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683887012; x=1686479012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtuF1WyPLprLSufpJla68O/unTeza43ZzPUlJs2Z33s=;
        b=EDvdDtfSioIHvfk0vXmngE0Twcn/KW4KZgs7fdvokdo4j5F7K2EQmh57wlYDDGMiDu
         gFKerL8ZksCKiRzOn7jw1tuSK8PtImLBWXoUDRM/3perknO3N/YI8US8NA2S4o5rylE+
         VBshBZJT7GZ21CQ72HrQcZU/wQoId7ZsghyYM0O1hZGBSid6grL277chN33LB+HbNcH0
         zzoU9I48GTSJORyn5yc24eC0NqeSaAVIu1QysAOr0nYO7KdKHKs8gCaZv9x6U0G8DdIP
         APShQXVK+0qnpaCgAevM+PpI32rggxzGP824SM9S9DYjt4sVC+5k4nidMC9PHG8RDXGI
         wy5A==
X-Gm-Message-State: AC+VfDy1ZOV5DhfVqCII+XHIBicTK7dMKMUnC1D7J4w7w6A42zvFmGxU
        zFzJXKZaYAxn6k9xvUsfUawxw5Zyd1QcTA==
X-Google-Smtp-Source: ACHHUZ5XWn+Trorg6rIVu1xlxUxesMtckgvfd4Wrr5jqDZmTtE1BiyfhKusAsjzgN60UjB5AbD3pdQ==
X-Received: by 2002:a17:907:7b96:b0:966:1e74:a3ff with SMTP id ne22-20020a1709077b9600b009661e74a3ffmr20816617ejc.40.1683887012625;
        Fri, 12 May 2023 03:23:32 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id gz4-20020a170907a04400b009571293d6acsm5202920ejc.59.2023.05.12.03.23.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:23:32 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 9/9] restorecond: drop last matchpathcon call
Date:   Fri, 12 May 2023 12:23:22 +0200
Message-Id: <20230512102322.72235-9-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512102322.72235-1-cgzones@googlemail.com>
References: <20230512102322.72235-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As restorecond does not use the matchpathcon family but the selabel one,
via selinux_restorecon(3), drop the last unneeded call.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 restorecond/user.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/restorecond/user.c b/restorecond/user.c
index 3ae3ebbb..defba9b4 100644
--- a/restorecond/user.c
+++ b/restorecond/user.c
@@ -279,8 +279,6 @@ int server(int master_fd, const char *watch_file) {
 	if (watch_list_isempty())
 		goto end;
 
-	set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
-
 	GIOChannel *c = g_io_channel_unix_new(master_fd);
 
 	g_io_add_watch_full(c,
-- 
2.40.1

