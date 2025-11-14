Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE77344041
	for <selinux@vger.kernel.org>; Fri, 14 Nov 2025 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763142339; cv=none; b=Zjt+AaVHkgCXa0/lJhXsXC7nXddhaQoECn9Sb53hszl3vDTrgf+cXaoQVgD14VmT3fugtoQxbSz/rSxiGFn5Wp/N/MriCnzQ0QqRyHNTGj4gxcSC2EZLxqUOIlS0n/Y0dnvOlRs9HMlK2mC0JLd9iZ3iNVz3BPFppwvYRrUIogU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763142339; c=relaxed/simple;
	bh=olsH7r73BZYAeMzhCSwC6GjhVxhddiiiLSfdRvXsi7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GcYnzVcabohQ6k5H7f4GPR34JRqFQJ/POcoW5xtdfZz5NZBaGCPnDwHkyV4DJC/HKAQMwiXizEASebK9X+vE51edj7P2g5zSNybal/HIyD30APu7SS63UiVSEcWYLqZJ2NQixty1I1Pv5LjBqMHgxe83TMbY9k89llP0imv/iGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzvkX5Ox; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzvkX5Ox"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b26b12be9eso235545485a.1
        for <selinux@vger.kernel.org>; Fri, 14 Nov 2025 09:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763142336; x=1763747136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mSc7SaGHmoqG6R8VvRRXHzMEnKuygPWX/FGkf902pMU=;
        b=dzvkX5OxvUCc72VZ/NJtrDCHCQ2wjbN3wSvJWLSuWGG79moeXWxA3vFqkl5VmGe+RT
         U2BQm7v9KzSOg8VITWxyc/vovxFI5WXzSJVjth+WA5DiyOJxnIkmW1BR7c9JfUCj2GTT
         PA088NqGm1wXGt1a1slbrwxuLbkRoGGcXZIMKmzcWs6fq03V0HSXBMprSWlvIzSclkaN
         HplmmZTSm4zbGSII3G8MaaxnWjnPyufq1yYf1352rsbrJCc4IBcX9MwJhvb3mrEt7YHZ
         h6fWAYcc83hFmV0o/ATedjG6VVXVPuZUbL1qa3+65kb8k9XuSAE+yrbImb9PjP+lhk1b
         eyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763142336; x=1763747136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSc7SaGHmoqG6R8VvRRXHzMEnKuygPWX/FGkf902pMU=;
        b=ZRDZC4aQmkj/XkGHLvhn9jd5G170FqkzkJRvdKDW7ohCsZ+eG7Qe23e4ldwOUS2Oct
         YtxJp7WvlzQ0gnlXHPkBuiIOLHtPzX1lPSq2eqqca/v6E/bjqAgQFXR2aRpcOeUNIaYf
         5fLv0JYX26WUoiCRFTEBAdEb5yauRzlyO/P0et5ZJShSMHYzwO8RIF8+PbHcJmhJ1+Kp
         rOCaHqmtWd0PBgwPzNdsNrlI4AY8ILOgu0vdDpFnitotaTGpjRFdTDIvWtD982rLEVu0
         ZMOS2O8SzJnnxmsxFY1E8zjqkXsvwAAx2DnNX4g+j4GVrEpyLrRJTvVTSUjl2NA5Khdj
         8IKA==
X-Gm-Message-State: AOJu0YzNwU82LK0SBRVWrePTStKXAFb9dfTpjn4Rz2cGjTh1/OjLidyo
	wqkjA1Znm8bofRINzHLxwRES9n9lEqojllWOPC2PUE9PRsbjPu7lcZVLghBS3A==
X-Gm-Gg: ASbGncu0iaLk3miO934m2a6n5mBcYZiT1qmuMSfJqaRIBqpn4aS4Su4IVC78+oVbGze
	85+v/uyIFgdv8hnMDALom4OHVNYGRqNAa44CD84sIGd1Cm8kuPfZYxuIQEvq4Olmgh8t6K1wHc4
	aFtZUukKgbiFmY2GxAOPoD3fKd1wieNkf3AA6geCq/oIrR/jBY5rCzpAPAiQLtahwGmozjT2wQx
	49jnnY7NOgBUfGFsSygtmHj9E617gtrL49alJdx0E3Z30BwuiLidLNT/S0lLX9fJKs3Wne7RR6a
	7H22HPG9yCWVcVMoPlh50Kqf28szHSHqlBVt9tRKXh49ojeLz/Dm9qmtgG3VJkrXy6fYP7soyWi
	C8eVIqG3YfsgmyXlMqSJSR9NWQuNoo+84irDZmO67Pb9zgC8IPj8vGhVjp4h/HUWT0rPClZbs1b
	f1Lkq1ZVd47X86w7KvQ/8EpS5uMv6g94XYR1YaH4w8lWZ2vv4hEKhhmDqNWIvDfKZpzUlAG+Kmu
	5P3Oe8EN+udOlPXNStqBfOvr94i6wmJ
X-Google-Smtp-Source: AGHT+IF49vdycIIwWCfUjwsDMh0nG+GzKDios6DYJzxBKuEuRnFUyFX8B/khmQrhZR21C/2z/v8Exg==
X-Received: by 2002:a05:620a:4115:b0:8b2:9765:3a66 with SMTP id af79cd13be357-8b2c3164969mr549702585a.21.1763142336335;
        Fri, 14 Nov 2025 09:45:36 -0800 (PST)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af04254csm370956185a.47.2025.11.14.09.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 09:45:35 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] selinux: move avdcache to per-task security blob
Date: Fri, 14 Nov 2025 12:45:12 -0500
Message-ID: <20251114174514.14695-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SELinux task_security_struct was originally per-task but later
migrated to per-cred when creds were first introduced to Linux. The
avdcache was meant to be per-task rather than per-cred; move it to a
new task_selinux_struct that is allocated per-task.

Fixes: 5d7ddc59b3d89b724a5aa8f30d0db94ff8d2d93f ("selinux: reduce path walk overhead")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c          | 35 +++++++++++++++++++------------
 security/selinux/include/objsec.h | 13 ++++++++++--
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a22b1920242f..0eea43e4a90c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -212,11 +212,15 @@ static int selinux_lsm_notifier_avc_callback(u32 event)
 static void cred_init_security(void)
 {
 	struct task_security_struct *tsec;
+	struct task_selinux_struct *tsel;
 
 	/* NOTE: the lsm framework zeros out the buffer on allocation */
 
 	tsec = selinux_cred(unrcu_pointer(current->real_cred));
-	tsec->osid = tsec->sid = tsec->avdcache.sid = SECINITSID_KERNEL;
+	tsec->osid = tsec->sid = SECINITSID_KERNEL;
+
+	tsel = selinux_task(current);
+	tsel->avdcache.sid = SECINITSID_KERNEL;
 }
 
 /*
@@ -3126,10 +3130,10 @@ static noinline int audit_inode_permission(struct inode *inode,
  * Clear the task's AVD cache in @tsec and reset it to the current policy's
  * and task's info.
  */
-static inline void task_avdcache_reset(struct task_security_struct *tsec)
+static inline void task_avdcache_reset(struct task_selinux_struct *tsec)
 {
 	memset(&tsec->avdcache.dir, 0, sizeof(tsec->avdcache.dir));
-	tsec->avdcache.sid = tsec->sid;
+	tsec->avdcache.sid = current_sid();
 	tsec->avdcache.seqno = avc_policy_seqno();
 	tsec->avdcache.dir_spot = TSEC_AVDC_DIR_SIZE - 1;
 }
@@ -3143,7 +3147,7 @@ static inline void task_avdcache_reset(struct task_security_struct *tsec)
  * Search @tsec for a AVD cache entry that matches @isec and return it to the
  * caller via @avdc.  Returns 0 if a match is found, negative values otherwise.
  */
-static inline int task_avdcache_search(struct task_security_struct *tsec,
+static inline int task_avdcache_search(struct task_selinux_struct *tsec,
 				       struct inode_security_struct *isec,
 				       struct avdc_entry **avdc)
 {
@@ -3153,7 +3157,7 @@ static inline int task_avdcache_search(struct task_security_struct *tsec,
 	if (isec->sclass != SECCLASS_DIR)
 		return -ENOENT;
 
-	if (unlikely(tsec->sid != tsec->avdcache.sid ||
+	if (unlikely(current_sid() != tsec->avdcache.sid ||
 		     tsec->avdcache.seqno != avc_policy_seqno())) {
 		task_avdcache_reset(tsec);
 		return -ENOENT;
@@ -3183,7 +3187,7 @@ static inline int task_avdcache_search(struct task_security_struct *tsec,
  * Update the AVD cache in @tsec with the @avdc and @audited info associated
  * with @isec.
  */
-static inline void task_avdcache_update(struct task_security_struct *tsec,
+static inline void task_avdcache_update(struct task_selinux_struct *tsec,
 					struct inode_security_struct *isec,
 					struct av_decision *avd,
 					u32 audited)
@@ -3217,7 +3221,8 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 {
 	int mask;
 	u32 perms;
-	struct task_security_struct *tsec;
+	u32 sid = current_sid();
+	struct task_selinux_struct *tsec;
 	struct inode_security_struct *isec;
 	struct avdc_entry *avdc;
 	int rc, rc2;
@@ -3229,8 +3234,8 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 	if (!mask)
 		return 0;
 
-	tsec = selinux_cred(current_cred());
-	if (task_avdcache_permnoaudit(tsec))
+	tsec = selinux_task(current);
+	if (task_avdcache_permnoaudit(tsec, sid))
 		return 0;
 
 	isec = inode_security_rcu(inode, requested & MAY_NOT_BLOCK);
@@ -3250,7 +3255,7 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 		struct av_decision avd;
 
 		/* Cache miss. */
-		rc = avc_has_perm_noaudit(tsec->sid, isec->sid, isec->sclass,
+		rc = avc_has_perm_noaudit(sid, isec->sid, isec->sclass,
 					  perms, 0, &avd);
 		audited = avc_audit_required(perms, &avd, rc,
 			(requested & MAY_ACCESS) ? FILE__AUDIT_ACCESS : 0,
@@ -3299,11 +3304,11 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 static int selinux_inode_getattr(const struct path *path)
 {
-	struct task_security_struct *tsec;
+	struct task_selinux_struct *tsec;
 
-	tsec = selinux_cred(current_cred());
+	tsec = selinux_task(current);
 
-	if (task_avdcache_permnoaudit(tsec))
+	if (task_avdcache_permnoaudit(tsec, current_sid()))
 		return 0;
 
 	return path_has_perm(current_cred(), path, FILE__GETATTR);
@@ -4167,7 +4172,10 @@ static int selinux_task_alloc(struct task_struct *task,
 			      u64 clone_flags)
 {
 	u32 sid = current_sid();
+	struct task_selinux_struct *old_tsec = selinux_task(current);
+	struct task_selinux_struct *new_tsec = selinux_task(task);
 
+	*new_tsec = *old_tsec;
 	return avc_has_perm(sid, sid, SECCLASS_PROCESS, PROCESS__FORK, NULL);
 }
 
@@ -7154,6 +7162,7 @@ static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *att
 
 struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_cred = sizeof(struct task_security_struct),
+	.lbs_task = sizeof(struct task_selinux_struct),
 	.lbs_file = sizeof(struct file_security_struct),
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 2d5139c6d45b..1ac35ae5332f 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -44,6 +44,9 @@ struct task_security_struct {
 	u32 create_sid; /* fscreate SID */
 	u32 keycreate_sid; /* keycreate SID */
 	u32 sockcreate_sid; /* fscreate SID */
+} __randomize_layout;
+
+struct task_selinux_struct {
 #define TSEC_AVDC_DIR_SIZE (1 << 2)
 	struct {
 		u32 sid; /* current SID for cached entries */
@@ -54,10 +57,11 @@ struct task_security_struct {
 	} avdcache;
 } __randomize_layout;
 
-static inline bool task_avdcache_permnoaudit(struct task_security_struct *tsec)
+static inline bool task_avdcache_permnoaudit(struct task_selinux_struct *tsec,
+					     u32 sid)
 {
 	return (tsec->avdcache.permissive_neveraudit &&
-		tsec->sid == tsec->avdcache.sid &&
+		sid == tsec->avdcache.sid &&
 		tsec->avdcache.seqno == avc_policy_seqno());
 }
 
@@ -177,6 +181,11 @@ static inline struct task_security_struct *selinux_cred(const struct cred *cred)
 	return cred->security + selinux_blob_sizes.lbs_cred;
 }
 
+static inline struct task_selinux_struct *selinux_task(const struct task_struct *task)
+{
+	return task->security + selinux_blob_sizes.lbs_task;
+}
+
 static inline struct file_security_struct *selinux_file(const struct file *file)
 {
 	return file->f_security + selinux_blob_sizes.lbs_file;
-- 
2.51.1

