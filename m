Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42411C34022
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 16:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100B52469C
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 16:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFBq5zOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgB0QDK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:03:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48982 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729153AbgB0QDK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 11:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582819389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WMv5VfmQfWfnTudeP8g0DGf9u1ZopZuCiFUiph6aMeE=;
        b=NFBq5zOvFmEzvxy1u7uax5BpX7poGXGdjegD36qEf4pvtrKTfk3qSq/4x2G4YvVp3Y8jrn
        1FYqrZ9obgwz6QdsLFh5mki5UdJMCN+iGGN2T+biheaOqp+yvhQcaaTMBedysTC5NjWCIC
        12iAiwNwvY0WfjBsdBhMc6Rli6MDudE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-3373vVr9PYq87V3UAejfEQ-1; Thu, 27 Feb 2020 11:03:07 -0500
X-MC-Unique: 3373vVr9PYq87V3UAejfEQ-1
Received: by mail-wm1-f72.google.com with SMTP id t17so862347wmi.7
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 08:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WMv5VfmQfWfnTudeP8g0DGf9u1ZopZuCiFUiph6aMeE=;
        b=MqMGpwUyWTFvbprlvWa23CBxGiD0x45S8YH4Rx+TMXA3icIrRrmDIjIVtryGKt1/9r
         upC6UhyLju8tFkOco9yqvsDcrdEvxQSwc4btk3OgM9fvb8B8faxjalCDU1h4Gaq36LSW
         mVQNh2sip7A3gpQ9boyrroGK/TfaC6yT7XGVqvr4QHb0BOLmH2142KGnXNVwJYHN6YCj
         kfY5AU3mrYtoug6mPtkwLc0kE/VCbLzcBXzI/TYil55BRuggPPyQ+erF9jLDEK5IKDrq
         Z5xRGw3Jl+9iwW9ouTysBC/Iv7iapPAaQ7FmzI/lDs1Px/vQbPST5GsDH/W6ILEXPwz6
         GRPQ==
X-Gm-Message-State: APjAAAVjIUqz9NnBgneJ1NYM0dxvmXzLo8nYh1gSCLMI16CdapO9VrxF
        C4v215DRLocf0EaMcYoWNbqQ50u1FERtNd6hFgA3nm+/CHHLuSM0peM265Yyl5B8mqEw0qRpd2y
        2xW5j4Gd7c9/H7YPiRg==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr208945wmi.25.1582819383028;
        Thu, 27 Feb 2020 08:03:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqxm3FreARqR+ixYi71A8Sex5YXDTklTk14h6p4+B2AMszyFS1ptCT8edXVk8nacqqzxqW36UQ==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr208921wmi.25.1582819382664;
        Thu, 27 Feb 2020 08:03:02 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d17sm8063456wmb.36.2020.02.27.08.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 08:03:01 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Subject: [PATCH 3/3] libsepol: speed up policy optimization
Date:   Thu, 27 Feb 2020 17:02:57 +0100
Message-Id: <20200227160257.340737-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227160257.340737-1-omosnace@redhat.com>
References: <20200227160257.340737-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The iteration over the set ebitmap bits is not implemented very
efficiently in libsepol. It is slowing down the policy optimization
quite significantly, so convert the type_map from an array of ebitmaps
to an array of simple ordered vectors, which can be traveresed more
easily. The worse space efficiency of the vectors is less important than
the speed in this case.

After this change the duration of semodule -BN decreased from 6.4s to
5.5s on Fedora Rawhide x86_64 (and from 6.1s to 5.6s with the unconfined
module disabled).

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/src/optimize.c | 113 ++++++++++++++++++++++++++++++++--------
 1 file changed, 90 insertions(+), 23 deletions(-)

diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index 2b5102af..6826155c 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -31,22 +31,85 @@
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/conditional.h>
 
+#define TYPE_VEC_INIT_SIZE 16
+
+struct type_vec {
+	uint32_t *types;
+	unsigned int count, capacity;
+};
+
+static int type_vec_init(struct type_vec *v)
+{
+	v->capacity = TYPE_VEC_INIT_SIZE;
+	v->count = 0;
+	v->types = malloc(v->capacity * sizeof(*v->types));
+	if (!v->types)
+		return -1;
+	return 0;
+}
+
+static void type_vec_destroy(struct type_vec *v)
+{
+	free(v->types);
+}
+
+static int type_vec_append(struct type_vec *v, uint32_t type)
+{
+	if (v->capacity == v->count) {
+		unsigned int new_capacity = v->capacity * 2;
+		uint32_t *new_types = realloc(v->types,
+					      new_capacity * sizeof(*v->types));
+		if (!new_types)
+			return -1;
+
+		v->types = new_types;
+		v->capacity = new_capacity;
+	}
+
+	v->types[v->count++] = type;
+	return 0;
+}
+
+static int type_vec_contains(const struct type_vec *v, uint32_t type)
+{
+	unsigned int s = 0, e = v->count;
+
+	while (s != e) {
+		unsigned int mid = (s + e) / 2;
+
+		if (v->types[mid] == type)
+			return 1;
+
+		if (v->types[mid] < type)
+			s = mid + 1;
+		else
+			e = mid;
+	}
+	return 0;
+}
+
 /* builds map: type/attribute -> {all attributes that are a superset of it} */
-static ebitmap_t *build_type_map(const policydb_t *p)
+static struct type_vec *build_type_map(const policydb_t *p)
 {
 	unsigned int i, k;
-	ebitmap_t *map = malloc(p->p_types.nprim * sizeof(ebitmap_t));
+	ebitmap_node_t *n;
+	struct type_vec *map = malloc(p->p_types.nprim * sizeof(*map));
 	if (!map)
 		return NULL;
 
 	for (i = 0; i < p->p_types.nprim; i++) {
+		if (type_vec_init(&map[i]))
+			goto err;
+
 		if (p->type_val_to_struct[i]->flavor != TYPE_ATTRIB) {
-			if (ebitmap_cpy(&map[i], &p->type_attr_map[i]))
-				goto err;
+			ebitmap_for_each_positive_bit(&p->type_attr_map[i],
+						      n, k) {
+				if (type_vec_append(&map[i], k))
+					goto err;
+			}
 		} else {
 			ebitmap_t *types_i = &p->attr_type_map[i];
 
-			ebitmap_init(&map[i]);
 			for (k = 0; k < p->p_types.nprim; k++) {
 				ebitmap_t *types_k = &p->attr_type_map[k];
 
@@ -54,7 +117,7 @@ static ebitmap_t *build_type_map(const policydb_t *p)
 					continue;
 
 				if (ebitmap_contains(types_k, types_i)) {
-					if (ebitmap_set_bit(&map[i], k, 1))
+					if (type_vec_append(&map[i], k))
 						goto err;
 				}
 			}
@@ -63,16 +126,16 @@ static ebitmap_t *build_type_map(const policydb_t *p)
 	return map;
 err:
 	for (k = 0; k <= i; k++)
-		ebitmap_destroy(&map[k]);
+		type_vec_destroy(&map[k]);
 	free(map);
 	return NULL;
 }
 
-static void destroy_type_map(const policydb_t *p, ebitmap_t *type_map)
+static void destroy_type_map(const policydb_t *p, struct type_vec *type_map)
 {
 	unsigned int i;
 	for (i = 0; i < p->p_types.nprim; i++)
-		ebitmap_destroy(&type_map[i]);
+		type_vec_destroy(&type_map[i]);
 	free(type_map);
 }
 
@@ -125,10 +188,11 @@ static int process_avtab_datum(uint16_t specified,
 
 /* checks if avtab contains a rule that covers the given rule */
 static int is_avrule_redundant(avtab_ptr_t entry, avtab_t *tab,
-			       const ebitmap_t *type_map, unsigned char not_cond)
+			       const struct type_vec *type_map,
+			       unsigned char not_cond)
 {
 	unsigned int i, k, s_idx, t_idx;
-	ebitmap_node_t *snode, *tnode;
+	uint32_t st, tt;
 	avtab_datum_t *d1, *d2;
 	avtab_key_t key;
 
@@ -144,14 +208,17 @@ static int is_avrule_redundant(avtab_ptr_t entry, avtab_t *tab,
 
 	d1 = &entry->datum;
 
-	ebitmap_for_each_positive_bit(&type_map[s_idx], snode, i) {
-		key.source_type = i + 1;
+	for (i = 0; i < type_map[s_idx].count; i++) {
+		st = type_map[s_idx].types[i];
+		key.source_type = st + 1;
+
+		for (k = 0; k < type_map[t_idx].count; k++) {
+			tt = type_map[t_idx].types[k];
 
-		ebitmap_for_each_positive_bit(&type_map[t_idx], tnode, k) {
-			if (not_cond && s_idx == i && t_idx == k)
+			if (not_cond && s_idx == st && t_idx == tt)
 				continue;
 
-			key.target_type = k + 1;
+			key.target_type = tt + 1;
 
 			d2 = avtab_search(tab, &key);
 			if (!d2)
@@ -179,7 +246,7 @@ static int is_avrule_with_attr(avtab_ptr_t entry, policydb_t *p)
 
 /* checks if conditional list contains a rule that covers the given rule */
 static int is_cond_rule_redundant(avtab_ptr_t e1, cond_av_list_t *list,
-				  const ebitmap_t *type_map)
+				  const struct type_vec *type_map)
 {
 	unsigned int s1, t1, c1, k1, s2, t2, c2, k2;
 
@@ -205,9 +272,9 @@ static int is_cond_rule_redundant(avtab_ptr_t e1, cond_av_list_t *list,
 
 		if (s1 == s2 && t1 == t2)
 			continue;
-		if (!ebitmap_get_bit(&type_map[s1], s2))
+		if (!type_vec_contains(&type_map[s1], s2))
 			continue;
-		if (!ebitmap_get_bit(&type_map[t1], t2))
+		if (!type_vec_contains(&type_map[t1], t2))
 			continue;
 
 		if (process_avtab_datum(k1, &e1->datum, &e2->datum))
@@ -216,7 +283,7 @@ static int is_cond_rule_redundant(avtab_ptr_t e1, cond_av_list_t *list,
 	return 0;
 }
 
-static void optimize_avtab(policydb_t *p, const ebitmap_t *type_map)
+static void optimize_avtab(policydb_t *p, const struct type_vec *type_map)
 {
 	avtab_t *tab = &p->te_avtab;
 	unsigned int i;
@@ -245,7 +312,7 @@ static void optimize_avtab(policydb_t *p, const ebitmap_t *type_map)
 
 /* find redundant rules in (*cond) and put them into (*del) */
 static void optimize_cond_av_list(cond_av_list_t **cond, cond_av_list_t **del,
-				  policydb_t *p, const ebitmap_t *type_map)
+				  policydb_t *p, const struct type_vec *type_map)
 {
 	cond_av_list_t **listp = cond;
 	cond_av_list_t *pcov = NULL;
@@ -294,7 +361,7 @@ static void optimize_cond_av_list(cond_av_list_t **cond, cond_av_list_t **del,
 	}
 }
 
-static void optimize_cond_avtab(policydb_t *p, const ebitmap_t *type_map)
+static void optimize_cond_avtab(policydb_t *p, const struct type_vec *type_map)
 {
 	avtab_t *tab = &p->te_cond_avtab;
 	unsigned int i;
@@ -363,7 +430,7 @@ static void optimize_cond_avtab(policydb_t *p, const ebitmap_t *type_map)
 
 int policydb_optimize(policydb_t *p)
 {
-	ebitmap_t *type_map;
+	struct type_vec *type_map;
 
 	if (p->policy_type != POLICY_KERN)
 		return -1;
-- 
2.24.1

