Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C746BC001B0
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 21:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjHIVCK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjHIVCJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 17:02:09 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB441BCF
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 14:02:09 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-48730d2ce5cso133011e0c.0
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 14:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691614928; x=1692219728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9hE+hq7eZ/GHfAYd9SGdLnWJEJLTIknNSSDhaC8vaI=;
        b=LU5nOZwU8kf/8Tgd9BJCf7kI5SAonECtn7ZXdznMH8yecAtZgJbS35+i7DOxouzWBr
         JmtoF0bbjNRb+5XFncJ1rFh4gGyhqqU7UG1qzSZreP0Nh2bSR/dmKY0VHYfDRxg7o5u8
         NTd38mwcljKhw23H2lP5Gklji0R27c7Zm2EGGnNGLw+uL+i4Hy9yyKHBAeBc779EpMh6
         8DnGQO3jrbCZE3kODaQ12vXautxZNZ6ATAoMFiBYinU2djhS1HuATW//8X9J34dv+s2k
         8+hPFvuY0U32ZwOt8EeU1mswIy9CkGtt0cdzKN5yhbaW7ejYwhd5hHsXFAabh4SC1lYN
         DI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691614928; x=1692219728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9hE+hq7eZ/GHfAYd9SGdLnWJEJLTIknNSSDhaC8vaI=;
        b=hFA7L4ASOz64wsODEQR/cUsrZ44x3IUzHUKYcoCTGgo9x0QStECWUkTwQuQISsqRz4
         xGGLsqGXYeCCthnZXF8IcSIXDOzATWol9K5JT8gbF5UIR7m52v0jE7gZj4BWVAM3Pyf2
         8CDAzx9kijCqbNQtsuwfYpy9+pSmS+M0MawRf3MwHmfoaI4RXwmZCSIlqGKNY05Q/sT2
         SAmYnnZpECPZh3H+ckpb0H5mIYN6UJ9kAMZFl4FNj1gQLk340SjWHCdfBu+TheDw2roZ
         Kvwin7lQKVLoKRX81fc17KFGFHOUz7M8mCcdNFcEc4Hjagzbf8XhZ7xyG4WIbfOGboPl
         NueQ==
X-Gm-Message-State: AOJu0YxpwRzOxxClyFQ3ffpOFWIPIbHMGHc9psueqE/pY+OhDUL+AHlE
        c6sFzy1cyk6whsgFa2We0H3wVfJeBJ0=
X-Google-Smtp-Source: AGHT+IGf3KUWJIiV9pKtpZ9mjyO8bfqQN956T1L2nvLwpRcMcHoWC1BJcCjsKzylw4xhHnTiV2ULMA==
X-Received: by 2002:a67:db95:0:b0:447:4520:43b1 with SMTP id f21-20020a67db95000000b00447452043b1mr309616vsk.7.1691614927797;
        Wed, 09 Aug 2023 14:02:07 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a10b400b00766fbeb3e7csm4208287qkk.132.2023.08.09.14.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:02:07 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 7/9 v4] secilc/secil2tree: Add option to write CIL AST after post processing
Date:   Wed,  9 Aug 2023 17:01:55 -0400
Message-ID: <20230809210157.112275-8-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809210157.112275-1-jwcart2@gmail.com>
References: <20230809210157.112275-1-jwcart2@gmail.com>
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
index d04566dd..a9a14f87 100644
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
@@ -203,6 +206,9 @@ int main(int argc, char *argv[])
 	case WRITE_AST_PHASE_RESOLVE:
 		rc = cil_write_resolve_ast(file, db);
 		break;
+	case WRITE_AST_PHASE_POST:
+		rc = cil_write_post_ast(file, db);
+		break;
 	}
 
 	if (rc != SEPOL_OK) {
-- 
2.41.0

