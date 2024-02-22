Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A28140372
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646388; cv=none; b=Q6+MmzZn1AgRymAZu8QJu20Kh5f7lStldQydRVN2V29JSxfU0DCfx2nNnu4hN1LgcAzy59yvyrsB1R/CPl2O/QzDjbUibTFy8oGW7+fGxu1EUY/byRbWw+086Aogl3x6l8NAVqjQAaXOdSwke/Xx8+mj6I4FLBap+OPT3MwDgsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646388; c=relaxed/simple;
	bh=SZ+zGVhSU6F3hsL4f/fO1qnXio9nfJN9GFUBbsVQj60=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhyW5YETIkisPSaXOYbPaEkPQOEJaDfhKTjnUthbspb7h75iblB7SznUitFbts7Eo4sykdU09kOATgNEUd4bd8Dy01OdHL1YpcIiEbeCPzsXtyfKaXRMCWLFO/W42MeTIBtroE+ANwAnh5L9iYqEswWyxkGGWU4rhD9LNI6lwj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ew4QP6L1; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ew4QP6L1"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68f51c5f9baso2002476d6.3
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646386; x=1709251186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2UG23iVUyi2LU1m26pPSBPDlo3EpeahzkQM9ckCXSY=;
        b=ew4QP6L1vTt4DBAJxyfAx2yCROKgMp53uICwVRWvXv6c4jCmvbKIvX+d03P1HZt6VI
         udlKDIBzPtbwLEvDn97gLnO31lpM7t5DG+y76UkIVy93pkucYQJzlBz8WZ3CHtC8xjtb
         Jyu+uqJ1rVcPbrE2qscvvn71NtNrLtnZtkozarfPEla1b3X4HB5KKqfm+yoFGgKbCjiA
         Nj0x+qhD3Pmj322Ktb3QAECXqj1PPg4nF5snBEObtKwpbXOLuSj9HXYa3pJJe81IcDdp
         zjKFlS4ramk0BSzWBMMciwQYeObuayZD/vfyuMCDGfrKcmgtjVpdGCe1pDQJBA8a2cqj
         wUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646386; x=1709251186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2UG23iVUyi2LU1m26pPSBPDlo3EpeahzkQM9ckCXSY=;
        b=o5zh/AlNL0cFVyqm9d3DLk3lu5/GIW1yVQM2+LEd/7E6DWRVG7aezJNWZl2KpuLqmt
         lqkvc0vT3+oRwy5wXLs2+zCYiywvw4tmsBGd7s6+qGQv8MXkK2yracX7Yd9DJKp6K6fF
         aH4XDDOoSvq5VpIpA8XYdxtMV+WXWq0N1v0+gBQgMaA2HhTGO28Y5hJiH12kgYuAjtJI
         aiK4KAgbfv1K/zSyVJQMivZDWoT2IjB593PLVvSNCXwZxgvG2yrUg2cVfngF4KdAy61m
         H/gqeGTeJgufOX8KNXwBoUsqrXcOQvnGH4UPjsC/mcF8/8dZjQ6q5gX9Ew8dViYCBcNT
         2P5A==
X-Gm-Message-State: AOJu0Yy4Rp7ZXFT5Ss1ApUNxjrIaMq0F0Xwx/KQMcVry4XGD2wS3hu4N
	BPhnTbV2qZ14nEq/UrmVj2bW3Klu0hQL70rC9KFfDtfxa7IHNqgxSqQU2VPMdHG6BmDOx+eUhlM
	=
X-Google-Smtp-Source: AGHT+IHDVGKKq5P97M/7E/G/eaoH/YSa4oQdSsdk0rK9IWjXLr1BddPAHqptNtMJHKfRvRo9or7d9g==
X-Received: by 2002:a0c:cb89:0:b0:68f:2eac:5e1e with SMTP id p9-20020a0ccb89000000b0068f2eac5e1emr649183qvk.38.1708646385794;
        Thu, 22 Feb 2024 15:59:45 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ql9-20020a056214540900b0068f920768a5sm3675403qvb.140.2024.02.22.15.59.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:45 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 13/21] selinux: fix style issues in security/selinux/ss/mls.c
Date: Thu, 22 Feb 2024 18:52:31 -0500
Message-ID: <20240222235708.386652-36-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7905; i=paul@paul-moore.com; h=from:subject; bh=SZ+zGVhSU6F3hsL4f/fO1qnXio9nfJN9GFUBbsVQj60=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl19+iw/R+bBjm6QWeIaPJ9BZqxOriyLbLRzhGM da28F09aOyJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdffogAKCRDqIPLalzeJ c+uYD/9lEu1WjEW/dqrBwD5YKuoGfJFThlkPlUVQ23q6g9V1hfTYkBjZcCN1tJiuH71rCZr/Dj7 ukDlt/iSoxuU41zirxuINir+rRHhGqEsvlV3p3UHJgEdzgz+m7o7s2QF6Hc44A8ZBCdz4GelI6F a6WhwvIILsiRlV99we3BlXEK8td/8QDEmMdI0qsueU9oN7/Hay3ZNzE194xHLv1yXH5bYNHG0Rw re76ZEm5uZydeN2zWl36tbGW2I17LZ7J3s14AqtIMERz+8ncuMFBtbUET8tfsl9oJLHCxtUQDAm HJm8AUp3nheDeko31Q/5+ln0wQelmlaQe33cyiagsDlBqOxQwXMW456OPCSEeoNmJXxs1Nh+YK8 1i0Ozj6mymuCW92PMksZWpB91lmdS3ILokmn8m8RENZpHVBB65ruyV/UEJICBOdVyuRXfo2w1a9 c0UVA7acQepjxXKeNF8CXMyEezL/7Hh7TSdOsJXKBkXTPSultbIypBcsBN+n1yyrVfOXnBHH5du OZcPLEVUhZ76lmgVKZ9LmLRca/NyQofBF3FoBBl8SX6umb453j25cPBf7+1ec1FfpLY8Yb/8S12 rut/JNB3byEca1enCL0yodFMhf06qZDaMw+yHYOUWG1Q6MyCzYskmkUleHC7H3R9kpywXT8Xh9/ vyanZ2rou7OX2Ww==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/mls.c | 83 ++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 50 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index cd38f5913b63..989c809d310d 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -4,19 +4,15 @@
  *
  * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
+
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
+ *          Support for enhanced MLS infrastructure.
+ *          Copyright (C) 2004-2006 Trusted Computer Solutions, Inc.
  *
- *	Support for enhanced MLS infrastructure.
- *
- * Copyright (C) 2004-2006 Trusted Computer Solutions, Inc.
- */
-/*
  * Updated: Hewlett-Packard <paul@paul-moore.com>
- *
- *      Added support to import/export the MLS label from NetLabel
- *
- * (c) Copyright Hewlett-Packard Development Company, L.P., 2006
+ *          Added support to import/export the MLS label from NetLabel
+ *          Copyright (C) Hewlett-Packard Development Company, L.P., 2006
  */
 
 #include <linux/kernel.h>
@@ -52,7 +48,8 @@ int mls_compute_context_len(struct policydb *p, struct context *context)
 		head = -2;
 		prev = -2;
 		e = &context->range.level[l].cat;
-		ebitmap_for_each_positive_bit(e, node, i) {
+		ebitmap_for_each_positive_bit(e, node, i)
+		{
 			if (i - prev > 1) {
 				/* one or more negative bits are skipped */
 				if (head != prev) {
@@ -86,8 +83,7 @@ int mls_compute_context_len(struct policydb *p, struct context *context)
  * the MLS fields of `context' into the string `*scontext'.
  * Update `*scontext' to point to the end of the MLS fields.
  */
-void mls_sid_to_context(struct policydb *p,
-			struct context *context,
+void mls_sid_to_context(struct policydb *p, struct context *context,
 			char **scontext)
 {
 	char *scontextp, *nm;
@@ -112,7 +108,8 @@ void mls_sid_to_context(struct policydb *p,
 		head = -2;
 		prev = -2;
 		e = &context->range.level[l].cat;
-		ebitmap_for_each_positive_bit(e, node, i) {
+		ebitmap_for_each_positive_bit(e, node, i)
+		{
 			if (i - prev > 1) {
 				/* one or more negative bits are skipped */
 				if (prev != head) {
@@ -230,12 +227,8 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
  * Policy read-lock must be held for sidtab lookup.
  *
  */
-int mls_context_to_sid(struct policydb *pol,
-		       char oldc,
-		       char *scontext,
-		       struct context *context,
-		       struct sidtab *s,
-		       u32 def_sid)
+int mls_context_to_sid(struct policydb *pol, char oldc, char *scontext,
+		       struct context *context, struct sidtab *s, u32 def_sid)
 {
 	char *sensitivity, *cur_cat, *next_cat, *rngptr;
 	struct level_datum *levdatum;
@@ -333,7 +326,8 @@ int mls_context_to_sid(struct policydb *pol,
 				return -EINVAL;
 
 			for (i = catdatum->value; i < rngdatum->value; i++) {
-				rc = ebitmap_set_bit(&context->range.level[l].cat, i, 1);
+				rc = ebitmap_set_bit(
+					&context->range.level[l].cat, i, 1);
 				if (rc)
 					return rc;
 			}
@@ -371,8 +365,8 @@ int mls_from_string(struct policydb *p, char *str, struct context *context,
 	if (!tmpstr) {
 		rc = -ENOMEM;
 	} else {
-		rc = mls_context_to_sid(p, ':', tmpstr, context,
-					NULL, SECSID_NULL);
+		rc = mls_context_to_sid(p, ':', tmpstr, context, NULL,
+					SECSID_NULL);
 		kfree(tmpstr);
 	}
 
@@ -382,8 +376,7 @@ int mls_from_string(struct policydb *p, char *str, struct context *context,
 /*
  * Copies the MLS range `range' into `context'.
  */
-int mls_range_set(struct context *context,
-				struct mls_range *range)
+int mls_range_set(struct context *context, struct mls_range *range)
 {
 	int l, rc = 0;
 
@@ -399,9 +392,8 @@ int mls_range_set(struct context *context,
 	return rc;
 }
 
-int mls_setup_user_range(struct policydb *p,
-			 struct context *fromcon, struct user_datum *user,
-			 struct context *usercon)
+int mls_setup_user_range(struct policydb *p, struct context *fromcon,
+			 struct user_datum *user, struct context *usercon)
 {
 	if (p->mls_enabled) {
 		struct mls_level *fromcon_sen = &(fromcon->range.level[0]);
@@ -444,10 +436,8 @@ int mls_setup_user_range(struct policydb *p,
  * policy `oldp' to the values specified in the policy `newp',
  * storing the resulting context in `newc'.
  */
-int mls_convert_context(struct policydb *oldp,
-			struct policydb *newp,
-			struct context *oldc,
-			struct context *newc)
+int mls_convert_context(struct policydb *oldp, struct policydb *newp,
+			struct context *oldc, struct context *newc)
 {
 	struct level_datum *levdatum;
 	struct cat_datum *catdatum;
@@ -468,8 +458,9 @@ int mls_convert_context(struct policydb *oldp,
 			return -EINVAL;
 		newc->range.level[l].sens = levdatum->level->sens;
 
-		ebitmap_for_each_positive_bit(&oldc->range.level[l].cat,
-					      node, i) {
+		ebitmap_for_each_positive_bit(&oldc->range.level[l].cat, node,
+					      i)
+		{
 			int rc;
 
 			catdatum = symtab_search(&newp->p_cats,
@@ -486,13 +477,9 @@ int mls_convert_context(struct policydb *oldp,
 	return 0;
 }
 
-int mls_compute_sid(struct policydb *p,
-		    struct context *scontext,
-		    struct context *tcontext,
-		    u16 tclass,
-		    u32 specified,
-		    struct context *newcontext,
-		    bool sock)
+int mls_compute_sid(struct policydb *p, struct context *scontext,
+		    struct context *tcontext, u16 tclass, u32 specified,
+		    struct context *newcontext, bool sock)
 {
 	struct range_trans rtr;
 	struct mls_range *r;
@@ -532,8 +519,8 @@ int mls_compute_sid(struct policydb *p,
 		case DEFAULT_TARGET_LOW_HIGH:
 			return mls_context_cpy(newcontext, tcontext);
 		case DEFAULT_GLBLUB:
-			return mls_context_glblub(newcontext,
-						  scontext, tcontext);
+			return mls_context_glblub(newcontext, scontext,
+						  tcontext);
 		}
 
 		fallthrough;
@@ -563,8 +550,7 @@ int mls_compute_sid(struct policydb *p,
  * NetLabel MLS sensitivity level field.
  *
  */
-void mls_export_netlbl_lvl(struct policydb *p,
-			   struct context *context,
+void mls_export_netlbl_lvl(struct policydb *p, struct context *context,
 			   struct netlbl_lsm_secattr *secattr)
 {
 	if (!p->mls_enabled)
@@ -585,8 +571,7 @@ void mls_export_netlbl_lvl(struct policydb *p,
  * NetLabel MLS sensitivity level into the context.
  *
  */
-void mls_import_netlbl_lvl(struct policydb *p,
-			   struct context *context,
+void mls_import_netlbl_lvl(struct policydb *p, struct context *context,
 			   struct netlbl_lsm_secattr *secattr)
 {
 	if (!p->mls_enabled)
@@ -607,8 +592,7 @@ void mls_import_netlbl_lvl(struct policydb *p,
  * MLS category field.  Returns zero on success, negative values on failure.
  *
  */
-int mls_export_netlbl_cat(struct policydb *p,
-			  struct context *context,
+int mls_export_netlbl_cat(struct policydb *p, struct context *context,
 			  struct netlbl_lsm_secattr *secattr)
 {
 	int rc;
@@ -637,8 +621,7 @@ int mls_export_netlbl_cat(struct policydb *p,
  * negative values on failure.
  *
  */
-int mls_import_netlbl_cat(struct policydb *p,
-			  struct context *context,
+int mls_import_netlbl_cat(struct policydb *p, struct context *context,
 			  struct netlbl_lsm_secattr *secattr)
 {
 	int rc;
-- 
2.43.2

