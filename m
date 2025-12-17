Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B100F2BE625
	for <selinux@vger.kernel.org>; Wed, 17 Dec 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994398; cv=none; b=a8ILs94avnFi/h6zX+VGEWMRypJZMQQjl/0f+RhNK3mhbSXASYyUZ1ZKeiwVxYcTQANLT6HByU0TNv9Vn5FvtWQ4Vb1kNUPtadRLL/WpH3H0bad04S9WIvCJCpPuuVUUg9/oYmY4GxIQp2cpLHTafSNu4T2lkXrNriP0IPslIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994398; c=relaxed/simple;
	bh=HHRcAfw3QlIxdjArmAe0dWx44I6NNxB9HBWf6/JLJ8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ODQj24XbzgroOMkQBkNgaKGIyTfFqzvJB8TvaHrjF3P7E0SKPk4tQzZuSW5USB2dYuVqs9nu2oTuS/HzyGgRAOjqE0uliDTzFERwwNxcymya46WCtMr6NbE+xIKLN0cOnhwayMDbWZVUtyw7bVvdstYUyI8itUtq+OdB+17V+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ex8ptg7N; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex8ptg7N"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-4f1b4bb40aaso36148981cf.3
        for <selinux@vger.kernel.org>; Wed, 17 Dec 2025 09:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765994396; x=1766599196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nTzXBktNFSR+X96KLPRCY1IULxG+EXVcn8CkJbL9icw=;
        b=ex8ptg7NpE/safEf/ZDJrvwVNWxYVd5tCkXEFXP1J2l2Ot0Bv11yHFI1BmKV3cieUA
         DxsSDsLD9ZCaiOf3N6y1W9mvkP8SVtJLKNlHVgrPr6HQ4UEGpgthyHk9Bsj/deRgBGju
         YYq+rpJ3cZ8qwdAYEFq6rvkSgoh2ManTxYhXaBdZvIMfBR/wYN6t0TmcsCZK7z63YEV0
         0iONT2nOXfzNs7eUIe8JKUEwH0vWJpyGTteUtOBGzEGYo8fSvuzqUr4tNZ+gGu4nzAa4
         SVBohXI/nv21ic8bMhfjnEMTABq7oEDuLqbxSdoelb0ld2/sE3UYwBox8ycN5wv7/38h
         GaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765994396; x=1766599196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTzXBktNFSR+X96KLPRCY1IULxG+EXVcn8CkJbL9icw=;
        b=jGWnq+qx7Jpt2hMzAT6rpBS93YNPcVJFY3P0mmxbG65eGZIA5OGaCbqN4oMaIhSziK
         wkYNbzoCSwlth0qD7bHTD4ZphxvIJymgk4ZZ1d0DoEEUg7zP5modVm6efo9G3A8miJnT
         MrvY1jQb7CUz3wYqEWxlWsz8gkS1Ql3tTE9/DUiNx+69mSZxTj/IPnQ74gX/18vUiXYe
         iMUElVY0UjjvRHntZfdb3ve8yXCZ6T+J1E/SndL+CqIPnXEy/Ya+ZoNas3prT6nhv3Lo
         z9Hx/Wvp9sS76CR7DEf6j6x35vhRAQJ5Z6ePGSJHIPYMDuMeSxfYJo872XOY+mNryHhx
         bsGg==
X-Gm-Message-State: AOJu0YyWKRbMnFlw+V7wSHG7vE1aMi7IkbRLCvubeXQqvbJjXcTFGuAx
	AFNcRCpRARvbH/Ew1cpNCGMdotVFYABxq/xkXDLGhll6sxMQMCTgWtMBe8+a/65Z
X-Gm-Gg: AY/fxX6J47BbKvjm62zt9A0UUB2KmTxrIzvWy2uDb7VFfB7mK2tTwtmpTpgfFy51YdD
	iOQq7bvPRHOWsxQHGdki19D2OJ+hTCXRUtWjerpCUwzPReVLFNvcXeKx40ZjZUqg+9C4XIQr5H8
	DeY9XNQLQcnmLsdA0+znwx4KhvFk5hd4NmtLxZcE1ERQ4jzFyQ48+rfjPb7UmHJw8HwhGJMTcYI
	GJYBWEHsxUOavialNKwXz7G8g/0ThifefQGvVOzdOlyB9CSJIaD6g9w9qTOaVQQ4TX5RyOCyYV9
	QmEtcSrW12e/3lA387svTL4F2UBb+a/6fLXXTDgzxSEhR8hHJ/hsNQS/taFBocj9aqEpyst2Z6E
	cycz6Rov/PX0dKDwDGUaPm/e+XAG0FgGNVQNtyq2fHPaHtRK3eTkXv2wqVUEtCGJK1ySUs9Xwyl
	4ccdrcjUnzvMCNIw7zTGMpcYuB9FdYVg==
X-Google-Smtp-Source: AGHT+IFmW3NNes5vmG9wdeekaSXlMCWWsp7dQ0mI3Hl9C8EpAxn/5VCyi59//iyfdeIca2ceRtPOCQ==
X-Received: by 2002:a05:622a:5c88:b0:4ee:4a1a:8242 with SMTP id d75a77b69052e-4f1d0636a4amr251621101cf.73.1765994395544;
        Wed, 17 Dec 2025 09:59:55 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c613742e2sm328416d6.42.2025.12.17.09.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 09:59:55 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH V3] Allow type attributes to be associated with other type attributes
Date: Wed, 17 Dec 2025 12:59:38 -0500
Message-ID: <20251217175938.193948-1-jwcart2@gmail.com>
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
V3: Fix potential NULL dereference in expand_attributes_in_attributes() and
    change the language of the error message.
V2: relocated call of expand_attributes_in_attributes() because of recent commits

 checkpolicy/policy_define.c                |  9 +++-
 libsepol/include/sepol/policydb/policydb.h |  3 +-
 libsepol/src/expand.c                      | 54 ++++++++++++++++++++++
 libsepol/src/policydb.c                    | 25 ++++++++--
 libsepol/src/policydb_validate.c           | 30 +++++++++++-
 5 files changed, 113 insertions(+), 8 deletions(-)

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
index 04b5e5e4..d8f56476 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -222,6 +222,56 @@ static int attr_convert_callback(hashtab_key_t key, hashtab_datum_t datum,
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
+		td = p->type_val_to_struct[i];
+		if (td && td->flavor == TYPE_ATTRIB)
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
+					ERR(handle, "Found loop in type attributes involving: %s", p->p_type_val_to_name[i]);
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
@@ -3161,6 +3211,10 @@ int expand_module(sepol_handle_t * handle,
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

