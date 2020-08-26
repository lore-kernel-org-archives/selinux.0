Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABEBC433E3
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 13:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C2E22B47
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 13:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyJapv+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgHZN6K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730058AbgHZN6I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 09:58:08 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3064EC061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 06:58:08 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id y11so732374qvl.4
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yvwflTzq7mzFkLu11uchpCWjDHBunpASMi7eKjutfu4=;
        b=tyJapv+YExHUAECUXNt54mEp4vRQed6TfV5eOSv1Z92ALhSvFGYq7mAtEdOy9yr+h6
         jJmLoVPmAE/OJXC5WOoyBS7cM3SI6lbdvYXnY4w/Y/1/C4ltYvlwPAPUwRswd/1xIjiz
         lBnEwQpUKN0nmBH45o8bw+crBFMaQqa/N8Gx8A86zJ+UCwE6kvmUaJkyESA8zdM3cya8
         inbWkfygeN3AUv/GAfq5gE7ABo1ROyFpz5Z23pTxg56R6HTPF8QCnQ1HEE3uf7rAAgWX
         aaYxdZpaHIb2A4V4s4RSxCz++VuWuQ2k1/RbydZC3VluOHBtpgGOBLzmqthPsv1dRBaT
         PuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yvwflTzq7mzFkLu11uchpCWjDHBunpASMi7eKjutfu4=;
        b=FbEqvJOWm+tKC9corjs8B7cEsyedwcU41m2C758V5/ZYC3xxRmu8c6cdRCnCVJTH1g
         mvHqOt/kpNq5yqKWjFRlH1D78YJe7XIdGc7rP1The3N4LsKGV2WaPvR3Vo/iqZjWfI/0
         HgWOTp/5GiI0e7CVqh3SCZJFslzf0DDSD4abpIQe+I1VQ42hkODVMvqZ8Zx2WyFyh3RC
         1AFnZ+lwAgVGrtTwyvYmZMr5Sr/PXm1QcsPEd6708W75w7MIrLKa3MK+FyVJ0LTCt5Qi
         9AxSyf/tU3cM426LPxwjBb7Ce9vA8e5dH8bsXhBBse+dy8kBG1JXn13DjADktShTZ1rs
         qZyw==
X-Gm-Message-State: AOAM530KckACCgpyF0pgSEJdH+XyZCz1Lu8XquzHrnFN8Lb+GOmfZ/dK
        J81i2hoa2kTrZOabbSXt0rg=
X-Google-Smtp-Source: ABdhPJyoxSnrunBGlJOiR75IH1dL2yg5QwZbPOrTlfEJt3X+O9ltLwA3cGIAig/S7jPkYZDymx/WCg==
X-Received: by 2002:a05:6214:a48:: with SMTP id ee8mr14260282qvb.53.1598450287349;
        Wed, 26 Aug 2020 06:58:07 -0700 (PDT)
Received: from puritycontrol.fios-router.home (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id w44sm2084311qtj.86.2020.08.26.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 06:58:06 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     paul@paul-moore.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        peter.enderborg@sony.com, paulmck@kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: move policy mutex to selinux_state, use in lockdep checks
Date:   Wed, 26 Aug 2020 09:57:59 -0400
Message-Id: <20200826135759.9891-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Move the mutex used to synchronize policy changes (reloads and setting
of booleans) from selinux_fs_info to selinux_state and use it in
lockdep checks for rcu_dereference_protected() calls in the security
server functions.  This makes the dependency on the mutex explicit
in the code rather than relying on comments.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            |  1 +
 security/selinux/include/security.h |  1 +
 security/selinux/selinuxfs.c        | 26 ++++++++++----------
 security/selinux/ss/services.c      | 37 +++++++----------------------
 4 files changed, 22 insertions(+), 43 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6f30ba1a38dc..6210e98219a5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7237,6 +7237,7 @@ static __init int selinux_init(void)
 	selinux_state.checkreqprot = selinux_checkreqprot_boot;
 	selinux_avc_init(&selinux_state.avc);
 	mutex_init(&selinux_state.status_lock);
+	mutex_init(&selinux_state.policy_mutex);
 
 	/* Set the security state for the initial task. */
 	cred_init_security();
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 505e51264d51..bbbf7141ccdb 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -103,6 +103,7 @@ struct selinux_state {
 
 	struct selinux_avc *avc;
 	struct selinux_policy __rcu *policy;
+	struct mutex policy_mutex;
 } __randomize_layout;
 
 void selinux_avc_init(struct selinux_avc **avc);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index d1872adf0c47..c0b9078fdb18 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -75,7 +75,6 @@ struct selinux_fs_info {
 	unsigned long last_class_ino;
 	bool policy_opened;
 	struct dentry *policycap_dir;
-	struct mutex mutex;
 	unsigned long last_ino;
 	struct selinux_state *state;
 	struct super_block *sb;
@@ -89,7 +88,6 @@ static int selinux_fs_info_create(struct super_block *sb)
 	if (!fsi)
 		return -ENOMEM;
 
-	mutex_init(&fsi->mutex);
 	fsi->last_ino = SEL_INO_NEXT - 1;
 	fsi->state = &selinux_state;
 	fsi->sb = sb;
@@ -400,7 +398,7 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 
 	BUG_ON(filp->private_data);
 
-	mutex_lock(&fsi->mutex);
+	mutex_lock(&selinux_state.policy_mutex);
 
 	rc = avc_has_perm(&selinux_state,
 			  current_sid(), SECINITSID_SECURITY,
@@ -431,11 +429,11 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 
 	filp->private_data = plm;
 
-	mutex_unlock(&fsi->mutex);
+	mutex_unlock(&selinux_state.policy_mutex);
 
 	return 0;
 err:
-	mutex_unlock(&fsi->mutex);
+	mutex_unlock(&selinux_state.policy_mutex);
 
 	if (plm)
 		vfree(plm->data);
@@ -622,7 +620,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	ssize_t length;
 	void *data = NULL;
 
-	mutex_lock(&fsi->mutex);
+	mutex_lock(&selinux_state.policy_mutex);
 
 	length = avc_has_perm(&selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
@@ -666,7 +664,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		from_kuid(&init_user_ns, audit_get_loginuid(current)),
 		audit_get_sessionid(current));
 out:
-	mutex_unlock(&fsi->mutex);
+	mutex_unlock(&selinux_state.policy_mutex);
 	vfree(data);
 	return length;
 }
@@ -1271,7 +1269,7 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 	unsigned index = file_inode(filep)->i_ino & SEL_INO_MASK;
 	const char *name = filep->f_path.dentry->d_name.name;
 
-	mutex_lock(&fsi->mutex);
+	mutex_lock(&selinux_state.policy_mutex);
 
 	ret = -EINVAL;
 	if (index >= fsi->bool_num || strcmp(name,
@@ -1290,14 +1288,14 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 	}
 	length = scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
 			  fsi->bool_pending_values[index]);
-	mutex_unlock(&fsi->mutex);
+	mutex_unlock(&selinux_state.policy_mutex);
 	ret = simple_read_from_buffer(buf, count, ppos, page, length);
 out_free:
 	free_page((unsigned long)page);
 	return ret;
 
 out_unlock:
-	mutex_unlock(&fsi->mutex);
+	mutex_unlock(&selinux_state.policy_mutex);
 	goto out_free;
 }
 
@@ -1322,7 +1320,7 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 	if (IS_ERR(page))
 		return PTR_ERR(page);
 
-	mutex_lock(&fsi->mutex);
+	mutex_lock(&selinux_state.policy_mutex);
 
 	length = avc_has_perm(&selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
@@ -1347,7 +1345,7 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 	length = count;
 
 out:
-	mutex_unlock(&fsi->mutex);
+	mutex_unlock(&selinux_state.policy_mutex);
 	kfree(page);
 	return length;
 }
@@ -1378,7 +1376,7 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 	if (IS_ERR(page))
 		return PTR_ERR(page);
 
-	mutex_lock(&fsi->mutex);
+	mutex_lock(&selinux_state.policy_mutex);
 
 	length = avc_has_perm(&selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
@@ -1400,7 +1398,7 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 		length = count;
 
 out:
-	mutex_unlock(&fsi->mutex);
+	mutex_unlock(&selinux_state.policy_mutex);
 	kfree(page);
 	return length;
 }
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 838161462756..c93e72918d00 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2163,13 +2163,8 @@ void selinux_policy_cancel(struct selinux_state *state,
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
+					lockdep_is_held(&state->policy_mutex));
 
 	sidtab_cancel_convert(oldpolicy->sidtab);
 	selinux_policy_free(policy);
@@ -2192,13 +2187,8 @@ void selinux_policy_commit(struct selinux_state *state,
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
+					lockdep_is_held(&state->policy_mutex));
 
 	/* If switching between different policy types, log MLS status */
 	if (oldpolicy) {
@@ -2289,13 +2279,8 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
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
+					lockdep_is_held(&state->policy_mutex));
 
 	/* Preserve active boolean values from the old policy */
 	rc = security_preserve_bools(oldpolicy, newpolicy);
@@ -3001,14 +2986,8 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
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
+					lockdep_is_held(&state->policy_mutex));
 
 	/* Consistency check on number of booleans, should never fail */
 	if (WARN_ON(len != oldpolicy->policydb.p_bools.nprim))
-- 
2.25.1

