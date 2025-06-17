Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A7E2E92CD;
	Tue, 17 Jun 2025 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169185; cv=none; b=RICy79BEFiRlR0WQ882jyQq3I7LozGEP1xvjVA0VJFgUchNsj/WG04xJY++2v020a7JTItpjYh7lPgCk2eP9snJn6IIi9DqM6Qd/uBYRfP76Mkv1Ciy5o92CHdEzOUY+XIa4fP5nDhL7ELescIRajNngCvVJKvnZvdsKgn81Qw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169185; c=relaxed/simple;
	bh=VpxgWwIAIs7EsZLJduwFUo6IQsJGAQHfxAe/mMkV1nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+tuZTI8hZqyRSssWDtwDSb/aKdnAWOF1kWfRWpUBLa98KQZbyKsS6U5G7OmModb7U1Jk9SAMaONtET1liGBfYL4oTM7HiEu+sTGmTInxUoIDzkf2HY4IPzpDyUdS7pF45hrn1GGqVBQ1PO0W+27s1/wFLEN9m5qYBiupoXcuFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQkQkMSm; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQkQkMSm"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d38d562a55so752308585a.2;
        Tue, 17 Jun 2025 07:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169182; x=1750773982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5npYhRtphx4UKteTGS3QbUwnAGdBuLmcFZewcnEGxAQ=;
        b=HQkQkMSmWq8L4O8YmnSyjAk9fCOTQe51BqzUWX/NI7S8mLIlAhfRu/O4XZIgKlR8z9
         JGXNySM3BhoZLz4QrpBj8xk+vloghbuPeBBa7xPvyYpCPVJzdwSBM55zUuGK9E2dg5iP
         EYdgO74LqFnpDlxybne4tZNAeUrGtfjcQBZhOu5qYWntWiGtz39KdqlIz1LiNW2R7HUU
         U9RcYT+GtJFktZ3CSaxGORnTRTHNbmExR8bMQTR6T7pSkAv4A8OtFEHpFPyjdbm5HcdK
         /Xv7yDzPmCTlTT5htfzg5RAHOeS2/xsdUOABIFxWs037EaRolYYCf47xXgXjdIO4juRy
         JhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169182; x=1750773982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5npYhRtphx4UKteTGS3QbUwnAGdBuLmcFZewcnEGxAQ=;
        b=RxlSYJyY8RCeKJJ4CRTLdbZT5mB9y2yrPnCnvoTvBoIQ5BgybDe89IhPnMwXRo7zTw
         iUnmZRoiR1A2uE3i9xDlmxV5mUyLBcE8KdpvQwdQBg1Q65P8qiK0UKzFfSYClas5OjUg
         ur+GD74Q2JbYYLsWFH/K4gFohJ3sSb9Nw7r8fYH1cB2ysnMko7KUdiTniWDHVkQ2UrlG
         jlI1ws4FOg598VDnH0mx6bqgUFSs5l4vCeVfiS7cLxZXaJC5/qx45vvuwtwGesk4cLak
         A3f+QggO/bePZDlBqhuD9QqVhFOdfxnoXD9pbODTwC3dyYsnq9aOqa8GqA2Hvd3ukLJ7
         Pyzg==
X-Forwarded-Encrypted: i=1; AJvYcCVkDokSMRe1s49cpOZqthM4lgsL27gqxQESbTlMlAuVN1FR4ezjnHpcYUoZw8pe7ibGOuPjqP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP2mPqObYPHUIjZQWF+D7FAdgwo+tZB8m7gUd+S7TJ/xZAeK1/
	srvsFW1W6WoZZOMt88gf5TeXHtBQPK08ywSXz64x8L0aLQvyhsFeRpN7EioFKw==
X-Gm-Gg: ASbGncukf5Kwgsz2lTdP8vHslaFXJ54VCNK3rM+MbqnGxZh26Wiq0ADqQo7Tc5BMWeN
	kUafxsVljPqG4vXWwrr7+ov9WSZnbA3WJ4lwtAsmhLJIdRjd1IFavBi8ViqfA9rp86uRP3TLUWu
	CXoNX9o5IjkTBe51YKczsHXKR/e6srbGJ+ZvJbEzR3XVNaUbv2PNY/2EoLlrqQU2yvo6hGWsNrm
	OebqAWzyUiVOr6w2UdahtvMw9AjLV7TJhSWu4lP2mg56LI+NfcmT5N/6b3dwQ7TIMQco785Uldr
	Nn3Wxls165d+UFZ5BBAJykV0Wj3/Pl0joeDy5UkmqgYNJpF74CKSMvQsdoPgqDKlI8hDdk7VEdR
	uDuC83n+eGZUHlymFbOd+YG8vytCUDv5R3kM+AG8blfIAsRsbKtEZuE5Qzg/w1m8tFg==
X-Google-Smtp-Source: AGHT+IHtjzR9+c0PO3Y/7clWqBt/lMVDk1koZlfhcWoOr6kzXdcOD1wNEW8Yd8E5irHj1yg5KzikBQ==
X-Received: by 2002:a05:620a:19a2:b0:7d2:1458:964e with SMTP id af79cd13be357-7d3c6cd9dcfmr1733790385a.28.1750169181587;
        Tue, 17 Jun 2025 07:06:21 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:20 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 13/42] selinux: refactor selinux_state_create()
Date: Tue, 17 Jun 2025 10:05:00 -0400
Message-ID: <20250617140531.2036-14-stephen.smalley.work@gmail.com>
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
index 746ef41b959c..da737e0abb76 100644
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
@@ -7781,9 +7765,10 @@ unsigned int selinux_maxnsdepth = CONFIG_SECURITY_SELINUX_MAXNSDEPTH;
 
 static atomic_t selinux_nsnum = ATOMIC_INIT(0);
 
-int selinux_state_create(struct selinux_state *parent,
-			 struct selinux_state **state)
+int selinux_state_create(const struct cred *cred)
 {
+	struct task_security_struct *tsec = selinux_cred(cred);
+	struct selinux_state *parent = tsec->state;
 	struct selinux_state *newstate;
 	int rc;
 
@@ -7808,13 +7793,40 @@ int selinux_state_create(struct selinux_state *parent,
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
@@ -7843,16 +7855,35 @@ void __put_selinux_state(struct selinux_state *state)
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
index ca025586e9e7..fa0551593b4b 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -116,8 +116,7 @@ struct selinux_state {
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

