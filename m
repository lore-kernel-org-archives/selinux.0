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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD5FC43217
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5BEE60F58
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhINMwI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhINMwI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 08:52:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA10CC061574
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i6so19703987edu.1
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jbHyGrMlok17SW/pWY9FgQdMybgrvAFwKYR5B7F6db4=;
        b=QMD64R+31/coEtekDEor0Nincgb7o+ayPS42KqbcujGkUtmI0/uoIEdxiXGclE1enb
         sVZy+GLgaHkAHbRLaWEkSvjlRRgRhNLb67Vz4zF0Lt5upggejV1KajI1w8vCyAl4sE+o
         XIM+VZqHmDOq1VnyirHtuxd67UmskOLgTnSAHjPFZixs915AE2P7qkQ9ugJ03grL8f/6
         Uc2omXwbjUP+F4SpimB8zvb9IGn/G69w0AGlcyPqerp071DgD8Uk2YDVH8tdjA0hZ0cc
         1Sn2PZsA5cAvVZNycYeQM8k4lWJRcqIwE1XDDI6jCsTJZV2ynv4JjU+P/7cQuwD1liW1
         qqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jbHyGrMlok17SW/pWY9FgQdMybgrvAFwKYR5B7F6db4=;
        b=FoEDa/Ha5Z86ZVUB8vMxIELS3reS+of7JSNH2YTHJHLo46JN0HjI6WQ5tz+8QLyQrh
         asyo8QQuvLn58mlS3UyUDbQiJ7Y4x/Xq8+tb5MCXsV13dGJGjtVaXK/B7vBKkebNo42g
         HNKwyIZ0h7SRHCIMNYNTSK/YN9VvhxCp82QThAgYYjRtc4iw6QQu44Szhbq/KhohB7Lt
         FuV1ytnxP5QH33AWBgg7hSRe9Kie7mUmjFnJNH3m7LU0ALg2+1Sx7YmeLi2pyPv9UyJA
         F1xiGIiHZcDlWn4wxnJFk8jv3wcGWqc0ytAUHvHHMwncbPSRw8zRbxu/DiwypxccK6Zs
         3M5w==
X-Gm-Message-State: AOAM530ykp0Nmhr/J8Zznl5chdlMra9gHXODC1Yz+GgdMANXZ54DdBVl
        0qpv8+4dhKNusYCyFhE7/WRTvSKGQQg=
X-Google-Smtp-Source: ABdhPJy7+T2+RqH4S4WpL+EKA1RQLJbrfjNbDnyOKKamZ4fblt1iNaopg5KpxDOyUchcrbajoh8fEA==
X-Received: by 2002:aa7:da41:: with SMTP id w1mr17670680eds.344.1631623849310;
        Tue, 14 Sep 2021 05:50:49 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-237-250.77.3.pool.telefonica.de. [77.3.237.250])
        by smtp.gmail.com with ESMTPSA id r8sm5567865eds.39.2021.09.14.05.50.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:50:49 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 12/13] checkpolicy: print warning on source line overflow
Date:   Tue, 14 Sep 2021 14:48:27 +0200
Message-Id: <20210914124828.19488-13-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914124828.19488-1-cgzones@googlemail.com>
References: <20210914124828.19488-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In case the source line value overflows or has a too big value in the
source policy print a warning.

    policy_scan.l:273:19: runtime error: implicit conversion from type 'int' of value -2 (32-bit, signed) to type 'unsigned long' changed the value to 18446744073709551614 (64-bit, unsigned)
    policy_scan.l:66:20: runtime error: unsigned integer overflow: 18446744073709551615 + 1 cannot be represented in type 'unsigned long'

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_scan.l | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 4067268b..129a8a2a 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -59,12 +59,17 @@ alnum   [a-zA-Z0-9]
 hexval	[0-9A-Fa-f]
 
 %%
-\n.*				{ strncpy(linebuf[lno], yytext+1, 255);
-                                  linebuf[lno][254] = 0;
-                                  lno = 1 - lno; 
-                                  policydb_lineno++;
-				  source_lineno++;
-                                  yyless(1); }
+\n.*				{
+				  strncpy(linebuf[lno], yytext+1, 255);
+				  linebuf[lno][254] = 0;
+				  lno = 1 - lno;
+				  policydb_lineno++;
+				  if (source_lineno == ULONG_MAX)
+				      yywarn("source line number overflow");
+				  else
+				      source_lineno++;
+				  yyless(1);
+				}
 CLONE |
 clone				{ return(CLONE); }
 COMMON |
@@ -270,7 +275,13 @@ GLBLUB				{ return(GLBLUB); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
 {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
 #line[ ]1[ ]\"[^\n]*\"		{ set_source_file(yytext+9); }
-#line[ ]{digit}+	        { source_lineno = atoi(yytext+6)-1; }
+#line[ ]{digit}+	        {
+				  errno = 0;
+				  source_lineno = strtoul(yytext+6, NULL, 10) - 1;
+				  if (errno) {
+				    yywarn("source line number too big");
+				  }
+				}
 #[^\n]*                         { /* delete comments */ }
 [ \t\f]+			{ /* delete whitespace */ }
 "==" 				{ return(EQUALS); }
-- 
2.33.0

