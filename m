Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19ED18049
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646380; cv=none; b=UptjNWZoVdma3mPuUeNVWK3p7JE9RNuIO/6839wib6CcTJ/JVM6DohvBGjzjObbx9MAqMqGkjaqj6wqP0V/gYE6qNfYqQOvZwDE5XmqPh0Bfnk16bfdgIrVozOmWC4eFNqPW1NS4oJZf8IuUJpON1W7ca4lX75axI5Ax76TIUVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646380; c=relaxed/simple;
	bh=LMQq413Eqt2J4vjabr+uBZYJ04yAIPv9qQHjRm1R/MU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtnL8L5JtduCddx/XQPqHU46pvRhfrYPOjRoJE/bAwdPoofwSXNlNhR5cIcVEOE+JU0yyE8tTcIuzeQkz+78F4qHY28TJ2NM0SsPpmphkXLooXRLOv06YawjijwSuF81yoFfj9lY4MG04gDEEsbR3btWv0chiUYUpCK1+9NhGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PjsSDnYj; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PjsSDnYj"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-787a405e724so20666485a.0
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646377; x=1709251177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6W4PQhx/+ZIjjflGgrGprDfsDGNct6xtOBPwuAgZXA=;
        b=PjsSDnYjH4rDdRkzAdVHfiiug2fSOJbXAEiHT9axh6/TdUGBSBHga+8gVT/mfo+k1q
         cxq/Ju4tFFLullvuw8oURaHpOZ4qR53bSL+en4M/L5J0hxGYShtkPb4pj4n1Mbvj7Gzg
         gF+IsyfXrU1L3DP4e3mu4eFr0RG/M3gjshwOmzsqYvyDfebQgqPpZ5OptSAKB2zbcaMz
         h5cvXph6ZVA8UWXNA0PdLYfO6P8z/hCDtGrVXVoqP9LypnpLiU+YEfvFO2gPDFD2mSGV
         RRg818nQokwB763pziPVZrc0QwBegPSM9tu2eEIiXNSnvZlm73VpM7rvl4H2k4oFjZ18
         BgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646377; x=1709251177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6W4PQhx/+ZIjjflGgrGprDfsDGNct6xtOBPwuAgZXA=;
        b=JLLd4c/Mm4zFvAJxP4OZ5+ASjkJs1AJaXc+kAxT0AI16OFQ9UOXknZKj80Ip52EwjL
         kZtG5CJrfyP9B5w1NbF/P+Z8UeNjHiBecHKf1TpNdubW71DHkVsyaS3qB7psVWPqzVdH
         w9Ql9XtfRaQZ+v4tC+fB2mvc4XjhCPQNg7dBhDESrAqG/s4oORwJ9Vc6lWpjn6hG38tm
         tTW2cv/7Izn+pIyCTF08CHu96g0DlNO/whokNgUq/do+Hi7nkw1oXTugDwK3oIPd2k59
         l8LwfGPtdCPWQGn/kblMGw69eueTrLWjyjmxWJHEIyYlyjL8e9ilPmg3yRLzBFQGNp+l
         Jvow==
X-Gm-Message-State: AOJu0YyoDum7zxsSk4XchB+o25RrpSjWKhBkznBwMQyBadX6jmbMWNMP
	M07lY635QkVYzBkkq8kNxDmmFdym3fvA+eXB3Z636lavLp7cdReOm6RRCZqPUtfzgNtB6pYTckQ
	=
X-Google-Smtp-Source: AGHT+IGVd/9u3vQRts8kmHhVSb25brbZ8t+0GKycgx+KeMmhby9EUrig8LAFVSehbyDgunkuysxfjg==
X-Received: by 2002:a05:620a:108c:b0:787:2377:a392 with SMTP id g12-20020a05620a108c00b007872377a392mr598223qkk.24.1708646377274;
        Thu, 22 Feb 2024 15:59:37 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id os22-20020a05620a811600b007871bac855fsm5812441qkn.47.2024.02.22.15.59.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:36 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 04/21] selinux: fix style issues in security/selinux/ss/conditional.c
Date: Thu, 22 Feb 2024 18:52:22 -0500
Message-ID: <20240222235708.386652-27-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8139; i=paul@paul-moore.com; h=from:subject; bh=LMQq413Eqt2J4vjabr+uBZYJ04yAIPv9qQHjRm1R/MU=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl199nDmPxau9Ly5Dnd7awfxantZdRQgedtMtwd +czdA+X1MuJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdffZwAKCRDqIPLalzeJ c5r/EADDFZYbn+xzJ7AmvZMjtBXOl+RqOaRAjNkHxgCXV/iw12HyfDe2OBaP+SPBfx/qBuSMTh+ yjQ5t0JLBerGkSh0Z5rKjUpnqX6sVFrD7gB+miBvVaj4zRDpevwW+z9gzHuuvytyAZ3VzcAeWTk wamVZzB0yrkzCKXnafTevPAhyAkO21AvtRK9FUn4jvhKOLImqBE4cL/of03A1IdHhh2GW2VUveD V13iTMrF86BDdIl3HW0rzEjr7F/fSIvhl2SddE1VkqZKKlSwqGd4hljYTENJ24b1VDeWMeZg9l3 G/pTGdULukYikiBuaqD9ZVkUR9krtsTVRF3f+WkfhaGGlZSs8dMJM65gA23E1m9qkJ4mjOFFqjA 4HRhjghJsnSyZEeso72AllnSNBgTFrFKJRCSlgZP8ZM64PMUMvzLDxqHPzwoh71nYcJMxuIS86w cHRPUnoTDyLFBlsAeXUW7HvrkoUeg6GG6tByQNLgZArLK0Dxkft0DzRZ+w9zhhQ7mIpuJHeRTu1 w3I80ee+jQtYfb4CWtJakW8MHLxmYAktxmuN9qq+EW+1jdK9L3l9/vQvPf7VePgVvQdW0NYapz6 foJ/0IR8XAxzFI7wjtFKFURtYXH4jKmab/2iIH6xZHTOlwjZuIl33o5je8FaZngbNaIk2CqCkSt wek7P/WOQxqjKpg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/conditional.c | 68 +++++++++++++++----------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 81ff676f209a..f12476855b27 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -1,8 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0-only
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Authors: Karl MacMillan <kmacmillan@tresys.com>
  *	    Frank Mayer <mayerf@tresys.com>
- *
- * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *          Copyright (C) 2003 - 2004 Tresys Technology, LLC
  */
 
 #include <linux/kernel.h>
@@ -166,9 +165,8 @@ void cond_policydb_destroy(struct policydb *p)
 int cond_init_bool_indexes(struct policydb *p)
 {
 	kfree(p->bool_val_to_struct);
-	p->bool_val_to_struct = kmalloc_array(p->p_bools.nprim,
-					      sizeof(*p->bool_val_to_struct),
-					      GFP_KERNEL);
+	p->bool_val_to_struct = kmalloc_array(
+		p->p_bools.nprim, sizeof(*p->bool_val_to_struct), GFP_KERNEL);
 	if (!p->bool_val_to_struct)
 		return -ENOMEM;
 	return 0;
@@ -287,7 +285,8 @@ static int cond_insertf(struct avtab *a, const struct avtab_key *k,
 		if (other) {
 			node_ptr = avtab_search_node(&p->te_cond_avtab, k);
 			if (node_ptr) {
-				if (avtab_search_node_next(node_ptr, k->specified)) {
+				if (avtab_search_node_next(node_ptr,
+							   k->specified)) {
 					pr_err("SELinux: too many conflicting type rules.\n");
 					return -EINVAL;
 				}
@@ -478,8 +477,8 @@ int cond_write_bool(void *vkey, void *datum, void *ptr)
  * the conditional. This means that the avtab with the conditional
  * rules will not be saved but will be rebuilt on policy load.
  */
-static int cond_write_av_list(struct policydb *p,
-			      struct cond_av_list *list, struct policy_file *fp)
+static int cond_write_av_list(struct policydb *p, struct cond_av_list *list,
+			      struct policy_file *fp)
 {
 	__le32 buf[1];
 	u32 i;
@@ -500,7 +499,7 @@ static int cond_write_av_list(struct policydb *p,
 }
 
 static int cond_write_node(struct policydb *p, struct cond_node *node,
-		    struct policy_file *fp)
+			   struct policy_file *fp)
 {
 	__le32 buf[2];
 	int rc;
@@ -555,7 +554,7 @@ int cond_write_list(struct policydb *p, void *fp)
 }
 
 void cond_compute_xperms(struct avtab *ctab, struct avtab_key *key,
-		struct extended_perms_decision *xpermd)
+			 struct extended_perms_decision *xpermd)
 {
 	struct avtab_node *node;
 
@@ -563,7 +562,7 @@ void cond_compute_xperms(struct avtab *ctab, struct avtab_key *key,
 		return;
 
 	for (node = avtab_search_node(ctab, key); node;
-			node = avtab_search_node_next(node, key->specified)) {
+	     node = avtab_search_node_next(node, key->specified)) {
 		if (node->key.specified & AVTAB_ENABLED)
 			services_compute_xperms_decision(xpermd, node);
 	}
@@ -572,7 +571,7 @@ void cond_compute_xperms(struct avtab *ctab, struct avtab_key *key,
  * av table, and if so, add them to the result
  */
 void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
-		struct av_decision *avd, struct extended_perms *xperms)
+		     struct av_decision *avd, struct extended_perms *xperms)
 {
 	struct avtab_node *node;
 
@@ -580,30 +579,29 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
 		return;
 
 	for (node = avtab_search_node(ctab, key); node;
-				node = avtab_search_node_next(node, key->specified)) {
-		if ((u16)(AVTAB_ALLOWED|AVTAB_ENABLED) ==
-		    (node->key.specified & (AVTAB_ALLOWED|AVTAB_ENABLED)))
+	     node = avtab_search_node_next(node, key->specified)) {
+		if ((u16)(AVTAB_ALLOWED | AVTAB_ENABLED) ==
+		    (node->key.specified & (AVTAB_ALLOWED | AVTAB_ENABLED)))
 			avd->allowed |= node->datum.u.data;
-		if ((u16)(AVTAB_AUDITDENY|AVTAB_ENABLED) ==
-		    (node->key.specified & (AVTAB_AUDITDENY|AVTAB_ENABLED)))
+		if ((u16)(AVTAB_AUDITDENY | AVTAB_ENABLED) ==
+		    (node->key.specified & (AVTAB_AUDITDENY | AVTAB_ENABLED)))
 			/* Since a '0' in an auditdeny mask represents a
 			 * permission we do NOT want to audit (dontaudit), we use
 			 * the '&' operand to ensure that all '0's in the mask
 			 * are retained (much unlike the allow and auditallow cases).
 			 */
 			avd->auditdeny &= node->datum.u.data;
-		if ((u16)(AVTAB_AUDITALLOW|AVTAB_ENABLED) ==
-		    (node->key.specified & (AVTAB_AUDITALLOW|AVTAB_ENABLED)))
+		if ((u16)(AVTAB_AUDITALLOW | AVTAB_ENABLED) ==
+		    (node->key.specified & (AVTAB_AUDITALLOW | AVTAB_ENABLED)))
 			avd->auditallow |= node->datum.u.data;
 		if (xperms && (node->key.specified & AVTAB_ENABLED) &&
-				(node->key.specified & AVTAB_XPERMS))
+		    (node->key.specified & AVTAB_XPERMS))
 			services_compute_xperms_drivers(xperms, node);
 	}
 }
 
-static int cond_dup_av_list(struct cond_av_list *new,
-			struct cond_av_list *orig,
-			struct avtab *avtab)
+static int cond_dup_av_list(struct cond_av_list *new, struct cond_av_list *orig,
+			    struct avtab *avtab)
 {
 	u32 i;
 
@@ -614,9 +612,8 @@ static int cond_dup_av_list(struct cond_av_list *new,
 		return -ENOMEM;
 
 	for (i = 0; i < orig->len; i++) {
-		new->nodes[i] = avtab_insert_nonunique(avtab,
-						       &orig->nodes[i]->key,
-						       &orig->nodes[i]->datum);
+		new->nodes[i] = avtab_insert_nonunique(
+			avtab, &orig->nodes[i]->key, &orig->nodes[i]->datum);
 		if (!new->nodes[i])
 			return -ENOMEM;
 		new->len++;
@@ -637,8 +634,7 @@ static int duplicate_policydb_cond_list(struct policydb *newp,
 
 	newp->cond_list_len = 0;
 	newp->cond_list = kcalloc(origp->cond_list_len,
-				sizeof(*newp->cond_list),
-				GFP_KERNEL);
+				  sizeof(*newp->cond_list), GFP_KERNEL);
 	if (!newp->cond_list)
 		goto error;
 
@@ -649,7 +645,8 @@ static int duplicate_policydb_cond_list(struct policydb *newp,
 		newp->cond_list_len++;
 
 		newn->cur_state = orign->cur_state;
-		newn->expr.nodes = kmemdup(orign->expr.nodes,
+		newn->expr.nodes =
+			kmemdup(orign->expr.nodes,
 				orign->expr.len * sizeof(*orign->expr.nodes),
 				GFP_KERNEL);
 		if (!newn->expr.nodes)
@@ -658,12 +655,12 @@ static int duplicate_policydb_cond_list(struct policydb *newp,
 		newn->expr.len = orign->expr.len;
 
 		rc = cond_dup_av_list(&newn->true_list, &orign->true_list,
-				&newp->te_cond_avtab);
+				      &newp->te_cond_avtab);
 		if (rc)
 			goto error;
 
 		rc = cond_dup_av_list(&newn->false_list, &orign->false_list,
-				&newp->te_cond_avtab);
+				      &newp->te_cond_avtab);
 		if (rc)
 			goto error;
 	}
@@ -683,7 +680,8 @@ static int cond_bools_destroy(void *key, void *datum, void *args)
 	return 0;
 }
 
-static int cond_bools_copy(struct hashtab_node *new, struct hashtab_node *orig, void *args)
+static int cond_bools_copy(struct hashtab_node *new, struct hashtab_node *orig,
+			   void *args)
 {
 	struct cond_bool_datum *datum;
 
@@ -709,7 +707,7 @@ static int cond_bools_index(void *key, void *datum, void *args)
 }
 
 static int duplicate_policydb_bools(struct policydb *newdb,
-				struct policydb *orig)
+				    struct policydb *orig)
 {
 	struct cond_bool_datum **cond_bool_array;
 	int rc;
@@ -721,7 +719,7 @@ static int duplicate_policydb_bools(struct policydb *newdb,
 		return -ENOMEM;
 
 	rc = hashtab_duplicate(&newdb->p_bools.table, &orig->p_bools.table,
-			cond_bools_copy, cond_bools_destroy, NULL);
+			       cond_bools_copy, cond_bools_destroy, NULL);
 	if (rc) {
 		kfree(cond_bool_array);
 		return -ENOMEM;
-- 
2.43.2

