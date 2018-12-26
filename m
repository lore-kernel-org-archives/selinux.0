Return-Path: <SRS0=3Vz+=PD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F5CC43387
	for <selinux@archiver.kernel.org>; Wed, 26 Dec 2018 14:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA3B214C6
	for <selinux@archiver.kernel.org>; Wed, 26 Dec 2018 14:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkFrLMDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeLZOyk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Dec 2018 09:54:40 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42112 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbeLZOyk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Dec 2018 09:54:40 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so7613597plp.9
        for <selinux@vger.kernel.org>; Wed, 26 Dec 2018 06:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xdSOQYTilgeq+j6a1W5blPb0T5vwCBaMapoI57QPMKM=;
        b=dkFrLMDdDAg7CVwDGqDfekojq/MdgzPbpqZFNQopzu57pgOaC8NPNtA/FQ408UwBSF
         hGx6exyCZWISTqZziPCzYaBpws01WXfJGqK7i43VWnWBvX5YZnAhhQWx06sLHaaSh1Ty
         rFBueg70jLnTLBXerrs3qNkBzOEuwBBP83R/z1Q0yUehSnWwQZ9lpsA1yz42hlUMUXEa
         b4CQatGtR4o1KIIbq2faFq0jZx05KB+3Wk3rYZVltYyhlt85hy5W9SMTZEEGlDXW+G0K
         YSM9BxMiejK+4hJukiKKC+qzur0dNvFK3uDHWuwfRRBJtZzbYWFvtq4kkWdXnXjWIY0L
         fWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xdSOQYTilgeq+j6a1W5blPb0T5vwCBaMapoI57QPMKM=;
        b=S05LoZmv/9H3TIQ/hQ/IAD0xxo9xXITYCFbnfPGiAu/9S0Q1qzYpAIavkEYmwVg4Ng
         PVSlcfZ5KAdrmatR/L1WR6ZqUMkNjfpao2LzT1FBRoff1mFNe6h9YFSzf4Qc5ScLQlH8
         cv0bs+7OmmIiz1s/yqZ29hhQi+4BLB2l8Y4aU7kyt2WUiTjn51HSbOzpOS0S/IL+q+s4
         4mcPylgMEsEf+eG/tYpglVYhqf+WTt99G955cH+LCb7YBG1Ap6nZO+m6RyOpSlZ4RkNg
         9vCfyS34KoHoPDC4hLdLCfddlsVXosA0kFkHj1vc+c6jR69m2AsT8hWi8GgGy7i99ft6
         uGfQ==
X-Gm-Message-State: AJcUukeQTDugmoLqkGDw+RrhevnpHSmEKcGJJGTBkjiDuluRPlSdcLAz
        Bd6q5j7Noyz9s3nYWUjlRD7EECHQ
X-Google-Smtp-Source: ALg8bN4sOHniO//4iDAwe0J0xoGasidz1vKbXDbrAwB44d7jmZ9z+5/aaNRXpyMG8s03jg2JXkaB5w==
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr19941162plb.238.1545836078812;
        Wed, 26 Dec 2018 06:54:38 -0800 (PST)
Received: from wcrobert-MOBL1.amr.corp.intel.com (jfdmzpr05-ext.jf.intel.com. [134.134.139.74])
        by smtp.gmail.com with ESMTPSA id 125sm45110583pfg.39.2018.12.26.06.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Dec 2018 06:54:37 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org
Cc:     sds@tycho.nsa.gov, William Roberts <william.c.roberts@intel.com>
Subject: [V2 PATCH 1/3] Makefile: fix _FORTIFY_SOURCE redefined build error
Date:   Wed, 26 Dec 2018 06:54:26 -0800
Message-Id: <1545836068-7824-1-git-send-email-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Certain builds of gcc enable _FORTIFY_SOURCE which results in the error:
<command-line>:0:0: warning: "_FORTIFY_SOURCE" redefined
<command-line>:0:0: note: this is the location of the previous definition

Correct this by undefining it first and redefining it. Also, the previous
command line option was using -Wp which is passing the value *AS IS* to the
pre-processor rather than to the compiler driver. The C pre-processor has
an undocumented interface subject to change per man 1 gcc. Just use the
-D option to specify this value.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/Makefile   | 2 +-
 libselinux/utils/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 977b5c8cfcca..6263d11393e6 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -64,7 +64,7 @@ ifeq ($(COMPILER), gcc)
 EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
 	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
 	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
-	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -Wp,-D_FORTIFY_SOURCE
+	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE
 else
 EXTRA_CFLAGS = -Wunused-command-line-argument
 endif
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index d06ffd66893b..890ff36f3bbc 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -30,7 +30,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Wformat-extra-args -Wformat-zero-length -Wformat=2 -Wmultichar \
           -Woverflow -Wpointer-to-int-cast -Wpragmas \
           -Wno-missing-field-initializers -Wno-sign-compare \
-          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE \
+          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE \
           -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
           -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
           -Werror -Wno-aggregate-return -Wno-redundant-decls \
-- 
2.7.4

