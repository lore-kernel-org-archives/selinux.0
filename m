Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326D7C64EC4
	for <selinux@archiver.kernel.org>; Thu,  9 Mar 2023 21:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjCIVvg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Mar 2023 16:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjCIVv1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Mar 2023 16:51:27 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FC410287C
        for <selinux@vger.kernel.org>; Thu,  9 Mar 2023 13:51:24 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id nv15so2434536qvb.7
        for <selinux@vger.kernel.org>; Thu, 09 Mar 2023 13:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678398684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlwOJT4ewE+i3ATuKiigpdoBEhvTE/OzvRm1XYEV538=;
        b=ModFzkNvdCwXdbz83skZlCsGZJPLYjbksFe50V0/e8qtQc3r7ItOpVIhCHHwAElJ4f
         Ye/FTL4GrHkW73v4j4Uid83C9nK8/LROmdmOpCIlIKS31h1wn6lWh1ILf4HQLuwqd3P+
         ZdFO0Y4ypqRUyT3kc5UX9S/UBoXunGAyhv2frmca/4hoUUW58MSfL04VvbxuPIGUyqpd
         /+1ClxfVUCJ5rwXIm6brTDpGgzG0AQDVp41Fs7w+gtYp3jOWzTteKzxda1OXysbUoTHP
         vKiBgaMj3qPIwrRvTa8qKNl/n4bFHMsYbl9HZ1W0uUSRu9MdtyxgtMaNBX1LICtrPzTr
         YfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678398684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlwOJT4ewE+i3ATuKiigpdoBEhvTE/OzvRm1XYEV538=;
        b=F89NdsAWm/dL5KN6hem5RjJ8JGPc5o/xKOi6LGLuiu7hGHK5+rYqDrc67u6BS4jz6E
         vkA72ngOO5DuNkUrQ5Pn2ImcHq/85sR+rSCOTdhQNuRfp1eKWvXJwPvd7brWZH+IhHzq
         RynN0TKX3rxIdwDJgZnhig/C7leKr9Eg8RAUKZ0DMafOs46nhkW9hOmjvzxwmiR+jZvr
         zV0xX2htd++sryjLmhFqi5NFwm+wLjAXsjezXjU6/90ZwoLwg/PGhXR0Ksm089omrN82
         N4U8wSL4JOKuJ/4woBVFZT0XMJEOnli08pS/TsDb1FJRtXN4Ov5n9ELGb5ZCC6xBDVpS
         65CQ==
X-Gm-Message-State: AO0yUKX3SCI7MvbBr7K8CocdTYzH+xWT6E/5skP8qGpx+oSJyhvQV4fE
        OyLKpocKUXnet82Yyju3jGj5GkmxRuo=
X-Google-Smtp-Source: AK7set/QauESMdffHXgG2/rvu4h2fUuzn4QNRGLZyJbVsattMMPgTpQSgdV30WIVKbEqbXwPRzFAGA==
X-Received: by 2002:a05:6214:1c4f:b0:56e:b4e0:1bf3 with SMTP id if15-20020a0562141c4f00b0056eb4e01bf3mr43487776qvb.18.1678398683794;
        Thu, 09 Mar 2023 13:51:23 -0800 (PST)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e011000000b007422fa6376bsm25731qkk.77.2023.03.09.13.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:51:23 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 7/9 v2] secilc/secil2tree: Add option to write CIL AST after post processing
Date:   Thu,  9 Mar 2023 16:51:12 -0500
Message-Id: <20230309215114.357831-8-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309215114.357831-1-jwcart2@gmail.com>
References: <20230309215114.357831-1-jwcart2@gmail.com>
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
2.39.2

