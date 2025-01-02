Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC0D1494D9
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836341; cv=none; b=AnYCkoVBUizQRmU9qGEYcT4Eeq5DXor6sOyeRjPcrfZU1Bo8DwjazpU6TnmlyX9d0OoKZxuWyqy+c4fDDbl90S2bAl/VllHPJMIsAX11r0d5Dbn1RKUlFTIKaAdxWiBqiO3hvQ02vNTO8OTOfcJI3KgN7enM+w9W4PRlod5P4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836341; c=relaxed/simple;
	bh=RcMbi9nddwmJHMorQUzNSo89Dk3dqrzYCUyVlcFTUEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jP/7yzhW23ODMBh/Wrey01PkoHI6epPvQHT6JDG2UNhl3EDC9Vqe7o1TxDOUALt64ffm4ZxaVoD6o3DkGhKOeg8cheiuGndzq87IoeVqRy5gCrkMh5i75rF5Rt20Y2q8KMVHfgSVCcXg/ux+FT3+DUdbZ7NIVRwzkm6OlMA6h04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKxZthYE; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKxZthYE"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4678afeb133so104917181cf.0
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836335; x=1736441135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uT04y3a33bZnWQ3lpMmcbghAidNRHEASFWX7vpcA7YA=;
        b=AKxZthYE3Gokd+213V3dw6hOF6WOGSN4sR19a7wCMaM65S0+GqkkLu8UeNM+Ew/PEs
         kuASfyxkr00sb+zDKvPNKYEoFfhGR089JvBF0cupjQbMx4V+L65MHX1g9nQiWqmVyXS3
         3Gw0zcWBKTvXj7EznnJfKnSzAaEzcPdO3wK4+4JNhyua6jSrRruFKrDjohBJO9/qQw8D
         7Zp4KZSBecUAmuUkQ+RLfhrgYKkYFU/fDfNxAkZsFZWVRSELj+kJnS5Vdar0Y45rBKkf
         uYw0fumKyTLLdXJQwewgHNFdP2ECuf+dxDCPGQ6sanms+gLiVwU03Lnkj5p+iKmMPIKg
         kiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836335; x=1736441135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uT04y3a33bZnWQ3lpMmcbghAidNRHEASFWX7vpcA7YA=;
        b=bzlTDDUe3Jj6TB3utav2er/fP0ciJVfbAAn9c7MQEqomygsOfm5ZgyybOQVMikpzR5
         l03fZYAGSoV7oGiUIoB/DuUTxWrOdmH9gRGzUzmuSDbno+tUkW+sSpHpT5l1f68w3TNa
         HgJvrEwHkmsO6qIaIkHE8PevEZUMfrcE7/0cLv5wUcAJL/jj82YUtu+eHnXgyVL2iUTL
         Sjg9HmZUVWq2ecHLhC0kM1K/AIUdVeI3Xl0laKCFcY1vwuwruTJmeSXE4DxGVQe884ox
         w4naYgTJejbH28yHk14UZwBFd4dJV3JVJgb+b3H0qvfOMN00UrX9ssFVwyBMq4rJzBdK
         DkEw==
X-Gm-Message-State: AOJu0YyFSwcyrSO5U3ASKg2aXd/z543hY1t9LQwGt04BOZswHRxnkluX
	2KgI4Q59mDCn+Xtv6kTF+YN+XU9nvqoxSHSnpazhtA2p31MPBVoxesMEDQ==
X-Gm-Gg: ASbGncuUj+WPFFyhFCbGLPCc+UVyfZAoLUiJdxbHgUAxCMhdcD8bsOGeq0dWvTu7z7R
	FPgI0xRSgvi12Vj1MFvYEV5vm+WJxKFkY2eI30AJlRSCkDwGgcJ9bqk0DcEHoN91CRaln2Llkvj
	TEYmOQ6AeACN0rDQb+AMX9nTiazqxbs94ZqdHr5+bSFy+8hRqb3nNvBhAH/9GrbtkrX8/fC59J4
	tsTNxuETLVybr9tWYa5U1phE1xsgtWZXZdYEKAYoAcPWJVGXIn7jhJNuhH9cMY00gOJP88IKCPL
	Nr6DTLPdnNzPhHd6HoDZzOw5mu1b8/tyhfy3JQ5eDg1KY+wH6FH/Rdraset9U/+4iuKmMg==
X-Google-Smtp-Source: AGHT+IGLWUKA04FiJmlHz3C/h0SB92Hz2g1oWrO29Im/9+lUSZO3vAPT1sA9x3syeWiWbF/+gJQudw==
X-Received: by 2002:ac8:590e:0:b0:467:7076:37c7 with SMTP id d75a77b69052e-46a3b0964c4mr815200781cf.22.1735836335273;
        Thu, 02 Jan 2025 08:45:35 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:34 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 04/44] selinux: dynamically allocate selinux namespace
Date: Thu,  2 Jan 2025 11:44:29 -0500
Message-Id: <20250102164509.25606-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
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
index effa0accefc5..cc20c5d8b63a 100644
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
index 400e4dec90a5..ad8172ae7fda 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -108,7 +108,7 @@
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
-static struct selinux_state init_selinux_state;
+static struct selinux_state *init_selinux_state;
 struct selinux_state *current_selinux_state;
 
 /* SECMARK reference count */
@@ -7562,16 +7562,67 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
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
index 14aa2cbb391a..6df38c714d1f 100644
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
index a72fc91f10ec..a59153c322cc 100644
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
index db6c17bb274d..bbac5f3f2fd3 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2183,7 +2183,7 @@ static void security_load_policycaps(struct selinux_state *state,
 static int security_preserve_bools(struct selinux_policy *oldpolicy,
 				struct selinux_policy *newpolicy);
 
-static void selinux_policy_free(struct selinux_policy *policy)
+void selinux_policy_free(struct selinux_policy __rcu *policy)
 {
 	if (!policy)
 		return;
-- 
2.47.1

