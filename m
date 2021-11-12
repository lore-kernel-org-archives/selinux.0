Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942DDC433F5
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7352360296
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhKLPo7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhKLPo7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Nov 2021 10:44:59 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A79C061766
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:08 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o8so39195843edc.3
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n2sA4lrtpEVOts4ZjNUrk5h9lD/gYE8zciz/w6NEhGY=;
        b=pPIOq+MynqroY6lP/T6I6iT3E5CbD1RKkEe253U2l82j2M1fLMyHZnwunRbbaWbDI3
         mtCM9Z2CIiFvdOeSIZqUI232AKTV2GK/XoQbc8Y54HmMdXZJmrgE3BI76LHgzmlvk5mm
         ehCpEL+CAMlVWG6H6dkWdcYmgOUSRxw5AJRwXUu/34js9bFmWv5vpzmIHAzSp8ANSh3U
         LEE82OmY8E5ZNOoVwamRjMnD8j2Td9JvR1r74CG+lQoFN7u0vjdz4EWTIizgCh1t3pwi
         nPQ1jg+h80yfKdpvPpU8MEfKgIzhrQRSqgP//DNO3NYs/SsQlUf3H5JEvTdtX3mvlQ/Y
         sy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n2sA4lrtpEVOts4ZjNUrk5h9lD/gYE8zciz/w6NEhGY=;
        b=b6zeaTeqCuIdaL32nYwtDA0K33SIKkjE0uM/Og6/CT9+cFLuBXCy//RKxKbehzKHc/
         zlq4gD/gLkudS0Sqf96RhK8P2xgbeIB3GkigC5hECnYaC4FEuBxlIcJiQtfqYcsDgRxw
         4KYG4uV7RZFm1o0QDFFoN0/iNoy12w5y1HE5WcVoeKnF7u0jhHy6wDpROKjVPpY9EuNB
         sw6s6AI9QYYd+5UAbS8iFfJjjH84RQlH103qrHpuWQitRGGJpPYIrdSGw9iK1VEWmdRr
         idKkxu8YR141E+bAlxJq9nGx+evqzdIoUpMG0yV5JBxv1UgQke2ypLnjw3tHRm8oRxgk
         YSUQ==
X-Gm-Message-State: AOAM5331C/Vz56+HVEOgeO7OK1oPZ29rDEiEss2twLbPvMMRl9IWldui
        ZgKRV7U8N7YqvTGFfg152djHGnu9woE=
X-Google-Smtp-Source: ABdhPJzea5PmBGoe/vKsnNg9NPM+g7ozpDUqdqEv8HhQpE3/OUK5eDujKu7VqWcLBstgaJ8OmZ3jdg==
X-Received: by 2002:a17:907:6da2:: with SMTP id sb34mr20915060ejc.509.1636731726690;
        Fri, 12 Nov 2021 07:42:06 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-195-130.77.0.pool.telefonica.de. [77.0.195.130])
        by smtp.gmail.com with ESMTPSA id m9sm2628914eje.102.2021.11.12.07.42.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:42:06 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 01/12] checkpolicy: use correct unsigned format specifiers
Date:   Fri, 12 Nov 2021 16:41:50 +0100
Message-Id: <20211112154201.78217-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The two variables policydb_lineno and source_lineno are both of the type
unsigned long; use the appropriate format specifier.

Found by Cppcheck

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_scan.l | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 129a8a2a..ef9f1899 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -308,11 +308,11 @@ GLBLUB				{ return(GLBLUB); }
 int yyerror(const char *msg)
 {
 	if (source_file[0])
-		fprintf(stderr, "%s:%ld:",
+		fprintf(stderr, "%s:%lu:",
 			source_file, source_lineno);
 	else
 		fprintf(stderr, "(unknown source)::");
-	fprintf(stderr, "ERROR '%s' at token '%s' on line %ld:\n%s\n%s\n",
+	fprintf(stderr, "ERROR '%s' at token '%s' on line %lu:\n%s\n%s\n",
 			msg,
 			yytext,
 			policydb_lineno,
@@ -327,11 +327,11 @@ int yywarn(const char *msg)
 		return yyerror(msg);
 
 	if (source_file[0])
-		fprintf(stderr, "%s:%ld:",
+		fprintf(stderr, "%s:%lu:",
 			source_file, source_lineno);
 	else
 		fprintf(stderr, "(unknown source)::");
-	fprintf(stderr, "WARNING '%s' at token '%s' on line %ld:\n%s\n%s\n",
+	fprintf(stderr, "WARNING '%s' at token '%s' on line %lu:\n%s\n%s\n",
 			msg,
 			yytext,
 			policydb_lineno,
-- 
2.33.1

