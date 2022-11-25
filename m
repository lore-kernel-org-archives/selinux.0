Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41308C4167B
	for <selinux@archiver.kernel.org>; Fri, 25 Nov 2022 15:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKYPuE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Nov 2022 10:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiKYPuC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Nov 2022 10:50:02 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10752FFD7
        for <selinux@vger.kernel.org>; Fri, 25 Nov 2022 07:50:00 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ho10so11231415ejc.1
        for <selinux@vger.kernel.org>; Fri, 25 Nov 2022 07:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpxfNS5H2f3MDOgS3AH+v2xwVje7iyLDHr1hQ2K1fNE=;
        b=ZocoP7o/fyLk1N4y84IX92lW8zPeu1ZbKmij6og9vH+fUxhkC/spv0hl1AOtnvkyyT
         zg+/h5ee8zy/fVL2eh4Oy6IngOnTR+voBni8nsQCHtxSMp0au3fbM9+O8r29NSL3sB0L
         xhK6MhiZjDqcuzGVb5ap2e+eWNkSsjnNLMoixnK6ofrRJk48XEsS2Iu1QTRL3/geUEBY
         FqKhG9R9BAyyOdRe8smHpGOR9qZIR2Fh3ecSyVsoPF9YCo9ldjD2Y7r2yZUEk5CPsO7k
         VAxxu1gSkpE593Te4zy+hRWVGvB9V1U5CUa9UWKa/i5VpxB8K1/oTGpup8lsUbl+yxxO
         ttfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpxfNS5H2f3MDOgS3AH+v2xwVje7iyLDHr1hQ2K1fNE=;
        b=ewWW3N2qvMZ2+1EmInuNE4TjDI3RxFgcGh7nELOUd4uFrvgRWEK5sGQf3UH7VbOG0f
         CnIiJvb5Bqh3fsj3Hvne3NP/wS1YwJVWd/JT0CyKmK0Ug+1qRuqNgaaoxAY7GMI0E2lW
         6ZZCFLWMGyMoeOwu6SlWvPIWTMKx9MvFmehXvuHOFK/izikP6W4QfgK54x/uycbMM+vk
         2rk3ykOAgE+Mk8IwETY3vFJbKs9cRkYvUbM33noFJ41bSLZoD5z85HM6wmGX0XGIIpEq
         bJsPw13gFYopCgFPqLdMw2+ag9FWFNdH/h5cUmpVL6i9CeOKjAm+MNLO5JeWUFl6kqaX
         fo2g==
X-Gm-Message-State: ANoB5plfBEZ+zR04TJ2f6TMDO/eZ+fOcwh//ezpx2xy4ldWZtXaLbykn
        RsLnCM/Lfgrkcybh+TUN3onlRM7wgmg=
X-Google-Smtp-Source: AA0mqf5eKEsWJf0XBQYW/9KCdLfi32DT32vMJ89rU5QunJjMoF8zYWkSE79jmKdwNQAzeC9XnYI34w==
X-Received: by 2002:a17:906:2e82:b0:7ae:44b2:cb7f with SMTP id o2-20020a1709062e8200b007ae44b2cb7fmr18387798eji.437.1669391399099;
        Fri, 25 Nov 2022 07:49:59 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-154-194.77.3.pool.telefonica.de. [77.3.154.194])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090630ce00b0078df26efb7dsm1677136ejb.107.2022.11.25.07.49.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:49:58 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v4 1/6] libsepol: Add not self support for neverallow rules
Date:   Fri, 25 Nov 2022 16:49:47 +0100
Message-Id: <20221125154952.20910-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125154952.20910-1-cgzones@googlemail.com>
References: <20221125154952.20910-1-cgzones@googlemail.com>
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

Adopted improvements from James Carter <jwcart2@gmail.com>

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/policydb.h |   3 +-
 libsepol/src/assertion.c                   | 144 +++++++++++++++++----
 libsepol/src/policydb_validate.c           |   9 ++
 3 files changed, 129 insertions(+), 27 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index ef1a014a..b014b7a8 100644
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
index 161874c3..11185253 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -223,6 +223,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
 	const int is_avrule_self = (avrule->flags & RULE_SELF) != 0;
+	const int is_avrule_notself = (avrule->flags & RULE_NOTSELF) != 0;
 
 	if ((k->specified & AVTAB_ALLOWED) == 0)
 		return 0;
@@ -242,19 +243,31 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
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
 
@@ -272,6 +285,8 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 			ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
 				if (is_avrule_self && i != j)
 					continue;
+				if (is_avrule_notself && i == j)
+					continue;
 				if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
 					a->errors += report_assertion_extended_permissions(handle,p, avrule,
 											i, j, cp, perms, k, avtab);
@@ -383,6 +398,7 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 	unsigned int i, j;
 	ebitmap_node_t *snode, *tnode;
 	const int is_avrule_self = (avrule->flags & RULE_SELF) != 0;
+	const int is_avrule_notself = (avrule->flags & RULE_NOTSELF) != 0;
 	int rc;
 
 	ebitmap_init(&src_matches);
@@ -399,20 +415,31 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
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
 
@@ -425,6 +452,8 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 		ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
 			if (is_avrule_self && i != j)
 				continue;
+			if (is_avrule_notself && i == j)
+				continue;
 			if (check_assertion_extended_permissions_avtab(avrule, avtab, i, j, k, p)) {
 				rc = 1;
 				goto exit;
@@ -442,6 +471,61 @@ exit:
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
@@ -485,16 +569,24 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
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
 
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 521ea4ff..3d51fb68 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -916,6 +916,15 @@ static int validate_avrules(sepol_handle_t *handle, const avrule_t *avrule, int
 		case 0:
 		case RULE_SELF:
 			break;
+		case RULE_NOTSELF:
+			switch(avrule->specified) {
+			case AVRULE_NEVERALLOW:
+			case AVRULE_XPERMS_NEVERALLOW:
+				break;
+			default:
+				goto bad;
+			}
+			break;
 		default:
 			goto bad;
 		}
-- 
2.38.1

