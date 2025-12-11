Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12739248F57
	for <selinux@vger.kernel.org>; Thu, 11 Dec 2025 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765471351; cv=none; b=hGU/Vd9k0lBkuy6jZC38rrNjXEACdnh54Vre4pf7bOX4VzhU/hhRdY7XxyzbpBfFUsZuVoR17zdAOd1F0KaFIoQ+4ZmnMLn5w/14o2AM8AHsVLGSebHobc/bOqbFLbr16eN71psU+b6xPGn5sX40Ow40soIE8wR1WqzDwTw39u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765471351; c=relaxed/simple;
	bh=/k63glydtQejF/rQggTF8og0YPlog8XaXmJdjY6nn3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJeo9MThSqiegvWkpRG7Og6plckBiITw7BLImMHhSqXs1rZjqNJHn0GA8DWfgfZ1mTTblcjNV2YaIWdFW2nN2CHv7dsoX0dXXF+npxtFmx31wK5pRB1mhvbhj7TgfTg7QdWRknjLveDx2XS81SBz3SgqoN10e5EvjQ2NkDsTju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL5a0FP8; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL5a0FP8"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b220ddc189so37947185a.0
        for <selinux@vger.kernel.org>; Thu, 11 Dec 2025 08:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765471348; x=1766076148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LxTnmXSQfDCAk82LbzkUZVYEy+Rhw1k1OjJjW7cvVFs=;
        b=iL5a0FP8v2G002lVf+T0GU7wZoX3yxgDRqWiJaIFRSdcYW0q0qAA5OZLc79kA+LbXp
         iX63SzNnb4Wm60BrtiN1uoOjO1OdWuwL2EDwnEA6M4TwiCqXyxsx6jks8939Ly81HKjR
         QpgyfaWki/zKxvH5oFRBoFlIjBDnPWo4bK1fRH4KjMMH8+3AEi++x95jKTXaNg3B23BV
         9yKwedNqBbm+zJM60w43TGork13TbQmfCAw5BmfEZxdk/n31sjfm5oopyVbZ+o0jKbaS
         XOdolOyeFA4pJvTqiwZZhb2v3Vf0SIVPTIZ8x/ONDM4zimePoTjvviVPtGTjEzv0iqK5
         C5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765471348; x=1766076148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxTnmXSQfDCAk82LbzkUZVYEy+Rhw1k1OjJjW7cvVFs=;
        b=VMAkBLtrr0X6U+OLhWLKF+zajvtU0CWVxfx60Zbxh03qMU3M0P+76cdZVRKzCd7pxM
         4dRYsg9vhS2OZ/8z3A2ymd6rQgfF+LjqPKdbpj3o+Dst93JR4CFtGpm0oVA6hTuf39iK
         iI/N3HWRY6/TeWfwJ5raweNGYSwsaOLMqBPXAvGQpe/zBb4Du6gwJuX8fP6wP7UKqjPK
         y+MDbJNDCE0/YQ1AgOaJHMlNz0Gk9GvANJHI24l6XGTv+A4C4v8FhRPaYsOp4Se2JEUv
         5FS6tO/GcYHz3CsKeCEIc5mkbQTgMUBu8eOU2l2WDydGc/Mla3onsS7zFDTnRJ8hKChQ
         crBg==
X-Gm-Message-State: AOJu0YyYkgMivjlvGAfnCgFU7CHFQudtPznELKEUm/d/ii5UIlgi0C5w
	HPyoEkMbQe16t+uWdpxFdwOIPeWVfzu09ENukBuIsBOsrNmNkn4rcfg7Y/Psqw==
X-Gm-Gg: AY/fxX4px97JF1z5cN+GsNbcFNIV5Dfb5b1WwEcc7IxU0+kiQ8hVPBG3vmVScC3CZgp
	bBKXA5/q0HLsMHvYyPAxm4uebOTMFvGpcNSzhsA7uOwT2GV5MBiTvkTpWXSEUyn4rSN7zcc5FeS
	WRHFtxKcY6gRk5OtAoPuTJrPo1Mr5kD0pHaMLM63nZSrWAzNKWpvJ27dadO4kRtwLYmy1+LWK/L
	8vjv5E9Ct+BwxlY+RRm9UToLAegvITq2792/pyZeK3Q9Md4ueWWKEnCXwS4fhyc0HPnvjcv9dGM
	/g4cgh3AamtK8nuQstuf5kni5ToAEcdAOhTK4h1GEBGOMuCCdnfcuoQm4UMxVsWhJIWUJ2pOtTD
	Z60VqBQgXVw6D4V+wDFWnBgzVyGOnlmJW92uimBijaODyoqM/Lz9sXLbqUUZwumQrFKlkdZl1FB
	Qc05o2B41soRC+KT3l4nc=
X-Google-Smtp-Source: AGHT+IFMyqY+oQH9ySDBNaabk3GE74VGTa1OO5oix5IZAp3W9IMaD/KGblXOFNizltxX4yRIILZXMQ==
X-Received: by 2002:ac8:57d0:0:b0:4ee:4128:beb7 with SMTP id d75a77b69052e-4f1b1b8e6d2mr89915681cf.69.1765471348322;
        Thu, 11 Dec 2025 08:42:28 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8886ec28de0sm28744636d6.4.2025.12.11.08.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 08:42:27 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: vmojzis@redhat.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] Allow type attributes to be associated with other type attributes
Date: Thu, 11 Dec 2025 11:42:16 -0500
Message-ID: <20251211164216.71202-1-jwcart2@gmail.com>
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
 checkpolicy/policy_define.c                |  9 +++-
 libsepol/include/sepol/policydb/policydb.h |  3 +-
 libsepol/src/expand.c                      | 54 ++++++++++++++++++++++
 libsepol/src/policydb.c                    | 25 ++++++++--
 libsepol/src/policydb_validate.c           | 30 +++++++++++-
 5 files changed, 113 insertions(+), 8 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 7029b834..a79b944c 100644
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
index 8695540c..d91ef6b1 100644
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
@@ -3159,6 +3208,11 @@ int expand_module(sepol_handle_t * handle,
 
 	}
 
+	/* Expand any attributes in each attributes' types ebitmap */
+	if (expand_attributes_in_attributes(state.handle, state.out)) {
+		goto cleanup;
+	}
+
 	/* remap role dominates bitmaps */
 	 if (hashtab_map(state.out->p_roles.table, role_remap_dominates, &state)) {
 		goto cleanup;
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
index d441526e..38b89495 100644
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

