Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2000541C6A
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785160816; cv=none; b=nXVe7drsCmt8cT7pWvYW9p55dM7QDT8VGo1zu9bPK6M301YR3jY3ovTX8WDkVGc/c8HKEWH7CVflHCyXz1SuApASKkKMiM5JqTexXss0yLXpB0hal+kGS13jUZMADzzFXZyhzZwBc2cjVF9V9LEx+KaJ/kLNCiKmci/v0ScX/sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785160816; c=relaxed/simple;
	bh=XMbPHl/RGV3SXDMCi5dFs0QJ4Cp95C7bK00yesOHYIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/QIxRBOhM48no43IUVzpI9EWGKW+WAQHbMzpDFJ+Gqp9diQF55384s3I+IfqSuReoSV+/Qz5W26L+KXc0ZSbhAB4gVILEv1gbsGpko4MXTUdxRpBpE/OcW2VtvHPT1g80fbMwLY6/wIIS2B8+uLwy0IV0yvoDm6XQgAL/DmPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkiHd5iW; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkiHd5iW"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-90004d2f7b7so33120566d6.1
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785160814; x=1785765614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vcF4Jg/gqtvQLrEuhcu9FTBzIdBjDzKQym3Hv+ePMlM=;
        b=AkiHd5iWSHhG9YM3d1fEcZ1DQm0o/1bCw4cTR9rfCq0n08/n9RvH5TI846tnyOWDVB
         wOO20tTyL12al0M1iJnjTWzHeKWI84d2LyaUCkz0wa1Yeruufv3jMwtLUyJYg2LhGyX9
         a6yXCkJtsWOrUUjyEjp9md51if8oZ3BY3I/PaY8ViLcvYkGP/L5jlzGuk6FhIyrXUtr4
         wKX4mInKHeBnW/uwYWc+07gZd2PaUSS1b4FkGUua4hpU2L03ZDLomozXI60JUkjWPKDx
         DV50REbvgPDftEPDDnN/HcHpAY/XaMKLg2yrhxpQk3haa8PDUHiP9LZxalEB1PVQIsg5
         m7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785160814; x=1785765614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vcF4Jg/gqtvQLrEuhcu9FTBzIdBjDzKQym3Hv+ePMlM=;
        b=mznGziQV8ULBO/55rtuuWmECFnAbPlmNqzcxergocHvY39jQJW7FRLo0L9uFOAR4HZ
         UhVaj9JrFieslX4INcF45gBZdru2bjmm1k/As7HFsYXKsRJB1y6XKNKhoyUcZi3KmuvK
         89SB3N6TGa00VihmvuAl+CgJrpc4H0M6iKYHqCuNunnjAC3cbG6VSvSuxwINtCT1b7fp
         5QY3AWQd+p2ZjChYuDhl+mnPIYCvkXAYaSNAK+mxa9H74kWg8NIY7NLwgj+qn/gYjcGB
         lPhgVoWXER8sGWAKfuIipeIj+JpTJiQPwfRyr2fLU0KXprc7isxz2fK7bimrVAj/9NMr
         yOsw==
X-Gm-Message-State: AOJu0Yyqg01Gg60/Z/UOif6PW+xYnJs+B9GWrVB+vtWS3+cxZNqUZTNj
	k5Sts/aFS0yWkL1vZNP5RfSxmBfElnlwUx+cmz9T9Hu/Wtknns5VK2kps+sfAg==
X-Gm-Gg: AR+sD12x1hAYKGx2HlIJ0YMj0oTZbKudukadUHcbM1/aoO1YbsTACkuo1YZlGi9Jj4C
	KL1CJVw7OQntNAN1gUxfCwQTK3gAXWY5eA/Egw3fp/br+tKPFK2yaIh7pc30Ny0QUHvdmLWu3Ag
	amMIKqBfll3PJkEL0KIL7lUof98cWhbSYOEJZb6CJor4wSXkWsYbT4iGThm8/miAFXW6a8OS4KB
	nqeM6aRHFeoFFN2NNS0z6yGnPSdOYAMETcdcCMML5zx4yOewjgBC2l123ZFj8FXSIL+9/bPtpgp
	Z2TCTm51jEX4lqw7bwlhF4KnTDE7y0DhCrh9AHFMmWqI4n57o41yMYCxN5g88sSDndCeZM9vyBR
	xgAVAheFFDuCY2+TMw1QjhVe4t5Ij/zWG4ZkJDpOFkqbzlbAU0vGt5Lg5GfvPhK+3M6DO1zmn3s
	5Mfp9minIMLRj5MhZTtLrRp12G4VKLF+F6YvIv0ajBjXya1KtzDan0YH4cX1bnsWKiMVxaQ7nDD
	I2Q3A==
X-Received: by 2002:a05:6214:5197:b0:8f1:7a7:b869 with SMTP id 6a1803df08f44-907ec7e473cmr112546296d6.31.1785160813525;
        Mon, 27 Jul 2026 07:00:13 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e86d7c80sm69009186d6.39.2026.07.27.07.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:00:13 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: cap max depth for __evaluate_classperms_list()
Date: Mon, 27 Jul 2026 09:59:57 -0400
Message-ID: <20260727135957.85523-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__evaluate_classperms_list() is called recursively without
a depth limit, which can overflow the stack. Cap the depth
to avoid such overflows.

Reported-by: oss-fuzz (issue 479899924)
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/cil/src/cil_post.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 8845faed..183b0d49 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -2291,11 +2291,14 @@ exit:
 }
 
 static int __evaluate_classperms_list(struct cil_list *classperms,
-				      struct cil_db *db)
+				      struct cil_db *db, int depth)
 {
 	int rc = SEPOL_ERR;
 	struct cil_list_item *curr;
 
+	if (depth > 32)
+		return SEPOL_ERR;
+
 	cil_list_for_each(curr, classperms) {
 		if (curr->flavor == CIL_CLASSPERMS) {
 			struct cil_classperms *cp = curr->data;
@@ -2313,7 +2316,7 @@ static int __evaluate_classperms_list(struct cil_list *classperms,
 				cil_list_for_each(i, cp->perms) {
 					struct cil_perm *cmp = i->data;
 					rc = __evaluate_classperms_list(
-						cmp->classperms, db);
+						cmp->classperms, db, depth + 1);
 					if (rc != SEPOL_OK) {
 						goto exit;
 					}
@@ -2322,7 +2325,8 @@ static int __evaluate_classperms_list(struct cil_list *classperms,
 		} else { /* SET */
 			struct cil_classperms_set *cp_set = curr->data;
 			struct cil_classpermission *cp = cp_set->set;
-			rc = __evaluate_classperms_list(cp->classperms, db);
+			rc = __evaluate_classperms_list(cp->classperms, db,
+							depth + 1);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
@@ -2347,7 +2351,7 @@ __evaluate_map_perm_classperms(__attribute__((unused)) hashtab_key_t k,
 	struct class_map_args *map_args = args;
 	struct cil_perm *cmp = (struct cil_perm *)d;
 
-	int rc = __evaluate_classperms_list(cmp->classperms, map_args->db);
+	int rc = __evaluate_classperms_list(cmp->classperms, map_args->db, 0);
 
 	if (rc != SEPOL_OK) {
 		map_args->rc = rc;
@@ -2393,7 +2397,7 @@ static int __cil_post_db_classperms_helper(struct cil_tree_node *node,
 	}
 	case CIL_CLASSPERMISSION: {
 		struct cil_classpermission *cp = node->data;
-		rc = __evaluate_classperms_list(cp->classperms, db);
+		rc = __evaluate_classperms_list(cp->classperms, db, 0);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2401,7 +2405,8 @@ static int __cil_post_db_classperms_helper(struct cil_tree_node *node,
 	}
 	case CIL_AVRULE: {
 		struct cil_avrule *avrule = node->data;
-		rc = __evaluate_classperms_list(avrule->perms.classperms, db);
+		rc = __evaluate_classperms_list(avrule->perms.classperms, db,
+						0);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2409,7 +2414,7 @@ static int __cil_post_db_classperms_helper(struct cil_tree_node *node,
 	}
 	case CIL_DENY_RULE: {
 		struct cil_deny_rule *deny = node->data;
-		rc = __evaluate_classperms_list(deny->classperms, db);
+		rc = __evaluate_classperms_list(deny->classperms, db, 0);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2418,7 +2423,7 @@ static int __cil_post_db_classperms_helper(struct cil_tree_node *node,
 	case CIL_CONSTRAIN:
 	case CIL_MLSCONSTRAIN: {
 		struct cil_constrain *constrain = node->data;
-		rc = __evaluate_classperms_list(constrain->classperms, db);
+		rc = __evaluate_classperms_list(constrain->classperms, db, 0);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
-- 
2.55.0

