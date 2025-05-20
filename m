Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C49C27C863;
	Tue, 20 May 2025 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742476; cv=none; b=E1j8L5shbU36cz2PZf7sKtc5EyRH2aiI26FF9UGNOJmBXGDqslZ26qrcL3+vulhak0S5DUuwQaI/p+puLuPcHaZKVQznBLoY1kWK1lI/Av8NrZ0xzXVYgUXCAcARRKZAIHE84J2yVzkOsQCOZKyjGurEnmkF3p1MLuwGqLI9vas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742476; c=relaxed/simple;
	bh=L9UMAtjZ6mzjopLXOr9RQ13KPZZd6nx7uFkvvDfsgKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyLKmF8xsAA6mAqzcVjCbTynRo7V8d16gSE87RB4Mfj6/F3IyzoYe0V31+gQ3PIGU/Xw1mpQ70cHU8GXzcqx265MuxJq2TgUQzwabx8ZeOfuSojQ7h6klNvdqkyUaWoLkqiLKV5UXIYpEiZnejLLEf4gfkXghH816KeEHarcipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGS4GNrF; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGS4GNrF"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5a88b34a6so587395985a.3;
        Tue, 20 May 2025 05:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742473; x=1748347273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcsmu4q/3rxVJbq2f9c7Rgnizz1+Ja2WSGj8j4c8nQw=;
        b=MGS4GNrF37WwMkIbIYYQ4OLmPxGSiQBk//H40KtIa7MnyoCLPsUsVhiBc9xfc3KrVD
         uVHGuo5R/wst64MBOP/F/dGrMp7XyyGf3sAPZ6e7fHoAFG4lcdjf4lkJ+p6Q2mffO9X3
         5xLI8Ienfj+CWRGSPtdIyahRDlP81T4c3Ho6mC057VC6RvMhi1IjLTCy9vMQQQ81ChYN
         gv4C2fe6QnOjOu+Hyj7W9jr0Ugz57wea8Bxi0uGVa7fO4FChRWf/2V3vTl9l8D7FqWbR
         ZU8fPMSnzGlhNumlEHDBtmMvgP7UnhT907Tnp7mHxDfqzzDL/xDQpk7b23KoEMiGfZj8
         QuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742473; x=1748347273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcsmu4q/3rxVJbq2f9c7Rgnizz1+Ja2WSGj8j4c8nQw=;
        b=lB96fWvmLo8O+iu456ftZWWn05PHXGAhH1+QJYfEctg7uGMs/KohqCgpM05a+cpCUW
         vqXnOeJ/uM/rcQ4WeCdYKQWiI4GHTli8w8k71+5K1ODSK2di3fvTgKdDLmLvm5XjzEOd
         fL7wEdeExnlSvCq5qz6Pvzbw5HrHwzpu42fJtyST+3hTnL5E/kFMSTuoHWzFMiZAFKeG
         BCrAeJzYKsjiUzvJOCUG1XJxqnFkVPM4qzuEAfZWjDAnKmfzoDNjiHsUYIph4rMWMXdw
         Ioo0lETF6MVmVkdX1ZOiqLVXAk4g2lKQgmnYSzKlMcQkW2CFa47ghY1HxdyF/6fqNo37
         mP2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8gFJ0b2LVGEMr8lYPvsL6dJCkfLk22IrPUWB/PRuD79/nQBamCq1eGsz9/WCToI+ZjJX4SMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+KO6Wl0Gcb9X+l4agAy7FKJgkq58CTQnlg4Xxs2c4HLm8bnU5
	e5ORIAkTPR28a8LgLBDDMs4mgAHCLP5Xl8ti6eIsKCkPrHc5txQSTozYdQ3uNQ==
X-Gm-Gg: ASbGncv6uBRNaQYUWfhF2B/kb4SmEgCSHMVFI1EG5ucmF/xVVxSPeMtXZZaHjETcSXR
	yYEtGujZVFDQ2L+lXfmsttGMHu0+0pEAJrSAxds1um+CZJxTz1XUBbpFdpttyweauD/FLhJpPP1
	KYpUYFDXSTbm72jkDrrZt20J9N/tqbVCoHoKKHxe8fyvxN8YRh04Q48w+4uV6YiTv0C3Z95/3Ng
	4BTyT85CosEPOlTx529tYUov7imAq3J6pEMTi25cmxLR8SE6vJCtKZ3UXppsuTrXF++pToc29Dz
	HVH4olsOLu8mAFMhRPzLJceM66iftRZVO0b0ReEidtB8KDtLFXO76aiDRVW7ZVzqPRqK16DXFPc
	ujPRM3FAQjQSQhYL07M6rbTtZCzciVQEuXwxZK58LEd5hEqm5+NSU0Q==
X-Google-Smtp-Source: AGHT+IEB74P5CPZXr1e2ExDUV6HKbHRoJDLmFtxVWX1hzrFZV3L/Q9mHevQ2MOHnU7aWnQkXM18dZA==
X-Received: by 2002:a05:620a:318e:b0:7c7:bb3f:fd40 with SMTP id af79cd13be357-7cd47f0f1bcmr2369703785a.5.1747742473197;
        Tue, 20 May 2025 05:01:13 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:12 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 12/42] selinux: refactor selinux_state_create()
Date: Tue, 20 May 2025 07:59:10 -0400
Message-ID: <20250520120000.25501-14-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
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
index b2efe6b1e566..83846fdaa3ad 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -204,22 +204,6 @@ static int selinux_lsm_notifier_avc_callback(u32 event)
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
@@ -7811,9 +7795,10 @@ unsigned int selinux_maxnsdepth = CONFIG_SECURITY_SELINUX_MAXNSDEPTH;
 
 static atomic_t selinux_nsnum = ATOMIC_INIT(0);
 
-int selinux_state_create(struct selinux_state *parent,
-			 struct selinux_state **state)
+int selinux_state_create(const struct cred *cred)
 {
+	struct task_security_struct *tsec = selinux_cred(cred);
+	struct selinux_state *parent = tsec->state;
 	struct selinux_state *newstate;
 	int rc;
 
@@ -7838,13 +7823,40 @@ int selinux_state_create(struct selinux_state *parent,
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
@@ -7873,16 +7885,35 @@ void __put_selinux_state(struct selinux_state *state)
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
index cb1c9095cffd..9802099e2f56 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -116,8 +116,7 @@ struct selinux_state {
 extern struct selinux_state *init_selinux_state;
 
 extern unsigned int selinux_maxns, selinux_maxnsdepth;
-int selinux_state_create(struct selinux_state *parent,
-			 struct selinux_state **state);
+int selinux_state_create(const struct cred *cred);
 void __put_selinux_state(struct selinux_state *state);
 
 void selinux_policy_free(struct selinux_policy __rcu *policy);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index b64730bb6596..c7e74229d2e3 100644
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

