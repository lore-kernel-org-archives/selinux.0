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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCCBC67839
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 21:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC9320811
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 21:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shQvZbRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC9320811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeLMVc7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:32:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46372 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeLMVc6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Dec 2018 16:32:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so1627868pgp.13
        for <selinux@vger.kernel.org>; Thu, 13 Dec 2018 13:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WOcdOuSqnlUiQQv5Mr8mYIiGalhrG7QXqmf+8IUFQU4=;
        b=shQvZbRTk+90Q7AWQYE9plGi/mVQeYmSjqc6xuXmUic1mXJPgaXJsyf09QABn30xXx
         H1a6SqypoxtHcEXtzRWxe2+ktnVyXnEIYnkbY8SNKNw+dytagLqNMcZizeJ5vju5xbdz
         ldeKSnwmMgxA5qSlR6WwAu9Y21Wo/lP5+22bPibQ2pbjxa6HtQcFQ0xD3WmeMauKns9C
         7bnWgHY0lkxYNkf3PhYtc3Le75j0fve0ehIUpJA7R8w3ZF8IIa/MMZXIBjhTveWleMnu
         fduSynxBhMz9/pR1rRoClkl0NhslFXLO+5IYK65t6SZ/XtEsegXI+y1dWxVXXN0urPWQ
         XNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WOcdOuSqnlUiQQv5Mr8mYIiGalhrG7QXqmf+8IUFQU4=;
        b=l/00UGpLZ5ZFOmNebeevGSvOxLelstShOJI4Hz2Ce/DBWZ3nfKtH0Yf5jDtJ6E2h4c
         bI347yM755cQo+uGnGNW+gswecHe/ZXr7Wf+WvNhfENxLziIGQjwY3lqtQwRmCG5F7dJ
         VhnX4AuqrqT/BwRi6GY2ISekDNEaeGwNZFo+crhQFvLohBIvkzm1zQLfcgdZ39UfV6xb
         6pIg+yBbHPyxWsvZWLY+0LHRHJEjwXt4AZ8ZUDFPwUbYrwxmQlqedk0CutIAecK7XuFR
         KW88LzmGk868Akr1n7+CNosqO3JLBnPVhtd4BrgI1Lj8Nknd74wXt5LuOZEZzxTKQh2a
         EjRw==
X-Gm-Message-State: AA+aEWbiAaiTqceoLPZT4Ii2szGufA+hrcuXe1115ac9MbXtHceUNeyL
        8Bq/GBYTQg+Eq/wWDUHwXOlHhStX
X-Google-Smtp-Source: AFSGD/XDKrNXbsU7E+tr2GxZhz96dZcEwO1HT2TfbOQup4kM/wJH/2q0blVMzjuCU2O22oBnPx4XMg==
X-Received: by 2002:a63:374e:: with SMTP id g14mr393597pgn.59.1544736777468;
        Thu, 13 Dec 2018 13:32:57 -0800 (PST)
Received: from wcrobert-MOBL1.amr.corp.intel.com ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id m20sm3999794pgb.56.2018.12.13.13.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 13:32:56 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org
Cc:     sds@tycho.nsa.gov, William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 1/2] Makefile: fix _FORTIFY_SOURCE redefined build error
Date:   Thu, 13 Dec 2018 13:32:40 -0800
Message-Id: <1544736761-7920-1-git-send-email-william.c.roberts@intel.com>
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
command line option was using -Wp which passing the value *AS IS* to the
pre-processor rather than to the compiler driver. The C pre-processor has
an undocumented interface subject to change per man 1 gcc. Just use the
-D option as is.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/Makefile   | 2 +-
 libselinux/utils/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 977b5c8cfcca..ee55bd0dbff7 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -64,7 +64,7 @@ ifeq ($(COMPILER), gcc)
 EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
 	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
 	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
-	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -Wp,-D_FORTIFY_SOURCE
+	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
 else
 EXTRA_CFLAGS = -Wunused-command-line-argument
 endif
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index d06ffd66893b..64ab877015c6 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -30,7 +30,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Wformat-extra-args -Wformat-zero-length -Wformat=2 -Wmultichar \
           -Woverflow -Wpointer-to-int-cast -Wpragmas \
           -Wno-missing-field-initializers -Wno-sign-compare \
-          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE \
+          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1 \
           -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
           -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
           -Werror -Wno-aggregate-return -Wno-redundant-decls \
-- 
2.7.4

