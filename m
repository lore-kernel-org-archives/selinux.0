Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316A715C14B
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836363; cv=none; b=hMm2pGcClGquZFc7v7mqJDForIhq/C7mQC5AQKimp7tYOEIEq4QdRUn2kPBhZr77Kb89llpJSCHZV2HMmAHtrtIKlFmQK5djPMj4xPBlK9OZHrS7rZAKs1asApZI7Lb2WRTe7uoWubt+wdZHP4/yJGhOn3BMScWau6lAq9e9rtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836363; c=relaxed/simple;
	bh=0TYmBzOQvZ2/t+8nEIImwpR7zTT1lLA1rvqY32RGv5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=baksAdZ6AhI+Mw7KH9nLCEpYwPrw9IHzSxoXcxcV4ERTnNYoTvGtMW8wY/1hVsjGIwOfPcmUazUAuLcyOf2CkErx8pFUvG6BTyC4QwnClSmsSd5c/4F1BcPYs7eE9NGFRZkbizgmqID4MJVKWXx6xFQTKLa9DaXp7wZdHaRrs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaLEeWB8; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaLEeWB8"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46741855f9bso103439581cf.2
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836358; x=1736441158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duohzdXzUV6DuywaJMPPM2Kl9XCO2YYHl8tJ1P/9ohQ=;
        b=WaLEeWB8ypnIkPeuOgU6DPcUj+h0ukU8qkIPd5JQJilTugxMQMICNnuWKv7i0ZAQC0
         c2Y5s1cZFaG0WwbcD9NLUHdKTmvlAfmbzvQ7ZZjoE6ADMOSMBhBRK5pwLPKI6SJ4JXZQ
         CdpX9Oc7dYez0nwe9q7TLLKfej3CDSJEHPMDu2lnP8C+NPgy3VQor61t1z3BtG8G/slM
         hdoU40r5iylsYWgip13Yz10qe8GCdqUietHXJKHLoQucnudJofH2RAvRXSLxnSJJRxAw
         oTsI4PsPDAOnWvQ4AZAQtkL1wldbiw2yyjyY8IR3mzCw23QE0cBA2xKUZbmoXKcmFGMD
         +oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836358; x=1736441158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duohzdXzUV6DuywaJMPPM2Kl9XCO2YYHl8tJ1P/9ohQ=;
        b=PNPkd1Jdt4XR//oJnOM/ml5/Xzj9MPdkZTN46skUitmy87a1cmoDWPCnvzOhFlPsAl
         AkA5MFQdQ9gOTYEijN2Z1ln07302XIjEqiFRd7ATgMPz6q3kUnfJkogRjVmd5uufcHi0
         lkWZaKoY+yuhQygYjnMVut7YOsFlp/kNJslRruqfuOb8u89tVo5/ZO02LlBLJtqvtS5a
         L2H3/uspehImyXLp7/dTS1JGd3bTAMT0SZ1myOIfyx1Wbyyr1brq7d8NjgBvCG/ikYI7
         zOJV/jChtCQbgMSdFdFknQpiroDxx22Ttpw+65s3vw6mNMSzY+1oh0LWBgapKF9ikoYv
         UILA==
X-Gm-Message-State: AOJu0YxwllFzChfEC2U3iPb963qln14NDLdImfPwZRIFS1OyxHCfJTe7
	O7jCUXappSiQUGLuvTexG0kktRFDp55JX2ZBzq/3hu9vmDY2xVzhOxM5iA==
X-Gm-Gg: ASbGncuE5zSp77zjKgPtj510eGnSO0hLfRda0LTzWXPOts7gZ3BB38bxLoSqRBo/Esr
	pmZ5TndJvKi1dBKiu6s6JMmcmKNuGzogOjswb2/R2AVMpwdCjgQQ/A+c8Z4m3YOnZFJSw9rMP69
	y/XbMhMlwKW+FT6TseNTOUCoIX4d0K8O6wmkiKmoAfwwsMcg8nmdI2OvUncEydh6D0hxCmvbTYU
	uuxAFlL1BJP5YuLQh37AeMDxD4ARe1O7z1RtjDA32QcoSoxjjcP7LZpfsfRFJ0uNaHPoUO1mZaY
	wxQTTiDmCi2BvAvQt1V0VmZGvNvwOUtmvBZbDyNibIUC72H8WbSoMr+f1zHS1yAFkRX5nw==
X-Google-Smtp-Source: AGHT+IFbE0cyW9FBPGCJbmO2DSTOq/8bDObK2fNzdfavGYT53l9Znr5jZ8paJv+E5iNnxlvzAM5MJw==
X-Received: by 2002:a05:622a:64c:b0:467:61a5:1a85 with SMTP id d75a77b69052e-46a4a8e87b4mr725846651cf.30.1735836357900;
        Thu, 02 Jan 2025 08:45:57 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:57 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 33/44] selinux: refactor selinux_state_create()
Date: Thu,  2 Jan 2025 11:44:58 -0500
Message-Id: <20250102164509.25606-34-stephen.smalley.work@gmail.com>
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

Refactor selinux_state_create() to be more like create_user_ns()
after which it was originally modeled. In particular, pass in
a single cred argument and update the cred SELinux blob with
the new state. This makes the reference counting situation
clearer with regard to the old state / parent reference and
simplifies the callers.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            | 78 ++++++++++++++++++++---------
 security/selinux/include/security.h |  3 +-
 security/selinux/selinuxfs.c        | 11 +---
 3 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3c4ea7ed3750..5ede1bf55f9a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -205,20 +205,6 @@ static int selinux_lsm_notifier_avc_callback(u32 event)
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
-	tsec = selinux_cred(unrcu_pointer(current->real_cred));
-	tsec->osid = tsec->sid = SECINITSID_KERNEL;
-	tsec->state = get_selinux_state(init_selinux_state);
-}
-
 /*
  * get the security ID of a set of credentials
  */
@@ -7576,10 +7562,11 @@ unsigned int selinux_maxnsdepth = CONFIG_SECURITY_SELINUX_MAXNSDEPTH;
 
 static atomic_t selinux_nsnum = ATOMIC_INIT(0);
 
-int selinux_state_create(struct selinux_state *parent,
-			 u32 creator_sid,
-			 struct selinux_state **state)
+int selinux_state_create(const struct cred *cred)
 {
+	struct task_security_struct *tsec = selinux_cred(cred);
+	struct selinux_state *parent = tsec->state;
+	u32 creator_sid = tsec->sid;
 	struct selinux_state *newstate;
 	int rc;
 
@@ -7606,14 +7593,39 @@ int selinux_state_create(struct selinux_state *parent,
 		goto err;
 
 	if (parent) {
-		/* Consumes parent reference */
+		/*
+		 * The reference to the new state replaces the reference
+		 * to the old state (parent) in the cred security blob;
+		 * hence, we do not need to use get_selinux_state() below
+		 * to increment the parent reference count.
+		 */
 		newstate->parent = parent;
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
+	tsec->osid = tsec->sid = SECINITSID_KERNEL;
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
@@ -7642,21 +7654,39 @@ void __put_selinux_state(struct selinux_state *state)
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
 
-	if (selinux_state_create(NULL, SECINITSID_KERNEL,
-				 &init_selinux_state))
+	/*
+	 * Initialize the first cred with the kernel SID and
+	 * NULL state since selinux_state_create() expects
+	 * these two fields to be set. The rest is handled by
+	 * selinux_state_create(), which will update the state
+	 * field to refer to the new state and set the parent
+	 * pointer to the old state value (NULL).
+	 */
+	tsec->sid = SECINITSID_KERNEL;
+	tsec->state = NULL;
+	if (selinux_state_create(cred))
 		panic("SELinux: Could not create initial namespace\n");
+
+	/*
+	 * Save a reference to the initial SELinux namespace
+	 * for use in various other functions.
+	 */
+	init_selinux_state = get_selinux_state(tsec->state);
+
 	enforcing_set(init_selinux_state, selinux_enforcing_boot);
 
 	if (global_sidtab_init())
 		panic("SELinux: Could not create global SID table\n");
 
-	/* Set the security state for the initial task. */
-	cred_init_security();
-
 	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
 	if (!default_noexec)
 		pr_notice("SELinux:  virtual memory is executable by default\n");
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 830f890b4cb9..adba67b074e4 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -117,8 +117,7 @@ struct selinux_state {
 extern struct selinux_state *init_selinux_state;
 
 extern unsigned int selinux_maxns, selinux_maxnsdepth;
-int selinux_state_create(struct selinux_state *parent, u32 creator_sid,
-			 struct selinux_state **state);
+int selinux_state_create(const struct cred *cred);
 void __put_selinux_state(struct selinux_state *state);
 
 void selinux_policy_free(struct selinux_policy __rcu *policy);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 0395ab187fd9..c91bf329692c 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -370,25 +370,16 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 
 	if (set) {
 		struct cred *cred = prepare_creds();
-		struct task_security_struct *tsec;
 
 		if (!cred) {
 			length = -ENOMEM;
 			goto out;
 		}
-		tsec = selinux_cred(cred);
-		if (selinux_state_create(state, current_sid(),
-					 &tsec->state)) {
+		if (selinux_state_create(cred)) {
 			abort_creds(cred);
 			length = -ENOMEM;
 			goto out;
 		}
-		tsec->osid = tsec->sid = SECINITSID_KERNEL;
-		tsec->exec_sid = tsec->create_sid = tsec->keycreate_sid =
-			tsec->sockcreate_sid = SECSID_NULL;
-		if (tsec->parent_cred)
-			put_cred(tsec->parent_cred);
-		tsec->parent_cred = get_current_cred();
 		commit_creds(cred);
 	}
 
-- 
2.47.1

