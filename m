Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145B2C433B4
	for <selinux@archiver.kernel.org>; Tue,  6 Apr 2021 09:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6208610E8
	for <selinux@archiver.kernel.org>; Tue,  6 Apr 2021 09:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244741AbhDFJFM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Apr 2021 05:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233952AbhDFJFK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Apr 2021 05:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617699902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ggRJBFPjYKDLPo0xWBDCtx/liTIaK6+hGtGr2ZDYf54=;
        b=csN6RE1TBrB+sFaR15gpeNHTZjR32B5YqzSvo1k7Wf4OlocOw04l0vCxYzfWbQc53rYkIe
        XNoTwfZKrMq67Bio7h1vM7T5cunxTJP7m8G47/jm+3EYZilWfYAxavw3GyrJcvAWDdlqOZ
        +6n2dm4NjJIjxbfWVbs7yhGTt3miNt4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-cbU8UrAROdGih3a8n1db8Q-1; Tue, 06 Apr 2021 05:05:00 -0400
X-MC-Unique: cbU8UrAROdGih3a8n1db8Q-1
Received: by mail-ej1-f72.google.com with SMTP id h14so5199429ejg.7
        for <selinux@vger.kernel.org>; Tue, 06 Apr 2021 02:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggRJBFPjYKDLPo0xWBDCtx/liTIaK6+hGtGr2ZDYf54=;
        b=TucUWImJSW+OKFzA4b/jJVENN+sItlL2rrYoD6GJivgnWytqfV77mT6lvMWK8Sv+aP
         xBQECjQXkD9pUiFWxUe7CFeOf4CVLkQMczuAlEyBrfYXeVG0aoyVXXfGAId+oeps7glM
         Oku3QzB7J4/1qruhpAVf+Zp3YWzM318QYMoU2iqPgbmQRh4auwIdyA6fY5PJ43EmFTH4
         O4PFZzUNEvnyqgv5gOwfi9cdAkUMqcSbjPzB7NJeRqBWamT2oBirFl8fQDVk/mLbnL8V
         rUQyDiRvpwV75p6NaXxPhYgQYv8rj3kR3i80shWT0TDhqKDZZVqcRHnkkYKKEyxskcwu
         vRPQ==
X-Gm-Message-State: AOAM5315QgwA4zjXPBRycM1JXzjcKeI67fjcg5t414vjk4adA+PcHSOX
        fQMG25SrenBiap0u30bQfnR3yCxUmQ9WoceGHRXkRsFfLY24XtGqincNgepcUT3+iTOzE+CIc9J
        fZIGKEnffsQCNPbXkT0jstaoudplEc4QQ8TXUR9Cfn+YXWV98C8dWEj/PCxs0iHV/e/Pevw==
X-Received: by 2002:a17:906:4a5a:: with SMTP id a26mr2935915ejv.8.1617699898793;
        Tue, 06 Apr 2021 02:04:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz+Mt2K16j2hLm6loqo2JXFEbgBO2yMblF+eVEFVJQC68BGLSW2R75yxasWOe4Nz9NXMS8WA==
X-Received: by 2002:a17:906:4a5a:: with SMTP id a26mr2935880ejv.8.1617699898496;
        Tue, 06 Apr 2021 02:04:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id a12sm6729240ejy.87.2021.04.06.02.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 02:04:58 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] selinux: fix race between old and new sidtab
Date:   Tue,  6 Apr 2021 11:04:55 +0200
Message-Id: <20210406090455.2455460-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since commit 1b8b31a2e612 ("selinux: convert policy read-write lock to
RCU"), there is a small window during policy load where the new policy
pointer has already been installed, but some threads may still be
holding the old policy pointer in their read-side RCU critical sections.
This means that there may be conflicting attempts to add a new SID entry
to both tables via sidtab_context_to_sid().

See also (and the rest of the thread):
https://lore.kernel.org/selinux/CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com/

Fix this by installing the new policy pointer under the old sidtab's
spinlock along with marking the old sidtab as "frozen". Then, if an
attempt to add new entry to a "frozen" sidtab is detected, make
sidtab_context_to_sid() return -ESTALE to indicate that a new policy
has been installed and that the caller will have to abort the policy
transaction and try again after re-taking the policy pointer (which is
guaranteed to be a newer policy). This requires adding a retry-on-ESTALE
logic to all callers of sidtab_context_to_sid(), but fortunately these
are easy to determine and aren't that many.

This seems to be the simplest solution for this problem, even if it
looks somewhat ugly. Note that other places in the kernel (e.g.
do_mknodat() in fs/namei.c) use similar stale-retry patterns, so I think
it's reasonable.

Fixes: 1b8b31a2e612 ("selinux: convert policy read-write lock to RCU")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v2: reset cladatum to NULL on retry in security_compute_sid()

 security/selinux/ss/services.c | 148 ++++++++++++++++++++++++++-------
 security/selinux/ss/sidtab.c   |  21 +++++
 security/selinux/ss/sidtab.h   |   4 +
 3 files changed, 141 insertions(+), 32 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 08ac1d01c743..801f94eaf9c5 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1552,6 +1552,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 		if (!str)
 			goto out;
 	}
+retry:
 	rcu_read_lock();
 	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
@@ -1565,6 +1566,15 @@ static int security_context_to_sid_core(struct selinux_state *state,
 	} else if (rc)
 		goto out_unlock;
 	rc = sidtab_context_to_sid(sidtab, &context, sid);
+	if (rc == -ESTALE) {
+		rcu_read_unlock();
+		if (context.str) {
+			str = context.str;
+			context.str = NULL;
+		}
+		context_destroy(&context);
+		goto retry;
+	}
 	context_destroy(&context);
 out_unlock:
 	rcu_read_unlock();
@@ -1714,7 +1724,7 @@ static int security_compute_sid(struct selinux_state *state,
 	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
-	struct class_datum *cladatum = NULL;
+	struct class_datum *cladatum;
 	struct context *scontext, *tcontext, newcontext;
 	struct sidtab_entry *sentry, *tentry;
 	struct avtab_key avkey;
@@ -1736,6 +1746,8 @@ static int security_compute_sid(struct selinux_state *state,
 		goto out;
 	}
 
+retry:
+	cladatum = NULL;
 	context_init(&newcontext);
 
 	rcu_read_lock();
@@ -1880,6 +1892,11 @@ static int security_compute_sid(struct selinux_state *state,
 	}
 	/* Obtain the sid for the context. */
 	rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
+	if (rc == -ESTALE) {
+		rcu_read_unlock();
+		context_destroy(&newcontext);
+		goto retry;
+	}
 out_unlock:
 	rcu_read_unlock();
 	context_destroy(&newcontext);
@@ -2192,6 +2209,7 @@ void selinux_policy_commit(struct selinux_state *state,
 			   struct selinux_load_state *load_state)
 {
 	struct selinux_policy *oldpolicy, *newpolicy = load_state->policy;
+	unsigned long flags;
 	u32 seqno;
 
 	oldpolicy = rcu_dereference_protected(state->policy,
@@ -2213,7 +2231,13 @@ void selinux_policy_commit(struct selinux_state *state,
 	seqno = newpolicy->latest_granting;
 
 	/* Install the new policy. */
-	rcu_assign_pointer(state->policy, newpolicy);
+	if (oldpolicy) {
+		sidtab_freeze_begin(oldpolicy->sidtab, &flags);
+		rcu_assign_pointer(state->policy, newpolicy);
+		sidtab_freeze_end(oldpolicy->sidtab, &flags);
+	} else {
+		rcu_assign_pointer(state->policy, newpolicy);
+	}
 
 	/* Load the policycaps from the new policy */
 	security_load_policycaps(state, newpolicy);
@@ -2357,13 +2381,15 @@ int security_port_sid(struct selinux_state *state,
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct ocontext *c;
-	int rc = 0;
+	int rc;
 
 	if (!selinux_initialized(state)) {
 		*out_sid = SECINITSID_PORT;
 		return 0;
 	}
 
+retry:
+	rc = 0;
 	rcu_read_lock();
 	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
@@ -2382,6 +2408,10 @@ int security_port_sid(struct selinux_state *state,
 		if (!c->sid[0]) {
 			rc = sidtab_context_to_sid(sidtab, &c->context[0],
 						   &c->sid[0]);
+			if (rc == -ESTALE) {
+				rcu_read_unlock();
+				goto retry;
+			}
 			if (rc)
 				goto out;
 		}
@@ -2408,13 +2438,15 @@ int security_ib_pkey_sid(struct selinux_state *state,
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct ocontext *c;
-	int rc = 0;
+	int rc;
 
 	if (!selinux_initialized(state)) {
 		*out_sid = SECINITSID_UNLABELED;
 		return 0;
 	}
 
+retry:
+	rc = 0;
 	rcu_read_lock();
 	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
@@ -2435,6 +2467,10 @@ int security_ib_pkey_sid(struct selinux_state *state,
 			rc = sidtab_context_to_sid(sidtab,
 						   &c->context[0],
 						   &c->sid[0]);
+			if (rc == -ESTALE) {
+				rcu_read_unlock();
+				goto retry;
+			}
 			if (rc)
 				goto out;
 		}
@@ -2460,13 +2496,15 @@ int security_ib_endport_sid(struct selinux_state *state,
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	struct ocontext *c;
-	int rc = 0;
+	int rc;
 
 	if (!selinux_initialized(state)) {
 		*out_sid = SECINITSID_UNLABELED;
 		return 0;
 	}
 
+retry:
+	rc = 0;
 	rcu_read_lock();
 	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
@@ -2487,6 +2525,10 @@ int security_ib_endport_sid(struct selinux_state *state,
 		if (!c->sid[0]) {
 			rc = sidtab_context_to_sid(sidtab, &c->context[0],
 						   &c->sid[0]);
+			if (rc == -ESTALE) {
+				rcu_read_unlock();
+				goto retry;
+			}
 			if (rc)
 				goto out;
 		}
@@ -2510,7 +2552,7 @@ int security_netif_sid(struct selinux_state *state,
 	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
-	int rc = 0;
+	int rc;
 	struct ocontext *c;
 
 	if (!selinux_initialized(state)) {
@@ -2518,6 +2560,8 @@ int security_netif_sid(struct selinux_state *state,
 		return 0;
 	}
 
+retry:
+	rc = 0;
 	rcu_read_lock();
 	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
@@ -2534,10 +2578,18 @@ int security_netif_sid(struct selinux_state *state,
 		if (!c->sid[0] || !c->sid[1]) {
 			rc = sidtab_context_to_sid(sidtab, &c->context[0],
 						   &c->sid[0]);
+			if (rc == -ESTALE) {
+				rcu_read_unlock();
+				goto retry;
+			}
 			if (rc)
 				goto out;
 			rc = sidtab_context_to_sid(sidtab, &c->context[1],
 						   &c->sid[1]);
+			if (rc == -ESTALE) {
+				rcu_read_unlock();
+				goto retry;
+			}
 			if (rc)
 				goto out;
 		}
@@ -2587,6 +2639,7 @@ int security_node_sid(struct selinux_state *state,
 		return 0;
 	}
 
+retry:
 	rcu_read_lock();
 	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
@@ -2635,6 +2688,10 @@ int security_node_sid(struct selinux_state *state,
 			rc = sidtab_context_to_sid(sidtab,
 						   &c->context[0],
 						   &c->sid[0]);
+			if (rc == -ESTALE) {
+				rcu_read_unlock();
+				goto retry;
+			}
 			if (rc)
 				goto out;
 		}
@@ -2676,18 +2733,20 @@ int security_get_user_sids(struct selinux_state *state,
 	struct sidtab *sidtab;
 	struct context *fromcon, usercon;
 	u32 *mysids = NULL, *mysids2, sid;
-	u32 mynel = 0, maxnel = SIDS_NEL;
+	u32 i, j, mynel, maxnel = SIDS_NEL;
 	struct user_datum *user;
 	struct role_datum *role;
 	struct ebitmap_node *rnode, *tnode;
-	int rc = 0, i, j;
+	int rc;
 
 	*sids = NULL;
 	*nel = 0;
 
 	if (!selinux_initialized(state))
-		goto out;
+		return 0;
 
+retry:
+	mynel = 0;
 	rcu_read_lock();
 	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
@@ -2723,6 +2782,10 @@ int security_get_user_sids(struct selinux_state *state,
 				continue;
 
 			rc = sidtab_context_to_sid(sidtab, &usercon, &sid);
+			if (rc == -ESTALE) {
+				rcu_read_unlock();
+				goto retry;
+			}
 			if (rc)
 				goto out_unlock;
 			if (mynel < maxnel) {
@@ -2745,14 +2808,14 @@ out_unlock:
 	rcu_read_unlock();
 	if (rc || !mynel) {
 		kfree(mysids);
-		goto out;
+		return rc;
 	}
 
 	rc = -ENOMEM;
 	mysids2 = kcalloc(mynel, sizeof(*mysids2), GFP_KERNEL);
 	if (!mysids2) {
 		kfree(mysids);
-		goto out;
+		return rc;
 	}
 	for (i = 0, j = 0; i < mynel; i++) {
 		struct av_decision dummy_avd;
@@ -2765,12 +2828,10 @@ out_unlock:
 			mysids2[j++] = mysids[i];
 		cond_resched();
 	}
-	rc = 0;
 	kfree(mysids);
 	*sids = mysids2;
 	*nel = j;
-out:
-	return rc;
+	return 0;
 }
 
 /**
@@ -2783,6 +2844,9 @@ out:
  * Obtain a SID to use for a file in a filesystem that
  * cannot support xattr or use a fixed labeling behavior like
  * transition SIDs or task SIDs.
+ *
+ * WARNING: This function may return -ESTALE, indicating that the caller
+ * must retry the operation after re-acquiring the policy pointer!
  */
 static inline int __security_genfs_sid(struct selinux_policy *policy,
 				       const char *fstype,
@@ -2861,11 +2925,13 @@ int security_genfs_sid(struct selinux_state *state,
 		return 0;
 	}
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
-	retval = __security_genfs_sid(policy,
-				fstype, path, orig_sclass, sid);
-	rcu_read_unlock();
+	do {
+		rcu_read_lock();
+		policy = rcu_dereference(state->policy);
+		retval = __security_genfs_sid(policy, fstype, path,
+					      orig_sclass, sid);
+		rcu_read_unlock();
+	} while (retval == -ESTALE);
 	return retval;
 }
 
@@ -2888,7 +2954,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
-	int rc = 0;
+	int rc;
 	struct ocontext *c;
 	struct superblock_security_struct *sbsec = sb->s_security;
 	const char *fstype = sb->s_type->name;
@@ -2899,6 +2965,8 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 		return 0;
 	}
 
+retry:
+	rc = 0;
 	rcu_read_lock();
 	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
@@ -2916,6 +2984,10 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 		if (!c->sid[0]) {
 			rc = sidtab_context_to_sid(sidtab, &c->context[0],
 						   &c->sid[0]);
+			if (rc == -ESTALE) {
+				rcu_read_unlock();
+				goto retry;
+			}
 			if (rc)
 				goto out;
 		}
@@ -2923,6 +2995,10 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	} else {
 		rc = __security_genfs_sid(policy, fstype, "/",
 					SECCLASS_DIR, &sbsec->sid);
+		if (rc == -ESTALE) {
+			rcu_read_unlock();
+			goto retry;
+		}
 		if (rc) {
 			sbsec->behavior = SECURITY_FS_USE_NONE;
 			rc = 0;
@@ -3132,12 +3208,13 @@ int security_sid_mls_copy(struct selinux_state *state,
 	u32 len;
 	int rc;
 
-	rc = 0;
 	if (!selinux_initialized(state)) {
 		*new_sid = sid;
-		goto out;
+		return 0;
 	}
 
+retry:
+	rc = 0;
 	context_init(&newcon);
 
 	rcu_read_lock();
@@ -3196,10 +3273,14 @@ int security_sid_mls_copy(struct selinux_state *state,
 		}
 	}
 	rc = sidtab_context_to_sid(sidtab, &newcon, new_sid);
+	if (rc == -ESTALE) {
+		rcu_read_unlock();
+		context_destroy(&newcon);
+		goto retry;
+	}
 out_unlock:
 	rcu_read_unlock();
 	context_destroy(&newcon);
-out:
 	return rc;
 }
 
@@ -3792,6 +3873,8 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 		return 0;
 	}
 
+retry:
+	rc = 0;
 	rcu_read_lock();
 	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
@@ -3818,23 +3901,24 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 				goto out;
 		}
 		rc = -EIDRM;
-		if (!mls_context_isvalid(policydb, &ctx_new))
-			goto out_free;
+		if (!mls_context_isvalid(policydb, &ctx_new)) {
+			ebitmap_destroy(&ctx_new.range.level[0].cat);
+			goto out;
+		}
 
 		rc = sidtab_context_to_sid(sidtab, &ctx_new, sid);
+		ebitmap_destroy(&ctx_new.range.level[0].cat);
+		if (rc == -ESTALE) {
+			rcu_read_unlock();
+			goto retry;
+		}
 		if (rc)
-			goto out_free;
+			goto out;
 
 		security_netlbl_cache_add(secattr, *sid);
-
-		ebitmap_destroy(&ctx_new.range.level[0].cat);
 	} else
 		*sid = SECSID_NULL;
 
-	rcu_read_unlock();
-	return 0;
-out_free:
-	ebitmap_destroy(&ctx_new.range.level[0].cat);
 out:
 	rcu_read_unlock();
 	return rc;
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index 5ee190bd30f5..656d50b09f76 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -39,6 +39,7 @@ int sidtab_init(struct sidtab *s)
 	for (i = 0; i < SECINITSID_NUM; i++)
 		s->isids[i].set = 0;
 
+	s->frozen = false;
 	s->count = 0;
 	s->convert = NULL;
 	hash_init(s->context_to_sid);
@@ -281,6 +282,15 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context,
 	if (*sid)
 		goto out_unlock;
 
+	if (unlikely(s->frozen)) {
+		/*
+		 * This sidtab is now frozen - tell the caller to abort and
+		 * get the new one.
+		 */
+		rc = -ESTALE;
+		goto out_unlock;
+	}
+
 	count = s->count;
 	convert = s->convert;
 
@@ -474,6 +484,17 @@ void sidtab_cancel_convert(struct sidtab *s)
 	spin_unlock_irqrestore(&s->lock, flags);
 }
 
+void sidtab_freeze_begin(struct sidtab *s, unsigned long *flags) __acquires(&s->lock)
+{
+	spin_lock_irqsave(&s->lock, *flags);
+	s->frozen = true;
+	s->convert = NULL;
+}
+void sidtab_freeze_end(struct sidtab *s, unsigned long *flags) __releases(&s->lock)
+{
+	spin_unlock_irqrestore(&s->lock, *flags);
+}
+
 static void sidtab_destroy_entry(struct sidtab_entry *entry)
 {
 	context_destroy(&entry->context);
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index 80c744d07ad6..4eff0e49dcb2 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -86,6 +86,7 @@ struct sidtab {
 	u32 count;
 	/* access only under spinlock */
 	struct sidtab_convert_params *convert;
+	bool frozen;
 	spinlock_t lock;
 
 #if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
@@ -125,6 +126,9 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params);
 
 void sidtab_cancel_convert(struct sidtab *s);
 
+void sidtab_freeze_begin(struct sidtab *s, unsigned long *flags) __acquires(&s->lock);
+void sidtab_freeze_end(struct sidtab *s, unsigned long *flags) __releases(&s->lock);
+
 int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid);
 
 void sidtab_destroy(struct sidtab *s);
-- 
2.30.2

