Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F92EA744;
	Fri, 20 Jun 2025 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441542; cv=none; b=DkaWjMcjj+qczRqWD6LPOkDsVTMWHdGlAikGJhIi0z4Xdsf6JbIj5hO+3+Wznh6xstf0yQUeH933oTmtGMekSr7kczstKn9+xC9vZWVm9k33zMhu8mtU9y5+u92EaU/yIp5M6RlalX6pZ2xuK7JIX+lCACe56ZpCAOScIgIO6dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441542; c=relaxed/simple;
	bh=eQeuVGjDi7yhoOjhZ7QB4DLvF1oM3LqoHgUrobKnNK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdqXeRKX6XALi2es2oCea3r7fwHA3a8pyAYxooumRt4df7UObScoi3LprxKFxGTuiMVnjoO/axm8Ku2QFV7xUBBh9VsHhVi+JaQK0DcIPkWvFAiNQuJ8us16Xqa8jRXrD4AQEMf4Ss0ntjdMgjHHydk+baQWp1f0/nx/rLuRd28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dztM4u16; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dztM4u16"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fac7147cb8so38380806d6.1;
        Fri, 20 Jun 2025 10:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441538; x=1751046338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z06gh2Bz9rlFsSdsABMwYzrq/H0IbdM05gjIJs7wU1Y=;
        b=dztM4u16J1dA2fAsf6edbZ6pJoJmmAiv5sUukSyEq0X/j0UxgNLXGdG4DrZKqIQQIt
         YRHTCPtmMkEK6nkPRo8H2/Uu/RELgunF4JjIHe5NmRiubDIVrMH+NbPamTFyiF/426x8
         XRusPHHW6JXqX79Ls8mf1BffXMUM2WCqBtsjjcGGyUXzEzzyN/lrUiHawp7gAE+K5SNY
         dggwP9uAv8QdCGbJgQ0qSfx8XbmspcnOHSWwxVRtb6JSAJPL3wqaMMQi/U5+4VIy5rmF
         CFJCFgYHd05ysFJWyW9qW8tRGshkGUV2muaYyl/TKtD8nDpdImpMFRWmp4BfE4bXKYEW
         uQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441538; x=1751046338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z06gh2Bz9rlFsSdsABMwYzrq/H0IbdM05gjIJs7wU1Y=;
        b=QsW4MmnJilrvEFdqt6QeymB6rhoqiLN4fpYQ+6sLRKXPhzYL9VaoUEr/RQaZin0fkP
         JP6dpwWiiyj8iWjnyj1LxRpEHyu54liDdjHAhz85+yG2uOE6oBaLi11BWVNg330ePfSf
         C+7I192PKQVsA/iVy3WVkUWEVPgsXYL4RErfkUq0skJdtN5YP1sl3kA/2tNHNlNVAHke
         ToScl6908fBi7m3/ePoBgF+cIC8fYTNjARZSRfK+Iig0nT/0y70Jtgo3pumOxYOOxLlT
         cmDJIskl1B4MsCTnoF9fphrtok9QDITU3HpOCTXfnP0WkqhuMBL/EYj2IDutRSTavVFl
         nKiA==
X-Forwarded-Encrypted: i=1; AJvYcCUZfeld8j5Dx6hcoTX5Rkgef2nb9s0h/h0m9nFAAhnbfyJYzvRiVVl2iqtv2UYs3KzP06WcDIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKUMGvAueojCP1/n14XrGDB2SHkeyLwQLmTk3HvaljTI23XFtJ
	qY0DxygPOEEENhwgA7/sT4wUUhGbd50O9Cy9qqamKqup4RR+xSyhw1aILBrCUA==
X-Gm-Gg: ASbGncvYr7LK+707hbnm6hWuTqN/s7AMq4FRyt1sExKNpkJXeIWg9HkJyMYns1+xBZW
	EYeBwO5r2RJRurCxuP7DuwSdeLyeY25Y+n40Ap4nRLmRtOi55virdRKkM1C/WwuRw/wQ2V/iGer
	tcwgZmJKj4YmBeJ7+gGn4T26yeTRYGInljucG6bGtwgWt5eUFvb0SacGovV7Z40iqE43l7i4Po1
	FOlJLI1fmXlB4YovaXol8aYREjkU5wXln69vcUwPBh5uUc38uKzZ5we2fuXXYRl5QfeBK60N+oz
	nST4Zttn2bNPv3O8CeuhqafKw0Q7Yet4ktCGgeI6pvkHYysau8Ppbyepy0LNfaJyj2rVxgv4Q+G
	54tUCWlMKAhSYZIQ7Q8lDdWgbzN59TMs6gxFf1w5ttFXkrZlAJ0etQsOUvk8gOsbsOA==
X-Google-Smtp-Source: AGHT+IEIdLMZTvzo+2ezB2MnhXT6qAGguVTOv/IbVRE/uN8YIFPOb+VckGY1qtBoxEnEaiHtB/lS4A==
X-Received: by 2002:a05:6214:1242:b0:6fa:d976:1977 with SMTP id 6a1803df08f44-6fd0a59ab5cmr54829466d6.41.1750441537741;
        Fri, 20 Jun 2025 10:45:37 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:37 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 22/42] selinux: introduce cred_task_has_perm()
Date: Fri, 20 Jun 2025 13:44:34 -0400
Message-ID: <20250620174502.1838-23-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce cred_task_has_perm() for checking permissions between a cred
and a target task against not only the current SELinux namespace but all
ancestor namespaces too.

Convert existing cred-task permission checks in the SELinux hook
functions to use cred_task_has_perm() instead of calling avc_has_perm().

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         | 44 +++++++++++++++++
 security/selinux/hooks.c       | 89 +++++++++++++---------------------
 security/selinux/include/avc.h |  4 ++
 3 files changed, 81 insertions(+), 56 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 8db199f06a2a..577743a01c5a 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1247,6 +1247,50 @@ int avc_has_perm(struct selinux_state *state, u32 ssid, u32 tsid, u16 tclass,
 	return rc;
 }
 
+static u32 task_sid_obj_for_state(const struct task_struct *p,
+				  const struct selinux_state *state)
+{
+	const struct task_security_struct *tsec;
+	u32 sid;
+
+	rcu_read_lock();
+	tsec = selinux_cred(__task_cred(p));
+	while (tsec->state != state && tsec->parent_cred)
+		tsec = selinux_cred(tsec->parent_cred);
+	if (tsec->state == state)
+		sid = tsec->sid;
+	else
+		sid = SECINITSID_UNLABELED;
+	rcu_read_unlock();
+	return sid;
+}
+
+int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
+		       u16 tclass, u32 requested,
+		       struct common_audit_data *ad)
+{
+	struct task_security_struct *tsec;
+	struct selinux_state *state;
+	u32 ssid;
+	u32 tsid;
+	int rc;
+
+	do {
+		tsec = selinux_cred(cred);
+		ssid = tsec->sid;
+		state = tsec->state;
+		tsid = task_sid_obj_for_state(p, state);
+
+		rc = avc_has_perm(state, ssid, tsid, tclass, requested, ad);
+		if (rc)
+			return rc;
+
+		cred = tsec->parent_cred;
+	} while (cred);
+
+	return 0;
+}
+
 u32 avc_policy_seqno(struct selinux_state *state)
 {
 	return state->avc->avc_cache.latest_notif;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 78a43494fa0c..a068752368b4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2154,15 +2154,12 @@ static int selinux_binder_transfer_file(const struct cred *from,
 static int selinux_ptrace_access_check(struct task_struct *child,
 				       unsigned int mode)
 {
-	u32 sid = current_sid();
-	u32 csid = task_sid_obj(child);
-
 	if (mode & PTRACE_MODE_READ)
-		return avc_has_perm(current_selinux_state,
-				    sid, csid, SECCLASS_FILE, FILE__READ, NULL);
+		return cred_task_has_perm(current_cred(), child,
+					  SECCLASS_FILE, FILE__READ, NULL);
 
-	return avc_has_perm(current_selinux_state,
-			    sid, csid, SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
+	return cred_task_has_perm(current_cred(), child, SECCLASS_PROCESS,
+				  PROCESS__PTRACE, NULL);
 }
 
 static int selinux_ptrace_traceme(struct task_struct *parent)
@@ -2175,9 +2172,8 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
 static int selinux_capget(const struct task_struct *target, kernel_cap_t *effective,
 			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), task_sid_obj(target), SECCLASS_PROCESS,
-			    PROCESS__GETCAP, NULL);
+	return cred_task_has_perm(current_cred(), target, SECCLASS_PROCESS,
+				  PROCESS__GETCAP, NULL);
 }
 
 static int selinux_capset(struct cred *new, const struct cred *old,
@@ -4448,23 +4444,20 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
 
 static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
 {
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
-			    PROCESS__SETPGID, NULL);
+	return cred_task_has_perm(current_cred(), p, SECCLASS_PROCESS,
+				  PROCESS__SETPGID, NULL);
 }
 
 static int selinux_task_getpgid(struct task_struct *p)
 {
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
-			    PROCESS__GETPGID, NULL);
+	return cred_task_has_perm(current_cred(), p, SECCLASS_PROCESS,
+				  PROCESS__GETPGID, NULL);
 }
 
 static int selinux_task_getsid(struct task_struct *p)
 {
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
-			    PROCESS__GETSESSION, NULL);
+	return cred_task_has_perm(current_cred(), p, SECCLASS_PROCESS,
+				  PROCESS__GETSESSION, NULL);
 }
 
 static void selinux_current_getlsmprop_subj(struct lsm_prop *prop)
@@ -4480,23 +4473,20 @@ static void selinux_task_getlsmprop_obj(struct task_struct *p,
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
 {
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
-			    PROCESS__SETSCHED, NULL);
+	return cred_task_has_perm(current_cred(), p, SECCLASS_PROCESS,
+				  PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_setioprio(struct task_struct *p, int ioprio)
 {
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
-			    PROCESS__SETSCHED, NULL);
+	return cred_task_has_perm(current_cred(), p, SECCLASS_PROCESS,
+				  PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_getioprio(struct task_struct *p)
 {
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
-			    PROCESS__GETSCHED, NULL);
+	return cred_task_has_perm(current_cred(), p, SECCLASS_PROCESS,
+				  PROCESS__GETSCHED, NULL);
 }
 
 static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcred,
@@ -4525,56 +4515,43 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
 	   later be used as a safe reset point for the soft limit
 	   upon context transitions.  See selinux_bprm_committing_creds. */
 	if (old_rlim->rlim_max != new_rlim->rlim_max)
-		return avc_has_perm(current_selinux_state,
-				    current_sid(), task_sid_obj(p),
-				    SECCLASS_PROCESS, PROCESS__SETRLIMIT, NULL);
+		return cred_task_has_perm(current_cred(), p, SECCLASS_PROCESS,
+					  PROCESS__SETRLIMIT, NULL);
 
 	return 0;
 }
 
 static int selinux_task_setscheduler(struct task_struct *p)
 {
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
-			    PROCESS__SETSCHED, NULL);
+	return cred_task_has_perm(current_cred(), p, SECCLASS_PROCESS,
+				  PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_getscheduler(struct task_struct *p)
 {
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
-			    PROCESS__GETSCHED, NULL);
+	return cred_task_has_perm(current_cred(), p, SECCLASS_PROCESS,
+				  PROCESS__GETSCHED, NULL);
 }
 
 static int selinux_task_movememory(struct task_struct *p)
 {
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
-			    PROCESS__SETSCHED, NULL);
+	return cred_task_has_perm(current_cred(), p, SECCLASS_PROCESS,
+				  PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 				int sig, const struct cred *cred)
 {
-	struct selinux_state *state;
-	u32 secid;
 	u32 perm;
 
-	if (cred)
-		state = cred_selinux_state(cred);
-	else
-		state = current_selinux_state;
+	if (!cred)
+		cred = current_cred();
 
 	if (!sig)
 		perm = PROCESS__SIGNULL; /* null signal; existence test */
 	else
 		perm = signal_to_av(sig);
-	if (!cred)
-		secid = current_sid();
-	else
-		secid = cred_sid(cred);
-	return avc_has_perm(state, secid, task_sid_obj(p),
-			    SECCLASS_PROCESS, perm, NULL);
+	return cred_task_has_perm(cred, p, SECCLASS_PROCESS, perm, NULL);
 }
 
 static void selinux_task_to_inode(struct task_struct *p,
@@ -6718,14 +6695,14 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 	u32 len;
 
 	rcu_read_lock();
-	tsec = task_security(p);
 	if (p != current) {
-		error = avc_has_perm(current_selinux_state,
-				     current_sid(), tsec->sid,
-				     SECCLASS_PROCESS, PROCESS__GETATTR, NULL);
+		error = cred_task_has_perm(current_cred(), p,
+					   SECCLASS_PROCESS,
+					   PROCESS__GETATTR, NULL);
 		if (error)
 			goto err_unlock;
 	}
+	tsec = task_security(p);
 	switch (attr) {
 	case LSM_ATTR_CURRENT:
 		sid = tsec->sid;
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index f6a500e9d74d..5d79bb7c610c 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -150,6 +150,10 @@ int avc_has_extended_perms(struct selinux_state *state, u32 ssid, u32 tsid,
 			   u16 tclass, u32 requested, u8 driver, u8 base_perm,
 			   u8 perm, struct common_audit_data *ad);
 
+int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
+		       u16 tclass, u32 requested,
+		       struct common_audit_data *auditdata);
+
 u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
-- 
2.49.0

