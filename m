Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A57B3E1
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836347; cv=none; b=OgrUluj5R1XA6o0bbtaDveGCpLqk9QW5W+kSdPFPl/86QzYimAMwzrwcWAklC6z2Ddg0t8L5g2G3w44bQxJE1GFY3ZEagJeD7D4iQarfuosQBWqVxRyKW9v+MOaTT0JjRUbS39YdAM6cTrXb0wNdSXHwwJh/wKfS1bxtxbzDS88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836347; c=relaxed/simple;
	bh=KwpRHOUviaH4AiGAOCn1t9ffHK9VouigNcBVqx2O2HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uoqrirb9dNmTEtQOO5gghm5DW6N7qy+qWM8ICWnTAifx0Bmgyzoqb1nydMajLZe/AoMQ5FpmFmRVc+hPjvAVoF4IlYnGGVY1SnPXPSFJM6+m26mz4aLUiz6sXgWPowWUq9FaepUe411XKLz9b+JZ+oHAUkr7kZmmAAHh+7UYetI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jbtua4Zr; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jbtua4Zr"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467b086e0easo59349741cf.1
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836343; x=1736441143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UhssZCc2QQmkomt4jnH3pklSAzAm4l66a8xNIU+ZcI=;
        b=Jbtua4ZrEo1Xyofugd/a/oaYwqjck4JKzoyth2oivZ4Wk56S9jrQ/hg3R2QCQ4+JFZ
         Pxqkvvqz0SPljMtp271i/nrMSbgP3Z79cRrm7nA0HwoIBauS0MnpFXApYAUvYR7JW7OT
         sId5Q+x7hUCwgLrPlqZLqWeZ1yh+3FSPC01dRzocuy2ZDUh9oBhAgkPxFhWgXcFauYUl
         c+JBrZ+/rmxMex1kUzTzyvesIF+CPe9xY7IB6Od771CDD5wfvX9MdCv5QEDxLVyn6J7G
         uEN8ZDByYMe67i96Q/wfAiuqb4QpPfrCsHfCRI9ax6JXHjmuVHhIdXQmhCOYwu75pw54
         1WsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836343; x=1736441143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UhssZCc2QQmkomt4jnH3pklSAzAm4l66a8xNIU+ZcI=;
        b=QGjStvi9EZx2Tx8z73PB+EeUQ4iFmat3A+nB34orXpaPegeqe43lbPWpqCP408E5MA
         Xv1oxL4N/Ms4gwEoL3us1opgGeYChA/gxFe65123suOUaoc3urUHN7PID88RTYoMed7W
         59sGGol1B80K8Gq57Tf3pkVk/UAahaE78wRcmI/iYH5OMkue5pBzC6kM7vxpWY2u5vTt
         zoI5gHx7nBRwdjOG7/z1r6p02QunS9Z/VhU44+YnrQCekhq1wQy6gRFJCd+fNo+hPC+m
         mGaqz8bK1IvN30pzhRqDvFdqeSIyilYHNnSEizkrXjzjA31WdfIZSdRnlqfE93wZ+EMN
         QQqQ==
X-Gm-Message-State: AOJu0Yz5Q+R38ZQdVyh0ncAuda/UxoLa3AInHlYf7mtl5lSlWuGAkMWH
	L9w/XX8Q/9Ex1nIsJGt6VdjlYFvOMZl1K0eWIY/f8b6x3gwLEW10C2IkTw==
X-Gm-Gg: ASbGnctWF/69qBHywZF/kjqlqfCnA+2KD/2QzmWKAoAo4dEdjfizAJuS9B7IhGeUutm
	jgriyasnYb6HfKw4iAisqD4YwMX+H6IOnc9k7q/KVVziFEtZuVYqOIpfYP7aCrk/lgi2B2D1AP0
	FILaWioNhjJTvvg9mrQD/tP2qInZ+6CeIV0AsE8STeuwgd82/ryB7e0xU6cJ7z2x7+oVw+hkI+d
	7tkOmwo6PVKPXhC5F60pq/472KWLSvKphChIQ7K7KWaHX4N5hSYKaLKSi7QlCHRHRK5tWn9H7Bs
	KwYyhns7rhrU+rf3Pv3orSl3mp/Ue/XK8Ns/kKrv152DNpYdvdgnYmbFiTotyKKZ7FLCUw==
X-Google-Smtp-Source: AGHT+IGvio6JXwApI62myZ793TlORPuuofLf8R/19inAHK1X2jz/gip8MhyNwBwWxxv17drFNjRldQ==
X-Received: by 2002:a05:622a:594:b0:467:7f7e:57fa with SMTP id d75a77b69052e-46a4a8ee54amr661943591cf.33.1735836342916;
        Thu, 02 Jan 2025 08:45:42 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:42 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 13/44] selinux: introduce cred_task_has_perm()
Date: Thu,  2 Jan 2025 11:44:38 -0500
Message-Id: <20250102164509.25606-14-stephen.smalley.work@gmail.com>
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
index cc20c5d8b63a..bdd97f8bb571 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1233,6 +1233,50 @@ int avc_has_perm(struct selinux_state *state, u32 ssid, u32 tsid, u16 tclass,
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
index 6fffd0aa088c..c7aca5610402 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2144,15 +2144,12 @@ static int selinux_binder_transfer_file(const struct cred *from,
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
@@ -2165,9 +2162,8 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
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
@@ -4274,23 +4270,20 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
 
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
@@ -4306,23 +4299,20 @@ static void selinux_task_getlsmprop_obj(struct task_struct *p,
 
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
@@ -4351,56 +4341,43 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
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
index 9c6d9c5e727e..0a12ebe43632 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -144,6 +144,10 @@ int avc_has_extended_perms(struct selinux_state *state, u32 ssid, u32 tsid,
 			   u16 tclass, u32 requested, u8 driver, u8 perm,
 			   struct common_audit_data *ad);
 
+int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
+		       u16 tclass, u32 requested,
+		       struct common_audit_data *auditdata);
+
 u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
-- 
2.47.1

