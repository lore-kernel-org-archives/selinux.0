Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC8BC433EF
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbhLQSTe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbhLQSTd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:19:33 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8573AC06173E
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:33 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id eq6so3179361qvb.7
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPNzMcGdW3jTxa/cCbMlFEpv3jL3BV/8GbwgBDJUAt4=;
        b=lcQo6YKJbKiwaMKsIKqsAeimXuJKAVQp6CRy11rNEBgLbJAst5ZnPU9SPR4nyf9yUe
         KfKDxXLFxx0fiSxRkjCwPUREfVfY75J7YVOP45+FTu7FIRARfX7RNpjQwkGL1UDhZ+HA
         daOaOX1IkXND5bgwuYw2IZs/JDaZwizTUDVY5uXOAh3Vw94vX748RVnB5xFMdHMPFl9W
         aIJN3+SglPP835uq5fgnCRmhmjeTN1vGXsLg5Wa+LU0JHzYl/Ovj3OZEHurvFLn0Vzpz
         WCbzgdfvRXllfypxKuXjjSwasQL3VQHl+fDtFzyTlxhW2CKqGvwCpxNWUkm+HKHJzsZa
         anZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPNzMcGdW3jTxa/cCbMlFEpv3jL3BV/8GbwgBDJUAt4=;
        b=mx/OdNKCFsk3T2POawSLUV84fn3E8bbr2HVpg4bajfjX4GYWymNFvXOGSqQ93cf+iz
         ZzPUC7KYVeTmy+MuXSNBqnILM8FuKhOWpHrZ8sQu0W7aegTFAKAgxj10YZdPN1Lp2EIo
         MmvrKHtfMUcnW19jWEl2Oc8YgjS9cP63CC7mJfjDCOrKiBxG0CNMxfPKl8u92CLZO0Qm
         dSy0PZWssd1UKAwlTZOSAp1S3riJY0EDowG6x4Q8Q+ffAoo5ha+3fkllPYXD1ck6R9Vt
         XriFXOeKrqqz42MZEUz63vnC35dtI+Bzflxb+mnVuKn/klv48BFmo5e1UAKpG/0vpQbR
         XXdw==
X-Gm-Message-State: AOAM5316p+F8DkAKul57qEn6OOdVBL68b0CoSjhZ1WV+CAztE6Ciwb75
        hvH3RnmvT9lKWXgIAw9cgnI6sdhAwRs=
X-Google-Smtp-Source: ABdhPJx9MkCZMrKqvtYf1ZCW6svV+9S1mkECT82jUmsTas+TG0gvjmlIi+AhoPfLIufpn6IzpDu72g==
X-Received: by 2002:ad4:5be5:: with SMTP id k5mr1197650qvc.124.1639765172572;
        Fri, 17 Dec 2021 10:19:32 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o17sm7468094qtv.30.2021.12.17.10.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:19:32 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 14/16] libsepol: The src and tgt must be the same if neverallow uses self
Date:   Fri, 17 Dec 2021 13:19:11 -0500
Message-Id: <20211217181913.336360-15-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211217181913.336360-1-jwcart2@gmail.com>
References: <20211217181913.336360-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When checking for violations of neverallow rules, if the neverallow
uses self, then the src and tgt must be the same when checking
extended permissions and when reporting violations.

Example:
  allow attr attr : CLASS PERM;
  neverallow attr self : CLASS PERM;

If the types t1 and t2 have attribute attr, then the violations
that would be reported would be:
  allow t1 t1 : CLASS PERM;
  allow t1 t2 : CLASS PERM;
  allow t2 t1 : CLASS PERM;
  allow t2 t2 : CLASS PERM;
instead of:
  allow t1 t1 : CLASS PERM;
  allow t2 t2 : CLASS PERM;

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index b8fe8b21..ae3c18be 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -213,6 +213,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	ebitmap_t src_matches, tgt_matches, self_matches;
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
+	const int is_avrule_self = (avrule->flags & RULE_SELF) != 0;
 
 	if ((k->specified & AVTAB_ALLOWED) == 0)
 		return 0;
@@ -236,7 +237,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	if (rc < 0)
 		goto oom;
 
-	if (avrule->flags == RULE_SELF) {
+	if (is_avrule_self) {
 		rc = ebitmap_and(&self_matches, &src_matches, &p->attr_type_map[k->target_type - 1]);
 		if (rc < 0)
 			goto oom;
@@ -260,6 +261,8 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 
 		ebitmap_for_each_positive_bit(&src_matches, snode, i) {
 			ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
+				if (is_avrule_self && i != j)
+					continue;
 				if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
 					a->errors += report_assertion_extended_permissions(handle,p, avrule,
 											i, j, cp, perms, k, avtab);
@@ -368,6 +371,7 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 	ebitmap_t src_matches, tgt_matches, self_matches;
 	unsigned int i, j;
 	ebitmap_node_t *snode, *tnode;
+	const int is_avrule_self = (avrule->flags & RULE_SELF) != 0;
 	int rc;
 
 	ebitmap_init(&src_matches);
@@ -389,7 +393,7 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 	if (rc < 0)
 		goto oom;
 
-	if (avrule->flags == RULE_SELF) {
+	if (is_avrule_self) {
 		rc = ebitmap_and(&self_matches, &src_matches, &p->attr_type_map[k->target_type - 1]);
 		if (rc < 0)
 			goto oom;
@@ -408,6 +412,8 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 
 	ebitmap_for_each_positive_bit(&src_matches, snode, i) {
 		ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
+			if (is_avrule_self && i != j)
+				continue;
 			if (check_assertion_extended_permissions_avtab(avrule, avtab, i, j, k, p)) {
 				rc = 1;
 				goto exit;
-- 
2.31.1

