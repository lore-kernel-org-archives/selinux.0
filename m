Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308875;
	b=gB6Ek7RObNGSx6K4SGYpmGjfqXvw5rGxGXmYkuV1jkm2Dm02sf/BRwfe/ROe2AcZlc8d
	 +0mkRl1h55+1RI7H+Wlskpcf5zaafJ3LQD8fB0LcZoGXlh99DBe9pKvWkUJdPNu0E4vYP
	 aZVA8jp6anHRMGF1NJpGDXPpmo1Or3vOZesRhI4dWV2UPxzR854VG7JD16Ztd2x6d8WEs
	 AN8VGObsxJb314uxPJrCT0+uH5dO9evCeMS6BkOHHgNBsuzO/+zJOxTPGmSzNmCbDokqS
	 lskqr2UlEOWelDY0ckgcU+OcNFiIMaVPVPT/6qdkMCtnWPBih1LQFbu9YYtXwEp+RHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308875;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=98gP7rlIKTCHWjF1UqUbV86m4O+F9t2eWRinjNirrNs=;
	b=BG2Iu01/LnC/BD4h7Uf7/AxK0r1+o3vDVIyn+HUdG4/DpAjoGrftLPxdMyvXy6XwZQie
	 I1yf3BNMBIvuY95m+b9L+Nyur3Rbsyvk/fZmh2eNtPAt9CI7y/co91FWBmqHPo9hkclUD
	 Z/EeYO7SWPTBQ92c6WMlffL0UyM3ve0hNBAh7O7yUpdoaCPMuOayFPGroFbA3bsczEGkw
	 l7V0bWM3qcGIK7G3td3q1L+Mkufy9XznxWKDORXHlUrZ/jG/OkjeSHw7usGwuYr90ATVF
	 nhg0GVhTHmIVFcc0WZL1QHpaxSwwF4aUKopvqxKzsLwGx1vEZELwRqBoJE7kCTdex7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=lEzLTpUa;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289EE606A32A
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 11:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 289EE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=lEzLTpUa
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794308873;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=98gP7rlIKTCHWjF1UqUbV86m4O+F9t2eWRinjNirrNs=;
	b=lEzLTpUa5H6ZIy+OONbmGuGd0QuSvGQ73smDcls4178myGj75WLTmOZOMrLnSlKT3QpxTT
	8C8HLjhtUCpiIAllS/6qPWD/6e5yaWuaK9/0zzPu16ug1SHBC1xOrq5cQTBOxCWFp6cKV6
	ZMy1KlLInsaGKThORwEowm+skR7TMESmisvFtI8tcIMPqlraydlZFDekPYLLDelvmYh8OI
	VaPl/viY9cupQYE05ua/epia959HfZ5fxAxQoKwZ97IV1AD1HumI7hbsOE3CkM55i85rRC
	NhIt5nCBY1KdBxaTwx1Jm/xccridg7RP1W85a2PPyy2fV4T4NY6lheaq9+baUA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 6/6] libsepol/cil: verify all ordered statements in a single tree walk
Date: Tue, 10 Nov 2026 12:07:38 +0100
Message-ID: <20261110110739.67209-5-cgoettsche@seltendoof.de>
In-Reply-To: <20261110110739.67209-1-cgoettsche@seltendoof.de>
References: <20261110110739.67209-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Whether all SIDs, classes, categories and sensitivities are part of an
ordering statement is verified by walking the whole AST once for each
of the four flavors.

Walk the tree once, remember the first unordered node of each flavor
and report them in the same order as before.

Compiling DSSP5 takes about 5% less time.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_resolve_ast.c |  17 +---
 libsepol/cil/src/cil_verify.c      | 124 ++++++++++++++++++-----------
 libsepol/cil/src/cil_verify.h      |   4 +-
 3 files changed, 79 insertions(+), 66 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index a805ca17..7b9c585e 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -4549,22 +4549,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 				goto exit;
 			}
 
-			rc = __cil_verify_ordered(current, CIL_SID);
-			if (rc != SEPOL_OK) {
-				goto exit;
-			}
-
-			rc = __cil_verify_ordered(current, CIL_CLASS);
-			if (rc != SEPOL_OK) {
-				goto exit;
-			}
-
-			rc = __cil_verify_ordered(current, CIL_CAT);
-			if (rc != SEPOL_OK) {
-				goto exit;
-			}
-
-			rc = __cil_verify_ordered(current, CIL_SENS);
+			rc = __cil_verify_ordered(current);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 0578428a..745277f2 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -678,69 +678,99 @@ int cil_verify_completed_ordered_list(struct cil_list *complete,
 }
 
 struct cil_args_verify_order {
-	uint32_t *flavor;
+	struct cil_tree_node *sid;
+	struct cil_tree_node *class;
+	struct cil_tree_node *cat;
+	struct cil_tree_node *sens;
 };
 
-int __cil_verify_ordered_node_helper(struct cil_tree_node *node,
-				     __attribute__((unused)) uint32_t *finished,
-				     void *extra_args)
+/* Record the first unordered node of each flavor */
+static int __cil_verify_ordered_node_helper(struct cil_tree_node *node,
+					    __attribute__((unused))
+					    uint32_t *finished,
+					    void *extra_args)
 {
 	struct cil_args_verify_order *args = extra_args;
-	uint32_t *flavor = args->flavor;
-
-	if (node->flavor == *flavor) {
-		if (node->flavor == CIL_SID) {
-			struct cil_sid *sid = node->data;
-			if (sid->ordered == CIL_FALSE) {
-				cil_tree_log(node, CIL_ERR,
-					     "SID %s not in sidorder statement",
-					     sid->datum.name);
-				return SEPOL_ERR;
-			}
-		} else if (node->flavor == CIL_CLASS) {
-			struct cil_class *class = node->data;
-			if (class->ordered == CIL_FALSE) {
-				cil_tree_log(
-					node, CIL_ERR,
-					"Class %s not in classorder statement",
-					class->datum.name);
-				return SEPOL_ERR;
-			}
-		} else if (node->flavor == CIL_CAT) {
-			struct cil_cat *cat = node->data;
-			if (cat->ordered == CIL_FALSE) {
-				cil_tree_log(
-					node, CIL_ERR,
-					"Category %s not in categoryorder statement",
-					cat->datum.name);
-				return SEPOL_ERR;
-			}
-		} else if (node->flavor == CIL_SENS) {
-			struct cil_sens *sens = node->data;
-			if (sens->ordered == CIL_FALSE) {
-				cil_tree_log(
-					node, CIL_ERR,
-					"Sensitivity %s not in sensitivityorder statement",
-					sens->datum.name);
-				return SEPOL_ERR;
-			}
+
+	switch (node->flavor) {
+	case CIL_SID: {
+		struct cil_sid *sid = node->data;
+		if (sid->ordered == CIL_FALSE && args->sid == NULL) {
+			args->sid = node;
+		}
+		break;
+	}
+	case CIL_CLASS: {
+		struct cil_class *class = node->data;
+		if (class->ordered == CIL_FALSE && args->class == NULL) {
+			args->class = node;
+		}
+		break;
+	}
+	case CIL_CAT: {
+		struct cil_cat *cat = node->data;
+		if (cat->ordered == CIL_FALSE && args->cat == NULL) {
+			args->cat = node;
+		}
+		break;
+	}
+	case CIL_SENS: {
+		struct cil_sens *sens = node->data;
+		if (sens->ordered == CIL_FALSE && args->sens == NULL) {
+			args->sens = node;
 		}
+		break;
+	}
+	default:
+		break;
 	}
 
 	return SEPOL_OK;
 }
 
-int __cil_verify_ordered(struct cil_tree_node *current, enum cil_flavor flavor)
+/*
+ * Verify that all SIDs, classes, categories and sensitivities are part of
+ * an ordering statement, using a single walk of the tree.
+ */
+int __cil_verify_ordered(struct cil_tree_node *current)
 {
-	struct cil_args_verify_order extra_args;
+	struct cil_args_verify_order extra_args = { NULL, NULL, NULL, NULL };
+	struct cil_tree_node *node;
 	int rc = SEPOL_ERR;
 
-	extra_args.flavor = &flavor;
-
 	rc = cil_tree_walk(current, __cil_verify_ordered_node_helper, NULL,
 			   NULL, &extra_args);
+	if (rc != SEPOL_OK) {
+		return rc;
+	}
+
+	if (extra_args.sid != NULL) {
+		node = extra_args.sid;
+		cil_tree_log(node, CIL_ERR, "SID %s not in sidorder statement",
+			     DATUM(node->data)->name);
+	} else if (extra_args.class != NULL) {
+		node = extra_args.class;
+		cil_tree_log(node, CIL_ERR,
+			     "Class %s not in classorder statement",
+			     DATUM(node->data)->name);
+	} else if (extra_args.cat != NULL) {
+		node = extra_args.cat;
+		cil_tree_log(node, CIL_ERR,
+			     "Category %s not in categoryorder statement",
+			     DATUM(node->data)->name);
+	} else if (extra_args.sens != NULL) {
+		node = extra_args.sens;
+		cil_tree_log(node, CIL_ERR,
+			     "Sensitivity %s not in sensitivityorder statement",
+			     DATUM(node->data)->name);
+	} else {
+		return SEPOL_OK;
+	}
 
-	return rc;
+	/* Same trace as for a failing tree walk */
+	cil_tree_log(node, CIL_INFO, "Problem");
+
+	return SEPOL_ERR;
 }
 
 int __cil_verify_initsids(struct cil_list *sids)
diff --git a/libsepol/cil/src/cil_verify.h b/libsepol/cil/src/cil_verify.h
index 7852f570..f60bf9f3 100644
--- a/libsepol/cil/src/cil_verify.h
+++ b/libsepol/cil/src/cil_verify.h
@@ -74,9 +74,7 @@ int cil_verify_decl_does_not_shadow_macro_parameter(struct cil_macro *macro,
 int __cil_verify_ranges(struct cil_list *list);
 int cil_verify_completed_ordered_list(struct cil_list *complete,
 				      struct cil_list *ordered_lists);
-int __cil_verify_ordered_node_helper(struct cil_tree_node *node,
-				     uint32_t *finished, void *extra_args);
-int __cil_verify_ordered(struct cil_tree_node *current, enum cil_flavor flavor);
+int __cil_verify_ordered(struct cil_tree_node *current);
 int __cil_verify_initsids(struct cil_list *sids);
 int __cil_verify_senscat(struct cil_sens *sens, struct cil_cat *cat);
 int __cil_verify_helper(struct cil_tree_node *node,
-- 
2.55.0

