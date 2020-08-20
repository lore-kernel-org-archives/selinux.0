Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33341C433DF
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 14:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2F920674
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 14:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgQdOqQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgHTOTB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgHTOS7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 10:18:59 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5AAC061385
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 07:18:59 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id o2so959085qvk.6
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tsv3JsMdMVwTmAYENVa0Vwaj4+Ag/ng6r2TXbvfybuA=;
        b=JgQdOqQslG91BJK1Grc7xwEmMRWSmAGamznXa8U/w4vPSL2cOGU8V0cwCBGSx22f+E
         uyWjEXTGSEPaXKou2LDIDsAsn4p/RtbdkNguvBmIVxc2mFlf5oXpDXue/auwdc5WI2WH
         TFeiDjWFN1HSA5GIRJ/+ckGW8l6ZyoMUs0svvy0dACosEO4TRO3Bk8/zJ4mRiUGGq8R/
         mL6fyZzVRqgYI5Df8/Vv2zmqFCO3qmLh7SkdsEgRRTSEIkmXD3n0xjSEjs2vSZUlwHWZ
         B15LqWeuwkfS9HhQp7gWr+yMIxkcBsRyZTrS+LJ4a60AUebpVdYgdoMU7LFgZZDfyxdj
         ce7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tsv3JsMdMVwTmAYENVa0Vwaj4+Ag/ng6r2TXbvfybuA=;
        b=WvAyvgSGrucQXXdceaSo8sRBqJNLN2rFTJNUZe2lUNfJOmvkNU2GELf0U+/ZfO0yPw
         EtDnM/kd6GaLq33mwefZwemqyMjsdA19FLUlarPLTbN+yZvBtDIH1nyu43MAvz1AppPW
         9Gd6MuQMx7imDYIC/lxiBcisK/JyrGeFksJAR8tDMDTEGNB0KQwSowYhMjS5MpXWCphz
         Zar7gGXYyNcxclPdHtIQiWXz/aD6QU1qGoPrtewxdmD9kdmw8ZWycxF7Zl/bapsWKIPY
         oDcWVQcr1SJoNmqmUgipKqJCL42Gs/b0Y0kRHxvrcNf3WLikTpzREc1X7WRUyenu/0V7
         fMxw==
X-Gm-Message-State: AOAM532PeI/MgJnqq5laiDMfU400i7yJQ0YOMz8jEFSkiIHuTwuz7HgB
        KQk8U4rxEPefnvsfGPoZQ6A=
X-Google-Smtp-Source: ABdhPJzxc4Rc2CJkUuZYs02UM3oh59bd3GvlWqu9D7cmg/Ors5iFIviXN0fRzmcaV2s9Q8X2j8Jkkw==
X-Received: by 2002:a0c:8b51:: with SMTP id d17mr3173504qvc.107.1597933138821;
        Thu, 20 Aug 2020 07:18:58 -0700 (PDT)
Received: from puritycontrol.fios-router.home (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id a6sm2487863qka.5.2020.08.20.07.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 07:18:58 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     paul@paul-moore.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        peter.enderborg@sony.com, paulmck@kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH] selinux: enable proper lockdep checking for policy rcu access
Date:   Thu, 20 Aug 2020 10:18:50 -0400
Message-Id: <20200820141850.60244-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In the previous change to convert the policy rwlock to RCU,
the update code was using rcu_dereference_check(..., 1) with
a comment to explain why it was safe without taking rcu_read_lock()
since the mutex used to provide exclusion was taken at a higher
level in selinuxfs.  This change passes the mutex down to the
necessary functions and replaces rcu_dereference_check(..., 1)
with rcu_dereference_protected(..., lockdep_is_held(mutex)) so
that lockdep checking is correctly applied and the dependency
is made explicit in the code rather than relying on comments.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
This is relative to the convert policy read-write lock to RCU patch,
https://patchwork.kernel.org/patch/11724997/.

 security/selinux/include/conditional.h |  3 +-
 security/selinux/include/security.h    |  6 ++--
 security/selinux/selinuxfs.c           | 12 ++++---
 security/selinux/ss/services.c         | 45 ++++++++------------------
 4 files changed, 26 insertions(+), 40 deletions(-)

diff --git a/security/selinux/include/conditional.h b/security/selinux/include/conditional.h
index b09343346e3f..4659193dc49d 100644
--- a/security/selinux/include/conditional.h
+++ b/security/selinux/include/conditional.h
@@ -16,7 +16,8 @@
 int security_get_bools(struct selinux_policy *policy,
 		       u32 *len, char ***names, int **values);
 
-int security_set_bools(struct selinux_state *state, u32 len, int *values);
+int security_set_bools(struct selinux_state *state, struct mutex *mutex,
+		u32 len, int *values);
 
 int security_get_bool_value(struct selinux_state *state, u32 index);
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 505e51264d51..87eac1f2e6ed 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -209,12 +209,12 @@ static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
 }
 
 int security_mls_enabled(struct selinux_state *state);
-int security_load_policy(struct selinux_state *state,
+int security_load_policy(struct selinux_state *state, struct mutex *mutex,
 			void *data, size_t len,
 			struct selinux_policy **newpolicyp);
-void selinux_policy_commit(struct selinux_state *state,
+void selinux_policy_commit(struct selinux_state *state, struct mutex *mutex,
 			struct selinux_policy *newpolicy);
-void selinux_policy_cancel(struct selinux_state *state,
+void selinux_policy_cancel(struct selinux_state *state, struct mutex *mutex,
 			struct selinux_policy *policy);
 int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 131816878e50..a054683359dd 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -560,7 +560,8 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (copy_from_user(data, buf, count) != 0)
 		goto out;
 
-	length = security_load_policy(fsi->state, data, count, &newpolicy);
+	length = security_load_policy(fsi->state, &fsi->mutex, data, count,
+				&newpolicy);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to load policy\n");
 		goto out;
@@ -568,11 +569,11 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 
 	length = sel_make_policy_nodes(fsi, newpolicy);
 	if (length) {
-		selinux_policy_cancel(fsi->state, newpolicy);
+		selinux_policy_cancel(fsi->state, &fsi->mutex, newpolicy);
 		goto out1;
 	}
 
-	selinux_policy_commit(fsi->state, newpolicy);
+	selinux_policy_commit(fsi->state, &fsi->mutex, newpolicy);
 
 	length = count;
 
@@ -1309,8 +1310,9 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 
 	length = 0;
 	if (new_value && fsi->bool_pending_values)
-		length = security_set_bools(fsi->state, fsi->bool_num,
-					    fsi->bool_pending_values);
+		length = security_set_bools(fsi->state, &fsi->mutex,
+					fsi->bool_num,
+					fsi->bool_pending_values);
 
 	if (!length)
 		length = count;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 838161462756..a9fff3592768 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2159,17 +2159,13 @@ static void selinux_policy_cond_free(struct selinux_policy *policy)
 }
 
 void selinux_policy_cancel(struct selinux_state *state,
+			struct mutex *mutex,
 			struct selinux_policy *policy)
 {
 	struct selinux_policy *oldpolicy;
 
-	/*
-	 * NOTE: We do not need to take the rcu read lock
-	 * around the code below because other policy-modifying
-	 * operations are already excluded by selinuxfs via
-	 * fsi->mutex.
-	 */
-	oldpolicy = rcu_dereference_check(state->policy, 1);
+	oldpolicy = rcu_dereference_protected(state->policy,
+					lockdep_is_held(mutex));
 
 	sidtab_cancel_convert(oldpolicy->sidtab);
 	selinux_policy_free(policy);
@@ -2187,18 +2183,14 @@ static void selinux_notify_policy_change(struct selinux_state *state,
 }
 
 void selinux_policy_commit(struct selinux_state *state,
+			struct mutex *mutex,
 			struct selinux_policy *newpolicy)
 {
 	struct selinux_policy *oldpolicy;
 	u32 seqno;
 
-	/*
-	 * NOTE: We do not need to take the rcu read lock
-	 * around the code below because other policy-modifying
-	 * operations are already excluded by selinuxfs via
-	 * fsi->mutex.
-	 */
-	oldpolicy = rcu_dereference_check(state->policy, 1);
+	oldpolicy = rcu_dereference_protected(state->policy,
+					lockdep_is_held(mutex));
 
 	/* If switching between different policy types, log MLS status */
 	if (oldpolicy) {
@@ -2249,7 +2241,8 @@ void selinux_policy_commit(struct selinux_state *state,
  * This function will flush the access vector cache after
  * loading the new policy.
  */
-int security_load_policy(struct selinux_state *state, void *data, size_t len,
+int security_load_policy(struct selinux_state *state, struct mutex *mutex,
+			void *data, size_t len,
 			struct selinux_policy **newpolicyp)
 {
 	struct selinux_policy *newpolicy, *oldpolicy;
@@ -2289,13 +2282,8 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 		return 0;
 	}
 
-	/*
-	 * NOTE: We do not need to take the rcu read lock
-	 * around the code below because other policy-modifying
-	 * operations are already excluded by selinuxfs via
-	 * fsi->mutex.
-	 */
-	oldpolicy = rcu_dereference_check(state->policy, 1);
+	oldpolicy = rcu_dereference_protected(state->policy,
+					lockdep_is_held(mutex));
 
 	/* Preserve active boolean values from the old policy */
 	rc = security_preserve_bools(oldpolicy, newpolicy);
@@ -2992,7 +2980,8 @@ int security_get_bools(struct selinux_policy *policy,
 }
 
 
-int security_set_bools(struct selinux_state *state, u32 len, int *values)
+int security_set_bools(struct selinux_state *state, struct mutex *mutex,
+		u32 len, int *values)
 {
 	struct selinux_policy *newpolicy, *oldpolicy;
 	int rc;
@@ -3001,14 +2990,8 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 	if (!selinux_initialized(state))
 		return -EINVAL;
 
-	/*
-	 * NOTE: We do not need to take the rcu read lock
-	 * around the code below because other policy-modifying
-	 * operations are already excluded by selinuxfs via
-	 * fsi->mutex.
-	 */
-
-	oldpolicy = rcu_dereference_check(state->policy, 1);
+	oldpolicy = rcu_dereference_protected(state->policy,
+					lockdep_is_held(mutex));
 
 	/* Consistency check on number of booleans, should never fail */
 	if (WARN_ON(len != oldpolicy->policydb.p_bools.nprim))
-- 
2.25.1

