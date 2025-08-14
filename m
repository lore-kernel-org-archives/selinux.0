Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCF3305E2C;
	Thu, 14 Aug 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178049; cv=none; b=WGTOhqT3owGrLk+YTXuZ5rWySE9xctPhx+R25Mjuh5w+07ZJFqyhb9zwTL5odu3diiL5aCpeYeDRgu1oyn8zkgKsOSoUDkuxQZ0HPdn5oewCaWro+wsznvPAXYRZWGi2NOXeSMToumz7weZ5DdgGw38FM6NLgBypcPRzWsY6p4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178049; c=relaxed/simple;
	bh=LbPeZLkK0I6obPL5JeAmX/2P+sTMwh2zVJPSZY1qOyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqA4jSdyhVCi3nmRoNZG7WS+e+QNQ4UGmcqOYh/tRlyq6OtPON2KG/Hb+qqgJbl1LR8aGNWtMMLPp/vPKminUtrPlEnXRspNMpeMFYIb4OSkb7leX13DI05UTjD4l4pPNEeuWRm8DA+Y97JQHn5fstTZXuXJsXwYULONmCDKxms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXoPBizx; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXoPBizx"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109c482c8so16953761cf.3;
        Thu, 14 Aug 2025 06:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178046; x=1755782846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJbxjJQb9s9D95zFwSJrm/EW5Wn/bNp/KYMNExt3hVM=;
        b=CXoPBizxOTRdpRk5rAcS8HjFvyZyGgtPd/CiQwB3XelsKUnNuhPk4XelGuPLdZVpj6
         Iisdefn7cHvhGfRZv9ev1ZCJA9qvesBoq0DGkRkk2eP4nRNM6HR3v4ViSmNlTom2XhG5
         M8Aa9H6KpDTcvpruXcBqXPp+/G2Nfm05YYP73XvBhj1qLESlSsi0gok3AhL2RemKWmHh
         naH8fzO6yWKe+jed1vcEKN6Fzh05n7ltxcypGbRFTpBYinasL9It0H1ywsp0vql3TPmp
         UHNdaG+M0q6FoPGWhh4HMAY+y4MOpotMhddumBoIWvosAsbjMbkIswxkgRnA8MJNY+1L
         RU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178046; x=1755782846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJbxjJQb9s9D95zFwSJrm/EW5Wn/bNp/KYMNExt3hVM=;
        b=fAropdY7/0LmWJFW6spDSxTcecnsYzv5A+5NiX0U4UWhMo9IKRvs0RGMcC7E98ehuC
         Qi3Fkv0aCnXS2j914I+kOMml6ylpFTO2LMIJYv4Kx71faxmEy+P8XlwSrzHm34OlTazu
         lJvrnEmOwz8Gbfx1FlL5hMfwDf04ur57C8pDHoX1FJusy1sz3BCIenuMwD9N780rtXHD
         y2IUxXsowHIr7U4GLAQbpOLX4a8/50OdscEl1AXbJYDg8ItdE5NkGElS0Hbd0MAwfkXr
         VmvJqUR9FIcsJzPcC5waw0kZsvmfvqHVfHXmJGteHnv+idA2P31G31rHGb+ydYyWZcwU
         9zow==
X-Forwarded-Encrypted: i=1; AJvYcCUb5oJxfdnUYjY3gUggVpAxzM6A60qRqyeBGR7hznd42koIZA80qwCaa9KbK2ud+pUw9MCPwow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxom2hcStQe4CHbnVpVkK9WU2TCFkI7LRjhbFQtxTYUnjLK9YLR
	Q4ZFvGY9u3OX4vfZeuDSCk/1GxcD9aZAoEotc0gMF1vX59b6wp5FBc4HE4+rKA==
X-Gm-Gg: ASbGncvUWImWTJEH1FzV0FJJpH4KaNcMXxAy+mFLbAVeWzQWAQ/GbwwAteu88deP9Mi
	/ux70Ja4OZgavEVpf5gX0vS0Wx4Byyu+kuZqCsYeBNy0vs/YlKf41EnJLw6NuBYGwijax4bc3ji
	m36/gYWDcaKbS17qp22NvN4Ebb40Zlnrbb07ReWRdNrq3w2idfyGDZxTqR2dMwC0g9r+sgM3Ueq
	q/DRkJJRr6ZcBTDqI7f97ULruIyMXKdPxj2/nd6AcmSsNOHbo72trmiVDArdXRtJ+0aniwcZ+P/
	afGBVa2jgDhZskI31rmGxF7VE8qDP1lQ16mh6D3s18mzvLhKz0/hydhf87bj4lJqfF30M9QeDkR
	abGBgVM/3sW/wXcKFCUM6aVr06DFRyiqjt39cOI759oS58lyD0SJjqr7YVWH6bC7Uql5r5gV3sB
	bY5PQEvGDc36FH5S4B4Fxpt+7iCXpP6DEkey1T
X-Google-Smtp-Source: AGHT+IFwcyg45//Axgy2wRy6sKvOxAg92dKsTsi1tii5LplIBw1G3bvUQpgIRanwJwE3vg3xifGbyQ==
X-Received: by 2002:a05:622a:2d5:b0:4b0:670b:f1cb with SMTP id d75a77b69052e-4b10aa82b7cmr44677071cf.23.1755178045667;
        Thu, 14 Aug 2025 06:27:25 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:25 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 22/42] selinux: introduce cred_task_has_perm()
Date: Thu, 14 Aug 2025 09:26:13 -0400
Message-ID: <20250814132637.1659-23-stephen.smalley.work@gmail.com>
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
index 056e597912ec..44caaead16aa 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1246,6 +1246,50 @@ int avc_has_perm(struct selinux_state *state, u32 ssid, u32 tsid, u16 tclass,
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
index 99a83acfa19e..d21b3d03cced 100644
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
@@ -4460,23 +4456,20 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
 
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
@@ -4492,23 +4485,20 @@ static void selinux_task_getlsmprop_obj(struct task_struct *p,
 
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
@@ -4537,56 +4527,43 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
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
@@ -6730,14 +6707,14 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
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
2.50.1

