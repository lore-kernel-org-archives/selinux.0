Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10509C433F5
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF38B60F44
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241683AbhI1Ps6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241680AbhI1Ps5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Sep 2021 11:48:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BA6C06161C
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v18so49332204edc.11
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RI4Q6OQvX08XzA+CVSOJCOxHd/0AM0iHQwfhFwGuhZ0=;
        b=EXmZZlZvazNCHjCav1ISCmEcfZP9+16J2d7zuig+4wlzMnm0kprctIvSxt5000F0gR
         F0mhL90Y35tkHdZ/JqGcUr/x3Biv7V1ISOoU5usJTYMz7cWT6DRrV0uBqfJFDr2O5qMz
         DrObpEOvET3dfgCCvZHMRE4s50EWjRiNl1L3RHExTfC93bibS9ohqhVJ5+MP1nL5WcgI
         oG1a6cs1fxykPO6MbP7QziKWehjtqVRbVX2AxZ6ZelSXfzdxykj67EEJU5goYJQS7Dyf
         2m5bsHrErPcyVj1eeqNbsYYND/sTn2tEuYpqSYPygzGgzb7HH8W9DeBY6iVy0PAjEvvC
         CI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RI4Q6OQvX08XzA+CVSOJCOxHd/0AM0iHQwfhFwGuhZ0=;
        b=bXM1y5pPwITsbH9tWSNlTGmgoqlNaqIUD1IJja7GFiaBRyDtyU2yXiySpqCi0LYWaH
         rBiHMG04Us2vNP84gXe0gKSz33pVi5pPiEznlcNcUIfnMFPTPQEAA6GiXkG+Erx36dA6
         Mk+K0Lqq/mk6DjJZCrpH2F1ZImwuYtlOzBln3xw089QOQ8VxNAJFd+AXNZLiLaWoFWPy
         7Z9qz1S/YqhW5zI5NciWUd1z4cIVmdFX5nlOStX/UTvUcZqw5ryDxrdIuQPGZ1U3wJtA
         vVd6S4GghTBiRaGrJfWqhbVLXkRkRf0RSQ9hxrCKLbMHeADRhchM1dH6vInM85lCvbPC
         aJJg==
X-Gm-Message-State: AOAM5339Z2mNggVgJY2mVkRduvs6KjqGneM83e2CNxRhPMlC8oazycoz
        0I87b22qVvfubI8mL641IxvznIiNf1Q=
X-Google-Smtp-Source: ABdhPJzLU24Sc/2GjK+FUpCtcTPYu5ZfKjfS6x1MbXQLGFTllqGKSDwFHNGbbdj0Q6JXRI1q0O7DRg==
X-Received: by 2002:a05:6402:64e:: with SMTP id u14mr8602914edx.184.1632843983377;
        Tue, 28 Sep 2021 08:46:23 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-152-081.95.112.pool.telefonica.de. [95.112.152.81])
        by smtp.gmail.com with ESMTPSA id l18sm13403834edw.78.2021.09.28.08.46.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:46:23 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/9] libsepol: ebitmap: mark nodes of const ebitmaps const
Date:   Tue, 28 Sep 2021 17:46:12 +0200
Message-Id: <20210928154620.11181-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Mark pointers to nodes of const ebitmaps also const. C does not enforce
a transitive const-ness, but it clarifies the intent and improves
maintainability.

Follow-up of 390ec54d278a

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/ebitmap.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index 4e9acdf8..1de3816a 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -17,7 +17,8 @@
 
 int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitmap_t * e2)
 {
-	ebitmap_node_t *n1, *n2, *new, *prev;
+	const ebitmap_node_t *n1, *n2;
+	ebitmap_node_t *new, *prev;
 
 	ebitmap_init(dst);
 
@@ -154,7 +155,7 @@ int ebitmap_hamming_distance(const ebitmap_t * e1, const ebitmap_t * e2)
 
 int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2)
 {
-	ebitmap_node_t *n1, *n2;
+	const ebitmap_node_t *n1, *n2;
 
 	if (e1->highbit != e2->highbit)
 		return 0;
@@ -175,7 +176,8 @@ int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2)
 
 int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src)
 {
-	ebitmap_node_t *n, *new, *prev;
+	const ebitmap_node_t *n;
+	ebitmap_node_t *new, *prev;
 
 	ebitmap_init(dst);
 	n = src->node;
@@ -204,7 +206,7 @@ int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src)
 
 int ebitmap_contains(const ebitmap_t * e1, const ebitmap_t * e2)
 {
-	ebitmap_node_t *n1, *n2;
+	const ebitmap_node_t *n1, *n2;
 
 	if (e1->highbit < e2->highbit)
 		return 0;
@@ -231,8 +233,8 @@ int ebitmap_contains(const ebitmap_t * e1, const ebitmap_t * e2)
 
 int ebitmap_match_any(const ebitmap_t *e1, const ebitmap_t *e2)
 {
-	ebitmap_node_t *n1 = e1->node;
-	ebitmap_node_t *n2 = e2->node;
+	const ebitmap_node_t *n1 = e1->node;
+	const ebitmap_node_t *n2 = e2->node;
 
 	while (n1 && n2) {
 		if (n1->startbit < n2->startbit) {
@@ -253,7 +255,7 @@ int ebitmap_match_any(const ebitmap_t *e1, const ebitmap_t *e2)
 
 int ebitmap_get_bit(const ebitmap_t * e, unsigned int bit)
 {
-	ebitmap_node_t *n;
+	const ebitmap_node_t *n;
 
 	if (e->highbit < bit)
 		return 0;
-- 
2.33.0

