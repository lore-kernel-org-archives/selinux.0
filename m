Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE5B281344;
	Tue, 20 May 2025 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742478; cv=none; b=ZziWR6EG0nI7eMqsy0HR67n/N4MDLeckD2T2t1746bzK+fiexqgnsue81to3v7fOvhEYsBtAsgCGm0DY7S6taepqdovJWpE4vrT2Somadcs6Ns9bORWEekkUhJMwenPW1teyB1PUxR7yyB4YIbEyyfTe7Ix1TVgvgzRZtJtbpOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742478; c=relaxed/simple;
	bh=+V1YFFda+/3iIDs+Sbe/C10imupOFnC31joU2Z+cNs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hhzied158MGCkuOOj1abIyDGQTNRtynxnSUPa6fcEA2fvpfe4kO3VZ6Z9isrYfXwUvH3SnREAZxZoj0h+sm8MJfsWhTmMSdIhHzWVb+Ot84bNnvkhuYeWLIT8thLzlCE/zU8RIPaHPXXbLmFZRYcsZ/cx41eWg1nfvk2WoPvtMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hizNA5Sw; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hizNA5Sw"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7306482f958so4267915a34.0;
        Tue, 20 May 2025 05:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742475; x=1748347275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLpQbSJvUX1NqTRgdRD8ddun+sgPY7BlFDS+G3vuXbc=;
        b=hizNA5SwPY6r7uZIswqHFFdsaZTuuHgTErEFkQkTmyxwWVXJltTqZ2x4dFtUKdXTFZ
         E0fUZdDTVaYkL1yv3/4vMg4l52gQUB9WJmPaff+ixBiYgQTgYSLI69sm51NMV2+gBCGC
         X8yn9u6j/9VKEM+6YvMiW2Zu4DgYWUr7sUANneCiKa0P/8+PV8j9ncX/ShLQDNdQOtHQ
         plX3XbDWk7MTL9yQnYI8WBxEqtT3qt9L2vy1UHwIOl3h7MrljslVMDF8jXJMj2IAcncx
         UDU/CvXuOH0EV6nD93qJzVA7KR99nvJcE6JhqS0nVBEM0a1/NNt8JDMgndkLDwilY3tI
         5opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742475; x=1748347275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLpQbSJvUX1NqTRgdRD8ddun+sgPY7BlFDS+G3vuXbc=;
        b=qRS79jfonJAhEoE4rTRPqpa1ZC05UPshNpYU299Ss8bNsoT3pRiNTa6yBT1+x9726m
         EPkP6R2D05IAtoxKOoS8q6YQcLxYefMzap0KbHNC9D6Lrina/aBmViVsWvzziP95At2Q
         SXRi93gn/8uij7b2VZLJaMn5M4taPEjHrEb0aDjT+L7Mt3/uZegCZ00G97F5N6N7kVBX
         xfdFWI9TQWPStA2DiYXp7aF4A65CFnfKj4YHMzsiS0nFeu7LJSY3D1Znl0PSwWxVZwaz
         m4+DagKsu8U09GJ+nHJSF5f5Os/KGEpuPTKBFVLNei5oc78PiKVDtbMdkUqHF34On+gg
         ppMw==
X-Forwarded-Encrypted: i=1; AJvYcCWEU4uQ4lY7rBKbZNe21myvYI4yMvfe0ypAm3DBWLoWzAfTXVwvP+N3p+Ak9CsRbBALvmNAlbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY/L4QGa0wbWYtQN1CFYjeUePe2RTMMOoIKFJN2AjfKXQHRGfr
	e2NqCIcM96uaVtHBXh3fTil/SQlntxCAwfg4BP6tdvYva0LIfzmH8JkPJ31V9Q==
X-Gm-Gg: ASbGncsr4dCz9mLCdzdJvd7Kv8tupJWowN5fjUgBOpOeuCJIao4EdIev8nNI7HitP3u
	L1UI9IRwsyAneqvPKvyIdZF3ZbN+cPAVStR6/NwPZXHeIiLoA3fOKjmkbcUOFfLWS507TCSlUbJ
	WBHbzxp/pnhqnN5H61wi9NloaGo1zYN3nJpYIac59GGTkbBz48kHmSnv6jfj/ChDNlYxDRfthLg
	620K+f/zkITk2AGmh+o0Q0MMgLb5l5KOcj++lnjfA/RACQ9Xv3BRFyiWZ43Zor8OPNyf/hAe3qi
	HTMfxdNZk9fccN5dO/nzy1hYLlLz6MUWrGiOjd/xUM6Iy7/hY0sIbyoLugFbKvYLkas05TSlO6r
	EmqcanzjkrZb4rSqLkTMfREH/vGxIFBmIt0U4Ek6vi3N5hCKPd09wnDR5U/VnD0KK
X-Google-Smtp-Source: AGHT+IEz3uLAh8N5Um7HnJCxT7ShzMFYZp534DnCILVvvvwhxk24XxgKz8nqt+nkdQCPi9n1Uiz8VQ==
X-Received: by 2002:a05:6102:6c2:b0:4df:a5f4:b979 with SMTP id ada2fe7eead31-4e053d63377mr14832442137.24.1747742464024;
        Tue, 20 May 2025 05:01:04 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:03 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 04/42] selinux: dynamically allocate selinux namespace
Date: Tue, 20 May 2025 07:59:02 -0400
Message-ID: <20250520120000.25501-6-stephen.smalley.work@gmail.com>
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

Move from static allocation of a single selinux namespace to
dynamic allocation.  Include necessary support for lifecycle management
of the selinux namespace, modeled after the user namespace support.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c              | 32 ++++++++++----
 security/selinux/hooks.c            | 65 +++++++++++++++++++++++++----
 security/selinux/include/security.h | 26 +++++++++++-
 security/selinux/selinuxfs.c        |  3 +-
 security/selinux/ss/services.c      |  2 +-
 5 files changed, 109 insertions(+), 19 deletions(-)

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
index 2cb568c04fea..fe4c65b132a4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -108,7 +108,7 @@
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
-static struct selinux_state init_selinux_state;
+static struct selinux_state *init_selinux_state;
 struct selinux_state *current_selinux_state;
 
 /* SECMARK reference count */
@@ -7762,16 +7762,67 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
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
+		selinux_policy_free(state->policy);
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
index 0c2995fc13b1..913a29eb3136 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -104,9 +104,33 @@ struct selinux_state {
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
+void selinux_policy_free(struct selinux_policy __rcu *policy);
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
index aa59a93be5a5..b9e3965418f7 100644
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
index 112edf9b2106..c67965cbfcba 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2202,7 +2202,7 @@ static void security_load_policycaps(struct selinux_state *state,
 static int security_preserve_bools(struct selinux_policy *oldpolicy,
 				struct selinux_policy *newpolicy);
 
-static void selinux_policy_free(struct selinux_policy *policy)
+void selinux_policy_free(struct selinux_policy __rcu *policy)
 {
 	if (!policy)
 		return;
-- 
2.49.0

