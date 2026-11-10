Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308875;
	b=O6kIgEgOtTuVm7Q8IEIDzpt5kNwEHT03fat1iBf/xByZcRzLaakMuMHom2JbACVGjYU9
	 VSq4x7hh1JbHiFRfUlvdmpk61CR586avoEJ09pOKdppw2c+4DbPqKaXUSNmXYRPPv4tvV
	 vlqwWB2SQpQsq3B0gFuQkS2EsoO1D1ea7gKpr55LLt6R0SH4RaHjPlKeVKOKG4oMbgwlX
	 5qv/A2pd8s38O7f+UUjrYFbBm/U9enfUZ6IlMbTNj3BdNUHDk1dDEI5+MT/k0TUC1taa0
	 Lk9uXCCrnOA3IF7TA7fjgYN6wdgYmGhKtl1R1w7er7JXKchfZXr50TKL+OuajayfPFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308875;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0qiMsmaxb218ClJ6Pt4LdUlOnj7yMDVV/WpSS1X4Exs=;
	b=ynFf1KfaNNItbHlpgTuaXmOulEDBM/q6FhB2/bPgkekStMLRqbtiBOkOfc1POMH1pE3E
	 ObgCNO0Fx5J1Re2UNf+RFyn46UgI+PtmjLhVnt8ArpIEXBEFm4hiptHq9lUXs07855Jqo
	 bZeJXruh2miEX2FVPGw9BvwRs8VVqCgifOw1VunuBv7T5dZVlWax1uXmMZM957601vf6Y
	 WqNUA1wvy2PTGCY4gvRoT7ud9foOD4o+8X4ts4tXDTpDP7I+FGiNQSIWnJ7h6kxk0JaC7
	 ldddtDKTW4doxGQqodTSgdLfcPpZHT71n17OzsM2hOwFZoHiTjTLmg5y52S1uG61MCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=SlYeWl6X;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC49E606A31C
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 11:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC49E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=SlYeWl6X
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794308873;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qiMsmaxb218ClJ6Pt4LdUlOnj7yMDVV/WpSS1X4Exs=;
	b=SlYeWl6XyxS7bEo7/Z31RVptSMjRuMokWdg0+MIbr+l9eM7lvw8+Zi1GVYJ5AdITecLJh2
	gZZ4ckt+xAEDde1d12Oom5yQ5VeyeSEIPp1o93UCV1wQbFuMVhqtH2wVnZ69CES9NG9oyV
	noeGlItABNkiEdKruh4w7/2lLQXyRCTZ14uBb68CZP4Mi9CsGj6k03ag3pOCEaVHMFLn7J
	Rr6NSKiCYRwqaSIJ6PPluyH1YbgTRcLGgfGtS0jEFS71fpL3vgMHtDnT53rT5WlTQYMsnB
	bePZQ5X4G6WxefUr/JbjPawBPNTeLkuL2iWxZb711UvbJaru1dl3mYiiYET9bA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 4/6] libsepol/cil: cache the sepol type values when checking neverallow rules
Date: Tue, 10 Nov 2026 12:07:36 +0100
Message-ID: <20261110110739.67209-3-cgoettsche@seltendoof.de>
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

The type sets of each neverallow rule are built by looking up every
type of the source and target attributes by name in the types symtab
of the policydb. Attributes used in neverallow rules tend to be large
and to be used by many rules.

Cache the value of the sepol type for each CIL type across all rules.

Compiling a policy with 917 neverallow rules takes 0.58s instead of
0.72s.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_binary.c | 45 +++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 03178d9f..7cc52f51 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -5449,8 +5449,14 @@ static void __cil_init_sepol_type_set(type_set_t *t)
 	t->flags = 0;
 }
 
+/*
+ * sepol_type_values caches the value of the sepol type for each CIL type
+ * (indexed by the value of the CIL type, 0 means not yet looked up), since
+ * the same types are looked up for many neverallow rules.
+ */
 static int __cil_add_sepol_type(policydb_t *pdb, const struct cil_db *db,
-				struct cil_symtab_datum *datum, ebitmap_t *map)
+				struct cil_symtab_datum *datum, ebitmap_t *map,
+				uint32_t *sepol_type_values)
 {
 	int rc = SEPOL_ERR;
 	struct cil_tree_node *n = NODE(datum);
@@ -5462,12 +5468,17 @@ static int __cil_add_sepol_type(policydb_t *pdb, const struct cil_db *db,
 		struct cil_typeattribute *attr =
 			(struct cil_typeattribute *)datum;
 		ebitmap_for_each_positive_bit(attr->types, tnode, i) {
-			datum = DATUM(db->val_to_type[i]);
-			rc = __cil_get_sepol_type_datum(pdb, datum,
-							&sepol_datum);
-			if (rc != SEPOL_OK)
-				goto exit;
-			ebitmap_set_bit(map, sepol_datum->s.value - 1, 1);
+			uint32_t value = sepol_type_values[i];
+			if (value == 0) {
+				datum = DATUM(db->val_to_type[i]);
+				rc = __cil_get_sepol_type_datum(pdb, datum,
+								&sepol_datum);
+				if (rc != SEPOL_OK)
+					goto exit;
+				value = sepol_datum->s.value;
+				sepol_type_values[i] = value;
+			}
+			ebitmap_set_bit(map, value - 1, 1);
 		}
 	} else {
 		rc = __cil_get_sepol_type_datum(pdb, datum, &sepol_datum);
@@ -5674,7 +5685,8 @@ exit:
 }
 
 static int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb,
-				struct cil_tree_node *node, int *violation)
+				struct cil_tree_node *node, int *violation,
+				uint32_t *sepol_type_values)
 {
 	int rc = SEPOL_OK;
 	struct cil_avrule *cil_rule = node->data;
@@ -5693,7 +5705,8 @@ static int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb,
 	rule = __cil_init_sepol_avrule(kind, node);
 	rule->next = NULL;
 
-	rc = __cil_add_sepol_type(pdb, db, cil_rule->src, &rule->stypes.types);
+	rc = __cil_add_sepol_type(pdb, db, cil_rule->src, &rule->stypes.types,
+				  sepol_type_values);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -5705,12 +5718,14 @@ static int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb,
 	} else if (tgt->fqn == CIL_KEY_OTHER) {
 		rule->flags = RULE_NOTSELF;
 		rc = __cil_add_sepol_type(pdb, db, cil_rule->src,
-					  &rule->ttypes.types);
+					  &rule->ttypes.types,
+					  sepol_type_values);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 	} else {
-		rc = __cil_add_sepol_type(pdb, db, tgt, &rule->ttypes.types);
+		rc = __cil_add_sepol_type(pdb, db, tgt, &rule->ttypes.types,
+					  sepol_type_values);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -5781,15 +5796,21 @@ static int cil_check_neverallows(const struct cil_db *db, policydb_t *pdb,
 {
 	int rc = SEPOL_OK;
 	struct cil_list_item *item;
+	uint32_t *sepol_type_values;
+
+	sepol_type_values =
+		cil_calloc(db->num_types + 1, sizeof(*sepol_type_values));
 
 	cil_list_for_each(item, neverallows) {
-		rc = cil_check_neverallow(db, pdb, item->data, violation);
+		rc = cil_check_neverallow(db, pdb, item->data, violation,
+					  sepol_type_values);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 	}
 
 exit:
+	free(sepol_type_values);
 	return rc;
 }
 
-- 
2.55.0

