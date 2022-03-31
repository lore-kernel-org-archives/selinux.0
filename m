Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F19C433EF
	for <selinux@archiver.kernel.org>; Thu, 31 Mar 2022 14:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiCaOsM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Mar 2022 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbiCaOsF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Mar 2022 10:48:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD86321FC45
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:46:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i16so1750514ejk.12
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FEPnOf9De8ppQQwLvr5UvBjlkgixIMafU28hjboCD8Y=;
        b=AEd01OG4+ReC4v1H75k1IUD0q0HgZ9TIZyKN0VClvVqXenNneBNZjetNQm9JTUI9lG
         B2QgKUjeLlYCHm20xzqWEk6wEQ+nkSxS5oVxsmcloHsAik2/pHmyZOqNYenaXRxRoRi5
         RI6193s1pyFHIcikLWR73FuYFlA7fNCyacBnGT01p4phEeJHjgmT6K2LGNBFi7+tJS0/
         /tkAn+7lRtKRUw/W/zd599NhIrDf3HiNW/ZQl+wQnFM1L+SWiDgSQRlg5xfUTTymF7lo
         j3sXvLKapKhxc3tuU+VGJc0zddCmNHg7UKQQZ+G2qqFCLVIQ/4pC6WggFy7w5B+KOZXK
         QeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FEPnOf9De8ppQQwLvr5UvBjlkgixIMafU28hjboCD8Y=;
        b=KAzr+FyMbeMJx5CcUv6HYruXW3/2nVu57uCCxVAMpYsDeZd88rtF3/H6JCTuMyMV3a
         IhULGCLiu9NMv6uwWNqWD3J9exO+fIAzvTKTnCfdZ8HZoioZPsVDVLJkTmKJNC9pGJE5
         kMfvtQe2TpzJEPOYdE8cF5UfVCWvl5zf4ptLSTRMYdKZ9IpE4htpK0pST+4z4SF6J9IB
         oTnRycv+GaNkfXgFmf11aPS+SY1WxnFGhkiNtwFoRRzh2QRhvd5LGwo3KTYqoyFyNe2E
         0/iU0y2X6G5tJRnQa8sACQOJ7Lf5bQ7YPCt3XNLdhSqqkl0cZGkQvX01Mf4LCfFxhSmv
         vNaA==
X-Gm-Message-State: AOAM530du+hT1HXrfB2OCDNXlyitBg5HzQj72iZwnFxFtvr6qR4eYv8j
        XJAXZqF+qYSsID/0qmnuAsyEvA7+M9g=
X-Google-Smtp-Source: ABdhPJzJtC1Sj/EX3BD9vcPRWEaj3Bz/NuK1tsA+0AZmfB4nqW42d6dYrwKIQcVJfqlzp8oIEFiDZA==
X-Received: by 2002:a17:907:2cc6:b0:6e0:1ae5:d762 with SMTP id hg6-20020a1709072cc600b006e01ae5d762mr5414690ejc.291.1648737976267;
        Thu, 31 Mar 2022 07:46:16 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-006-065-043.77.6.pool.telefonica.de. [77.6.65.43])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090672cd00b006df86017b61sm9593824ejl.105.2022.03.31.07.46.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 07:46:15 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libsepol: mark immutable mls and context parameter const
Date:   Thu, 31 Mar 2022 16:46:09 +0200
Message-Id: <20220331144610.31056-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Make it more obvious which parameters are read-only and not being
modified and allow callers to pass const pointers.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/context.h   | 14 +++++++-------
 libsepol/include/sepol/policydb/mls_types.h | 12 ++++++------
 libsepol/src/mls.c                          | 17 +++++++++--------
 libsepol/src/mls.h                          |  4 ++--
 4 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/libsepol/include/sepol/policydb/context.h b/libsepol/include/sepol/policydb/context.h
index 37cdc591..025c894f 100644
--- a/libsepol/include/sepol/policydb/context.h
+++ b/libsepol/include/sepol/policydb/context.h
@@ -43,7 +43,7 @@ static inline void mls_context_init(context_struct_t * c)
 }
 
 static inline int mls_context_cpy(context_struct_t * dst,
-				  context_struct_t * src)
+				  const context_struct_t * src)
 {
 
 	if (mls_range_cpy(&dst->range, &src->range) < 0)
@@ -55,7 +55,7 @@ static inline int mls_context_cpy(context_struct_t * dst,
 /*
  * Sets both levels in the MLS range of 'dst' to the low level of 'src'.
  */
-static inline int mls_context_cpy_low(context_struct_t *dst, context_struct_t *src)
+static inline int mls_context_cpy_low(context_struct_t *dst, const context_struct_t *src)
 {
 	int rc;
 
@@ -75,7 +75,7 @@ out:
 /*
  * Sets both levels in the MLS range of 'dst' to the high level of 'src'.
  */
-static inline int mls_context_cpy_high(context_struct_t *dst, context_struct_t *src)
+static inline int mls_context_cpy_high(context_struct_t *dst, const context_struct_t *src)
 {
 	int rc;
 
@@ -92,12 +92,12 @@ out:
 	return rc;
 }
 
-static inline int mls_context_glblub(context_struct_t *dst, context_struct_t *c1, context_struct_t *c2)
+static inline int mls_context_glblub(context_struct_t *dst, const context_struct_t *c1, const context_struct_t *c2)
 {
 	return mls_range_glblub(&dst->range, &c1->range, &c2->range);
 }
 
-static inline int mls_context_cmp(context_struct_t * c1, context_struct_t * c2)
+static inline int mls_context_cmp(const context_struct_t * c1, const context_struct_t * c2)
 {
 	return (mls_level_eq(&c1->range.level[0], &c2->range.level[0]) &&
 		mls_level_eq(&c1->range.level[1], &c2->range.level[1]));
@@ -118,7 +118,7 @@ static inline void context_init(context_struct_t * c)
 	memset(c, 0, sizeof(*c));
 }
 
-static inline int context_cpy(context_struct_t * dst, context_struct_t * src)
+static inline int context_cpy(context_struct_t * dst, const context_struct_t * src)
 {
 	dst->user = src->user;
 	dst->role = src->role;
@@ -135,7 +135,7 @@ static inline void context_destroy(context_struct_t * c)
 	mls_context_destroy(c);
 }
 
-static inline int context_cmp(context_struct_t * c1, context_struct_t * c2)
+static inline int context_cmp(const context_struct_t * c1, const context_struct_t * c2)
 {
 	return ((c1->user == c2->user) &&
 		(c1->role == c2->role) &&
diff --git a/libsepol/include/sepol/policydb/mls_types.h b/libsepol/include/sepol/policydb/mls_types.h
index 0ba6d9de..12990c69 100644
--- a/libsepol/include/sepol/policydb/mls_types.h
+++ b/libsepol/include/sepol/policydb/mls_types.h
@@ -50,7 +50,7 @@ typedef struct mls_range {
 	mls_level_t level[2];	/* low == level[0], high == level[1] */
 } mls_range_t;
 
-static inline int mls_range_glblub(struct mls_range *dst, struct mls_range *r1, struct mls_range *r2)
+static inline int mls_range_glblub(struct mls_range *dst, const struct mls_range *r1, const struct mls_range *r2)
 {
 	if (r1->level[1].sens < r2->level[0].sens || r2->level[1].sens < r1->level[0].sens) {
 		/* These ranges have no common sensitivities */
@@ -74,7 +74,7 @@ static inline int mls_range_glblub(struct mls_range *dst, struct mls_range *r1,
 }
 
 
-static inline int mls_level_cpy(struct mls_level *dst, struct mls_level *src)
+static inline int mls_level_cpy(struct mls_level *dst, const struct mls_level *src)
 {
 
 	dst->sens = src->sens;
@@ -119,7 +119,7 @@ static inline int mls_level_dom(const struct mls_level *l1, const struct mls_lev
 (mls_level_dom(&(r2).level[0], &(r1).level[0]) && \
  mls_level_dom(&(r1).level[1], &(r2).level[1]))
 
-static inline int mls_range_cpy(mls_range_t * dst, mls_range_t * src)
+static inline int mls_range_cpy(mls_range_t * dst, const mls_range_t * src)
 {
 
 	if (mls_level_cpy(&dst->level[0], &src->level[0]) < 0)
@@ -149,7 +149,7 @@ static inline void mls_range_destroy(struct mls_range *r)
 	mls_level_destroy(&r->level[1]);
 }
 
-static inline int mls_range_eq(struct mls_range *r1, struct mls_range *r2)
+static inline int mls_range_eq(const struct mls_range *r1, const struct mls_range *r2)
 {
 	return (mls_level_eq(&r1->level[0], &r2->level[0]) &&
 	        mls_level_eq(&r1->level[1], &r2->level[1]));
@@ -174,10 +174,10 @@ extern void mls_semantic_cat_init(mls_semantic_cat_t *c);
 extern void mls_semantic_cat_destroy(mls_semantic_cat_t *c);
 extern void mls_semantic_level_init(mls_semantic_level_t *l);
 extern void mls_semantic_level_destroy(mls_semantic_level_t *l);
-extern int mls_semantic_level_cpy(mls_semantic_level_t *dst, mls_semantic_level_t *src);
+extern int mls_semantic_level_cpy(mls_semantic_level_t *dst, const mls_semantic_level_t *src);
 extern void mls_semantic_range_init(mls_semantic_range_t *r);
 extern void mls_semantic_range_destroy(mls_semantic_range_t *r);
-extern int mls_semantic_range_cpy(mls_semantic_range_t *dst, mls_semantic_range_t *src);
+extern int mls_semantic_range_cpy(mls_semantic_range_t *dst, const mls_semantic_range_t *src);
 
 #ifdef __cplusplus
 }
diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
index 366a1114..4ffe9814 100644
--- a/libsepol/src/mls.c
+++ b/libsepol/src/mls.c
@@ -451,7 +451,7 @@ int mls_context_to_sid(const policydb_t * policydb,
  * Copies the MLS range from `src' into `dst'.
  */
 static inline int mls_copy_context(context_struct_t * dst,
-				   context_struct_t * src)
+				   const context_struct_t * src)
 {
 	int l, rc = 0;
 
@@ -471,7 +471,7 @@ static inline int mls_copy_context(context_struct_t * dst,
  * Copies the effective MLS range from `src' into `dst'.
  */
 static inline int mls_scopy_context(context_struct_t * dst,
-				    context_struct_t * src)
+				    const context_struct_t * src)
 {
 	int l, rc = 0;
 
@@ -490,7 +490,7 @@ static inline int mls_scopy_context(context_struct_t * dst,
 /*
  * Copies the MLS range `range' into `context'.
  */
-static inline int mls_range_set(context_struct_t * context, mls_range_t * range)
+static inline int mls_range_set(context_struct_t * context, const mls_range_t * range)
 {
 	int l, rc = 0;
 
@@ -601,8 +601,8 @@ int mls_convert_context(policydb_t * oldp,
 }
 
 int mls_compute_sid(policydb_t * policydb,
-		    context_struct_t * scontext,
-		    context_struct_t * tcontext,
+		    const context_struct_t * scontext,
+		    const context_struct_t * tcontext,
 		    sepol_security_class_t tclass,
 		    uint32_t specified, context_struct_t * newcontext)
 {
@@ -755,9 +755,10 @@ void mls_semantic_level_destroy(mls_semantic_level_t * l)
 }
 
 int mls_semantic_level_cpy(mls_semantic_level_t * dst,
-			   mls_semantic_level_t * src)
+			   const mls_semantic_level_t * src)
 {
-	mls_semantic_cat_t *cat, *newcat, *lnewcat = NULL;
+	const mls_semantic_cat_t *cat;
+	mls_semantic_cat_t *newcat, *lnewcat = NULL;
 
 	mls_semantic_level_init(dst);
 	dst->sens = src->sens;
@@ -800,7 +801,7 @@ void mls_semantic_range_destroy(mls_semantic_range_t * r)
 }
 
 int mls_semantic_range_cpy(mls_semantic_range_t * dst,
-			   mls_semantic_range_t * src)
+			   const mls_semantic_range_t * src)
 {
 	if (mls_semantic_level_cpy(&dst->level[0], &src->level[0]) < 0)
 		return -1;
diff --git a/libsepol/src/mls.h b/libsepol/src/mls.h
index 5ca3cd51..eb4a1cb8 100644
--- a/libsepol/src/mls.h
+++ b/libsepol/src/mls.h
@@ -56,8 +56,8 @@ extern int mls_convert_context(policydb_t * oldp,
 			       policydb_t * newp, context_struct_t * context);
 
 extern int mls_compute_sid(policydb_t * policydb,
-			   context_struct_t * scontext,
-			   context_struct_t * tcontext,
+			   const context_struct_t * scontext,
+			   const context_struct_t * tcontext,
 			   sepol_security_class_t tclass,
 			   uint32_t specified, context_struct_t * newcontext);
 
-- 
2.35.1

