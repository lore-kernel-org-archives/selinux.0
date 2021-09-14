Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3FAC433F5
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CA460F58
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbhINMwG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbhINMwF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 08:52:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80924C061766
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j13so19684733edv.13
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sUcWbZEsagYCsYe2kOOTbpLjbFUKNZmcmVw/Fchgzw8=;
        b=LDoAYN1km4otTjpiH//EDyHdaZKlSgD/fbiFPGC6WQJqawe9Rl4Iu8TiMbfPXD09uZ
         gXES0MHFs6FAiunH6emmJbpMX0iX1CVCee8o9vK5+87lzU9yDR90Jq5r67dDKrDEliJX
         oRMte0wBX3F+Ejyxe1BdjQDfwLEaNlicf3G0y7fdudcxaRxXKTig8iCofrMlhNh7mcim
         ttIacsgyI4Mph5wYrGszt2WVfAsytiQBwKkhJu7NM5zYW1/wnMH/WrnvGj/HOxah63jY
         4fro7bVZuCi0ZIK/bds7nDDiZ8yDd1VRjuFGm3YJVkyJiivXEyLv0TM9A/hSuATOHLIs
         6BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sUcWbZEsagYCsYe2kOOTbpLjbFUKNZmcmVw/Fchgzw8=;
        b=7VF0Hp0gzCo7+WN4bur0QlIC1sDIILqUqxEGrP6RahWhTsUTeSmMF0p4NvhmmnoXaE
         Pak/bEfn65wGcYjii0oJONUKYx0kSX/VEUqTFw9AZluMV8wFtW7jmPRRPAop+y2yNBdG
         IALhiLxNqu7QpZzBWE7+YsDbRbh9m/Q97SYFIX4NbKakXEYL3H46pRJjHAEA4sGX/HEe
         2Hk47LTXdFyYw0Rxmizgd0C1Ej2h8umq16FTcW4SDS3OVcJG+ngYGLq2nWS0l9BTVMLY
         CsuaV3QPKeiea+/lP1gf96RcElSM8EakTap0P9Cmq/k7Hm86v5vNvAOcWzF7ADSb4IKu
         p3/w==
X-Gm-Message-State: AOAM530FY8M3kgUWIPjh21m3nCncnZrPVvPL20mzGKCNWxPxzKASG9Jm
        MUDA+lzwPR3hv/gkdFw0c/LhLLd3zxI=
X-Google-Smtp-Source: ABdhPJzhjCwpFnSWge09TMiKsb2P0jOJIgVorWen9HMSzQodfIdt/ctUTxiPY7SgWJi+M3QC/LPyjw==
X-Received: by 2002:a05:6402:518e:: with SMTP id q14mr19079628edd.268.1631623847058;
        Tue, 14 Sep 2021 05:50:47 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-237-250.77.3.pool.telefonica.de. [77.3.237.250])
        by smtp.gmail.com with ESMTPSA id r8sm5567865eds.39.2021.09.14.05.50.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:50:46 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 08/13] checkpolicy: add missing function declarations
Date:   Tue, 14 Sep 2021 14:48:23 +0200
Message-Id: <20210914124828.19488-9-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914124828.19488-1-cgzones@googlemail.com>
References: <20210914124828.19488-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ideally they should be declared in the corresponding header file, but
the overall include style in the checkpolicy code is quite messy.
Declare them for now in the source file before defining them to silence
related compiler warnings:

    policy_define.c:84:6: error: no previous prototype for function 'init_parser' [-Werror,-Wmissing-prototypes]
    void init_parser(int pass_number)
         ^
    policy_define.c:93:6: error: no previous prototype for function 'yyerror2' [-Werror,-Wmissing-prototypes]
    void yyerror2(const char *fmt, ...)
         ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 11707700..c71e0571 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -60,6 +60,10 @@
 #include "module_compiler.h"
 #include "policy_define.h"
 
+extern void init_parser(int pass_number);
+__attribute__ ((format(printf, 1, 2)))
+extern void yyerror2(const char *fmt, ...);
+
 policydb_t *policydbp;
 queue_t id_queue = 0;
 unsigned int pass;
@@ -89,7 +93,6 @@ void init_parser(int pass_number)
 	pass = pass_number;
 }
 
-__attribute__ ((format(printf, 1, 2)))
 void yyerror2(const char *fmt, ...)
 {
 	va_list ap;
-- 
2.33.0

