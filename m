Return-Path: <SRS0=GpsN=BV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7B6C433E0
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 19:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 636CC206DA
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 19:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnK6oMPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgHKTCJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKTCI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Aug 2020 15:02:08 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1A0C06174A
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 12:02:08 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l64so12648527qkb.8
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 12:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2PNmGXChGzKvhSYMXG+SLB/AClSxFR+A8Zco7AsvLcw=;
        b=HnK6oMPHhdPMxbX5NMVJZjOfWJC3Q8vEl4LyU1kBwH53e/9iS9KzPlWMma0tQBzViy
         3po5A62NVmYIa64gzuXFq7FfU4mQKeYIvhqRFSuDWEy93qSd+ZB0kX+mda6vzb9vGV+/
         Rs0614vtt/x8OU4NXfGGs2GptbK52bn3crNb/TK4GvLDK0gw66pHHiA4sTfpkLVSH9SM
         A2LY0MxjXNrpjwefphnKSOSvUF7JKNerD5ia8CrJ0UECa0uQ79Exn0/FiY0k4Pbwmb8n
         lkoxYto5TUuaEBZCL7gB7nBO/WnfGVDGepjzGSPJdutayWNPe2cE4ENTVMivZ+CVbRDF
         tNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2PNmGXChGzKvhSYMXG+SLB/AClSxFR+A8Zco7AsvLcw=;
        b=orjfxP6msk7uEa9wItAtJ1zhm37RR8iv6BnhdLzviPPlSAtwIp14nBOjBgH+irns5O
         rDbZnBKw87L/MBHuNBzaYJUtiN20MpLfyLKXuC91CWL7YulDOzEqL8KdE0ueiPyzyRbp
         U14i+vGMnuqZ6JxQWfSMnX/eA0/JGSBgm27eS2PbuieK18985MxQRRhG8Wh37/eSvQgG
         buz9UEcfa/+OWlLkuTZNDkoG8HKUSF7HC3wLplxuq4zytZBQfSQoAF/wEtAaxSLOcq86
         9X9Poq0+JVxAXEKxIZkRiT4xVUEFlx5KHeqUFGVMGH9TqBUmZcLdEzHLhSRqjR/LCd+O
         9P6g==
X-Gm-Message-State: AOAM531cQCWodTRa8oKCJP7Yxonw4VL/5QWhy4Li45MJmjwK0II6rQBl
        YYwlSCnK9wlnxzWXEch1mpE=
X-Google-Smtp-Source: ABdhPJzFjkuZfRSwBs101MzBt2TtxwXVqgXh87hymkJDTDKlBiBcgtBPnSsI3s/q8I0V7k9L7+dOBA==
X-Received: by 2002:a37:553:: with SMTP id 80mr2453587qkf.291.1597172527438;
        Tue, 11 Aug 2020 12:02:07 -0700 (PDT)
Received: from puritycontrol.fios-router.home (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id u37sm21386131qtj.47.2020.08.11.12.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 12:02:06 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     paul@paul-moore.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        peter.enderborg@sony.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] selinux: refactor changing booleans
Date:   Tue, 11 Aug 2020 15:01:56 -0400
Message-Id: <20200811190156.31193-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Refactor the logic for changing SELinux policy booleans in a similar
manner to the refactoring of policy load, thereby reducing the
size of the critical section when the policy write-lock is held
and making it easier to convert the policy rwlock to RCU in the
future.  Instead of directly modifying the policydb in place, modify
a copy and then swap it into place through a single pointer update.
Only fully copy the portions of the policydb that are affected by
boolean changes to avoid the full cost of a deep policydb copy.
Introduce another level of indirection for the sidtab since changing
booleans does not require updating the sidtab, unlike policy load.
While we are here, create a common helper for notifying
other kernel components and userspace of a policy change and call it
from both security_set_bools() and selinux_policy_commit().

Based on an old (2004) patch by Kaigai Kohei [1] to convert the policy
rwlock to RCU that was deferred at the time since it did not
significantly improve performance and introduced complexity. Peter
Enderborg later submitted a patch series to convert to RCU [2] that
would have made changing booleans a much more expensive operation
by requiring a full policydb_write();policydb_read(); sequence to
deep copy the entire policydb and also had concerns regarding
atomic allocations.

This change is now simplified by the earlier work to encapsulate
policy state in the selinux_policy struct and to refactor
policy load.  After this change, the last major obstacle to
converting the policy rwlock to RCU is likely the sidtab live
convert support.

[1] https://lore.kernel.org/selinux/6e2f9128-e191-ebb3-0e87-74bfccb0767f@tycho.nsa.gov/
[2] https://lore.kernel.org/selinux/20180530141104.28569-1-peter.enderborg@sony.com/

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 fixes a memory leak of the oldpolicy structure in security_set_bools().
Thanks, kmemleak!

 security/selinux/ss/avtab.c       |  49 ++++++++-
 security/selinux/ss/avtab.h       |   1 +
 security/selinux/ss/conditional.c | 156 ++++++++++++++++++++++++++++
 security/selinux/ss/conditional.h |   2 +
 security/selinux/ss/hashtab.c     |  53 ++++++++++
 security/selinux/ss/hashtab.h     |   6 ++
 security/selinux/ss/services.c    | 163 ++++++++++++++++++------------
 security/selinux/ss/services.h    |   2 +-
 8 files changed, 368 insertions(+), 64 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 01b300a4a882..0172d87e2b9a 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -301,7 +301,6 @@ void avtab_destroy(struct avtab *h)
 
 void avtab_init(struct avtab *h)
 {
-	kvfree(h->htable);
 	h->htable = NULL;
 	h->nel = 0;
 }
@@ -340,6 +339,54 @@ int avtab_alloc(struct avtab *h, u32 nrules)
 	return 0;
 }
 
+int avtab_duplicate(struct avtab *new, struct avtab *orig)
+{
+	int i;
+	struct avtab_node *node, *tmp, *tail;
+
+	memset(new, 0, sizeof(*new));
+
+	new->htable = kvcalloc(orig->nslot, sizeof(void *), GFP_KERNEL);
+	if (!new->htable)
+		return -ENOMEM;
+	new->nslot = orig->nslot;
+	new->mask = orig->mask;
+
+	for (i = 0; i < orig->nslot; i++) {
+		tail = NULL;
+		for (node = orig->htable[i]; node; node = node->next) {
+			tmp = kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
+			if (!tmp)
+				goto error;
+			tmp->key = node->key;
+			if (tmp->key.specified & AVTAB_XPERMS) {
+				tmp->datum.u.xperms =
+					kmem_cache_zalloc(avtab_xperms_cachep,
+							GFP_KERNEL);
+				if (!tmp->datum.u.xperms) {
+					kmem_cache_free(avtab_node_cachep, tmp);
+					goto error;
+				}
+				tmp->datum.u.xperms = node->datum.u.xperms;
+			} else
+				tmp->datum.u.data = node->datum.u.data;
+
+			if (tail)
+				tail->next = tmp;
+			else
+				new->htable[i] = tmp;
+
+			tail = tmp;
+			new->nel++;
+		}
+	}
+
+	return 0;
+error:
+	avtab_destroy(new);
+	return -ENOMEM;
+}
+
 void avtab_hash_eval(struct avtab *h, char *tag)
 {
 	int i, chain_len, slots_used, max_chain_len;
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 5fdcb6696bcc..4c4445ca9118 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -89,6 +89,7 @@ struct avtab {
 
 void avtab_init(struct avtab *h);
 int avtab_alloc(struct avtab *, u32);
+int avtab_duplicate(struct avtab *new, struct avtab *orig);
 struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *k);
 void avtab_destroy(struct avtab *h);
 void avtab_hash_eval(struct avtab *h, char *tag);
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index e68dd2e4cac1..92c7a313327e 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -605,3 +605,159 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
 			services_compute_xperms_drivers(xperms, node);
 	}
 }
+
+static int cond_dup_av_list(struct cond_av_list *new,
+			struct cond_av_list *orig,
+			struct avtab *avtab)
+{
+	struct avtab_node *avnode;
+	u32 i;
+
+	memset(new, 0, sizeof(*new));
+
+	new->nodes = kcalloc(orig->len, sizeof(*new->nodes), GFP_KERNEL);
+	if (!new->nodes)
+		return -ENOMEM;
+
+	for (i = 0; i < orig->len; i++) {
+		avnode = avtab_search_node(avtab, &orig->nodes[i]->key);
+		if (WARN_ON(!avnode))
+			return -EINVAL;
+		new->nodes[i] = avnode;
+		new->len++;
+	}
+
+	return 0;
+}
+
+static int duplicate_policydb_cond_list(struct policydb *newp,
+					struct policydb *origp)
+{
+	int rc, i, j;
+
+	rc = avtab_duplicate(&newp->te_cond_avtab, &origp->te_cond_avtab);
+	if (rc)
+		return rc;
+
+	newp->cond_list_len = 0;
+	newp->cond_list = kcalloc(origp->cond_list_len,
+				sizeof(*newp->cond_list),
+				GFP_KERNEL);
+	if (!newp->cond_list)
+		goto error;
+
+	for (i = 0; i < origp->cond_list_len; i++) {
+		struct cond_node *newn = &newp->cond_list[i];
+		struct cond_node *orign = &origp->cond_list[i];
+
+		newp->cond_list_len++;
+
+		newn->cur_state = orign->cur_state;
+		newn->expr.nodes = kcalloc(orign->expr.len,
+					sizeof(*newn->expr.nodes), GFP_KERNEL);
+		if (!newn->expr.nodes)
+			goto error;
+		for (j = 0; j < orign->expr.len; j++)
+			newn->expr.nodes[j] = orign->expr.nodes[j];
+		newn->expr.len = orign->expr.len;
+
+		rc = cond_dup_av_list(&newn->true_list, &orign->true_list,
+				&newp->te_cond_avtab);
+		if (rc)
+			goto error;
+
+		rc = cond_dup_av_list(&newn->false_list, &orign->false_list,
+				&newp->te_cond_avtab);
+		if (rc)
+			goto error;
+	}
+
+	return 0;
+
+error:
+	avtab_destroy(&newp->te_cond_avtab);
+	cond_list_destroy(newp);
+	return -ENOMEM;
+}
+
+static int cond_bools_destroy(void *key, void *datum, void *args)
+{
+	/* key was not copied so no need to free here */
+	kfree(datum);
+	return 0;
+}
+
+static int cond_bools_copy(struct hashtab_node *new, struct hashtab_node *orig, void *args)
+{
+	struct cond_bool_datum *datum;
+
+	datum = kmalloc(sizeof(struct cond_bool_datum), GFP_KERNEL);
+	if (!datum)
+		return -ENOMEM;
+
+	memcpy(datum, orig->datum, sizeof(struct cond_bool_datum));
+
+	new->key = orig->key; /* No need to copy, never modified */
+	new->datum = datum;
+	return 0;
+}
+
+static int cond_bools_index(void *key, void *datum, void *args)
+{
+	struct cond_bool_datum *booldatum, **cond_bool_array;
+
+	booldatum = datum;
+	cond_bool_array = args;
+	cond_bool_array[booldatum->value - 1] = booldatum;
+
+	return 0;
+}
+
+static int duplicate_policydb_bools(struct policydb *newdb,
+				struct policydb *orig)
+{
+	struct cond_bool_datum **cond_bool_array;
+	int rc;
+
+	cond_bool_array = kmalloc_array(orig->p_bools.nprim,
+					sizeof(*orig->bool_val_to_struct),
+					GFP_KERNEL);
+	if (!cond_bool_array)
+		return -ENOMEM;
+
+	rc = hashtab_duplicate(&newdb->p_bools.table, &orig->p_bools.table,
+			cond_bools_copy, cond_bools_destroy, NULL);
+	if (rc) {
+		kfree(cond_bool_array);
+		return -ENOMEM;
+	}
+
+	hashtab_map(&newdb->p_bools.table, cond_bools_index, cond_bool_array);
+	newdb->bool_val_to_struct = cond_bool_array;
+
+	newdb->p_bools.nprim = orig->p_bools.nprim;
+
+	return 0;
+}
+
+void cond_policydb_destroy_dup(struct policydb *p)
+{
+	hashtab_map(&p->p_bools.table, cond_bools_destroy, NULL);
+	hashtab_destroy(&p->p_bools.table);
+	cond_policydb_destroy(p);
+}
+
+int cond_policydb_dup(struct policydb *new, struct policydb *orig)
+{
+	cond_policydb_init(new);
+
+	if (duplicate_policydb_bools(new, orig))
+		return -ENOMEM;
+
+	if (duplicate_policydb_cond_list(new, orig)) {
+		cond_policydb_destroy_dup(new);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index 79e7e03db859..e47ec6ddeaf6 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -79,5 +79,7 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
 void cond_compute_xperms(struct avtab *ctab, struct avtab_key *key,
 		struct extended_perms_decision *xpermd);
 void evaluate_cond_nodes(struct policydb *p);
+void cond_policydb_destroy_dup(struct policydb *p);
+int cond_policydb_dup(struct policydb *new, struct policydb *orig);
 
 #endif /* _CONDITIONAL_H_ */
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index d9287bb4bfeb..dab8c25c739b 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -122,6 +122,59 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 	info->max_chain_len = max_chain_len;
 }
 
+int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
+		int (*copy)(struct hashtab_node *new,
+			struct hashtab_node *orig, void *args),
+		int (*destroy)(void *k, void *d, void *args),
+		void *args)
+{
+	struct hashtab_node *cur, *tmp, *tail;
+	int i, rc;
+
+	memset(new, 0, sizeof(*new));
+
+	new->htable = kcalloc(orig->size, sizeof(*new->htable), GFP_KERNEL);
+	if (!new->htable)
+		return -ENOMEM;
+
+	new->size = orig->size;
+
+	for (i = 0; i < orig->size; i++) {
+		tail = NULL;
+		for (cur = orig->htable[i]; cur; cur = cur->next) {
+			tmp = kmem_cache_zalloc(hashtab_node_cachep,
+						GFP_KERNEL);
+			if (!tmp)
+				goto error;
+			rc = copy(tmp, cur, args);
+			if (rc) {
+				kmem_cache_free(hashtab_node_cachep, tmp);
+				goto error;
+			}
+			tmp->next = NULL;
+			if (!tail)
+				new->htable[i] = tmp;
+			else
+				tail->next = tmp;
+			tail = tmp;
+			new->nel++;
+		}
+	}
+
+	return 0;
+
+ error:
+	for (i = 0; i < new->size; i++) {
+		for (cur = new->htable[i]; cur; cur = tmp) {
+			tmp = cur->next;
+			destroy(cur->key, cur->datum, args);
+			kmem_cache_free(hashtab_node_cachep, cur);
+		}
+	}
+	kmem_cache_free(hashtab_node_cachep, new);
+	return -ENOMEM;
+}
+
 void __init hashtab_cache_init(void)
 {
 		hashtab_node_cachep = kmem_cache_create("hashtab_node",
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 3c952f0f01f9..043a773bf0b7 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -136,6 +136,12 @@ int hashtab_map(struct hashtab *h,
 		int (*apply)(void *k, void *d, void *args),
 		void *args);
 
+int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
+		int (*copy)(struct hashtab_node *new,
+			struct hashtab_node *orig, void *args),
+		int (*destroy)(void *k, void *d, void *args),
+		void *args);
+
 /* Fill info with some hash table statistics */
 void hashtab_stat(struct hashtab *h, struct hashtab_info *info);
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index b6afb81fce67..fc8e80beece0 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -733,7 +733,7 @@ static int security_validtrans_handle_fail(struct selinux_state *state,
 					   u16 tclass)
 {
 	struct policydb *p = &state->ss->policy->policydb;
-	struct sidtab *sidtab = &state->ss->policy->sidtab;
+	struct sidtab *sidtab = state->ss->policy->sidtab;
 	char *o = NULL, *n = NULL, *t = NULL;
 	u32 olen, nlen, tlen;
 
@@ -778,7 +778,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 
 	if (!user)
 		tclass = unmap_class(&state->ss->policy->map, orig_tclass);
@@ -879,7 +879,7 @@ int security_bounded_transition(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 
 	rc = -EINVAL;
 	old_entry = sidtab_search_entry(sidtab, old_sid);
@@ -1036,7 +1036,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 		goto allow;
 
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1121,7 +1121,7 @@ void security_compute_av(struct selinux_state *state,
 		goto allow;
 
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1175,7 +1175,7 @@ void security_compute_av_user(struct selinux_state *state,
 		goto allow;
 
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1298,7 +1298,7 @@ int security_sidtab_hash_stats(struct selinux_state *state, char *page)
 	}
 
 	read_lock(&state->ss->policy_rwlock);
-	rc = sidtab_hash_stats(&state->ss->policy->sidtab, page);
+	rc = sidtab_hash_stats(state->ss->policy->sidtab, page);
 	read_unlock(&state->ss->policy_rwlock);
 
 	return rc;
@@ -1347,7 +1347,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 	}
 	read_lock(&state->ss->policy_rwlock);
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 
 	if (force)
 		entry = sidtab_search_entry_force(sidtab, sid);
@@ -1541,7 +1541,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 	}
 	read_lock(&state->ss->policy_rwlock);
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 	rc = string_to_context_struct(policydb, sidtab, scontext2,
 				      &context, def_sid);
 	if (rc == -EINVAL && force) {
@@ -1629,7 +1629,7 @@ static int compute_sid_handle_invalid_context(
 	struct context *newcontext)
 {
 	struct policydb *policydb = &state->ss->policy->policydb;
-	struct sidtab *sidtab = &state->ss->policy->sidtab;
+	struct sidtab *sidtab = state->ss->policy->sidtab;
 	char *s = NULL, *t = NULL, *n = NULL;
 	u32 slen, tlen, nlen;
 	struct audit_buffer *ab;
@@ -1734,7 +1734,7 @@ static int security_compute_sid(struct selinux_state *state,
 	}
 
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 
 	sentry = sidtab_search_entry(sidtab, ssid);
 	if (!sentry) {
@@ -2138,7 +2138,8 @@ static void selinux_policy_free(struct selinux_policy *policy)
 		return;
 
 	policydb_destroy(&policy->policydb);
-	sidtab_destroy(&policy->sidtab);
+	sidtab_destroy(policy->sidtab);
+	kfree(policy->sidtab);
 	kfree(policy->map.mapping);
 	kfree(policy);
 }
@@ -2146,11 +2147,21 @@ static void selinux_policy_free(struct selinux_policy *policy)
 void selinux_policy_cancel(struct selinux_state *state,
 			struct selinux_policy *policy)
 {
-
-	sidtab_cancel_convert(&state->ss->policy->sidtab);
+	sidtab_cancel_convert(state->ss->policy->sidtab);
 	selinux_policy_free(policy);
 }
 
+static void selinux_notify_policy_change(struct selinux_state *state,
+					u32 seqno)
+{
+	/* Flush external caches and notify userspace of policy load */
+	avc_ss_reset(state->avc, seqno);
+	selnl_notify_policyload(seqno);
+	selinux_status_update_policyload(state, seqno);
+	selinux_netlbl_cache_invalidate();
+	selinux_xfrm_notify_policyload();
+}
+
 void selinux_policy_commit(struct selinux_state *state,
 			struct selinux_policy *newpolicy)
 {
@@ -2195,12 +2206,8 @@ void selinux_policy_commit(struct selinux_state *state,
 	/* Free the old policy */
 	selinux_policy_free(oldpolicy);
 
-	/* Flush external caches and notify userspace of policy load */
-	avc_ss_reset(state->avc, seqno);
-	selnl_notify_policyload(seqno);
-	selinux_status_update_policyload(state, seqno);
-	selinux_netlbl_cache_invalidate();
-	selinux_xfrm_notify_policyload();
+	/* Notify others of the policy change */
+	selinux_notify_policy_change(state, seqno);
 }
 
 /**
@@ -2226,6 +2233,10 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 	if (!newpolicy)
 		return -ENOMEM;
 
+	newpolicy->sidtab = kzalloc(sizeof(*newpolicy->sidtab), GFP_KERNEL);
+	if (!newpolicy)
+		goto err;
+
 	rc = policydb_read(&newpolicy->policydb, fp);
 	if (rc)
 		goto err;
@@ -2236,7 +2247,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 	if (rc)
 		goto err;
 
-	rc = policydb_load_isids(&newpolicy->policydb, &newpolicy->sidtab);
+	rc = policydb_load_isids(&newpolicy->policydb, newpolicy->sidtab);
 	if (rc) {
 		pr_err("SELinux:  unable to load the initial SIDs\n");
 		goto err;
@@ -2271,9 +2282,9 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 
 	convert_params.func = convert_context;
 	convert_params.args = &args;
-	convert_params.target = &newpolicy->sidtab;
+	convert_params.target = newpolicy->sidtab;
 
-	rc = sidtab_convert(&state->ss->policy->sidtab, &convert_params);
+	rc = sidtab_convert(state->ss->policy->sidtab, &convert_params);
 	if (rc) {
 		pr_err("SELinux:  unable to convert the internal"
 			" representation of contexts in the new SID"
@@ -2316,7 +2327,7 @@ int security_port_sid(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 
 	c = policydb->ocontexts[OCON_PORT];
 	while (c) {
@@ -2361,7 +2372,7 @@ int security_ib_pkey_sid(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 
 	c = policydb->ocontexts[OCON_IBPKEY];
 	while (c) {
@@ -2407,7 +2418,7 @@ int security_ib_endport_sid(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 
 	c = policydb->ocontexts[OCON_IBENDPORT];
 	while (c) {
@@ -2452,7 +2463,7 @@ int security_netif_sid(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 
 	c = policydb->ocontexts[OCON_NETIF];
 	while (c) {
@@ -2515,7 +2526,7 @@ int security_node_sid(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 
 	switch (domain) {
 	case AF_INET: {
@@ -2615,7 +2626,7 @@ int security_get_user_sids(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 
 	context_init(&usercon);
 
@@ -2715,7 +2726,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 				       u32 *sid)
 {
 	struct policydb *policydb = &policy->policydb;
-	struct sidtab *sidtab = &policy->sidtab;
+	struct sidtab *sidtab = policy->sidtab;
 	int len;
 	u16 sclass;
 	struct genfs *genfs;
@@ -2812,7 +2823,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 
 	c = policydb->ocontexts[OCON_FSUSE];
 	while (c) {
@@ -2897,49 +2908,77 @@ int security_get_bools(struct selinux_policy *policy,
 
 int security_set_bools(struct selinux_state *state, u32 len, int *values)
 {
-	struct policydb *policydb;
+	struct selinux_policy *newpolicy, *oldpolicy;
 	int rc;
-	u32 i, lenp, seqno = 0;
+	u32 i, seqno = 0;
 
-	write_lock_irq(&state->ss->policy_rwlock);
+	/*
+	 * NOTE: We do not need to take the policy read-lock
+	 * around the code below because other policy-modifying
+	 * operations are already excluded by selinuxfs via
+	 * fsi->mutex.
+	 */
 
-	policydb = &state->ss->policy->policydb;
+	/* Consistency check on number of booleans, should never fail */
+	if (WARN_ON(len != state->ss->policy->policydb.p_bools.nprim))
+		return -EINVAL;
 
-	rc = -EFAULT;
-	lenp = policydb->p_bools.nprim;
-	if (len != lenp)
-		goto out;
+	newpolicy = kmemdup(state->ss->policy, sizeof(*newpolicy),
+			GFP_KERNEL);
+	if (!newpolicy)
+		return -ENOMEM;
+
+	oldpolicy = state->ss->policy;
 
+	/*
+	 * Deep copy only the parts of the policydb that might be
+	 * modified as a result of changing booleans.
+	 */
+	rc = cond_policydb_dup(&newpolicy->policydb, &oldpolicy->policydb);
+	if (rc) {
+		kfree(newpolicy);
+		return -ENOMEM;
+	}
+
+	/* Update the boolean states in the copy */
 	for (i = 0; i < len; i++) {
-		if (!!values[i] != policydb->bool_val_to_struct[i]->state) {
+		int new_state = !!values[i];
+		int old_state = newpolicy->policydb.bool_val_to_struct[i]->state;
+
+		if (new_state != old_state) {
 			audit_log(audit_context(), GFP_ATOMIC,
 				AUDIT_MAC_CONFIG_CHANGE,
 				"bool=%s val=%d old_val=%d auid=%u ses=%u",
-				sym_name(policydb, SYM_BOOLS, i),
-				!!values[i],
-				policydb->bool_val_to_struct[i]->state,
+				sym_name(&newpolicy->policydb, SYM_BOOLS, i),
+				new_state,
+				old_state,
 				from_kuid(&init_user_ns, audit_get_loginuid(current)),
 				audit_get_sessionid(current));
+			newpolicy->policydb.bool_val_to_struct[i]->state = new_state;
 		}
-		if (values[i])
-			policydb->bool_val_to_struct[i]->state = 1;
-		else
-			policydb->bool_val_to_struct[i]->state = 0;
 	}
 
-	evaluate_cond_nodes(policydb);
+	/* Re-evaluate the conditional rules in the copy */
+	evaluate_cond_nodes(&newpolicy->policydb);
 
+	/* Install the new policy */
+	write_lock_irq(&state->ss->policy_rwlock);
+	state->ss->policy = newpolicy;
 	seqno = ++state->ss->latest_granting;
-	rc = 0;
-out:
 	write_unlock_irq(&state->ss->policy_rwlock);
-	if (!rc) {
-		avc_ss_reset(state->avc, seqno);
-		selnl_notify_policyload(seqno);
-		selinux_status_update_policyload(state, seqno);
-		selinux_xfrm_notify_policyload();
-	}
-	return rc;
+
+	/*
+	 * Free the conditional portions of the old policydb
+	 * that were copied for the new policy.
+	 */
+	cond_policydb_destroy_dup(&oldpolicy->policydb);
+
+	/* Free the old policy structure but not what it references. */
+	kfree(oldpolicy);
+
+	/* Notify others of the policy change */
+	selinux_notify_policy_change(state, seqno);
+	return 0;
 }
 
 int security_get_bool_value(struct selinux_state *state,
@@ -3021,7 +3060,7 @@ int security_sid_mls_copy(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 
 	if (!policydb->mls_enabled) {
 		*new_sid = sid;
@@ -3131,7 +3170,7 @@ int security_net_peersid_resolve(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 
 	/*
 	 * We don't need to check initialized here since the only way both
@@ -3473,7 +3512,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 		goto out;
 	}
 
-	ctxt = sidtab_search(&state->ss->policy->sidtab, sid);
+	ctxt = sidtab_search(state->ss->policy->sidtab, sid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
 			  sid);
@@ -3649,7 +3688,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
-	sidtab = &state->ss->policy->sidtab;
+	sidtab = state->ss->policy->sidtab;
 
 	if (secattr->flags & NETLBL_SECATTR_CACHE)
 		*sid = *(u32 *)secattr->cache->data;
@@ -3719,7 +3758,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 	policydb = &state->ss->policy->policydb;
 
 	rc = -ENOENT;
-	ctx = sidtab_search(&state->ss->policy->sidtab, sid);
+	ctx = sidtab_search(state->ss->policy->sidtab, sid);
 	if (ctx == NULL)
 		goto out;
 
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index c36933c1c363..06931e34cb24 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -23,7 +23,7 @@ struct selinux_map {
 };
 
 struct selinux_policy {
-	struct sidtab sidtab;
+	struct sidtab *sidtab;
 	struct policydb policydb;
 	struct selinux_map map;
 };
-- 
2.25.1

