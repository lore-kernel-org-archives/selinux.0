Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FCFC3F2C6
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 23:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491B624699
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 23:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CimnsLYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgB0XBp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:01:45 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39082 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbgB0XBo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 18:01:44 -0500
Received: by mail-pj1-f65.google.com with SMTP id e9so424544pjr.4
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 15:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NLCy5wAvWVD2u0F8d+QCHPjwvw2Q4FFL8KdhB7Bv9MM=;
        b=CimnsLYWqeViolun/KxypkG8sshRIC8qIokGsmurlVSavxMoCLBfwhFdJfCUNrO1b7
         dhv02UYdzwBEre2pAAy8TtaJXS6FsHce+4tugbJdE5Mb24lDXLykXix0pLkMLz5ZPVIM
         I1yq3f6Q2W8VS+2CNVnLNwvTT/liV5IY+fmWY+FcL1Oo8oetCWnAfCmc+/9QemqXik3D
         lDMZh8bkv85KGy5wKUtUPDp3hqgtL5PryHus00MRXcpsfS7nWkmC3U7oVa6rOaTEMiw3
         GIhxokpFohXkhxc2F/bY4DfR8ESnAR0pVnUVvvFJpAngOJSyQ4QH0YzhrsGdHewN0PLS
         SKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NLCy5wAvWVD2u0F8d+QCHPjwvw2Q4FFL8KdhB7Bv9MM=;
        b=o/rXKJjxlkwUXFW/js7ciWFvUmX6b8eLGWtXdPAMSdKsgCjSGDHEw474DTJZjS2VoI
         J3wLBcnUSNJPLhONoTeZ+0J6k8Wi0XkWkXrlbHVwubjfm0zA5/C4PT2+HhpM/NXbKTw8
         X/e2HMQvTXswNIks9+HOmL5Kej03//Y8+bTC/8ADJyJd0PeYw5eJf+WV9zAgEYNafbtg
         ZT5Lr4Q97Eeg0Nvwyh0ltXVT5xJdO0p88dcyVdthmFjtQofKfSJooh3ygIDdXTYCdMI8
         8PzRs+GVpMu+58hQG/5Jr4qC2g6VQaxGfwGNNiwxkNVt1HEGR/StGc8dcmy2SYb1GpXF
         IkqA==
X-Gm-Message-State: APjAAAVcLKI56SdeDrQZoHRuZJ0cjzd61+mhO19NUsBF/bK/LFykQSvc
        yGXcB2iaPKLjw/TL4hrjgP/Ji9K4
X-Google-Smtp-Source: APXvYqwcMbATOqgmkHqXQPve1ljv0pZhkq/Gpq6JsWGMg1QKQM+pY0fYzCflBxPw/Ncs73dISVQYFw==
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr1020732plv.297.1582844501884;
        Thu, 27 Feb 2020 15:01:41 -0800 (PST)
Received: from localhost.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id b27sm7749969pgl.77.2020.02.27.15.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 15:01:41 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org, drepper@redhat.com, omosnace@redhat.com,
        stephen.smalley.work@gmail.com, plautrba@redhat.com
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 2/3] Makefile: add -fno-semantic-interposition
Date:   Thu, 27 Feb 2020 17:01:28 -0600
Message-Id: <20200227230129.31166-3-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227230129.31166-1-william.c.roberts@intel.com>
References: <20200227230129.31166-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Add -fno-semantic-interposition to CFLAGS. This will restore
the DSO infrastructures protections to insure internal callers
of exported symbols call into libselinux and not something laoding first
in the library list.

Clang has this enabled by default.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 7f5a5d7418e9..c76110fbc650 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -65,7 +65,7 @@ EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nan
 	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
 	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
 	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 \
-	-Wstrict-overflow=5
+	-Wstrict-overflow=5 -fno-semantic-interposition
 else
 EXTRA_CFLAGS = -Wunused-command-line-argument
 endif
-- 
2.17.1

