Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B903AC433F5
	for <selinux@archiver.kernel.org>; Wed, 19 Jan 2022 16:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356059AbiASQDt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jan 2022 11:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356028AbiASQDp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jan 2022 11:03:45 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121A5C061574
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 08:03:45 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p18so5932786wmg.4
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 08:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WspBGirnmTC3GntqfCuIm1l0CBNJ004WVOxA3ms/bVw=;
        b=mpgRkHDpMA8BE3Mwg8f+2OqtfLr81FPV/26pQofQ3Hd6K97TZ2R3U/SdemE/EQQhAj
         N9zl8psU91guda8cYqovisHuq3VQpsQhbT1BuVaKdaR5EluCaXvInq2IpmrG8zK5QHLo
         lx1Ku8j/6lu6GQnaQR3jlesrtuAkwywvM8yoTNZdeLgZNW4COt5mBHDnDN2gVaIBEB1f
         0I4ZLSXZorryFN2RfNgtzh/z0f6XkBXoIE/03V/vug8zdABFpHSo/c/cRcIPjfQ+/7ok
         Q+iWvXlhWyibIEwSTRoKz0UKvh7sMTexngJyCiYOV7FUbV85JQa6X3+CddvyDqwPQZ7i
         TpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WspBGirnmTC3GntqfCuIm1l0CBNJ004WVOxA3ms/bVw=;
        b=iyYRi+Mfvd11ho3FzKeGVl+9za6JlgcLs5VXVfyholeAwYLdlAWyg/KYKXauJRdNW5
         Ld3P5VL2cwrj4RRoUWr7gD1mGP+kxh+UT+nAgwhoI9v2fv8RtkfX7IX2ZVQa/8HTy/Im
         od4CQ8qrHubI4j9r+roeXWj3hyuET/xUv8kfPXEcwzUbhsueNXGsBfZaOMnSPYSd2sDY
         ocS1IW8+1qgft8JsdmwYmyja/0Sxzv4b7iISbynnzgRmJHvjgRWaFuh38CdXQL2Do/XW
         o00h6QM5ZHIRuuroE29xW+9xlGJyXoMu1dC6XfHdKrHrJh3VfzdLPMZ52k7wrFO/F6AH
         No+g==
X-Gm-Message-State: AOAM531Loh1CbayawgbcFjTIsQLuJ6qjSiwfyd5GFpgtDGanMabU9dau
        btlPii2mL6YdFFSwE1ptVChGjqylZvc=
X-Google-Smtp-Source: ABdhPJwXrKuFGHyY3Hw8n9h71JcGHEGu9hg11gv2hvLeLnF0Juswdz0WSuqbMyOQQOA/0ZowJtGZhg==
X-Received: by 2002:a05:6000:42:: with SMTP id k2mr4596822wrx.178.1642608223403;
        Wed, 19 Jan 2022 08:03:43 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-001-173-022.77.1.pool.telefonica.de. [77.1.173.22])
        by smtp.gmail.com with ESMTPSA id l20sm7683352wms.24.2022.01.19.08.03.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 08:03:42 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: drop trailing newlines in log messages
Date:   Wed, 19 Jan 2022 17:03:39 +0100
Message-Id: <20220119160339.12072-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The default log handler sepol_msg_default_handler() appends a newline
and the majority of log messages do not contain a trailing newline in
the format string.

Fixes: 5c178f9f55 ("libsepol: use logging framework in conditional.c")
Fixes: 852f14d43d ("libsepol: use logging framework in ebitmap.c")

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/avtab.c          |  2 +-
 libsepol/src/conditional.c    | 14 +++++++-------
 libsepol/src/context_record.c |  2 +-
 libsepol/src/ebitmap.c        | 20 ++++++++++----------
 libsepol/src/expand.c         |  8 ++++----
 libsepol/src/hierarchy.c      |  2 +-
 libsepol/src/link.c           | 16 ++++++++--------
 libsepol/src/services.c       |  2 +-
 8 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 9dc5d9f1..7920b60a 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -548,7 +548,7 @@ int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
 	if ((vers < POLICYDB_VERSION_XPERMS_IOCTL) &&
 			(key.specified & AVTAB_XPERMS)) {
 		ERR(fp->handle, "policy version %u does not support extended "
-				"permissions rules and one was specified\n", vers);
+				"permissions rules and one was specified", vers);
 		return -1;
 	} else if (key.specified & AVTAB_XPERMS) {
 		rc = next_entry(&buf8, fp, sizeof(uint8_t));
diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index a3125fdd..f78b38a2 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -315,7 +315,7 @@ static int evaluate_cond_node(policydb_t * p, cond_node_t * node)
 	if (new_state != node->cur_state) {
 		node->cur_state = new_state;
 		if (new_state == -1)
-			WARN(NULL, "expression result was undefined - disabling all rules.\n");
+			WARN(NULL, "expression result was undefined - disabling all rules.");
 		/* turn the rules on or off */
 		for (cur = node->true_list; cur != NULL; cur = cur->next) {
 			if (new_state <= 0) {
@@ -368,7 +368,7 @@ int cond_normalize_expr(policydb_t * p, cond_node_t * cn)
 		if (ne) {
 			ne->next = NULL;
 		} else {	/* ne should never be NULL */
-			ERR(NULL, "Found expr with no bools and only a ! - this should never happen.\n");
+			ERR(NULL, "Found expr with no bools and only a ! - this should never happen.");
 			return -1;
 		}
 		/* swap the true and false lists */
@@ -421,7 +421,7 @@ int cond_normalize_expr(policydb_t * p, cond_node_t * cn)
 			k = cond_evaluate_expr(p, cn->expr);
 			if (k == -1) {
 				ERR(NULL, "While testing expression, expression result "
-				     "was undefined - this should never happen.\n");
+				     "was undefined - this should never happen.");
 				return -1;
 			}
 			/* set the bit if expression evaluates true */
@@ -660,13 +660,13 @@ static int cond_insertf(avtab_t * a
 					}
 				}
 				if (!found) {
-					ERR(NULL, "security: conflicting type rules.\n");
+					ERR(NULL, "security: conflicting type rules.");
 					return -1;
 				}
 			}
 		} else {
 			if (avtab_search(&p->te_cond_avtab, k)) {
-				ERR(NULL, "security: conflicting type rules when adding type rule for true.\n");
+				ERR(NULL, "security: conflicting type rules when adding type rule for true.");
 				return -1;
 			}
 		}
@@ -733,12 +733,12 @@ static int cond_read_av_list(policydb_t * p, void *fp,
 static int expr_isvalid(policydb_t * p, cond_expr_t * expr)
 {
 	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
-		WARN(NULL, "security: conditional expressions uses unknown operator.\n");
+		WARN(NULL, "security: conditional expressions uses unknown operator.");
 		return 0;
 	}
 
 	if (expr->bool > p->p_bools.nprim) {
-		WARN(NULL, "security: conditional expressions uses unknown bool.\n");
+		WARN(NULL, "security: conditional expressions uses unknown bool.");
 		return 0;
 	}
 	return 1;
diff --git a/libsepol/src/context_record.c b/libsepol/src/context_record.c
index 435f7880..2bda121b 100644
--- a/libsepol/src/context_record.c
+++ b/libsepol/src/context_record.c
@@ -127,7 +127,7 @@ int sepol_context_create(sepol_handle_t * handle, sepol_context_t ** con_ptr)
 	    (sepol_context_t *) malloc(sizeof(sepol_context_t));
 
 	if (!con) {
-		ERR(handle, "out of memory, could not " "create context\n");
+		ERR(handle, "out of memory, could not create context");
 		return STATUS_ERR;
 	}
 
diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index fa728558..bd98c0f8 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -406,7 +406,7 @@ int ebitmap_read(ebitmap_t * e, void *fp)
 	count = le32_to_cpu(buf[2]);
 
 	if (mapsize != MAPSIZE) {
-		ERR(NULL, "security: ebitmap: map size %d does not match my size %zu (high bit was %d)\n",
+		ERR(NULL, "security: ebitmap: map size %d does not match my size %zu (high bit was %d)",
 		     mapsize, MAPSIZE, e->highbit);
 		goto bad;
 	}
@@ -415,7 +415,7 @@ int ebitmap_read(ebitmap_t * e, void *fp)
 		goto ok;
 	}
 	if (e->highbit & (MAPSIZE - 1)) {
-		ERR(NULL, "security: ebitmap: high bit (%d) is not a multiple of the map size (%zu)\n",
+		ERR(NULL, "security: ebitmap: high bit (%d) is not a multiple of the map size (%zu)",
 		     e->highbit, MAPSIZE);
 		goto bad;
 	}
@@ -427,12 +427,12 @@ int ebitmap_read(ebitmap_t * e, void *fp)
 	for (i = 0; i < count; i++) {
 		rc = next_entry(buf, fp, sizeof(uint32_t));
 		if (rc < 0) {
-			ERR(NULL, "security: ebitmap: truncated map\n");
+			ERR(NULL, "security: ebitmap: truncated map");
 			goto bad;
 		}
 		n = (ebitmap_node_t *) malloc(sizeof(ebitmap_node_t));
 		if (!n) {
-			ERR(NULL, "security: ebitmap: out of memory\n");
+			ERR(NULL, "security: ebitmap: out of memory");
 			rc = -ENOMEM;
 			goto bad;
 		}
@@ -441,30 +441,30 @@ int ebitmap_read(ebitmap_t * e, void *fp)
 		n->startbit = le32_to_cpu(buf[0]);
 
 		if (n->startbit & (MAPSIZE - 1)) {
-			ERR(NULL, "security: ebitmap start bit (%d) is not a multiple of the map size (%zu)\n",
+			ERR(NULL, "security: ebitmap start bit (%d) is not a multiple of the map size (%zu)",
 			     n->startbit, MAPSIZE);
 			goto bad_free;
 		}
 		if (n->startbit > (e->highbit - MAPSIZE)) {
-			ERR(NULL, "security: ebitmap start bit (%d) is beyond the end of the bitmap (%zu)\n",
+			ERR(NULL, "security: ebitmap start bit (%d) is beyond the end of the bitmap (%zu)",
 			     n->startbit, (e->highbit - MAPSIZE));
 			goto bad_free;
 		}
 		rc = next_entry(&map, fp, sizeof(uint64_t));
 		if (rc < 0) {
-			ERR(NULL, "security: ebitmap: truncated map\n");
+			ERR(NULL, "security: ebitmap: truncated map");
 			goto bad_free;
 		}
 		n->map = le64_to_cpu(map);
 
 		if (!n->map) {
-			ERR(NULL, "security: ebitmap: null map in ebitmap (startbit %d)\n",
+			ERR(NULL, "security: ebitmap: null map in ebitmap (startbit %d)",
 			     n->startbit);
 			goto bad_free;
 		}
 		if (l) {
 			if (n->startbit <= l->startbit) {
-				ERR(NULL, "security: ebitmap: start bit %d comes after start bit %d\n",
+				ERR(NULL, "security: ebitmap: start bit %d comes after start bit %d",
 				     n->startbit, l->startbit);
 				goto bad_free;
 			}
@@ -475,7 +475,7 @@ int ebitmap_read(ebitmap_t * e, void *fp)
 		l = n;
 	}
 	if (count && l->startbit + MAPSIZE != e->highbit) {
-		ERR(NULL, "security: ebitmap: high bit %u has not the expected value %zu\n",
+		ERR(NULL, "security: ebitmap: high bit %u has not the expected value %zu",
 		     e->highbit, l->startbit + MAPSIZE);
 		goto bad;
 	}
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 898e6b87..6d4384ae 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -166,7 +166,7 @@ static int type_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 
 	if (new_type->flags & TYPE_FLAGS_PERMISSIVE)
 		if (ebitmap_set_bit(&state->out->permissive_map, new_type->s.value, 1)) {
-			ERR(state->handle, "Out of memory!\n");
+			ERR(state->handle, "Out of memory!");
 			return -1;
 		}
 
@@ -937,7 +937,7 @@ int mls_semantic_level_expand(mls_semantic_level_t * sl, mls_level_t * l,
 	levdatum = (level_datum_t *) hashtab_search(p->p_levels.table,
 						    p->p_sens_val_to_name[l->sens - 1]);
 	if (!levdatum) {
-		ERR(h, "%s: Impossible situation found, nothing in p_levels.table.\n",
+		ERR(h, "%s: Impossible situation found, nothing in p_levels.table.",
 		    __func__);
 		errno = ENOENT;
 		return -1;
@@ -1694,7 +1694,7 @@ static int expand_terule_helper(sepol_handle_t * handle,
 	uint32_t oldtype = 0;
 
 	if (!(specified & (AVRULE_TRANSITION|AVRULE_MEMBER|AVRULE_CHANGE))) {
-		ERR(handle, "Invalid specification: %"PRIu32"\n", specified);
+		ERR(handle, "Invalid specification: %"PRIu32, specified);
 		return EXPAND_RULE_ERROR;
 	}
 
@@ -1873,7 +1873,7 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 				return EXPAND_RULE_ERROR;
 			break;
 		default:
-			ERR(handle, "Unknown specification: %"PRIu32"\n", specified);
+			ERR(handle, "Unknown specification: %"PRIu32, specified);
 			return EXPAND_RULE_ERROR;
 		}
 
diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
index 8919daa7..350443a8 100644
--- a/libsepol/src/hierarchy.c
+++ b/libsepol/src/hierarchy.c
@@ -237,7 +237,7 @@ oom:
 	ERR(handle, "Insufficient memory");
 
 exit:
-	ERR(handle,"Failed to expand parent rules\n");
+	ERR(handle,"Failed to expand parent rules");
 	avtab_destroy(global_avtab);
 	bounds_destroy_cond_info(*cond_info);
 	*cond_info = NULL;
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index dfcb0673..21a5a935 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -165,7 +165,7 @@ static int permission_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 					     (hashtab_datum_t) new_perm);
 			if (ret) {
 				ERR(state->handle,
-				    "could not insert permission into class\n");
+				    "could not insert permission into class");
 				goto err;
 			}
 			new_perm->s.value = dest_class->permissions.nprim + 1;
@@ -289,7 +289,7 @@ static int class_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			new_class =
 			    (class_datum_t *) calloc(1, sizeof(class_datum_t));
 			if (new_class == NULL) {
-				ERR(state->handle, "Memory error\n");
+				ERR(state->handle, "Memory error");
 				ret = SEPOL_ERR;
 				goto err;
 			}
@@ -300,7 +300,7 @@ static int class_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			}
 			new_id = strdup(id);
 			if (new_id == NULL) {
-				ERR(state->handle, "Memory error\n");
+				ERR(state->handle, "Memory error");
 				symtab_destroy(&new_class->permissions);
 				ret = SEPOL_ERR;
 				goto err;
@@ -696,7 +696,7 @@ static int sens_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			return SEPOL_ENOTSUP;
 		} else {
 			ERR(state->handle,
-			    "%s: has an unknown scope: %d\n",
+			    "%s: has an unknown scope: %d",
 			    state->cur_mod_name, scope->scope);
 			return SEPOL_ENOTSUP;
 		}
@@ -738,7 +738,7 @@ static int cat_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		} else {
 			/* unknown scope?  malformed policy? */
 			ERR(state->handle,
-			    "%s: has an unknown scope: %d\n",
+			    "%s: has an unknown scope: %d",
 			    state->cur_mod_name, scope->scope);
 			return SEPOL_ENOTSUP;
 		}
@@ -1781,7 +1781,7 @@ static int copy_avrule_block(link_state_t * state, policy_module_t * module,
 		if (module->policy->name != NULL) {
 			new_decl->module_name = strdup(module->policy->name);
 			if (new_decl->module_name == NULL) {
-				ERR(state->handle, "Out of memory\n");
+				ERR(state->handle, "Out of memory");
 				avrule_decl_destroy(new_decl);
 				ret = -1;
 				goto cleanup;
@@ -2208,7 +2208,7 @@ static int enable_avrules(link_state_t * state, policydb_t * pol)
 			if (state->verbose) {
 				const char *mod_name = decl->module_name ?
 				    decl->module_name : "BASE";
-				INFO(state->handle, "check module %s decl %d\n",
+				INFO(state->handle, "check module %s decl %d",
 				     mod_name, decl->decl_id);
 			}
 			rc = is_decl_requires_met(state, decl, &req);
@@ -2554,7 +2554,7 @@ int link_modules(sepol_handle_t * handle,
 
 		if (mods[i]->policyvers > b->policyvers) {
 			WARN(state.handle,
-			     "Upgrading policy version from %u to %u\n", b->policyvers, mods[i]->policyvers);
+			     "Upgrading policy version from %u to %u", b->policyvers, mods[i]->policyvers);
 			b->policyvers = mods[i]->policyvers;
 		}
 
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 0f36ac53..7becfd1b 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1553,7 +1553,7 @@ static int validate_class(hashtab_key_t key, hashtab_datum_t datum, void *p)
 		     cladatum2->comdatum->permissions.table)) {
 			ERR(NULL,
 			    " in the access vector definition "
-			    "for class %s\n", key);
+			    "for class %s", key);
 			return -1;
 		}
 	}
-- 
2.34.1

