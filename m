Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEFAC28E88
	for <selinux@archiver.kernel.org>; Thu, 11 Mar 2021 15:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6E764FEF
	for <selinux@archiver.kernel.org>; Thu, 11 Mar 2021 15:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhCKPlX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbhCKPlJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Mar 2021 10:41:09 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96171C061760
        for <selinux@vger.kernel.org>; Thu, 11 Mar 2021 07:41:09 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id n79so21017219qke.3
        for <selinux@vger.kernel.org>; Thu, 11 Mar 2021 07:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZQv7xPvdbIKiE4its/B+2Zh9ap9UvZQS0ZJdtoRgqg=;
        b=g4UNAiOP4UEnI0AZcEsPztmqEHSSL/4BjZ34zDEXlEiLzWLiUGICAys7xYggm8GjL7
         Zc82zUzwnn9RF2VDTntji+mVetXgJ9soWH4QzMYTEvvwn1hMJzf8iU7H4yZUqAiZn4iD
         DMIflkofKCNdoHOt7X4R6VTrzfPDsVlxmjJSJx7HxV+EQvSyRnCs8sRuoyV+Ja32g4lV
         O0duQoiJxt4O1vIxs/lqmy34p0jNQ2rqK74sgoY0GWdmIvuv1Dpv6QHNpveDSMmf/3lh
         2qk7vpSqGwsf1JmBSViPxzm3V8qT9EcxPssd1qj7UlBL4MuHfyPTGZuBqGx314tQ5Uva
         c+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZQv7xPvdbIKiE4its/B+2Zh9ap9UvZQS0ZJdtoRgqg=;
        b=MYsW+9istlcsT30AtZWv+if274tL5F5GLq3QClxyd1U6/ObgQo3ETnaxhUep6kv/+I
         5983iQ54u+iusIODD0pJop00M+P/iJVQWzqekBvVozg9AR5UAODue83IFkDO8OSQtJ5M
         y7E3F57ECPBxVLnwHJZB5lzb+yfySnf45f5ahDRdcnjQESgEvhRsX7e3SdTmugioRMKM
         ykwIastxfcB2c8jfaulKSzovMmmae4/uo5zu2xE48gtwi/tGZsDCxM3Icfv5ThumzSci
         33GkOpwD6ZgpePHpJLmQZL0iSQJGeMCnhTJUzjCLjihZwi9C3WjfS/UvUajSy71N3aSM
         qnJw==
X-Gm-Message-State: AOAM532dU2bLx65Qx5YahSN5PDQLb15qsct6Eqsck9D5Ou/ufhVMycto
        BM8hEQPQunpEzBwh+F+B+GEvgJvlrkc=
X-Google-Smtp-Source: ABdhPJxKDkqeYvlD0j/5q2AP9AldqQYlqNvehSEgxj2lojgAvn10daALCwMs9EllmBbP/jR6qiLJQA==
X-Received: by 2002:a05:620a:294a:: with SMTP id n10mr8194071qkp.496.1615477268570;
        Thu, 11 Mar 2021 07:41:08 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d70sm2211152qkg.30.2021.03.11.07.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:41:08 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2] checkpolicy: Do not automatically upgrade when using "-b" flag
Date:   Thu, 11 Mar 2021 10:41:04 -0500
Message-Id: <20210311154105.195494-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When reading a binary policy, do not automatically change the version
to the max policy version supported by libsepol or, if specified, the
value given using the "-c" flag.

If the binary policy version is less than or equal to version 23
(POLICYDB_VERSION_PERMISSIVE) than do not automatically upgrade the
policy and if a policy version is specified by the "-c" flag, only set
the binary policy to the specified version if it is lower than the
current version.

If the binary policy version is greater than version 23 than it should
be set to the maximum version supported by libsepol or, if specified,
the value given by the "-c" flag.

The reason for this change is that policy versions 20
(POLICYDB_VERSION_AVTAB) to 23 have a more primitive support for type
attributes where the datums are not written out, but they exist in the
type_attr_map. This means that when the binary policy is read by
libsepol, there will be gaps in the type_val_to_struct and
p_type_val_to_name arrays and policy rules can refer to those gaps.
Certain libsepol functions like sepol_kernel_policydb_to_conf() and
sepol_kernel_policydb_to_cil() do not support this behavior and need
to be able to identify these policies. Policies before version 20 do not
support attributes at all and can be handled by all libsepol functions.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/checkpolicy.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 5841c5c4..e7b225b8 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -106,7 +106,7 @@ static int handle_unknown = SEPOL_DENY_UNKNOWN;
 static const char *txtfile = "policy.conf";
 static const char *binfile = "policy";
 
-unsigned int policyvers = POLICYDB_VERSION_MAX;
+unsigned int policyvers = 0;
 
 static __attribute__((__noreturn__)) void usage(const char *progname)
 {
@@ -588,6 +588,16 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 		}
+
+		if (policydbp->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
+			if (policyvers > policydbp->policyvers) {
+				fprintf(stderr, "Binary policies with version <= %u cannot be upgraded\n", POLICYDB_VERSION_PERMISSIVE);
+			} else if (policyvers) {
+				policydbp->policyvers = policyvers;
+			}
+		} else {
+			policydbp->policyvers = policyvers ? policyvers : POLICYDB_VERSION_MAX;
+		}
 	} else {
 		if (conf) {
 			fprintf(stderr, "Can only generate policy.conf from binary policy\n");
@@ -629,6 +639,8 @@ int main(int argc, char **argv)
 			policydb_destroy(policydbp);
 			policydbp = &policydb;
 		}
+
+		policydbp->policyvers = policyvers ? policyvers : POLICYDB_VERSION_MAX;
 	}
 
 	if (policydb_load_isids(&policydb, &sidtab))
@@ -654,8 +666,6 @@ int main(int argc, char **argv)
 			}
 		}
 
-		policydb.policyvers = policyvers;
-
 		if (!cil) {
 			if (!conf) {
 				policydb.policy_type = POLICY_KERN;
-- 
2.26.2

