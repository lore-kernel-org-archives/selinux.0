Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135C2C433ED
	for <selinux@archiver.kernel.org>; Mon,  5 Apr 2021 09:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0511613A1
	for <selinux@archiver.kernel.org>; Mon,  5 Apr 2021 09:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbhDEJLs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Apr 2021 05:11:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238640AbhDEJLK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Apr 2021 05:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617613861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zUFofgZgjJ7IvzGbCeDi/ckITehwCYwVgZvtaLmWAGY=;
        b=GkcITTafIkg76ZgAxuS/wDgYbsz5adU2nG7SEgekowKvd3QD3cxNXFaFISeVbAWw/3khQG
        b9Pg1UeH5D0W61ox6aAdn3ybqqXKSFe+h3yRzuW3URYkWCMhdq0DFK7RskRMraYKs6T9vB
        T+1Qcl8v+3FfU1CPSWxuIODNj58dY20=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-7fa2ORCjM7iOmsT-ZmFcSw-1; Mon, 05 Apr 2021 05:10:58 -0400
X-MC-Unique: 7fa2ORCjM7iOmsT-ZmFcSw-1
Received: by mail-ed1-f69.google.com with SMTP id i6so8467876edq.12
        for <selinux@vger.kernel.org>; Mon, 05 Apr 2021 02:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zUFofgZgjJ7IvzGbCeDi/ckITehwCYwVgZvtaLmWAGY=;
        b=lJmlXH7+082a2lGTKr8HcGUJhFNO8rZHlNEEnosDlqds/bfD1++0qPCYFvxG686FVJ
         qqGVSvdxaNOZ/84TodBaX2kuBYfF/bYdA0AOa+5GwK1wAkUOVr6r7zsJOrDZSo9rQoPW
         ccDLUYdlTHEGBbD9nsmU9+QshgvimKH7t/B38vZ39bqmGbnI5r7QX3+u6VeV50pUunZN
         HkY3/jNLEIGJldqILF5CIFVxeQSVrlr4cC2jbUQZqIFbyNfK+pnaYjjtyiOnRXS8w83N
         NROVnpliCv5L/qjH6HP5aIoh2FIoXw4JCYtsDQWofidmDbfcqQ53qcMYsVcVKBaFRiI2
         Jxkg==
X-Gm-Message-State: AOAM533w4yS7b4fwCEiJHbesHDDSbT2yhFtb5rXWOsQ6ziWNc1xfHj4B
        xCosCp2/FeH4iLCoNPvSMhnVb6ts5e6naflf2IzEUb26B8F+tCmQ/3spKWwx8hsFy7M9JhBchyi
        X5e3xHskJP9isEUerp6tyTIP/9YeLBsZhJuX9g/cu5Tx51bQ0xXMFBLQ9OlsCPJ4Yx6yKJw==
X-Received: by 2002:a17:907:1b19:: with SMTP id mp25mr4797930ejc.154.1617613857090;
        Mon, 05 Apr 2021 02:10:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgxbV4+Jrj85DZ+BZPAYZ0u0GG3B5ZqXydNE0MpWj2+xF2mpgUuCbBU1JnIko6ytd8Lx6U5w==
X-Received: by 2002:a17:907:1b19:: with SMTP id mp25mr4797911ejc.154.1617613856813;
        Mon, 05 Apr 2021 02:10:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id k12sm10409440edo.50.2021.04.05.02.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 02:10:56 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: fix race between old and new sidtab
Date:   Mon,  5 Apr 2021 11:10:52 +0200
Message-Id: <20210405091052.2296792-1-omosnace@redhat.com>
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
 security/selinux/ss/services.c | 145 ++++++++++++++++++++++++++-------
 security/selinux/ss/sidtab.c   |  21 +++++
 security/selinux/ss/sidtab.h   |   4 +
 3 files changed, 139 insertions(+), 31 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 08ac1d01c743..50abcfcdf242 100644
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
@@ -1736,6 +1746,7 @@ static int security_compute_sid(struct selinux_state *state,
 		goto out;
 	}
 
+retry:
 	context_init(&newcontext);
 
 	rcu_read_lock();
@@ -1880,6 +1891,11 @@ static int security_compute_sid(struct selinux_state *state,
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
@@ -2192,6 +2208,7 @@ void selinux_policy_commit(struct selinux_state *state,
 			   struct selinux_load_state *load_state)
 {
 	struct selinux_policy *oldpolicy, *newpolicy = load_state->policy;
+	unsigned long flags;
 	u32 seqno;
 
 	oldpolicy = rcu_dereference_protected(state->policy,
@@ -2213,7 +2230,13 @@ void selinux_policy_commit(struct selinux_state *state,
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
@@ -2357,13 +2380,15 @@ int security_port_sid(struct selinux_state *state,
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
@@ -2382,6 +2407,10 @@ int security_port_sid(struct selinux_state *state,
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
@@ -2408,13 +2437,15 @@ int security_ib_pkey_sid(struct selinux_state *state,
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
@@ -2435,6 +2466,10 @@ int security_ib_pkey_sid(struct selinux_state *state,
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
@@ -2460,13 +2495,15 @@ int security_ib_endport_sid(struct selinux_state *state,
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
@@ -2487,6 +2524,10 @@ int security_ib_endport_sid(struct selinux_state *state,
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
@@ -2510,7 +2551,7 @@ int security_netif_sid(struct selinux_state *state,
 	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
-	int rc = 0;
+	int rc;
 	struct ocontext *c;
 
 	if (!selinux_initialized(state)) {
@@ -2518,6 +2559,8 @@ int security_netif_sid(struct selinux_state *state,
 		return 0;
 	}
 
+retry:
+	rc = 0;
 	rcu_read_lock();
 	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
@@ -2534,10 +2577,18 @@ int security_netif_sid(struct selinux_state *state,
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
@@ -2587,6 +2638,7 @@ int security_node_sid(struct selinux_state *state,
 		return 0;
 	}
 
+retry:
 	rcu_read_lock();
 	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
@@ -2635,6 +2687,10 @@ int security_node_sid(struct selinux_state *state,
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
@@ -2676,18 +2732,20 @@ int security_get_user_sids(struct selinux_state *state,
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
@@ -2723,6 +2781,10 @@ int security_get_user_sids(struct selinux_state *state,
 				continue;
 
 			rc = sidtab_context_to_sid(sidtab, &usercon, &sid);
+			if (rc == -ESTALE) {
+				rcu_read_unlock();
+				goto retry;
+			}
 			if (rc)
 				goto out_unlock;
 			if (mynel < maxnel) {
@@ -2745,14 +2807,14 @@ out_unlock:
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
@@ -2765,12 +2827,10 @@ out_unlock:
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
@@ -2783,6 +2843,9 @@ out:
  * Obtain a SID to use for a file in a filesystem that
  * cannot support xattr or use a fixed labeling behavior like
  * transition SIDs or task SIDs.
+ *
+ * WARNING: This function may return -ESTALE, indicating that the caller
+ * must retry the operation after re-acquiring the policy pointer!
  */
 static inline int __security_genfs_sid(struct selinux_policy *policy,
 				       const char *fstype,
@@ -2861,11 +2924,13 @@ int security_genfs_sid(struct selinux_state *state,
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
 
@@ -2888,7 +2953,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
-	int rc = 0;
+	int rc;
 	struct ocontext *c;
 	struct superblock_security_struct *sbsec = sb->s_security;
 	const char *fstype = sb->s_type->name;
@@ -2899,6 +2964,8 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 		return 0;
 	}
 
+retry:
+	rc = 0;
 	rcu_read_lock();
 	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
@@ -2916,6 +2983,10 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
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
@@ -2923,6 +2994,10 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
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
@@ -3132,12 +3207,13 @@ int security_sid_mls_copy(struct selinux_state *state,
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
@@ -3196,10 +3272,14 @@ int security_sid_mls_copy(struct selinux_state *state,
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
 
@@ -3792,6 +3872,8 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 		return 0;
 	}
 
+retry:
+	rc = 0;
 	rcu_read_lock();
 	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
@@ -3818,23 +3900,24 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
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

