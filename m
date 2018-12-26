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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA715C43387
	for <selinux@archiver.kernel.org>; Wed, 26 Dec 2018 14:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B81214C6
	for <selinux@archiver.kernel.org>; Wed, 26 Dec 2018 14:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0tn7AFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbeLZOym (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Dec 2018 09:54:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46619 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbeLZOym (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Dec 2018 09:54:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so7635623pgp.13
        for <selinux@vger.kernel.org>; Wed, 26 Dec 2018 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rsWmmcHo9Fq+rgmwGo0dVrXm+j/6Vle5tFvSFkQruyg=;
        b=n0tn7AFw0X0FAorGaRo7feztouqQNHZt3PuDEF09T4uxSlGAVfwnTDqkK3euNoa23Q
         8mK07TflP50f8U2aGdRqgMhRYd3kCBMDi2B67BQzCOHJ+7l9MU77/psVwLGkm24FMu/n
         36teEFk4YYEv0iUHSzZdQBdeKyPWfZEeZByGK5yNUTl5UsLyTeGZAQWbt1DEeOHcGKtQ
         cnw5Lq0UYhLMYHESwqepw33GLxLutCUou3nw3thro/XArqekPD1v657eyPUO8g5U85S/
         csWjziXP5lFbCe9TuwqtOTPD6Y3Uqj/rEX6JKOV17ck4zmc2Hyld152ZumZOec3IBiw/
         QF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rsWmmcHo9Fq+rgmwGo0dVrXm+j/6Vle5tFvSFkQruyg=;
        b=rl5L+QTK0ePWowC6YjL+kEr3kysfTwsTj8bC5OdIQSqDyI6RFrZqMcs18UnHzXbKDt
         iIsBTRkf5ZR3OOkj4RVG38V6JrnQsZVsQm8fykyx1OA9vIMciWvHkAOyko+94mgO2eqL
         OEYxpWbeYhGSwOL5TEbdkXGZTgrOu7NSPefCRvz/XwViccChGFjzM7i3fm1Xjgh4FZCn
         5Ph+WRKsgO/eC6nodgqAhEHdHjqsctMSV1/wMhThsLJY6lir4FoNrdaM/xJMVXR2d9Dx
         rkHApMETSBGFQotgTILPUAa3ihO2eSFyQp8OXEb2CPB+JKYeHlj9G9OvVMgF74/SN4RL
         eqOg==
X-Gm-Message-State: AA+aEWYXd0e3RFR9DpzI9EAJ2S7+9J+u0FIdRCIbHN2WBVJIgzrGLRBn
        TZuq1XHYiWX/p7le2jbuNeT0jzUM
X-Google-Smtp-Source: AFSGD/X9RFMDlHy5sFtmQy4ZX++ieGnMDpRldG5hGsTXMS6XyYjpMo4dbosPDGc4QhzVaYv8OGiP5g==
X-Received: by 2002:a62:b24a:: with SMTP id x71mr20900648pfe.148.1545836080716;
        Wed, 26 Dec 2018 06:54:40 -0800 (PST)
Received: from wcrobert-MOBL1.amr.corp.intel.com (jfdmzpr05-ext.jf.intel.com. [134.134.139.74])
        by smtp.gmail.com with ESMTPSA id 125sm45110583pfg.39.2018.12.26.06.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Dec 2018 06:54:40 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org
Cc:     sds@tycho.nsa.gov, William Roberts <william.c.roberts@intel.com>
Subject: [V2 PATCH 2/3] build: set _FORTIFY_SOURCE=2 in libselinux
Date:   Wed, 26 Dec 2018 06:54:27 -0800
Message-Id: <1545836068-7824-2-git-send-email-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545836068-7824-1-git-send-email-william.c.roberts@intel.com>
References: <1545836068-7824-1-git-send-email-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Use -D_FO0RTIFY_SOURCE=2 when building libselinux and it's util library.
Note that this can be overridden by setting CFLAGS during the build.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/Makefile   | 2 +-
 libselinux/utils/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 6263d11393e6..1a9223c0027d 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -64,7 +64,7 @@ ifeq ($(COMPILER), gcc)
 EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
 	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
 	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
-	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE
+	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2
 else
 EXTRA_CFLAGS = -Wunused-command-line-argument
 endif
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 890ff36f3bbc..e7a75121f049 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -30,7 +30,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Wformat-extra-args -Wformat-zero-length -Wformat=2 -Wmultichar \
           -Woverflow -Wpointer-to-int-cast -Wpragmas \
           -Wno-missing-field-initializers -Wno-sign-compare \
-          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE \
+          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 \
           -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
           -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
           -Werror -Wno-aggregate-return -Wno-redundant-decls \
-- 
2.7.4

