Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A805C3F2D4
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 14:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBB2246AE
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 14:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7ik2bDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgB1OFw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:05:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36530 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgB1OFu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 09:05:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id d9so1589485pgu.3
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 06:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NLCy5wAvWVD2u0F8d+QCHPjwvw2Q4FFL8KdhB7Bv9MM=;
        b=D7ik2bDX28JADgwK+Y5+7ndia3GDoIbPJ4jdl5RgNYn51TYvK1PDx3dTVqoLTYIHz0
         l4+YLGlBxMGJTmPJHqytHucaqgLHE+pSZiMTIL/W7IFG3A9JF8I4s0vzKUG3VB0mmvCa
         jY426Y4fw2Ph9qQRGfTjshA8kPCB+yjPiouniPMjF73AJgd2T1UXDOldO5jnBAKB5IPB
         6UH3UQr82zqVZs2AxSbQkPt/JAy+GzJE/KaW4x0f/JJyIB9T54PVqmXmRwg5TShxtF54
         mXymB1m2sO13+hC/x6HBse06vDdY0+q+phTGxhA1+O4fysRVTdIgydpDS7vM+exZswot
         L18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NLCy5wAvWVD2u0F8d+QCHPjwvw2Q4FFL8KdhB7Bv9MM=;
        b=nPLrfhQnhICEsQbkd2i3ygmV/vAqAsCtOR3Nc2pRK2EcKyqF95Rkm54FFdnM1Tz6q0
         Jm4JLoi9+SRMHxxXMytzbp/AvKXt0lSbYnJQwP5yQa52pXRJECjX4aX70peiUDHIDhgG
         EnEywVfXR5SibBdYrOS3Wz+rCB6NBbu+2SpyPPLnLJd8o3RGQ3+Thc/2QgUQ+89sxTUW
         Tgy+FaLZYYu6keiuotE8bnr3hetqeTPnUFRf302IjsRpSt+1DcV5DC/Z3elKHxHojG2h
         6vXTUirHtkkemPR1O/GU2zZLF5urerttXIa783Fg3BNbkVuDFD4AqsEAUrUNkEdygTE7
         Ca8g==
X-Gm-Message-State: APjAAAVxy8+WTMHAy7NrGOMQPeduAscuOCvyHuiB0HvQjeSZSl5MgcI8
        Sd1p2iRwf1fSkbaH6HeBsB/yHIwc
X-Google-Smtp-Source: APXvYqz8q6B05Or5C37mpC0nBT79S5q3usIM0UXy+AIYLuVFbx7c3pmv9PYzxXMwVugXtvhha/zVRw==
X-Received: by 2002:a62:ea08:: with SMTP id t8mr4224069pfh.163.1582898749160;
        Fri, 28 Feb 2020 06:05:49 -0800 (PST)
Received: from localhost.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id t11sm2656903pjo.21.2020.02.28.06.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 06:05:48 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org, drepper@redhat.com, omosnace@redhat.com,
        stephen.smalley.work@gmail.com, plautrba@redhat.com
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 2/4] Makefile: add -fno-semantic-interposition
Date:   Fri, 28 Feb 2020 08:05:22 -0600
Message-Id: <20200228140524.2404-3-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228140524.2404-1-william.c.roberts@intel.com>
References: <CAEjxPJ4ae=FLqEDofLwSP0PEeqUqh1WtoSVFb9TrafMhawfhPg@mail.gmail.com>
 <20200228140524.2404-1-william.c.roberts@intel.com>
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

