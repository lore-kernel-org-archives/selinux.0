Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA5245008;
	Tue, 10 Jun 2025 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576202; cv=none; b=Hw5Zm1icP6zDn5su0XSG/5jhYlzwEUoa9ZxU/HLku81+fRimp9uIJ34kfqFlJD+k/dnveQgNLiW4HJO9S2YVL/SXuWpcauBUPg/wzVNj5+n6ufy65eamFgML6OYpW18Up3EI3RI6fOm44dfcQPztZvS7L0GG50FuyryZ/ZP2exo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576202; c=relaxed/simple;
	bh=ke0eZPvQS2joolbP99KcRMzgkLFolEoKPcLkjtCfOqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeSDQ8IGhxJ0fakJOG6mFxNc3YVWdu1JuaOOXSEhL0T6MN6Qiw4B8I+INudir1X2MAqB9SgDr8LoEHc0MsinFfeN5zRDWLUlamBKvD1cZeqqJolcD3JXvx7YIMjOX/ouA/i97sGdNyOZ+MEyKesuc/lMA8l/2CrIU8ZSj5FxW/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQnbd4L4; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQnbd4L4"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7cadc92771dso498266085a.1;
        Tue, 10 Jun 2025 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576199; x=1750180999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAafEV1pVgjf2e35h3jMHcIwdh5sS8pvBqnOopP/ISo=;
        b=MQnbd4L4yAgv2896kq3gkxwWlE/TeQmHdGtNWkAAnB+vRZqHaYV/ZCO6mAQ9PDpn8a
         TbWI9kOKdfOoyL5k4x+LBzDWuQyYK/Q1ExPuJSau542Gw4lXQW7dsbTMHIoSSZfioqNA
         dAWn6FlrZiLs47xEQL6NpLgvJbvKVaiWk/4FaHTVN58/cRyFHW3RZQurtwvdQpZ9xlVN
         VmO0xwKL2TLtn8GE45RZ5gVSRb/UqJT4wkAXd+OSUnuVfcF3utO1/SAYZVjKlJz9wV+y
         v8PLYwQUyNxn08GmFHfomAwcbdEOkHLB+uYY1m7ewTlT9hiUxe7hX5+SxkZ4KJHpIPQK
         YazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576199; x=1750180999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAafEV1pVgjf2e35h3jMHcIwdh5sS8pvBqnOopP/ISo=;
        b=jEBiayHDbvkZitF33h/Q/lN4ddmqM2JwauURitPaP9wZNwl+A/Yy4VhVR1R8Gzet8y
         gaJg/0tIFXu6N3dd5d6g9TXzWEbXijyr6x8L4Kokb7PUQG2BOwfs6RBT1zplls/IANhM
         VLowAE+ALD4eG03nPxpn2f5OkrdA6iHQoXMVYgirPAoL6QiMbIKDnAxLFiWw59KIwlKJ
         r/I4CFfmPVhAldDo2eiLS8n8O8VoJga+PzGpZIRjvkWC72xISwnV9/+PlMgoNtnO03Io
         KEyuO8itU41D9S+6mKLPel5E5wOXYhGITRuKfftImNgE9jrxLESEamjp13fvpXg9ZNzm
         qArw==
X-Forwarded-Encrypted: i=1; AJvYcCXGL4UQl1PFBSbqAsMoAJ704DUw+48A0Q5Ln96felXXLC4pXBQtp1sWMTF6VRD8HFUX8gB7JJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02gN/H6uxFYBz3yd42rD1iNIaVun2H84J7NvJGkiLUrjgFnmm
	BDygB4CQ1z9rLhknt/XAsVpPBgKvv0yyLHvhy/IZ0zNH0Ek5Xdf1n17v11LxOw==
X-Gm-Gg: ASbGncub19TG1+KkGLvfAbm0fIGAFmKwcYN3cAy4O1BwbQPpAYTCl33iRZTrVpblKWG
	O3zQje/yiAyI5/xYvuY6kcNeswfRprAJjl0jXst6u/IFGCcH9D5XTbc+70osfTnDW4G0Kb53+1q
	AoiOTs9zyt/HkxiOJB6usb34CTyOq6HQu1Uwx40JAqQlYW/GblNdDWBMgbYCazN/FoGBvt7G+Zd
	wQwzm5XTsbcl+SA2rpz/tv7lPUCr6VmFckuIg8jNPkRmikzku0lrimpZWn6Vm4IcfzTskyBGLGi
	fldt8RVOjPug5posdCXihWfQJnAnfMvscy9VXdR+sOZ1lRpDjSFqUwkLDn0zeIhYSjp+TGcfrI1
	qjaT6bch8T1CL/WbIRJAqjYCfJ/5UK0uL9c943ZZkBScKUNMBbg/kyCMsVijsq6d1Jg==
X-Google-Smtp-Source: AGHT+IGHOi7gvwjkT1ouH6gv6M88paWR3QTGDtVb76jqt3s75dfe/bVsSZZqVPynK4zboewujjIpTQ==
X-Received: by 2002:a05:620a:2714:b0:7d3:a6c7:4eb2 with SMTP id af79cd13be357-7d3a88e0e1dmr29423885a.31.1749576199073;
        Tue, 10 Jun 2025 10:23:19 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:18 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 22/42] selinux: introduce cred_task_has_perm()
Date: Tue, 10 Jun 2025 13:21:53 -0400
Message-ID: <20250610172226.1470741-23-stephen.smalley.work@gmail.com>
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
index 1c511d3abac3..93df1d969547 100644
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
@@ -4436,23 +4432,20 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
 
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
@@ -4468,23 +4461,20 @@ static void selinux_task_getlsmprop_obj(struct task_struct *p,
 
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
@@ -4513,56 +4503,43 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
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
@@ -6706,14 +6683,14 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
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

