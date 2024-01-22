Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F7F3D0BE
	for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931720; cv=none; b=TLc/GT2gmPjPeeQib4nCM19FcBDuDuI1WW6Ui4hTfZUu0+oe1KhxcNEgBMHqTWgBfBZcU/HpYqjIoUljABOwWE6b8/GoSSZF+czH9CuPwgQ+vibG1Z3i04fH2wsVUKpaYhxfzCtofQloxwW0hQC4AP7f+hXARiJOOCWEOduzP4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931720; c=relaxed/simple;
	bh=Xrp9Oy32nzN35jMJpO+aqdjoHaCujKlOjNS46O9SIVQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfjKum7MBCVrj6CQABerg/g4kcSXPFIchbji3hnxHMcVEwKGNIo8TJAu6SMqhGjU5+9bycmB928NNTJ0GKtNRHpvTvw1T1XdZ4CY3jHcmbsX49sSzBG+D4NZzs812T7JUf4o3tiZjmmVxAJq7UNAyQHVcJ6wWMIhYlS1xtdeIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=XNCKltO0; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XNCKltO0"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50eaaf2c7deso3435300e87.2
        for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 05:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705931717; x=1706536517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yB/h2/SQ3UkwWaSlfaTnCJ7BDrE3uw0fRC78I7/fNVQ=;
        b=XNCKltO0zbsQL5ojkDOC8gJ4jW2yDEwTyVfbCMfza+QJBi1QR6RJj/c9P1NlH9++Dc
         cLQLODzF8hORA5HPgz2xQYulOfMuiMMgaATtUx+AhniprvIlIc+ByNip/ofbPi+ya4XF
         4J4aijruwwYccuHVgDwIwLVaeTahI+WgfaMzpOaGG20kjZowdFHKUZG5A0H+QW0jL/HX
         iTN/arFpH5i6OSNfYXLhbSrv7ynC/1UuT/NIqshtJ8rFA1xyF9txCV8Vhs0XRZ+ttHGf
         /cB7dYNhbBi//v7cT8REuzSSBeaa0zGWUgw+2+ks7VkxvFtWh9i9MyY4pV7F717L6N4P
         COpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931717; x=1706536517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yB/h2/SQ3UkwWaSlfaTnCJ7BDrE3uw0fRC78I7/fNVQ=;
        b=uOf0T/a4BZVq10gABmdfipsMYxp/5qMondgA7IVFSKhalLPNA4EGMMAzRFxeRz+2C2
         6H+okhXGDzJkvB8cpgrqF9+Kh71tk5bGC4fhAByAYUpY66FqeM5JMIoATFl6zJkyklqd
         tvhlCVpvYX2oeWj7sTrU5YAnXZaHKi1rbE1vvKjMnLUsa6rMyxyCxYHn6bHPbYyfiFIF
         hzS7nkCK2ICmK3z21Ql0LzwwMTmTRM1mhBwljNxItnJfuP/bKJ+8cdwEbhtDavRUxnxb
         MMHa48c8TNvpioujIzo2lofv8AZA7T4Xpm/C6VPKzv9KpcdUJOw9Vf8UpcmdiRUEhHpK
         VQmA==
X-Gm-Message-State: AOJu0YwpM3RpqM1OjJaVkWs531aLd+8HhIrcaMSvuqjGkvaQEL9ZoXDp
	hVm/2iydzpUH+dxvuTd2P0VuTLNK5mLtmobKvUz4V4wL71lbgIs8gCuUN9JU
X-Google-Smtp-Source: AGHT+IHlAbxX8jnQzVE+BeQui1FVmlNnlu3j/U+mlEGm+CtYNEcA3yxEKd9Uoip/efTooYFgoaNVdg==
X-Received: by 2002:a05:6512:ac2:b0:50e:9dbe:e563 with SMTP id n2-20020a0565120ac200b0050e9dbee563mr2158907lfu.77.1705931716859;
        Mon, 22 Jan 2024 05:55:16 -0800 (PST)
Received: from ddev.DebianHome (dynamic-077-003-088-202.77.3.pool.telefonica.de. [77.3.88.202])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b00a28825e0a2bsm13340284ejh.22.2024.01.22.05.55.16
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:55:16 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 06/15] checkpolicy: clean expression on error
Date: Mon, 22 Jan 2024 14:54:58 +0100
Message-ID: <20240122135507.63506-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122135507.63506-1-cgzones@googlemail.com>
References: <20240122135507.63506-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The passed expression needs to be transferred into the policy or free'd
by the sink functions define_constraint() and define_validatetrans().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 68 ++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index ec19da9d..97582630 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3428,20 +3428,22 @@ int define_constraint(constraint_expr_t * expr)
 		return 0;
 	}
 
+	ebitmap_init(&classmap);
+
 	depth = -1;
 	for (e = expr; e; e = e->next) {
 		switch (e->expr_type) {
 		case CEXPR_NOT:
 			if (depth < 0) {
 				yyerror("illegal constraint expression");
-				return -1;
+				goto bad;
 			}
 			break;
 		case CEXPR_AND:
 		case CEXPR_OR:
 			if (depth < 1) {
 				yyerror("illegal constraint expression");
-				return -1;
+				goto bad;
 			}
 			depth--;
 			break;
@@ -3449,51 +3451,48 @@ int define_constraint(constraint_expr_t * expr)
 		case CEXPR_NAMES:
 			if (e->attr & CEXPR_XTARGET) {
 				yyerror("illegal constraint expression");
-				return -1;	/* only for validatetrans rules */
+				goto bad;	/* only for validatetrans rules */
 			}
 			if (depth == (CEXPR_MAXDEPTH - 1)) {
 				yyerror("constraint expression is too deep");
-				return -1;
+				goto bad;
 			}
 			depth++;
 			break;
 		default:
 			yyerror("illegal constraint expression");
-			return -1;
+			goto bad;
 		}
 	}
 	if (depth != 0) {
 		yyerror("illegal constraint expression");
-		return -1;
+		goto bad;
 	}
 
-	ebitmap_init(&classmap);
 	while ((id = queue_remove(id_queue))) {
 		if (!is_id_in_scope(SYM_CLASSES, id)) {
 			yyerror2("class %s is not within scope", id);
 			free(id);
-			return -1;
+			goto bad;
 		}
 		cladatum =
 		    (class_datum_t *) hashtab_search(policydbp->p_classes.table,
 						     (hashtab_key_t) id);
 		if (!cladatum) {
 			yyerror2("class %s is not defined", id);
-			ebitmap_destroy(&classmap);
 			free(id);
-			return -1;
+			goto bad;
 		}
 		if (ebitmap_set_bit(&classmap, cladatum->s.value - 1, TRUE)) {
 			yyerror("out of memory");
-			ebitmap_destroy(&classmap);
 			free(id);
-			return -1;
+			goto bad;
 		}
 		node = malloc(sizeof(struct constraint_node));
 		if (!node) {
 			yyerror("out of memory");
 			free(node);
-			return -1;
+			goto bad;
 		}
 		memset(node, 0, sizeof(constraint_node_t));
 		if (useexpr) {
@@ -3505,7 +3504,7 @@ int define_constraint(constraint_expr_t * expr)
 		if (!node->expr) {
 			yyerror("out of memory");
 			free(node);
-			return -1;
+			goto bad;
 		}
 		node->permissions = 0;
 
@@ -3557,8 +3556,7 @@ int define_constraint(constraint_expr_t * expr)
 					yyerror2("permission %s is not"
 						 " defined for class %s", id, policydbp->p_class_val_to_name[i]);
 					free(id);
-					ebitmap_destroy(&classmap);
-					return -1;
+					goto bad;
 				}
 			}
 			node->permissions |= (UINT32_C(1) << (perdatum->s.value - 1));
@@ -3569,6 +3567,13 @@ int define_constraint(constraint_expr_t * expr)
 	ebitmap_destroy(&classmap);
 
 	return 0;
+
+bad:
+	ebitmap_destroy(&classmap);
+	if (useexpr)
+		constraint_expr_destroy(expr);
+
+	return -1;
 }
 
 int define_validatetrans(constraint_expr_t * expr)
@@ -3587,20 +3592,22 @@ int define_validatetrans(constraint_expr_t * expr)
 		return 0;
 	}
 
+	ebitmap_init(&classmap);
+
 	depth = -1;
 	for (e = expr; e; e = e->next) {
 		switch (e->expr_type) {
 		case CEXPR_NOT:
 			if (depth < 0) {
 				yyerror("illegal validatetrans expression");
-				return -1;
+				goto bad;
 			}
 			break;
 		case CEXPR_AND:
 		case CEXPR_OR:
 			if (depth < 1) {
 				yyerror("illegal validatetrans expression");
-				return -1;
+				goto bad;
 			}
 			depth--;
 			break;
@@ -3608,47 +3615,45 @@ int define_validatetrans(constraint_expr_t * expr)
 		case CEXPR_NAMES:
 			if (depth == (CEXPR_MAXDEPTH - 1)) {
 				yyerror("validatetrans expression is too deep");
-				return -1;
+				goto bad;
 			}
 			depth++;
 			break;
 		default:
 			yyerror("illegal validatetrans expression");
-			return -1;
+			goto bad;
 		}
 	}
 	if (depth != 0) {
 		yyerror("illegal validatetrans expression");
-		return -1;
+		goto bad;
 	}
 
-	ebitmap_init(&classmap);
 	while ((id = queue_remove(id_queue))) {
 		if (!is_id_in_scope(SYM_CLASSES, id)) {
 			yyerror2("class %s is not within scope", id);
 			free(id);
-			return -1;
+			goto bad;
 		}
 		cladatum =
 		    (class_datum_t *) hashtab_search(policydbp->p_classes.table,
 						     (hashtab_key_t) id);
 		if (!cladatum) {
 			yyerror2("class %s is not defined", id);
-			ebitmap_destroy(&classmap);
 			free(id);
-			return -1;
+			goto bad;
 		}
 		if (ebitmap_set_bit(&classmap, (cladatum->s.value - 1), TRUE)) {
 			yyerror("out of memory");
-			ebitmap_destroy(&classmap);
 			free(id);
-			return -1;
+			goto bad;
 		}
 
 		node = malloc(sizeof(struct constraint_node));
 		if (!node) {
 			yyerror("out of memory");
-			return -1;
+			free(id);
+			goto bad;
 		}
 		memset(node, 0, sizeof(constraint_node_t));
 		if (useexpr) {
@@ -3668,6 +3673,13 @@ int define_validatetrans(constraint_expr_t * expr)
 	ebitmap_destroy(&classmap);
 
 	return 0;
+
+bad:
+	ebitmap_destroy(&classmap);
+	if (useexpr)
+		constraint_expr_destroy(expr);
+
+	return -1;
 }
 
 uintptr_t define_cexpr(uint32_t expr_type, uintptr_t arg1, uintptr_t arg2)
-- 
2.43.0

