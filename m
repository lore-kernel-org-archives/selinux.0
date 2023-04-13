Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD1FC77B71
	for <selinux@archiver.kernel.org>; Thu, 13 Apr 2023 19:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDMTe5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Apr 2023 15:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjDMTe4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Apr 2023 15:34:56 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE8C6592
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 12:34:55 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54c0c86a436so422113547b3.6
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 12:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681414494; x=1684006494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlwOJT4ewE+i3ATuKiigpdoBEhvTE/OzvRm1XYEV538=;
        b=Wk+GRrpGyfb5hPyr1mRc/BE2iQ9rbk+yluTQ55ybFA0P+mV5ys+90yecvWqw8hz8FC
         81blrzJVc0dCD+0PZSFwIyqIqroSw2KT4yYovwCTbwVQ2bV56gpJ5KcfCil9Bbby+CJw
         UxxcxEr2ZEG8yWjJaDOOPbNbGJt6DAUkYXExrQe/TZUtaEM8ycmqdnmlZVnXojEsEtsp
         b/Cv1z43517AbrhEV3e5s4/hYq2OFcmTIPuB0j19KzX4MSTgCgqihDV99ACRX1mQ2vfx
         DScXYhThNkyYxPGZtniYOJA9iSsCbC9A4s7hkrjLO/wiVFjRu3O8RZIbiCXPAvXx+WDK
         k/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681414494; x=1684006494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlwOJT4ewE+i3ATuKiigpdoBEhvTE/OzvRm1XYEV538=;
        b=H7VQq4E4gmXHSM7/Bi5MJ6vZ7W6pfz/zfI9gWKgM6hop/q8MtNPRNbVLGjCocCC9kC
         PoOr9SkanZ5zYX0w+wibyiXNo1aTZ+7FMRggYibjw04IADpe++bYK6MQGaDRSYDys3p/
         5cUJy/JZoBHbJB72vir01pD/qzJsXoVQOGU9RuqV+fpSUQmJ/R9Zchy1GJ19FA+9KSvd
         b5miWQCF2zIIH3ASdlcp+HAX85xyrDGQJyjWBuKKKy0n744aZy7sLc6wfCFY7pU1a2Pe
         OMniyjQ0rYhAYBfiBNqwihP1vwRrFGrandHa5cZs0EA0uI27+n7xWVkUWQD+YUehxk1g
         I7fg==
X-Gm-Message-State: AAQBX9d3erJqjL0qG3dPBI9Gp8iAn4He9TgmKxqGxYyqSMiYXgHdm9YY
        boZ+wG0g9B0S8nGK2lyAOxRlvpOkcYE=
X-Google-Smtp-Source: AKy350Zs74c4Zh6rqhsUuLcQNkVuCqfbXrm46NTf+wvWSs732KkciEfvPR+1Cpuz9M791ITfBw4mmg==
X-Received: by 2002:a81:83cd:0:b0:54f:9e41:df5a with SMTP id t196-20020a8183cd000000b0054f9e41df5amr2933049ywf.15.1681414494509;
        Thu, 13 Apr 2023 12:34:54 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id 21-20020a811615000000b0054c0f46b24bsm691350yww.5.2023.04.13.12.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 12:34:54 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 7/9 v3] secilc/secil2tree: Add option to write CIL AST after post processing
Date:   Thu, 13 Apr 2023 15:34:43 -0400
Message-Id: <20230413193445.588395-8-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413193445.588395-1-jwcart2@gmail.com>
References: <20230413193445.588395-1-jwcart2@gmail.com>
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

