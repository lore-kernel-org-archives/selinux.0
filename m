Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A3F3019DD;
	Thu, 14 Aug 2025 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178040; cv=none; b=p5JK15D6koHMXP9gqAjvAU5qhTBhHm7tI94LT+SUwwje6/7Rbb1JMaXMjy346srhPoUHkdNW0HBC/hoB9fxSJVvkzakiNVdm4C3BL1qM7HZdg5e6LOWf1ae985mXUpgQjw7SKqLlIBcWa+0y51fuO+hJVrnH6ap4EtbPPcfn5KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178040; c=relaxed/simple;
	bh=fOYWLrxEReLZQi1k392qZBuWNyaNAx7Vm7/oOqeV11E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxfj/ZuVK8zsNPJpi//+ymnh0aTOXOMzCOJsXZOmINA8PseSBeheR9edYd68mEAQp+L7luPC4zaq60Znohg/qL57IiSMkHM69zNG5YOnbEEslWa49EmpqiaNjFw5fqRGqnQwVzBqwdnyWegsZsCtmiTq4YZseUg5HmI4f+iFtJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqOvhV/9; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqOvhV/9"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109914034so9372521cf.0;
        Thu, 14 Aug 2025 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178037; x=1755782837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiCSQ/qEP//b3qt23046cawJInCtR9aFXEewUxbubPU=;
        b=nqOvhV/9EwmxjbLBiu4reJduLJZLVo3ZDVhIfh8onop7eCf0+Tv3vxG15DoAbDAwkM
         rlDYGSEMC5RQVKt0QPmMNXne3034q9IhdcqUMzpPI5+mxlHiRVrNs57NzY+ydJa1Fl++
         Co/kkideAw2xfxvGPMV6LzitWy/kzDBvlOC37p2tsXwxTL9gwUMT7fr4vrabWu3lqP3F
         9dLTccf//xjs0QbmRo8GaEjjJ4oT7sgffNZL5v8up93JuuFQQpJ8MPO2j4w83bKB6V5E
         BahNlBKluI1Pt9jCnZ/I7qBGvTYzEofBsRIQeB8hjUKF/pMgjETATiix4KAm0GCWOW4P
         Vq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178037; x=1755782837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiCSQ/qEP//b3qt23046cawJInCtR9aFXEewUxbubPU=;
        b=kb3/utT5KgdktGE4o4sS5MIrSWERmR09lEGDR28nxZBm+KOy8DD6oc7n2QxUeAukzO
         9Wi5pVDfqT5psxAUrKNStvmOM4J/yShA03QTlrQwq2VOZGevBzykYF4NsgMapeF+QNkq
         4FUOA000gsNS3NJ6pZfg1GQEZ1ge2Am6WsyqiuhdzOZjdYHD+tbIH724w9KGd1FHnVci
         CxKRCc6lME3Jrh8He/a8SOu/q/eKwrjwFyNRKsKvyGn4d19nxT81GktNYty5H8WInbMd
         8YMDFZ7NyO+js2I2/jsX1SEwfYDww6aVcTlK7unUtEA3O3RZsZwTenxrWFtPd0mDF3DZ
         1RhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTTc1z0DR5VIpiL9FXdkYmRAExTv07AqI8WZDa2SxPPeGbG5B5+Adkgax3NGYTvO/hMfdzshg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+FAdLHI1wSpnYswficq+PgwXbzq6mmPjGXUCP0FxOgdRJT7md
	rNRQ357ICbCAKggpVbTZmuFuQfX7CwC+IaFPprPItNNviDpUs1UlQVRxyLAZTQ==
X-Gm-Gg: ASbGncvXuycg6vYXpapLeBkFPWGGKChSC6G5M+rYtJWgHDNLkq3eORKtnbgZBWK50Uw
	+N2mqRYpD0Ks4jieUuEs3hk07ep8nei6S5VcLPLQsogQeg1hR4A7d5QGGXXqiSzkbV3gCL3VHhh
	j972U1D2/r1h/c8hI8opM1lrIiKXH1/tMaxPECPrDbBQlzo2jvGUPahlxctLCkNLzQWQ4iLW4u6
	yzvPKGTjypR70XPGwYGHYRqxiFf9b9oAP5qETxSuFTqSVTyPYgm2woXtdqdF5r+g1vm+2H2btSD
	GJJkoPCfOSiuliZVeNmndMqKRENVFPDcmfCnlu00NUf9xdrS+/OdeGK3u3UlwXWHqAs6Dkqw2D9
	8fD/4ZGRHivSC3PSSBlJ5HXXewcytkC5mdq1el+pMeoex+0EXlY1b/ZEACyePLxJZztYLj3kDMW
	4PSg0fw2jG0d+XvZTDZZdcTBIbyM4lWFeBRPW3
X-Google-Smtp-Source: AGHT+IE1Dg0vxHrcZvKCdsxTLoEPfwRwxA6a4OCDQ2hZ9SEWnVdjmqyB6FQvHbTM1hbGOaQ9KWfKdQ==
X-Received: by 2002:ac8:5849:0:b0:4b0:cb11:b5e4 with SMTP id d75a77b69052e-4b10a902326mr42025381cf.6.1755178036534;
        Thu, 14 Aug 2025 06:27:16 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:16 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 13/42] selinux: refactor selinux_state_create()
Date: Thu, 14 Aug 2025 09:26:04 -0400
Message-ID: <20250814132637.1659-14-stephen.smalley.work@gmail.com>
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
index bb053445a086..145432020575 100644
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
@@ -7807,9 +7791,10 @@ unsigned int selinux_maxnsdepth = CONFIG_SECURITY_SELINUX_MAXNSDEPTH;
 
 static atomic_t selinux_nsnum = ATOMIC_INIT(0);
 
-int selinux_state_create(struct selinux_state *parent,
-			 struct selinux_state **state)
+int selinux_state_create(const struct cred *cred)
 {
+	struct task_security_struct *tsec = selinux_cred(cred);
+	struct selinux_state *parent = tsec->state;
 	struct selinux_state *newstate;
 	int rc;
 
@@ -7834,13 +7819,40 @@ int selinux_state_create(struct selinux_state *parent,
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
@@ -7869,16 +7881,35 @@ void __put_selinux_state(struct selinux_state *state)
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
index d8312a39a265..04325259c44f 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -117,8 +117,7 @@ struct selinux_state {
 extern struct selinux_state *init_selinux_state;
 
 extern unsigned int selinux_maxns, selinux_maxnsdepth;
-int selinux_state_create(struct selinux_state *parent,
-			 struct selinux_state **state);
+int selinux_state_create(const struct cred *cred);
 void __put_selinux_state(struct selinux_state *state);
 
 void selinux_policy_free(struct selinux_policy *policy);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 06e2aeb478cd..3c2e828e0967 100644
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
2.50.1

