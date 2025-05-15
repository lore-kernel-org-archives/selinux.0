Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE9E29992C
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314625; cv=none; b=Fv9iCcCbnVgmWssNp+kp1QQ6xYst6DNDAHyDqNSAYIWzdT570XyxJILZT355v8i7Xl4G3QVm2gmBNFes08Y4eOKywsmcuQ/IwO8hzA/2ZzdaPrwDPHNCH2xhM7qIClXmkjbPJhATz6Ycu9jIvsuYOBv/AJAHVZf3gVIMy5SASDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314625; c=relaxed/simple;
	bh=ddfmVGJF0a9jRt4dpmNbEnIEhf5LILFu6MEnlzA0Qzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBVCERRtL7obN8qE9sHt/annOiGkiqeTOu5162eymMrxaTMAJ99iaovwz9MOLdKor0JmvNrs0WOtIBqEeS2QqYgbx3N3J5jt8iI5BIcHCKh6mBVCsaZZiGLutb4nHaHk8fWslmbVol5KHYTyPYoIx75Jj1GaOJJBVCRMQswBnrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvvO9Tlk; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvvO9Tlk"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4775ce8a4b0so14048341cf.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314622; x=1747919422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UTn70Y4wrT5z1OYFa1fMmLYC2HNoEeiGYFSNvwgo+Y=;
        b=IvvO9TlkNifiNl1JjoL7ZeQm0ktXFMcpY3/tvxcFfg9Ixr0xTf8/4AEhnlGgSvJkBJ
         Uz5XA04UVwgngkTzo4VdiNRnhf1vOi/ksqlK8lmVNKHz9lGAmLMFtqtea8wLJDxza/6T
         INiUqTePXzyt5RM5rV4DhqreonBr3qfXxC2S2uhnexYzGtUfeJuCX+Irj5coVzjHzqz5
         ulX8V7SPjmTqjDu6SAZcXaJYKC0odFxW3GdKzUuhQGMs709l5uPDbLPf5NcZ3SpcupuO
         F+hw4CW44PuMcKMsmpNxGK961KEGPa+12IrF5FJDcA3FJnHS7LD3KeKEhjOOqmshz+VZ
         SK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314622; x=1747919422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UTn70Y4wrT5z1OYFa1fMmLYC2HNoEeiGYFSNvwgo+Y=;
        b=lvG/D/CG+qsw3xNAtSYT3Uq4SePiaAHBDnVzf20GC9vzbUZr6iS6TimSVxOLPRvSrA
         s1XemLpEwy6r5vqdbvqmy1gTXllJzrgk0TB2DjXgPOWJGVz6fNDqD2JLL/oGhQfoVZoC
         9/bVocTZM9HPs3rlULJbgB2TU14O/dfhgZbsVNctQc0VPmspwzUjfS1sHbQwqnaXn0y9
         CMKF7Geau/0YExna9YxUOL8kVLdHXQMGALhq9rpYMX5RJnOviZmkVZjs7kPl/SqyrNfv
         erfXesqwipYjk/BJtWF2cUCDuV5tBhktOjmnC7dUOU3XBcMtos6sResc02e8YJdm9hFH
         N4DQ==
X-Gm-Message-State: AOJu0YyMLTU9eFliHWG5ZZ4i+ZPR28X4yb+NAOydBKV1Et3dU5nO+WKc
	CPG+9P+pa2uDU7EmjcIlFgbMDHaT/XWhiRHXZKMiQN01HzfzZVGlpVOHMA==
X-Gm-Gg: ASbGnctu9T/z40Z4YyVRKlHTNNJhgvPWPFY0BN7r2cJs6FLGQ2KcELyc8BLidSE/E9j
	FZr/790HRhDilcCPR+r4KXiS283pEhPSntchdMxY0J3eXLWkghggBmcIwS0CxxuafwfCWUNH0Pn
	4hqgokLRnIGnfg3iFaXqBAsNn3qo3qAI6l+aIJ7auVZa2qV4LSlK/BN+HNnwO6Q/6TxAufZI/cB
	3lrMha1V/m2jOMYTBAYbtQ2X3BLkJfqnvjvYJs9eVtBIC87r3IVnUck/rFJmZ+87v89hzYSfy57
	nqPcvHsGOz3yPxMErt95doR8sl92tYQRdutV1///rTqLThYK34X29Wn7WbanlaOn83EFFE3ntgw
	+vQoG8klSngRavfTWY4cJ8eNf/8sTM3I1/7ti2+vhiifq6oCWxA/4fg==
X-Google-Smtp-Source: AGHT+IEQ2awjL8wOuBnBpsdta1mrML/BiasaCPWjOL2YC86bmn8KVpNL4TMTnLYdSeE3ROpjRpXT/g==
X-Received: by 2002:ac8:750d:0:b0:494:7a4e:435e with SMTP id d75a77b69052e-494a338f918mr30467551cf.40.1747314621855;
        Thu, 15 May 2025 06:10:21 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:21 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 04/49] selinux: dynamically allocate selinux namespace
Date: Thu, 15 May 2025 09:09:02 -0400
Message-ID: <20250515130947.52806-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
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
index 40316fcb0c06..eadef3f02c45 100644
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

