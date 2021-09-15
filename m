Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B52CC433F5
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 13:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F4760F11
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 13:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhIONNT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Sep 2021 09:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbhIONNS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Sep 2021 09:13:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6EBC061574
        for <selinux@vger.kernel.org>; Wed, 15 Sep 2021 06:11:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id o20so6040975ejd.7
        for <selinux@vger.kernel.org>; Wed, 15 Sep 2021 06:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Efz4C0s5yc05LUG8sfustSDCd7muvd4bWvgMXaaNNLQ=;
        b=UxNkmTP8w8yBF0E1WiRu/Xle/C/4CQ+F0MDFlar++yXg3uGlrCfRMteN5Zdt0sDqhD
         yxafljESsrLGr581pr5WfNYCEfYPLrXCSeRzPnAtapRgU+xF6j/lPcIrDd2Z3ER1YUoU
         3f364rNPWEvbMMnkil08/Z+u12YQh850sx2CHQPe6erGFkMpyaCezbdJcA+Jy06ryBFa
         aBnklb6OkbtWRVAMSFGsuBj+4EhZmFyt4DkIXd9L2aQVzoaEcSbRLkBeRlhaS8MzNzrz
         Q7BglilhUlZxTEvpjr10OdXkfhfybWJeQi+lXAvzwUKZo3OhQRHYuWb/tRsvTRUBFITW
         Shfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Efz4C0s5yc05LUG8sfustSDCd7muvd4bWvgMXaaNNLQ=;
        b=zUMfpu+fikMg1WeUCcB5sBjOBco74Z4o/rB1LuOcc0mopBn0H3r2+iigcvBuf2Uasa
         MFxU+YFrGdP/NHN3fEnPPxho1KRs5gzeuAUNwfiqpHrAUuyfSUTO/rcMOUNfbZFtez8x
         SIwhXstRmLZOoJfTngIoXYALlyMGoRNdBKlwkePEyUjhO5ltanRDDca4BHYIix0co4X4
         xb5i6u8YGkFL1OdBv4fhwm2aCYEO8TRZ/cDBYH8dNhYWAedvCWHrk5vFBQ8RhwHL5o8F
         Lmxq9dFRMgSaeWoT1ruZKt/Aq8PedKr+qlSL7vCVrkMMWOxPe4rFyr5VWX6Yex2o2cQ8
         ZesQ==
X-Gm-Message-State: AOAM530MM+u9IgcPzix47zCC17m1UE948A3JAjBpYYyXjVwgAMaTtjMR
        o1rTybFmlnYQcjHNkJsmWJNlZUPgHuw=
X-Google-Smtp-Source: ABdhPJyc1sVkug9nzYB//RyTaXIYru3FJm8+jbQR0El52KeEIwbXUcOyuqkWry+1SLyVW5mQCoSU8Q==
X-Received: by 2002:a17:906:3a57:: with SMTP id a23mr24733987ejf.469.1631711517875;
        Wed, 15 Sep 2021 06:11:57 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-239-251.95.112.pool.telefonica.de. [95.112.239.251])
        by smtp.gmail.com with ESMTPSA id m15sm6263328ejx.73.2021.09.15.06.11.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 06:11:57 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 11/13] checkpolicy: error out on parsing too big integers
Date:   Wed, 15 Sep 2021 15:11:53 +0200
Message-Id: <20210915131153.25416-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914124828.19488-12-cgzones@googlemail.com>
References: <20210914124828.19488-12-cgzones@googlemail.com>
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
v2:
  - only check usigned long against UINT_MAX, if ULONG_MAX is actually
    bigger


 checkpolicy/policy_parse.y | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 6098eb50..45f973ff 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -890,10 +890,26 @@ filename		: FILENAME
 			{ yytext[strlen(yytext) - 1] = '\0'; if (insert_id(yytext + 1,0)) return -1; }
 			;
 number			: NUMBER 
-			{ $$ = strtoul(yytext,NULL,0); }
+			{ unsigned long x;
+			  errno = 0;
+			  x = strtoul(yytext, NULL, 0);
+			  if (errno)
+			      return -1;
+#if ULONG_MAX > UINT_MAX
+			  if (x > UINT_MAX)
+			      return -1;
+#endif
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

