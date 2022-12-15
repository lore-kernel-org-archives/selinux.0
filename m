Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5100DC4332F
	for <selinux@archiver.kernel.org>; Thu, 15 Dec 2022 21:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiLOVeq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Dec 2022 16:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLOVeo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Dec 2022 16:34:44 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69B75C0E9
        for <selinux@vger.kernel.org>; Thu, 15 Dec 2022 13:34:43 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id h10so348440qvq.7
        for <selinux@vger.kernel.org>; Thu, 15 Dec 2022 13:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJuL+o9JOU3i4OEWVwLAgLjL1OEYhTM0g+1enfG7FEA=;
        b=LDd5kqCqw0+AP6t4+1TsdJ/JCWvcgsLAIrRS4k3awUPA+J/CXd2+OBeh8iey7CkzGL
         cWKqPWHgx2m931oM9TsFJraS2I68u7RfZaglSKd78z0BrmRJgksQIJXNWI3JRkN4Rd+f
         qtYwAWBY98eqMT49QePgGytdE8/qAppyFLkFl5TZiN3p/JRdEp4MyyKQa/6AxsBlK4jz
         KHetasB2IGOwI2WE1En68vPUlKKhqahuQOExpYKUiv7IlsPf1lL4W3H2e7aZCX57bJdO
         IZhX40SuMCnKx9YUEx/zfQPbdCyP+KjzCg1Ylr+HtabGCOH4ByiKT4JY4T2J88mXOF8L
         gtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJuL+o9JOU3i4OEWVwLAgLjL1OEYhTM0g+1enfG7FEA=;
        b=w5OPRwEizDSqrpTC3LhBa1xfG7BB4UsA7YwIXNZ/S5UMfvOi9DIP8L1xrC42NcbGYE
         F9x7GVJ/WoNQaL8HVEOKA52NNRL3e2+1N9AbvBFHdj07kXC7ff4kO/n1C2q/CrQcfw2M
         eCJeHcMf2d6nw+l5wuc//K/PznS9fPdV55NKeEwrznBGMQhAVdGnUaiKAQD9QdSBv8BT
         21JUvwjkwoJAGdsqiup8+sIVzhy5abDDBYu7Qs/ECA7GRC04fi8CdhJne7tUAFzlBHNr
         r9hrXBPcupdWvNu3NeVjTsiVGky1AOqCMQ61Bv66NUm1GGHFuIYB30hwOj+xLVMzT1Yb
         JeTw==
X-Gm-Message-State: ANoB5plWrIFurPweeYGFeE/zxlS7GKb428OmTgKqPCwu1ARbklYCgBd3
        gHr9thUwVYMBOzI3/E5L8hnTI0EV7KU=
X-Google-Smtp-Source: AA0mqf6ZSH6WAulBqm4LM/K79eX0PiLleONDtR132WU8EXh8KJgYQSPE5zuerzSm81bWWRQa5o08+Q==
X-Received: by 2002:ad4:5103:0:b0:4c7:9386:bb2d with SMTP id g3-20020ad45103000000b004c79386bb2dmr6292022qvp.14.1671140082711;
        Thu, 15 Dec 2022 13:34:42 -0800 (PST)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a424a00b006a6ebde4799sm21066qko.90.2022.12.15.13.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 13:34:42 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 7/9] secilc/secil2tree: Add option to write CIL AST after post processing
Date:   Thu, 15 Dec 2022 16:34:27 -0500
Message-Id: <20221215213429.998948-8-jwcart2@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215213429.998948-1-jwcart2@gmail.com>
References: <20221215213429.998948-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This will show the resulting CIL AST after deny rules have been
processed.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/secil2tree.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/secilc/secil2tree.c b/secilc/secil2tree.c
index e5cdf6bd..ff0fc92b 100644
--- a/secilc/secil2tree.c
+++ b/secilc/secil2tree.c
@@ -45,6 +45,7 @@ enum write_ast_phase {
 	WRITE_AST_PHASE_PARSE = 0,
 	WRITE_AST_PHASE_BUILD,
 	WRITE_AST_PHASE_RESOLVE,
+	WRITE_AST_PHASE_POST,
 };
 
 static __attribute__((__noreturn__)) void usage(const char *prog)
@@ -58,7 +59,7 @@ static __attribute__((__noreturn__)) void usage(const char *prog)
 	printf("                           Blocks, blockinherits, blockabstracts, and\n");
 	printf("                           in-statements will not be allowed.\n");
 	printf("  -A, --ast-phase=<phase>  write AST of phase <phase>. Phase must be parse, \n");
-	printf("                           build, or resolve. (default: resolve)\n");
+	printf("                           build, resolve, or post. (default: resolve)\n");
 	printf("  -v, --verbose            increment verbosity level\n");
 	printf("  -h, --help               display usage information\n");
 	exit(1);
@@ -115,6 +116,8 @@ int main(int argc, char *argv[])
 					write_ast = WRITE_AST_PHASE_BUILD;
 				} else if (!strcasecmp(optarg, "resolve")) {
 					write_ast = WRITE_AST_PHASE_RESOLVE;
+				} else if (!strcasecmp(optarg, "post")) {
+					write_ast = WRITE_AST_PHASE_POST;
 				} else {
 					fprintf(stderr, "Invalid AST phase: %s\n", optarg);
 					usage(argv[0]);
@@ -197,6 +200,9 @@ int main(int argc, char *argv[])
 	case WRITE_AST_PHASE_RESOLVE:
 		rc = cil_write_resolve_ast(file, db);
 		break;
+	case WRITE_AST_PHASE_POST:
+		rc = cil_write_post_ast(file, db);
+		break;
 	}
 
 	if (rc != SEPOL_OK) {
-- 
2.38.1

