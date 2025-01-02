Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD0813C9D9
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836351; cv=none; b=t4SWXY2lDVCo2qOJ7YTucItwurWQ6jIe44pVN4Y3MhibF0JfvFNw4T3IhwZ/bRAf1ZjjvC2aBAVH8nslb6d+jhbRmwGtTXxl5jcFflTyWgZzg9C4CesH073q6tJLsnAScZQx9u5Q9gjPJFfZ1ukSUMEjAPc6RWbumSWL5aT7VAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836351; c=relaxed/simple;
	bh=+fWs2pi2NkSWNjnzp2aNtEJ/bmbbaWnuZKuPfmD2GrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UbEe2NtU0dsiTwq23xKP9T7gXWL6suXIg2CWDDFlKlWeIEDH+TW8XPYJSqFMLi8UdZzHj77xXGDAiFhXtDdcOoeop2xOQNEa6ZBzea+ZX86BMIpcWdlZOkpbAgg6JtW59jfm44xly/IfhFLJxlvN3g9iio4+ZIqP318HKSKeQbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/Gp6Off; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/Gp6Off"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467a3c85e11so72362911cf.2
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836346; x=1736441146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvo/0keHFQtiXK0D5wuY3vZQdM+RsA+s2twIrUDc5iM=;
        b=b/Gp6OffQ87UuIvbIySB4KXq/1a+KGMEWOeX/U6bKpa3cBG5oiceqvnwtaOSt7mE4D
         Rp25lcJOCq9K44cr7MoIwc+SX+2FBHZ2gO2AVehSdWi2jVvg4GPtiWx96aG+mmfmDqKC
         8XsgTpts0NK5172XbomsappAqZ3OcM++fclZhvSVlr14P85LvYl5LktYO7M4U/tdqkml
         hE0VdHKqBHeRdmeYV9YBFkcFxRMfpPGZ5/kfMUiGv23gC5fQODOmGuIo5FSRkgZ6Ab0q
         l9MLqZ2wVMrembo6tYyVoIHWkeDhz52M9lbaiQQ+btIwjUS80RH+GWsC/Qwi+Yrrw902
         a6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836346; x=1736441146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvo/0keHFQtiXK0D5wuY3vZQdM+RsA+s2twIrUDc5iM=;
        b=wb/efeArAIlZkHx2nKBfoZNHvsLt2SCXzNBpVKku8VITPiq4DWFJiiYjp2VUezu172
         fEOMi2pKeuhp8beWI/y6Q2JpcLlN+Dd/SV7tGw9TN9aGqJMAk3hcycXrg8MOluoUIv3y
         JkBE2WonxNf7lgLpcfmolCzn2A22ct3YKwx9EG+Nn1KcYHyDOgsbhaEihL7YWq/lMe+1
         hpLFyWIgNZK1AUtoKFxx1p62myuXw4hzpVjfpzmi6dJJoB4jK328kYGpoEY9nvKDrf1H
         L+u8AtvJKd0sG1f9Y2IaJSO+K5yJzqx0L1PifTTjCulcKJzt3lqhtT0+YvATd7GJpla4
         lH9w==
X-Gm-Message-State: AOJu0YzbcUPsmguK4VT+dehLqR6vrTf20J5Tlk7c3S2wyMswUUzV/Q20
	PfEAMJx0wq7oPddHa/leXwX11hqyfFJjLdBbQfIeJe92H+lyIGC27dbO7A==
X-Gm-Gg: ASbGnctu0zxVlJZvsdl75WqBKRxPY9P3fXPZxpDeRZcZnOro1EmOYsGmspO2Qfkidg2
	ex0ZDE/2j7eJaZkHrG1E9LjLNXZ9MLj5FphEhP7RBK9Ys/sBN6ouc/W6L8uj4r6+pb2xfFauyLy
	23fx60xCetyy7vD8uLNt2PY13KoROPTZH/hXJtntiwNHmBb8RQ3XbDOKeaLdraj807f787/5GTW
	+4pMjwGnnoCXIwRlrzj+T92WdoK3d32UKjFeHswcvNhjbpB51i88mfp7YJJzzhv9EgUtY/dodi+
	oJiGb2z6HukmXKHEycd8wOMLAof5API5L0KRQfm+Gs6olRJ5hxmCb2wwR+B5uGWIsTobIg==
X-Google-Smtp-Source: AGHT+IHbzTGtAEEs8+GXB+tDQwhEH9JEJZpCe1jdi79dCcgEVOQh3Wzk/8SFhIWdo/UZt9rkpKOpkw==
X-Received: by 2002:a05:622a:14a:b0:467:81ef:1953 with SMTP id d75a77b69052e-46a4a8b6f0cmr730634631cf.7.1735836345331;
        Thu, 02 Jan 2025 08:45:45 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:44 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 16/44] selinux: introduce cred_has_perm()
Date: Thu,  2 Jan 2025 11:44:41 -0500
Message-Id: <20250102164509.25606-17-stephen.smalley.work@gmail.com>
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

Introduce cred_has_perm() to check permissions between a cred
and a specified target SID against the current SELinux namespace
and all ancestors. Also provide a cred_has_perm_noaudit() variant
for use by checks where auditing is not desired or requires further
specialization (e.g. selinux_inode_permission).

These helpers should NOT be used when checking permissions
between two creds (or tasks) since they will not use the
target SID from the same namespace as the source cred.
They are only suitable when checking permissions to
non-cred/task objects like superblocks, inodes, etc.

Convert permission checks in the hook functions to use these
new helpers when appropriate. Also convert some further checks
to using the cred_self_has_perm() helper previously introduced.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         |  53 +++++
 security/selinux/hooks.c       | 384 +++++++++++++--------------------
 security/selinux/include/avc.h |   6 +
 3 files changed, 211 insertions(+), 232 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 8f6a8992170a..19641d5daba8 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1349,6 +1349,59 @@ int cred_self_has_perm_noaudit(const struct cred *cred, u16 tclass,
 	return 0;
 }
 
+int cred_has_perm(const struct cred *cred, u32 tsid, u16 tclass,
+		  u32 requested, struct common_audit_data *ad)
+{
+	struct task_security_struct *tsec;
+	struct selinux_state *state;
+	u32 ssid;
+	int rc;
+
+	do {
+		tsec = selinux_cred(cred);
+		ssid = tsec->sid;
+		state = tsec->state;
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
+int cred_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
+			  u32 requested, struct av_decision *avd)
+{
+	struct task_security_struct *tsec;
+	struct selinux_state *state;
+	u32 ssid;
+	int rc;
+
+	do {
+		tsec = selinux_cred(cred);
+		ssid = tsec->sid;
+		state = tsec->state;
+
+		/*
+		 * TODO Do we need to use a tmp avd for each
+		 * avc_has_perm_noaudit() call and intersect/union
+		 * the sets as appropriate as we go? Or can we
+		 * simply use the last result since we generally
+		 * only care when there is a denial?
+		 */
+		rc = avc_has_perm_noaudit(state, ssid, tsid, tclass,
+					  requested, 0, avd);
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
index f0fb515ca56e..b38d0f78f33d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -452,17 +452,14 @@ static int may_context_mount_sb_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
 
-	rc = avc_has_perm(cred_selinux_state(cred),
-			  tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
-			  FILESYSTEM__RELABELFROM, NULL);
+	rc = cred_has_perm(cred, sbsec->sid, SECCLASS_FILESYSTEM,
+			   FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(cred_selinux_state(cred),
-			  tsec->sid, sid, SECCLASS_FILESYSTEM,
+	rc = cred_has_perm(cred, sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELTO, NULL);
 	return rc;
 }
@@ -471,18 +468,16 @@ static int may_context_mount_inode_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
-	rc = avc_has_perm(cred_selinux_state(cred),
-			  tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
+
+	rc = cred_has_perm(cred, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(cred_selinux_state(cred),
-			  sid, sbsec->sid, SECCLASS_FILESYSTEM,
-			  FILESYSTEM__ASSOCIATE, NULL);
-	return rc;
+	return avc_has_perm(cred_selinux_state(cred),
+			    sid, sbsec->sid, SECCLASS_FILESYSTEM,
+			    FILESYSTEM__ASSOCIATE, NULL);
 }
 
 static int selinux_is_genfs_special_handling(struct super_block *sb)
@@ -1691,16 +1686,13 @@ static int inode_has_perm(const struct cred *cred,
 			  struct common_audit_data *adp)
 {
 	struct inode_security_struct *isec;
-	u32 sid;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
 
-	sid = cred_sid(cred);
 	isec = selinux_inode(inode);
 
-	return avc_has_perm(cred_selinux_state(cred),
-			    sid, isec->sid, isec->sclass, perms, adp);
+	return cred_has_perm(cred, isec->sid, isec->sclass, perms, adp);
 }
 
 /* Same as inode_has_perm, but pass explicit audit data containing
@@ -1748,7 +1740,7 @@ static inline int file_path_has_perm(const struct cred *cred,
 }
 
 #ifdef CONFIG_BPF_SYSCALL
-static int bpf_fd_pass(const struct file *file, u32 sid);
+static int bpf_fd_pass(const struct file *file, const struct cred *cred);
 #endif
 
 /* Check whether a task can use an open file descriptor to
@@ -1773,17 +1765,14 @@ static int file_has_perm(const struct cred *cred,
 	ad.u.file = file;
 
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(cred_selinux_state(cred),
-				  sid, fsec->sid,
-				  SECCLASS_FD,
-				  FD__USE,
-				  &ad);
+		rc = cred_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
+				   &ad);
 		if (rc)
 			goto out;
 	}
 
 #ifdef CONFIG_BPF_SYSCALL
-	rc = bpf_fd_pass(file, cred_sid(cred));
+	rc = bpf_fd_pass(file, cred);
 	if (rc)
 		return rc;
 #endif
@@ -1830,23 +1819,21 @@ static int may_create(struct inode *dir,
 		      struct dentry *dentry,
 		      u16 tclass)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred *cred = current_cred();
+	const struct task_security_struct *tsec = selinux_cred(cred);
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
-	u32 sid, newsid;
+	u32 newsid;
 	struct common_audit_data ad;
 	int rc;
 
 	dsec = inode_security(dir);
 	sbsec = selinux_superblock(dir->i_sb);
 
-	sid = tsec->sid;
-
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
 
-	rc = avc_has_perm(current_selinux_state,
-			  sid, dsec->sid, SECCLASS_DIR,
+	rc = cred_has_perm(cred, dsec->sid, SECCLASS_DIR,
 			  DIR__ADD_NAME | DIR__SEARCH,
 			  &ad);
 	if (rc)
@@ -1857,8 +1844,7 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(current_selinux_state,
-			  sid, newsid, tclass, FILE__CREATE, &ad);
+	rc = cred_has_perm(cred, newsid, tclass, FILE__CREATE, &ad);
 	if (rc)
 		return rc;
 
@@ -1878,9 +1864,9 @@ static int may_link(struct inode *dir,
 		    int kind)
 
 {
+	const struct cred *cred = current_cred();
 	struct inode_security_struct *dsec, *isec;
 	struct common_audit_data ad;
-	u32 sid = current_sid();
 	u32 av;
 	int rc;
 
@@ -1892,8 +1878,7 @@ static int may_link(struct inode *dir,
 
 	av = DIR__SEARCH;
 	av |= (kind ? DIR__REMOVE_NAME : DIR__ADD_NAME);
-	rc = avc_has_perm(current_selinux_state,
-			  sid, dsec->sid, SECCLASS_DIR, av, &ad);
+	rc = cred_has_perm(cred, dsec->sid, SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
 
@@ -1913,9 +1898,7 @@ static int may_link(struct inode *dir,
 		return 0;
 	}
 
-	rc = avc_has_perm(current_selinux_state,
-			  sid, isec->sid, isec->sclass, av, &ad);
-	return rc;
+	return cred_has_perm(cred, isec->sid, isec->sclass, av, &ad);
 }
 
 static inline int may_rename(struct inode *old_dir,
@@ -1923,9 +1906,9 @@ static inline int may_rename(struct inode *old_dir,
 			     struct inode *new_dir,
 			     struct dentry *new_dentry)
 {
+	const struct cred *cred = current_cred();
 	struct inode_security_struct *old_dsec, *new_dsec, *old_isec, *new_isec;
 	struct common_audit_data ad;
-	u32 sid = current_sid();
 	u32 av;
 	int old_is_dir, new_is_dir;
 	int rc;
@@ -1938,20 +1921,17 @@ static inline int may_rename(struct inode *old_dir,
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 
 	ad.u.dentry = old_dentry;
-	rc = avc_has_perm(current_selinux_state,
-			  sid, old_dsec->sid, SECCLASS_DIR,
+	rc = cred_has_perm(cred, old_dsec->sid, SECCLASS_DIR,
 			  DIR__REMOVE_NAME | DIR__SEARCH, &ad);
 	if (rc)
 		return rc;
-	rc = avc_has_perm(current_selinux_state,
-			  sid, old_isec->sid,
-			  old_isec->sclass, FILE__RENAME, &ad);
+	rc = cred_has_perm(cred, old_isec->sid, old_isec->sclass,
+			   FILE__RENAME, &ad);
 	if (rc)
 		return rc;
 	if (old_is_dir && new_dir != old_dir) {
-		rc = avc_has_perm(current_selinux_state,
-				  sid, old_isec->sid,
-				  old_isec->sclass, DIR__REPARENT, &ad);
+		rc = cred_has_perm(cred, old_isec->sid, old_isec->sclass,
+				   DIR__REPARENT, &ad);
 		if (rc)
 			return rc;
 	}
@@ -1960,17 +1940,15 @@ static inline int may_rename(struct inode *old_dir,
 	av = DIR__ADD_NAME | DIR__SEARCH;
 	if (d_is_positive(new_dentry))
 		av |= DIR__REMOVE_NAME;
-	rc = avc_has_perm(current_selinux_state,
-			  sid, new_dsec->sid, SECCLASS_DIR, av, &ad);
+	rc = cred_has_perm(cred, new_dsec->sid, SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
 	if (d_is_positive(new_dentry)) {
 		new_isec = backing_inode_security(new_dentry);
 		new_is_dir = d_is_dir(new_dentry);
-		rc = avc_has_perm(current_selinux_state,
-				  sid, new_isec->sid,
-				  new_isec->sclass,
-				  (new_is_dir ? DIR__RMDIR : FILE__UNLINK), &ad);
+		rc = cred_has_perm(cred, new_isec->sid, new_isec->sclass,
+				   (new_is_dir ? DIR__RMDIR : FILE__UNLINK),
+				   &ad);
 		if (rc)
 			return rc;
 	}
@@ -1985,11 +1963,10 @@ static int superblock_has_perm(const struct cred *cred,
 			       struct common_audit_data *ad)
 {
 	struct superblock_security_struct *sbsec;
-	u32 sid = cred_sid(cred);
 
 	sbsec = selinux_superblock(sb);
-	return avc_has_perm(cred_selinux_state(cred),
-			    sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
+	return cred_has_perm(cred, sbsec->sid, SECCLASS_FILESYSTEM, perms,
+			     ad);
 }
 
 /* Convert a Linux mode and permission mask to an access vector. */
@@ -2112,17 +2089,14 @@ static int selinux_binder_transfer_file(const struct cred *from,
 	ad.u.path = file->f_path;
 
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(cred_selinux_state(to),
-				  sid, fsec->sid,
-				  SECCLASS_FD,
-				  FD__USE,
-				  &ad);
+		rc = cred_has_perm(to, fsec->sid, SECCLASS_FD, FD__USE,
+				   &ad);
 		if (rc)
 			return rc;
 	}
 
 #ifdef CONFIG_BPF_SYSCALL
-	rc = bpf_fd_pass(file, sid);
+	rc = bpf_fd_pass(file, to);
 	if (rc)
 		return rc;
 #endif
@@ -2131,9 +2105,8 @@ static int selinux_binder_transfer_file(const struct cred *from,
 		return 0;
 
 	isec = backing_inode_security(dentry);
-	return avc_has_perm(cred_selinux_state(to),
-			    sid, isec->sid, isec->sclass, file_to_av(file),
-			    &ad);
+	return cred_has_perm(to, isec->sid, isec->sclass, file_to_av(file),
+			     &ad);
 }
 
 static int selinux_ptrace_access_check(struct task_struct *child,
@@ -2231,25 +2204,25 @@ static int selinux_quota_on(struct dentry *dentry)
 
 static int selinux_syslog(int type)
 {
+	const struct cred *cred = current_cred();
+
 	switch (type) {
 	case SYSLOG_ACTION_READ_ALL:	/* Read last kernel messages */
 	case SYSLOG_ACTION_SIZE_BUFFER:	/* Return size of the log buffer */
-		return avc_has_perm(current_selinux_state,
-				    current_sid(), SECINITSID_KERNEL,
-				    SECCLASS_SYSTEM, SYSTEM__SYSLOG_READ, NULL);
+		return cred_has_perm(cred, SECINITSID_KERNEL,
+				     SECCLASS_SYSTEM,
+				     SYSTEM__SYSLOG_READ, NULL);
 	case SYSLOG_ACTION_CONSOLE_OFF:	/* Disable logging to console */
 	case SYSLOG_ACTION_CONSOLE_ON:	/* Enable logging to console */
 	/* Set level of messages printed to console */
 	case SYSLOG_ACTION_CONSOLE_LEVEL:
-		return avc_has_perm(current_selinux_state,
-				    current_sid(), SECINITSID_KERNEL,
-				    SECCLASS_SYSTEM, SYSTEM__SYSLOG_CONSOLE,
-				    NULL);
+		return cred_has_perm(cred, SECINITSID_KERNEL,
+				     SECCLASS_SYSTEM,
+				     SYSTEM__SYSLOG_CONSOLE, NULL);
 	}
 	/* All other syslog types */
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), SECINITSID_KERNEL,
-			    SECCLASS_SYSTEM, SYSTEM__SYSLOG_MOD, NULL);
+	return cred_has_perm(cred, SECINITSID_KERNEL, SECCLASS_SYSTEM,
+			     SYSTEM__SYSLOG_MOD, NULL);
 }
 
 /*
@@ -3058,12 +3031,8 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 	ad.type = LSM_AUDIT_DATA_ANONINODE;
 	ad.u.anonclass = name ? (const char *)name->name : "?";
 
-	return avc_has_perm(current_selinux_state,
-			    sid,
-			    isec->sid,
-			    isec->sclass,
-			    FILE__CREATE,
-			    &ad);
+	return cred_has_perm(current_cred(), isec->sid, isec->sclass,
+			     FILE__CREATE, &ad);
 }
 
 static int selinux_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
@@ -3119,7 +3088,6 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 {
 	struct common_audit_data ad;
 	struct inode_security_struct *isec;
-	u32 sid = current_sid();
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
@@ -3127,8 +3095,8 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	return avc_has_perm(current_selinux_state,
-				  sid, isec->sid, isec->sclass, FILE__READ, &ad);
+	return cred_has_perm(current_cred(), isec->sid, isec->sclass,
+			     FILE__READ, &ad);
 }
 
 static noinline int audit_inode_permission(struct inode *inode,
@@ -3152,7 +3120,6 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	bool from_access;
 	bool no_block = mask & MAY_NOT_BLOCK;
 	struct inode_security_struct *isec;
-	u32 sid = current_sid();
 	struct av_decision avd;
 	int rc, rc2;
 	u32 audited, denied;
@@ -3173,9 +3140,8 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	rc = avc_has_perm_noaudit(current_selinux_state,
-				  sid, isec->sid, isec->sclass, perms, 0,
-				  &avd);
+	rc = cred_has_perm_noaudit(current_cred(), isec->sid, isec->sclass,
+				   perms, &avd);
 	audited = avc_audit_required(perms, &avd, rc,
 				     from_access ? FILE__AUDIT_ACCESS : 0,
 				     &denied);
@@ -3255,11 +3221,12 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 				  struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
+	const struct cred *cred = current_cred();
 	struct inode *inode = d_backing_inode(dentry);
 	struct inode_security_struct *isec;
 	struct superblock_security_struct *sbsec;
 	struct common_audit_data ad;
-	u32 newsid, sid = current_sid();
+	u32 newsid;
 	int rc = 0;
 
 	/* if not a selinux xattr, only check the ordinary setattr perm */
@@ -3280,9 +3247,8 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	ad.u.dentry = dentry;
 
 	isec = backing_inode_security(dentry);
-	rc = avc_has_perm(current_selinux_state,
-			  sid, isec->sid, isec->sclass,
-			  FILE__RELABELFROM, &ad);
+	rc = cred_has_perm(cred, isec->sid, isec->sclass, FILE__RELABELFROM,
+			   &ad);
 	if (rc)
 		return rc;
 
@@ -3321,14 +3287,13 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(current_selinux_state,
-			  sid, newsid, isec->sclass,
-			  FILE__RELABELTO, &ad);
+	rc = cred_has_perm(cred, newsid, isec->sclass, FILE__RELABELTO,
+			   &ad);
 	if (rc)
 		return rc;
 
 	rc = security_validate_transition(current_selinux_state, isec->sid, newsid,
-					  sid, isec->sclass);
+					current_sid(), isec->sclass);
 	if (rc)
 		return rc;
 
@@ -3750,11 +3715,8 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	ad.u.op->path = file->f_path;
 
 	if (ssid != fsec->sid) {
-		rc = avc_has_perm(cred_selinux_state(cred),
-				  ssid, fsec->sid,
-				SECCLASS_FD,
-				FD__USE,
-				&ad);
+		rc = cred_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
+				   &ad);
 		if (rc)
 			goto out;
 	}
@@ -4137,14 +4099,10 @@ static void selinux_cred_getlsmprop(const struct cred *c, struct lsm_prop *prop)
 static int selinux_kernel_act_as(struct cred *new, u32 secid)
 {
 	struct task_security_struct *tsec = selinux_cred(new);
-	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(tsec->state,
-			   sid, secid,
-			   SECCLASS_KERNEL_SERVICE,
-			   KERNEL_SERVICE__USE_AS_OVERRIDE,
-			   NULL);
+	ret = cred_has_perm(current_cred(), secid, SECCLASS_KERNEL_SERVICE,
+			    KERNEL_SERVICE__USE_AS_OVERRIDE, NULL);
 	if (ret == 0) {
 		tsec->sid = secid;
 		tsec->create_sid = 0;
@@ -4162,14 +4120,12 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
 	struct inode_security_struct *isec = inode_security(inode);
 	struct task_security_struct *tsec = selinux_cred(new);
-	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(tsec->state,
-			   sid, isec->sid,
-			   SECCLASS_KERNEL_SERVICE,
-			   KERNEL_SERVICE__CREATE_FILES_AS,
-			   NULL);
+	ret = cred_has_perm(current_cred(), isec->sid,
+			    SECCLASS_KERNEL_SERVICE,
+			    KERNEL_SERVICE__CREATE_FILES_AS,
+			    NULL);
 
 	if (ret == 0)
 		tsec->create_sid = isec->sid;
@@ -4183,9 +4139,8 @@ static int selinux_kernel_module_request(char *kmod_name)
 	ad.type = LSM_AUDIT_DATA_KMOD;
 	ad.u.kmod_name = kmod_name;
 
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), SECINITSID_KERNEL, SECCLASS_SYSTEM,
-			    SYSTEM__MODULE_REQUEST, &ad);
+	return cred_has_perm(current_cred(), SECINITSID_KERNEL,
+			     SECCLASS_SYSTEM, SYSTEM__MODULE_REQUEST, &ad);
 }
 
 static int selinux_kernel_module_from_file(struct file *file)
@@ -4193,12 +4148,13 @@ static int selinux_kernel_module_from_file(struct file *file)
 	struct common_audit_data ad;
 	struct inode_security_struct *isec;
 	struct file_security_struct *fsec;
+	const struct cred *cred = current_cred();
 	u32 sid = current_sid();
 	int rc;
 
 	/* init_module */
 	if (file == NULL)
-		return cred_self_has_perm(current_cred(), SECCLASS_SYSTEM,
+		return cred_self_has_perm(cred, SECCLASS_SYSTEM,
 					  SYSTEM__MODULE_LOAD, NULL);
 
 	/* finit_module */
@@ -4208,16 +4164,15 @@ static int selinux_kernel_module_from_file(struct file *file)
 
 	fsec = selinux_file(file);
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(current_selinux_state,
-				  sid, fsec->sid, SECCLASS_FD, FD__USE, &ad);
+		rc = cred_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
+				   &ad);
 		if (rc)
 			return rc;
 	}
 
 	isec = inode_security(file_inode(file));
-	return avc_has_perm(current_selinux_state,
-			    sid, isec->sid, SECCLASS_SYSTEM,
-				SYSTEM__MODULE_LOAD, &ad);
+	return cred_has_perm(cred, isec->sid, SECCLASS_SYSTEM,
+			     SYSTEM__MODULE_LOAD, &ad);
 }
 
 static int selinux_kernel_read_file(struct file *file,
@@ -4727,9 +4682,8 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 
 	ad_net_init_from_sk(&ad, &net, sk);
 
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), sksec->sid, sksec->sclass, perms,
-			    &ad);
+	return cred_has_perm(current_cred(), sksec->sid, sksec->sclass,
+			     perms, &ad);
 }
 
 static int selinux_socket_create(int family, int type,
@@ -4748,8 +4702,8 @@ static int selinux_socket_create(int family, int type,
 	if (rc)
 		return rc;
 
-	return avc_has_perm(current_selinux_state,
-			    tsec->sid, newsid, secclass, SOCKET__CREATE, NULL);
+	return cred_has_perm(current_cred(), newsid, secclass,
+			     SOCKET__CREATE, NULL);
 }
 
 static int selinux_socket_post_create(struct socket *sock, int family,
@@ -5698,8 +5652,7 @@ static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 
 static int selinux_secmark_relabel_packet(u32 sid)
 {
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), sid, SECCLASS_PACKET,
+	return cred_has_perm(current_cred(), sid, SECCLASS_PACKET,
 			    PACKET__RELABELTO, NULL);
 }
 
@@ -5729,8 +5682,6 @@ static int selinux_tun_dev_alloc_security(void *security)
 
 static int selinux_tun_dev_create(void)
 {
-	u32 sid = current_sid();
-
 	/* we aren't taking into account the "sockcreate" SID since the socket
 	 * that is being created here is not a socket in the traditional sense,
 	 * instead it is a private sock, accessible only to the kernel, and
@@ -5738,18 +5689,17 @@ static int selinux_tun_dev_create(void)
 	 * connections unlike traditional sockets - check the TUN driver to
 	 * get a better understanding of why this socket is special */
 
-	return avc_has_perm(current_selinux_state,
-			    sid, sid, SECCLASS_TUN_SOCKET, TUN_SOCKET__CREATE,
-			    NULL);
+	return cred_self_has_perm(current_cred(), SECCLASS_TUN_SOCKET,
+				  TUN_SOCKET__CREATE, NULL);
 }
 
 static int selinux_tun_dev_attach_queue(void *security)
 {
 	struct tun_security_struct *tunsec = selinux_tun_dev(security);
 
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), tunsec->sid, SECCLASS_TUN_SOCKET,
-			    TUN_SOCKET__ATTACH_QUEUE, NULL);
+	return cred_has_perm(current_cred(), tunsec->sid,
+			     SECCLASS_TUN_SOCKET, TUN_SOCKET__ATTACH_QUEUE,
+			     NULL);
 }
 
 static int selinux_tun_dev_attach(struct sock *sk, void *security)
@@ -5772,21 +5722,19 @@ static int selinux_tun_dev_attach(struct sock *sk, void *security)
 
 static int selinux_tun_dev_open(void *security)
 {
+	const struct cred *cred = current_cred();
 	struct tun_security_struct *tunsec = selinux_tun_dev(security);
-	u32 sid = current_sid();
 	int err;
 
-	err = avc_has_perm(current_selinux_state,
-			   sid, tunsec->sid, SECCLASS_TUN_SOCKET,
-			   TUN_SOCKET__RELABELFROM, NULL);
+	err = cred_has_perm(cred, tunsec->sid, SECCLASS_TUN_SOCKET,
+			    TUN_SOCKET__RELABELFROM, NULL);
 	if (err)
 		return err;
-	err = avc_has_perm(current_selinux_state,
-			   sid, sid, SECCLASS_TUN_SOCKET,
-			   TUN_SOCKET__RELABELTO, NULL);
+	err = cred_self_has_perm(cred, SECCLASS_TUN_SOCKET,
+				 TUN_SOCKET__RELABELTO, NULL);
 	if (err)
 		return err;
-	tunsec->sid = sid;
+	tunsec->sid = current_sid();
 
 	return 0;
 }
@@ -6163,15 +6111,14 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 {
 	struct ipc_security_struct *isec;
 	struct common_audit_data ad;
-	u32 sid = current_sid();
 
 	isec = selinux_ipc(ipc_perms);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = ipc_perms->key;
 
-	return avc_has_perm(current_selinux_state,
-			    sid, isec->sid, isec->sclass, perms, &ad);
+	return cred_has_perm(current_cred(), isec->sid, isec->sclass, perms,
+			     &ad);
 }
 
 static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
@@ -6189,7 +6136,6 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
 {
 	struct ipc_security_struct *isec;
 	struct common_audit_data ad;
-	u32 sid = current_sid();
 
 	isec = selinux_ipc(msq);
 	ipc_init_security(isec, SECCLASS_MSGQ);
@@ -6197,24 +6143,21 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	return avc_has_perm(current_selinux_state,
-			    sid, isec->sid, SECCLASS_MSGQ,
-			    MSGQ__CREATE, &ad);
+	return cred_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
+			     MSGQ__CREATE, &ad);
 }
 
 static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
 {
 	struct ipc_security_struct *isec;
 	struct common_audit_data ad;
-	u32 sid = current_sid();
 
 	isec = selinux_ipc(msq);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	return avc_has_perm(current_selinux_state,
-			    sid, isec->sid, SECCLASS_MSGQ,
+	return cred_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
 			    MSGQ__ASSOCIATE, &ad);
 }
 
@@ -6226,8 +6169,7 @@ static int selinux_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
 	case IPC_INFO:
 	case MSG_INFO:
 		/* No specific object, just general system-wide information. */
-		return avc_has_perm(current_selinux_state,
-				    current_sid(), SECINITSID_KERNEL,
+		return cred_has_perm(current_cred(), SECINITSID_KERNEL,
 				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case IPC_STAT:
 	case MSG_STAT:
@@ -6249,6 +6191,7 @@ static int selinux_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
 
 static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *msg, int msqflg)
 {
+	const struct cred *cred = current_cred();
 	struct ipc_security_struct *isec;
 	struct msg_security_struct *msec;
 	struct common_audit_data ad;
@@ -6276,14 +6219,11 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
 	ad.u.ipc_id = msq->key;
 
 	/* Can this process write to the queue? */
-	rc = avc_has_perm(current_selinux_state,
-			  sid, isec->sid, SECCLASS_MSGQ,
-			  MSGQ__WRITE, &ad);
+	rc = cred_has_perm(cred, isec->sid, SECCLASS_MSGQ, MSGQ__WRITE, &ad);
 	if (!rc)
 		/* Can this process send the message */
-		rc = avc_has_perm(current_selinux_state,
-				  sid, msec->sid, SECCLASS_MSG,
-				  MSG__SEND, &ad);
+		rc = cred_has_perm(cred, msec->sid, SECCLASS_MSG, MSG__SEND,
+				   &ad);
 	if (!rc)
 		/* Can the message be put in the queue? */
 		rc = avc_has_perm(current_selinux_state,
@@ -6324,7 +6264,6 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
 {
 	struct ipc_security_struct *isec;
 	struct common_audit_data ad;
-	u32 sid = current_sid();
 
 	isec = selinux_ipc(shp);
 	ipc_init_security(isec, SECCLASS_SHM);
@@ -6332,25 +6271,22 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
 
-	return avc_has_perm(current_selinux_state,
-			    sid, isec->sid, SECCLASS_SHM,
-			    SHM__CREATE, &ad);
+	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
+			     SHM__CREATE, &ad);
 }
 
 static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 {
 	struct ipc_security_struct *isec;
 	struct common_audit_data ad;
-	u32 sid = current_sid();
 
 	isec = selinux_ipc(shp);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
 
-	return avc_has_perm(current_selinux_state,
-			    sid, isec->sid, SECCLASS_SHM,
-			    SHM__ASSOCIATE, &ad);
+	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
+			     SHM__ASSOCIATE, &ad);
 }
 
 /* Note, at this point, shp is locked down */
@@ -6362,9 +6298,9 @@ static int selinux_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
 	case IPC_INFO:
 	case SHM_INFO:
 		/* No specific object, just general system-wide information. */
-		return avc_has_perm(current_selinux_state,
-				    current_sid(), SECINITSID_KERNEL,
-				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
+		return cred_has_perm(current_cred(), SECINITSID_KERNEL,
+				     SECCLASS_SYSTEM, SYSTEM__IPC_INFO,
+				     NULL);
 	case IPC_STAT:
 	case SHM_STAT:
 	case SHM_STAT_ANY:
@@ -6405,7 +6341,6 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
 {
 	struct ipc_security_struct *isec;
 	struct common_audit_data ad;
-	u32 sid = current_sid();
 
 	isec = selinux_ipc(sma);
 	ipc_init_security(isec, SECCLASS_SEM);
@@ -6413,25 +6348,22 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
 
-	return avc_has_perm(current_selinux_state,
-			    sid, isec->sid, SECCLASS_SEM,
-			    SEM__CREATE, &ad);
+	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
+			     SEM__CREATE, &ad);
 }
 
 static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
 {
 	struct ipc_security_struct *isec;
 	struct common_audit_data ad;
-	u32 sid = current_sid();
 
 	isec = selinux_ipc(sma);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
 
-	return avc_has_perm(current_selinux_state,
-			    sid, isec->sid, SECCLASS_SEM,
-			    SEM__ASSOCIATE, &ad);
+	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
+			     SEM__ASSOCIATE, &ad);
 }
 
 /* Note, at this point, sma is locked down */
@@ -6444,9 +6376,9 @@ static int selinux_sem_semctl(struct kern_ipc_perm *sma, int cmd)
 	case IPC_INFO:
 	case SEM_INFO:
 		/* No specific object, just general system-wide information. */
-		return avc_has_perm(current_selinux_state,
-				    current_sid(), SECINITSID_KERNEL,
-				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
+		return cred_has_perm(current_cred(), SECINITSID_KERNEL,
+				     SECCLASS_SYSTEM, SYSTEM__IPC_INFO,
+				     NULL);
 	case GETPID:
 	case GETNCNT:
 	case GETZCNT:
@@ -6532,9 +6464,9 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 	rcu_read_lock();
 	tsec = task_security(p);
 	if (p != current) {
-		error = avc_has_perm(current_selinux_state,
-				     current_sid(), tsec->sid,
-				     SECCLASS_PROCESS, PROCESS__GETATTR, NULL);
+		error = cred_has_perm(current_cred(), tsec->sid,
+				      SECCLASS_PROCESS, PROCESS__GETATTR,
+				      NULL);
 		if (error)
 			goto err_unlock;
 	}
@@ -6580,9 +6512,10 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 
 static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 {
+	const struct cred *cred = current_cred();
 	struct task_security_struct *tsec;
 	struct cred *new;
-	u32 mysid = current_sid(), sid = 0, ptsid;
+	u32 sid = 0, ptsid;
 	int error;
 	char *str = value;
 
@@ -6591,23 +6524,23 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 	 */
 	switch (attr) {
 	case LSM_ATTR_EXEC:
-		error = cred_self_has_perm(current_cred(), SECCLASS_PROCESS,
+		error = cred_self_has_perm(cred, SECCLASS_PROCESS,
 					   PROCESS__SETEXEC, NULL);
 		break;
 	case LSM_ATTR_FSCREATE:
-		error = cred_self_has_perm(current_cred(), SECCLASS_PROCESS,
+		error = cred_self_has_perm(cred, SECCLASS_PROCESS,
 					   PROCESS__SETFSCREATE, NULL);
 		break;
 	case LSM_ATTR_KEYCREATE:
-		error = cred_self_has_perm(current_cred(), SECCLASS_PROCESS,
+		error = cred_self_has_perm(cred, SECCLASS_PROCESS,
 					   PROCESS__SETKEYCREATE, NULL);
 		break;
 	case LSM_ATTR_SOCKCREATE:
-		error = cred_self_has_perm(current_cred(), SECCLASS_PROCESS,
+		error = cred_self_has_perm(cred, SECCLASS_PROCESS,
 					   PROCESS__SETSOCKCREATE, NULL);
 		break;
 	case LSM_ATTR_CURRENT:
-		error = cred_self_has_perm(current_cred(), SECCLASS_PROCESS,
+		error = cred_self_has_perm(cred, SECCLASS_PROCESS,
 					   PROCESS__SETCURRENT, NULL);
 		break;
 	default:
@@ -6674,8 +6607,8 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		tsec->create_sid = sid;
 	} else if (attr == LSM_ATTR_KEYCREATE) {
 		if (sid) {
-			error = avc_has_perm(current_selinux_state, mysid, sid,
-					     SECCLASS_KEY, KEY__CREATE, NULL);
+			error = cred_has_perm(cred, sid, SECCLASS_KEY,
+					      KEY__CREATE, NULL);
 			if (error)
 				goto abort_change;
 		}
@@ -6879,7 +6812,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 {
 	struct key *key;
 	struct key_security_struct *ksec;
-	u32 perm, sid;
+	u32 perm;
 
 	switch (need_perm) {
 	case KEY_NEED_VIEW:
@@ -6911,12 +6844,10 @@ static int selinux_key_permission(key_ref_t key_ref,
 
 	}
 
-	sid = cred_sid(cred);
 	key = key_ref_to_ptr(key_ref);
 	ksec = selinux_key(key);
 
-	return avc_has_perm(cred_selinux_state(cred),
-			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
+	return cred_has_perm(cred, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
@@ -6938,10 +6869,9 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
 static int selinux_watch_key(struct key *key)
 {
 	struct key_security_struct *ksec = selinux_key(key);
-	u32 sid = current_sid();
 
-	return avc_has_perm(current_selinux_state,
-			    sid, ksec->sid, SECCLASS_KEY, KEY__VIEW, NULL);
+	return cred_has_perm(current_cred(), ksec->sid, SECCLASS_KEY,
+			     KEY__VIEW, NULL);
 }
 #endif
 #endif
@@ -7007,19 +6937,17 @@ static int selinux_ib_alloc_security(void *ib_sec)
 static int selinux_bpf(int cmd, union bpf_attr *attr,
 				     unsigned int size)
 {
-	u32 sid = current_sid();
+	const struct cred *cred = current_cred();
 	int ret;
 
 	switch (cmd) {
 	case BPF_MAP_CREATE:
-		ret = avc_has_perm(current_selinux_state,
-				   sid, sid, SECCLASS_BPF, BPF__MAP_CREATE,
-				   NULL);
+		ret = cred_self_has_perm(cred, SECCLASS_BPF, BPF__MAP_CREATE,
+					 NULL);
 		break;
 	case BPF_PROG_LOAD:
-		ret = avc_has_perm(current_selinux_state,
-				   sid, sid, SECCLASS_BPF, BPF__PROG_LOAD,
-				   NULL);
+		ret = cred_self_has_perm(cred, SECCLASS_BPF, BPF__PROG_LOAD,
+					 NULL);
 		break;
 	default:
 		ret = 0;
@@ -7048,7 +6976,7 @@ static u32 bpf_map_fmode_to_av(fmode_t fmode)
  * access the bpf object and that's why we have to add this additional check in
  * selinux_file_receive and selinux_binder_transfer_files.
  */
-static int bpf_fd_pass(const struct file *file, u32 sid)
+static int bpf_fd_pass(const struct file *file, const struct cred *cred)
 {
 	struct bpf_security_struct *bpfsec;
 	struct bpf_prog *prog;
@@ -7058,16 +6986,14 @@ static int bpf_fd_pass(const struct file *file, u32 sid)
 	if (file->f_op == &bpf_map_fops) {
 		map = file->private_data;
 		bpfsec = map->security;
-		ret = avc_has_perm(current_selinux_state,
-				   sid, bpfsec->sid, SECCLASS_BPF,
+		ret = cred_has_perm(cred, bpfsec->sid, SECCLASS_BPF,
 				   bpf_map_fmode_to_av(file->f_mode), NULL);
 		if (ret)
 			return ret;
 	} else if (file->f_op == &bpf_prog_fops) {
 		prog = file->private_data;
 		bpfsec = prog->aux->security;
-		ret = avc_has_perm(current_selinux_state,
-				   sid, bpfsec->sid, SECCLASS_BPF,
+		ret = cred_has_perm(cred, bpfsec->sid, SECCLASS_BPF,
 				   BPF__PROG_RUN, NULL);
 		if (ret)
 			return ret;
@@ -7077,23 +7003,19 @@ static int bpf_fd_pass(const struct file *file, u32 sid)
 
 static int selinux_bpf_map(struct bpf_map *map, fmode_t fmode)
 {
-	u32 sid = current_sid();
 	struct bpf_security_struct *bpfsec;
 
 	bpfsec = map->security;
-	return avc_has_perm(current_selinux_state,
-			    sid, bpfsec->sid, SECCLASS_BPF,
-			    bpf_map_fmode_to_av(fmode), NULL);
+	return cred_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
+			     bpf_map_fmode_to_av(fmode), NULL);
 }
 
 static int selinux_bpf_prog(struct bpf_prog *prog)
 {
-	u32 sid = current_sid();
 	struct bpf_security_struct *bpfsec;
 
 	bpfsec = prog->aux->security;
-	return avc_has_perm(current_selinux_state,
-			    sid, bpfsec->sid, SECCLASS_BPF,
+	return cred_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
 			    BPF__PROG_RUN, NULL);
 }
 
@@ -7187,7 +7109,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 #ifdef CONFIG_PERF_EVENTS
 static int selinux_perf_event_open(struct perf_event_attr *attr, int type)
 {
-	u32 requested, sid = current_sid();
+	u32 requested;
 
 	if (type == PERF_SECURITY_OPEN)
 		requested = PERF_EVENT__OPEN;
@@ -7200,8 +7122,8 @@ static int selinux_perf_event_open(struct perf_event_attr *attr, int type)
 	else
 		return -EINVAL;
 
-	return avc_has_perm(current_selinux_state, sid, sid, SECCLASS_PERF_EVENT,
-			    requested, NULL);
+	return cred_self_has_perm(current_cred(), SECCLASS_PERF_EVENT,
+				  requested, NULL);
 }
 
 static int selinux_perf_event_alloc(struct perf_event *event)
@@ -7217,19 +7139,17 @@ static int selinux_perf_event_alloc(struct perf_event *event)
 static int selinux_perf_event_read(struct perf_event *event)
 {
 	struct perf_event_security_struct *perfsec = event->security;
-	u32 sid = current_sid();
 
-	return avc_has_perm(current_selinux_state, sid, perfsec->sid,
-			    SECCLASS_PERF_EVENT, PERF_EVENT__READ, NULL);
+	return cred_has_perm(current_cred(), perfsec->sid,
+			     SECCLASS_PERF_EVENT, PERF_EVENT__READ, NULL);
 }
 
 static int selinux_perf_event_write(struct perf_event *event)
 {
 	struct perf_event_security_struct *perfsec = event->security;
-	u32 sid = current_sid();
 
-	return avc_has_perm(current_selinux_state, sid, perfsec->sid,
-			    SECCLASS_PERF_EVENT, PERF_EVENT__WRITE, NULL);
+	return cred_has_perm(current_cred(), perfsec->sid,
+			     SECCLASS_PERF_EVENT, PERF_EVENT__WRITE, NULL);
 }
 #endif
 
@@ -7277,7 +7197,7 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 	ad.type = LSM_AUDIT_DATA_FILE;
 	ad.u.file = file;
 
-	return avc_has_perm(current_selinux_state, current_sid(), isec->sid,
+	return cred_has_perm(current_cred(), isec->sid,
 			    SECCLASS_IO_URING, IO_URING__CMD, &ad);
 }
 #endif /* CONFIG_IO_URING */
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index dd2db5d7f433..31fbf844f9d4 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -158,6 +158,12 @@ int cred_self_has_perm(const struct cred *cred, u16 tclass, u32 requested,
 int cred_self_has_perm_noaudit(const struct cred *cred, u16 tclass,
 			       u32 requested);
 
+int cred_has_perm(const struct cred *cred, u32 tsid, u16 tclass, u32 requested,
+		  struct common_audit_data *ad);
+
+int cred_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
+			  u32 requested, struct av_decision *avd);
+
 u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
-- 
2.47.1

