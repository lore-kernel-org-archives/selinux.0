Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1DC299947
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314632; cv=none; b=VUKfrrjMOypzQtPyJgVtEEVTULMxhb9mWldhZ0KkPqBUDyEXjZGQ1Bwia9MO/iaLAMBXANcwQMGMRnVxfHdUbzaai8N1nXXtL8J3e5ljvjKa0KOeCaqypMrEx1nYVKo7JwaB+l4WKt1oTJelpRiRSKXCXHCMIQLLWg9VBQJFQYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314632; c=relaxed/simple;
	bh=rYkrMnFNPHIGua3LsE/vTevMXcjv9LSeV9y7xYqHpo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjM8Pe8fHbMbMlbz9Un5X39CTOmD7kcnMZkK5umjnEcjAsKdgLxW2ext8GQ6RYkVCxkMobvqwy5hGbICYO1nkeOfq3nzbF2lZGHgfBZtYs2rn+Yr23BcYB8K59JjscV+STctcytBLB47hhYTWRVkdwKKyCzeZc+LdchN2XO05ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwObHmjc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwObHmjc"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7caeeef95d4so84407685a.2
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314629; x=1747919429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCduqfLPbK1dTo9HoGsV3KlVMeOy01LR70JA+WrpqDg=;
        b=WwObHmjcxWk/9T3Grlrqi6Mkl90Q0/0n6sXUqeFwXyfHb+CQUEmN6v6XmD5lyGg5e+
         WjjhVVmlnnns6GjvrQ55QsGbaR0Zku73nspzEUXaElQ8B3FKLnMsy6QdNzgMH0ie/W3Y
         JjGUTxSDDm6aVp6kJTOysqjShSWN+1tGZanZWSHtKvjHuuk6yqj8DnYcdIzrwShx0IVI
         CFXs6WUSdkWziN1iq22vcym9AgauBwh6eEARIaTrPq1QkxOMYuu9Hzr8GiGh5Zlem1IQ
         H6b7wg9Ewr/1p0KnZRpldudxUhsi+DsOOLNE/SFAtnL4IIW1iSOCC4fQdYbjooCh/Xaz
         hLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314629; x=1747919429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCduqfLPbK1dTo9HoGsV3KlVMeOy01LR70JA+WrpqDg=;
        b=N152YiA0N/a1Wm9lOC+zdUMu0iNHJHgGSJQvNtVdNtM0IFyCh5Lo4xaB6cmmcH8SVq
         pftdZ7k7UKOEJ4uR7jUJWMyzbWFn4jzqOSUXkFyKxlz8jWUxju3cwKoU3JOmWtf4A6ye
         cN1YnwcSHJoWXrzg5nmhBaYVGxE0CcdvISEGtV6Bbf/oSBQKsBk32w8F0ISjBflCXYwX
         zwxQwhn+sNG88upIN7ryu2diMYvfC8gg1b6/EB6DLBEB4SAAjOCKz4LlOPyKqq7xK3/1
         QMsxLzkQAS8DFPBkFT63LCDb+zzO5nQqLJyEZ6ygSAqDxHOzn69yJyoJEfVSojS2H6JY
         3GbA==
X-Gm-Message-State: AOJu0Yw+vZliX9qdzdYEDVHOXF692PylI38l9/N2tN1xtOkNKI7s+Dcg
	6GPiVv5ubDRHYAttDFtO59o/mzOExnNphv+TraujbjkqzCWUHYwZ3YU5JA==
X-Gm-Gg: ASbGnctgF+yJlTVMRLRN748nxzvLZkUFZ18ZSQNW09SrB0cPGt70XdakdjLebVrsKGR
	6tTkGn8GFAIXMCrKM++kgD7Zv2npFD3MbfkEUJqMo0x1FBNqL9G2JG7bDoDwLlQNk9qUfJXLBFw
	CahDIZq9f5OnqIawLYQpsTDmLY7ptBmz72Q9oB6uV2RrnuUuIQUoR2AdwDvNaI8cFqi532+Tgdq
	95zabPC04GrCMlkng8XW8VCDD3YLjuBwtG917pJT0cRPXj7QnlQxzqJXahD4OUBMCPGZTmhsjXo
	dnuEWu2YLIPwDXJwU7iK/FSxG27M9tfjSU9yDeKaRsu57l4J5/BfdhYoKmic+gWy4O7z0rGNOuo
	qkXrs+rLmJKIck6Yjfgev6XhFN5AoXcmj7l1jOpnVtIfmQF1Do+VCkuUDL7hZd6ST
X-Google-Smtp-Source: AGHT+IFdOCbjmKHIKjWoody5UuLI7iMNofUhkPYQbKft6BjvYfzABXvMtPVRBlwpojqYLesb32a0gw==
X-Received: by 2002:ac8:65c9:0:b0:494:ac45:d214 with SMTP id d75a77b69052e-494ac45d86bmr5417391cf.37.1747314629103;
        Thu, 15 May 2025 06:10:29 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:28 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 13/49] selinux: introduce cred_task_has_perm()
Date: Thu, 15 May 2025 09:09:11 -0400
Message-ID: <20250515130947.52806-14-stephen.smalley.work@gmail.com>
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

Introduce cred_task_has_perm() for checking permissions between a cred
and a target task against not only the current SELinux namespace but all
ancestor namespaces too.

Convert existing cred-task permission checks in the SELinux hook
functions to use cred_task_has_perm() instead of calling avc_has_perm().

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         | 44 ++++++++++++++++++
 security/selinux/hooks.c       | 81 ++++++++++++----------------------
 security/selinux/include/avc.h |  4 ++
 3 files changed, 77 insertions(+), 52 deletions(-)

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
index 43b02696904c..2c9ee01eb408 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2161,15 +2161,12 @@ static int selinux_binder_transfer_file(const struct cred *from,
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
@@ -2182,9 +2179,8 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
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
@@ -4443,23 +4439,20 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
 
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
@@ -4475,23 +4468,20 @@ static void selinux_task_getlsmprop_obj(struct task_struct *p,
 
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
@@ -4520,56 +4510,43 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
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

