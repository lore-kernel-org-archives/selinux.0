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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53416C433EF
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D37560F58
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhINMwH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhINMwH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 08:52:07 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCC4C061760
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:50 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c22so18311080edn.12
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=D1AoMropzllZOsLvZSZ2ud+yeMiAjVWTDSbTeIIwkCM=;
        b=DNRpWm3Mw6nXbq1sskvbtoEclIMoBH6sHXQvBUH0fAgxlJJ36EOucIWs2b+VF/xHJM
         VANfqv3cnzq0jcrL1cimgJGXzLf99CAIrD1PWkIZTI52lUdO84sq4cfQOvq0HbeMOeJS
         pPmWrLTWLbf2Yd6tphFOJB1yWwcHlPohuyJKfb1zsX3+XyBtyZu2MvQc93yuZukTx+SR
         0c+2UBK5tqTHiPngqfPzlf+QsJilK/2HRQYGFnoDEYSkQXPKqY0G/fPGSKKywkyU8zac
         vqOup5bXAY1RzCF9WJfb51N6CIse9J/YMibs9Vm6kVfLfjkfhftRyQ0Qea15iBaUIfMc
         RZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D1AoMropzllZOsLvZSZ2ud+yeMiAjVWTDSbTeIIwkCM=;
        b=LkjYFxJtlOk35LjUYK8sSGpJr2K4mozm5/8FUHB+mocPvMwe/2ZfsLUqXCVWboK8Fl
         uMpcGTW8FhgAaeIYWSAkluth2nqjrZ1LAoWlUjfaQe2JyGhzt0q+23sL+HEnm50JKotT
         bUh6IO+UkWpR6bpRU8C0Mmv4iYh6+yIqWExRusVtcofZghtjO0IBVyTofamtzAPMJQV8
         vCuhId6NIQP5TXnh6ehMhsmNGbI8k3vzCQt3RSKiS9akqjDF3r9DKZAwwETTCGlrgU50
         C7rgBkbcs2Y2RN4YqTK8zO+eJ+WJ866xFq+88XcziQ0w/pWOssrQQzYAZKlYUBtMsu7c
         /Qrg==
X-Gm-Message-State: AOAM5320qu/vycYSnvcP2bCgHIUkd9TGRtCx+QsHFqVGCdi0luBHGHj/
        w5g/JelQCT2uyIdvb1/XZA8+dvIZYtQ=
X-Google-Smtp-Source: ABdhPJxyJrleDG1x+kSxu8OVsQh2dgi4unjf/4qUvV6vCAFQIfC9yF0zjzEslPgA6dLpW5Ox4auGhA==
X-Received: by 2002:a05:6402:49a:: with SMTP id k26mr19613482edv.279.1631623848739;
        Tue, 14 Sep 2021 05:50:48 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-237-250.77.3.pool.telefonica.de. [77.3.237.250])
        by smtp.gmail.com with ESMTPSA id r8sm5567865eds.39.2021.09.14.05.50.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:50:48 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 11/13] checkpolicy: error out on parsing too big integers
Date:   Tue, 14 Sep 2021 14:48:26 +0200
Message-Id: <20210914124828.19488-12-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914124828.19488-1-cgzones@googlemail.com>
References: <20210914124828.19488-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Error out instead of silently converting too big integer values in
policy sources.

    policy_parse.y:893:41: runtime error: implicit conversion from type 'unsigned long' of value 18446744073709551615 (64-bit, unsigned) to type 'unsigned int' changed the value to 4294967295 (32-bit, unsigned)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_parse.y | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 6098eb50..e969d973 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -890,10 +890,22 @@ filename		: FILENAME
 			{ yytext[strlen(yytext) - 1] = '\0'; if (insert_id(yytext + 1,0)) return -1; }
 			;
 number			: NUMBER 
-			{ $$ = strtoul(yytext,NULL,0); }
+			{ unsigned long x;
+			  errno = 0;
+			  x = strtoul(yytext, NULL, 0);
+			  if (errno || x > UINT_MAX)
+			      return -1;
+			  $$ = (unsigned int) x;
+			}
 			;
 number64		: NUMBER
-			{ $$ = strtoull(yytext,NULL,0); }
+			{ unsigned long long x;
+			  errno = 0;
+			  x = strtoull(yytext, NULL, 0);
+			  if (errno)
+			      return -1;
+			  $$ = (uint64_t) x;
+			}
 			;
 ipv6_addr		: IPV6_ADDR
 			{ if (insert_id(yytext,0)) return -1; }
-- 
2.33.0

