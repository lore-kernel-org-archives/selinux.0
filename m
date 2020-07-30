Return-Path: <SRS0=qcS5=BJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D31DC433DF
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 22:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3522720829
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 22:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHG03Typ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgG3WJU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgG3WJT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jul 2020 18:09:19 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112E1C061574
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2020 15:09:19 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j187so27083347qke.11
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2020 15:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZAv7zxi3PZjCuaUIiTFAgOZbb9BNiIPgWP7z48/W3E=;
        b=rHG03TypIlbDXgF/pCVavFGbnERu7Svm9BcGAy2jcMFAkdfCMZqwILHw+2f9jqpZ5M
         IFHfj6R4JJI1pkSfOl+AioalT9vy5DqSiRUzQNgspsssaAbOLq4Q0osMOWYL3qMj1zxr
         y2yWZO4jdoCNWUP5tfucEV0YLWzwdGvGeFoRgbSj9qEE5YN25v3ERIijC1qXJ15fed+Z
         iqQ0E+n4LYpIkSh7d1KgVh1KgKMnFU6sEaXs/l8gPXCm6FbAGYL9vToqfMGJsj71WQY+
         gqYfnRnZzWljcxs3Vx8r0QsvlaYd0gUV3Ux1OGVpP29Mdws5LZSn2Ppd8klCLq5sZ0q0
         58NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZAv7zxi3PZjCuaUIiTFAgOZbb9BNiIPgWP7z48/W3E=;
        b=sSgtQ7U1xVIeSvTLcN4lQxd4PTTid/SWahfkz1NEFY/gxyy7c2f3FgsHEZ0YljGkj+
         IgDr8W4k4425VBC8M7JP+IQnubNJLA+feIk2us605q+PBBLIyw97KfrHjgSj8VnRLEkV
         ngcrVQv9WcL4lSQCqH+SCrWAoZELNt9YJLjGc+uh8kNgDoVOOSA3AjriIVNhOAz/6epx
         W+vhA3eGbCvXuuXwKYp7fbmhfvI8uWP0Ac/onKZCvmXx66ivLOWtdM7bfdnNDiVZgT3o
         t1Xy64lsiRG/EXIvfgQm/2aWme2eMjO+KeZzaotsHvkaL4A4uihGjugrHTzDyc9vR9FN
         X3Ow==
X-Gm-Message-State: AOAM533n5EQk55Ew4y7gjm4QgbizfEo1DJ+lp9OIuesRPzL8nksKSans
        hYbTR3YGPgXJO8IACofKOiPqhA/x824=
X-Google-Smtp-Source: ABdhPJz4yU8JSmS6JZf9yyVxNZWd0VL/ErP+Iqn9GDjmNsG+9yYtuiKPiIrJvzmIrTNB9SAQMfmozQ==
X-Received: by 2002:a05:620a:1355:: with SMTP id c21mr1365478qkl.378.1596146957789;
        Thu, 30 Jul 2020 15:09:17 -0700 (PDT)
Received: from puritycontrol.fios-router.home (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id k5sm2083968qtu.2.2020.07.30.15.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:09:17 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     paul@paul-moore.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH] selinux: encapsulate policy state, refactor policy load
Date:   Thu, 30 Jul 2020 18:09:05 -0400
Message-Id: <20200730220905.60088-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Encapsulate the policy state in its own structure (struct
selinux_policy) that is separately allocated but referenced from the
selinux_ss structure.  The policy state includes the SID table
(particularly the context structures), the policy database, and the
mapping between the kernel classes/permissions and the policy values.
Refactor the security server portion of the policy load logic to
cleanly separate loading of the new structures from committing the new
policy.  Unify the initial policy load and reload code paths as much
as possible, avoiding duplicated code.  Make sure we are taking the
policy read-lock prior to any dereferencing of the policy.  Move the
copying of the policy capability booleans into the state structure
outside of the policy write-lock because they are separate from the
policy and are read outside of any policy lock; possibly they should
be using at least READ_ONCE/WRITE_ONCE or smp_load_acquire/store_release.

These changes simplify the policy loading logic, reduce the size of
the critical section while holding the policy write-lock, and should
facilitate future changes to e.g. refactor the entire policy reload
logic including the selinuxfs code to make the updating of the policy
and the selinuxfs directory tree atomic and/or to convert the policy
read-write lock to RCU.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/ss/services.c | 391 +++++++++++++++++----------------
 security/selinux/ss/services.h |  10 +-
 2 files changed, 209 insertions(+), 192 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 9e76a80db6e1..c56db5e81d58 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -248,9 +248,15 @@ static void map_decision(struct selinux_map *map,
 
 int security_mls_enabled(struct selinux_state *state)
 {
-	struct policydb *p = &state->ss->policydb;
+	int mls_enabled;
 
-	return p->mls_enabled;
+	if (!selinux_initialized(state))
+		return 0;
+
+	read_lock(&state->ss->policy_rwlock);
+	mls_enabled = state->ss->policy->policydb.mls_enabled;
+	read_unlock(&state->ss->policy_rwlock);
+	return mls_enabled;
 }
 
 /*
@@ -726,8 +732,8 @@ static int security_validtrans_handle_fail(struct selinux_state *state,
 					   struct sidtab_entry *tentry,
 					   u16 tclass)
 {
-	struct policydb *p = &state->ss->policydb;
-	struct sidtab *sidtab = state->ss->sidtab;
+	struct policydb *p = &state->ss->policy->policydb;
+	struct sidtab *sidtab = &state->ss->policy->sidtab;
 	char *o = NULL, *n = NULL, *t = NULL;
 	u32 olen, nlen, tlen;
 
@@ -771,11 +777,11 @@ static int security_compute_validatetrans(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
 
 	if (!user)
-		tclass = unmap_class(&state->ss->map, orig_tclass);
+		tclass = unmap_class(&state->ss->policy->map, orig_tclass);
 	else
 		tclass = orig_tclass;
 
@@ -872,8 +878,8 @@ int security_bounded_transition(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
 
 	rc = -EINVAL;
 	old_entry = sidtab_search_entry(sidtab, old_sid);
@@ -1029,8 +1035,8 @@ void security_compute_xperms_decision(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		goto allow;
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1046,7 +1052,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 		goto out;
 	}
 
-	tclass = unmap_class(&state->ss->map, orig_tclass);
+	tclass = unmap_class(&state->ss->policy->map, orig_tclass);
 	if (unlikely(orig_tclass && !tclass)) {
 		if (policydb->allow_unknown)
 			goto allow;
@@ -1114,8 +1120,8 @@ void security_compute_av(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		goto allow;
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1135,7 +1141,7 @@ void security_compute_av(struct selinux_state *state,
 		goto out;
 	}
 
-	tclass = unmap_class(&state->ss->map, orig_tclass);
+	tclass = unmap_class(&state->ss->policy->map, orig_tclass);
 	if (unlikely(orig_tclass && !tclass)) {
 		if (policydb->allow_unknown)
 			goto allow;
@@ -1143,7 +1149,7 @@ void security_compute_av(struct selinux_state *state,
 	}
 	context_struct_compute_av(policydb, scontext, tcontext, tclass, avd,
 				  xperms);
-	map_decision(&state->ss->map, orig_tclass, avd,
+	map_decision(&state->ss->policy->map, orig_tclass, avd,
 		     policydb->allow_unknown);
 out:
 	read_unlock(&state->ss->policy_rwlock);
@@ -1168,8 +1174,8 @@ void security_compute_av_user(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		goto allow;
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1292,7 +1298,7 @@ int security_sidtab_hash_stats(struct selinux_state *state, char *page)
 	}
 
 	read_lock(&state->ss->policy_rwlock);
-	rc = sidtab_hash_stats(state->ss->sidtab, page);
+	rc = sidtab_hash_stats(&state->ss->policy->sidtab, page);
 	read_unlock(&state->ss->policy_rwlock);
 
 	return rc;
@@ -1340,8 +1346,8 @@ static int security_sid_to_context_core(struct selinux_state *state,
 		return -EINVAL;
 	}
 	read_lock(&state->ss->policy_rwlock);
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
 
 	if (force)
 		entry = sidtab_search_entry_force(sidtab, sid);
@@ -1534,8 +1540,8 @@ static int security_context_to_sid_core(struct selinux_state *state,
 			goto out;
 	}
 	read_lock(&state->ss->policy_rwlock);
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
 	rc = string_to_context_struct(policydb, sidtab, scontext2,
 				      &context, def_sid);
 	if (rc == -EINVAL && force) {
@@ -1622,8 +1628,8 @@ static int compute_sid_handle_invalid_context(
 	u16 tclass,
 	struct context *newcontext)
 {
-	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = state->ss->sidtab;
+	struct policydb *policydb = &state->ss->policy->policydb;
+	struct sidtab *sidtab = &state->ss->policy->sidtab;
 	char *s = NULL, *t = NULL, *n = NULL;
 	u32 slen, tlen, nlen;
 	struct audit_buffer *ab;
@@ -1719,16 +1725,16 @@ static int security_compute_sid(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	if (kern) {
-		tclass = unmap_class(&state->ss->map, orig_tclass);
+		tclass = unmap_class(&state->ss->policy->map, orig_tclass);
 		sock = security_is_socket_class(orig_tclass);
 	} else {
 		tclass = orig_tclass;
-		sock = security_is_socket_class(map_class(&state->ss->map,
+		sock = security_is_socket_class(map_class(&state->ss->policy->map,
 							  tclass));
 	}
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
 
 	sentry = sidtab_search_entry(sidtab, ssid);
 	if (!sentry) {
@@ -1945,7 +1951,7 @@ static inline int convert_context_handle_invalid_context(
 	struct selinux_state *state,
 	struct context *context)
 {
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb = &state->ss->policy->policydb;
 	char *s;
 	u32 len;
 
@@ -2098,10 +2104,12 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 
 static void security_load_policycaps(struct selinux_state *state)
 {
-	struct policydb *p = &state->ss->policydb;
+	struct policydb *p = &state->ss->policy->policydb;
 	unsigned int i;
 	struct ebitmap_node *node;
 
+	read_lock(&state->ss->policy_rwlock);
+
 	for (i = 0; i < ARRAY_SIZE(state->policycap); i++)
 		state->policycap[i] = ebitmap_get_bit(&p->policycaps, i);
 
@@ -2115,11 +2123,71 @@ static void security_load_policycaps(struct selinux_state *state)
 			pr_info("SELinux:  unknown policy capability %u\n",
 				i);
 	}
+
+	read_unlock(&state->ss->policy_rwlock);
 }
 
 static int security_preserve_bools(struct selinux_state *state,
 				   struct policydb *newpolicydb);
 
+static void selinux_policy_free(struct selinux_policy *policy)
+{
+	if (!policy)
+		return;
+
+	policydb_destroy(&policy->policydb);
+	sidtab_destroy(&policy->sidtab);
+	kfree(policy->map.mapping);
+	kfree(policy);
+}
+
+static void selinux_policy_commit(struct selinux_state *state,
+				struct selinux_policy *newpolicy)
+{
+	struct selinux_policy *oldpolicy;
+	u32 seqno;
+
+	/* If switching between different policy types, log MLS status */
+	read_lock(&state->ss->policy_rwlock);
+	oldpolicy = state->ss->policy;
+	if (oldpolicy) {
+		if (oldpolicy->policydb.mls_enabled && !newpolicy->policydb.mls_enabled)
+			pr_info("SELinux: Disabling MLS support...\n");
+		else if (!oldpolicy->policydb.mls_enabled && newpolicy->policydb.mls_enabled)
+			pr_info("SELinux: Enabling MLS support...\n");
+	}
+	read_unlock(&state->ss->policy_rwlock);
+
+	/* Install the new policy. */
+	write_lock_irq(&state->ss->policy_rwlock);
+	state->ss->policy = newpolicy;
+	seqno = ++state->ss->latest_granting;
+	write_unlock_irq(&state->ss->policy_rwlock);
+
+	/* Free the old policy */
+	selinux_policy_free(oldpolicy);
+
+	/* Load the policycaps from the new policy */
+	security_load_policycaps(state);
+
+	if (!selinux_initialized(state)) {
+		/*
+		 * After first policy load, the security server is
+		 * marked as initialized and ready to handle requests and
+		 * any objects created prior to policy load are then labeled.
+		 */
+		selinux_mark_initialized(state);
+		selinux_complete_init();
+	}
+
+	/* Flush external caches and notify userspace of policy load */
+	avc_ss_reset(state->avc, seqno);
+	selnl_notify_policyload(seqno);
+	selinux_status_update_policyload(state, seqno);
+	selinux_netlbl_cache_invalidate();
+	selinux_xfrm_notify_policyload();
+}
+
 /**
  * security_load_policy - Load a security policy configuration.
  * @data: binary policy data
@@ -2132,112 +2200,58 @@ static int security_preserve_bools(struct selinux_state *state,
  */
 int security_load_policy(struct selinux_state *state, void *data, size_t len)
 {
-	struct policydb *policydb;
-	struct sidtab *oldsidtab, *newsidtab;
-	struct policydb *oldpolicydb, *newpolicydb;
-	struct selinux_mapping *oldmapping;
-	struct selinux_map newmap;
+	struct selinux_policy *newpolicy;
 	struct sidtab_convert_params convert_params;
 	struct convert_context_args args;
-	u32 seqno;
 	int rc = 0;
 	struct policy_file file = { data, len }, *fp = &file;
 
-	policydb = &state->ss->policydb;
-
-	newsidtab = kmalloc(sizeof(*newsidtab), GFP_KERNEL);
-	if (!newsidtab)
+	newpolicy = kzalloc(sizeof(*newpolicy), GFP_KERNEL);
+	if (!newpolicy)
 		return -ENOMEM;
 
-	if (!selinux_initialized(state)) {
-		rc = policydb_read(policydb, fp);
-		if (rc) {
-			kfree(newsidtab);
-			return rc;
-		}
-
-		policydb->len = len;
-		rc = selinux_set_mapping(policydb, secclass_map,
-					 &state->ss->map);
-		if (rc) {
-			kfree(newsidtab);
-			policydb_destroy(policydb);
-			return rc;
-		}
-
-		rc = policydb_load_isids(policydb, newsidtab);
-		if (rc) {
-			kfree(newsidtab);
-			policydb_destroy(policydb);
-			return rc;
-		}
-
-		state->ss->sidtab = newsidtab;
-		security_load_policycaps(state);
-		selinux_mark_initialized(state);
-		seqno = ++state->ss->latest_granting;
-		selinux_complete_init();
-		avc_ss_reset(state->avc, seqno);
-		selnl_notify_policyload(seqno);
-		selinux_status_update_policyload(state, seqno);
-		selinux_netlbl_cache_invalidate();
-		selinux_xfrm_notify_policyload();
-		return 0;
-	}
-
-	oldpolicydb = kcalloc(2, sizeof(*oldpolicydb), GFP_KERNEL);
-	if (!oldpolicydb) {
-		kfree(newsidtab);
-		return -ENOMEM;
-	}
-	newpolicydb = oldpolicydb + 1;
-
-	rc = policydb_read(newpolicydb, fp);
-	if (rc) {
-		kfree(newsidtab);
-		goto out;
-	}
+	rc = policydb_read(&newpolicy->policydb, fp);
+	if (rc)
+		goto err;
 
-	newpolicydb->len = len;
-	/* If switching between different policy types, log MLS status */
-	if (policydb->mls_enabled && !newpolicydb->mls_enabled)
-		pr_info("SELinux: Disabling MLS support...\n");
-	else if (!policydb->mls_enabled && newpolicydb->mls_enabled)
-		pr_info("SELinux: Enabling MLS support...\n");
+	newpolicy->policydb.len = len;
+	rc = selinux_set_mapping(&newpolicy->policydb, secclass_map,
+				&newpolicy->map);
+	if (rc)
+		goto err;
 
-	rc = policydb_load_isids(newpolicydb, newsidtab);
+	rc = policydb_load_isids(&newpolicy->policydb, &newpolicy->sidtab);
 	if (rc) {
 		pr_err("SELinux:  unable to load the initial SIDs\n");
-		policydb_destroy(newpolicydb);
-		kfree(newsidtab);
-		goto out;
+		goto err;
 	}
 
-	rc = selinux_set_mapping(newpolicydb, secclass_map, &newmap);
-	if (rc)
-		goto err;
+	if (!selinux_initialized(state)) {
+		/* First policy load, so no need to preserve state from old policy */
+		selinux_policy_commit(state, newpolicy);
+		return 0;
+	}
 
-	rc = security_preserve_bools(state, newpolicydb);
+	/* Preserve active boolean values from the old policy */
+	rc = security_preserve_bools(state, &newpolicy->policydb);
 	if (rc) {
 		pr_err("SELinux:  unable to preserve booleans\n");
 		goto err;
 	}
 
-	oldsidtab = state->ss->sidtab;
-
 	/*
 	 * Convert the internal representations of contexts
 	 * in the new SID table.
 	 */
 	args.state = state;
-	args.oldp = policydb;
-	args.newp = newpolicydb;
+	args.oldp = &state->ss->policy->policydb;
+	args.newp = &newpolicy->policydb;
 
 	convert_params.func = convert_context;
 	convert_params.args = &args;
-	convert_params.target = newsidtab;
+	convert_params.target = &newpolicy->sidtab;
 
-	rc = sidtab_convert(oldsidtab, &convert_params);
+	rc = sidtab_convert(&state->ss->policy->sidtab, &convert_params);
 	if (rc) {
 		pr_err("SELinux:  unable to convert the internal"
 			" representation of contexts in the new SID"
@@ -2245,53 +2259,20 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 		goto err;
 	}
 
-	/* Save the old policydb and SID table to free later. */
-	memcpy(oldpolicydb, policydb, sizeof(*policydb));
-
-	/* Install the new policydb and SID table. */
-	write_lock_irq(&state->ss->policy_rwlock);
-	memcpy(policydb, newpolicydb, sizeof(*policydb));
-	state->ss->sidtab = newsidtab;
-	security_load_policycaps(state);
-	oldmapping = state->ss->map.mapping;
-	state->ss->map.mapping = newmap.mapping;
-	state->ss->map.size = newmap.size;
-	seqno = ++state->ss->latest_granting;
-	write_unlock_irq(&state->ss->policy_rwlock);
-
-	/* Free the old policydb and SID table. */
-	policydb_destroy(oldpolicydb);
-	sidtab_destroy(oldsidtab);
-	kfree(oldsidtab);
-	kfree(oldmapping);
-
-	avc_ss_reset(state->avc, seqno);
-	selnl_notify_policyload(seqno);
-	selinux_status_update_policyload(state, seqno);
-	selinux_netlbl_cache_invalidate();
-	selinux_xfrm_notify_policyload();
-
-	rc = 0;
-	goto out;
+	selinux_policy_commit(state, newpolicy);
+	return 0;
 
 err:
-	kfree(newmap.mapping);
-	sidtab_destroy(newsidtab);
-	kfree(newsidtab);
-	policydb_destroy(newpolicydb);
-
-out:
-	kfree(oldpolicydb);
+	selinux_policy_free(newpolicy);
 	return rc;
 }
 
 size_t security_policydb_len(struct selinux_state *state)
 {
-	struct policydb *p = &state->ss->policydb;
 	size_t len;
 
 	read_lock(&state->ss->policy_rwlock);
-	len = p->len;
+	len = state->ss->policy->policydb.len;
 	read_unlock(&state->ss->policy_rwlock);
 
 	return len;
@@ -2313,8 +2294,8 @@ int security_port_sid(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
 
 	c = policydb->ocontexts[OCON_PORT];
 	while (c) {
@@ -2358,8 +2339,8 @@ int security_ib_pkey_sid(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
 
 	c = policydb->ocontexts[OCON_IBPKEY];
 	while (c) {
@@ -2404,8 +2385,8 @@ int security_ib_endport_sid(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
 
 	c = policydb->ocontexts[OCON_IBENDPORT];
 	while (c) {
@@ -2449,8 +2430,8 @@ int security_netif_sid(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
 
 	c = policydb->ocontexts[OCON_NETIF];
 	while (c) {
@@ -2512,8 +2493,8 @@ int security_node_sid(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
 
 	switch (domain) {
 	case AF_INET: {
@@ -2612,8 +2593,8 @@ int security_get_user_sids(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
 
 	context_init(&usercon);
 
@@ -2714,8 +2695,8 @@ static inline int __security_genfs_sid(struct selinux_state *state,
 				       u16 orig_sclass,
 				       u32 *sid)
 {
-	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = state->ss->sidtab;
+	struct policydb *policydb = &state->ss->policy->policydb;
+	struct sidtab *sidtab = &state->ss->policy->sidtab;
 	int len;
 	u16 sclass;
 	struct genfs *genfs;
@@ -2725,7 +2706,7 @@ static inline int __security_genfs_sid(struct selinux_state *state,
 	while (path[0] == '/' && path[1] == '/')
 		path++;
 
-	sclass = unmap_class(&state->ss->map, orig_sclass);
+	sclass = unmap_class(&state->ss->policy->map, orig_sclass);
 	*sid = SECINITSID_UNLABELED;
 
 	for (genfs = policydb->genfs; genfs; genfs = genfs->next) {
@@ -2800,8 +2781,8 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
 
 	c = policydb->ocontexts[OCON_FSUSE];
 	while (c) {
@@ -2851,7 +2832,7 @@ int security_get_bools(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
+	policydb = &state->ss->policy->policydb;
 
 	*names = NULL;
 	*values = NULL;
@@ -2902,7 +2883,7 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 
 	write_lock_irq(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
+	policydb = &state->ss->policy->policydb;
 
 	rc = -EFAULT;
 	lenp = policydb->p_bools.nprim;
@@ -2950,7 +2931,7 @@ int security_get_bool_value(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
-	policydb = &state->ss->policydb;
+	policydb = &state->ss->policy->policydb;
 
 	rc = -EFAULT;
 	len = policydb->p_bools.nprim;
@@ -2998,8 +2979,8 @@ static int security_preserve_bools(struct selinux_state *state,
 int security_sid_mls_copy(struct selinux_state *state,
 			  u32 sid, u32 mls_sid, u32 *new_sid)
 {
-	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = state->ss->sidtab;
+	struct policydb *policydb;
+	struct sidtab *sidtab;
 	struct context *context1;
 	struct context *context2;
 	struct context newcon;
@@ -3008,7 +2989,7 @@ int security_sid_mls_copy(struct selinux_state *state,
 	int rc;
 
 	rc = 0;
-	if (!selinux_initialized(state) || !policydb->mls_enabled) {
+	if (!selinux_initialized(state)) {
 		*new_sid = sid;
 		goto out;
 	}
@@ -3017,6 +2998,14 @@ int security_sid_mls_copy(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
+
+	if (!policydb->mls_enabled) {
+		*new_sid = sid;
+		goto out_unlock;
+	}
+
 	rc = -EINVAL;
 	context1 = sidtab_search(sidtab, sid);
 	if (!context1) {
@@ -3094,8 +3083,8 @@ int security_net_peersid_resolve(struct selinux_state *state,
 				 u32 xfrm_sid,
 				 u32 *peer_sid)
 {
-	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = state->ss->sidtab;
+	struct policydb *policydb;
+	struct sidtab *sidtab;
 	int rc;
 	struct context *nlbl_ctx;
 	struct context *xfrm_ctx;
@@ -3117,15 +3106,20 @@ int security_net_peersid_resolve(struct selinux_state *state,
 		return 0;
 	}
 
+	read_lock(&state->ss->policy_rwlock);
+
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
+
 	/*
 	 * We don't need to check initialized here since the only way both
 	 * nlbl_sid and xfrm_sid are not equal to SECSID_NULL would be if the
 	 * security server was initialized and state->initialized was true.
 	 */
-	if (!policydb->mls_enabled)
-		return 0;
-
-	read_lock(&state->ss->policy_rwlock);
+	if (!policydb->mls_enabled) {
+		rc = 0;
+		goto out;
+	}
 
 	rc = -EINVAL;
 	nlbl_ctx = sidtab_search(sidtab, nlbl_sid);
@@ -3172,7 +3166,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 int security_get_classes(struct selinux_state *state,
 			 char ***classes, int *nclasses)
 {
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb;
 	int rc;
 
 	if (!selinux_initialized(state)) {
@@ -3183,6 +3177,8 @@ int security_get_classes(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
+	policydb = &state->ss->policy->policydb;
+
 	rc = -ENOMEM;
 	*nclasses = policydb->p_classes.nprim;
 	*classes = kcalloc(*nclasses, sizeof(**classes), GFP_ATOMIC);
@@ -3219,12 +3215,14 @@ static int get_permissions_callback(void *k, void *d, void *args)
 int security_get_permissions(struct selinux_state *state,
 			     char *class, char ***perms, int *nperms)
 {
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb;
 	int rc, i;
 	struct class_datum *match;
 
 	read_lock(&state->ss->policy_rwlock);
 
+	policydb = &state->ss->policy->policydb;
+
 	rc = -EINVAL;
 	match = symtab_search(&policydb->p_classes, class);
 	if (!match) {
@@ -3265,12 +3263,22 @@ int security_get_permissions(struct selinux_state *state,
 
 int security_get_reject_unknown(struct selinux_state *state)
 {
-	return state->ss->policydb.reject_unknown;
+	int value;
+
+	read_lock(&state->ss->policy_rwlock);
+	value = state->ss->policy->policydb.reject_unknown;
+	read_unlock(&state->ss->policy_rwlock);
+	return value;
 }
 
 int security_get_allow_unknown(struct selinux_state *state)
 {
-	return state->ss->policydb.allow_unknown;
+	int value;
+
+	read_lock(&state->ss->policy_rwlock);
+	value = state->ss->policy->policydb.allow_unknown;
+	read_unlock(&state->ss->policy_rwlock);
+	return value;
 }
 
 /**
@@ -3286,11 +3294,10 @@ int security_get_allow_unknown(struct selinux_state *state)
 int security_policycap_supported(struct selinux_state *state,
 				 unsigned int req_cap)
 {
-	struct policydb *policydb = &state->ss->policydb;
 	int rc;
 
 	read_lock(&state->ss->policy_rwlock);
-	rc = ebitmap_get_bit(&policydb->policycaps, req_cap);
+	rc = ebitmap_get_bit(&state->ss->policy->policydb.policycaps, req_cap);
 	read_unlock(&state->ss->policy_rwlock);
 
 	return rc;
@@ -3314,7 +3321,7 @@ void selinux_audit_rule_free(void *vrule)
 int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 {
 	struct selinux_state *state = &selinux_state;
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb;
 	struct selinux_audit_rule *tmprule;
 	struct role_datum *roledatum;
 	struct type_datum *typedatum;
@@ -3359,6 +3366,8 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 
 	read_lock(&state->ss->policy_rwlock);
 
+	policydb = &state->ss->policy->policydb;
+
 	tmprule->au_seqno = state->ss->latest_granting;
 
 	switch (field) {
@@ -3455,7 +3464,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 		goto out;
 	}
 
-	ctxt = sidtab_search(state->ss->sidtab, sid);
+	ctxt = sidtab_search(&state->ss->policy->sidtab, sid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
 			  sid);
@@ -3617,8 +3626,8 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 				   struct netlbl_lsm_secattr *secattr,
 				   u32 *sid)
 {
-	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = state->ss->sidtab;
+	struct policydb *policydb;
+	struct sidtab *sidtab;
 	int rc;
 	struct context *ctx;
 	struct context ctx_new;
@@ -3630,6 +3639,9 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
+	policydb = &state->ss->policy->policydb;
+	sidtab = &state->ss->policy->sidtab;
+
 	if (secattr->flags & NETLBL_SECATTR_CACHE)
 		*sid = *(u32 *)secattr->cache->data;
 	else if (secattr->flags & NETLBL_SECATTR_SECID)
@@ -3686,7 +3698,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 int security_netlbl_sid_to_secattr(struct selinux_state *state,
 				   u32 sid, struct netlbl_lsm_secattr *secattr)
 {
-	struct policydb *policydb = &state->ss->policydb;
+	struct policydb *policydb;
 	int rc;
 	struct context *ctx;
 
@@ -3695,8 +3707,10 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 
 	read_lock(&state->ss->policy_rwlock);
 
+	policydb = &state->ss->policy->policydb;
+
 	rc = -ENOENT;
-	ctx = sidtab_search(state->ss->sidtab, sid);
+	ctx = sidtab_search(&state->ss->policy->sidtab, sid);
 	if (ctx == NULL)
 		goto out;
 
@@ -3725,7 +3739,6 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len)
 {
-	struct policydb *policydb = &state->ss->policydb;
 	int rc;
 	struct policy_file fp;
 
@@ -3742,7 +3755,7 @@ int security_read_policy(struct selinux_state *state,
 	fp.len = *len;
 
 	read_lock(&state->ss->policy_rwlock);
-	rc = policydb_write(policydb, &fp);
+	rc = policydb_write(&state->ss->policy->policydb, &fp);
 	read_unlock(&state->ss->policy_rwlock);
 
 	if (rc)
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index a06f3d835216..c36933c1c363 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -22,12 +22,16 @@ struct selinux_map {
 	u16 size; /* array size of mapping */
 };
 
-struct selinux_ss {
-	struct sidtab *sidtab;
+struct selinux_policy {
+	struct sidtab sidtab;
 	struct policydb policydb;
+	struct selinux_map map;
+};
+
+struct selinux_ss {
 	rwlock_t policy_rwlock;
 	u32 latest_granting;
-	struct selinux_map map;
+	struct selinux_policy *policy;
 } __randomize_layout;
 
 void services_compute_xperms_drivers(struct extended_perms *xperms,
-- 
2.25.1

