Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D529E218592;
	Tue, 17 Jun 2025 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169176; cv=none; b=nuTZxzx4zvKZsTHno1pz6TYkjd275fUT8HEe+85wwotTXJregmwyFohQ0qlGMBIa4OVy+R9UDPbWwWyk0TiJz/2bKz4PJhWJT+dGJAcT7EcmtQL2xWznQQF34d1tfIt51F6rr7Tc93HJLjKsidpR0puvx7J29cxjro5Jhuhyxsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169176; c=relaxed/simple;
	bh=b0zXqFrj3kbSXHTngD+eeBfhHpyIkz5ft94ye4NRG7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHrOV4XqfQKkNlEtev/oO0EPgMw/cTm7i2EYFU8/VU9t07o+AjoodsXikJ0kcFt8L+xRZXWXPIkIRouEueb6uSC3fE/1J4eieJIZD0rm6ZMUzbxiqj+21fqTFzeen7pAhoimt6a5kiWJk4hu6fI4Ldz7XGeuIjor8EbKzx3XzIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAEw0GHq; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAEw0GHq"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7cadd46ea9aso911391085a.1;
        Tue, 17 Jun 2025 07:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169173; x=1750773973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkkoKVlKa/NYPIdWJpDHOGpyZmwNfmLpZxUf6MO3oc8=;
        b=TAEw0GHqFLdM7kRXVu9KIvSeA+d+WQSdD68HnPWyByEJvebF1O9sCVq6ZSkAsaGm9H
         72kv3oCBrCxEZakimPNLMvgzg84W4f4rwArRTe4VEZhqHsmnsuDR4bHrA3BsetMCYtOU
         KxH+FfDj0L2hN/nXCu9Njk1nS/e1ZsfODyr4nP/nbpOgWGCv2Opf5s6LEWpYFSVcj5yV
         oW8LFqC+VZDwpYTBjjsQgvixdZiofqXyHqSekFaWHnxW6M3suv0X+Y5f/KiMnIGH+OyJ
         15uGVYPvrR/ljEAb/rVj/3cvbjU+xIdGEDUwHnakCYpgqmQteBM5hCnti1BVrziMedNd
         qQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169173; x=1750773973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkkoKVlKa/NYPIdWJpDHOGpyZmwNfmLpZxUf6MO3oc8=;
        b=KUfvQxbNRcDqLpJqHIEBdSWl3D0elJstDHskGCTdVpK6LRIUHMf3vHIca9M36HuiQQ
         ihIqJgUx4RnDtr/Klgb7q7z6LSj/BL5XysOuZnyH7mppV2FrnVUSX7A+GD2L9A8AFWSJ
         LdGNDc6OcnP0m6VR7a3I/qoSd97kkJ2jLZA5WyN/aQzh4MAkKs51dU8KropYpzQLbHMg
         QMUv7VupaVt66+lD7DHB26J1mQ7WH34wEVlQmWk+HChp3+ss/s6NHXUFdzvBe6ToijSl
         z3uS82W0LBl23eWgQrqQN/iUUZRy2UcV9+K505EGvdML7D3/45TpCvZjH8YGtxz+iJkG
         +VkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWwLSLrm8zNHNcaqyG6dMDl7N3U8Gz4OV/ybG42BX4uxVJWFjPcvLm1h13DVGGx2JfhF43yIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSBy6g/NevI5NTTTeASz5otAFKhg/M2DCeihMXS2Xl1ZT9vTyz
	QjLuGf0znc098ExiWDjPASPCL1DUJ51U7zq6cA3TCZs2p15t7Re2YO1FPH6E/g==
X-Gm-Gg: ASbGncvpxpqSOXPiy0VAuwbcVH8HodP+ffOlMsvBpyUpz13FovL7uEZDxeC20T/YtwE
	2x1ZQt7xebS0XpLr/N2OYznnAIRk27EzIvIdXdnWdSdZEM5wmcxOkEgkjtCPEDsvq7ZeBS6B54i
	bgLO5gpqcywVT00yHLzfRu8oX18tw0k9cY0ypkMGpp61wSBdpaXRv8Ddx3sD4kXH+Lpnyv0YypK
	Z6ZegnYsm3AAZ3KDkHMvFV9dPsLHGDBnqb49AYV9G5AbV20gKKRtyi3w4ouiIScEo0UeKXD1U/G
	6SlY9FGlJzssH9RkX4fztNMHZfKK638647vwly76ZG10vo326xoONDF0tjOINY/rhOzQ5OIBEcx
	X53/AhW+zPZijptC73qYA4yTXUhFYEDzjKpwZnPI09Awo2XvAOqKr5B1JxySfyjbUqw==
X-Google-Smtp-Source: AGHT+IEUs8kzij81NA6ZgjmfzCIYjfPr/2OCg0PdW1GeQV9goX8HWnenaYT6HOzQcWPX3liN7pgeJA==
X-Received: by 2002:a05:620a:4408:b0:7d0:a243:d5c5 with SMTP id af79cd13be357-7d3c6c0950cmr2209284785a.5.1750169169339;
        Tue, 17 Jun 2025 07:06:09 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:08 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 04/42] selinux: dynamically allocate selinux namespace
Date: Tue, 17 Jun 2025 10:04:51 -0400
Message-ID: <20250617140531.2036-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
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
index 05ddec2a0491..953f71e517c4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -107,7 +107,7 @@
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
-static struct selinux_state init_selinux_state;
+static struct selinux_state *init_selinux_state;
 struct selinux_state *current_selinux_state;
 
 /* SECMARK reference count */
@@ -7723,16 +7723,67 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
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
index 0c2995fc13b1..f250d00daab3 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -104,9 +104,34 @@ struct selinux_state {
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
index 112edf9b2106..c621ec4a94dc 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2202,7 +2202,7 @@ static void security_load_policycaps(struct selinux_state *state,
 static int security_preserve_bools(struct selinux_policy *oldpolicy,
 				struct selinux_policy *newpolicy);
 
-static void selinux_policy_free(struct selinux_policy *policy)
+void selinux_policy_free(struct selinux_policy *policy)
 {
 	if (!policy)
 		return;
@@ -2214,6 +2214,11 @@ static void selinux_policy_free(struct selinux_policy *policy)
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

