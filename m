Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA54C433DF
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 17:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE42920809
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 17:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvVl4dES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbgG1RTu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731684AbgG1RTu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jul 2020 13:19:50 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B454FC061794
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2020 10:19:49 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s23so15391564qtq.12
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2020 10:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zmM9zj3U5FA8KSvji0CLRUp03hueN0VyiiP8Swkuv04=;
        b=XvVl4dESAJqZ0eSubTWansMgSOp6XX98nl3BOoStfO4/iT1R1ZSRTJmZ6nSXfCEamq
         7YKy1PaXtO5jlq2IrQzq5pSjXMPKkLJf3KvSRWGnZ7e7LIDPRmu8tbvftyIsoaVWTSo1
         sHx89asAU34cDJKIrw5vBwEg+owGlk2GaJO5+Ux4ai2kxZzfz81OMweC9tu/63QW1iQP
         qXrQAN/hoRp17eASDmXrS6S5tIo+qzY3EbJS8FDpkp9ZXaZ1iChG5DOmGZ/pLw1WEtLY
         e910EdmR2YLsqjKUhpQGdmk9n4hReyFBNpWjzuEg5RuWLfGJ/ed6tW2nwjoY/QuqzNiu
         6BTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zmM9zj3U5FA8KSvji0CLRUp03hueN0VyiiP8Swkuv04=;
        b=fhE/xhlgZC5lJHj08pZ1tUdcxv9GDVWGcnJ7wxEH2zpyhCIMQhzSTGkYEPQeMCc1EP
         q2N98X5D75CbtaPxgEmLZ7pIDg+rCg0slJi3a6SB5DChSp2aCjfCPc3j7z231LszBdhK
         qNFKVxg+1m0wqY8Pl9JbImDxEFSQToOoPKmvEkJx5lpyWZzP4h9zOdynCtiKyb7U+WVt
         nxNElcBwKEX1XeDJRHUCnJbbnAwqf+39jOHWpEK1MHTQescTMpNOF5mnQ+FeyrMcIUWw
         dIMeBPNyZJ5ChkEtriFNyLIaIxneNR/xiwXN00ofeMbFCoEeFfSjDCh7HDp7X8H3OwfA
         GQnw==
X-Gm-Message-State: AOAM533s9S3NI6WbjySEuan8FJchKo4B7AXyao4slLVCbwAfJO/OUgSA
        M0a39UlrSsFf6lEazM+5Q8Lxc9FihUI=
X-Google-Smtp-Source: ABdhPJzGBsdo8TBxXdyYTg76hE/YvTE1IJ75BBEgzQ8FksQqev544lX5HTeJb3qZMifH9MqTfQb2mQ==
X-Received: by 2002:ac8:2256:: with SMTP id p22mr27320701qtp.75.1595956788840;
        Tue, 28 Jul 2020 10:19:48 -0700 (PDT)
Received: from puritycontrol.fios-router.home (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id f7sm20338357qkj.32.2020.07.28.10.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 10:19:48 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     paul@paul-moore.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: encapsulate policy-dependent state
Date:   Tue, 28 Jul 2020 13:19:29 -0400
Message-Id: <20200728171929.50152-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Encapsulate the policy-dependent state in its own structure
(struct selinux_policy) embedded within the selinux_ss structure.
The policy-dependent state includes the SID table (particularly
the context structures), the policy database, and the mapping
between the kernel classes/permissions and the policy values.
No change in functionality or interfaces.  This change is
preparatory to splitting the policy load logic into multiple
stages to enable making the entire policy reload atomic.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/ss/services.c | 150 ++++++++++++++++-----------------
 security/selinux/ss/services.h |   8 +-
 2 files changed, 81 insertions(+), 77 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 9e76a80db6e1..53a7d87782a7 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -248,7 +248,7 @@ static void map_decision(struct selinux_map *map,
 
 int security_mls_enabled(struct selinux_state *state)
 {
-	struct policydb *p = &state->ss->policydb;
+	struct policydb *p = &state->ss->policy.policydb;
 
 	return p->mls_enabled;
 }
@@ -726,8 +726,8 @@ static int security_validtrans_handle_fail(struct selinux_state *state,
 					   struct sidtab_entry *tentry,
 					   u16 tclass)
 {
-	struct policydb *p = &state->ss->policydb;
-	struct sidtab *sidtab = state->ss->sidtab;
+	struct policydb *p = &state->ss->policy.policydb;
+	struct sidtab *sidtab = state->ss->policy.sidtab;
 	char *o = NULL, *n = NULL, *t = NULL;
 	u32 olen, nlen, tlen;
 
@@ -771,11 +771,11 @@ static int security_compute_validatetrans(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy.policydb;
+	sidtab = state->ss->policy.sidtab;
 
 	if (!user)
-		tclass = unmap_class(&state->ss->map, orig_tclass);
+		tclass = unmap_class(&state->ss->policy.map, orig_tclass);
 	else
 		tclass = orig_tclass;
 
@@ -872,8 +872,8 @@ int security_bounded_transition(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy.policydb;
+	sidtab = state->ss->policy.sidtab;
 
 	rc = -EINVAL;
 	old_entry = sidtab_search_entry(sidtab, old_sid);
@@ -1029,8 +1029,8 @@ void security_compute_xperms_decision(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		goto allow;
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy.policydb;
+	sidtab = state->ss->policy.sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1046,7 +1046,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 		goto out;
 	}
 
-	tclass = unmap_class(&state->ss->map, orig_tclass);
+	tclass = unmap_class(&state->ss->policy.map, orig_tclass);
 	if (unlikely(orig_tclass && !tclass)) {
 		if (policydb->allow_unknown)
 			goto allow;
@@ -1114,8 +1114,8 @@ void security_compute_av(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		goto allow;
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy.policydb;
+	sidtab = state->ss->policy.sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1135,7 +1135,7 @@ void security_compute_av(struct selinux_state *state,
 		goto out;
 	}
 
-	tclass = unmap_class(&state->ss->map, orig_tclass);
+	tclass = unmap_class(&state->ss->policy.map, orig_tclass);
 	if (unlikely(orig_tclass && !tclass)) {
 		if (policydb->allow_unknown)
 			goto allow;
@@ -1143,7 +1143,7 @@ void security_compute_av(struct selinux_state *state,
 	}
 	context_struct_compute_av(policydb, scontext, tcontext, tclass, avd,
 				  xperms);
-	map_decision(&state->ss->map, orig_tclass, avd,
+	map_decision(&state->ss->policy.map, orig_tclass, avd,
 		     policydb->allow_unknown);
 out:
 	read_unlock(&state->ss->policy_rwlock);
@@ -1168,8 +1168,8 @@ void security_compute_av_user(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		goto allow;
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy.policydb;
+	sidtab = state->ss->policy.sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1292,7 +1292,7 @@ int security_sidtab_hash_stats(struct selinux_state *state, char *page)
 	}
 
 	read_lock(&state->ss->policy_rwlock);
-	rc = sidtab_hash_stats(state->ss->sidtab, page);
+	rc = sidtab_hash_stats(state->ss->policy.sidtab, page);
 	read_unlock(&state->ss->policy_rwlock);
 
 	return rc;
@@ -1340,8 +1340,8 @@ static int security_sid_to_context_core(struct selinux_state *state,
 		return -EINVAL;
 	}
 	read_lock(&state->ss->policy_rwlock);
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy.policydb;
+	sidtab = state->ss->policy.sidtab;
 
 	if (force)
 		entry = sidtab_search_entry_force(sidtab, sid);
@@ -1534,8 +1534,8 @@ static int security_context_to_sid_core(struct selinux_state *state,
 			goto out;
 	}
 	read_lock(&state->ss->policy_rwlock);
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy.policydb;
+	sidtab = state->ss->policy.sidtab;
 	rc = string_to_context_struct(policydb, sidtab, scontext2,
 				      &context, def_sid);
 	if (rc == -EINVAL && force) {
@@ -1622,8 +1622,8 @@ static int compute_sid_handle_invalid_context(
 	u16 tclass,
 	struct context *newcontext)
 {
-	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = state->ss->sidtab;
+	struct policydb *policydb = &state->ss->policy.policydb;
+	struct sidtab *sidtab = state->ss->policy.sidtab;
 	char *s = NULL, *t = NULL, *n = NULL;
 	u32 slen, tlen, nlen;
 	struct audit_buffer *ab;
@@ -1719,16 +1719,16 @@ static int security_compute_sid(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	if (kern) {
-		tclass = unmap_class(&state->ss->map, orig_tclass);
+		tclass = unmap_class(&state->ss->policy.map, orig_tclass);
 		sock = security_is_socket_class(orig_tclass);
 	} else {
 		tclass = orig_tclass;
-		sock = security_is_socket_class(map_class(&state->ss->map,
+		sock = security_is_socket_class(map_class(&state->ss->policy.map,
 							  tclass));
 	}
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy.policydb;
+	sidtab = state->ss->policy.sidtab;
 
 	sentry = sidtab_search_entry(sidtab, ssid);
 	if (!sentry) {
@@ -1945,7 +1945,7 @@ static inline int convert_context_handle_invalid_context(
 	struct selinux_state *state,
 	struct context *context)
 {
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb = &state->ss->policy.policydb;
 	char *s;
 	u32 len;
 
@@ -2098,7 +2098,7 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 
 static void security_load_policycaps(struct selinux_state *state)
 {
-	struct policydb *p = &state->ss->policydb;
+	struct policydb *p = &state->ss->policy.policydb;
 	unsigned int i;
 	struct ebitmap_node *node;
 
@@ -2143,7 +2143,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	int rc = 0;
 	struct policy_file file = { data, len }, *fp = &file;
 
-	policydb = &state->ss->policydb;
+	policydb = &state->ss->policy.policydb;
 
 	newsidtab = kmalloc(sizeof(*newsidtab), GFP_KERNEL);
 	if (!newsidtab)
@@ -2158,7 +2158,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 
 		policydb->len = len;
 		rc = selinux_set_mapping(policydb, secclass_map,
-					 &state->ss->map);
+					 &state->ss->policy.map);
 		if (rc) {
 			kfree(newsidtab);
 			policydb_destroy(policydb);
@@ -2172,7 +2172,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 			return rc;
 		}
 
-		state->ss->sidtab = newsidtab;
+		state->ss->policy.sidtab = newsidtab;
 		security_load_policycaps(state);
 		selinux_mark_initialized(state);
 		seqno = ++state->ss->latest_granting;
@@ -2223,7 +2223,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 		goto err;
 	}
 
-	oldsidtab = state->ss->sidtab;
+	oldsidtab = state->ss->policy.sidtab;
 
 	/*
 	 * Convert the internal representations of contexts
@@ -2251,11 +2251,11 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	/* Install the new policydb and SID table. */
 	write_lock_irq(&state->ss->policy_rwlock);
 	memcpy(policydb, newpolicydb, sizeof(*policydb));
-	state->ss->sidtab = newsidtab;
+	state->ss->policy.sidtab = newsidtab;
 	security_load_policycaps(state);
-	oldmapping = state->ss->map.mapping;
-	state->ss->map.mapping = newmap.mapping;
-	state->ss->map.size = newmap.size;
+	oldmapping = state->ss->policy.map.mapping;
+	state->ss->policy.map.mapping = newmap.mapping;
+	state->ss->policy.map.size = newmap.size;
 	seqno = ++state->ss->latest_granting;
 	write_unlock_irq(&state->ss->policy_rwlock);
 
@@ -2287,7 +2287,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 
 size_t security_policydb_len(struct selinux_state *state)
 {
-	struct policydb *p = &state->ss->policydb;
+	struct policydb *p = &state->ss->policy.policydb;
 	size_t len;
 
 	read_lock(&state->ss->policy_rwlock);
@@ -2313,8 +2313,8 @@ int security_port_sid(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy.policydb;
+	sidtab = state->ss->policy.sidtab;
 
 	c = policydb->ocontexts[OCON_PORT];
 	while (c) {
@@ -2358,8 +2358,8 @@ int security_ib_pkey_sid(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy.policydb;
+	sidtab = state->ss->policy.sidtab;
 
 	c = policydb->ocontexts[OCON_IBPKEY];
 	while (c) {
@@ -2404,8 +2404,8 @@ int security_ib_endport_sid(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy.policydb;
+	sidtab = state->ss->policy.sidtab;
 
 	c = policydb->ocontexts[OCON_IBENDPORT];
 	while (c) {
@@ -2449,8 +2449,8 @@ int security_netif_sid(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy.policydb;
+	sidtab = state->ss->policy.sidtab;
 
 	c = policydb->ocontexts[OCON_NETIF];
 	while (c) {
@@ -2512,8 +2512,8 @@ int security_node_sid(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy.policydb;
+	sidtab = state->ss->policy.sidtab;
 
 	switch (domain) {
 	case AF_INET: {
@@ -2612,8 +2612,8 @@ int security_get_user_sids(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy.policydb;
+	sidtab = state->ss->policy.sidtab;
 
 	context_init(&usercon);
 
@@ -2714,8 +2714,8 @@ static inline int __security_genfs_sid(struct selinux_state *state,
 				       u16 orig_sclass,
 				       u32 *sid)
 {
-	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = state->ss->sidtab;
+	struct policydb *policydb = &state->ss->policy.policydb;
+	struct sidtab *sidtab = state->ss->policy.sidtab;
 	int len;
 	u16 sclass;
 	struct genfs *genfs;
@@ -2725,7 +2725,7 @@ static inline int __security_genfs_sid(struct selinux_state *state,
 	while (path[0] == '/' && path[1] == '/')
 		path++;
 
-	sclass = unmap_class(&state->ss->map, orig_sclass);
+	sclass = unmap_class(&state->ss->policy.map, orig_sclass);
 	*sid = SECINITSID_UNLABELED;
 
 	for (genfs = policydb->genfs; genfs; genfs = genfs->next) {
@@ -2800,8 +2800,8 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy.policydb;
+	sidtab = state->ss->policy.sidtab;
 
 	c = policydb->ocontexts[OCON_FSUSE];
 	while (c) {
@@ -2851,7 +2851,7 @@ int security_get_bools(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
+	policydb = &state->ss->policy.policydb;
 
 	*names = NULL;
 	*values = NULL;
@@ -2902,7 +2902,7 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 
 	write_lock_irq(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
+	policydb = &state->ss->policy.policydb;
 
 	rc = -EFAULT;
 	lenp = policydb->p_bools.nprim;
@@ -2950,7 +2950,7 @@ int security_get_bool_value(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
+	policydb = &state->ss->policy.policydb;
 
 	rc = -EFAULT;
 	len = policydb->p_bools.nprim;
@@ -2998,8 +2998,8 @@ static int security_preserve_bools(struct selinux_state *state,
 int security_sid_mls_copy(struct selinux_state *state,
 			  u32 sid, u32 mls_sid, u32 *new_sid)
 {
-	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = state->ss->sidtab;
+	struct policydb *policydb = &state->ss->policy.policydb;
+	struct sidtab *sidtab = state->ss->policy.sidtab;
 	struct context *context1;
 	struct context *context2;
 	struct context newcon;
@@ -3094,8 +3094,8 @@ int security_net_peersid_resolve(struct selinux_state *state,
 				 u32 xfrm_sid,
 				 u32 *peer_sid)
 {
-	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = state->ss->sidtab;
+	struct policydb *policydb = &state->ss->policy.policydb;
+	struct sidtab *sidtab = state->ss->policy.sidtab;
 	int rc;
 	struct context *nlbl_ctx;
 	struct context *xfrm_ctx;
@@ -3172,7 +3172,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 int security_get_classes(struct selinux_state *state,
 			 char ***classes, int *nclasses)
 {
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb = &state->ss->policy.policydb;
 	int rc;
 
 	if (!selinux_initialized(state)) {
@@ -3219,7 +3219,7 @@ static int get_permissions_callback(void *k, void *d, void *args)
 int security_get_permissions(struct selinux_state *state,
 			     char *class, char ***perms, int *nperms)
 {
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb = &state->ss->policy.policydb;
 	int rc, i;
 	struct class_datum *match;
 
@@ -3265,12 +3265,12 @@ int security_get_permissions(struct selinux_state *state,
 
 int security_get_reject_unknown(struct selinux_state *state)
 {
-	return state->ss->policydb.reject_unknown;
+	return state->ss->policy.policydb.reject_unknown;
 }
 
 int security_get_allow_unknown(struct selinux_state *state)
 {
-	return state->ss->policydb.allow_unknown;
+	return state->ss->policy.policydb.allow_unknown;
 }
 
 /**
@@ -3286,7 +3286,7 @@ int security_get_allow_unknown(struct selinux_state *state)
 int security_policycap_supported(struct selinux_state *state,
 				 unsigned int req_cap)
 {
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb = &state->ss->policy.policydb;
 	int rc;
 
 	read_lock(&state->ss->policy_rwlock);
@@ -3314,7 +3314,7 @@ void selinux_audit_rule_free(void *vrule)
 int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 {
 	struct selinux_state *state = &selinux_state;
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb = &state->ss->policy.policydb;
 	struct selinux_audit_rule *tmprule;
 	struct role_datum *roledatum;
 	struct type_datum *typedatum;
@@ -3455,7 +3455,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 		goto out;
 	}
 
-	ctxt = sidtab_search(state->ss->sidtab, sid);
+	ctxt = sidtab_search(state->ss->policy.sidtab, sid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
 			  sid);
@@ -3617,8 +3617,8 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 				   struct netlbl_lsm_secattr *secattr,
 				   u32 *sid)
 {
-	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = state->ss->sidtab;
+	struct policydb *policydb = &state->ss->policy.policydb;
+	struct sidtab *sidtab = state->ss->policy.sidtab;
 	int rc;
 	struct context *ctx;
 	struct context ctx_new;
@@ -3686,7 +3686,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 int security_netlbl_sid_to_secattr(struct selinux_state *state,
 				   u32 sid, struct netlbl_lsm_secattr *secattr)
 {
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb = &state->ss->policy.policydb;
 	int rc;
 	struct context *ctx;
 
@@ -3696,7 +3696,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	rc = -ENOENT;
-	ctx = sidtab_search(state->ss->sidtab, sid);
+	ctx = sidtab_search(state->ss->policy.sidtab, sid);
 	if (ctx == NULL)
 		goto out;
 
@@ -3725,7 +3725,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len)
 {
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb = &state->ss->policy.policydb;
 	int rc;
 	struct policy_file fp;
 
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index a06f3d835216..b1c5515a3a3a 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -22,12 +22,16 @@ struct selinux_map {
 	u16 size; /* array size of mapping */
 };
 
-struct selinux_ss {
+struct selinux_policy {
 	struct sidtab *sidtab;
 	struct policydb policydb;
+	struct selinux_map map;
+};
+
+struct selinux_ss {
 	rwlock_t policy_rwlock;
 	u32 latest_granting;
-	struct selinux_map map;
+	struct selinux_policy policy;
 } __randomize_layout;
 
 void services_compute_xperms_drivers(struct extended_perms *xperms,
-- 
2.25.1

