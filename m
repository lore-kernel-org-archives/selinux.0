Return-Path: <SRS0=VF96=T5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0B3C46470
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 07:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175CC208C3
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 07:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfE2HiI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 May 2019 03:38:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55532 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfE2HiI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 May 2019 03:38:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id u78so833949wmu.5
        for <selinux@vger.kernel.org>; Wed, 29 May 2019 00:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sMI4yLZPripAM6IR7UVjCl1/ss7b2U9TPNkrY0JZSic=;
        b=mdyqXdY7ezEWxZd54nzIe2+q3X8f4T8ZVnPNUuEGEGzU6/kJVJj5B5ZPJz6k2FYJtF
         2Zi5bcWEF0qov5GZh72Pidox7SQyjN75Wc75DMeoha23cBBtaoIL8gOf5k7wFSZ6bxFV
         A+w/mvNzo9/E5D28tZNN5vOfUVForbdrHLJJ+RSPlgzpQfh1wmxa7rvxigwUeeuYimlW
         HuNW8wzQTFRf1/QnfF/buU7g3DH1G682P4DJGOWNDVqEfBV7TfUTCP2Tezy5MpQ44fs0
         uEy35kAhyi1wm8yMnX41HMgbwjocsYn/hcJ+EsDWdkGKx/G1VvF3aSwBK++7EgCdWQZq
         sSgA==
X-Gm-Message-State: APjAAAVBq8M+JG0pAcWqwyPO6Xu6qcTdznoSUOEMPI3ETj816Tv5/jD6
        yIR8H/NfsnMFWeeo/CrSul0sTfgLXN0=
X-Google-Smtp-Source: APXvYqycOxbMOtmYZMgtB/bpL7IYw24JyeQHl+bgljS50sMcKg4wky8O6aFXQgU6pwLwCxdZfBBTnQ==
X-Received: by 2002:a1c:1947:: with SMTP id 68mr5832881wmz.171.1559115484287;
        Wed, 29 May 2019 00:38:04 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p16sm32024877wrg.49.2019.05.29.00.38.03
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 00:38:03 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v3 1/7] libsepol: add a function to optimize kernel policy
Date:   Wed, 29 May 2019 09:37:53 +0200
Message-Id: <20190529073759.20548-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529073759.20548-1-omosnace@redhat.com>
References: <20190529073759.20548-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add sepol_policydb_optimize(), which checks a kernel policy for
redundant rules (i.e. those that are covered by an existing more general
rule) and removes them.

Results on Fedora 29 policy:

WITHOUT OPTIMIZATION:
    # time semodule -B
    real    0m21,280s
    user    0m18,636s
    sys     0m2,525s

    $ wc -c /sys/fs/selinux/policy
    8692158 /sys/fs/selinux/policy

    $ seinfo (edited)
      Allow:            113159
      Dontaudit:         10297
      Total:            123156

WITH OPTIMIZATION ENABLED:
    # time semodule -B
    real    0m22,825s
    user    0m20,178s
    sys     0m2,520s

    $ wc -c /sys/fs/selinux/policy
    8096158 /sys/fs/selinux/policy

    $ seinfo (edited)
      Allow:             66334
      Dontaudit:          7480
      Total:             73814

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/include/sepol/policydb.h          |   5 +
 libsepol/include/sepol/policydb/policydb.h |   2 +
 libsepol/src/libsepol.map.in               |   5 +
 libsepol/src/optimize.c                    | 374 +++++++++++++++++++++
 libsepol/src/policydb_public.c             |   5 +
 5 files changed, 391 insertions(+)
 create mode 100644 libsepol/src/optimize.c

diff --git a/libsepol/include/sepol/policydb.h b/libsepol/include/sepol/policydb.h
index 6769b913..792913dd 100644
--- a/libsepol/include/sepol/policydb.h
+++ b/libsepol/include/sepol/policydb.h
@@ -100,6 +100,11 @@ extern int sepol_policydb_set_handle_unknown(sepol_policydb_t * p,
 extern int sepol_policydb_set_target_platform(sepol_policydb_t * p,
 					     int target_platform);
 
+/*
+ * Optimize the policy by removing redundant rules.
+ */
+extern int sepol_policydb_optimize(sepol_policydb_t * p);
+
 /* 
  * Read a policydb from a policy file.
  * This automatically sets the type and version based on the 
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 591ce6e0..a279382e 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -636,6 +636,8 @@ extern int policydb_user_cache(hashtab_key_t key,
 
 extern int policydb_reindex_users(policydb_t * p);
 
+extern int policydb_optimize(policydb_t * p);
+
 extern void policydb_destroy(policydb_t * p);
 
 extern int policydb_load_isids(policydb_t * p, sidtab_t * s);
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index d879016c..6358e51f 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -59,3 +59,8 @@ LIBSEPOL_1.1 {
 	sepol_polcap_getnum;
 	sepol_polcap_getname;
 } LIBSEPOL_1.0;
+
+LIBSEPOL_1.2 {
+  global:
+	sepol_optimize_policy;
+} LIBSEPOL_1.1;
diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
new file mode 100644
index 00000000..b3859b6c
--- /dev/null
+++ b/libsepol/src/optimize.c
@@ -0,0 +1,374 @@
+/*
+ * Author: Ondrej Mosnacek <omosnacek@gmail.com>
+ *
+ * Copyright (C) 2019 Red Hat Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+/*
+ * Binary policy optimization.
+ *
+ * Defines the policydb_optimize() function, which finds and removes
+ * redundant rules from the binary policy to reduce its size and potentially
+ * improve rule matching times. Only rules that are already covered by a
+ * more general rule are removed. The resulting policy is functionally
+ * equivalent to the original one.
+ */
+
+#include <sepol/policydb/policydb.h>
+#include <sepol/policydb/conditional.h>
+
+/* builds map: type/attribute -> {all attributes that are a superset of it} */
+static ebitmap_t *build_type_map(const policydb_t *p)
+{
+	unsigned int i, k;
+	ebitmap_t *map = malloc(p->p_types.nprim * sizeof(ebitmap_t));
+	if (!map)
+		return NULL;
+
+	for (i = 0; i < p->p_types.nprim; i++) {
+		if (p->type_val_to_struct[i] &&
+		    p->type_val_to_struct[i]->flavor != TYPE_ATTRIB) {
+			if (ebitmap_cpy(&map[i], &p->type_attr_map[i]))
+				goto err;
+		} else {
+			ebitmap_t *types_i = &p->attr_type_map[i];
+
+			ebitmap_init(&map[i]);
+			for (k = 0; k < p->p_types.nprim; k++) {
+				ebitmap_t *types_k = &p->attr_type_map[k];
+
+				if (ebitmap_contains(types_k, types_i)) {
+					if (ebitmap_set_bit(&map[i], k, 1))
+						goto err;
+				}
+			}
+		}
+	}
+	return map;
+err:
+	for (k = 0; k < i; k++)
+		ebitmap_destroy(&map[i]);
+	return NULL;
+}
+
+static void destroy_type_map(const policydb_t *p, ebitmap_t *type_map)
+{
+	unsigned int i;
+	for (i = 0; i < p->p_types.nprim; i++)
+		ebitmap_destroy(&type_map[i]);
+	free(type_map);
+}
+
+static int match_xperms(const uint32_t *p1, const uint32_t *p2)
+{
+	size_t i;
+
+	for (i = 0; i < EXTENDED_PERMS_LEN; i++) {
+		if ((p2[i] & p1[i]) != p1[i])
+			return 0;
+	}
+	return 1;
+}
+
+static int match_avtab_datum(uint16_t specified,
+			     const avtab_datum_t *d1, const avtab_datum_t *d2)
+{
+	/* inverse logic needed for AUDITDENY rules */
+	if (specified & AVTAB_AUDITDENY)
+		return (d1->data & d2->data) == d2->data;
+
+	if (specified & AVTAB_AV)
+		return (d2->data & d1->data) == d1->data;
+
+	if (specified & AVTAB_XPERMS) {
+		const avtab_extended_perms_t *x1 = d1->xperms;
+		const avtab_extended_perms_t *x2 = d2->xperms;
+
+		if (x1->specified == AVTAB_XPERMS_IOCTLFUNCTION) {
+			if (x2->specified == AVTAB_XPERMS_IOCTLFUNCTION) {
+				if (x1->driver != x2->driver)
+					return 0;
+				return match_xperms(x1->perms, x2->perms);
+			}
+			if (x2->specified == AVTAB_XPERMS_IOCTLDRIVER)
+				return xperm_test(x1->driver, x2->perms);
+		} else if (x1->specified == AVTAB_XPERMS_IOCTLDRIVER) {
+			if (x2->specified == AVTAB_XPERMS_IOCTLFUNCTION)
+				return 0;
+
+			if (x2->specified == AVTAB_XPERMS_IOCTLDRIVER)
+				return match_xperms(x1->perms, x2->perms);
+		}
+		return 0;
+	}
+	return 0;
+}
+
+/* checks if avtab contains a rule that covers the given rule */
+static int is_avrule_redundant(avtab_ptr_t entry, avtab_t *tab,
+			       const ebitmap_t *type_map)
+{
+	unsigned int i, k, s_idx, t_idx;
+	ebitmap_node_t *snode, *tnode;
+	avtab_datum_t *d1, *d2;
+	avtab_key_t key;
+
+	/* we only care about AV rules */
+	if (!(entry->key.specified & (AVTAB_AV|AVTAB_XPERMS)))
+		return 0;
+
+	s_idx = entry->key.source_type - 1;
+	t_idx = entry->key.target_type - 1;
+
+	key.target_class = entry->key.target_class;
+	key.specified    = entry->key.specified;
+
+	d1 = &entry->datum;
+
+	ebitmap_for_each_positive_bit(&type_map[s_idx], snode, i) {
+		key.source_type = i + 1;
+
+		ebitmap_for_each_positive_bit(&type_map[t_idx], tnode, k) {
+			if (s_idx == i && t_idx == k)
+				continue;
+
+			key.target_type = k + 1;
+
+			d2 = avtab_search(tab, &key);
+			if (!d2)
+				continue;
+
+			if (match_avtab_datum(key.specified, d1, d2))
+				return 1;
+		}
+	}
+	return 0;
+}
+
+static int is_type_attr(policydb_t *p, unsigned int id)
+{
+	return p->type_val_to_struct[id]->flavor == TYPE_ATTRIB;
+}
+
+static int is_avrule_with_attr(avtab_ptr_t entry, policydb_t *p)
+{
+	unsigned int s_idx = entry->key.source_type - 1;
+	unsigned int t_idx = entry->key.target_type - 1;
+
+	return is_type_attr(p, s_idx) || is_type_attr(p, t_idx);
+}
+
+/* checks if conditional list contains a rule that covers the given rule */
+static int is_cond_rule_redundant(avtab_ptr_t e1, cond_av_list_t *list,
+				  const ebitmap_t *type_map)
+{
+	unsigned int s1, t1, c1, k1, s2, t2, c2, k2;
+
+	/* we only care about AV rules */
+	if (!(e1->key.specified & (AVTAB_AV|AVTAB_XPERMS)))
+		return 0;
+
+	s1 = e1->key.source_type - 1;
+	t1 = e1->key.target_type - 1;
+	c1 = e1->key.target_class;
+	k1 = e1->key.specified;
+
+	for (; list; list = list->next) {
+		avtab_ptr_t e2 = list->node;
+
+		s2 = e2->key.source_type - 1;
+		t2 = e2->key.target_type - 1;
+		c2 = e2->key.target_class;
+		k2 = e2->key.specified;
+
+		if (k1 != k2 || c1 != c2)
+			continue;
+
+		if (s1 == s2 && t1 == t2)
+			continue;
+		if (!ebitmap_get_bit(&type_map[s1], s2))
+			continue;
+		if (!ebitmap_get_bit(&type_map[t1], t2))
+			continue;
+
+		if (match_avtab_datum(k1, &e1->datum, &e2->datum))
+			return 1;
+	}
+	return 0;
+}
+
+static void optimize_avtab(policydb_t *p, const ebitmap_t *type_map)
+{
+	avtab_t *tab = &p->te_avtab;
+	unsigned int i;
+	avtab_ptr_t *cur;
+
+	for (i = 0; i < tab->nslot; i++) {
+		cur = &tab->htable[i];
+		while (*cur) {
+			if (is_avrule_redundant(*cur, tab, type_map)) {
+				/* redundant rule -> remove it */
+				avtab_ptr_t tmp = *cur;
+
+				*cur = tmp->next;
+				if (tmp->key.specified & AVTAB_XPERMS)
+					free(tmp->datum.xperms);
+				free(tmp);
+
+				tab->nel--;
+			} else {
+				/* rule not redundant -> move to next rule */
+				cur = &(*cur)->next;
+			}
+		}
+	}
+}
+
+/* find redundant rules in (*cond) and put them into (*del) */
+static void optimize_cond_av_list(cond_av_list_t **cond, cond_av_list_t **del,
+				  policydb_t *p, const ebitmap_t *type_map)
+{
+	cond_av_list_t **listp = cond;
+	cond_av_list_t *pcov = NULL;
+	cond_av_list_t **pcov_cur = &pcov;
+
+	/*
+	 * Separate out all "potentially covering" rules (src or tgt is an attr)
+	 * and move them to the end of the list. This is needed to avoid
+	 * polynomial complexity when almost all rules are expanded.
+	 */
+	while (*cond) {
+		if (is_avrule_with_attr((*cond)->node, p)) {
+			cond_av_list_t *tmp = *cond;
+
+			*cond = tmp->next;
+			tmp->next = pcov;
+			pcov = tmp;
+		} else {
+			cond = &(*cond)->next;
+		}
+	}
+	/* link the "potentially covering" rules to the end of the list */
+	*cond = pcov;
+
+	/* now go through the list and find the redundant rules */
+	cond = listp;
+	pcov_cur = &pcov;
+	while (*cond) {
+		/* needed because pcov itself may get deleted */
+		if (*cond == pcov)
+			pcov_cur = cond;
+		/*
+		 * First check if covered by an unconditional rule, then also
+		 * check if covered by another rule in the same list.
+		 */
+		if (is_avrule_redundant((*cond)->node, &p->te_avtab, type_map) ||
+		    is_cond_rule_redundant((*cond)->node, *pcov_cur, type_map)) {
+			cond_av_list_t *tmp = *cond;
+
+			*cond = tmp->next;
+			tmp->next = *del;
+			*del = tmp;
+		} else {
+			cond = &(*cond)->next;
+		}
+	}
+}
+
+static void optimize_cond_avtab(policydb_t *p, const ebitmap_t *type_map)
+{
+	avtab_t *tab = &p->te_cond_avtab;
+	unsigned int i;
+	avtab_ptr_t *cur;
+	cond_node_t **cond;
+	cond_av_list_t **avcond, *del = NULL;
+
+	/* First go through all conditionals and collect redundant rules. */
+	cond = &p->cond_list;
+	while (*cond) {
+		optimize_cond_av_list(&(*cond)->true_list,  &del, p, type_map);
+		optimize_cond_av_list(&(*cond)->false_list, &del, p, type_map);
+		/* TODO: maybe also check for rules present in both lists */
+
+		/* nothing left in both lists -> remove the whole conditional */
+		if (!(*cond)->true_list && !(*cond)->false_list) {
+			cond_node_t *cond_tmp = *cond;
+
+			*cond = cond_tmp->next;
+			cond_node_destroy(cond_tmp);
+		} else {
+			cond = &(*cond)->next;
+		}
+	}
+
+	if (!del)
+		return;
+
+	/*
+	 * Now go through the whole cond_avtab and remove all rules that are
+	 * found in the 'del' list.
+	 */
+	for (i = 0; i < tab->nslot; i++) {
+		cur = &tab->htable[i];
+		while (*cur) {
+			int redundant = 0;
+			avcond = &del;
+			while (*avcond) {
+				if ((*avcond)->node == *cur) {
+					cond_av_list_t *cond_tmp = *avcond;
+
+					*avcond = cond_tmp->next;
+					free(cond_tmp);
+					redundant = 1;
+					break;
+				} else {
+					avcond = &(*avcond)->next;
+				}
+			}
+			if (redundant) {
+				avtab_ptr_t tmp = *cur;
+
+				*cur = tmp->next;
+				if (tmp->key.specified & AVTAB_XPERMS)
+					free(tmp->datum.xperms);
+				free(tmp);
+
+				tab->nel--;
+			} else {
+				cur = &(*cur)->next;
+			}
+		}
+	}
+}
+
+int policydb_optimize(policydb_t *p)
+{
+	ebitmap_t *type_map;
+
+	if (p->policy_type != POLICY_KERN)
+		return -1;
+
+	type_map = build_type_map(p);
+	if (!type_map)
+		return -1;
+
+	optimize_avtab(p, type_map);
+	optimize_cond_avtab(p, type_map);
+
+	destroy_type_map(p, type_map);
+	return 0;
+}
diff --git a/libsepol/src/policydb_public.c b/libsepol/src/policydb_public.c
index e7218423..747a43ff 100644
--- a/libsepol/src/policydb_public.c
+++ b/libsepol/src/policydb_public.c
@@ -169,6 +169,11 @@ int sepol_policydb_set_target_platform(sepol_policydb_t * sp,
 	return 0;
 }
 
+int sepol_policydb_optimize(sepol_policydb_t * p)
+{
+	return policydb_optimize(&p->p);
+}
+
 int sepol_policydb_read(sepol_policydb_t * p, sepol_policy_file_t * pf)
 {
 	return policydb_read(&p->p, &pf->pf, 0);
-- 
2.20.1

