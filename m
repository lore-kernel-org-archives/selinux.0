Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B6C25771
	for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763582213; cv=none; b=SEM0lb761mgsGkYv19lmtBn04xk2DocGq6UcZMlTueFNIAAefxl6JFRxZ4zdewqUeG0GJjyHZDmtB2U2DPeLT66x1ZpmOa7Pe6vsaVYn7LhP+f4Kn+1zUgQEIfXacCbTwcia1Pr7K2G6lf13+MVBu5hmPASL5H7zNlXZ/w256h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763582213; c=relaxed/simple;
	bh=8vs7QMm5ivDQd9c0D9cx7Kj76gQk8EIuUfuUsBbz+hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlPAtHBb+291xNeQ4RQfRQ9pN1Wwfi6QZWTMV/ZUiNdixwrkybHxjKKVljm6viqTOyUbDzKR9jCnbK9QkOjuR/RcVNMHs/7I0MoJlznM4y4KohdFuE0OTgKPuirtEkdBsxwjzW4pMs+p8HPqOptCN9xy9TqPI0g1FHpayVd2Jt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NgWkvBcs; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NgWkvBcs"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b21fc25ae1so12215785a.1
        for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 11:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763582208; x=1764187008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kAL5Q0i5cCG8uh09YF0qSelTy4B273fbdlmKSA31Mc=;
        b=NgWkvBcsRD2cKPzAwQc+xgsnCrEsl4VMrcnAmv4LdQpNtHP880fyEQHe33u1VTmLDu
         y5SiIqOOUNDzBYF67tm2QQU7GgkNGuKkEaUMP/yZvMUnhEvvYyfcQsimlLAUWbamWopg
         Ko+/dn13/dNOh8ezfwUwHgMv6gTsKDkmr9qs+GobeaRauM/7pHzjDZFHqPdTd3P0A5zJ
         z3oEZywNOROqOnmM8GBvKe76gN4AKG52xUGTJH020K/r0aBjoLKhUx3brswqIEqE3J4H
         35J6aI4KEt18ID6xqWfX1jj6MtPQlPvoT7OrHskErh/fDEMibeFX3/aXeVLv9tjPxnCJ
         hNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763582208; x=1764187008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8kAL5Q0i5cCG8uh09YF0qSelTy4B273fbdlmKSA31Mc=;
        b=JWM+r/pbYT5aJ3DoNzRefnK0/fVzZ3xGI5kNxkeGvpIEek67YHxWSCEX9DGMGJdaQt
         YTfaY8ANLRXQ6Cpugl/8Sy4miDxzco1jFrpkabeBhKGWaONSf+IWKjNwRzR3JHEEpva9
         xhOBNqGNzi6xxDhTH7GCRg4kRMpX99RuYJYCm6RjSECwrG8gnnAsHlwU5tK/g+36aIyl
         AMOui2ykOz16R3BsrOB8KMWm2+jhJdgwd6pmEetr2+fEUfLvBZ2vpWpq6G3UPw413dc8
         OaNrorN01LjIeTCYjm/JM5grGpSx+3a4ZkNXyaUc3X5Uzh2vUNBr48YOqees1TwjDfpd
         Bzyg==
X-Gm-Message-State: AOJu0YxqSPaDu++GTWztLjtWefW6b0O6RF2cCz/YheBNF+SrWFx9qH2k
	FH/QRYXLXt6+rfW/6pLtKWd5svAMHZv0xybbrpJr8hT7srjcyWT9IB0vEhunm7IvsDHssTKenQi
	Ubgc=
X-Gm-Gg: ASbGncumacPdkWBEX/RwyRb8khqsLucVzuTcYP7ifYg0U7XN6haDZE876KI0j03N3d8
	phfps4vWkHW+8TtOpKSuKUCKwH3ASEdDO54GURwah7hyQtTB9eerTB/7Nn9azv4C6Z57L3AWDVG
	ZWbos1VahPClXKGjjE8Wlk0/5kVmonfeoL1SoxBbPtzJsHoPkg/dP1XPSGMB88MTRImqXWQAKGr
	cFkcJ3zmEhMy6olLqQNESsp0nj9/i1UD/D9rSdQaWNV1mxizGQ0aqtvV8PDb0bUBzet0GJLsT6X
	GzzPcUwHlTgLw1nU5Jwn1yBOk3tsL8OzfyXPcWXyqzzRB7G0ntyXeSDrFHdWSJfqITmVh9klp9D
	HYeT0tDvy8Qr6n2Cl+jsIMPb+igMkrdXGEfjST4MpaCTEAtPgz+/FBERitJYs2C2z9X4L0qCVkd
	+DdVeotkuvnKf+gMgsl3Jv1YzIw4vrz74QnwmhW+grZJGos4t28avx5lpv
X-Google-Smtp-Source: AGHT+IH5LCydqaU1Gv07gkia+Ss2Bm0TuFRdTD+6P+9G5wdcbcC9GFFSm8ce2kNtFjxgzk438GqRlA==
X-Received: by 2002:a05:620a:4016:b0:8a1:426a:2cca with SMTP id af79cd13be357-8b32748a6e8mr84947085a.41.1763582207974;
        Wed, 19 Nov 2025 11:56:47 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932952bsm16570485a.5.2025.11.19.11.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:56:46 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/3] selinux: move avdcache to per-task security struct
Date: Wed, 19 Nov 2025 14:56:30 -0500
Message-ID: <20251119195628.184825-5-paul@paul-moore.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251119195628.184825-4-paul@paul-moore.com>
References: <20251119195628.184825-4-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6833; i=paul@paul-moore.com; h=from:subject; bh=hc0eEAN/Hnvdp3s+rXZf5hiF+b2oMslxpkvlUorBA3o=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBpHiD1+fZBBW9DD52eWFGduaxe/mSSRSvpejPnS zL7PaJ3YfiJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaR4g9QAKCRDqIPLalzeJ cz46EACpKGGv+GTlU4RcZJd0+mr8WLk6jowwgSQzlT99W4jkVCP/e9AYmjk+chv1uL/kKTksXeS aDHjmw3kgynwwEsu0Kmy3o17MNVhPKYnY6OE61Zl0RhHLcJHUjqRxY0cFtWpKb71qawxFqQfur5 jfCj3NICcbDNiCFhe7iDvqAo4T06l3GEj0YkHOeJfnMejS68K5yxc/0Xnm/XMqz2owSC8Tq+8GU RxAvZzEncXfgudgK+GjTV4Cd6YcPApPTAAJswwZTmjQYARHTnlyNGq6F+3w+foQ5QwV7MAt0RlM nqDT1A0/tww3ZrVYyFBhyoiollwjDWFFiHAJk0hf2ZtSnfNUVHipuIOe6QXhcsleCFGYGneEqn+ F343ZTbGkeA7WCyHzVqKPVxhT1huwIULxXZWZbMWXBrXNPOiK/z3bH1bdSe/U9MjmKN9dv+rAni nXsKVCgmgztZG2Ti8fDhfLPo7F9fsLC8YzHiEsB5ONK7euj39eL3djJrkVFqcQIoH+Wwm14LSz3 p4TCX3w7J241S39XVvo43S3hgSXmxl1u3lY31qqYg9hJQSIRf86ZXkN4ogqXgViVISQNhhv4Ztf 9mm+QFwv9jkNkbPMc5AVeNu87aCZlEXkeQ6G83LhIGKbMWN78ii9qjAyfkSei/lcpbytGOq2LyC 0Xi7F2V/kxXnf4w==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

From: Stephen Smalley <stephen.smalley.work@gmail.com>

The avdcache is meant to be per-task; move it to a new
task_security_struct that is duplicated per-task.

Cc: stable@vger.kernel.org
Fixes: 5d7ddc59b3d89b724a5aa8f30d0db94ff8d2d93f ("selinux: reduce path walk overhead")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
[PM: line length fixes]
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c          | 31 ++++++++++++++++++-------------
 security/selinux/include/objsec.h | 14 ++++++++++++--
 2 files changed, 30 insertions(+), 15 deletions(-)

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
index e71ce352bc97..00804562c2c3 100644
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
 
@@ -177,6 +181,12 @@ static inline struct cred_security_struct *selinux_cred(const struct cred *cred)
 	return cred->security + selinux_blob_sizes.lbs_cred;
 }
 
+static inline struct task_security_struct *
+selinux_task(const struct task_struct *task)
+{
+	return task->security + selinux_blob_sizes.lbs_task;
+}
+
 static inline struct file_security_struct *selinux_file(const struct file *file)
 {
 	return file->f_security + selinux_blob_sizes.lbs_file;
-- 
2.52.0

