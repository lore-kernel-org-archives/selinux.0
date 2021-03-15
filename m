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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC78C433DB
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 15:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E4664E10
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 15:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhCOPKL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Mar 2021 11:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbhCOPJm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Mar 2021 11:09:42 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE70C06174A
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 08:09:42 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id g8so7904574qvx.1
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C71WjT4ccZwBv1Wpf5ksm6lOf/rD/6ebhGcJsiG16YY=;
        b=BUhoPDcVWjXqpgrOelOlVhbc41J0NsSm3+5zZCF3TX7nBb07knp/Fpz+DDv1JZ+/wg
         5cGawtHOZoLePiQNbmEfAV4RuCrRA70ugLIQtMY9sfD5i40DxslTB40NMeRyXuyKy0uk
         slkRZ26lmBYurvDWnBEpaX/l1mWqkHXT4lEqrBRnRu/QTXOLZC3e53SKmuRfwrTFrm8B
         MBqIZYlzbyo4Xe2l+UwuhYv5GaMCkFZqQmjbvNtkiRQXQEq8NUXOxMUrObwMrYTh9RXt
         Z4PiWwcuMjj1tMWXxa3JtUwl7pDOdM1CerMZJh/jdkpop71RGWMysyefkazDjCRkZfXK
         GQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C71WjT4ccZwBv1Wpf5ksm6lOf/rD/6ebhGcJsiG16YY=;
        b=DMyF5QPke/v9Pf5fd5uhLHFSC64FhVby3iknb9v8USCs+EYOyWUk8aD6DwxtZJbLtK
         IYrHSpukb/mbAzVnwKtJtb6dCTUuz13yvzZlieCzMZ9qrOy5GijzAC8NizYHSYx3ywNH
         fXg8HRd+KlvZ/NnF664VTAF2MYh25Lb/DQTD3pg7dM0qqIALQWudKmPopQNssA9pD0Tf
         V3G37bz0228/OHUDf9N6usVPNumwng6r/LXWuoQ3QhIjXmj6b4y/XxqW+OAsLp4u1Zne
         S7FMPXB/YUS+8rMF9bBqKYwdfbJTWdw0keShcotGvaEKOgptiGbx48+Qz35A3tP+WIUD
         l+oQ==
X-Gm-Message-State: AOAM5339yN+E0PS8ojIAXkmPs8RbcOCYYJ6KuDUhqnaTx+2S7FNCFNgW
        5ll42zRBfiVlq4EmKXQEfZwfBWsmx5A=
X-Google-Smtp-Source: ABdhPJykTAn0iK/5kPb17AMHwNv2oTdEYdRyB5x7g5hVX82tD6ZOTEBHzoAl8L3nPQ3nepZWWBVaqw==
X-Received: by 2002:a0c:f7d1:: with SMTP id f17mr10997152qvo.38.1615820981539;
        Mon, 15 Mar 2021 08:09:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id m7sm11443045qti.33.2021.03.15.08.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 08:09:41 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2 v2] checkpolicy: Do not automatically upgrade when using "-b" flag
Date:   Mon, 15 Mar 2021 11:09:37 -0400
Message-Id: <20210315150938.320990-1-jwcart2@gmail.com>
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
v2 - Give the proper value when printing the compatibility range

 checkpolicy/checkpolicy.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 5841c5c4..acf1eac4 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -106,7 +106,7 @@ static int handle_unknown = SEPOL_DENY_UNKNOWN;
 static const char *txtfile = "policy.conf";
 static const char *binfile = "policy";
 
-unsigned int policyvers = POLICYDB_VERSION_MAX;
+unsigned int policyvers = 0;
 
 static __attribute__((__noreturn__)) void usage(const char *progname)
 {
@@ -515,7 +515,8 @@ int main(int argc, char **argv)
 	}
 
 	if (show_version) {
-		printf("%d (compatibility range %d-%d)\n", policyvers,
+		printf("%d (compatibility range %d-%d)\n",
+			   policyvers ? policyvers : POLICYDB_VERSION_MAX ,
 		       POLICYDB_VERSION_MAX, POLICYDB_VERSION_MIN);
 		exit(0);
 	}
@@ -588,6 +589,16 @@ int main(int argc, char **argv)
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
@@ -629,6 +640,8 @@ int main(int argc, char **argv)
 			policydb_destroy(policydbp);
 			policydbp = &policydb;
 		}
+
+		policydbp->policyvers = policyvers ? policyvers : POLICYDB_VERSION_MAX;
 	}
 
 	if (policydb_load_isids(&policydb, &sidtab))
@@ -654,8 +667,6 @@ int main(int argc, char **argv)
 			}
 		}
 
-		policydb.policyvers = policyvers;
-
 		if (!cil) {
 			if (!conf) {
 				policydb.policy_type = POLICY_KERN;
-- 
2.26.2

