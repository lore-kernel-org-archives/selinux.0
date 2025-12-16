Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4CC23182D
	for <selinux@vger.kernel.org>; Tue, 16 Dec 2025 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765918913; cv=none; b=GwG88Mz8FVYE53883pY8U+LoMYgWuoo2/1Xu59BDtRQGkhN5+xzIOsy2kHyVDBEhM6THW4ulQDzImkLw6ydTQnbv4bwku4iy819EsBw1e10C8qBwwmq/B11UY3epeDBspPsIa/wYQFXr4lJftOLGIMW+5EpRsgHUJmow1Zpgs2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765918913; c=relaxed/simple;
	bh=H97KLUA3r4TUVyFDaGE5tt3jLeNuNLHtWzcv+t5i3y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FXat5+989nxrBpp4X8NECOHDkMRcE4veAXdbR4KRexwmlJlBQAodTJXHCS9mcQzeHgVxH/mz5jz/MTN44KVvhMSz1onRJLVQwDJ1fgEsoLC3myFiqq/V7th+5JhL2bGmQT1DSU4Jxfshkm9VaasyWLqyjwJ9MOQGcj2NRR8+FUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIZsFYpQ; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIZsFYpQ"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8bc53dae8c2so300651385a.2
        for <selinux@vger.kernel.org>; Tue, 16 Dec 2025 13:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765918910; x=1766523710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yLqgkibr7iQS6MZXLeIhqkKYZ9wwe/YjQ8wjlbRnLuQ=;
        b=LIZsFYpQgxkqZqewLBDwreblGfQEZFOqUc1K2tgxdTxYxZH7r0pFu2kjxBx77tstZl
         funl9Bb/FVAThLFd6sZKXqWhsiKQ+67A/thgN6W37HjAevyjkVhmRBju9BxrLp/snkUM
         hA464FAJFmULdCeKiKZB4ZA+DDqyVyzyn2aO8cY5KV6rjMCoWtJWz4df/8G82p5B9yZl
         tVJELPdBP9q17F70FAmgMyXp7AXk17iQL+/qxzELkjQGbvxQG6bRiQbBFfhH6oNXuosX
         du3Y7/LEQusVhIudNuSTPld6enkBrmbrzNFozwc35XpTzRKeJYVQ3LgAOh0KpNBj411y
         khcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765918910; x=1766523710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLqgkibr7iQS6MZXLeIhqkKYZ9wwe/YjQ8wjlbRnLuQ=;
        b=TS0HbbfkINUi/vFqa5XD978JXRzGzSg4LDWuOdxfboLv8FYWbHGa42GDmavoMdwsSE
         ORav0KfbbuaWX4sai097ZNFfWp/zoN2/Eh1/IMS86dqA4R/M9ZkC8UetSZJsnjSEDisX
         Vpp/MJ4lyyweZ3OPQNISDHWtryVUvkj6QN29RmwR1m+3Fq3BEc8rStFG3Yxd2fZr9aHm
         kB4KV2Jj2964fXGaM60GAk+C2t8iWwsNQTo0XqHG62JI095DvsHL25tW92ogfCrdWCUQ
         mfnptzI8I1R7Y45Z1GF+W++D1HdQj6gvrAEIsZXgWBmLB2c0hdJmQR8e2Ug18X79Yv3M
         9mEA==
X-Gm-Message-State: AOJu0YxEEqtGypS88jwy2jWSpkQRWEJW/Bl7yvZjmeeYwwNsFbCRFT2m
	24nKJkDef2VAgw7/sq3mL7qevJdqTkLDcgzNTWou6D20oUn4yCK3BOMOhTlQ1BBN
X-Gm-Gg: AY/fxX6ZE0bl36RsD9TGu8Gsk1CQ+RBFw7C9mGEpmpgAVkSUTvdJvYqnOBORSo/Do4E
	WlYeAIoHyuvG/oTdd2J3Jn2ukK92MsHJtyKV3InGAUs62l6mCCR3V1WwlG1cYZRPRCoEfillxuH
	ZBSGIRadwK43vU5awsP1B+t20zx0QkxMw6DWOXw/tzzxbOha/l3iEhQv20hgtUFXyIFmOXiI8N3
	l1InYO6svsXkzhHd4E8YgdiswqZ3oK7X/KT6X+z2b3MyKBgqkfEQAUhrEmZfG6/f6aHAn0XNyHT
	SYB6Hzqfk3j6ed4KhVrt75Y/BpNuLo7ZY8EYvZd9ZD+cCnrMo1KLWXj04TsP2i4Jeta7DvFlHbp
	Q7Wm1j5MnG1i2GdcJ6Xi8Y5wFQUh2o1UejLhrJtvMrfSUALJ7NxRGD9hrA956wRao/2Pxr39r2W
	vZeiNqAJs3OmK6rcoFcGQ=
X-Google-Smtp-Source: AGHT+IFLO3lJllOSXFbvxKwiJV+DgbyIsP0NgRmlDdOJfR4V736yVROtbeLDZwlUPoA+Hqq+xJNzxg==
X-Received: by 2002:a05:620a:1a08:b0:8b2:f269:f899 with SMTP id af79cd13be357-8bb3a253e9bmr2172997885a.56.1765918910176;
        Tue, 16 Dec 2025 13:01:50 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be5a606c6fsm163366585a.11.2025.12.16.13.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 13:01:49 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: vmojzis@redhat.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH V2] Allow type attributes to be associated with other type attributes
Date: Tue, 16 Dec 2025 16:01:33 -0500
Message-ID: <20251216210133.149077-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the following:
attribute at1;
attribute at2;
typeattribute at2 at1;

This associates the attribute at2 with the attribute at1. Any types
associated with at2 will be associated with at1 as well when the
policy is expanded. A loop in the associations between attributes
will produce an error.

The kernel binary policy is not effected by this change because all
attribute associations are expanded when the policy is expanded.
The modular policy is effected because compiled modules and the
linked modular policy can now have type attributes associated with
other type attributes, so a new module version is needed to prevent
an older policy toolchain from creating a kernel binary policy that
has type attributes associated with other attributes.

Also validate that the types field of a type datum for an attribute
is empty for kernel policies and does not contain an attribute for
modular policies before this new version.

This was suggested by Vit Mojzis <vmojzis@redhat.com> who also
provided an initial patch for checkpolicy.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
V2: relocated call of expand_attributes_in_attributes() because of recent commits

 checkpolicy/policy_define.c                |  9 +++-
 libsepol/include/sepol/policydb/policydb.h |  3 +-
 libsepol/src/expand.c                      | 53 ++++++++++++++++++++++
 libsepol/src/policydb.c                    | 25 ++++++++--
 libsepol/src/policydb_validate.c           | 30 +++++++++++-
 5 files changed, 112 insertions(+), 8 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 4c53e1e6..b73de45c 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1440,11 +1440,18 @@ int define_typeattribute(void)
 		return -1;
 	}
 	t = hashtab_search(policydbp->p_types.table, id);
-	if (!t || t->flavor == TYPE_ATTRIB) {
+	if (!t) {
 		yyerror2("unknown type %s", id);
 		free(id);
 		return -1;
+	} else if (t->flavor == TYPE_ATTRIB) {
+		if (policydbp->policy_type != POLICY_KERN && policydbp->policyvers < MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS) {
+			yyerror2("Type attributes cannot be used in a typeattribute definition in policy version %d", policydbp->policyvers);
+			free(id);
+			return -1;
+		}
 	}
+
 	free(id);
 
 	while ((id = queue_remove(id_queue))) {
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 9875255c..4107b662 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -802,9 +802,10 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define MOD_POLICYDB_VERSION_SELF_TYPETRANS	21
 #define MOD_POLICYDB_VERSION_COND_XPERMS	22
 #define MOD_POLICYDB_VERSION_NEVERAUDIT		23
+#define MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS 24
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_NEVERAUDIT
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS
 
 #define POLICYDB_CONFIG_MLS    1
 
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 04b5e5e4..25c2c4ae 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -222,6 +222,55 @@ static int attr_convert_callback(hashtab_key_t key, hashtab_datum_t datum,
 	return 0;
 }
 
+static int expand_attributes_in_attributes(sepol_handle_t *handle, policydb_t *p)
+{
+	ebitmap_t attrs, types;
+	ebitmap_node_t *ni, *nj;
+	unsigned int i, j, reps = 0, done = 0;
+	type_datum_t *td, *ad;
+
+	ebitmap_init(&attrs);
+	for (i=0; i < p->p_types.nprim; i++) {
+		if (p->type_val_to_struct[i]->flavor == TYPE_ATTRIB)
+			ebitmap_set_bit(&attrs, i, 1);
+	}
+
+	while (!done && reps < p->p_types.nprim) {
+		done = 1;
+		reps++;
+		ebitmap_for_each_positive_bit(&attrs, ni, i) {
+			td = p->type_val_to_struct[i];
+			if (ebitmap_match_any(&td->types, &attrs)) {
+				done = 0;
+				ebitmap_init(&types);
+				ebitmap_for_each_positive_bit(&td->types, nj, j) {
+					if (ebitmap_get_bit(&attrs, j)) {
+						ad = p->type_val_to_struct[j];
+						ebitmap_union(&types, &ad->types);
+						ebitmap_set_bit(&td->types, j, 0);
+					}
+				}
+				ebitmap_union(&td->types, &types);
+				ebitmap_destroy(&types);
+				if (ebitmap_get_bit(&td->types, i)) {
+					ERR(handle, "Found loop while expanding attribute %s", p->p_type_val_to_name[i]);
+					ebitmap_destroy(&attrs);
+					return -1;
+				}
+			}
+		}
+	}
+
+	ebitmap_destroy(&attrs);
+
+	if (!done) {
+		ERR(handle, "Failed to expand attributes");
+		return -1;
+	}
+
+	return 0;
+}
+
 static int perm_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			      void *data)
 {
@@ -3161,6 +3210,10 @@ int expand_module(sepol_handle_t * handle,
 		if (hashtab_map(decl->p_types.table, type_bounds_copy_callback, &state))
 			goto cleanup;
 	}
+	/* Expand any attributes in each attributes' types ebitmap */
+	if (expand_attributes_in_attributes(state.handle, state.out)) {
+		goto cleanup;
+	}
 
 	/* copy commons */
 	if (hashtab_map
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 8a81687d..6aaa18f2 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -362,6 +362,13 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = OCON_IBENDPORT + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_IBENDPORT + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BASE,
@@ -502,6 +509,13 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = 0,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_MOD,
+	 .version = MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 };
 
 #if 0
@@ -4492,16 +4506,19 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 			if (r_policyvers >= POLICYDB_VERSION_AVTAB) {
 				if (ebitmap_read(&p->type_attr_map[i], fp))
 					goto bad;
-				ebitmap_for_each_positive_bit(&p->type_attr_map[i],
-							 tnode, j) {
+				ebitmap_for_each_positive_bit(&p->type_attr_map[i], tnode, j) {
 					if (i == j)
 						continue;
 
 					if (j >= p->p_types.nprim)
 						goto bad;
 
-					if (ebitmap_set_bit
-					    (&p->attr_type_map[j], i, 1))
+					if (p->type_val_to_struct[i]->flavor == TYPE_ATTRIB) {
+						ERR(fp->handle, "Invalid to have type attributes associated with an attribute for a kernel policy");
+						goto bad;
+					}
+
+					if (ebitmap_set_bit(&p->attr_type_map[j], i, 1))
 						goto bad;
 				}
 			}
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index fb79c8d9..5afbfa49 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -566,6 +566,27 @@ bad:
 	return -1;
 }
 
+static int validate_types_in_attribute(const ebitmap_t *map, const policydb_t *p, const validate_t flavors[SYM_NUM])
+{
+	ebitmap_node_t *node;
+	uint32_t i;
+
+	if (validate_ebitmap(map, &flavors[SYM_TYPES]))
+		goto bad;
+
+	if (p->policy_type != POLICY_KERN && p->policyvers < MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS) {
+		ebitmap_for_each_positive_bit(map, node, i) {
+			if (validate_simpletype(i+1, p, flavors))
+				goto bad;
+		}
+	}
+
+	return 0;
+
+bad:
+	return -1;
+}
+
 static int validate_type_datum(sepol_handle_t *handle, const type_datum_t *type, const policydb_t *p, validate_t flavors[])
 {
 	if (validate_value(type->s.value, &flavors[SYM_TYPES]))
@@ -582,8 +603,13 @@ static int validate_type_datum(sepol_handle_t *handle, const type_datum_t *type,
 			goto bad;
 		break;
 	case TYPE_ATTRIB:
-		if (validate_ebitmap(&type->types, &flavors[SYM_TYPES]))
-			goto bad;
+		if (p->policy_type == POLICY_KERN) {
+			if (!ebitmap_is_empty(&type->types))
+				goto bad;
+		} else {
+			if (validate_types_in_attribute(&type->types, p, flavors))
+				goto bad;
+		}
 		if (type->bounds)
 			goto bad;
 		break;
-- 
2.50.0

