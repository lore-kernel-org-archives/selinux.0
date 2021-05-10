Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB688C43460
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 11:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCEBA60FDC
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 11:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhEJLWW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 May 2021 07:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbhEJLGH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 May 2021 07:06:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13713C061761
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 03:56:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id b25so23798052eju.5
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XJ/Tgui++NoHALSEhni10Dnq7/+CzyDkdUE2MKOJVn8=;
        b=QP3a9uhblsu/sQiKJRQ8zeflz3mBBYUh/Kq+743ddIMv14js9u7xGHCK78Z3mhiaoi
         Qcq2I/DgyYDTngJ7p5aTkQIDaT4BzMVFIWEcsWIKMb8Mp+P85QeDcYeOxN/hEntn4ACy
         sivzPzo758sX5f1qW2aP6pjDygEVXCGfXJEmVga6Q3fCWI/Y7K+KacwkVrr4ZVYORykm
         ZD58x9lKgy0JEIt9TVsXNPzN7CDUZQggOafs/CwuKOTpCU9iwaFOMae99gRHuu1mV7Lr
         Hi66QPjWHxGelXAevi/FGnXtLXRgeg45onus0ak8tL3XqQGnd9p6EPVsOaV8PcdiGx9T
         TGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJ/Tgui++NoHALSEhni10Dnq7/+CzyDkdUE2MKOJVn8=;
        b=GKhfleGuQ80s8N0lK80KXOzGDQzPcwj7H+yrDNonYMwPecN2k92w9ky+fSPZjCu2+N
         4RCyjxvUYhhW8bCuL7Wl96u7x3Zr8tkLIV9JSGrwiA2PsghsV1/7alsE/7X2xQlhi83n
         nuzX/PZyFNUmFCOxVtEcrvJH5Q6OaGtIX2VFrtmdsiDJz5ABxIkn1m+pCzUVqyMqF6av
         1dWC3/T4sVceEN5yXNcwH/Ns/S1rWt/QEImEw5/Dz8JN0d8Ls4LY5GtcUBaO4fzUmywl
         wET7YGGzrgMV3kzJP9MNgBY7PrKBnu5i+UIszQiGDpW2y0PcZl7GB3vZs4r4O8wO0ckq
         cneQ==
X-Gm-Message-State: AOAM531ih2NRne7eXUVeUEx3+9PRyleL3F50tukVC3HJYpuYTsuS2xOZ
        6LX3uuezMcT8Tyo+W7n12oyaf8kEpSEs93lP
X-Google-Smtp-Source: ABdhPJwn+qw5Y4FkKrN0sa3iO9wHYqis7oKBSHGDbGkcx/jBQO8GWWUzhgRHEffHvrd9c7wlokbMXw==
X-Received: by 2002:a17:906:4a42:: with SMTP id a2mr25080712ejv.343.1620644210757;
        Mon, 10 May 2021 03:56:50 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-162-005.77.3.pool.telefonica.de. [77.3.162.5])
        by smtp.gmail.com with ESMTPSA id z17sm8884162eju.65.2021.05.10.03.56.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:56:50 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] libselinux: make selinux_status_open(3) reentrant
Date:   Mon, 10 May 2021 12:56:47 +0200
Message-Id: <20210510105648.14635-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510105648.14635-1-cgzones@googlemail.com>
References: <20210510105648.14635-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not mmap the status page again if `selinux_status_open(3)` has already
been called with success.

`selinux_status_open(3)` might be called unintentionally multiple times,
e.g. once to manually be able to call `selinux_status_getenforce(3)` and
once indirectly through `selinux_check_access(3)`
(since libselinux 3.2).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/sestatus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
index 12b015e0..531a522c 100644
--- a/libselinux/src/sestatus.c
+++ b/libselinux/src/sestatus.c
@@ -282,6 +282,10 @@ int selinux_status_open(int fallback)
 	long		pagesize;
 	uint32_t	seqno;
 
+	if (selinux_status != NULL) {
+		return 0;
+	}
+
 	if (!selinux_mnt) {
 		errno = ENOENT;
 		return -1;
-- 
2.31.1

