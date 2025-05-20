Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884727BF7D;
	Tue, 20 May 2025 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742490; cv=none; b=JpzdZxPHYOQN9ADxQtq8r8TEd//PdXFNNOOYuDffG1yI76RX7Juu1ktD2yZmnFH37iBiLdD5GKxF7nFNJHfq9+jMmeaAyyRUlGpwsK9I+VyqA7/SDkKdrPYDSYSUTIUc14+boE6mT8803RNY7U2U7mu2TBXWVUxjILsZLbc61f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742490; c=relaxed/simple;
	bh=ugJbm0LZ4Jko/FnF/3BKs2TCpBOD1ZqILH3csP1QpkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmfxAn/3Xd8TPiLTCG+hEZTpkqmJpoUVRInOT3VodZrWcqHibMLGV5mUKOBTDFgBeLNY/B2e0W3roHLf6J/slxteFhM8sIrD9UPYRsklW0Rz7iusuW+EyqF8/F60gmqu11y/FYn7QF0ihxEJ+jJrg8lssw25tm48gLMF8lh+geg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hv9EXZd0; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv9EXZd0"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3feaedb39e9so1915084b6e.1;
        Tue, 20 May 2025 05:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742487; x=1748347287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUBDgqFoKlm94Ed491fmMqDILFMJ2tFqBe8fPzbswrU=;
        b=hv9EXZd0Zu3xrdQ0PIVZCzOVGQUHo6RhT+nu9XiLXI1gocLYa2tNhZ2vY6V0HUvVLC
         wmxMpDLA03NnNtXxgHsYqwxTY+PR5XSVIDSA3Xpfh56irRSyemGSwangZTHH5aeykBab
         eku92vqUNj0fjpRobqt6rAvltfDchJzIo8IFGIUu1G6GiCty7A5chhVDWyjwKrDvfnyB
         YAnnZ1h2CFyEBUhNpMzWXPNn5CvBeChhp54NbgANa/UfoDl01JEIcVzVKEwpmwp9zlKM
         y+xROtoZhoIYX+qoJZaVqvOFhvICYW/wPwnAqigx+Gffn51q8lnn7QFWqzX32iH+6HRb
         +EBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742487; x=1748347287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUBDgqFoKlm94Ed491fmMqDILFMJ2tFqBe8fPzbswrU=;
        b=ENoRn6qaOgSingUGbka7GKwebY5epM9RrtmTOh3LLkoKQmUObKmMp9sr74p1D1Q5qH
         ERY9KxYuzkHtTQL5pO/rwA5xqHswR/37D/Eh3Svym/9GBaS+6S2pdXZgeahrXwQI+wtY
         oWvauIPUPssWk2FT57LLYhVEQBZZRkSpsRFwFYRWMN3Y8RcGH3ud5GMwfXkt+OGZucTC
         mlYVBut9mha3tsuHMn0uhLIovHWfkbQyFXS93Bowq+mLBkwAzfIQtzhhbrmbLNbUuyFS
         JgOj46lnuDsIwu7QwF3ycfziWJJqD7bY1uEC4Qb0ihnO9rAK5PI2EilaoF71/8Azx1nk
         Z8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNYvydd2IfGzK70zuNtFfbDK/z1v+b/ChtAQP/AKnV2TzXfPJGrAOVaA5ZarDoH007dCAAr3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9wLOnuCElOMl3NO7p+UJ+wslrsYRX2f17W4P/XP0OsMnMdXo0
	pmmOJ0tg8W1HJiZ/vdbM4W3PWDok67y1mkcjlLk3BSsIQPZIMPy/mTGOgplu+g==
X-Gm-Gg: ASbGncv8QMxFzA5e823XBQxFLZU3l4Wz3DHUTguino84j5k5ZNJcxptFXcoQOKNsl77
	tjwYEICvKWw4Gx9maMbq8V7XpsqkYX32Sv1awWf/rjBM4INVXRtgzX61DphgdMt8H2Wgw4WiSGc
	sdgBCCwT5rHJoiYKAAxILpg5irJAN0hwhIu542DAg0RXXUqmJrGXcntlAHZcEDhM2kfu75eQ70u
	+7Lm4+hqGWm0ANOljYGx0pJJGTJWBmZOmHVzln1Zk7QxUeJuJgj7NghW0/3QaILCSskG6RLJFkr
	W91fRqMgzkjx7HMpChqP07DRs7OgetDgWvlHX5Qg4kMp9sof9b+VrRhiH7JHdZZWX9aYQHcp8bY
	lZoqtSawzNL83tsbx73BPphymy8EX3R7cVVqfzD7UOKKVdQ49egXggg==
X-Google-Smtp-Source: AGHT+IFl7fsbdxQOmz1AgsF4M859CUbd4IXXUUUyq3/OVMUlMO46Gca12uk/QOdrD34Z3paEyS/k8A==
X-Received: by 2002:a05:6870:596:b0:2c2:2e8e:2030 with SMTP id 586e51a60fabf-2e3c83767c8mr8350051fac.23.1747742486141;
        Tue, 20 May 2025 05:01:26 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:25 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 21/42] selinux: introduce cred_task_has_perm()
Date: Tue, 20 May 2025 07:59:19 -0400
Message-ID: <20250520120000.25501-23-stephen.smalley.work@gmail.com>
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
index cfd224e7551f..6142b39e0772 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2148,15 +2148,12 @@ static int selinux_binder_transfer_file(const struct cred *from,
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
@@ -2169,9 +2166,8 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
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
@@ -4430,23 +4426,20 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
 
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
@@ -4462,23 +4455,20 @@ static void selinux_task_getlsmprop_obj(struct task_struct *p,
 
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
@@ -4507,56 +4497,43 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
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
@@ -6736,14 +6713,14 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
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
index 833eec9b5fac..ce2d1b71e0a2 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -146,6 +146,10 @@ int avc_has_extended_perms(struct selinux_state *state, u32 ssid, u32 tsid,
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

