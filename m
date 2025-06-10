Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A308C2472BE;
	Tue, 10 Jun 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576195; cv=none; b=hMBrQkzpZ9/BgjJJKSYoVhNVa0I2pHdib5auGoyZFVN9YPiTZspJHzv7scff1Sty4vo0K6X1OhUGwjVTjmxC9ptmv4Jyb6WAl0najGqeLGIT4q+5S3CuC6SacT5o9wpKX1C2n5BbZQ8BKNrbF8SWoZ4tnyJlLv+zDcdMLtKrssM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576195; c=relaxed/simple;
	bh=+/5DVNWapLI9ujbkIpaMUsL6wC/ZtxAX2JvM7WVmcws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRVaXl0tRCXKhf/72BXKFZd0jUj0Fis5KqJ68v52wxcd00/i3ev0MtZoG0OZHsjH4tr/3IBWyfWt0OYs7JqOkL4q1qUAef6//bQSj32T80qWpp4fFrs0YISA/EfN65C8FSSCn28DUpO14lX4pIovCqA3UGhawfbJJ8DSGYVmEwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBGSyC+s; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBGSyC+s"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fb01566184so47309406d6.1;
        Tue, 10 Jun 2025 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576192; x=1750180992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRSR3W7IlXbzCk/qoepMEBQ6GdLonRMgQbUsPx+5xKY=;
        b=aBGSyC+sPLL+onU2pWenVHqN6omwg81InWd0m7jMGDYR9ZuDMMANgYo1ma3bX9imc3
         Gp86UVAFxTv0gudE4KZ78+eEtTvWFxhbkk+s+6BFUZTl69jmOMxk5XIirrX1AsheNd+I
         0OnOC29muZkIYWE3qMXaqZKPfllyS9xIbL0nCYB6mVWK2OVovXQ5ddanZgP9RrQ/0nPQ
         NQZkB7PVPO0G7TmxT6TOWxSBgKYaHrvbEExUNhOqHxUY94Y8nLWjyi8U8c2x1h69vbJ7
         vMN6kXiKhiT9cWYvnsW4QZS3hLObBq4OZtAsk9Zapxoaxua9hTtxxF58fuMG+1rqc8L2
         QjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576192; x=1750180992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRSR3W7IlXbzCk/qoepMEBQ6GdLonRMgQbUsPx+5xKY=;
        b=V+xkMSKBojphjuASyQATzzgQmqE+JJ/TJIP6LHEW3es+6J7zW+UA8/tqNX/8s60Jqx
         q6QCctI5xv/5oK0+6dkQaWDU3wODhiAORVZ0gi9mOkMGg+bbOGw4ckRial75nV3uWXMa
         gzAFafr3YM1y0TZnpcVmp1puBbX8W+0goh5gtc/WTkd0G/mHpRPbHjeASW42wm4Q5iFB
         zl2s5MCFCQgEmahmwW00P/6zsyBP8gFOJoCSjWYOcpU8sgDx1Uu2BR8ZGhJ/aAtBmSuc
         /DYElgNM6UR/slKKj2g3qS6wzJoL37LgwhQF/8gbnKNtO3htqyzbH5reteLDpAjfH1Rd
         KF0g==
X-Forwarded-Encrypted: i=1; AJvYcCXZ5vEWX+9wi93FhTzaf1fo+0WvH7iUaA5gq0UZ5nzy3C8BIP8lpqA4NhFMbHSKhs71gokTiwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQhg0FKRjobFmrOqtrMk2sSp7GSIxJRwte4pkjFgVMluT49F0
	9boRUVURUCHgoa6N8lKQLW6ShQ+DpAziaYzRokaDCHRhU65wNZznuOWuLbuI0A==
X-Gm-Gg: ASbGnctcsXvfENxfgQkEH3maxuFlIWxcjvA6IgyU8/CzIGYrEqNmqNzmIGGkMOrITY1
	9t/sRKUmkihgzb28WbXmlA7j4VXqcFrZ7aSxe4Vwp1SnQzy64QvH/yk+XqJVuslf/DjHymU0nTD
	5TBzm2iao9U0L57Bp7vgB4V38Q3QQS7u1MLhMgMBvgTnIz2atnG0nt8pNuOwaDcON31SLsrh3lc
	L4IybmGlKi+sALtmyVwwPkQzq0fB2mHLpzxGBB+TzEpgOVBYeGSal8fAU6mLEJvJ77RB2p6dG1S
	mYWMKzdUVPzRBigTx1g77mRPIXn9dl1GRPrdmCWOxdoWU5U85Kq29D9r2QVAhHdlEeZeIX651+Q
	HAehS2q8Pduf6zY6sL20ZIfgwqO6n8Gis8hrJAoPBj5mnpedMQlXAEJTMrIfo+7zGZg==
X-Google-Smtp-Source: AGHT+IEl5KsFCzw39C5mAD+ie2OkvIIt1WiUpeLq1q5/0Kgow9jcF/oW6/8PrQZsjKFKHsHRNICIxg==
X-Received: by 2002:a05:6214:2508:b0:6f8:e66b:578e with SMTP id 6a1803df08f44-6fb2c372867mr4523426d6.32.1749576192133;
        Tue, 10 Jun 2025 10:23:12 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:11 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 13/42] selinux: refactor selinux_state_create()
Date: Tue, 10 Jun 2025 13:21:44 -0400
Message-ID: <20250610172226.1470741-14-stephen.smalley.work@gmail.com>
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
index dcdc8c23590e..8e1afcbae941 100644
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
index 221a02f3f9fe..e916c6da1824 100644
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

