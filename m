Return-Path: <SRS0=NH41=7V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712CCC433E0
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 15:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E70206C3
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 15:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuA+kiih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbgFHPha (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgFHPh3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Jun 2020 11:37:29 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407D1C08C5C2
        for <selinux@vger.kernel.org>; Mon,  8 Jun 2020 08:37:29 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u8so861163pje.4
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2020 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aKPr9gLZ4O8+nDJ3qnx5Rc5k3WMm8dVRY/icceQbM3g=;
        b=HuA+kiihCMptss+DAq+Q0/Tv1BX4lrWo3Ya9UwzYc1WruvA10ziuHJMI9gdxYPC/ge
         ZDVhZCNRzflOMXF+pcGk3h5uksMHBrEk3azP5SwIVwkplzRW5Wc3AXQ1M4ngfD9fVdn3
         +M/1zKJFZ7nUh0H8XGoG0jE4B/Y9GvGH2wDa+Lk/qpoL/9A8k84g3CIDtQRpfgoCrdMu
         6E7YoZoSXtKsiTQXCwr27SH5Vhvp1FAbtvE+NDRT66L+s5BwoeOyVqZ8VNvVPU5myrSP
         EuWIhMzNOjLb/EZBUEdeEgAIzw9V8qHz8Nzu6+LgUJJW0j8IxF4cWmlUItDDKZhp0eXM
         nZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aKPr9gLZ4O8+nDJ3qnx5Rc5k3WMm8dVRY/icceQbM3g=;
        b=GbImtPl0PVcBVGeESyJ1K4OCjFU6Ke/Wr7IxgN3l95fUbV6dyqt/RfFn08iE2Yxl/8
         LOf0x+Ay+yH37/S9d/Za2kr01zG+e02ANZFysxri3fqAh3FhugN7foq0QK4r94/SX2I4
         qlmiaPDDoqm55ZsuX7wBjyr8/dFCGbxsrO6wH3RcD6xqBcdH2Zw6lu6mu+ux4YFTV4xB
         fnNK9z21bj/DER/063fjz9ZTVU9isMorW+XDaAh3fnlRUalvuPc7119nPDMEsYrWHURp
         YPHerhQ3lPRQ+ZcD9igseF5bYJict+5jFf3hvQEohpZ4Gqe3nIhnM/HxeMuKm1jq6Bfk
         ay7Q==
X-Gm-Message-State: AOAM531orOJanI6pec7IVYrAcRMgSTTKspHZuTkJmxLncbuohYRBN6S2
        bfQlT6LQJMPRXcxKx/tLBf0=
X-Google-Smtp-Source: ABdhPJyYDKP0PLHZ/6zoQJIDJZzwcMsFzFVY6tsdgZ75D+ZxTH4k0z5oKCFf/VorN0KMDOgvVctjPw==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr21586998plb.217.1591630648654;
        Mon, 08 Jun 2020 08:37:28 -0700 (PDT)
Received: from localhost.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id x1sm7343160pfn.76.2020.06.08.08.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:37:27 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     stephen.smalley.work@gmail.com
Cc:     bigon@debian.org, bill.c.roberts@gmail.com, plautrba@redhat.com,
        selinux@vger.kernel.org, william.c.roberts@intel.com
Subject: [PATCH v2] README: start a section for documenting CFLAGS
Date:   Mon,  8 Jun 2020 10:37:22 -0500
Message-Id: <20200608153722.18622-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAEjxPJ4NU0rd0ZgGuNXpWy37St==bfT8_XfR1Z1YQNwdLVR6tw@mail.gmail.com>
References: <CAEjxPJ4NU0rd0ZgGuNXpWy37St==bfT8_XfR1Z1YQNwdLVR6tw@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Start a section in the README for documenting that custom CFLAGS yields
CUSTOM results and that your mileage may vary. The first CFLAG to
document that you likely want to include is -fsemantic-interposition.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
v2:
  - Fixed commit message spelling of yields.
  - Reduced usages of CFLAGS in documentation.

 README.md | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/README.md b/README.md
index 9d64f0b5cf90..eb8e170ea1f7 100644
--- a/README.md
+++ b/README.md
@@ -120,6 +120,17 @@ lacks library functions or other dependencies relied upon by your
 distribution.  If it breaks, you get to keep both pieces.
 
 
+## Setting CFLAGS
+
+Setting CFLAGS during the make process will cause the omission of many defaults. While the project strives
+to provide a reasonable set of default flags, custom CFLAGS could break the build, or have other undesired
+changes on the build output. Thus, be very careful when setting CFLAGS. CFLAGS that are encouraged to be
+set when overriding are:
+
+- -fsemantic-interposition for gcc or compilers that do not do this. clang does this by default. clang-10 and up
+   will support passing this flag, but ignore it. Previous clang versions fail.
+
+
 macOS
 -----
 
-- 
2.17.1

