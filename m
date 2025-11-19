Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA21F8722
	for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 02:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763517831; cv=none; b=fGAPj3MhJqEEz2BYagAu0sEC1u6bQD0hbzMLoyPn4922XtEiNkZ0y0mtUcrWYq/rf48Xv3l/yMEV67hUX9nZFXhSPs4OVgCnEGtDhrEBOQyDrsdu2LKGn6jVDFQNsw9sXFiTFE7WEFXPbrjp3xig8XMgZMbTSKsxG/8fTFO4iEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763517831; c=relaxed/simple;
	bh=Xjum6/v6VxY/UuQSo0f6xmN205wPmNxgXARxMns2WME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+Htz1Dfr+16nvLPDDMKoYogFLz83RTAudmryGODeJwz1PIC/Eg5JDVmPq6bQqlE1IpvMGve/mFk9WoG1cT3zwNWaNJ51hmkpnPVLRKdqfCeXnP4iNn6mmO66mT8avFsIwlpksv4SqJ8yhabSzUhVEAAcXEB1/fUY9DpvIpQunc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MgqEYIIX; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MgqEYIIX"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2d56eaaceso386528285a.0
        for <selinux@vger.kernel.org>; Tue, 18 Nov 2025 18:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763517827; x=1764122627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7HVphHBoMcIA9qVvqvlec6Va7fJVaQcHOXGpPqASus=;
        b=MgqEYIIX1e4HCjWYHBu8gjubxt252qPuZiOA6DqI6jSTW8mbxBRECwd7cA74dU/GjC
         WBaC3idZYbagwsnwu5fzPAsN6dsnd6jF3FnWGYFoCEPzCVioYDvgRdXmGHEW81gx9LhG
         4t0erLxb0ryfJM1iQ2vGKX7TPEgqHk/otWOU7a9B0rWFERyzzJGJdzn1mzu50Z4KABnC
         2viqklDq2vGZrJV6WoHB8Xsw+XYwzpMUs+WVIAShkKN5CHkfcF/NwobUTIhCgUJfyb8W
         95MqD5POEJ9XvvQPvqwOksQ6McEbN59Ojf4nya0iyijyYK2b2BgoVqQRIZvacDj8UM6b
         Be4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763517827; x=1764122627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s7HVphHBoMcIA9qVvqvlec6Va7fJVaQcHOXGpPqASus=;
        b=UN57ydajcF01BIFWY8/frXwa9tGzTS9+x6Xcue9XLalHzoVWYAYsMrb1I7bVmT/IwL
         FMmzz3P6O76QD2wh4yNqdEVS/YK/5Tr1Vj1FfsN1dWPqFj9z9YNp5h0yHAM9/dabTYP+
         Fx3GcYu111Mcyzg3UYihHiEkjLkIy0yDcP+WvROQSs36iuuZ2+mQmiLbyzEIrNnQdrGF
         Pe25E311fLmZITaBdZW7zo7xNjM8RQXmjXF9xky5PqDfScZGa+TtY/d2vDnxWLMpsTCG
         It7gPIEWP/mhEZUn5FvdOs4ovN/ZQD4TKEmJWb4EA73ZPhDdWcxvwIpGiNeLjfBJMAiz
         DlSA==
X-Gm-Message-State: AOJu0YzbXIRTDVdz3Uk0gP62RZauSIsLe/EXHw2WuL9Jcvjdua6lB2lS
	Jz7Iy0br0n37cG0D3N7eSipHSzeeC3mgAII/sg5j6ZTOXNuMOt1aSnsC93mVCmOBVkpN1Ynpe4K
	MuDE=
X-Gm-Gg: ASbGncvp6XpiyUd+/BR2T2JxybcYtMQSnlQcf8hNfbS+LmCnuVO3tb6CybPRaDKkZCZ
	wHm3XCCkgOVnjTNUFYAP47bekZTv9kmIjgtTV+hmgtsuFheaetHG0JIW+tTy7Rff1+DOerrD/or
	dw2txs7Vqd97pfsEpE8KLSJyqIbVh7+/PPJNwusBLBtxhOuAhrRgAPDH/ToB+X3EEYnZgJwV6SM
	sGC3tEVocU/LJyKrgip2aU+5X15VAZW7FDawjodPUk9jSScFbJVOL+/LSfx1vNHokIESKgURmv3
	dm5UOzE75aOxzUsP8n3c9bnglM3zCFWi2R/ZQa2+egEJcb0oPJ1zUcTUcRR/kIWknZXkjNi4oEI
	VXCfFkRRnAWtXCwAjPzvp7/dsnmM5yeocqH4MpGZ2e2MaiWIo5TJHXUPRUErZmuZatAYiJ3CGL4
	9p1o+hlWltakLkveYkIibr3M8Q1X3kedi471l/SwZ7/FfM705Ok3XZAnyH4z9J9hLLxtE=
X-Google-Smtp-Source: AGHT+IGoeXNkYvLzCoZsQnvGl6gO59Z6ezNhuCugy5R0bPJhXpMSTUl67HDMVVSCu1uZv+Mht7dYwg==
X-Received: by 2002:a05:620a:28cc:b0:8a2:3be9:1d79 with SMTP id af79cd13be357-8b316f00e04mr204512185a.18.1763517827337;
        Tue, 18 Nov 2025 18:03:47 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aeeb2522sm1306352285a.23.2025.11.18.18.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 18:03:46 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/3] selinux: move avdcache to per-task security struct
Date: Tue, 18 Nov 2025 21:03:36 -0500
Message-ID: <20251119020334.521449-5-paul@paul-moore.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251119020334.521449-4-paul@paul-moore.com>
References: <20251119020334.521449-4-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6804; i=paul@paul-moore.com; h=from:subject; bh=sXZcG355+j9dAjIgr25SPvQen4GSFIX0RiFM/l20ODM=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBpHSV6BvCzpuWd9fqZUjdY7W2pL+SSO3YSW2l3S 2rrvLIGG32JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaR0legAKCRDqIPLalzeJ c07KEADG3R7R5GV3FAg4Ulk1/xbtHZPVibI8pMvkq8CnbrchrECsnvSaMVy1byPpzlY3b9sEc5O Nvbxm0RFX2ryk0+xG96kgl0JyObJqPXBWlsf3eT9yojcRQrhRDrFSnEG/iv3ebsAUMJ9Z8in+59 Q3dF8rlskgdnLWQfJXNHwlVNRKv3geavB16KwDoERkg+7yECA20mLebcm0C0Xp4cF3d6LO9pZxK C7R1R9CzZndV+9aLKbLbOCb0uD4NeW4NkMF6yGPmY930FnG/H8Bor9ZRVjNpSyqwODLaVfFJx7Q onLKULuxAyuBiJpGUI3Wn54+RCywxAGUFSgDHPVvPOjTUX9lwZgjxnP3bmQzNgnf0DF+MNR1PV2 ZNJ97sOi/LOqODSl1Qqwa7KrcRuj9SN8ot16h1un00oPyZQVI+k+XzIvNltsdALCJWtQ85u/PM2 14R6d3i0dGYrzlxaUOU5azd4oascFmzRSj3Zedr4zBaDyskzRhchRCSCf0ZvE+VwCOPki0s39iM hrgdj/Cy72SPWPrh8Pmdsz7iyQc8zu+5ZZjAikhBpYLw5QEj8bsAtZ7bA45ozbihP6gRBGuXBzQ rUDUjYV5GmwrbZKsJo4DiaZhIQ+8vW6njHCCpgRh90r3IWUx+F9vGb7/khnUbvmyIYwf7FSwd5a 5RWT/Ra17lPoQCg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

From: Stephen Smalley <stephen.smalley.work@gmail.com>

The avdcache is meant to be per-task; move it to a new
task_security_struct that is duplicated per-task.

Cc: stable@vger.kernel.org
Fixes: 5d7ddc59b3d89b724a5aa8f30d0db94ff8d2d93f ("selinux: reduce path walk overhead")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c          | 31 ++++++++++++++++++-------------
 security/selinux/include/objsec.h | 13 +++++++++++--
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0890e7ee84c9..0ac4b05eb56c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -215,7 +215,7 @@ static void cred_init_security(void)
 	/* NOTE: the lsm framework zeros out the buffer on allocation */
 
 	tsec = selinux_cred(unrcu_pointer(current->real_cred));
-	tsec->osid = tsec->sid = tsec->avdcache.sid = SECINITSID_KERNEL;
+	tsec->osid = tsec->sid = SECINITSID_KERNEL;
 }
 
 /*
@@ -3110,10 +3110,10 @@ static noinline int audit_inode_permission(struct inode *inode,
  * Clear the task's AVD cache in @tsec and reset it to the current policy's
  * and task's info.
  */
-static inline void task_avdcache_reset(struct cred_security_struct *tsec)
+static inline void task_avdcache_reset(struct task_security_struct *tsec)
 {
 	memset(&tsec->avdcache.dir, 0, sizeof(tsec->avdcache.dir));
-	tsec->avdcache.sid = tsec->sid;
+	tsec->avdcache.sid = current_sid();
 	tsec->avdcache.seqno = avc_policy_seqno();
 	tsec->avdcache.dir_spot = TSEC_AVDC_DIR_SIZE - 1;
 }
@@ -3127,7 +3127,7 @@ static inline void task_avdcache_reset(struct cred_security_struct *tsec)
  * Search @tsec for a AVD cache entry that matches @isec and return it to the
  * caller via @avdc.  Returns 0 if a match is found, negative values otherwise.
  */
-static inline int task_avdcache_search(struct cred_security_struct *tsec,
+static inline int task_avdcache_search(struct task_security_struct *tsec,
 				       struct inode_security_struct *isec,
 				       struct avdc_entry **avdc)
 {
@@ -3137,7 +3137,7 @@ static inline int task_avdcache_search(struct cred_security_struct *tsec,
 	if (isec->sclass != SECCLASS_DIR)
 		return -ENOENT;
 
-	if (unlikely(tsec->sid != tsec->avdcache.sid ||
+	if (unlikely(current_sid() != tsec->avdcache.sid ||
 		     tsec->avdcache.seqno != avc_policy_seqno())) {
 		task_avdcache_reset(tsec);
 		return -ENOENT;
@@ -3167,7 +3167,7 @@ static inline int task_avdcache_search(struct cred_security_struct *tsec,
  * Update the AVD cache in @tsec with the @avdc and @audited info associated
  * with @isec.
  */
-static inline void task_avdcache_update(struct cred_security_struct *tsec,
+static inline void task_avdcache_update(struct task_security_struct *tsec,
 					struct inode_security_struct *isec,
 					struct av_decision *avd,
 					u32 audited)
@@ -3201,7 +3201,8 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 {
 	int mask;
 	u32 perms;
-	struct cred_security_struct *tsec;
+	u32 sid = current_sid();
+	struct task_security_struct *tsec;
 	struct inode_security_struct *isec;
 	struct avdc_entry *avdc;
 	int rc, rc2;
@@ -3213,8 +3214,8 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 	if (!mask)
 		return 0;
 
-	tsec = selinux_cred(current_cred());
-	if (task_avdcache_permnoaudit(tsec))
+	tsec = selinux_task(current);
+	if (task_avdcache_permnoaudit(tsec, sid))
 		return 0;
 
 	isec = inode_security_rcu(inode, requested & MAY_NOT_BLOCK);
@@ -3234,7 +3235,7 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 		struct av_decision avd;
 
 		/* Cache miss. */
-		rc = avc_has_perm_noaudit(tsec->sid, isec->sid, isec->sclass,
+		rc = avc_has_perm_noaudit(sid, isec->sid, isec->sclass,
 					  perms, 0, &avd);
 		audited = avc_audit_required(perms, &avd, rc,
 			(requested & MAY_ACCESS) ? FILE__AUDIT_ACCESS : 0,
@@ -3283,11 +3284,11 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 static int selinux_inode_getattr(const struct path *path)
 {
-	struct cred_security_struct *tsec;
+	struct task_security_struct *tsec;
 
-	tsec = selinux_cred(current_cred());
+	tsec = selinux_task(current);
 
-	if (task_avdcache_permnoaudit(tsec))
+	if (task_avdcache_permnoaudit(tsec, current_sid()))
 		return 0;
 
 	return path_has_perm(current_cred(), path, FILE__GETATTR);
@@ -4151,7 +4152,10 @@ static int selinux_task_alloc(struct task_struct *task,
 			      u64 clone_flags)
 {
 	u32 sid = current_sid();
+	struct task_security_struct *old_tsec = selinux_task(current);
+	struct task_security_struct *new_tsec = selinux_task(task);
 
+	*new_tsec = *old_tsec;
 	return avc_has_perm(sid, sid, SECCLASS_PROCESS, PROCESS__FORK, NULL);
 }
 
@@ -7138,6 +7142,7 @@ static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *att
 
 struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_cred = sizeof(struct cred_security_struct),
+	.lbs_task = sizeof(struct task_security_struct),
 	.lbs_file = sizeof(struct file_security_struct),
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index e71ce352bc97..6cc5104fd2f2 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -44,6 +44,9 @@ struct cred_security_struct {
 	u32 create_sid; /* fscreate SID */
 	u32 keycreate_sid; /* keycreate SID */
 	u32 sockcreate_sid; /* fscreate SID */
+} __randomize_layout;
+
+struct task_security_struct {
 #define TSEC_AVDC_DIR_SIZE (1 << 2)
 	struct {
 		u32 sid; /* current SID for cached entries */
@@ -54,10 +57,11 @@ struct cred_security_struct {
 	} avdcache;
 } __randomize_layout;
 
-static inline bool task_avdcache_permnoaudit(struct cred_security_struct *tsec)
+static inline bool task_avdcache_permnoaudit(struct task_security_struct *tsec,
+					     u32 sid)
 {
 	return (tsec->avdcache.permissive_neveraudit &&
-		tsec->sid == tsec->avdcache.sid &&
+		sid == tsec->avdcache.sid &&
 		tsec->avdcache.seqno == avc_policy_seqno());
 }
 
@@ -177,6 +181,11 @@ static inline struct cred_security_struct *selinux_cred(const struct cred *cred)
 	return cred->security + selinux_blob_sizes.lbs_cred;
 }
 
+static inline struct task_security_struct *selinux_task(const struct task_struct *task)
+{
+	return task->security + selinux_blob_sizes.lbs_task;
+}
+
 static inline struct file_security_struct *selinux_file(const struct file *file)
 {
 	return file->f_security + selinux_blob_sizes.lbs_file;
-- 
2.52.0

