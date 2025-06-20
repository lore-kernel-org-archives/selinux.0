Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6D32EA145;
	Fri, 20 Jun 2025 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441524; cv=none; b=txb4Tvd1T3319raszxk0Nop7G/re+BqV8EMYhuJPYsoQZB+r8XsXZ97nfVmhmTCMUfQ4Oc6jzZOAOkF5qYcODnbtjIC/Qzm+X5jcw+DGD/9gdJ6CVmDX57xJFVdWinaUUmtxiLHVxEQMIhQZcZjfo0MEvaLE0ZDTiiMXo1GSUQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441524; c=relaxed/simple;
	bh=zbyqntqR/Jh0R3SIRbyVWrPJ9SlFoccIDnBWIil6OzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=if2+Zz6tOJc0HVpOAEfmX3VLOZtRxVGMozdMgaFTj7GYASgEasnhgHuaxmALWfEkopmN1Yooua9j1xzIUnHD/UmFvuRmKUc4eWgwKZArjrw95RVGPSzymIcV6LDbC9NFSE2y1J8O89P18bFio0lsv3jotGy5Itw9Rz6ae6BDUrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHt+a74+; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHt+a74+"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fad3400ea3so21040076d6.0;
        Fri, 20 Jun 2025 10:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441522; x=1751046322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ob8j06qFXRE1zGm7OglsSv1fuT0guAp4Mm/OuOhVMFs=;
        b=eHt+a74+M8x6n8HjMBmTHaCIPPWvp6R+DH4inFKVg8ymzhx3PQDKL8Ryh9PVqHAtQu
         ndVt7ymWZVA4aiTA2J3pobnE+BXX2mJAOLvvGw3bpPsyI9XgqJMgRFrUm/sC5z1VtpUf
         P83HAk6hkRLncgBLfyUMYjCtyICj6EU6DxIRi6Se1rdCwC7ntB0aCemKLUP4+jammhcD
         3T7QvjsjUCfmJVoJB4OcO58xTVnT2Ky8sQCWJ0TEVjQu/b/lkhgk0Q7VkVDALSIPm3rg
         nIC3xAzq4z9y/UcCkyEYYGL42vF6xfGt+LnKVDPZg4VWwKnStjlsIi+5pc2i8n5Lcqc2
         1lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441522; x=1751046322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ob8j06qFXRE1zGm7OglsSv1fuT0guAp4Mm/OuOhVMFs=;
        b=JCso0bado/CzngSCf6CReSE2uEjIqXjA7koarKqrxEyxS2TMvPfofAT62yBnS8E+sp
         6T84W+8qXoUpGZT3li3N9FSCOfwdU4JaWr1LL7nnqB0HyGXPeFrPC/pix+4BL2gI84Om
         5P04MPjuBrb1Pxwo6bsZj6BuNrXcq/jO/Ps+dF/ZoXlQBvYiOPrKLs/O6uGmX9JvNMIw
         j5wx1d4NauP7cPH7s4sBAWl7tiDzK2/J1cqH/WO26HyaGU0TzOZMXV+JsuY70/p8X4V1
         HHKxOmcJJKVPxJ3zQEfWPWyGsC7HV2/bjkr8JB+AECd/bEs8UTzSF1h/mG0lwFhPWNBW
         CC2w==
X-Forwarded-Encrypted: i=1; AJvYcCWcUePhUABwOznEI1amkC67arsSQ5mwf8gED/uT1gBCPuhXU623ZKeyuWa4nXQetFDE1XL/bG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysz7HiMurrrA23FYoIF9Gf5VrhIVGl+L0N5xyNHhao+SHyxPfz
	LZ7X2ni4WNRATB/uaQHDn5kSPmexB8V9Owo9bdzP1ge1kdZjitUCw+gjHBDBHg==
X-Gm-Gg: ASbGncscGpz5p3MBpGv09j/MFZtE2OxxCkYeq0dwhftP73uc+AdcWI658QWfwkP4YHs
	VqV3f9zrOqVILi0dswjJOJ/eyXiKzF0mhlVD/MlIFfsbmiNSS2Uheie81Sl3NFjGdoz0OrwkMLf
	mvxIkMTQ+e1Cq1ISqgjyOvrMpQTRa7m60apnMPso8hwx4hq7qdQjkVFx9QM1/503cJUMVXjCCQK
	WE11FCq+pl1EHqSQp5oO/OyiPkXjmES3sgmwz15E+r3BYHRrQCvLdm4ZtHOOhj7arGxdLE4neJU
	I//zqh9a9yXGODBIzThKKI7l2OyqABGZul1Hf6i3mETyBFXSOiXasxpfUcyErja/LYkAqTTek48
	dIffotVSNevxTT7fOsk9LQR4qZ8cGW6bP5O1eaxahgxk6vte9vy1zMUQMxE3a+TxJtEElnmME8l
	5Z
X-Google-Smtp-Source: AGHT+IHpvqyXgFuTxb9aKOEBeLy/ika+Hr5y1jR886NoOaAlCLojxyeY0xADbqGpNHivH421n/TOkw==
X-Received: by 2002:a05:6214:124d:b0:6fa:c697:97a5 with SMTP id 6a1803df08f44-6fd0a46f07fmr64735356d6.15.1750441521774;
        Fri, 20 Jun 2025 10:45:21 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:21 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 04/42] selinux: dynamically allocate selinux namespace
Date: Fri, 20 Jun 2025 13:44:16 -0400
Message-ID: <20250620174502.1838-5-stephen.smalley.work@gmail.com>
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

Move from static allocation of a single selinux namespace to
dynamic allocation.  Include necessary support for lifecycle management
of the selinux namespace, modeled after the user namespace support.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c              | 32 ++++++++++----
 security/selinux/hooks.c            | 65 +++++++++++++++++++++++++----
 security/selinux/include/security.h | 27 +++++++++++-
 security/selinux/selinuxfs.c        |  3 +-
 security/selinux/ss/services.c      |  7 +++-
 5 files changed, 115 insertions(+), 19 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 1be359d9758c..8db199f06a2a 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -91,20 +91,34 @@ struct selinux_avc {
 	struct avc_cache avc_cache;
 };
 
-static struct selinux_avc selinux_avc;
-
-void selinux_avc_init(struct selinux_avc **avc)
+int selinux_avc_create(struct selinux_avc **avc)
 {
+	struct selinux_avc *newavc;
 	int i;
 
-	selinux_avc.avc_cache_threshold = AVC_DEF_CACHE_THRESHOLD;
+	newavc = kzalloc(sizeof(*newavc), GFP_KERNEL);
+	if (!newavc)
+		return -ENOMEM;
+
+	newavc->avc_cache_threshold = AVC_DEF_CACHE_THRESHOLD;
+
 	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		INIT_HLIST_HEAD(&selinux_avc.avc_cache.slots[i]);
-		spin_lock_init(&selinux_avc.avc_cache.slots_lock[i]);
+		INIT_HLIST_HEAD(&newavc->avc_cache.slots[i]);
+		spin_lock_init(&newavc->avc_cache.slots_lock[i]);
 	}
-	atomic_set(&selinux_avc.avc_cache.active_nodes, 0);
-	atomic_set(&selinux_avc.avc_cache.lru_hint, 0);
-	*avc = &selinux_avc;
+	atomic_set(&newavc->avc_cache.active_nodes, 0);
+	atomic_set(&newavc->avc_cache.lru_hint, 0);
+
+	*avc = newavc;
+	return 0;
+}
+
+static void avc_flush(struct selinux_avc *avc);
+
+void selinux_avc_free(struct selinux_avc *avc)
+{
+	avc_flush(avc);
+	kfree(avc);
 }
 
 unsigned int avc_get_cache_threshold(struct selinux_avc *avc)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c6da35bef827..97cc7ae8943d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -107,7 +107,7 @@
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
-static struct selinux_state init_selinux_state;
+static struct selinux_state *init_selinux_state;
 struct selinux_state *current_selinux_state;
 
 /* SECMARK reference count */
@@ -7735,16 +7735,67 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 #endif
 };
 
+static void selinux_state_free(struct work_struct *work);
+
+int selinux_state_create(struct selinux_state *parent,
+			 struct selinux_state **state)
+{
+	struct selinux_state *newstate;
+	int rc;
+
+	newstate = kzalloc(sizeof(*newstate), GFP_KERNEL);
+	if (!newstate)
+		return -ENOMEM;
+
+	refcount_set(&newstate->count, 1);
+	INIT_WORK(&newstate->work, selinux_state_free);
+
+	mutex_init(&newstate->status_lock);
+	mutex_init(&newstate->policy_mutex);
+
+	rc = selinux_avc_create(&newstate->avc);
+	if (rc)
+		goto err;
+
+	if (parent)
+		newstate->parent = get_selinux_state(parent);
+
+	*state = newstate;
+	return 0;
+err:
+	kfree(newstate);
+	return rc;
+}
+
+static void selinux_state_free(struct work_struct *work)
+{
+	struct selinux_state *parent, *state =
+		container_of(work, struct selinux_state, work);
+
+	do {
+		parent = state->parent;
+		if (state->status_page)
+			__free_page(state->status_page);
+		selinux_policy_free_rcu(state->policy);
+		selinux_avc_free(state->avc);
+		kfree(state);
+		state = parent;
+	} while (state && refcount_dec_and_test(&state->count));
+}
+
+void __put_selinux_state(struct selinux_state *state)
+{
+	schedule_work(&state->work);
+}
+
 static __init int selinux_init(void)
 {
 	pr_info("SELinux:  Initializing.\n");
 
-	memset(&init_selinux_state, 0, sizeof(init_selinux_state));
-	enforcing_set(&init_selinux_state, selinux_enforcing_boot);
-	selinux_avc_init(&init_selinux_state.avc);
-	mutex_init(&init_selinux_state.status_lock);
-	mutex_init(&init_selinux_state.policy_mutex);
-	current_selinux_state = &init_selinux_state;
+	if (selinux_state_create(NULL, &init_selinux_state))
+		panic("SELinux: Could not create initial namespace\n");
+	enforcing_set(init_selinux_state, selinux_enforcing_boot);
+	current_selinux_state = init_selinux_state;
 
 	/* Set the security state for the initial task. */
 	cred_init_security();
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index f81516731f98..fbfe486c91c9 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -105,9 +105,34 @@ struct selinux_state {
 	struct selinux_avc *avc;
 	struct selinux_policy __rcu *policy;
 	struct mutex policy_mutex;
+	struct selinux_state *parent;
+
+	refcount_t count;
+	struct work_struct work;
 } __randomize_layout;
 
-void selinux_avc_init(struct selinux_avc **avc);
+int selinux_state_create(struct selinux_state *parent,
+			 struct selinux_state **state);
+void __put_selinux_state(struct selinux_state *state);
+
+void selinux_policy_free(struct selinux_policy *policy);
+void selinux_policy_free_rcu(struct selinux_policy __rcu *policy);
+
+int selinux_avc_create(struct selinux_avc **avc);
+void selinux_avc_free(struct selinux_avc *avc);
+
+static inline void put_selinux_state(struct selinux_state *state)
+{
+	if (state && refcount_dec_and_test(&state->count))
+		__put_selinux_state(state);
+}
+
+static inline struct selinux_state *
+get_selinux_state(struct selinux_state *state)
+{
+	refcount_inc(&state->count);
+	return state;
+}
 
 extern struct selinux_state *current_selinux_state;
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index fd03ceb6c8de..6e67b7a9f3e5 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -90,7 +90,7 @@ static int selinux_fs_info_create(struct super_block *sb)
 		return -ENOMEM;
 
 	fsi->last_ino = SEL_INO_NEXT - 1;
-	fsi->state = current_selinux_state;
+	fsi->state = get_selinux_state(current_selinux_state);
 	fsi->sb = sb;
 	sb->s_fs_info = fsi;
 	return 0;
@@ -102,6 +102,7 @@ static void selinux_fs_info_free(struct super_block *sb)
 	unsigned int i;
 
 	if (fsi) {
+		put_selinux_state(fsi->state);
 		for (i = 0; i < fsi->bool_num; i++)
 			kfree(fsi->bool_pending_names[i]);
 		kfree(fsi->bool_pending_names);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 14a1194a9e90..fc7e0631bef3 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2222,7 +2222,7 @@ static void security_load_policycaps(struct selinux_state *state,
 static int security_preserve_bools(struct selinux_policy *oldpolicy,
 				struct selinux_policy *newpolicy);
 
-static void selinux_policy_free(struct selinux_policy *policy)
+void selinux_policy_free(struct selinux_policy *policy)
 {
 	if (!policy)
 		return;
@@ -2234,6 +2234,11 @@ static void selinux_policy_free(struct selinux_policy *policy)
 	kfree(policy);
 }
 
+void selinux_policy_free_rcu(struct selinux_policy __rcu *policy)
+{
+	selinux_policy_free(rcu_dereference(policy));
+}
+
 static void selinux_policy_cond_free(struct selinux_policy *policy)
 {
 	cond_policydb_destroy_dup(&policy->policydb);
-- 
2.49.0

