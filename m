Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571C0C433FE
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 22:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiAKWIf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 17:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345466AbiAKWIf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 17:08:35 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3DCC06173F
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 14:08:34 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id fo11so851622qvb.4
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 14:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L9s0NWCB2Ae/oAvy9vFBhtEe4hpmoS9IxE/3ttjkPVo=;
        b=XeYs7yoeNuJgsUR32ukl97bfUtyHI+datupiWFg6xahDrvbKBa3MLl4ndZr9T0n28m
         DFx3axyJ8Yp4Jpoit0Qu1a2Pr7mBDLS0xEJGAVRoA/BDW/d6RLF1SG1g2Qm93693TGha
         rbs4d/jCIcsEeZP3rKs9xUZb+J+1mx3LKuegXXW2AL9/bt3OKKFQ5ctR7KNBQv2mM3DV
         cRxjLhIj0Js7TGB3TtlPZdaOP8zs49ogeziSPooubjtvj4B3QrwRdxBNV/bqe2GSpssV
         q7QjXH3Q0VklSVJMAe2/+kq5vhwGfV7KuURR+Wqv6ljgfRoXAcRF61xAKioCKGqmNCtr
         Qtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9s0NWCB2Ae/oAvy9vFBhtEe4hpmoS9IxE/3ttjkPVo=;
        b=mxg8gEwNd6FZnG+i6slxyeHfo0BlsOcItsaJ0f2wpofdR5Te9C1znecd5Q4qzPvr3e
         7Qa5CLupVaM1MAuzTv20cBdJhpUomKopTrmaxHCfNzPVO1Dx/snDQr08SWQHyz8vSI+w
         ml3tfS66BjJg9IKu4rraZVTw1b8nWO6FRN3QjHrEKXljFQZFWjufOyxN7KSM8TAEEFG4
         URXS/m2/J4VxS5I1intv+ThgoPvpOOHx9McFK/+51eJpcPd3j++swrk09zCIKk9eBsau
         41DHqybJi4Y1Rs77jUzOiyEieA6AKJLE0019PupZtmZzUR5c9bQK+k18t0ShBKHiuhE7
         VVMg==
X-Gm-Message-State: AOAM530BLT5kWsPfla4wMqeYG3Uu+CPpHU2ConZ6ZkQt4Dku0om79O0s
        cqVNGq1dmLd84SH6L8oN6z0hfE9ZypA=
X-Google-Smtp-Source: ABdhPJzCn+dF4MeTZtonbYUFALGcIYv1NmYS3eWp/gRtDcIb47Fl14ms+ABNZBgpZywQDKiwGVlvsw==
X-Received: by 2002:ad4:5be5:: with SMTP id k5mr5636165qvc.124.1641938913856;
        Tue, 11 Jan 2022 14:08:33 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id t3sm8211068qtc.7.2022.01.11.14.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:08:33 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2 RFC] libsepol: Add not self support for neverallow rules
Date:   Tue, 11 Jan 2022 17:08:22 -0500
Message-Id: <20220111220823.596065-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111220823.596065-1-jwcart2@gmail.com>
References: <20220111220823.596065-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add not self support for neverallow rules.

Example 1
  allow TYPE1 TYPE1 : CLASS1 PERM1; # Rule 1
  allow TYPE1 TYPE2 : CLASS1 PERM1; # Rule 2
  neverallow TYPE1 ~self : CLASS1 PERM1;

Rule 1 is not a violation of the neverallow. Rule 2 is.

Example 2
  allow TYPE1 TYPE1 : CLASS2 PERM2; # Rule 1
  allow TYPE1 TYPE2 : CLASS2 PERM2; # Rule 2
  allow TYPE1 TYPE3 : CLASS2 PERM2; # Rule 3
  neverallow ATTR1 { ATTR2 -self } : CLASS2 PERM2;

Assuming TYPE1 has attribute ATTR1 and TYPE1 and TYPE2 have
attribute ATTR2, then rule 1 and 3 are not violations of the
neverallow while rule 2 is. Rule 3 is not a violation because
TYPE3 does not have attribute ATTR2.

Based on patch by Christian Göttsche <cgzones@googlemail.com>

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/include/sepol/policydb/policydb.h |   3 +-
 libsepol/src/assertion.c                   | 144 +++++++++++++++++----
 2 files changed, 120 insertions(+), 27 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 4bf9f05d..11637fe8 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -285,7 +285,8 @@ typedef struct avrule {
 #define AVRULE_XPERMS	(AVRULE_XPERMS_ALLOWED | AVRULE_XPERMS_AUDITALLOW | \
 				AVRULE_XPERMS_DONTAUDIT | AVRULE_XPERMS_NEVERALLOW)
 	uint32_t specified;
-#define RULE_SELF 1
+#define RULE_SELF       (1U << 0)
+#define RULE_NOTSELF    (1U << 1)
 	uint32_t flags;
 	type_set_t stypes;
 	type_set_t ttypes;
diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 44c20362..55e188be 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -215,6 +215,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
 	const int is_avrule_self = (avrule->flags & RULE_SELF) != 0;
+	const int is_avrule_notself = (avrule->flags & RULE_NOTSELF) != 0;
 
 	if ((k->specified & AVTAB_ALLOWED) == 0)
 		return 0;
@@ -234,19 +235,31 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	if (ebitmap_is_empty(&src_matches))
 		goto exit;
 
-	rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
-	if (rc < 0)
-		goto oom;
-
-	if (is_avrule_self) {
-		rc = ebitmap_and(&self_matches, &src_matches, &p->attr_type_map[k->target_type - 1]);
+	if (is_avrule_notself) {
+		if (ebitmap_is_empty(&avrule->ttypes.types)) {
+			/* avrule tgt is of the form ~self */
+			rc = ebitmap_cpy(&tgt_matches, &p->attr_type_map[k->target_type -1]);
+		} else {
+			/* avrule tgt is of the form {ATTR -self} */
+			rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type - 1]);
+		}
+		if (rc)
+			goto oom;
+	} else {
+		rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
 		if (rc < 0)
 			goto oom;
 
-		if (!ebitmap_is_empty(&self_matches)) {
-			rc = ebitmap_union(&tgt_matches, &self_matches);
+		if (is_avrule_self) {
+			rc = ebitmap_and(&self_matches, &src_matches, &p->attr_type_map[k->target_type - 1]);
 			if (rc < 0)
 				goto oom;
+
+			if (!ebitmap_is_empty(&self_matches)) {
+				rc = ebitmap_union(&tgt_matches, &self_matches);
+				if (rc < 0)
+					goto oom;
+			}
 		}
 	}
 
@@ -264,6 +277,8 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 			ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
 				if (is_avrule_self && i != j)
 					continue;
+				if (is_avrule_notself && i == j)
+					continue;
 				if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
 					a->errors += report_assertion_extended_permissions(handle,p, avrule,
 											i, j, cp, perms, k, avtab);
@@ -375,6 +390,7 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 	unsigned int i, j;
 	ebitmap_node_t *snode, *tnode;
 	const int is_avrule_self = (avrule->flags & RULE_SELF) != 0;
+	const int is_avrule_notself = (avrule->flags & RULE_NOTSELF) != 0;
 	int rc;
 
 	ebitmap_init(&src_matches);
@@ -391,20 +407,31 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 		goto exit;
 	}
 
-	rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types,
-			 &p->attr_type_map[k->target_type -1]);
-	if (rc < 0)
-		goto oom;
-
-	if (is_avrule_self) {
-		rc = ebitmap_and(&self_matches, &src_matches, &p->attr_type_map[k->target_type - 1]);
+	if (is_avrule_notself) {
+		if (ebitmap_is_empty(&avrule->ttypes.types)) {
+			/* avrule tgt is of the form ~self */
+			rc = ebitmap_cpy(&tgt_matches, &p->attr_type_map[k->target_type -1]);
+		} else {
+			/* avrule tgt is of the form {ATTR -self} */
+			rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type - 1]);
+		}
+		if (rc < 0)
+			goto oom;
+	} else {
+		rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
 		if (rc < 0)
 			goto oom;
 
-		if (!ebitmap_is_empty(&self_matches)) {
-			rc = ebitmap_union(&tgt_matches, &self_matches);
+		if (is_avrule_self) {
+			rc = ebitmap_and(&self_matches, &src_matches, &p->attr_type_map[k->target_type - 1]);
 			if (rc < 0)
 				goto oom;
+
+			if (!ebitmap_is_empty(&self_matches)) {
+				rc = ebitmap_union(&tgt_matches, &self_matches);
+				if (rc < 0)
+					goto oom;
+			}
 		}
 	}
 
@@ -417,6 +444,8 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 		ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
 			if (is_avrule_self && i != j)
 				continue;
+			if (is_avrule_notself && i == j)
+				continue;
 			if (check_assertion_extended_permissions_avtab(avrule, avtab, i, j, k, p)) {
 				rc = 1;
 				goto exit;
@@ -434,6 +463,61 @@ exit:
 	return rc;
 }
 
+static int check_assertion_notself_match(avtab_key_t *k, avrule_t *avrule, policydb_t *p)
+{
+	ebitmap_t src_matches, tgt_matches;
+	unsigned int num_src_matches, num_tgt_matches;
+	int rc;
+
+	ebitmap_init(&src_matches);
+	ebitmap_init(&tgt_matches);
+
+	rc = ebitmap_and(&src_matches, &avrule->stypes.types, &p->attr_type_map[k->source_type - 1]);
+	if (rc < 0)
+		goto oom;
+
+	if (ebitmap_is_empty(&avrule->ttypes.types)) {
+		/* avrule tgt is of the form ~self */
+		rc = ebitmap_cpy(&tgt_matches, &p->attr_type_map[k->target_type - 1]);
+	} else {
+		/* avrule tgt is of the form {ATTR -self} */
+		rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type - 1]);
+	}
+	if (rc < 0)
+		goto oom;
+
+	num_src_matches = ebitmap_cardinality(&src_matches);
+	num_tgt_matches = ebitmap_cardinality(&tgt_matches);
+	if (num_src_matches == 0 || num_tgt_matches == 0) {
+		rc = 0;
+		goto nomatch;
+	}
+	if (num_src_matches == 1 && num_tgt_matches == 1) {
+		ebitmap_t matches;
+		unsigned int num_matches;
+		rc = ebitmap_and(&matches, &src_matches, &tgt_matches);
+		if (rc < 0) {
+			ebitmap_destroy(&matches);
+			goto oom;
+		}
+		num_matches = ebitmap_cardinality(&matches);
+		ebitmap_destroy(&matches);
+		if (num_matches == 1) {
+			/* The only non-match is of the form TYPE TYPE */
+			rc = 0;
+			goto nomatch;
+		}
+	}
+
+	rc = 1;
+
+oom:
+nomatch:
+	ebitmap_destroy(&src_matches);
+	ebitmap_destroy(&tgt_matches);
+	return rc;
+}
+
 static int check_assertion_self_match(avtab_key_t *k, avrule_t *avrule, policydb_t *p)
 {
 	ebitmap_t src_matches;
@@ -477,16 +561,24 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 	if (!ebitmap_match_any(&avrule->stypes.types, &p->attr_type_map[k->source_type - 1]))
 		goto nomatch;
 
-	/* neverallow may have tgts even if it uses SELF */
-	if (!ebitmap_match_any(&avrule->ttypes.types, &p->attr_type_map[k->target_type -1])) {
-		if (avrule->flags == RULE_SELF) {
-			rc = check_assertion_self_match(k, avrule, p);
-			if (rc < 0)
-				goto oom;
-			if (rc == 0)
-				goto nomatch;
-		} else {
+	if (avrule->flags & RULE_NOTSELF) {
+		rc = check_assertion_notself_match(k, avrule, p);
+		if (rc < 0)
+			goto oom;
+		if (rc == 0)
 			goto nomatch;
+	} else {
+		/* neverallow may have tgts even if it uses SELF */
+		if (!ebitmap_match_any(&avrule->ttypes.types, &p->attr_type_map[k->target_type -1])) {
+			if (avrule->flags == RULE_SELF) {
+				rc = check_assertion_self_match(k, avrule, p);
+				if (rc < 0)
+					goto oom;
+				if (rc == 0)
+					goto nomatch;
+			} else {
+				goto nomatch;
+			}
 		}
 	}
 
-- 
2.31.1

