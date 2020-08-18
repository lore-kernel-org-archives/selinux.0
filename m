Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ADAC433DF
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 19:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C6DD206B5
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 19:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHL6bs0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHRTnY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgHRTnX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Aug 2020 15:43:23 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C22C061389
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 12:43:21 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 77so19431697qkm.5
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 12:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5MrGepwrU57jlBCEsjKc/cGYG9+6iGQzuwlszI5yO8=;
        b=aHL6bs0HNgBgIXmxOtoZKVTmD9fRbCP0deKab50ZUHuvbCL9iwK6B5Kt+Ad8QEpf5Q
         tOfY+kBN1/nVwrxNq9rsOnlV5+KzUqVQDXp7k/QjjaHn/rxNIquyd1WkFZOs7FsMG5XQ
         WASApLFcP5BhCP5WG5jcKUFD2fueJfyUsxcgwuadrYiN9bbqOKfQ5JjF2tEmyzvyzf8G
         TyAchHTsoKrHEDff/5rqBmnALuLEkHySgYBUTFpDRfyHuEJpZ9Z/5wu1f1MZMZqGd/Mf
         02oUN+D7Kv6GEvD0cLGJrvGv7ECu5LZnxcYDhaE380DtVhPFs9ftUEPALUJl3uSilYu3
         VklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5MrGepwrU57jlBCEsjKc/cGYG9+6iGQzuwlszI5yO8=;
        b=IcxMWuGbFe743wcSasyxCy9qNIR+EWmhyQsifLlpL3a4lTpW6b2R/s5Mgc+ije4tlC
         wcZpa792cnBdX2BWup87Ih89SKH1CH73hnXp07KBzDzl1NM71yqY/IOi9GXKIwgpdLtv
         C0Qo3EmNbfAimNUtoxzeTXwoYMGoNwYNk9pQZCPUV0ULfcUrSmWcmGVwXg+E3xlZDYnV
         THcAnqVQEAJI5xJaFoU9NechoZH7uvwpbM5NDpbgAwlsmviRYgbG5dphoEFivC4bpOZf
         eSdSPpQ7FI3FcdHF8arUrcz9IZjaF38/yh8c/LBOsTXDPbgMepAlJPWA6fEfh8aub85O
         LQRA==
X-Gm-Message-State: AOAM531YB19sP8jYqv1yhHlG07H7cH+4dt+9hqRV3BlcpC1A4pzhIcoY
        E5myk0ZKJ48mFPA9U+3ceVI=
X-Google-Smtp-Source: ABdhPJx1V3bHJ2UMOepkK+UHeLA77UW6wt3a9umrpFAjPTeaa0KhW2Qhb5/jwHhdOZaQIvmee3wC/g==
X-Received: by 2002:a05:620a:531:: with SMTP id h17mr17799107qkh.61.1597779800951;
        Tue, 18 Aug 2020 12:43:20 -0700 (PDT)
Received: from puritycontrol.fios-router.home (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id c33sm25356618qtk.40.2020.08.18.12.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:43:20 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     paul@paul-moore.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        peter.enderborg@sony.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH] selinux: convert policy read-write lock to RCU
Date:   Tue, 18 Aug 2020 15:43:11 -0400
Message-Id: <20200818194311.30018-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the policy read-write lock to RCU.  This is significantly
simplified by the earlier work to encapsulate the policy data
structures and refactor the policy load and boolean setting logic.

Since the latest_granting sequence number is no longer read/written
under the policy rwlock, convert it to an atomic_t counter. Alternatively
it could be left as a u32, moved into the selinux_policy structure, and
updated atomically upon the pointer update.  At that point struct
selinux_ss would contain nothing but a pointer to struct selinux_policy
and we could drop selinux_ss altogether?  If we leave it as an atomic_t,
possibly it should be atomic_long_t instead to reduce likelihood of
overflow.

At present this change merely passes a hardcoded 1 to
rcu_dereference_check() in the cases where we know we do not need to
take rcu_read_lock(), with the preceding comment explaining why.
Alternatively we could pass fsi->mutex down from selinuxfs and
apply a lockdep check on it instead.

We have to hand off the actual freeing of the policy data structure
to a worker thread instead of doing it directly from the rcu callback
because the avtab and certain other structures may be allocated/freed
via vmalloc/vfree and vfree isn't permitted from rcu callback. I previously
used this approach in the selinuxns series for freeing the selinux
namespace, and it is based on the approach used for user namespaces
in mainline.

This change does not specifically do anything special with respect
to the sidtab live convert; I am unclear as to whether it is safe
as a result.  Comments welcome.

Based in part on earlier attempts to convert the policy rwlock
to RCU by Kaigai Kohei [1] and by Peter Enderborg [2].

[1] https://lore.kernel.org/selinux/6e2f9128-e191-ebb3-0e87-74bfccb0767f@tycho.nsa.gov/
[2] https://lore.kernel.org/selinux/20180530141104.28569-1-peter.enderborg@sony.com/

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/ss/services.c | 446 ++++++++++++++++++++-------------
 security/selinux/ss/services.h |  11 +-
 2 files changed, 278 insertions(+), 179 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f6f78c65f53f..0e1a5b7e7028 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -70,7 +70,7 @@ static struct selinux_ss selinux_ss;
 
 void selinux_ss_init(struct selinux_ss **ss)
 {
-	rwlock_init(&selinux_ss.policy_rwlock);
+	atomic_set(&selinux_ss.latest_granting, 0);
 	*ss = &selinux_ss;
 }
 
@@ -239,13 +239,15 @@ static void map_decision(struct selinux_map *map,
 int security_mls_enabled(struct selinux_state *state)
 {
 	int mls_enabled;
+	struct selinux_policy *policy;
 
 	if (!selinux_initialized(state))
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
-	mls_enabled = state->ss->policy->policydb.mls_enabled;
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	mls_enabled = policy->policydb.mls_enabled;
+	rcu_read_unlock();
 	return mls_enabled;
 }
 
@@ -722,8 +724,9 @@ static int security_validtrans_handle_fail(struct selinux_state *state,
 					   struct sidtab_entry *tentry,
 					   u16 tclass)
 {
-	struct policydb *p = &state->ss->policy->policydb;
-	struct sidtab *sidtab = state->ss->policy->sidtab;
+	struct selinux_policy *policy = rcu_dereference(state->ss->policy);
+	struct policydb *p = &policy->policydb;
+	struct sidtab *sidtab = policy->sidtab;
 	char *o = NULL, *n = NULL, *t = NULL;
 	u32 olen, nlen, tlen;
 
@@ -751,6 +754,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
 					  u32 oldsid, u32 newsid, u32 tasksid,
 					  u16 orig_tclass, bool user)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct sidtab_entry *oentry;
@@ -765,13 +769,14 @@ static int security_compute_validatetrans(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	if (!user)
-		tclass = unmap_class(&state->ss->policy->map, orig_tclass);
+		tclass = unmap_class(&policy->map, orig_tclass);
 	else
 		tclass = orig_tclass;
 
@@ -824,7 +829,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
 	}
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -856,6 +861,7 @@ int security_validate_transition(struct selinux_state *state,
 int security_bounded_transition(struct selinux_state *state,
 				u32 old_sid, u32 new_sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct sidtab_entry *old_entry, *new_entry;
@@ -866,10 +872,10 @@ int security_bounded_transition(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	rc = -EINVAL;
 	old_entry = sidtab_search_entry(sidtab, old_sid);
@@ -930,7 +936,7 @@ int security_bounded_transition(struct selinux_state *state,
 		kfree(old_name);
 	}
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 
 	return rc;
 }
@@ -940,7 +946,7 @@ static void avd_init(struct selinux_state *state, struct av_decision *avd)
 	avd->allowed = 0;
 	avd->auditallow = 0;
 	avd->auditdeny = 0xffffffff;
-	avd->seqno = state->ss->latest_granting;
+	avd->seqno = atomic_read(&state->ss->latest_granting);
 	avd->flags = 0;
 }
 
@@ -1005,6 +1011,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 				      u8 driver,
 				      struct extended_perms_decision *xpermd)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	u16 tclass;
@@ -1021,12 +1028,13 @@ void security_compute_xperms_decision(struct selinux_state *state,
 	memset(xpermd->auditallow->p, 0, sizeof(xpermd->auditallow->p));
 	memset(xpermd->dontaudit->p, 0, sizeof(xpermd->dontaudit->p));
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 	if (!selinux_initialized(state))
 		goto allow;
 
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1042,7 +1050,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 		goto out;
 	}
 
-	tclass = unmap_class(&state->ss->policy->map, orig_tclass);
+	tclass = unmap_class(&policy->map, orig_tclass);
 	if (unlikely(orig_tclass && !tclass)) {
 		if (policydb->allow_unknown)
 			goto allow;
@@ -1074,7 +1082,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 		}
 	}
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return;
 allow:
 	memset(xpermd->allowed->p, 0xff, sizeof(xpermd->allowed->p));
@@ -1099,19 +1107,21 @@ void security_compute_av(struct selinux_state *state,
 			 struct av_decision *avd,
 			 struct extended_perms *xperms)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	u16 tclass;
 	struct context *scontext = NULL, *tcontext = NULL;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 	avd_init(state, avd);
 	xperms->len = 0;
 	if (!selinux_initialized(state))
 		goto allow;
 
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1131,7 +1141,7 @@ void security_compute_av(struct selinux_state *state,
 		goto out;
 	}
 
-	tclass = unmap_class(&state->ss->policy->map, orig_tclass);
+	tclass = unmap_class(&policy->map, orig_tclass);
 	if (unlikely(orig_tclass && !tclass)) {
 		if (policydb->allow_unknown)
 			goto allow;
@@ -1139,10 +1149,10 @@ void security_compute_av(struct selinux_state *state,
 	}
 	context_struct_compute_av(policydb, scontext, tcontext, tclass, avd,
 				  xperms);
-	map_decision(&state->ss->policy->map, orig_tclass, avd,
+	map_decision(&policy->map, orig_tclass, avd,
 		     policydb->allow_unknown);
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return;
 allow:
 	avd->allowed = 0xffffffff;
@@ -1155,17 +1165,19 @@ void security_compute_av_user(struct selinux_state *state,
 			      u16 tclass,
 			      struct av_decision *avd)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct context *scontext = NULL, *tcontext = NULL;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 	avd_init(state, avd);
 	if (!selinux_initialized(state))
 		goto allow;
 
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1194,7 +1206,7 @@ void security_compute_av_user(struct selinux_state *state,
 	context_struct_compute_av(policydb, scontext, tcontext, tclass, avd,
 				  NULL);
  out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return;
 allow:
 	avd->allowed = 0xffffffff;
@@ -1279,6 +1291,7 @@ static int sidtab_entry_to_string(struct policydb *p,
 
 int security_sidtab_hash_stats(struct selinux_state *state, char *page)
 {
+	struct selinux_policy *policy;
 	int rc;
 
 	if (!selinux_initialized(state)) {
@@ -1287,9 +1300,10 @@ int security_sidtab_hash_stats(struct selinux_state *state, char *page)
 		return -EINVAL;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
-	rc = sidtab_hash_stats(state->ss->policy->sidtab, page);
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	rc = sidtab_hash_stats(policy->sidtab, page);
+	rcu_read_unlock();
 
 	return rc;
 }
@@ -1306,6 +1320,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 					u32 *scontext_len, int force,
 					int only_invalid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct sidtab_entry *entry;
@@ -1335,9 +1350,10 @@ static int security_sid_to_context_core(struct selinux_state *state,
 		       "load_policy on unknown SID %d\n", __func__, sid);
 		return -EINVAL;
 	}
-	read_lock(&state->ss->policy_rwlock);
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	if (force)
 		entry = sidtab_search_entry_force(sidtab, sid);
@@ -1356,7 +1372,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 				    scontext_len);
 
 out_unlock:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 
 }
@@ -1491,6 +1507,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 					u32 *sid, u32 def_sid, gfp_t gfp_flags,
 					int force)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	char *scontext2, *str = NULL;
@@ -1529,9 +1546,10 @@ static int security_context_to_sid_core(struct selinux_state *state,
 		if (!str)
 			goto out;
 	}
-	read_lock(&state->ss->policy_rwlock);
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 	rc = string_to_context_struct(policydb, sidtab, scontext2,
 				      &context, def_sid);
 	if (rc == -EINVAL && force) {
@@ -1543,7 +1561,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 	rc = sidtab_context_to_sid(sidtab, &context, sid);
 	context_destroy(&context);
 out_unlock:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 out:
 	kfree(scontext2);
 	kfree(str);
@@ -1618,8 +1636,9 @@ static int compute_sid_handle_invalid_context(
 	u16 tclass,
 	struct context *newcontext)
 {
-	struct policydb *policydb = &state->ss->policy->policydb;
-	struct sidtab *sidtab = state->ss->policy->sidtab;
+	struct selinux_policy *policy = rcu_dereference(state->ss->policy);
+	struct policydb *policydb = &policy->policydb;
+	struct sidtab *sidtab = policy->sidtab;
 	char *s = NULL, *t = NULL, *n = NULL;
 	u32 slen, tlen, nlen;
 	struct audit_buffer *ab;
@@ -1686,6 +1705,7 @@ static int security_compute_sid(struct selinux_state *state,
 				u32 *out_sid,
 				bool kern)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct class_datum *cladatum = NULL;
@@ -1712,19 +1732,21 @@ static int security_compute_sid(struct selinux_state *state,
 
 	context_init(&newcontext);
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+
+	policy = rcu_dereference(state->ss->policy);
 
 	if (kern) {
-		tclass = unmap_class(&state->ss->policy->map, orig_tclass);
+		tclass = unmap_class(&policy->map, orig_tclass);
 		sock = security_is_socket_class(orig_tclass);
 	} else {
 		tclass = orig_tclass;
-		sock = security_is_socket_class(map_class(&state->ss->policy->map,
+		sock = security_is_socket_class(map_class(&policy->map,
 							  tclass));
 	}
 
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	sentry = sidtab_search_entry(sidtab, ssid);
 	if (!sentry) {
@@ -1852,7 +1874,7 @@ static int security_compute_sid(struct selinux_state *state,
 	/* Obtain the sid for the context. */
 	rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
 out_unlock:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	context_destroy(&newcontext);
 out:
 	return rc;
@@ -1941,7 +1963,8 @@ static inline int convert_context_handle_invalid_context(
 	struct selinux_state *state,
 	struct context *context)
 {
-	struct policydb *policydb = &state->ss->policy->policydb;
+	struct selinux_policy *policy = rcu_dereference(state->ss->policy);
+	struct policydb *policydb = &policy->policydb;
 	char *s;
 	u32 len;
 
@@ -2094,13 +2117,16 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 
 static void security_load_policycaps(struct selinux_state *state)
 {
+	struct selinux_policy *policy;
 	struct policydb *p;
 	unsigned int i;
 	struct ebitmap_node *node;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+
+	policy = rcu_dereference(state->ss->policy);
 
-	p = &state->ss->policy->policydb;
+	p = &policy->policydb;
 
 	for (i = 0; i < ARRAY_SIZE(state->policycap); i++)
 		state->policycap[i] = ebitmap_get_bit(&p->policycaps, i);
@@ -2116,16 +2142,16 @@ static void security_load_policycaps(struct selinux_state *state)
 				i);
 	}
 
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 }
 
 static int security_preserve_bools(struct selinux_state *state,
 				   struct policydb *newpolicydb);
 
-static void selinux_policy_free(struct selinux_policy *policy)
+static void selinux_policy_full_free(struct work_struct *work)
 {
-	if (!policy)
-		return;
+	struct selinux_policy *policy =
+		container_of(work, struct selinux_policy, fullfree);
 
 	policydb_destroy(&policy->policydb);
 	sidtab_destroy(policy->sidtab);
@@ -2134,10 +2160,45 @@ static void selinux_policy_free(struct selinux_policy *policy)
 	kfree(policy);
 }
 
+static void selinux_policy_cond_free(struct work_struct *work)
+{
+	struct selinux_policy *policy =
+		container_of(work, struct selinux_policy, condfree);
+
+	cond_policydb_destroy_dup(&policy->policydb);
+	kfree(policy);
+}
+
+static void selinux_policy_free(struct selinux_policy *policy)
+{
+	if (!policy)
+		return;
+	selinux_policy_full_free(&policy->fullfree);
+}
+
+static void selinux_policy_free_rcu(struct rcu_head *rcu)
+{
+	struct selinux_policy *policy = container_of(rcu, struct selinux_policy, rhead);
+
+	schedule_work(&policy->fullfree);
+}
+
+static void selinux_policy_cond_free_rcu(struct rcu_head *rcu)
+{
+	struct selinux_policy *policy = container_of(rcu, struct selinux_policy, rhead);
+
+	schedule_work(&policy->condfree);
+}
+
 void selinux_policy_cancel(struct selinux_state *state,
 			struct selinux_policy *policy)
 {
-	sidtab_cancel_convert(state->ss->policy->sidtab);
+	struct selinux_policy *oldpolicy;
+
+	rcu_read_lock();
+	oldpolicy = rcu_dereference(state->ss->policy);
+	sidtab_cancel_convert(oldpolicy->sidtab);
+	rcu_read_unlock();
 	selinux_policy_free(policy);
 }
 
@@ -2159,14 +2220,14 @@ void selinux_policy_commit(struct selinux_state *state,
 	u32 seqno;
 
 	/*
-	 * NOTE: We do not need to take the policy read-lock
+	 * NOTE: We do not need to take the rcu read lock
 	 * around the code below because other policy-modifying
 	 * operations are already excluded by selinuxfs via
 	 * fsi->mutex.
 	 */
+	oldpolicy = rcu_dereference_check(state->ss->policy, 1);
 
 	/* If switching between different policy types, log MLS status */
-	oldpolicy = state->ss->policy;
 	if (oldpolicy) {
 		if (oldpolicy->policydb.mls_enabled && !newpolicy->policydb.mls_enabled)
 			pr_info("SELinux: Disabling MLS support...\n");
@@ -2175,10 +2236,8 @@ void selinux_policy_commit(struct selinux_state *state,
 	}
 
 	/* Install the new policy. */
-	write_lock_irq(&state->ss->policy_rwlock);
-	state->ss->policy = newpolicy;
-	seqno = ++state->ss->latest_granting;
-	write_unlock_irq(&state->ss->policy_rwlock);
+	rcu_assign_pointer(state->ss->policy, newpolicy);
+	seqno = atomic_inc_return(&state->ss->latest_granting);
 
 	/* Load the policycaps from the new policy */
 	security_load_policycaps(state);
@@ -2194,7 +2253,8 @@ void selinux_policy_commit(struct selinux_state *state,
 	}
 
 	/* Free the old policy */
-	selinux_policy_free(oldpolicy);
+	if (oldpolicy)
+		call_rcu(&oldpolicy->rhead, selinux_policy_free_rcu);
 
 	/* Notify others of the policy change */
 	selinux_notify_policy_change(state, seqno);
@@ -2213,7 +2273,7 @@ void selinux_policy_commit(struct selinux_state *state,
 int security_load_policy(struct selinux_state *state, void *data, size_t len,
 			struct selinux_policy **newpolicyp)
 {
-	struct selinux_policy *newpolicy;
+	struct selinux_policy *newpolicy, *oldpolicy;
 	struct sidtab_convert_params convert_params;
 	struct convert_context_args args;
 	int rc = 0;
@@ -2222,6 +2282,8 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 	newpolicy = kzalloc(sizeof(*newpolicy), GFP_KERNEL);
 	if (!newpolicy)
 		return -ENOMEM;
+	INIT_WORK(&newpolicy->fullfree, selinux_policy_full_free);
+	INIT_WORK(&newpolicy->condfree, selinux_policy_cond_free);
 
 	newpolicy->sidtab = kzalloc(sizeof(*newpolicy->sidtab), GFP_KERNEL);
 	if (!newpolicy)
@@ -2261,20 +2323,22 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 	 * Convert the internal representations of contexts
 	 * in the new SID table.
 	 *
-	 * NOTE: We do not need to take the policy read-lock
+	 * NOTE: We do not need to take the rcu read lock
 	 * around the code below because other policy-modifying
 	 * operations are already excluded by selinuxfs via
 	 * fsi->mutex.
 	 */
+	oldpolicy = rcu_dereference_check(state->ss->policy, 1);
+
 	args.state = state;
-	args.oldp = &state->ss->policy->policydb;
+	args.oldp = &oldpolicy->policydb;
 	args.newp = &newpolicy->policydb;
 
 	convert_params.func = convert_context;
 	convert_params.args = &args;
 	convert_params.target = newpolicy->sidtab;
 
-	rc = sidtab_convert(state->ss->policy->sidtab, &convert_params);
+	rc = sidtab_convert(oldpolicy->sidtab, &convert_params);
 	if (rc) {
 		pr_err("SELinux:  unable to convert the internal"
 			" representation of contexts in the new SID"
@@ -2291,11 +2355,13 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 
 size_t security_policydb_len(struct selinux_state *state)
 {
+	struct selinux_policy *policy;
 	size_t len;
 
-	read_lock(&state->ss->policy_rwlock);
-	len = state->ss->policy->policydb.len;
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	len = policy->policydb.len;
+	rcu_read_unlock();
 
 	return len;
 }
@@ -2309,15 +2375,16 @@ size_t security_policydb_len(struct selinux_state *state)
 int security_port_sid(struct selinux_state *state,
 		      u8 protocol, u16 port, u32 *out_sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct ocontext *c;
 	int rc = 0;
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	c = policydb->ocontexts[OCON_PORT];
 	while (c) {
@@ -2341,7 +2408,7 @@ int security_port_sid(struct selinux_state *state,
 	}
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2354,15 +2421,16 @@ int security_port_sid(struct selinux_state *state,
 int security_ib_pkey_sid(struct selinux_state *state,
 			 u64 subnet_prefix, u16 pkey_num, u32 *out_sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct ocontext *c;
 	int rc = 0;
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	c = policydb->ocontexts[OCON_IBPKEY];
 	while (c) {
@@ -2387,7 +2455,7 @@ int security_ib_pkey_sid(struct selinux_state *state,
 		*out_sid = SECINITSID_UNLABELED;
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2400,15 +2468,16 @@ int security_ib_pkey_sid(struct selinux_state *state,
 int security_ib_endport_sid(struct selinux_state *state,
 			    const char *dev_name, u8 port_num, u32 *out_sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct ocontext *c;
 	int rc = 0;
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	c = policydb->ocontexts[OCON_IBENDPORT];
 	while (c) {
@@ -2433,7 +2502,7 @@ int security_ib_endport_sid(struct selinux_state *state,
 		*out_sid = SECINITSID_UNLABELED;
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2445,15 +2514,16 @@ int security_ib_endport_sid(struct selinux_state *state,
 int security_netif_sid(struct selinux_state *state,
 		       char *name, u32 *if_sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	int rc = 0;
 	struct ocontext *c;
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	c = policydb->ocontexts[OCON_NETIF];
 	while (c) {
@@ -2478,7 +2548,7 @@ int security_netif_sid(struct selinux_state *state,
 		*if_sid = SECINITSID_NETIF;
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2508,15 +2578,16 @@ int security_node_sid(struct selinux_state *state,
 		      u32 addrlen,
 		      u32 *out_sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	int rc;
 	struct ocontext *c;
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	switch (domain) {
 	case AF_INET: {
@@ -2571,7 +2642,7 @@ int security_node_sid(struct selinux_state *state,
 
 	rc = 0;
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2597,6 +2668,7 @@ int security_get_user_sids(struct selinux_state *state,
 			   u32 **sids,
 			   u32 *nel)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct context *fromcon, usercon;
@@ -2613,10 +2685,10 @@ int security_get_user_sids(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		goto out;
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	context_init(&usercon);
 
@@ -2667,7 +2739,7 @@ int security_get_user_sids(struct selinux_state *state,
 	}
 	rc = 0;
 out_unlock:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	if (rc || !mynel) {
 		kfree(mysids);
 		goto out;
@@ -2778,12 +2850,14 @@ int security_genfs_sid(struct selinux_state *state,
 		       u16 orig_sclass,
 		       u32 *sid)
 {
+	struct selinux_policy *policy;
 	int retval;
 
-	read_lock(&state->ss->policy_rwlock);
-	retval = __security_genfs_sid(state->ss->policy,
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	retval = __security_genfs_sid(policy,
 				fstype, path, orig_sclass, sid);
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return retval;
 }
 
@@ -2803,6 +2877,7 @@ int selinux_policy_genfs_sid(struct selinux_policy *policy,
  */
 int security_fs_use(struct selinux_state *state, struct super_block *sb)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	int rc = 0;
@@ -2810,10 +2885,10 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	struct superblock_security_struct *sbsec = sb->s_security;
 	const char *fstype = sb->s_type->name;
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	c = policydb->ocontexts[OCON_FSUSE];
 	while (c) {
@@ -2832,7 +2907,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 		}
 		sbsec->sid = c->sid[0];
 	} else {
-		rc = __security_genfs_sid(state->ss->policy, fstype, "/",
+		rc = __security_genfs_sid(policy, fstype, "/",
 					SECCLASS_DIR, &sbsec->sid);
 		if (rc) {
 			sbsec->behavior = SECURITY_FS_USE_NONE;
@@ -2843,7 +2918,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	}
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2906,23 +2981,27 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 	int rc;
 	u32 i, seqno = 0;
 
+	if (!selinux_initialized(state))
+		return -EINVAL;
+
 	/*
-	 * NOTE: We do not need to take the policy read-lock
+	 * NOTE: We do not need to take the rcu read lock
 	 * around the code below because other policy-modifying
 	 * operations are already excluded by selinuxfs via
 	 * fsi->mutex.
 	 */
 
+	oldpolicy = rcu_dereference_check(state->ss->policy, 1);
+
 	/* Consistency check on number of booleans, should never fail */
-	if (WARN_ON(len != state->ss->policy->policydb.p_bools.nprim))
+	if (WARN_ON(len != oldpolicy->policydb.p_bools.nprim))
 		return -EINVAL;
 
-	newpolicy = kmemdup(state->ss->policy, sizeof(*newpolicy),
-			GFP_KERNEL);
+	newpolicy = kmemdup(oldpolicy, sizeof(*newpolicy), GFP_KERNEL);
 	if (!newpolicy)
 		return -ENOMEM;
-
-	oldpolicy = state->ss->policy;
+	INIT_WORK(&newpolicy->fullfree, selinux_policy_full_free);
+	INIT_WORK(&newpolicy->condfree, selinux_policy_cond_free);
 
 	/*
 	 * Deep copy only the parts of the policydb that might be
@@ -2956,19 +3035,15 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 	evaluate_cond_nodes(&newpolicy->policydb);
 
 	/* Install the new policy */
-	write_lock_irq(&state->ss->policy_rwlock);
-	state->ss->policy = newpolicy;
-	seqno = ++state->ss->latest_granting;
-	write_unlock_irq(&state->ss->policy_rwlock);
+	rcu_assign_pointer(state->ss->policy, newpolicy);
+	seqno = atomic_inc_return(&state->ss->latest_granting);
 
 	/*
 	 * Free the conditional portions of the old policydb
-	 * that were copied for the new policy.
+	 * that were copied for the new policy, and the oldpolicy
+	 * structure itself but not what it references.
 	 */
-	cond_policydb_destroy_dup(&oldpolicy->policydb);
-
-	/* Free the old policy structure but not what it references. */
-	kfree(oldpolicy);
+	call_rcu(&oldpolicy->rhead, selinux_policy_cond_free_rcu);
 
 	/* Notify others of the policy change */
 	selinux_notify_policy_change(state, seqno);
@@ -2978,13 +3053,14 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 int security_get_bool_value(struct selinux_state *state,
 			    u32 index)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	int rc;
 	u32 len;
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
+	rcu_read_lock();
+	policy = state->ss->policy;
+	policydb = &policy->policydb;
 
 	rc = -EFAULT;
 	len = policydb->p_bools.nprim;
@@ -2993,21 +3069,23 @@ int security_get_bool_value(struct selinux_state *state,
 
 	rc = policydb->bool_val_to_struct[index]->state;
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
 static int security_preserve_bools(struct selinux_state *state,
 				   struct policydb *policydb)
 {
+	struct selinux_policy *policy;
 	int rc, *bvalues = NULL;
 	char **bnames = NULL;
 	struct cond_bool_datum *booldatum;
 	u32 i, nbools = 0;
 
-	read_lock(&state->ss->policy_rwlock);
-	rc = security_get_bools(state->ss->policy, &nbools, &bnames, &bvalues);
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+	policy = state->ss->policy;
+	rc = security_get_bools(policy, &nbools, &bnames, &bvalues);
+	rcu_read_unlock();
 	if (rc)
 		goto out;
 	for (i = 0; i < nbools; i++) {
@@ -3034,6 +3112,7 @@ static int security_preserve_bools(struct selinux_state *state,
 int security_sid_mls_copy(struct selinux_state *state,
 			  u32 sid, u32 mls_sid, u32 *new_sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct context *context1;
@@ -3051,10 +3130,10 @@ int security_sid_mls_copy(struct selinux_state *state,
 
 	context_init(&newcon);
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	if (!policydb->mls_enabled) {
 		*new_sid = sid;
@@ -3107,7 +3186,7 @@ int security_sid_mls_copy(struct selinux_state *state,
 	}
 	rc = sidtab_context_to_sid(sidtab, &newcon, new_sid);
 out_unlock:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	context_destroy(&newcon);
 out:
 	return rc;
@@ -3138,6 +3217,7 @@ int security_net_peersid_resolve(struct selinux_state *state,
 				 u32 xfrm_sid,
 				 u32 *peer_sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	int rc;
@@ -3161,10 +3241,10 @@ int security_net_peersid_resolve(struct selinux_state *state,
 		return 0;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	/*
 	 * We don't need to check initialized here since the only way both
@@ -3201,7 +3281,7 @@ int security_net_peersid_resolve(struct selinux_state *state,
 	 * expressive */
 	*peer_sid = xfrm_sid;
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -3305,21 +3385,25 @@ int security_get_permissions(struct selinux_policy *policy,
 
 int security_get_reject_unknown(struct selinux_state *state)
 {
+	struct selinux_policy *policy;
 	int value;
 
-	read_lock(&state->ss->policy_rwlock);
-	value = state->ss->policy->policydb.reject_unknown;
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	value = policy->policydb.reject_unknown;
+	rcu_read_unlock();
 	return value;
 }
 
 int security_get_allow_unknown(struct selinux_state *state)
 {
+	struct selinux_policy *policy;
 	int value;
 
-	read_lock(&state->ss->policy_rwlock);
-	value = state->ss->policy->policydb.allow_unknown;
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	value = policy->policydb.allow_unknown;
+	rcu_read_unlock();
 	return value;
 }
 
@@ -3336,11 +3420,13 @@ int security_get_allow_unknown(struct selinux_state *state)
 int security_policycap_supported(struct selinux_state *state,
 				 unsigned int req_cap)
 {
+	struct selinux_policy *policy;
 	int rc;
 
-	read_lock(&state->ss->policy_rwlock);
-	rc = ebitmap_get_bit(&state->ss->policy->policydb.policycaps, req_cap);
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	rc = ebitmap_get_bit(&policy->policydb.policycaps, req_cap);
+	rcu_read_unlock();
 
 	return rc;
 }
@@ -3363,6 +3449,7 @@ void selinux_audit_rule_free(void *vrule)
 int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 {
 	struct selinux_state *state = &selinux_state;
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct selinux_audit_rule *tmprule;
 	struct role_datum *roledatum;
@@ -3406,11 +3493,11 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 
 	context_init(&tmprule->au_ctxt);
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
 
-	tmprule->au_seqno = state->ss->latest_granting;
+	tmprule->au_seqno = atomic_read(&state->ss->latest_granting);
 
 	switch (field) {
 	case AUDIT_SUBJ_USER:
@@ -3449,7 +3536,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	}
 	rc = 0;
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 
 	if (rc) {
 		selinux_audit_rule_free(tmprule);
@@ -3489,6 +3576,7 @@ int selinux_audit_rule_known(struct audit_krule *rule)
 int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 {
 	struct selinux_state *state = &selinux_state;
+	struct selinux_policy *policy;
 	struct context *ctxt;
 	struct mls_level *level;
 	struct selinux_audit_rule *rule = vrule;
@@ -3499,14 +3587,16 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 		return -ENOENT;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+
+	policy = rcu_dereference(state->ss->policy);
 
-	if (rule->au_seqno < state->ss->latest_granting) {
+	if (rule->au_seqno < atomic_read(&state->ss->latest_granting)) {
 		match = -ESTALE;
 		goto out;
 	}
 
-	ctxt = sidtab_search(state->ss->policy->sidtab, sid);
+	ctxt = sidtab_search(policy->sidtab, sid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
 			  sid);
@@ -3590,7 +3680,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 	}
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return match;
 }
 
@@ -3668,6 +3758,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 				   struct netlbl_lsm_secattr *secattr,
 				   u32 *sid)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	int rc;
@@ -3679,10 +3770,10 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 		return 0;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
-	sidtab = state->ss->policy->sidtab;
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
+	sidtab = policy->sidtab;
 
 	if (secattr->flags & NETLBL_SECATTR_CACHE)
 		*sid = *(u32 *)secattr->cache->data;
@@ -3718,12 +3809,12 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 	} else
 		*sid = SECSID_NULL;
 
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return 0;
 out_free:
 	ebitmap_destroy(&ctx_new.range.level[0].cat);
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -3740,6 +3831,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 int security_netlbl_sid_to_secattr(struct selinux_state *state,
 				   u32 sid, struct netlbl_lsm_secattr *secattr)
 {
+	struct selinux_policy *policy;
 	struct policydb *policydb;
 	int rc;
 	struct context *ctx;
@@ -3747,12 +3839,12 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
-
-	policydb = &state->ss->policy->policydb;
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	policydb = &policy->policydb;
 
 	rc = -ENOENT;
-	ctx = sidtab_search(state->ss->policy->sidtab, sid);
+	ctx = sidtab_search(policy->sidtab, sid);
 	if (ctx == NULL)
 		goto out;
 
@@ -3767,7 +3859,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 	mls_export_netlbl_lvl(policydb, ctx, secattr);
 	rc = mls_export_netlbl_cat(policydb, ctx, secattr);
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 #endif /* CONFIG_NETLABEL */
@@ -3781,6 +3873,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len)
 {
+	struct selinux_policy *policy;
 	int rc;
 	struct policy_file fp;
 
@@ -3796,9 +3889,10 @@ int security_read_policy(struct selinux_state *state,
 	fp.data = *data;
 	fp.len = *len;
 
-	read_lock(&state->ss->policy_rwlock);
-	rc = policydb_write(&state->ss->policy->policydb, &fp);
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_lock();
+	policy = rcu_dereference(state->ss->policy);
+	rc = policydb_write(&policy->policydb, &fp);
+	rcu_read_unlock();
 
 	if (rc)
 		return rc;
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index 06931e34cb24..ddaee0ffcd78 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -7,6 +7,9 @@
 #ifndef _SS_SERVICES_H_
 #define _SS_SERVICES_H_
 
+#include <linux/atomic.h>
+#include <linux/rcupdate.h>
+#include <linux/workqueue.h>
 #include "policydb.h"
 
 /* Mapping for a single class */
@@ -23,15 +26,17 @@ struct selinux_map {
 };
 
 struct selinux_policy {
+	struct rcu_head rhead;
+	struct work_struct fullfree;
+	struct work_struct condfree;
 	struct sidtab *sidtab;
 	struct policydb policydb;
 	struct selinux_map map;
 };
 
 struct selinux_ss {
-	rwlock_t policy_rwlock;
-	u32 latest_granting;
-	struct selinux_policy *policy;
+	atomic_t latest_granting;
+	struct selinux_policy *policy __rcu;
 } __randomize_layout;
 
 void services_compute_xperms_drivers(struct extended_perms *xperms,
-- 
2.25.1

