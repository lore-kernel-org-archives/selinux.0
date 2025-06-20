Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD1E2EBB98;
	Fri, 20 Jun 2025 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441533; cv=none; b=GHadKRbXOn3HWCxG0+QdogOXNQkHZlhzAh5T2UzB1oVa7xLQmNtBEPUPzraavhfgF0szHxKaVz7BTqqBnd5Jj9HRP3RyJ/kCXsis3MON+Vua/14JK4T64ICBQBz0CV0P/ObaTO7sQR7yS4yPAU+kUsWtQOse5V5VtopYeGBAG68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441533; c=relaxed/simple;
	bh=hZK/nrtlRZSE7pFmINJSCMACHwWwJ22vmgQemVoJ4Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZokM9eX7H00hbm5EBBkR+XeBhuSeYH9uUNy/TkyQ0X03cMbkv1sj4n3ZO7Xi24uzzwVZ87NYFHyyRseX7JwyLXvffjjuuj6rMrkG/QCqmHK7RxaHg9tkLfsoP6+KBmvqR2U0nAw3SagjUgZ7CWl05ouMJ0q6CJWhAcHiV+tYeNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lzsj9CRR; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lzsj9CRR"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ecf99dd567so26007356d6.0;
        Fri, 20 Jun 2025 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441530; x=1751046330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqVRWOwDQDJS0a9J5qkomYpO71m1tdUB9Knh5/w/5Go=;
        b=Lzsj9CRRXqvqGvBWdEAAFAKzjLjDSAXiTXZCYObbEndQSkxk7EWmY+AU713paq3LeY
         y4NzefT/SWtYOLTgskkEqvQIsTpt8MAA6cBoWE/kFVN/9uJw8NjZfFEH7pnnaYiYJX0N
         /JGhEAV3BN8JvlHUhxKEbQivDNLM7aijWd2JZjHJAlQL4Zelg3zByL7wNeleipGGKsRN
         53lPFF9sbPJuI6UiuG001OVpu9lQBBC1bOvy5YVrtfvwxZPJAb11+uNMmvdM9PhlCmAw
         h6FPnpjCHH2BvzRtZQjr1bzStXlVc4E23rMLPyOTLUe8nDnKtcPM5IhR5G3lxrwuudcz
         Ru6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441530; x=1751046330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqVRWOwDQDJS0a9J5qkomYpO71m1tdUB9Knh5/w/5Go=;
        b=dxGiPMbUdsxxJ7MCa9OdsSAt2k+AH5sNkXlfaDU+5PYeeYHsmFIbPBcloI8puifINF
         7FSHM3bpGwzX9nqht7di9tS5JduxaA9nVpKH1Hdb3tzLZhQiV4EgwCG3E+xr/N1/+QQq
         njY97Apc53ZfHVcGGIQF/d9P9Drpf8AI3QeWqr/Ee3n2SfIaoDFcr8rpIpRaDP1EiCXP
         ewFcM+tS8IGUTWYkAWRjXIPYmGsO/kgPosFrVUU1QtWYG97biehGNuSlgSAKF8dWaf2H
         pPTTTlV2rgkhVU2TONhDSyty5C0LjTjnvYsA9UosjlpvP1Hf1rxCm94JuTi+vQjTLlQL
         MP9A==
X-Forwarded-Encrypted: i=1; AJvYcCWn379GhUsdzl22fnf66XfXQiO/AOajhsHVXGxYT5/2QtawmHOH/Xg2sDNMOY/3uaHNIXgv/7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9KXOItjy2prezEu7xRhe6APtkS0cyUHhkvy/p0dlpjrvYLaJ9
	3k1BbIDfF1qgr/d4oG6w4rtmodjnDulmeNFcDc6tlvTfeA2X7GWUjuonVsPLSg==
X-Gm-Gg: ASbGncse0W0QNu52Ey2+bvpKbXHP9LtRLKPoVWKa9/LQmdMDQICGJLd5F3bYdCQSijJ
	eN4jCHQ/2Zn/CALRFm1E0UzpifTmRIoW/IsfZFxXARpDzE+fKqvOf5sDtbd3B86przlcxhZKX5a
	fmmW9b2kUAcPziObSzWQv5upcgrxORWNK8laEEz6Y7jzgnBu79iDzDArMA9MfaKcWSXGLe/PAk/
	C1jpM0GsmW/wiiOzMSvM+wz0Fy57h4gIZasCkXtgBAR2eoE+WcK6yXUtOyyhE4/vwN4J2aSpwZ8
	A2bLT0zaErlIcr6n1fuZ0kGN0RqiuP5Cl4VJFmaecONFBwuvH6euysmu3NRdBggQdmHqK0cKko0
	zDOmrF8bZKNGIcjsocek4WK/d9VLzAV/jg9EFLODOX1DTEYtp0XMCl2xbUJpCrW3yWlKKqeWets
	c+
X-Google-Smtp-Source: AGHT+IFoKr7QFIgL+FVl7lqXtYYd+RxDRzCUirAobQ7eiygQypshJhlwwh43UOT/8QQIqeTTc/MyAQ==
X-Received: by 2002:a05:6214:d64:b0:6fb:f00:48ad with SMTP id 6a1803df08f44-6fd0a4d88acmr71622256d6.18.1750441530422;
        Fri, 20 Jun 2025 10:45:30 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:29 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 13/42] selinux: refactor selinux_state_create()
Date: Fri, 20 Jun 2025 13:44:25 -0400
Message-ID: <20250620174502.1838-14-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor selinux_state_create() to be more like create_user_ns()
after which it was originally modeled. In particular, pass in
a single cred argument and update the cred SELinux blob with
the new state. This makes the reference counting situation
clearer with regard to the old state / parent reference and
simplifies the callers.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            | 79 ++++++++++++++++++++---------
 security/selinux/include/security.h |  3 +-
 security/selinux/selinuxfs.c        | 10 +---
 3 files changed, 57 insertions(+), 35 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2d08c0bd4eba..e091b1c12189 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -203,22 +203,6 @@ static int selinux_lsm_notifier_avc_callback(u32 event)
 	return 0;
 }
 
-struct selinux_state *init_selinux_state;
-
-/*
- * initialise the security for the init task
- */
-static void cred_init_security(void)
-{
-	struct task_security_struct *tsec;
-
-	/* NOTE: the lsm framework zeros out the buffer on allocation */
-
-	tsec = selinux_cred(unrcu_pointer(current->real_cred));
-	tsec->osid = tsec->sid = tsec->avdcache.sid = SECINITSID_KERNEL;
-	tsec->state = get_selinux_state(init_selinux_state);
-}
-
 /*
  * get the security ID of a set of credentials
  */
@@ -7793,9 +7777,10 @@ unsigned int selinux_maxnsdepth = CONFIG_SECURITY_SELINUX_MAXNSDEPTH;
 
 static atomic_t selinux_nsnum = ATOMIC_INIT(0);
 
-int selinux_state_create(struct selinux_state *parent,
-			 struct selinux_state **state)
+int selinux_state_create(const struct cred *cred)
 {
+	struct task_security_struct *tsec = selinux_cred(cred);
+	struct selinux_state *parent = tsec->state;
 	struct selinux_state *newstate;
 	int rc;
 
@@ -7820,13 +7805,40 @@ int selinux_state_create(struct selinux_state *parent,
 		goto err;
 
 	if (parent) {
-		newstate->parent = get_selinux_state(parent);
+		/*
+		 * The reference to the new state replaces the reference
+		 * to the old state (parent) in the cred security blob;
+		 * hence, we do not need to use get_selinux_state() below
+		 * to increment the parent reference count.
+		 */
+		newstate->parent = parent;
 		newstate->depth = parent->depth + 1;
 	}
 
 	atomic_inc(&selinux_nsnum);
 
-	*state = newstate;
+	/*
+	 * Set the new namespace.
+	 * The reference count was initialized to 1 and
+	 * this is that reference.
+	 */
+	tsec->state = newstate;
+
+	/* Reset the SIDs for the new namespace. */
+	if (parent)
+		tsec->osid = tsec->sid = tsec->avdcache.sid = SECINITSID_INIT;
+	tsec->exec_sid = tsec->create_sid = tsec->keycreate_sid =
+		tsec->sockcreate_sid = SECSID_NULL;
+
+	/*
+	 * Save the credential in the parent namespace
+	 * for later use in checks in that namespace.
+	 */
+	if (parent) {
+		put_cred(tsec->parent_cred);
+		tsec->parent_cred = get_current_cred();
+	}
+
 	return 0;
 err:
 	kfree(newstate);
@@ -7855,16 +7867,35 @@ void __put_selinux_state(struct selinux_state *state)
 	schedule_work(&state->work);
 }
 
+struct selinux_state *init_selinux_state;
+
 static __init int selinux_init(void)
 {
+	const struct cred *cred = unrcu_pointer(current->real_cred);
+	struct task_security_struct *tsec = selinux_cred(cred);
+
 	pr_info("SELinux:  Initializing.\n");
 
-	if (selinux_state_create(NULL, &init_selinux_state))
+	/*
+	 * Initialize the first cred with the kernel SID and
+	 * NULL state since selinux_state_create() expects
+	 * these two fields to be set. The rest is handled by
+	 * selinux_state_create(), which will update the state
+	 * field to refer to the new state and set the parent
+	 * pointer to the old state value (NULL).
+	 */
+	tsec->osid = tsec->sid = tsec->avdcache.sid = SECINITSID_KERNEL;
+	tsec->state = NULL;
+	if (selinux_state_create(cred))
 		panic("SELinux: Could not create initial namespace\n");
-	enforcing_set(init_selinux_state, selinux_enforcing_boot);
 
-	/* Set the security state for the initial task. */
-	cred_init_security();
+	/*
+	 * Save a reference to the initial SELinux namespace
+	 * for use in various other functions.
+	 */
+	init_selinux_state = get_selinux_state(tsec->state);
+
+	enforcing_set(init_selinux_state, selinux_enforcing_boot);
 
 	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
 	if (!default_noexec)
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 176db64d8afe..4aa06d4dba54 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -117,8 +117,7 @@ struct selinux_state {
 extern struct selinux_state *init_selinux_state;
 
 extern unsigned int selinux_maxns, selinux_maxnsdepth;
-int selinux_state_create(struct selinux_state *parent,
-			 struct selinux_state **state);
+int selinux_state_create(const struct cred *cred);
 void __put_selinux_state(struct selinux_state *state);
 
 void selinux_policy_free(struct selinux_policy *policy);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 1ff044d17805..0508ad18eb73 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -325,8 +325,6 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 
 {
-	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
-	struct selinux_state *state = fsi->state;
 	char *page;
 	ssize_t length;
 	bool set;
@@ -355,22 +353,16 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 
 	if (set) {
 		struct cred *cred = prepare_creds();
-		struct task_security_struct *tsec;
 
 		if (!cred) {
 			length = -ENOMEM;
 			goto out;
 		}
-		tsec = selinux_cred(cred);
-		if (selinux_state_create(state, &tsec->state)) {
+		if (selinux_state_create(cred)) {
 			abort_creds(cred);
 			length = -ENOMEM;
 			goto out;
 		}
-		tsec->osid = tsec->sid = SECINITSID_INIT;
-		tsec->exec_sid = tsec->create_sid = tsec->keycreate_sid =
-			tsec->sockcreate_sid = SECSID_NULL;
-		tsec->parent_cred = get_current_cred();
 		commit_creds(cred);
 	}
 
-- 
2.49.0

