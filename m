Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C72AC433F5
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 17:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154896120C
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 17:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241860AbhI1R5T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Sep 2021 13:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241520AbhI1R5S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Sep 2021 13:57:18 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CDBC06161C
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 10:55:30 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id e16so20586563qte.13
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWto906hkezj+i/O4v0YiPyx6aJsaGYSrEpNwZzO7uE=;
        b=hu+pS0eChMDzNH83dijiUmBKg4SdpjWpagNsxa62F1gdSIkmlqqojrvfs/EwHU8cB/
         CHio5HfgNNyWYGIR5wzf+MrjaX04HvkiYrZh4xPCoDLHUxXUgFxmCNJ9IUUURnUgFMk2
         b22869jqrUlC6F7Onk80RJM52tpTpUiaaaR/O0dNC23DZO2jcteg63bcDHRvtUG9IeLe
         KlSeSLOO2z0TD3/B9HGCdHWWqVm2+HaDtYODnj5SH6KjdcATkmjXThlJTOqsRnfZOBre
         G1jKeTFvhYvX7l7WDcpDRdlbTd2LwIL7tZ5wW89FgbKK/r0mkKQrpzH0mF8+CJk3IJGD
         fWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWto906hkezj+i/O4v0YiPyx6aJsaGYSrEpNwZzO7uE=;
        b=Vsf0BeY7iWeua/pwmTjdL7XljZI+VD5+dllLYCSFgi1Pt7h8S9+Y/um+uQZksruK0T
         wyJEUZGpzguDkKqTNfrPJHIBIaTXxdu9QFYw+zEqoWte+z2fiKziB63TSL/jKJoSq35+
         v4T+HdWFWnuBf4bCniPGD2NEQjYF2FEmwhEXeg1KdmEhOIUOtL0VWRkANTRGWelV3wRE
         sYg+TV6KxAV9/GY1ZkHIJE+5MJTYCMxyv71zN6A5agWpPNp5JSZDqT0MtKVFBYl/2HpR
         IjbcGiz54acXr0/GIwJHMt0Ub5l5WpXwCZDGfMWWdSAxb4aznpMPZoOCj1FKLIU7H56Y
         MTOA==
X-Gm-Message-State: AOAM532msZAVwXxaB/4g4Ke9om/7vbLUYsdgahthdb5hs2hjv2xOnUQf
        TpIoyenxuK0SOS2v/uAKMeVhsgmXXtQ=
X-Google-Smtp-Source: ABdhPJwVH+aDcBelzrHgtTwcR6eo0S6tVa6m2BjPw2ywpKHd5JeSjT6s7cHEka+C9/nQwJYBdgPfrQ==
X-Received: by 2002:ac8:408b:: with SMTP id p11mr7027700qtl.87.1632851729928;
        Tue, 28 Sep 2021 10:55:29 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id a3sm13679245qkh.67.2021.09.28.10.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 10:55:29 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Limit the amount of reporting for bounds failures
Date:   Tue, 28 Sep 2021 13:55:21 -0400
Message-Id: <20210928175521.79432-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Type bounds are checked when creating the CIL binary using libsepol
functions on the binary policy db. The bad rule is reported and, to
provide better error reporting, a search is made for matching rules
in the CIL policy. These matching rules as well as their parents are
written out with their locations to make it easier to find the rules
that violate the type bounds.

It is possible to craft CIL policies where there are many rules
that violate a bounds check each with many matching rules as well.
This can make the error messages very difficult to deal with. For
example, if there are 100 rules in the binary policy db that violate
a type bounds and each of these rules has 100 matches, then 10,000
matching rules along with their parents will be written out as part
of the error message.

Limit the error reporting to two rules for each type bounds violation
along with two matches for each of those rules.

This problem was found with the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_binary.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 4a80cb56..ec5f01e5 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4825,6 +4825,7 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
 			avtab_ptr_t cur;
 			struct cil_avrule target;
 			struct cil_tree_node *n1 = NULL;
+			int count_bad = 0;
 
 			*violation = CIL_TRUE;
 
@@ -4838,6 +4839,8 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
 			for (cur = bad; cur; cur = cur->next) {
 				struct cil_list_item *i2;
 				struct cil_list *matching;
+				int num_matching = 0;
+				int count_matching = 0;
 
 				rc = cil_avrule_from_sepol(pdb, cur, &target, type_value_to_cil, class_value_to_cil, perm_value_to_cil);
 				if (rc != SEPOL_OK) {
@@ -4855,6 +4858,9 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
 					bounds_destroy_bad(bad);
 					goto exit;
 				}
+				cil_list_for_each(i2, matching) {
+					num_matching++;
+				}
 				cil_list_for_each(i2, matching) {
 					struct cil_tree_node *n2 = i2->data;
 					struct cil_avrule *r2 = n2->data;
@@ -4865,9 +4871,19 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
 						__cil_print_parents("    ", n2);
 						__cil_print_rule("      ", "allow", r2);
 					}
+					count_matching++;
+					if (count_matching >= 2) {
+						cil_log(CIL_ERR, "    Only first 2 of %d matching rules shown\n", num_matching);
+						break;
+					}
 				}
 				cil_list_destroy(&matching, CIL_FALSE);
 				cil_list_destroy(&target.perms.classperms, CIL_TRUE);
+				count_bad++;
+				if (count_bad >= 2) {
+					cil_log(CIL_ERR, "  Only first 2 of %d bad rules shown\n", numbad);
+					break;
+				}
 			}
 			bounds_destroy_bad(bad);
 		}
-- 
2.31.1

