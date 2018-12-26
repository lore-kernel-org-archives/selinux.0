Return-Path: <SRS0=3Vz+=PD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24572C43387
	for <selinux@archiver.kernel.org>; Wed, 26 Dec 2018 14:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81D821720
	for <selinux@archiver.kernel.org>; Wed, 26 Dec 2018 14:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6+Db4X+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeLZOyn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Dec 2018 09:54:43 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:37353 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbeLZOyn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Dec 2018 09:54:43 -0500
Received: by mail-pl1-f177.google.com with SMTP id b5so7631461plr.4
        for <selinux@vger.kernel.org>; Wed, 26 Dec 2018 06:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CRT+gmnzz8170KIqVT+admga/R3uP0x76KWDbSknrQw=;
        b=J6+Db4X+l6URRNx3+Cr34O0zpvfsj1M0VTbcwVS3zX5lrlXeg07DB9GdF6J5TFp9aE
         fWRwLm/Mw73CNeeE7q3LPgIrh+tl2Ny4Cq2DyG0SCLRnPo2w6Gf3EcUE45m2JY+iw740
         PBhtccW1tUPAM+gmGzFQcD2L2JBcfRqvYhNdWjn+V5gOcQix/Wmp/dYa0yGKgTYskxM6
         Tf97//+/tR4M0px2tEag1CSbbBQv74jfH9YNNVNmSxHJqmxEBn9jJIIZ1DKUFfGC1KcI
         yjYWEzL+nzFEM45sEuGVHTc+pVRxgNVSkW8ELaCqUt0YLlcdFR2fbjNZLq4ZE8Z2kza2
         TJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CRT+gmnzz8170KIqVT+admga/R3uP0x76KWDbSknrQw=;
        b=SYWf92+PqMXkB4vynqrhDB/PtzGD02bYvM+8uYEw9Lv3dgeP1FdGtDXWOPTrPAr4Jw
         Clt20AjgrbCNjgKBKa7M0o3YlQiCy4MmNFJMxoK33f+au0zB8fPJcDSGMB5vdDFZaag6
         8SINl4K3806OAXLY+w16o1Ka6DMM7wWmxG1/HoVtH60uEXhr6K6JydXI2Wm9ldFQY+Yu
         1nC5t0HLb+cMrTo+B+vNbigufydu9tuNuYJXhadDj7Xkvyc7572nEzR0L3jYuOEZXxjz
         SBodK27c0lbHk/fRSymOuztbcxBMnqcfjDqmU8Ti3ZP+nG/9VplwVkmqPMXNQssjQ9mv
         MPxQ==
X-Gm-Message-State: AJcUukcaV2PkpsUPEWhzpsKNa8aLWK9dVlJtP0gVaZmBFVVDbb3r853z
        bBKAvweaaJa1Iwgr5QwRcV1P7IJq
X-Google-Smtp-Source: ALg8bN51LveVM60xBjKxMhLM3gERhm5cmpVVbKra5m9fiF259Zqdom6JGDiMZvHdW4E8eZVM8foTtQ==
X-Received: by 2002:a17:902:a50a:: with SMTP id s10mr19153429plq.278.1545836082268;
        Wed, 26 Dec 2018 06:54:42 -0800 (PST)
Received: from wcrobert-MOBL1.amr.corp.intel.com (jfdmzpr05-ext.jf.intel.com. [134.134.139.74])
        by smtp.gmail.com with ESMTPSA id 125sm45110583pfg.39.2018.12.26.06.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Dec 2018 06:54:41 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org
Cc:     sds@tycho.nsa.gov, William Roberts <william.c.roberts@intel.com>
Subject: [V2 PATCH 3/3] Makefile: add -Wstrict-overflow=5 to CFLAGS
Date:   Wed, 26 Dec 2018 06:54:28 -0800
Message-Id: <1545836068-7824-3-git-send-email-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545836068-7824-1-git-send-email-william.c.roberts@intel.com>
References: <1545836068-7824-1-git-send-email-william.c.roberts@intel.com>
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
index 1a9223c0027d..8891086e4af6 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -64,7 +64,8 @@ ifeq ($(COMPILER), gcc)
 EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
 	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
 	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
-	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2
+	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 \
+	-Wstrict-overflow=5
 else
 EXTRA_CFLAGS = -Wunused-command-line-argument
 endif
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index e7a75121f049..361506384d08 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -33,7 +33,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 \
           -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
           -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
-          -Werror -Wno-aggregate-return -Wno-redundant-decls \
+          -Werror -Wno-aggregate-return -Wno-redundant-decls -Wstrict-overflow=5 \
           $(EXTRA_CFLAGS)
 
 LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-z,relro
-- 
2.7.4

