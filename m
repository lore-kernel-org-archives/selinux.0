Return-Path: <SRS0=DV1m=OW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D98C65BAE
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 21:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA2620811
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 21:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVhs/KJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA2620811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeLMVdN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:33:13 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:46898 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeLMVdN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Dec 2018 16:33:13 -0500
Received: by mail-pl1-f171.google.com with SMTP id t13so1638943ply.13
        for <selinux@vger.kernel.org>; Thu, 13 Dec 2018 13:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zza9sUikUYHCW0U7Ka4rHaeUSrnuAtwfRxTc9liQ6NU=;
        b=VVhs/KJK+qz3Jejmlvc1GpubSyklhRIIuGI0b38bkEyritovIU/bFcFFm3jqQmyU8Z
         wG5CcRn/tO2w7TJmXzGwMv8juDg3g64Za5tXUw7Y3UthM1bFBN8vuN4Lc1IeIquXlSfY
         6fUQUW853loG+X4QALJDaQq18DM+WnpKMnIOqFr4R/le4HMcccbLWY2GgJ4WUAdmhmmR
         eHt3WspOLn4vPGbPb7ZIWVu7WxouekM92Pi6oFFczyh+jfWnGdQIZGJ+dchplzDBCiUX
         TfYcQmpJwh7OWe7EcGyTJA21abqgyfSPjxugXGWlyATU4+KAS5JIouIyHfCam1r6WWMJ
         I+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zza9sUikUYHCW0U7Ka4rHaeUSrnuAtwfRxTc9liQ6NU=;
        b=il8uIaY4yjGIlwWqBODVqan5z+ezZERlyFD5ojJWaOtyBNMDuM4Cvfiv4E2yqvhwF4
         OgNGUz+/dG3Vcv3+D03MCImNmhtO1XMb79Xy9NYtJiSj4GlM19NiiZOe+DrkEuwG+6+d
         gFRDa7HNYqaNiGcc0uAkMZzGRn4vCgleHed8vZXbY41qDWzzOyMgNL8xfskHhGLoB3UL
         vcpW4vdSBleR5iq0LNRlsQMzXkFWYuCQohBaf7tyd8T2EAyYej5Mb9PbSkXwSN4mWfKy
         rGuvdwJSrrqE2EWHCKZ1w+BF3o+f4kMbiYIuQjyJpFfPT+8ZfilKSYW9U0gMkn5cRRa+
         7HZA==
X-Gm-Message-State: AA+aEWYzcNUU0mxB7TMmujAXwXjDXpSSeYTeJFHLJNwZ3X1LSR7X6W49
        DuUTdLDWzUpv5AQzxYF7FNPbzAM/
X-Google-Smtp-Source: AFSGD/VM+jvg8G+r8zNqMwpcP1z/YvfCUS2DKzHAuTDSLQ3awAG4VTMFR4NSHJcMihpqmCbLKFflZA==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12mr462164pld.8.1544736792300;
        Thu, 13 Dec 2018 13:33:12 -0800 (PST)
Received: from wcrobert-MOBL1.amr.corp.intel.com ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id m20sm3999794pgb.56.2018.12.13.13.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 13:33:11 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org
Cc:     sds@tycho.nsa.gov, William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 2/2] Makefile: add -Wstrict-overflow=5 to CFLAGS
Date:   Thu, 13 Dec 2018 13:32:41 -0800
Message-Id: <1544736761-7920-2-git-send-email-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544736761-7920-1-git-send-email-william.c.roberts@intel.com>
References: <1544736761-7920-1-git-send-email-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Build with strict overflow checking enabled. If the compiler optimizes
code that could be removed due to undefined signed overflow, then the
compiler will issue a warning.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/Makefile   | 3 ++-
 libselinux/utils/Makefile | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index ee55bd0dbff7..a283ac9d90c2 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -64,7 +64,8 @@ ifeq ($(COMPILER), gcc)
 EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
 	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
 	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
-	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
+	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1 \
+        -Wstrict-overflow=5
 else
 EXTRA_CFLAGS = -Wunused-command-line-argument
 endif
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 64ab877015c6..c2f59ea947cc 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -33,7 +33,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1 \
           -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
           -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
-          -Werror -Wno-aggregate-return -Wno-redundant-decls \
+          -Werror -Wno-aggregate-return -Wno-redundant-decls -Wstrict-overflow=5 \
           $(EXTRA_CFLAGS)
 
 LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-z,relro
-- 
2.7.4

