Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEFC244693;
	Tue, 10 Jun 2025 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576188; cv=none; b=NfI7iBavzK1EImGaFcqjvMmDnQSNGbDz+aIf0UV7IKh1hdno7VNFZ8m/Y7SooduaRwsf7SzolItc82i0Oemsb3p7Px5uyW8Zc8gfGrncVHf0T+7UMOBuqNMVY/+J8i/lQdTrYoENXNaEPRYGlBrP8jmAv5AUc8bwXRAWErgohGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576188; c=relaxed/simple;
	bh=VXQrnLwHF4iAZxzLzMqp0ojeU7/UzuytVx0ItlLndm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifHfonGtkkLlOnOy8AFT9QRPGY2120HsZNCMogMNjjzb36P6BZjKdtJXE8lRVnVx14v3t0yTGUEhOf/aJ0AiNcoDR17gFQHgnNqQqKakW8DSVNHSHV5ZITT+wFQqJYNep1aOxTTnd11kveLw6dUmM8CoALJBBFVWYIJqLKEKFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+3NHDPW; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+3NHDPW"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d3862646eeso184885685a.2;
        Tue, 10 Jun 2025 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576185; x=1750180985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAy6jcSiQc/kXUrtN+FUS7cjzBG7SRacvXyoq4WwWgg=;
        b=N+3NHDPWvntjnVlvM90Thi2wVejo9wG/3iSDPlz4WlrhjBhv06oeqNMFxFUi/8ShiG
         cDODgRWu2L2L5jRRjufrxjlNr/Z+QAD+O2RDBcir4lfL1jWGdRmgdPP6ItytBjvklTsQ
         SlJ82mdQ7fyhhifiXiurKctxhw1AG0dZ6Bl33I7BJD3FlNEYPCTEnishXZg9HmrRyKAc
         uCF3GKgkbQJtR5qj+7BKAzywTtW/mgrrwofgtvDl49pZA0h1FjcYZirrcyJMlsldoHX7
         xM6SG7GjRI+7AGZIErnCr85rw5A0VJNgDxNkx/WaKTquMipwf50H7P1L1hUU/eg1OoLB
         RhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576185; x=1750180985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAy6jcSiQc/kXUrtN+FUS7cjzBG7SRacvXyoq4WwWgg=;
        b=hyNXu8pwCPJInNcRtgHR0iTUtOCeyNZse4TydPK9fE9xCMMlBZVAYCBh5sKvakhJON
         If+ITeUdg/vAqsVIARF4SF6hP5TtDJ4X0IVe5XZ9rchwF1UZLlxAPfLJ4unTHs6D3rES
         WLTGiHs591PxRA2cUDvTMTmzELg5SD46b1WkKpqawRKr2Ou84jUA4IPZpLmcspVk1qIc
         cYaOdBNvBnr1dO9reKGRAoemkJEFTsXEsUMp6unUZb1uRW3b9A3K3No4rMue59UTKRNH
         nS3JcRAqGXY7ODGcIrnIsPX5sYrSdfNBAL/a6EIokytdRkSxiAhn7zfRl7g83q61SLu+
         i+PQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7v2uUALJ0r9Umw+0bPMK+DSp61l871zo9ATst8nhJp0o1dJuV9uTKGyLwlrmhOfQUxOZo5/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0rFWYHmJYOFR9Y1CTouuaOQuj0cNwMIG06euz+keVZ7Ettar
	nMD1lDUqvAtTMD/h5Lrttr8MvcvHHcflHY+EO5ewqeiF0mgTRaVeej2UilYzTA==
X-Gm-Gg: ASbGnctWtlH5+gRDjmLNpfE9gS5oqUsLQa37EjDygsmrZmeGRLL7H5xZbV+J5t0w1yo
	/oqeXnV17K7ZWnR9+6l54QdCWsZpz4DO+wNmT5nHMliNOE+BdZxhqiylQtkMAsNuTThcOfnFRBZ
	EUrflA4618fJ5H5o0yP+tJPhKJORRS/g5DD7n1DzBnugxcizWP57N3EUGqscPrA2TQNuQXs2+I2
	hrlSsowGofA8/rXSnQPVc6LAmiTpmJl5ppQw9P0mcgZ3HC+UqacUhpZVdWnp2L7zPYS3qqB3uMa
	7UHUuNn2dXNAMyCxO61wrIgH5DnsCnmczqOQ7bQzbM4bBNhBYaYq8fzRRbLmEvP+W1sbvx/ZpV7
	qdVJp0gH3LAV5G8jgfY9lnjG/cvbiYLwtD2g2Cp2CzvEdJXI2vUkPgUIGnUEqLnaUDA==
X-Google-Smtp-Source: AGHT+IFtrkwlihWjX5twCuVXl4Xt/tvo9/xPFI6LtBMEBmnrm5y6ByTl3+QF0EMo8sGC0Q6IeGahzA==
X-Received: by 2002:a05:620a:28cc:b0:7c5:9b12:f53c with SMTP id af79cd13be357-7d3a880591amr38341185a.5.1749576184840;
        Tue, 10 Jun 2025 10:23:04 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:04 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 04/42] selinux: dynamically allocate selinux namespace
Date: Tue, 10 Jun 2025 13:21:35 -0400
Message-ID: <20250610172226.1470741-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
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
index 05ddec2a0491..59960e9a296f 100644
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

