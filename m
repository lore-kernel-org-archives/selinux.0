Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D69C433E3
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 15:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415C820786
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 15:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/Qq/R3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgHYPVC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:21:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58617 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726934AbgHYPVB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 11:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598368858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78G3KsscjvevRTF9/qEMGoKxGqwELDT9pY705iEF/7k=;
        b=G/Qq/R3g3nM35KIpOVBKsNZsaWH+OJrXYwYSkuaoveq/AdL4dCSc+SjQTrZF7ieYIjrk2O
        PkJSkIepcG5SIPfKVlnCk86nnVz19DusqL7RUOVZ/LkV1PImUcS2qBUogkRG0uSyOgqRtq
        yfQeNuFdli4M0bxOQ9MuEYubI2Wls/0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-oLyOQprrOhWzjhEB2AG99g-1; Tue, 25 Aug 2020 11:20:55 -0400
X-MC-Unique: oLyOQprrOhWzjhEB2AG99g-1
Received: by mail-wr1-f71.google.com with SMTP id d15so2534694wrp.10
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 08:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78G3KsscjvevRTF9/qEMGoKxGqwELDT9pY705iEF/7k=;
        b=NlWwAIaBDXJESVxdVCNT6V+9xZWOadV18YHdZRAQj1wYGYcmLQN4oY0LKqJ8yifLGb
         6RNlgY7/3RiaeQAsFtu0VvjNNq7KuoW3WwkfYiJavt2SPA1akvKBqEUeFiE2XoUU8xQ2
         xNpXUFS1Ipcd+OxdZrwNksDSxx9vaQuI7Iai/6xx9g7ovNt+f6TNabKBNE8g1BfRiB5M
         zH1bT0NAh/H3QXO0cimO/TZlxAqtC8rIbA1QJln1wGFwniNGf8M7HJBj/xeE0P5bG8VE
         k7hAEmgduruLHbV6FjbT7yT/M4koHMxOeBb1QG/JMZj5cP7ebf/zXnClGNteCmB+vk2/
         wTrA==
X-Gm-Message-State: AOAM530MRJ00xYKNp37N14jXUFSWmIc0aC5aa80mVEtNFsk7Kv5B7BEc
        6eSAE11+VpSnOv/14ZEWkDCtyg5IT79ByrxYQyMZh0hbuxWTRdFdBpVHZmKoeemxk8XVf7msq0s
        QqSR598uUvytgvp8zHA==
X-Received: by 2002:adf:9d8a:: with SMTP id p10mr11282494wre.331.1598368852555;
        Tue, 25 Aug 2020 08:20:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+BI03WLOw6tFfBiidvzebVePB8hnM66UOTr6ktDT/PNJwH/o52TDlZOcwMXVDTp70AvFq8A==
X-Received: by 2002:adf:9d8a:: with SMTP id p10mr11282449wre.331.1598368851917;
        Tue, 25 Aug 2020 08:20:51 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id t4sm28372514wre.30.2020.08.25.08.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 08:20:51 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        rcu@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [RFC PATCH 3/3] selinux: track policy lifetime with refcount
Date:   Tue, 25 Aug 2020 17:20:45 +0200
Message-Id: <20200825152045.1719298-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825152045.1719298-1-omosnace@redhat.com>
References: <20200825152045.1719298-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Instead of holding the RCU read lock the whole time while accessing the
policy, add a simple refcount mechanism to track its lifetime. After
this, the RCU read lock is held only for a brief time when fetching the
policy pointer and incrementing the refcount. The policy struct is then
guaranteed to stay alive until the refcount is decremented.

Freeing of the policy remains the responsibility of the task that does
the policy reload. In case the refcount drops to zero in a different
task, the policy load task is notified via a completion.

The advantage of this change is that the operations that access the
policy can now do sleeping allocations, since they don't need to hold
the RCU read lock anymore. This patch so far only leverages this in
security_read_policy() for the vmalloc_user() allocation (although this
function is always called under fsi->mutex and could just access the
policy pointer directly). The conversion of affected GFP_ATOMIC
allocations to GFP_KERNEL is left for a later patch, since auditing
which code paths may still need GFP_ATOMIC is not very easy.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/services.c | 286 ++++++++++++++++-----------------
 security/selinux/ss/services.h |   6 +
 2 files changed, 147 insertions(+), 145 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index d863b23f2a670..393bc7cc03d73 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -66,6 +66,33 @@
 #include "audit.h"
 #include "policycap_names.h"
 
+static struct selinux_policy *selinux_policy_get(struct selinux_state *state)
+{
+	struct selinux_policy *policy;
+
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	if (policy)
+		refcount_inc(&policy->refcount);
+	policy = rcu_pointer_handoff(policy);
+	rcu_read_unlock();
+
+	return policy;
+}
+
+static void selinux_policy_put(struct selinux_policy *policy)
+{
+	if (!policy)
+		return;
+
+	/*
+	 * Decrement the refcount and if it becomes zero, tell
+	 * the loading task that it can now free the policy.
+	 */
+	if (unlikely(refcount_dec_and_test(&policy->refcount)))
+		complete(&policy->eol);
+}
+
 /* Forward declaration. */
 static int context_struct_to_string(struct policydb *policydb,
 				    struct context *context,
@@ -233,13 +260,12 @@ int security_mls_enabled(struct selinux_state *state)
 	int mls_enabled;
 	struct selinux_policy *policy;
 
-	if (!selinux_initialized(state))
+	policy = selinux_policy_get(state);
+	if (!policy)
 		return 0;
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	mls_enabled = policy->policydb.mls_enabled;
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return mls_enabled;
 }
 
@@ -758,12 +784,10 @@ static int security_compute_validatetrans(struct selinux_state *state,
 	int rc = 0;
 
 
-	if (!selinux_initialized(state))
+	policy = selinux_policy_get(state);
+	if (!policy)
 		return 0;
 
-	rcu_read_lock();
-
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 	sidtab = policy->sidtab;
 
@@ -822,7 +846,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
 	}
 
 out:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return rc;
 }
 
@@ -862,11 +886,10 @@ int security_bounded_transition(struct selinux_state *state,
 	int index;
 	int rc;
 
-	if (!selinux_initialized(state))
+	policy = selinux_policy_get(state);
+	if (!policy)
 		return 0;
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 	sidtab = policy->sidtab;
 
@@ -929,7 +952,7 @@ int security_bounded_transition(struct selinux_state *state,
 		kfree(old_name);
 	}
 out:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 
 	return rc;
 }
@@ -1024,11 +1047,10 @@ void security_compute_xperms_decision(struct selinux_state *state,
 	memset(xpermd->auditallow->p, 0, sizeof(xpermd->auditallow->p));
 	memset(xpermd->dontaudit->p, 0, sizeof(xpermd->dontaudit->p));
 
-	rcu_read_lock();
-	if (!selinux_initialized(state))
+	policy = selinux_policy_get(state);
+	if (!policy)
 		goto allow;
 
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 	sidtab = policy->sidtab;
 
@@ -1078,7 +1100,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 		}
 	}
 out:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return;
 allow:
 	memset(xpermd->allowed->p, 0xff, sizeof(xpermd->allowed->p));
@@ -1109,11 +1131,10 @@ void security_compute_av(struct selinux_state *state,
 	u16 tclass;
 	struct context *scontext = NULL, *tcontext = NULL;
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
+	policy = selinux_policy_get(state);
 	avd_init(policy, avd);
 	xperms->len = 0;
-	if (!selinux_initialized(state))
+	if (!policy)
 		goto allow;
 
 	policydb = &policy->policydb;
@@ -1148,7 +1169,7 @@ void security_compute_av(struct selinux_state *state,
 	map_decision(&policy->map, orig_tclass, avd,
 		     policydb->allow_unknown);
 out:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return;
 allow:
 	avd->allowed = 0xffffffff;
@@ -1166,10 +1187,9 @@ void security_compute_av_user(struct selinux_state *state,
 	struct sidtab *sidtab;
 	struct context *scontext = NULL, *tcontext = NULL;
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
+	policy = selinux_policy_get(state);
 	avd_init(policy, avd);
-	if (!selinux_initialized(state))
+	if (!policy)
 		goto allow;
 
 	policydb = &policy->policydb;
@@ -1201,8 +1221,8 @@ void security_compute_av_user(struct selinux_state *state,
 
 	context_struct_compute_av(policydb, scontext, tcontext, tclass, avd,
 				  NULL);
- out:
-	rcu_read_unlock();
+out:
+	selinux_policy_put(policy);
 	return;
 allow:
 	avd->allowed = 0xffffffff;
@@ -1290,16 +1310,15 @@ int security_sidtab_hash_stats(struct selinux_state *state, char *page)
 	struct selinux_policy *policy;
 	int rc;
 
-	if (!selinux_initialized(state)) {
+	policy = selinux_policy_get(state);
+	if (!policy) {
 		pr_err("SELinux: %s:  called before initial load_policy\n",
 		       __func__);
 		return -EINVAL;
 	}
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	rc = sidtab_hash_stats(policy->sidtab, page);
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 
 	return rc;
 }
@@ -1326,7 +1345,8 @@ static int security_sid_to_context_core(struct selinux_state *state,
 		*scontext = NULL;
 	*scontext_len  = 0;
 
-	if (!selinux_initialized(state)) {
+	policy = selinux_policy_get(state);
+	if (!policy) {
 		if (sid <= SECINITSID_NUM) {
 			char *scontextp;
 			const char *s = initial_sid_to_string[sid];
@@ -1346,8 +1366,6 @@ static int security_sid_to_context_core(struct selinux_state *state,
 		       "load_policy on unknown SID %d\n", __func__, sid);
 		return -EINVAL;
 	}
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 	sidtab = policy->sidtab;
 
@@ -1368,7 +1386,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 				    scontext_len);
 
 out_unlock:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return rc;
 
 }
@@ -1519,7 +1537,8 @@ static int security_context_to_sid_core(struct selinux_state *state,
 	if (!scontext2)
 		return -ENOMEM;
 
-	if (!selinux_initialized(state)) {
+	policy = selinux_policy_get(state);
+	if (!policy) {
 		int i;
 
 		for (i = 1; i < SECINITSID_NUM; i++) {
@@ -1542,8 +1561,6 @@ static int security_context_to_sid_core(struct selinux_state *state,
 		if (!str)
 			goto out;
 	}
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 	sidtab = policy->sidtab;
 	rc = string_to_context_struct(policydb, sidtab, scontext2,
@@ -1553,12 +1570,11 @@ static int security_context_to_sid_core(struct selinux_state *state,
 		context.len = strlen(str) + 1;
 		str = NULL;
 	} else if (rc)
-		goto out_unlock;
+		goto out;
 	rc = sidtab_context_to_sid(sidtab, &context, sid);
 	context_destroy(&context);
-out_unlock:
-	rcu_read_unlock();
 out:
+	selinux_policy_put(policy);
 	kfree(scontext2);
 	kfree(str);
 	return rc;
@@ -1714,7 +1730,8 @@ static int security_compute_sid(struct selinux_state *state,
 	int rc = 0;
 	bool sock;
 
-	if (!selinux_initialized(state)) {
+	policy = selinux_policy_get(state);
+	if (!policy) {
 		switch (orig_tclass) {
 		case SECCLASS_PROCESS: /* kernel value */
 			*out_sid = ssid;
@@ -1728,10 +1745,6 @@ static int security_compute_sid(struct selinux_state *state,
 
 	context_init(&newcontext);
 
-	rcu_read_lock();
-
-	policy = rcu_dereference(state->policy);
-
 	if (kern) {
 		tclass = unmap_class(&policy->map, orig_tclass);
 		sock = security_is_socket_class(orig_tclass);
@@ -1871,7 +1884,7 @@ static int security_compute_sid(struct selinux_state *state,
 	/* Obtain the sid for the context. */
 	rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
 out_unlock:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	context_destroy(&newcontext);
 out:
 	return rc;
@@ -2220,14 +2233,15 @@ void selinux_policy_commit(struct selinux_state *state,
 
 	if (!oldpolicy) {
 		/*
-		 * After first policy load, the security server is
-		 * marked as initialized and ready to handle requests and
-		 * any objects created prior to policy load are then labeled.
+		 * After first policy load, any objects created prior
+		 * to policy load need to be labeled.
 		 */
 		selinux_complete_init();
 	} else {
 		/* Free the old policy */
 		synchronize_rcu();
+		if (unlikely(!refcount_dec_and_test(&oldpolicy->refcount)))
+			wait_for_completion(&oldpolicy->eol);
 		selinux_policy_free(oldpolicy);
 	}
 
@@ -2258,6 +2272,9 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 	if (!newpolicy)
 		return -ENOMEM;
 
+	refcount_set(&newpolicy->refcount, 1);
+	init_completion(&newpolicy->eol);
+
 	newpolicy->sidtab = kzalloc(sizeof(*newpolicy->sidtab), GFP_KERNEL);
 	if (!newpolicy->sidtab)
 		goto err;
@@ -2340,13 +2357,10 @@ int security_port_sid(struct selinux_state *state,
 	struct ocontext *c;
 	int rc = 0;
 
-	if (!selinux_initialized(state)) {
-		*out_sid = SECINITSID_PORT;
+	policy = selinux_policy_get(state);
+	if (!policy)
 		return 0;
-	}
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 	sidtab = policy->sidtab;
 
@@ -2372,7 +2386,7 @@ int security_port_sid(struct selinux_state *state,
 	}
 
 out:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return rc;
 }
 
@@ -2391,13 +2405,12 @@ int security_ib_pkey_sid(struct selinux_state *state,
 	struct ocontext *c;
 	int rc = 0;
 
-	if (!selinux_initialized(state)) {
+	policy = selinux_policy_get(state);
+	if (!policy) {
 		*out_sid = SECINITSID_UNLABELED;
 		return 0;
 	}
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 	sidtab = policy->sidtab;
 
@@ -2424,7 +2437,7 @@ int security_ib_pkey_sid(struct selinux_state *state,
 		*out_sid = SECINITSID_UNLABELED;
 
 out:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return rc;
 }
 
@@ -2443,13 +2456,12 @@ int security_ib_endport_sid(struct selinux_state *state,
 	struct ocontext *c;
 	int rc = 0;
 
-	if (!selinux_initialized(state)) {
+	policy = selinux_policy_get(state);
+	if (!policy) {
 		*out_sid = SECINITSID_UNLABELED;
 		return 0;
 	}
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 	sidtab = policy->sidtab;
 
@@ -2476,7 +2488,7 @@ int security_ib_endport_sid(struct selinux_state *state,
 		*out_sid = SECINITSID_UNLABELED;
 
 out:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return rc;
 }
 
@@ -2494,13 +2506,12 @@ int security_netif_sid(struct selinux_state *state,
 	int rc = 0;
 	struct ocontext *c;
 
-	if (!selinux_initialized(state)) {
+	policy = selinux_policy_get(state);
+	if (!policy) {
 		*if_sid = SECINITSID_NETIF;
 		return 0;
 	}
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 	sidtab = policy->sidtab;
 
@@ -2527,7 +2538,7 @@ int security_netif_sid(struct selinux_state *state,
 		*if_sid = SECINITSID_NETIF;
 
 out:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return rc;
 }
 
@@ -2563,13 +2574,12 @@ int security_node_sid(struct selinux_state *state,
 	int rc;
 	struct ocontext *c;
 
-	if (!selinux_initialized(state)) {
+	policy = selinux_policy_get(state);
+	if (!policy) {
 		*out_sid = SECINITSID_NODE;
 		return 0;
 	}
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 	sidtab = policy->sidtab;
 
@@ -2626,7 +2636,7 @@ int security_node_sid(struct selinux_state *state,
 
 	rc = 0;
 out:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return rc;
 }
 
@@ -2666,11 +2676,10 @@ int security_get_user_sids(struct selinux_state *state,
 	*sids = NULL;
 	*nel = 0;
 
-	if (!selinux_initialized(state))
+	policy = selinux_policy_get(state);
+	if (!policy)
 		goto out;
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 	sidtab = policy->sidtab;
 
@@ -2723,7 +2732,7 @@ int security_get_user_sids(struct selinux_state *state,
 	}
 	rc = 0;
 out_unlock:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	if (rc || !mynel) {
 		kfree(mysids);
 		goto out;
@@ -2837,16 +2846,15 @@ int security_genfs_sid(struct selinux_state *state,
 	struct selinux_policy *policy;
 	int retval;
 
-	if (!selinux_initialized(state)) {
+	policy = selinux_policy_get(state);
+	if (!policy) {
 		*sid = SECINITSID_UNLABELED;
 		return 0;
 	}
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	retval = __security_genfs_sid(policy,
 				fstype, path, orig_sclass, sid);
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return retval;
 }
 
@@ -2874,14 +2882,13 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	struct superblock_security_struct *sbsec = sb->s_security;
 	const char *fstype = sb->s_type->name;
 
-	if (!selinux_initialized(state)) {
+	policy = selinux_policy_get(state);
+	if (!policy) {
 		sbsec->behavior = SECURITY_FS_USE_NONE;
 		sbsec->sid = SECINITSID_UNLABELED;
 		return 0;
 	}
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 	sidtab = policy->sidtab;
 
@@ -2913,7 +2920,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	}
 
 out:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return rc;
 }
 
@@ -2976,17 +2983,15 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 	int rc;
 	u32 i, seqno = 0;
 
-	if (!selinux_initialized(state))
-		return -EINVAL;
-
 	/*
 	 * NOTE: We do not need to take the rcu read lock
 	 * around the code below because other policy-modifying
 	 * operations are already excluded by selinuxfs via
 	 * fsi->mutex.
 	 */
-
 	oldpolicy = rcu_dereference_check(state->policy, 1);
+	if (!oldpolicy)
+		return -EINVAL;
 
 	/* Consistency check on number of booleans, should never fail */
 	if (WARN_ON(len != oldpolicy->policydb.p_bools.nprim))
@@ -2996,6 +3001,10 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 	if (!newpolicy)
 		return -ENOMEM;
 
+	/* Re-init lifecycle management fields. */
+	refcount_set(&newpolicy->refcount, 1);
+	init_completion(&newpolicy->eol);
+
 	/*
 	 * Deep copy only the parts of the policydb that might be
 	 * modified as a result of changing booleans.
@@ -3040,6 +3049,8 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 	 * structure itself but not what it references.
 	 */
 	synchronize_rcu();
+	if (unlikely(!refcount_dec_and_test(&oldpolicy->refcount)))
+		wait_for_completion(&oldpolicy->eol);
 	selinux_policy_cond_free(oldpolicy);
 
 	/* Notify others of the policy change */
@@ -3055,11 +3066,10 @@ int security_get_bool_value(struct selinux_state *state,
 	int rc;
 	u32 len;
 
-	if (!selinux_initialized(state))
+	policy = selinux_policy_get(state);
+	if (!policy)
 		return 0;
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 
 	rc = -EFAULT;
@@ -3069,7 +3079,7 @@ int security_get_bool_value(struct selinux_state *state,
 
 	rc = policydb->bool_val_to_struct[index]->state;
 out:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return rc;
 }
 
@@ -3120,15 +3130,14 @@ int security_sid_mls_copy(struct selinux_state *state,
 	int rc;
 
 	rc = 0;
-	if (!selinux_initialized(state)) {
+	policy = selinux_policy_get(state);
+	if (!policy) {
 		*new_sid = sid;
 		goto out;
 	}
 
 	context_init(&newcon);
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 	sidtab = policy->sidtab;
 
@@ -3184,7 +3193,7 @@ int security_sid_mls_copy(struct selinux_state *state,
 	}
 	rc = sidtab_context_to_sid(sidtab, &newcon, new_sid);
 out_unlock:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	context_destroy(&newcon);
 out:
 	return rc;
@@ -3239,11 +3248,10 @@ int security_net_peersid_resolve(struct selinux_state *state,
 		return 0;
 	}
 
-	if (!selinux_initialized(state))
+	policy = selinux_policy_get(state);
+	if (!policy)
 		return 0;
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 	sidtab = policy->sidtab;
 
@@ -3282,7 +3290,7 @@ int security_net_peersid_resolve(struct selinux_state *state,
 	 * expressive */
 	*peer_sid = xfrm_sid;
 out:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return rc;
 }
 
@@ -3389,13 +3397,12 @@ int security_get_reject_unknown(struct selinux_state *state)
 	struct selinux_policy *policy;
 	int value;
 
-	if (!selinux_initialized(state))
+	policy = selinux_policy_get(state);
+	if (!policy)
 		return 0;
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	value = policy->policydb.reject_unknown;
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return value;
 }
 
@@ -3404,13 +3411,12 @@ int security_get_allow_unknown(struct selinux_state *state)
 	struct selinux_policy *policy;
 	int value;
 
-	if (!selinux_initialized(state))
+	policy = selinux_policy_get(state);
+	if (!policy)
 		return 0;
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	value = policy->policydb.allow_unknown;
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return value;
 }
 
@@ -3430,13 +3436,12 @@ int security_policycap_supported(struct selinux_state *state,
 	struct selinux_policy *policy;
 	int rc;
 
-	if (!selinux_initialized(state))
+	policy = selinux_policy_get(state);
+	if (!policy)
 		return 0;
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	rc = ebitmap_get_bit(&policy->policydb.policycaps, req_cap);
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 
 	return rc;
 }
@@ -3470,9 +3475,6 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 
 	*rule = NULL;
 
-	if (!selinux_initialized(state))
-		return -EOPNOTSUPP;
-
 	switch (field) {
 	case AUDIT_SUBJ_USER:
 	case AUDIT_SUBJ_ROLE:
@@ -3497,14 +3499,16 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 		return -EINVAL;
 	}
 
+	policy = selinux_policy_get(state);
+	if (!policy)
+		return -EOPNOTSUPP;
+
 	tmprule = kzalloc(sizeof(struct selinux_audit_rule), GFP_KERNEL);
 	if (!tmprule)
 		return -ENOMEM;
 
 	context_init(&tmprule->au_ctxt);
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 
 	tmprule->au_seqno = policy->latest_granting;
@@ -3546,7 +3550,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	}
 	rc = 0;
 out:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 
 	if (rc) {
 		selinux_audit_rule_free(tmprule);
@@ -3597,13 +3601,10 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 		return -ENOENT;
 	}
 
-	if (!selinux_initialized(state))
+	policy = selinux_policy_get(state);
+	if (!policy)
 		return 0;
 
-	rcu_read_lock();
-
-	policy = rcu_dereference(state->policy);
-
 	if (rule->au_seqno < policy->latest_granting) {
 		match = -ESTALE;
 		goto out;
@@ -3693,7 +3694,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 	}
 
 out:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return match;
 }
 
@@ -3778,13 +3779,12 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 	struct context *ctx;
 	struct context ctx_new;
 
-	if (!selinux_initialized(state)) {
+	policy = selinux_policy_get(state);
+	if (!policy) {
 		*sid = SECSID_NULL;
 		return 0;
 	}
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 	sidtab = policy->sidtab;
 
@@ -3822,12 +3822,12 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 	} else
 		*sid = SECSID_NULL;
 
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return 0;
 out_free:
 	ebitmap_destroy(&ctx_new.range.level[0].cat);
 out:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return rc;
 }
 
@@ -3849,11 +3849,10 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 	int rc;
 	struct context *ctx;
 
-	if (!selinux_initialized(state))
+	policy = selinux_policy_get(state);
+	if (!policy)
 		return 0;
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
 
 	rc = -ENOENT;
@@ -3872,7 +3871,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 	mls_export_netlbl_lvl(policydb, ctx, secattr);
 	rc = mls_export_netlbl_cat(policydb, ctx, secattr);
 out:
-	rcu_read_unlock();
+	selinux_policy_put(policy);
 	return rc;
 }
 #endif /* CONFIG_NETLABEL */
@@ -3890,25 +3889,22 @@ int security_read_policy(struct selinux_state *state,
 	int rc;
 	struct policy_file fp;
 
-	if (!selinux_initialized(state))
+	policy = selinux_policy_get(state);
+	if (!policy)
 		return -EINVAL;
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	*len = policy->policydb.len;
-	rcu_read_unlock();
 
 	*data = vmalloc_user(*len);
-	if (!*data)
-		return -ENOMEM;
-
-	fp.data = *data;
-	fp.len = *len;
+	if (*data) {
+		fp.data = *data;
+		fp.len = *len;
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
-	rc = policydb_write(&policy->policydb, &fp);
-	rcu_read_unlock();
+		rc = policydb_write(&policy->policydb, &fp);
+	} else {
+		rc = -ENOMEM;
+	}
+	selinux_policy_put(policy);
 
 	if (rc)
 		return rc;
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index 9555ad074303c..104ca16037baa 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -9,6 +9,9 @@
 
 #include "policydb.h"
 
+#include <linux/refcount.h>
+#include <linux/completion.h>
+
 /* Mapping for a single class */
 struct selinux_mapping {
 	u16 value; /* policy value for class */
@@ -23,6 +26,9 @@ struct selinux_map {
 };
 
 struct selinux_policy {
+	refcount_t refcount;
+	struct completion eol;
+
 	struct sidtab *sidtab;
 	struct policydb policydb;
 	struct selinux_map map;
-- 
2.26.2

