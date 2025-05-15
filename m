Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2B429A310
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314657; cv=none; b=lA84tvFtEWw3Xy4wE34YtJfDJZupX6R6Xt62qnpYcRlkvaOLXyghlzF/6Hk7xD+2cqUzjjUAvhsqHZApHa3JmLIcGeZcq6IKHomuiF2IqXhq1IN4fOsnEKCD9yRukww/+Tgq6XH7F83K560vc3OHGa8DuuhdGvePddp3a2buYuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314657; c=relaxed/simple;
	bh=WTli0TQCgjWfZKvf8KuIXjBctjdH2VHO6iIbNsgmRh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHisI1DFfQkvrtRbTO50GL2ywYVDlevBNLu1c7dn2FAsJPOENmTadnp4lBJF1LSsqutJ/ghpNeTHWhq8jfb6B8F1xu39SxUbOTYzITEcyQ53yBGR9M1VeM1gDiBTPjgxLxSE81QIO99v8BqQRDO+qiLb9KKFsg/+0VNIF14Omj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dctr+n/O; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dctr+n/O"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47692b9d059so14049111cf.3
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314654; x=1747919454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS0DfjtNCbe1tv4oFgshB3OH9dMZ1nFojoebqqW8c8E=;
        b=Dctr+n/Ol33r28ID9kPT81YsFzQnty2VW/DrwwIuUwrCJjRz9bIhivPEdB4aZ3aaz1
         uAUjkkP/k5AZmVKOpqBnamh0YlZhHXFyvhPxKVaCqYpGo015giAlrILfRsa73dqrTw4T
         Kv3uMWhu4/xrORSWaUwRnkw/czVqHkSwu7vZJdPHETU/ggvlEfAyUv8ZJxJaWNosloPY
         nIes0YPNORwzPR5L7ydIvbJ3SdEjY+s3xASzxLyS9iHfgSm53IerC88G7mVPtzy0GAzl
         qwNjVM7Z6dAbci1OVYXnP0KElgTEsxrHfiBv/dEnKidtPVKxxKWpZwkcCzkmrB1/MI06
         au1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314654; x=1747919454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nS0DfjtNCbe1tv4oFgshB3OH9dMZ1nFojoebqqW8c8E=;
        b=K4xSlklHyv3zfb9eOWjgOvR0Ma3NDXNC5hl7L3pAVzaA9pGi84JoaMinkVXGLKMfUu
         5aKcSaDh+ueDThdXfhGtlWx8oEgyLQTljjYXtVSDyHl1k2V//oo0N1l4/ZJj8FPQCWPH
         Y0CvIpo63YzPR71a2VkbGdEIoWjkQVK1rlGtf7YBCmRep7Id07y4N63rhqw7KoEaHdPA
         9KD713CS01zRG1kxKtT4l0JDNPl+PIiN5OxOefgEnT0XrC17KeTMS01yKZKhs9sIHOoc
         AkaR2T+LTVYDOohpOIWpoXiP3uDVHRf1Xh+vMFi3a7mvlTe5AsdciAhPhX3eQHlSueji
         MLXw==
X-Gm-Message-State: AOJu0YwldeKJdgePuQ+tBxpdwkLezJBKd7KNtYheMYsuMIznotauFy+0
	GE7UnD1YWudEmduwFrcyTZZfblwEyJrxtn7ekpSm3kTNF33daLQxqiNjfw==
X-Gm-Gg: ASbGnctS1FhgiUgGC2wfoX5NzeKAz5VetKbWTLY0MxgNJQcZF+f2ppi7llAb4cMtZQn
	lb/3PR/I440nC+saGrAWdaYlkd3t2Gh7Z2fUSK6gVT03ST/9pM/KSGPQrni6A1CjUZQP6cpQjD2
	687CHDYB4v1R5vMcrJULNlMsMU0URTuTR28qj4FUaFLASdblSNrVUHgKebLdIkZek/qPFb1foOA
	3A5tKWReBwfonAzAKqY09frEApmylaGwLd2FcqUuBTNqgHl1ZGKjwJtqbCZpdGZQj7x2C2LUGXy
	6d7BkPMqXmx+kqi06A0sRlemG/x84IAkq6Ms/jK0RjlOBUw2aqhV+TmaplcfnUQC6NyKjXnLiLw
	vjIPg2171kIZ/VxXAN1toDj/F2Q5tA5nhjTlVoeBQktqOAZlgILvKRg==
X-Google-Smtp-Source: AGHT+IEf/wU0BXpbV41n62o2XNmrP+zregdVdTe942qP/yGmbzI3XjwoGkYmpZ4W033rDkP+l7M/7Q==
X-Received: by 2002:a05:622a:22a7:b0:476:b7cf:4d42 with SMTP id d75a77b69052e-494a33a996cmr49331321cf.27.1747314643642;
        Thu, 15 May 2025 06:10:43 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:43 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 33/49] selinux: refactor selinux_state_create()
Date: Thu, 15 May 2025 09:09:31 -0400
Message-ID: <20250515130947.52806-34-stephen.smalley.work@gmail.com>
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

Refactor selinux_state_create() to be more like create_user_ns()
after which it was originally modeled. In particular, pass in
a single cred argument and update the cred SELinux blob with
the new state. This makes the reference counting situation
clearer with regard to the old state / parent reference and
simplifies the callers.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            | 81 ++++++++++++++++++++---------
 security/selinux/include/security.h |  3 +-
 security/selinux/selinuxfs.c        | 11 +---
 3 files changed, 57 insertions(+), 38 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d9ec8add75e3..a5f2e089d33d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -205,22 +205,6 @@ static int selinux_lsm_notifier_avc_callback(u32 event)
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
@@ -7779,10 +7763,11 @@ unsigned int selinux_maxnsdepth = CONFIG_SECURITY_SELINUX_MAXNSDEPTH;
 
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
 
@@ -7809,14 +7794,40 @@ int selinux_state_create(struct selinux_state *parent,
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
@@ -7845,21 +7856,39 @@ void __put_selinux_state(struct selinux_state *state)
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
+	tsec->osid = tsec->sid = tsec->avdcache.sid = SECINITSID_KERNEL;
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
index 7ade0f7532d8..adcd0b04e3a7 100644
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
index 9b537de75480..259502f4059f 100644
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
-		tsec->osid = tsec->sid = SECINITSID_INIT;
-		tsec->exec_sid = tsec->create_sid = tsec->keycreate_sid =
-			tsec->sockcreate_sid = SECSID_NULL;
-		if (tsec->parent_cred)
-			put_cred(tsec->parent_cred);
-		tsec->parent_cred = get_current_cred();
 		commit_creds(cred);
 	}
 
-- 
2.49.0

