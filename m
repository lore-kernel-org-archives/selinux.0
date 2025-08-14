Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECE73002CC;
	Thu, 14 Aug 2025 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178030; cv=none; b=tO/S7G96ggTvQeLEd8gRNnkUr5RHdkmi1nZKEQih/STulmcLKa8CCZdORaILfXGGkiXVzj17+XZ7BkpUIOWWGrSgaUfd3P0tm34PSuPOBGcB8datmXO+twmsOLryXCTFs8ATzPUOeIvUM0Gu1nU8vg40tUVwFGFVWDZE9cahJbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178030; c=relaxed/simple;
	bh=lfUxiYrnDYgX1qaRgy4aUY/XHdWRhYhd0BPconX90RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fh7x+g0/ka5p1LqxVUeDCK6rQQdx4XTmYNYYDqzl5MhCCTHPVuFFw8a5t8xtINgX0kzelEsuTBL0TCJLb1Q/JmOIjUiigisBxsv1r619LlpwLDSDg8KyMJFsD+Mq5ikRr+8US3ZpYAgTk3gCeJUe5UStI6niA/HjN3RLp1oLesM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSM9eNWn; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSM9eNWn"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109c5ac7bso9667361cf.3;
        Thu, 14 Aug 2025 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178027; x=1755782827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Meu4lEnVA95ljbpyloXHyZ1jWqtJ5L9mUbWPiabubaA=;
        b=NSM9eNWn4bT3YFMzc41a0o1j4NPQQqGfXrnCUsU5taGtT0BqufQbC/LpNqj/12WY8d
         0oS4fgutF27dFAWhOCOnBxP48D8iyFYSSFB/beHOxfxtMcQLDj4ezaZHIFX8ji9vYKLA
         OvPrbC3Wmf8m6WTXIncsbc9nhvdTby+lq3MKI/U7UPiGsW8i1OQRt5ZnAZcJ9g1vSKC7
         165inNfZ00wH/ecBNg8Oujb1bbBmFYpA7Q+eDUQsSNlAMmu33fnzXvDcKT30dDmF0nW/
         mnxns2kL1jD7fjXEpxiy2POc8jt5G/iS8BpDp5yF7CmrxoE/ZZIabBXmweabAsIQfcmE
         WDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178027; x=1755782827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Meu4lEnVA95ljbpyloXHyZ1jWqtJ5L9mUbWPiabubaA=;
        b=JW5M0xwo4eL1VPAwuhCROvJ2iRk7V8JW+8XgooBVHeqdQxW+ahWec0fNIEEErLzler
         9qF+9fFtXc0yhjmQunVS8OpJ1malSU/lvZSd+yUrXj4s7gLt7R/9hij2fnGSONiEWM/w
         Tj6L1mR8OVpCSSQg2ZioMz0D6/vStEd7mYraPRKjzFVUPZ7s7lHJ5QWF20MBALGfFb6x
         YIDxuTLbpdmBc4oXL1V3Y7bDlKB9Sg4hPsFxJ7mtgibgpS/ji+8jYk02rvj7jXZwf8hN
         Mqetf31/n7pADeTfwb52bxiD1LC0XWamQrLW5h5nOzXhF1bRAs0Nn+vqHoMHIspuM28+
         LQ1w==
X-Forwarded-Encrypted: i=1; AJvYcCWBtIzxfHKa8RUsVpImaZY4flyWXk72ReA8FKu2FZRrd9Z2E6XyuXNYMJD9Le0k6hAleN5b4B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBHyuQh0o+RSr19MaVwHn1PrwPwK9r0I41RYMKX3SIBOeBWHs8
	+v+U83o38ZNDYPL988hmI6CjMYjR+z8ctvduPD7GKAowVoMDH5lIYSie4QcPeQ==
X-Gm-Gg: ASbGncu8hAwdf+ArFCY7QtuNo3Vi6EO7hzolj2tTJANQLk6CtY7dXlzSjGIcXSZ6AoP
	W573gIG0VWwuCGKeAk1BgvXw7iqGrolIpU6n91cuSX5RwuTBEPldZ9RIPD2g7kkTFJI33fyiVPl
	pEat+6EaEr7xQRfaSxgcIXaIivIHqikpLRQPFOYDv+F/eRfVwDr3GSON5HNqoy7awkkffKUgSEK
	/UhchyeMYIRwzRXvGfIHx4tsGZTYszARs4qZD1XLpbtFmoDsTabeqsFG6KavdrtXFhlpau1OS14
	haYU03Yvspded9mIlJaSXna8z6x1uWEe2j10cll1QPCIxpK4zVNh02dmUO8tPBs0GRbOiV1VOHe
	wX3CRFR9FRRkRt3vXe/MCna62JMPcoHVmFcOELC0Bjax/GGBpwlwsmbpU0B970KiYM9gLW+1s68
	gpiwqhF7JJjFssfXB012doQti9Kg==
X-Google-Smtp-Source: AGHT+IFmy7ADpJhrjrMGa/NwxDpRWT2g9YkXmAsMwaDWTKFicswdouG/a2nzP1My8dJZ8BE3Un2SNQ==
X-Received: by 2002:a05:622a:92:b0:4ab:730d:c17e with SMTP id d75a77b69052e-4b10abc9d9emr35374761cf.39.1755178027213;
        Thu, 14 Aug 2025 06:27:07 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:06 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 04/42] selinux: dynamically allocate selinux namespace
Date: Thu, 14 Aug 2025 09:25:55 -0400
Message-ID: <20250814132637.1659-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
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
 security/selinux/ss/services.c      | 17 +++++++-
 5 files changed, 125 insertions(+), 19 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 32e1a116f2b7..056e597912ec 100644
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
index d45a3ac9ded6..7c405f3289db 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -107,7 +107,7 @@
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
-static struct selinux_state init_selinux_state;
+static struct selinux_state *init_selinux_state;
 struct selinux_state *current_selinux_state;
 
 /* SECMARK reference count */
@@ -7749,16 +7749,67 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
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
+		selinux_state_policy_free(state);
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
index 168bd75f9cdf..d733d2dabb9f 100644
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
+void selinux_state_policy_free(struct selinux_state *state);
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
index d07d585fa401..28d0fe3b3244 100644
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
index 430a654b42a5..90a73bc627ca 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2228,7 +2228,7 @@ static void security_load_policycaps(struct selinux_state *state,
 static int security_preserve_bools(struct selinux_policy *oldpolicy,
 				struct selinux_policy *newpolicy);
 
-static void selinux_policy_free(struct selinux_policy *policy)
+void selinux_policy_free(struct selinux_policy *policy)
 {
 	if (!policy)
 		return;
@@ -2240,6 +2240,21 @@ static void selinux_policy_free(struct selinux_policy *policy)
 	kfree(policy);
 }
 
+void selinux_state_policy_free(struct selinux_state *state)
+{
+	struct selinux_policy *policy;
+
+	/*
+	 * This is only called from selinux_state_free() when the
+	 * refcount for the state drops to zero, i.e. there are no
+	 * remaining references to the state and hence no remaining
+	 * references to its policy.
+	 */
+	policy = rcu_dereference_protected(state->policy,
+					refcount_read(&state->count) == 0);
+	selinux_policy_free(policy);
+}
+
 static void selinux_policy_cond_free(struct selinux_policy *policy)
 {
 	cond_policydb_destroy_dup(&policy->policydb);
-- 
2.50.1

