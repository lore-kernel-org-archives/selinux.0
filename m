Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CA6C43332
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 22:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F0D64FF1
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 22:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhBEW3S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhBEOUK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Feb 2021 09:20:10 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFD3C061D7E
        for <selinux@vger.kernel.org>; Fri,  5 Feb 2021 07:57:50 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id t17so5294468qtq.2
        for <selinux@vger.kernel.org>; Fri, 05 Feb 2021 07:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uc7rlwZTY3BrLCjYbLnoh7heWRZl5OO1yNXmDnxMCwI=;
        b=Elg5O3B/CPluEJPhvlT0yudW+VvhjKbyDQobfZUxUYvJW5DWrvLNHRiKL9dYSkWmzZ
         hRNSb/KHZr5GCWQp+vePJ0sHRNWnt8ZSrrnV+cOODzaS3ERt9Hkz76RvsCI2nZ+FklSs
         ikzmaw4y1NzXA71TDZ1wzkWplcALBJUL022pVHidtsihBO26/Sz0S0HIfsB+uBuUktuD
         pyl5hdE0eMD9+flIo/RjCcBE5wqgG75Pu9rVxtRJkSQtdtz94nR/1LfISuW/4as+hE6N
         FfmMQJZMONGV1tMOmNeSzDhvCjpEKJavW8CBd2/weGphRluATwqhRiNVVBfB1oE0+jZu
         27bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uc7rlwZTY3BrLCjYbLnoh7heWRZl5OO1yNXmDnxMCwI=;
        b=hUHyvO0marG9WRD27ZqavMt/Apwgg9db9Pmo5R/l/C8YcYRznvjVoU99eEV8zWSmGU
         yRkwrv7mMxg4iaAsh5rCLFwtcgQTWfSYzLwauSbj9z9CDMlZmd3HDymZg5dZD9Hg6kjL
         +BuX71XYbgvW/aWKdDqnQrAIXQIf8DCKGqVQpEBzb6QhKNfXLaiUflx0PCblE33YXNP1
         574sHwyf4kmzx/9+JM3AzUFkNBUnTHTGdKYcI8cuXg7gw85ilbzXI6RA4xUepG9hkCbC
         h4pTG0zHNBxnc12TIriTG8/WB2wjog9dhQQqHmZh/8UCGH0GE3jASNvbODgIR5b2xz5H
         bivQ==
X-Gm-Message-State: AOAM531kpVEOnIe6GSptsiCuNH5qEvrQ8Upv4IpJNlbvIjNZ/mrbWh7r
        eSjanuKNsUilCbkLhGaqUUQ47BrqYJUJxg==
X-Google-Smtp-Source: ABdhPJzeD5vVboKruPGpWgmqj/tjqyJh1Ytjq5Xb/wMyEOEJ2ODiO2T7jctQo+oFUKRwoBxYvIYwtQ==
X-Received: by 2002:a37:5d07:: with SMTP id r7mr4313356qkb.335.1612534097256;
        Fri, 05 Feb 2021 06:08:17 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id c12sm8079219qtq.76.2021.02.05.06.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:08:16 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] libsepol: Validate policydb values when reading binary policy
Date:   Fri,  5 Feb 2021 09:08:00 -0500
Message-Id: <20210205140800.275993-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210205140800.275993-1-jwcart2@gmail.com>
References: <20210205140800.275993-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss reports that fuzzing /usr/libexec/hll/pp with the
American Fuzzy Lop revealed that inconsistent policy modules could be
created that caused NULL dereferences and other problems.

When reading in a binary modular or kernel policy, check values in the
policydb to verify consistency. When reading in the data for commons,
classes, roles, types, users, booleans, sensitivities, and categories
verify that their value is between 1 and the number of primary
identifiers (value-1 is used to index the sym_val_to_name array for
all of these and the val_to_struct array for classes, roles, users,
and types.) Next all references in policy rules are checked to ensure
that they refer to a valid value.

It is possible for the type and role struct and name arrays to have
gaps in them. For roles, there will be gaps in the case of a kernel
policy created from a policy with role attributes, but nothing in the
policy will refer to any of the gaps. For types, there will be gaps
for any kernel policy with a version from 20 to 23, but, unfortunately,
there will be references to the gaps. This is because, while attributes
exist in these policies, they only exist in the type_attr_map. For
policies with versions between 20 and 23, it must be assumed that all
of the gaps and any references to them are valid. To check for
references to gaps, bitmaps are created to map where the gaps are and
all values are verified to be within the proper range and not within a
gap.

Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb.c          |  35 +-
 libsepol/src/policydb_validate.c | 764 +++++++++++++++++++++++++++++++
 libsepol/src/policydb_validate.h |   7 +
 3 files changed, 794 insertions(+), 12 deletions(-)
 create mode 100644 libsepol/src/policydb_validate.c
 create mode 100644 libsepol/src/policydb_validate.h

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 157569db..ffa27971 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -54,6 +54,7 @@
 #include "private.h"
 #include "debug.h"
 #include "mls.h"
+#include "policydb_validate.h"
 
 #define POLICYDB_TARGET_SZ   ARRAY_SIZE(policydb_target_strings)
 const char *policydb_target_strings[] = { POLICYDB_STRING, POLICYDB_XEN_STRING };
@@ -993,7 +994,7 @@ static int common_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
 
 	comdatum = (common_datum_t *) datum;
 	p = (policydb_t *) datap;
-	if (!comdatum->s.value || comdatum->s.value > p->p_commons.nprim)
+	if (!value_isvalid(comdatum->s.value, p->p_commons.nprim))
 		return -EINVAL;
 	if (p->p_common_val_to_name[comdatum->s.value - 1] != NULL)
 		return -EINVAL;
@@ -1009,7 +1010,7 @@ static int class_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
 
 	cladatum = (class_datum_t *) datum;
 	p = (policydb_t *) datap;
-	if (!cladatum->s.value || cladatum->s.value > p->p_classes.nprim)
+	if (!value_isvalid(cladatum->s.value, p->p_classes.nprim))
 		return -EINVAL;
 	if (p->p_class_val_to_name[cladatum->s.value - 1] != NULL)
 		return -EINVAL;
@@ -1026,7 +1027,7 @@ static int role_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
 
 	role = (role_datum_t *) datum;
 	p = (policydb_t *) datap;
-	if (!role->s.value || role->s.value > p->p_roles.nprim)
+	if (!value_isvalid(role->s.value, p->p_roles.nprim))
 		return -EINVAL;
 	if (p->p_role_val_to_name[role->s.value - 1] != NULL)
 		return -EINVAL;
@@ -1045,7 +1046,7 @@ static int type_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
 	p = (policydb_t *) datap;
 
 	if (typdatum->primary) {
-		if (!typdatum->s.value || typdatum->s.value > p->p_types.nprim)
+		if (!value_isvalid(typdatum->s.value, p->p_types.nprim))
 			return -EINVAL;
 		if (p->p_type_val_to_name[typdatum->s.value - 1] != NULL)
 			return -EINVAL;
@@ -1064,7 +1065,7 @@ static int user_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
 	usrdatum = (user_datum_t *) datum;
 	p = (policydb_t *) datap;
 
-	if (!usrdatum->s.value || usrdatum->s.value > p->p_users.nprim)
+	if (!value_isvalid(usrdatum->s.value, p->p_users.nprim))
 		return -EINVAL;
 	if (p->p_user_val_to_name[usrdatum->s.value - 1] != NULL)
 		return -EINVAL;
@@ -1083,8 +1084,7 @@ static int sens_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
 	p = (policydb_t *) datap;
 
 	if (!levdatum->isalias) {
-		if (!levdatum->level->sens ||
-		    levdatum->level->sens > p->p_levels.nprim)
+		if (!value_isvalid(levdatum->level->sens, p->p_levels.nprim))
 			return -EINVAL;
 		if (p->p_sens_val_to_name[levdatum->level->sens - 1] != NULL)
 			return -EINVAL;
@@ -1103,7 +1103,7 @@ static int cat_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
 	p = (policydb_t *) datap;
 
 	if (!catdatum->isalias) {
-		if (!catdatum->s.value || catdatum->s.value > p->p_cats.nprim)
+		if (!value_isvalid(catdatum->s.value, p->p_cats.nprim))
 			return -EINVAL;
 		if (p->p_cat_val_to_name[catdatum->s.value - 1] != NULL)
 			return -EINVAL;
@@ -1190,7 +1190,7 @@ int policydb_index_decls(sepol_handle_t * handle, policydb_t * p)
 	for (curblock = p->global; curblock != NULL; curblock = curblock->next) {
 		for (decl = curblock->branch_list; decl != NULL;
 		     decl = decl->next) {
-			if (decl->decl_id < 1 || decl->decl_id > num_decls) {
+			if (!value_isvalid(decl->decl_id, num_decls)) {
 				ERR(handle, "invalid decl ID %u", decl->decl_id);
 				return -1;
 			}
@@ -2060,7 +2060,7 @@ static int context_read_and_validate(context_struct_t * c,
 
 static int perm_read(policydb_t * p
 		     __attribute__ ((unused)), hashtab_t h,
-		     struct policy_file *fp)
+		     struct policy_file *fp, uint32_t nprim)
 {
 	char *key = 0;
 	perm_datum_t *perdatum;
@@ -2081,6 +2081,8 @@ static int perm_read(policydb_t * p
 		goto bad;
 
 	perdatum->s.value = le32_to_cpu(buf[1]);
+	if (!value_isvalid(perdatum->s.value, nprim))
+		goto bad;
 
 	if (hashtab_insert(h, key, perdatum))
 		goto bad;
@@ -2129,7 +2131,7 @@ static int common_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 	key[len] = 0;
 
 	for (i = 0; i < nel; i++) {
-		if (perm_read(p, comdatum->permissions.table, fp))
+		if (perm_read(p, comdatum->permissions.table, fp, comdatum->permissions.nprim))
 			goto bad;
 	}
 
@@ -2295,7 +2297,7 @@ static int class_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 		}
 	}
 	for (i = 0; i < nel; i++) {
-		if (perm_read(p, cladatum->permissions.table, fp))
+		if (perm_read(p, cladatum->permissions.table, fp, cladatum->permissions.nprim))
 			goto bad;
 	}
 
@@ -3631,12 +3633,18 @@ static int range_read(policydb_t * p, struct policy_file *fp)
 		if (rc < 0)
 			goto err;
 		rt->source_type = le32_to_cpu(buf[0]);
+		if (!value_isvalid(rt->source_type, p->p_types.nprim))
+			goto err;
 		rt->target_type = le32_to_cpu(buf[1]);
+		if (!value_isvalid(rt->target_type, p->p_types.nprim))
+			goto err;
 		if (new_rangetr) {
 			rc = next_entry(buf, fp, (sizeof(uint32_t)));
 			if (rc < 0)
 				goto err;
 			rt->target_class = le32_to_cpu(buf[0]);
+			if (!value_isvalid(rt->target_class, p->p_classes.nprim))
+				goto err;
 		} else
 			rt->target_class = p->process_class;
 		r = calloc(1, sizeof(*r));
@@ -4544,6 +4552,9 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		}
 	}
 
+	if (validate_policydb(fp->handle, p))
+		goto bad;
+
 	return POLICYDB_SUCCESS;
       bad:
 	return POLICYDB_ERROR;
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
new file mode 100644
index 00000000..9ba062b7
--- /dev/null
+++ b/libsepol/src/policydb_validate.c
@@ -0,0 +1,764 @@
+
+#include <sepol/policydb/conditional.h>
+#include <sepol/policydb/ebitmap.h>
+#include <sepol/policydb/policydb.h>
+
+#include "debug.h"
+#include "policydb_validate.h"
+
+typedef struct validate {
+	uint32_t nprim;
+	ebitmap_t gaps;
+} validate_t;
+
+
+static int create_gap_ebitmap(char **val_to_name, uint32_t nprim, ebitmap_t *gaps)
+{
+	unsigned int i;
+
+	ebitmap_init(gaps);
+
+	for (i = 0; i < nprim; i++) {
+		if (!val_to_name[i]) {
+			if (ebitmap_set_bit(gaps, i, 1))
+				return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int validate_init(validate_t *flavor, char **val_to_name, uint32_t nprim)
+{
+	flavor->nprim = nprim;
+	if (create_gap_ebitmap(val_to_name, nprim, &flavor->gaps))
+		return -1;
+
+	return 0;
+}
+
+static int validate_array_init(policydb_t *p, validate_t flavors[])
+{
+	if (validate_init(&flavors[SYM_CLASSES], p->p_class_val_to_name, p->p_classes.nprim))
+		goto bad;
+	if (validate_init(&flavors[SYM_ROLES], p->p_role_val_to_name, p->p_roles.nprim))
+		goto bad;
+	if (p->policyvers < POLICYDB_VERSION_AVTAB || p->policyvers > POLICYDB_VERSION_PERMISSIVE) {
+		if (validate_init(&flavors[SYM_TYPES], p->p_type_val_to_name, p->p_types.nprim))
+			goto bad;
+	} else {
+		/*
+		 * For policy versions between 20 and 23, attributes exist in the policy,
+		 * but they only exist in the type_attr_map, so there will be references
+		 * to gaps and we just have to treat this case as if there were no gaps.
+		 */
+		flavors[SYM_TYPES].nprim = p->p_types.nprim;
+		ebitmap_init(&flavors[SYM_TYPES].gaps);
+	}
+	if (validate_init(&flavors[SYM_USERS], p->p_user_val_to_name, p->p_users.nprim))
+		goto bad;
+	if (validate_init(&flavors[SYM_BOOLS], p->p_bool_val_to_name, p->p_bools.nprim))
+		goto bad;
+	if (validate_init(&flavors[SYM_LEVELS], p->p_sens_val_to_name, p->p_levels.nprim))
+		goto bad;
+	if (validate_init(&flavors[SYM_CATS], p->p_cat_val_to_name, p->p_cats.nprim))
+		goto bad;
+
+	return 0;
+
+bad:
+	return -1;
+}
+
+/*
+ * Functions to validate both kernel and module policydbs
+ */
+
+int value_isvalid(uint32_t value, uint32_t nprim)
+{
+	if (!value || value > nprim)
+		return 0;
+
+	return 1;
+}
+
+static int validate_value(uint32_t value, validate_t *flavor)
+{
+	if (!value || value > flavor->nprim)
+		goto bad;
+	if (ebitmap_get_bit(&flavor->gaps, value-1))
+		goto bad;
+
+	return 0;
+
+bad:
+	return -1;
+}
+
+static int validate_ebitmap(ebitmap_t *map, validate_t *flavor)
+{
+	if (ebitmap_length(map) > 0 && ebitmap_highest_set_bit(map) >= flavor->nprim)
+		goto bad;
+	if (ebitmap_match_any(map, &flavor->gaps))
+		goto bad;
+
+	return 0;
+
+bad:
+	return -1;
+}
+
+static int validate_type_set(type_set_t *type_set, validate_t *type)
+{
+	if (validate_ebitmap(&type_set->types, type))
+		goto bad;
+	if (validate_ebitmap(&type_set->negset, type))
+		goto bad;
+
+	return 0;
+
+bad:
+	return -1;
+}
+
+static int validate_role_set(role_set_t *role_set, validate_t *role)
+{
+	if (validate_ebitmap(&role_set->roles, role))
+		return -1;
+
+	return 0;
+}
+
+static int validate_scope(__attribute__ ((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	scope_datum_t *scope_datum = (scope_datum_t *)d;
+	uint32_t *nprim = (uint32_t *)args;
+	unsigned int i;
+
+	for (i = 0; i < scope_datum->decl_ids_len; i++) {
+		if (!value_isvalid(scope_datum->decl_ids[i], *nprim))
+			return -1;
+	}
+
+	return 0;
+}
+
+static int validate_scopes(sepol_handle_t *handle, symtab_t scopes[], avrule_block_t *block)
+{
+	avrule_decl_t *decl;
+	unsigned int i;
+	unsigned int num_decls = 0;
+
+	for (; block != NULL; block = block->next) {
+		for (decl = block->branch_list; decl; decl = decl->next) {
+			num_decls++;
+		}
+	}
+
+	for (i = 0; i < SYM_NUM; i++) {
+		if (hashtab_map(scopes[i].table, validate_scope, &num_decls))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid scope");
+	return -1;	
+}
+
+static int validate_constraint_nodes(sepol_handle_t *handle, constraint_node_t *cons, validate_t flavors[])
+{
+	constraint_expr_t *cexp;
+
+	for (; cons; cons = cons->next) {
+		for (cexp = cons->expr; cexp; cexp = cexp->next) {
+			if (cexp->attr & CEXPR_USER) {
+				if (validate_ebitmap(&cexp->names, &flavors[SYM_USERS]))
+					goto bad;
+			} else if (cexp->attr & CEXPR_ROLE) {
+				if (validate_ebitmap(&cexp->names, &flavors[SYM_ROLES]))
+					goto bad;
+			} else if (cexp->attr & CEXPR_TYPE) {
+				if (validate_ebitmap(&cexp->names, &flavors[SYM_TYPES]))
+					goto bad;
+				if (validate_type_set(cexp->type_names, &flavors[SYM_TYPES]))
+					goto bad;
+			}
+		}
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid constraint expr");
+	return -1;
+}
+
+static int validate_class_datum(sepol_handle_t *handle, class_datum_t *class, validate_t flavors[])
+{
+	if (validate_value(class->s.value, &flavors[SYM_CLASSES]))
+		goto bad;
+	if (validate_constraint_nodes(handle, class->constraints, flavors))
+		goto bad;
+	if (validate_constraint_nodes(handle, class->validatetrans, flavors))
+		goto bad;
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid class datum");
+	return -1;
+}
+
+static int validate_role_datum(sepol_handle_t *handle, role_datum_t *role, validate_t flavors[])
+{
+	if (validate_value(role->s.value, &flavors[SYM_ROLES]))
+		goto bad;
+	if (validate_ebitmap(&role->dominates, &flavors[SYM_ROLES]))
+		goto bad;
+	if (validate_type_set(&role->types, &flavors[SYM_TYPES]))
+		goto bad;
+	if (role->bounds && validate_value(role->bounds, &flavors[SYM_ROLES]))
+		goto bad;
+	if (validate_ebitmap(&role->roles, &flavors[SYM_ROLES]))
+		goto bad;
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid class datum");
+	return -1;
+}
+
+static int validate_type_datum(sepol_handle_t *handle, type_datum_t *type, validate_t flavors[])
+{
+	if (validate_value(type->s.value, &flavors[SYM_TYPES]))
+		goto bad;
+	if (validate_ebitmap(&type->types, &flavors[SYM_TYPES]))
+		goto bad;
+	if (type->bounds && validate_value(type->bounds, &flavors[SYM_TYPES]))
+		goto bad;
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid type datum");
+	return -1;
+}
+
+static int validate_mls_semantic_cat(mls_semantic_cat_t *cat, validate_t *cats)
+{
+	for (; cat; cat = cat->next) {
+		if (validate_value(cat->low, cats))
+			goto bad;
+		if (validate_value(cat->high, cats))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	return -1;
+}
+
+static int validate_mls_semantic_level(mls_semantic_level_t *level, validate_t *sens, validate_t *cats)
+{
+	if (level->sens == 0)
+		return 0;
+	if (validate_value(level->sens, sens))
+		goto bad;
+	if (validate_mls_semantic_cat(level->cat, cats))
+		goto bad;
+
+	return 0;
+
+bad:
+	return -1;
+}
+
+static int validate_mls_semantic_range(mls_semantic_range_t *range, validate_t *sens, validate_t *cats)
+{
+	if (validate_mls_semantic_level(&range->level[0], sens, cats))
+		goto bad;
+	if (validate_mls_semantic_level(&range->level[1], sens, cats))
+		goto bad;
+
+	return 0;
+
+bad:
+	return -1;
+}
+
+static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, validate_t flavors[])
+{
+	if (validate_value(user->s.value, &flavors[SYM_USERS]))
+		goto bad;
+	if (validate_role_set(&user->roles, &flavors[SYM_ROLES]))
+		goto bad;
+	if (validate_mls_semantic_range(&user->range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+		goto bad;
+	if (validate_mls_semantic_level(&user->dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+		goto bad;
+	if (user->bounds && validate_value(user->bounds, &flavors[SYM_USERS]))
+		goto bad;
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid user datum");
+	return -1;
+}
+
+static int validate_datum_arrays(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+{
+	unsigned int i;
+
+	for (i = 0; i < p->p_classes.nprim; i++) {
+		if (p->class_val_to_struct[i]) {
+			if (ebitmap_get_bit(&flavors[SYM_CLASSES].gaps, i))
+				goto bad;
+			if (validate_class_datum(handle, p->class_val_to_struct[i], flavors))
+				goto bad;
+		} else {
+			if (!ebitmap_get_bit(&flavors[SYM_CLASSES].gaps, i))
+				goto bad;
+		}
+	}
+
+	for (i = 0; i < p->p_roles.nprim; i++) {
+		if (p->role_val_to_struct[i]) {
+			if (ebitmap_get_bit(&flavors[SYM_ROLES].gaps, i))
+				goto bad;
+			if (validate_role_datum(handle, p->role_val_to_struct[i], flavors))
+				goto bad;
+		} else {
+			if (!ebitmap_get_bit(&flavors[SYM_ROLES].gaps, i))
+				goto bad;
+		}
+	}
+
+	/*
+	 * For policy versions between 20 and 23, attributes exist in the policy,
+	 * but only in the type_attr_map, so all gaps must be assumed to be valid.
+	 */
+	if (p->policyvers < POLICYDB_VERSION_AVTAB || p->policyvers > POLICYDB_VERSION_PERMISSIVE) {
+		for (i = 0; i < p->p_types.nprim; i++) {
+			if (p->type_val_to_struct[i]) {
+				if (ebitmap_get_bit(&flavors[SYM_TYPES].gaps, i))
+					goto bad;
+				if (validate_type_datum(handle, p->type_val_to_struct[i], flavors))
+					goto bad;
+			} else {
+				if (!ebitmap_get_bit(&flavors[SYM_TYPES].gaps, i))
+					goto bad;
+			}
+		}
+	}
+
+	for (i = 0; i < p->p_users.nprim; i++) {
+		if (p->user_val_to_struct[i]) {
+			if (ebitmap_get_bit(&flavors[SYM_USERS].gaps, i))
+				goto bad;
+			if (validate_user_datum(handle, p->user_val_to_struct[i], flavors))
+				goto bad;
+		} else {
+			if (!ebitmap_get_bit(&flavors[SYM_USERS].gaps, i))
+				goto bad;
+		}
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid datum arrays");
+	return -1;
+}
+
+/*
+ * Functions to validate a kernel policydb
+ */
+
+static int validate_avtab_key(avtab_key_t *key, validate_t flavors[])
+{
+	if (validate_value(key->source_type, &flavors[SYM_TYPES]))
+		goto bad;
+	if (validate_value(key->target_type, &flavors[SYM_TYPES]))
+		goto bad;
+	if (validate_value(key->target_class, &flavors[SYM_CLASSES]))
+		goto bad;
+
+	return 0;
+
+bad:
+	return -1;
+}
+
+static int validate_avtab_key_wrapper(avtab_key_t *k,  __attribute__ ((unused)) avtab_datum_t *d, void *args)
+{
+	validate_t *flavors = (validate_t *)args;
+	return validate_avtab_key(k, flavors);
+}
+
+static int validate_avtab(sepol_handle_t *handle, avtab_t *avtab, validate_t flavors[])
+{
+	if (avtab_map(avtab, validate_avtab_key_wrapper, flavors)) {
+		ERR(handle, "Invalid avtab");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int validate_cond_av_list(sepol_handle_t *handle, cond_av_list_t *cond_av, validate_t flavors[])
+{
+	avtab_ptr_t avtab_ptr;
+
+	for (; cond_av; cond_av = cond_av->next) {
+		for (avtab_ptr = cond_av->node; avtab_ptr; avtab_ptr = avtab_ptr->next) {
+			if (validate_avtab_key(&avtab_ptr->key, flavors)) {
+				ERR(handle, "Invalid cond av list");
+				return -1;
+			}
+		}
+	}
+
+	return 0;	
+}
+
+static int validate_avrules(sepol_handle_t *handle, avrule_t *avrule, validate_t flavors[])
+{
+	class_perm_node_t *class;
+
+	for (; avrule; avrule = avrule->next) {
+		if (validate_type_set(&avrule->stypes, &flavors[SYM_TYPES]))
+			goto bad;
+		if (validate_type_set(&avrule->ttypes, &flavors[SYM_TYPES]))
+			goto bad;
+		class = avrule->perms;
+		for (; class; class = class->next) {
+			if (validate_value(class->tclass, &flavors[SYM_CLASSES]))
+				goto bad;
+		}
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid avrule");
+	return -1;
+}
+
+static int validate_bool_id_array(sepol_handle_t *handle, uint32_t bool_ids[], unsigned int nbools, validate_t *bool)
+{
+	unsigned int i;
+
+	if (nbools >= COND_MAX_BOOLS)
+		goto bad;
+
+	for (i=0; i < nbools; i++) {
+		if (validate_value(bool_ids[i], bool))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid bool id array");
+	return -1;
+}
+
+static int validate_cond_list(sepol_handle_t *handle, cond_list_t *cond, validate_t flavors[])
+{
+	for (; cond; cond = cond->next) {
+		if (validate_cond_av_list(handle, cond->true_list, flavors))
+			goto bad;
+		if (validate_cond_av_list(handle, cond->false_list, flavors))
+			goto bad;
+		if (validate_avrules(handle, cond->avtrue_list, flavors))
+			goto bad;
+		if (validate_avrules(handle, cond->avfalse_list, flavors))
+			goto bad;
+		if (validate_bool_id_array(handle, cond->bool_ids, cond->nbools, &flavors[SYM_BOOLS]))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid cond list");
+	return -1;
+}
+
+static int validate_role_transes(sepol_handle_t *handle, role_trans_t *role_trans, validate_t flavors[])
+{
+	for (; role_trans; role_trans = role_trans->next) {
+		if (validate_value(role_trans->role, &flavors[SYM_ROLES]))
+			goto bad;
+		if (validate_value(role_trans->type, &flavors[SYM_TYPES]))
+			goto bad;
+		if (validate_value(role_trans->tclass, &flavors[SYM_CLASSES]))
+			goto bad;
+		if (validate_value(role_trans->new_role, &flavors[SYM_ROLES]))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid role trans");
+	return -1;
+}
+
+static int validate_role_allows(sepol_handle_t *handle, role_allow_t *role_allow, validate_t flavors[])
+{
+	for (; role_allow; role_allow = role_allow->next) {
+		if (validate_value(role_allow->role, &flavors[SYM_ROLES]))
+			goto bad;
+		if (validate_value(role_allow->new_role, &flavors[SYM_ROLES]))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid role allow");
+	return -1;
+}
+
+static int validate_filename_trans(hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	filename_trans_key_t *ftk = (filename_trans_key_t *)k;
+	filename_trans_datum_t *ftd = d;
+	validate_t *flavors = (validate_t *)args;
+
+	if (validate_value(ftk->ttype, &flavors[SYM_TYPES]))
+		goto bad;
+	if (validate_value(ftk->tclass, &flavors[SYM_CLASSES]))
+		goto bad;
+	for (; ftd; ftd = ftd->next) {
+		if (validate_ebitmap(&ftd->stypes, &flavors[SYM_TYPES]))
+			goto bad;
+		if (validate_value(ftd->otype, &flavors[SYM_TYPES]))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	return -1;
+}
+
+static int validate_filename_trans_hashtab(sepol_handle_t *handle, hashtab_t filename_trans, validate_t flavors[])
+{
+	if (hashtab_map(filename_trans, validate_filename_trans, flavors)) {
+		ERR(handle, "Invalid filename trans");
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * Functions to validate a module policydb
+ */
+
+static int validate_role_trans_rules(sepol_handle_t *handle, role_trans_rule_t *role_trans, validate_t flavors[])
+{
+	for (; role_trans; role_trans = role_trans->next) {
+		if (validate_role_set(&role_trans->roles, &flavors[SYM_ROLES]))
+			goto bad;
+		if (validate_type_set(&role_trans->types, &flavors[SYM_TYPES]))
+			goto bad;
+		if (validate_ebitmap(&role_trans->classes, &flavors[SYM_CLASSES]))
+			goto bad;
+		if (validate_value(role_trans->new_role, &flavors[SYM_ROLES]))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid role trans rule");
+	return -1;	
+}
+
+static int validate_role_allow_rules(sepol_handle_t *handle, role_allow_rule_t *role_allow, validate_t flavors[])
+{
+	for (; role_allow; role_allow = role_allow->next) {
+		if (validate_role_set(&role_allow->roles, &flavors[SYM_ROLES]))
+			goto bad;
+		if (validate_role_set(&role_allow->new_roles, &flavors[SYM_ROLES]))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid role allow rule");
+	return -1;	
+}
+
+static int validate_range_trans_rules(sepol_handle_t *handle, range_trans_rule_t *range_trans, validate_t flavors[])
+{
+	for (; range_trans; range_trans = range_trans->next) {
+		if (validate_type_set(&range_trans->stypes, &flavors[SYM_TYPES]))
+			goto bad;
+		if (validate_type_set(&range_trans->ttypes, &flavors[SYM_TYPES]))
+			goto bad;
+		if (validate_ebitmap(&range_trans->tclasses, &flavors[SYM_CLASSES]))
+			goto bad;
+		if (validate_mls_semantic_range(&range_trans->trange, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid range trans rule");
+	return -1;
+}
+
+static int validate_scope_index(sepol_handle_t *handle, scope_index_t *scope_index, validate_t flavors[])
+{
+	if (validate_ebitmap(&scope_index->p_classes_scope, &flavors[SYM_CLASSES]))
+		goto bad;
+	if (validate_ebitmap(&scope_index->p_roles_scope, &flavors[SYM_ROLES]))
+		goto bad;
+	if (validate_ebitmap(&scope_index->p_types_scope, &flavors[SYM_TYPES]))
+		goto bad;
+	if (validate_ebitmap(&scope_index->p_users_scope, &flavors[SYM_USERS]))
+		goto bad;
+	if (validate_ebitmap(&scope_index->p_bools_scope, &flavors[SYM_BOOLS]))
+		goto bad;
+	if (validate_ebitmap(&scope_index->p_sens_scope, &flavors[SYM_LEVELS]))
+		goto bad;
+	if (validate_ebitmap(&scope_index->p_cat_scope, &flavors[SYM_CATS]))
+		goto bad;
+	if (scope_index->class_perms_len > flavors[SYM_CLASSES].nprim)
+		goto bad;
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalide scope");
+	return -1;
+}
+
+
+static int validate_filename_trans_rules(sepol_handle_t *handle, filename_trans_rule_t *filename_trans, validate_t flavors[])
+{
+	for (; filename_trans; filename_trans = filename_trans->next) {
+		if (validate_type_set(&filename_trans->stypes, &flavors[SYM_TYPES]))
+			goto bad;
+		if (validate_type_set(&filename_trans->ttypes, &flavors[SYM_TYPES]))
+			goto bad;
+		if (validate_value(filename_trans->tclass,&flavors[SYM_CLASSES] ))
+			goto bad;
+		if (validate_value(filename_trans->otype, &flavors[SYM_TYPES]))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid filename trans rule list");
+	return -1;
+}
+
+static int validate_datum(__attribute__ ((unused))hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	symtab_datum_t *s = d;
+	uint32_t *nprim = (uint32_t *)args;
+
+	return !value_isvalid(s->value, *nprim);
+}
+
+static int validate_symtabs(sepol_handle_t *handle, symtab_t symtabs[], validate_t flavors[])
+{
+	unsigned int i;
+
+	for (i = 0; i < SYM_NUM; i++) {
+		if (hashtab_map(symtabs[i].table, validate_datum, &flavors[i].nprim)) {
+			ERR(handle, "Invalid symtab");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int validate_avrule_blocks(sepol_handle_t *handle, avrule_block_t *avrule_block, validate_t flavors[])
+{
+	avrule_decl_t *decl;
+
+	for (; avrule_block; avrule_block = avrule_block->next) {
+		for (decl = avrule_block->branch_list; decl != NULL; decl = decl->next) {
+			if (validate_cond_list(handle, decl->cond_list, flavors))
+				goto bad;
+			if (validate_avrules(handle, decl->avrules, flavors))
+				goto bad;
+			if (validate_role_trans_rules(handle, decl->role_tr_rules, flavors))
+				goto bad;
+			if (validate_role_allow_rules(handle, decl->role_allow_rules, flavors))
+				goto bad;
+			if (validate_range_trans_rules(handle, decl->range_tr_rules, flavors))
+				goto bad;
+			if (validate_scope_index(handle, &decl->required, flavors))
+				goto bad;
+			if (validate_scope_index(handle, &decl->declared, flavors))
+				goto bad;
+			if (validate_filename_trans_rules(handle, decl->filename_trans_rules, flavors))
+				goto bad;
+			if (validate_symtabs(handle, decl->symtab, flavors))
+				goto bad;
+		}
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid avrule block");
+	return -1;	
+}
+
+/*
+ * Validate policydb
+ */
+int validate_policydb(sepol_handle_t *handle, policydb_t *p)
+{
+	validate_t flavors[SYM_NUM];
+
+	if (validate_array_init(p, flavors))
+		goto bad;
+
+	if (p->policy_type == POLICY_KERN) {
+		if (validate_avtab(handle, &p->te_avtab, flavors))
+			goto bad;
+		if (p->policyvers >= POLICYDB_VERSION_BOOL)
+			if (validate_cond_list(handle, p->cond_list, flavors))
+				goto bad;
+		if (validate_role_transes(handle, p->role_tr, flavors))
+			goto bad;
+		if (validate_role_allows(handle, p->role_allow, flavors))
+			goto bad;
+		if (p->policyvers >= POLICYDB_VERSION_FILENAME_TRANS)
+			if (validate_filename_trans_hashtab(handle, p->filename_trans, flavors))
+				goto bad;
+	} else {
+		if (validate_avrule_blocks(handle, p->global, flavors))
+			goto bad;
+	}
+
+	if (validate_scopes(handle, p->scope, p->global))
+		goto bad;
+
+	if (validate_datum_arrays(handle, p, flavors))
+		goto bad;
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid policydb");
+	return -1;
+}
diff --git a/libsepol/src/policydb_validate.h b/libsepol/src/policydb_validate.h
new file mode 100644
index 00000000..d9f7229b
--- /dev/null
+++ b/libsepol/src/policydb_validate.h
@@ -0,0 +1,7 @@
+#include <stdint.h>
+
+#include <sepol/handle.h>
+#include <sepol/policydb/policydb.h>
+
+int value_isvalid(uint32_t value, uint32_t nprim);
+int validate_policydb(sepol_handle_t *handle, policydb_t *p);
-- 
2.26.2

