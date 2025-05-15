Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF2D29712C
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314625; cv=none; b=CKcj/NoefSFXiasizUQuZuClLN5886lQzoQYQG3YQkP6jvxb7BoZdnGj41ikjkf3py9teIeg6P8YS9n6g9I/YprCuvFY3pVE0YcUUa6fiZYNjlwWpwAyVcNIzvtXNkD0cCXSeXgjtg+12MOh6PlyQTCpgGj3MaBiIQRoP27u3Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314625; c=relaxed/simple;
	bh=rGuQVkGOC0BHV3GgA4+bnto6T5HmhYTPemDifLFc+l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kh4oTPvmrxjgMy5rSC1DiKxn8paoLNcJQCPI8qSuXDV1KkELD2bvsGBclmC2QSrbQYKhdvBmqd3LIyhxbLHSNne06ZY0i+AuJV9UzxJ3xcnPsDFiRisf5xqDCcrXwaQlQMmP8jyhROm2xsbk9HZhLtVtOY90y/xTLM8Z70IaTrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFCegLZ8; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFCegLZ8"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-47690a4ec97so10388501cf.2
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314620; x=1747919420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=do4svgrZFKsYPZtXpU1BhWCo0UjUafbXO6HwXtU/eDQ=;
        b=KFCegLZ8UXveZ7fU+qXRZNqiuyv9UHeIRVqgZ0lfwgkfHt1TnTmnwyGUnSyV0YrimN
         Fst18xO4lGo6Y4giFOzOuFzWbt+DdRrtvETOoobndKu8aB6UXJh1VELMQ0I2MjgkaIId
         ksGk2PMLgCQE5EQLyPO+xLGqGexa+2C5IAogWkODaCRIOnSyhcsmZJjRqlnosVm8di11
         9GS8APa04uDTdHyw/DT4vUbtai5MTIXrY2kvouLLyLW1oB2foJbbNTgf6aw7zwZ+7P9+
         ziOqpBOe0d6CrLOGtpE8JjLCv6ytDLjKG7Jafe2rQnsitSrLV5ossi02ZjrtiI7jZYkn
         4Eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314620; x=1747919420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=do4svgrZFKsYPZtXpU1BhWCo0UjUafbXO6HwXtU/eDQ=;
        b=lG0pjUOrPCBtQnvWxWRPBdXgvdfU5Z9L8aVyuyT8UXDro9APnx4/oxas2z6zkb3cuu
         tURLK6RyLwoGp3l16XUEUMOrxzv5RpadgDNV4DeRK2wtoYK7u3JiNJYOndCzJsv6I9kI
         wrl86bRTVedHS1JWiRzwdPDiO2hURhqgtq/3dt4dpAPvi55cgifCJdvsiza3/g7PukR1
         BPOLjl05Yygc1yBJTDY1PqwVSLMszdJQ2qlU/6q0lsuniP3sxtQWHcblVnTEIeYvTpKe
         0Ix50ggTLIZ0edoPZ5bXm6weiw0Hbdxv2GmJ5Z03bNOoaeeMVui59tRnlMtpoxY8u8IZ
         nqNw==
X-Gm-Message-State: AOJu0YxScs6E37IHw1MR4bEr7crjKD4mEH0uUBNl2uppA5yLWSYp3YKO
	KL/s9X/47DWQw776nlUjDcPxPe+2dUgrz+cXuWjSfjFJeG3HDHbdLljSjg==
X-Gm-Gg: ASbGncu9P9PaMkMMJGiQ1miQDyRuSZbEBuSMxOETb+wxVSrqvhVGERSb9RBnVI99naa
	la9AHObI1df60SPX0THLOnvm06nYzIHtuMPpfD0FyAexn4a97NOTrqs1GGtEyPsjQ/VhOsAf+a5
	55A+purK7f0SvAtlCRaQeqZoVx+Dhx9zPTR/LO23phZYV80n6uuVf8AI7Nk7TjXMRHe3+d6NvW/
	/WXazDjhNKxQf0PwgEQGuBjShq/0sx/p3NOi9zQsS9FLCyQWr3M5R0WSW1HsCma7UHjzh2dvOiv
	7QLFW0ZcoObYUiib1DqlipG9ec2C/JMfodPjRxnNS45lTU62vq+X0gUSOdKeM1j+1a7vIYG7JQL
	r49U0jQQKAN/c/QxhlAlhi7BWf/Xp/1phvui/VB7hMcfylRV+EhQvIA==
X-Google-Smtp-Source: AGHT+IGW5apvuB2qbzB8r8NOgkvnl+XaH2tHsJTl/Wz9+nvNuLxI/NfqAyPVAZ7X1tM006QAVx5Zog==
X-Received: by 2002:a05:622a:5a8f:b0:476:7b0b:30fb with SMTP id d75a77b69052e-49495c9c44bmr109473731cf.22.1747314618822;
        Thu, 15 May 2025 06:10:18 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:18 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 02/49] selinux: introduce current_selinux_state
Date: Thu, 15 May 2025 09:09:00 -0400
Message-ID: <20250515130947.52806-3-stephen.smalley.work@gmail.com>
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

Rename selinux_state to init_selinux_state, make it static, and
introduce a current_selinux_state pointer initialized to it that
can be used everywhere we were previously directly referencing
selinux_state.  This is in preparation for future changes where
multiple selinux states (aka namespaces) will be supported and
current_selinux_state will refer to the correct one for the current
process.

Note that passing the current selinux state is not correct for
all hooks; some hooks will need to be adjusted to pass the selinux
state associated with an open file, a network namespace or socket,
etc, since not all hooks are invoked in process context and some
hooks operate in the context of a cred that may differ from current's
cred.  Fixing all of these cases is left to future changes, once
we introduce the support for multiple selinux namespaces.

This change by itself should have no effect on SELinux behavior or
APIs (userspace or LSM).

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            | 428 ++++++++++++++--------------
 security/selinux/ibpkey.c           |   2 +-
 security/selinux/include/security.h |  35 ++-
 security/selinux/netif.c            |   2 +-
 security/selinux/netlabel.c         |  12 +-
 security/selinux/netnode.c          |   4 +-
 security/selinux/netport.c          |   2 +-
 security/selinux/selinuxfs.c        |  36 +--
 security/selinux/ss/services.c      |   4 +-
 security/selinux/xfrm.c             |  16 +-
 10 files changed, 277 insertions(+), 264 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9eeed98fa534..2cb568c04fea 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -108,7 +108,8 @@
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
-struct selinux_state selinux_state;
+static struct selinux_state init_selinux_state;
+struct selinux_state *current_selinux_state;
 
 /* SECMARK reference count */
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
@@ -280,7 +281,7 @@ static int __inode_security_revalidate(struct inode *inode,
 				       struct dentry *dentry,
 				       bool may_sleep)
 {
-	if (!selinux_initialized(&selinux_state))
+	if (!selinux_initialized(current_selinux_state))
 		return 0;
 
 	if (may_sleep)
@@ -441,13 +442,13 @@ static int may_context_mount_sb_relabel(u32 sid,
 	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  tsec->sid, sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELTO, NULL);
 	return rc;
@@ -459,13 +460,13 @@ static int may_context_mount_inode_relabel(u32 sid,
 {
 	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__ASSOCIATE, NULL);
 	return rc;
@@ -549,7 +550,7 @@ static int sb_check_xattr_support(struct super_block *sb)
 
 fallback:
 	/* No xattr support - try to fallback to genfs if possible. */
-	rc = security_genfs_sid(&selinux_state, sb->s_type->name, "/",
+	rc = security_genfs_sid(current_selinux_state, sb->s_type->name, "/",
 				SECCLASS_DIR, &sid);
 	if (rc)
 		return -EOPNOTSUPP;
@@ -660,7 +661,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 
 	mutex_lock(&sbsec->lock);
 
-	if (!selinux_initialized(&selinux_state)) {
+	if (!selinux_initialized(current_selinux_state)) {
 		if (!opts) {
 			/* Defer initialization until selinux_complete_init,
 			   after the initial policy is loaded and the security
@@ -759,7 +760,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		 * Determine the labeling behavior to use for this
 		 * filesystem type.
 		 */
-		rc = security_fs_use(&selinux_state, sb);
+		rc = security_fs_use(current_selinux_state, sb);
 		if (rc) {
 			pr_warn("%s: security_fs_use(%s) returned %d\n",
 					__func__, sb->s_type->name, rc);
@@ -784,7 +785,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		}
 		if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
 			sbsec->behavior = SECURITY_FS_USE_MNTPOINT;
-			rc = security_transition_sid(&selinux_state,
+			rc = security_transition_sid(current_selinux_state,
 						     current_sid(),
 						     current_sid(),
 						     SECCLASS_FILE, NULL,
@@ -943,7 +944,7 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 	 * if the parent was able to be mounted it clearly had no special lsm
 	 * mount options.  thus we can safely deal with this superblock later
 	 */
-	if (!selinux_initialized(&selinux_state)) {
+	if (!selinux_initialized(current_selinux_state)) {
 		if (kern_flags & SECURITY_LSM_NATIVE_LABELS) {
 			newsbsec->flags |= SE_SBNATIVE;
 			*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
@@ -970,7 +971,7 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 
 	if (newsbsec->behavior == SECURITY_FS_USE_NATIVE &&
 		!(kern_flags & SECURITY_LSM_NATIVE_LABELS) && !set_context) {
-		rc = security_fs_use(&selinux_state, newsb);
+		rc = security_fs_use(current_selinux_state, newsb);
 		if (rc)
 			goto out;
 	}
@@ -1019,7 +1020,7 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 	if (!s)
 		return -EINVAL;
 
-	if (!selinux_initialized(&selinux_state)) {
+	if (!selinux_initialized(current_selinux_state)) {
 		pr_warn("SELinux: Unable to set superblock options before the security server is initialized\n");
 		return -EINVAL;
 	}
@@ -1056,7 +1057,8 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		WARN_ON(1);
 		return -EINVAL;
 	}
-	rc = security_context_str_to_sid(&selinux_state, s, dst_sid, GFP_KERNEL);
+	rc = security_context_str_to_sid(current_selinux_state, s, dst_sid,
+					 GFP_KERNEL);
 	if (rc)
 		pr_warn("SELinux: security_context_str_to_sid (%s) failed with errno=%d\n",
 			s, rc);
@@ -1073,7 +1075,7 @@ static int show_sid(struct seq_file *m, u32 sid)
 	u32 len;
 	int rc;
 
-	rc = security_sid_to_context(&selinux_state, sid,
+	rc = security_sid_to_context(current_selinux_state, sid,
 					     &context, &len);
 	if (!rc) {
 		bool has_comma = strchr(context, ',');
@@ -1097,7 +1099,7 @@ static int selinux_sb_show_options(struct seq_file *m, struct super_block *sb)
 	if (!(sbsec->flags & SE_SBINITIALIZED))
 		return 0;
 
-	if (!selinux_initialized(&selinux_state))
+	if (!selinux_initialized(current_selinux_state))
 		return 0;
 
 	if (sbsec->flags & FSCONTEXT_MNT) {
@@ -1351,7 +1353,7 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 				path++;
 			}
 		}
-		rc = security_genfs_sid(&selinux_state, sb->s_type->name,
+		rc = security_genfs_sid(current_selinux_state, sb->s_type->name,
 					path, tclass, sid);
 		if (rc == -ENOENT) {
 			/* No match in policy, mark as unlabeled. */
@@ -1406,8 +1408,8 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
 		return 0;
 	}
 
-	rc = security_context_to_sid_default(&selinux_state, context, rc, sid,
-					     def_sid, GFP_NOFS);
+	rc = security_context_to_sid_default(current_selinux_state, context, rc,
+					     sid, def_sid, GFP_NOFS);
 	if (rc) {
 		char *dev = inode->i_sb->s_id;
 		unsigned long ino = inode->i_ino;
@@ -1516,7 +1518,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		sid = sbsec->sid;
 
 		/* Try to obtain a transition SID. */
-		rc = security_transition_sid(&selinux_state, task_sid, sid,
+		rc = security_transition_sid(current_selinux_state, task_sid, sid,
 					     sclass, NULL, &sid);
 		if (rc)
 			goto out;
@@ -1661,10 +1663,10 @@ static int cred_has_capability(const struct cred *cred,
 		return -EINVAL;
 	}
 
-	rc = avc_has_perm_noaudit(&selinux_state,
+	rc = avc_has_perm_noaudit(current_selinux_state,
 				  sid, sid, sclass, av, 0, &avd);
 	if (!(opts & CAP_OPT_NOAUDIT)) {
-		int rc2 = avc_audit(&selinux_state,
+		int rc2 = avc_audit(current_selinux_state,
 				    sid, sid, sclass, av, &avd, rc, &ad);
 		if (rc2)
 			return rc2;
@@ -1689,7 +1691,7 @@ static int inode_has_perm(const struct cred *cred,
 	sid = cred_sid(cred);
 	isec = selinux_inode(inode);
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, isec->sclass, perms, adp);
 }
 
@@ -1769,7 +1771,7 @@ static int file_has_perm(const struct cred *cred,
 	ad.u.file = file;
 
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, fsec->sid,
 				  SECCLASS_FD,
 				  FD__USE,
@@ -1813,7 +1815,7 @@ selinux_determine_inode_label(const struct task_security_struct *tsec,
 		*_new_isid = tsec->create_sid;
 	} else {
 		const struct inode_security_struct *dsec = inode_security(dir);
-		return security_transition_sid(&selinux_state, tsec->sid,
+		return security_transition_sid(current_selinux_state, tsec->sid,
 					       dsec->sid, tclass,
 					       name, _new_isid);
 	}
@@ -1841,7 +1843,7 @@ static int may_create(struct inode *dir,
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, dsec->sid, SECCLASS_DIR,
 			  DIR__ADD_NAME | DIR__SEARCH,
 			  &ad);
@@ -1853,12 +1855,12 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, newsid, tclass, FILE__CREATE, &ad);
 	if (rc)
 		return rc;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    newsid, sbsec->sid,
 			    SECCLASS_FILESYSTEM,
 			    FILESYSTEM__ASSOCIATE, &ad);
@@ -1888,7 +1890,7 @@ static int may_link(struct inode *dir,
 
 	av = DIR__SEARCH;
 	av |= (kind ? DIR__REMOVE_NAME : DIR__ADD_NAME);
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, dsec->sid, SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
@@ -1909,7 +1911,7 @@ static int may_link(struct inode *dir,
 		return 0;
 	}
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, isec->sid, isec->sclass, av, &ad);
 	return rc;
 }
@@ -1934,18 +1936,18 @@ static inline int may_rename(struct inode *old_dir,
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 
 	ad.u.dentry = old_dentry;
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, old_dsec->sid, SECCLASS_DIR,
 			  DIR__REMOVE_NAME | DIR__SEARCH, &ad);
 	if (rc)
 		return rc;
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, old_isec->sid,
 			  old_isec->sclass, FILE__RENAME, &ad);
 	if (rc)
 		return rc;
 	if (old_is_dir && new_dir != old_dir) {
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, old_isec->sid,
 				  old_isec->sclass, DIR__REPARENT, &ad);
 		if (rc)
@@ -1956,14 +1958,14 @@ static inline int may_rename(struct inode *old_dir,
 	av = DIR__ADD_NAME | DIR__SEARCH;
 	if (d_is_positive(new_dentry))
 		av |= DIR__REMOVE_NAME;
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, new_dsec->sid, SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
 	if (d_is_positive(new_dentry)) {
 		new_isec = backing_inode_security(new_dentry);
 		new_is_dir = d_is_dir(new_dentry);
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, new_isec->sid,
 				  new_isec->sclass,
 				  (new_is_dir ? DIR__RMDIR : FILE__UNLINK), &ad);
@@ -1984,7 +1986,7 @@ static int superblock_has_perm(const struct cred *cred,
 	u32 sid = cred_sid(cred);
 
 	sbsec = selinux_superblock(sb);
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
 }
 
@@ -2059,7 +2061,7 @@ static inline u32 open_file_to_av(struct file *file)
 
 static int selinux_binder_set_context_mgr(const struct cred *mgr)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), cred_sid(mgr), SECCLASS_BINDER,
 			    BINDER__SET_CONTEXT_MGR, NULL);
 }
@@ -2073,21 +2075,21 @@ static int selinux_binder_transaction(const struct cred *from,
 	int rc;
 
 	if (mysid != fromsid) {
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  mysid, fromsid, SECCLASS_BINDER,
 				  BINDER__IMPERSONATE, NULL);
 		if (rc)
 			return rc;
 	}
 
-	return avc_has_perm(&selinux_state, fromsid, tosid,
+	return avc_has_perm(current_selinux_state, fromsid, tosid,
 			    SECCLASS_BINDER, BINDER__CALL, NULL);
 }
 
 static int selinux_binder_transfer_binder(const struct cred *from,
 					  const struct cred *to)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    cred_sid(from), cred_sid(to),
 			    SECCLASS_BINDER, BINDER__TRANSFER,
 			    NULL);
@@ -2108,7 +2110,7 @@ static int selinux_binder_transfer_file(const struct cred *from,
 	ad.u.path = file->f_path;
 
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, fsec->sid,
 				  SECCLASS_FD,
 				  FD__USE,
@@ -2127,7 +2129,7 @@ static int selinux_binder_transfer_file(const struct cred *from,
 		return 0;
 
 	isec = backing_inode_security(dentry);
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, isec->sclass, file_to_av(file),
 			    &ad);
 }
@@ -2139,16 +2141,16 @@ static int selinux_ptrace_access_check(struct task_struct *child,
 	u32 csid = task_sid_obj(child);
 
 	if (mode & PTRACE_MODE_READ)
-		return avc_has_perm(&selinux_state,
+		return avc_has_perm(current_selinux_state,
 				    sid, csid, SECCLASS_FILE, FILE__READ, NULL);
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, csid, SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
 }
 
 static int selinux_ptrace_traceme(struct task_struct *parent)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    task_sid_obj(parent), task_sid_obj(current),
 			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
 }
@@ -2156,7 +2158,7 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
 static int selinux_capget(const struct task_struct *target, kernel_cap_t *effective,
 			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(target), SECCLASS_PROCESS,
 			    PROCESS__GETCAP, NULL);
 }
@@ -2166,7 +2168,7 @@ static int selinux_capset(struct cred *new, const struct cred *old,
 			  const kernel_cap_t *inheritable,
 			  const kernel_cap_t *permitted)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    cred_sid(old), cred_sid(new), SECCLASS_PROCESS,
 			    PROCESS__SETCAP, NULL);
 }
@@ -2234,20 +2236,20 @@ static int selinux_syslog(int type)
 	switch (type) {
 	case SYSLOG_ACTION_READ_ALL:	/* Read last kernel messages */
 	case SYSLOG_ACTION_SIZE_BUFFER:	/* Return size of the log buffer */
-		return avc_has_perm(&selinux_state,
+		return avc_has_perm(current_selinux_state,
 				    current_sid(), SECINITSID_KERNEL,
 				    SECCLASS_SYSTEM, SYSTEM__SYSLOG_READ, NULL);
 	case SYSLOG_ACTION_CONSOLE_OFF:	/* Disable logging to console */
 	case SYSLOG_ACTION_CONSOLE_ON:	/* Enable logging to console */
 	/* Set level of messages printed to console */
 	case SYSLOG_ACTION_CONSOLE_LEVEL:
-		return avc_has_perm(&selinux_state,
+		return avc_has_perm(current_selinux_state,
 				    current_sid(), SECINITSID_KERNEL,
 				    SECCLASS_SYSTEM, SYSTEM__SYSLOG_CONSOLE,
 				    NULL);
 	}
 	/* All other syslog types */
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), SECINITSID_KERNEL,
 			    SECCLASS_SYSTEM, SYSTEM__SYSLOG_MOD, NULL);
 }
@@ -2308,7 +2310,7 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 			av |= PROCESS2__NNP_TRANSITION;
 		if (nosuid)
 			av |= PROCESS2__NOSUID_TRANSITION;
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  old_tsec->sid, new_tsec->sid,
 				  SECCLASS_PROCESS2, av, NULL);
 		if (!rc)
@@ -2320,7 +2322,7 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 	 * i.e. SIDs that are guaranteed to only be allowed a subset
 	 * of the permissions of the current SID.
 	 */
-	rc = security_bounded_transition(&selinux_state, old_tsec->sid,
+	rc = security_bounded_transition(current_selinux_state, old_tsec->sid,
 					 new_tsec->sid);
 	if (!rc)
 		return 0;
@@ -2366,7 +2368,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	 * early boot end up with a label different from SECINITSID_KERNEL
 	 * (if the policy chooses to set SECINITSID_INIT != SECINITSID_KERNEL).
 	 */
-	if (!selinux_initialized(&selinux_state)) {
+	if (!selinux_initialized(current_selinux_state)) {
 		new_tsec->sid = SECINITSID_INIT;
 		/* also clear the exec_sid just in case */
 		new_tsec->exec_sid = 0;
@@ -2384,7 +2386,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 			return rc;
 	} else {
 		/* Check for a default transition on this program. */
-		rc = security_transition_sid(&selinux_state, old_tsec->sid,
+		rc = security_transition_sid(current_selinux_state, old_tsec->sid,
 					     isec->sid, SECCLASS_PROCESS, NULL,
 					     &new_tsec->sid);
 		if (rc)
@@ -2403,20 +2405,20 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	ad.u.file = bprm->file;
 
 	if (new_tsec->sid == old_tsec->sid) {
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  old_tsec->sid, isec->sid,
 				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
 		if (rc)
 			return rc;
 	} else {
 		/* Check permissions for the transition. */
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  old_tsec->sid, new_tsec->sid,
 				  SECCLASS_PROCESS, PROCESS__TRANSITION, &ad);
 		if (rc)
 			return rc;
 
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  new_tsec->sid, isec->sid,
 				  SECCLASS_FILE, FILE__ENTRYPOINT, &ad);
 		if (rc)
@@ -2424,7 +2426,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 
 		/* Check for shared state */
 		if (bprm->unsafe & LSM_UNSAFE_SHARE) {
-			rc = avc_has_perm(&selinux_state,
+			rc = avc_has_perm(current_selinux_state,
 					  old_tsec->sid, new_tsec->sid,
 					  SECCLASS_PROCESS, PROCESS__SHARE,
 					  NULL);
@@ -2437,7 +2439,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 		if (bprm->unsafe & LSM_UNSAFE_PTRACE) {
 			u32 ptsid = ptrace_parent_sid();
 			if (ptsid != 0) {
-				rc = avc_has_perm(&selinux_state,
+				rc = avc_has_perm(current_selinux_state,
 						  ptsid, new_tsec->sid,
 						  SECCLASS_PROCESS,
 						  PROCESS__PTRACE, NULL);
@@ -2452,7 +2454,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 		/* Enable secure mode for SIDs transitions unless
 		   the noatsecure permission is granted between
 		   the two SIDs, i.e. ahp returns 0. */
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  old_tsec->sid, new_tsec->sid,
 				  SECCLASS_PROCESS, PROCESS__NOATSECURE,
 				  NULL);
@@ -2545,7 +2547,7 @@ static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
 	 * higher than the default soft limit for cases where the default is
 	 * lower than the hard limit, e.g. RLIMIT_CORE or RLIMIT_STACK.
 	 */
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  new_tsec->osid, new_tsec->sid, SECCLASS_PROCESS,
 			  PROCESS__RLIMITINH, NULL);
 	if (rc) {
@@ -2585,7 +2587,7 @@ static void selinux_bprm_committed_creds(const struct linux_binprm *bprm)
 	 * This must occur _after_ the task SID has been updated so that any
 	 * kill done after the flush will be checked against the new SID.
 	 */
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  osid, sid, SECCLASS_PROCESS, PROCESS__SIGINH, NULL);
 	if (rc) {
 		clear_itimer();
@@ -2941,8 +2943,8 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 		*xattr_name = XATTR_NAME_SELINUX;
 
 	cp->id = LSM_ID_SELINUX;
-	return security_sid_to_context(&selinux_state, newsid, &cp->context,
-				       &cp->len);
+	return security_sid_to_context(current_selinux_state, newsid,
+				       &cp->context, &cp->len);
 }
 
 static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
@@ -2994,12 +2996,12 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 		isec->initialized = LABEL_INITIALIZED;
 	}
 
-	if (!selinux_initialized(&selinux_state) ||
+	if (!selinux_initialized(current_selinux_state) ||
 	    !(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
 	if (xattr) {
-		rc = security_sid_to_context_force(&selinux_state, newsid,
+		rc = security_sid_to_context_force(current_selinux_state, newsid,
 						   &context, &clen);
 		if (rc)
 			return rc;
@@ -3020,7 +3022,7 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 	struct inode_security_struct *isec;
 	int rc;
 
-	if (unlikely(!selinux_initialized(&selinux_state)))
+	if (unlikely(!selinux_initialized(current_selinux_state)))
 		return 0;
 
 	isec = selinux_inode(inode);
@@ -3044,7 +3046,7 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 	} else {
 		isec->sclass = SECCLASS_ANON_INODE;
 		rc = security_transition_sid(
-			&selinux_state, sid, sid,
+			current_selinux_state, sid, sid,
 			isec->sclass, name, &isec->sid);
 		if (rc)
 			return rc;
@@ -3059,7 +3061,7 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 	ad.type = LSM_AUDIT_DATA_ANONINODE;
 	ad.u.anonclass = name ? (const char *)name->name : "?";
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid,
 			    isec->sid,
 			    isec->sclass,
@@ -3128,7 +3130,7 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 				  sid, isec->sid, isec->sclass, FILE__READ, &ad);
 }
 
@@ -3142,7 +3144,7 @@ static noinline int audit_inode_permission(struct inode *inode,
 	ad.type = LSM_AUDIT_DATA_INODE;
 	ad.u.inode = inode;
 
-	return slow_avc_audit(&selinux_state,
+	return slow_avc_audit(current_selinux_state,
 			    current_sid(), isec->sid, isec->sclass, perms,
 			    audited, denied, result, &ad);
 }
@@ -3158,7 +3160,7 @@ static inline void task_avdcache_reset(struct task_security_struct *tsec)
 {
 	memset(&tsec->avdcache.dir, 0, sizeof(tsec->avdcache.dir));
 	tsec->avdcache.sid = tsec->sid;
-	tsec->avdcache.seqno = avc_policy_seqno(&selinux_state);
+	tsec->avdcache.seqno = avc_policy_seqno(current_selinux_state);
 	tsec->avdcache.dir_spot = TSEC_AVDC_DIR_SIZE - 1;
 }
 
@@ -3182,7 +3184,7 @@ static inline int task_avdcache_search(struct task_security_struct *tsec,
 		return -ENOENT;
 
 	if (unlikely(tsec->sid != tsec->avdcache.sid ||
-		     tsec->avdcache.seqno != avc_policy_seqno(&selinux_state))) {
+		     tsec->avdcache.seqno != avc_policy_seqno(current_selinux_state))) {
 		task_avdcache_reset(tsec);
 		return -ENOENT;
 	}
@@ -3266,14 +3268,14 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 		/* Cache hit. */
 		audited = perms & avdc->audited;
 		denied = perms & ~avdc->allowed;
-		if (unlikely(denied && enforcing_enabled(&selinux_state) &&
+		if (unlikely(denied && enforcing_enabled(current_selinux_state) &&
 			     !avdc->permissive))
 			rc = -EACCES;
 	} else {
 		struct av_decision avd;
 
 		/* Cache miss. */
-		rc = avc_has_perm_noaudit(&selinux_state, tsec->sid,
+		rc = avc_has_perm_noaudit(current_selinux_state, tsec->sid,
 					  isec->sid, isec->sclass, perms, 0,
 					  &avd);
 		audited = avc_audit_required(perms, &avd, rc,
@@ -3370,7 +3372,7 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	if (strcmp(name, XATTR_NAME_SELINUX))
 		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
 
-	if (!selinux_initialized(&selinux_state))
+	if (!selinux_initialized(current_selinux_state))
 		return (inode_owner_or_capable(idmap, inode) ? 0 : -EPERM);
 
 	sbsec = selinux_superblock(inode->i_sb);
@@ -3384,13 +3386,13 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	ad.u.dentry = dentry;
 
 	isec = backing_inode_security(dentry);
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, isec->sid, isec->sclass,
 			  FILE__RELABELFROM, &ad);
 	if (rc)
 		return rc;
 
-	rc = security_context_to_sid(&selinux_state, value, size, &newsid,
+	rc = security_context_to_sid(current_selinux_state, value, size, &newsid,
 				     GFP_KERNEL);
 	if (rc == -EINVAL) {
 		if (!has_cap_mac_admin(true)) {
@@ -3419,24 +3421,24 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 
 			return rc;
 		}
-		rc = security_context_to_sid_force(&selinux_state, value,
+		rc = security_context_to_sid_force(current_selinux_state, value,
 						   size, &newsid);
 	}
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, newsid, isec->sclass,
 			  FILE__RELABELTO, &ad);
 	if (rc)
 		return rc;
 
-	rc = security_validate_transition(&selinux_state, isec->sid, newsid,
+	rc = security_validate_transition(current_selinux_state, isec->sid, newsid,
 					  sid, isec->sclass);
 	if (rc)
 		return rc;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    newsid,
 			    sbsec->sid,
 			    SECCLASS_FILESYSTEM,
@@ -3477,7 +3479,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 		return;
 	}
 
-	if (!selinux_initialized(&selinux_state)) {
+	if (!selinux_initialized(current_selinux_state)) {
 		/* If we haven't even been initialized, then we can't validate
 		 * against a policy, so leave the label as invalid. It may
 		 * resolve to a valid label on the next revalidation try if
@@ -3486,7 +3488,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 		return;
 	}
 
-	rc = security_context_to_sid_force(&selinux_state, value, size,
+	rc = security_context_to_sid_force(current_selinux_state, value, size,
 					   &newsid);
 	if (rc) {
 		pr_err("SELinux:  unable to map context to SID"
@@ -3524,7 +3526,7 @@ static int selinux_inode_removexattr(struct mnt_idmap *idmap,
 	if (strcmp(name, XATTR_NAME_SELINUX))
 		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
 
-	if (!selinux_initialized(&selinux_state))
+	if (!selinux_initialized(current_selinux_state))
 		return 0;
 
 	/* No one is allowed to remove a SELinux security label.
@@ -3598,7 +3600,7 @@ static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
 	 * If we're not initialized yet, then we can't validate contexts, so
 	 * just let vfs_getxattr fall back to using the on-disk xattr.
 	 */
-	if (!selinux_initialized(&selinux_state) ||
+	if (!selinux_initialized(current_selinux_state) ||
 	    strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
 
@@ -3613,11 +3615,11 @@ static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
 	 */
 	isec = inode_security(inode);
 	if (has_cap_mac_admin(false))
-		error = security_sid_to_context_force(&selinux_state,
+		error = security_sid_to_context_force(current_selinux_state,
 						      isec->sid, &context,
 						      &size);
 	else
-		error = security_sid_to_context(&selinux_state, isec->sid,
+		error = security_sid_to_context(current_selinux_state, isec->sid,
 						&context, &size);
 	if (error)
 		return error;
@@ -3649,7 +3651,7 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 	if (!value || !size)
 		return -EACCES;
 
-	rc = security_context_to_sid(&selinux_state, value, size, &newsid,
+	rc = security_context_to_sid(current_selinux_state, value, size, &newsid,
 				     GFP_KERNEL);
 	if (rc)
 		return rc;
@@ -3666,7 +3668,7 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
 {
 	const int len = sizeof(XATTR_NAME_SELINUX);
 
-	if (!selinux_initialized(&selinux_state))
+	if (!selinux_initialized(current_selinux_state))
 		return 0;
 
 	if (buffer && len <= buffer_size)
@@ -3708,7 +3710,7 @@ static int selinux_inode_copy_up_xattr(struct dentry *dentry, const char *name)
 	 * xattrs up.  Instead, filter out SELinux-related xattrs following
 	 * policy load.
 	 */
-	if (selinux_initialized(&selinux_state) &&
+	if (selinux_initialized(current_selinux_state) &&
 	    !strcmp(name, XATTR_NAME_SELINUX))
 		return -ECANCELED; /* Discard */
 
@@ -3746,8 +3748,8 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 		return rc;
 	}
 
-	rc = security_context_to_sid(&selinux_state, context, clen, &parent_sid,
-				     GFP_KERNEL);
+	rc = security_context_to_sid(current_selinux_state, context, clen,
+				     &parent_sid, GFP_KERNEL);
 	kfree(context);
 	if (rc)
 		return rc;
@@ -3764,14 +3766,14 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 		q.name = kn_name;
 		q.hash_len = hashlen_string(kn_dir, kn_name);
 
-		rc = security_transition_sid(&selinux_state, tsec->sid,
+		rc = security_transition_sid(current_selinux_state, tsec->sid,
 					     parent_sid, secclass, &q,
 					     &newsid);
 		if (rc)
 			return rc;
 	}
 
-	rc = security_sid_to_context_force(&selinux_state, newsid,
+	rc = security_sid_to_context_force(current_selinux_state, newsid,
 					   &context, &clen);
 	if (rc)
 		return rc;
@@ -3811,7 +3813,7 @@ static int selinux_file_permission(struct file *file, int mask)
 
 	isec = inode_security(inode);
 	if (sid == fsec->sid && fsec->isid == isec->sid &&
-	    fsec->pseqno == avc_policy_seqno(&selinux_state))
+	    fsec->pseqno == avc_policy_seqno(current_selinux_state))
 		/* No change since file_open check. */
 		return 0;
 
@@ -3852,7 +3854,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	ad.u.op->path = file->f_path;
 
 	if (ssid != fsec->sid) {
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  ssid, fsec->sid,
 				SECCLASS_FD,
 				FD__USE,
@@ -3865,7 +3867,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 		return 0;
 
 	isec = inode_security(inode);
-	rc = avc_has_extended_perms(&selinux_state,
+	rc = avc_has_extended_perms(current_selinux_state,
 				    ssid, isec->sid, isec->sclass,
 				    requested, driver, AVC_EXT_IOCTL, xperm,
 				    &ad);
@@ -3963,7 +3965,7 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 		 * private file mapping that will also be writable.
 		 * This has an additional check.
 		 */
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, sid, SECCLASS_PROCESS,
 				  PROCESS__EXECMEM, NULL);
 		if (rc)
@@ -3994,7 +3996,7 @@ static int selinux_mmap_addr(unsigned long addr)
 
 	if (addr < CONFIG_LSM_MMAP_MIN_ADDR) {
 		u32 sid = current_sid();
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, sid, SECCLASS_MEMPROTECT,
 				  MEMPROTECT__MMAP_ZERO, NULL);
 	}
@@ -4043,12 +4045,12 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 		 */
 		if (vma->vm_start >= vma->vm_mm->start_brk &&
 		    vma->vm_end <= vma->vm_mm->brk) {
-			rc = avc_has_perm(&selinux_state,
+			rc = avc_has_perm(current_selinux_state,
 					  sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECHEAP, NULL);
 		} else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
 			    vma_is_stack_for_current(vma))) {
-			rc = avc_has_perm(&selinux_state,
+			rc = avc_has_perm(current_selinux_state,
 					  sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECSTACK, NULL);
 		} else if (vma->vm_file && vma->anon_vma) {
@@ -4141,7 +4143,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 	else
 		perm = signal_to_av(signum);
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    fsec->fown_sid, sid,
 			    SECCLASS_PROCESS, perm, NULL);
 }
@@ -4168,7 +4170,7 @@ static int selinux_file_open(struct file *file)
 	 * struct as its SID.
 	 */
 	fsec->isid = isec->sid;
-	fsec->pseqno = avc_policy_seqno(&selinux_state);
+	fsec->pseqno = avc_policy_seqno(current_selinux_state);
 	/*
 	 * Since the inode label or policy seqno may have changed
 	 * between the selinux_inode_permission check and the saving
@@ -4187,7 +4189,7 @@ static int selinux_task_alloc(struct task_struct *task,
 {
 	u32 sid = current_sid();
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, sid, SECCLASS_PROCESS, PROCESS__FORK, NULL);
 }
 
@@ -4235,7 +4237,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(&selinux_state,
+	ret = avc_has_perm(current_selinux_state,
 			   sid, secid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__USE_AS_OVERRIDE,
@@ -4260,7 +4262,7 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(&selinux_state,
+	ret = avc_has_perm(current_selinux_state,
 			   sid, isec->sid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__CREATE_FILES_AS,
@@ -4278,7 +4280,7 @@ static int selinux_kernel_module_request(char *kmod_name)
 	ad.type = LSM_AUDIT_DATA_KMOD;
 	ad.u.kmod_name = kmod_name;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), SECINITSID_KERNEL, SECCLASS_SYSTEM,
 			    SYSTEM__MODULE_REQUEST, &ad);
 }
@@ -4292,7 +4294,7 @@ static int selinux_kernel_load_from_file(struct file *file, u32 requested)
 	int rc;
 
 	if (file == NULL)
-		return avc_has_perm(&selinux_state,
+		return avc_has_perm(current_selinux_state,
 				    sid, sid, SECCLASS_SYSTEM, requested,
 				    NULL);
 
@@ -4302,14 +4304,14 @@ static int selinux_kernel_load_from_file(struct file *file, u32 requested)
 
 	fsec = selinux_file(file);
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, fsec->sid, SECCLASS_FD, FD__USE, &ad);
 		if (rc)
 			return rc;
 	}
 
 	isec = inode_security(file_inode(file));
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, SECCLASS_SYSTEM, requested, &ad);
 }
 
@@ -4390,21 +4392,21 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
 
 static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__SETPGID, NULL);
 }
 
 static int selinux_task_getpgid(struct task_struct *p)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__GETPGID, NULL);
 }
 
 static int selinux_task_getsid(struct task_struct *p)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__GETSESSION, NULL);
 }
@@ -4422,21 +4424,21 @@ static void selinux_task_getlsmprop_obj(struct task_struct *p,
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_setioprio(struct task_struct *p, int ioprio)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_getioprio(struct task_struct *p)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__GETSCHED, NULL);
 }
@@ -4452,7 +4454,7 @@ static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcre
 		av |= PROCESS__SETRLIMIT;
 	if (flags & LSM_PRLIMIT_READ)
 		av |= PROCESS__GETRLIMIT;
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    cred_sid(cred), cred_sid(tcred),
 			    SECCLASS_PROCESS, av, NULL);
 }
@@ -4467,7 +4469,7 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
 	   later be used as a safe reset point for the soft limit
 	   upon context transitions.  See selinux_bprm_committing_creds. */
 	if (old_rlim->rlim_max != new_rlim->rlim_max)
-		return avc_has_perm(&selinux_state,
+		return avc_has_perm(current_selinux_state,
 				    current_sid(), task_sid_obj(p),
 				    SECCLASS_PROCESS, PROCESS__SETRLIMIT, NULL);
 
@@ -4476,21 +4478,21 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
 
 static int selinux_task_setscheduler(struct task_struct *p)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_getscheduler(struct task_struct *p)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__GETSCHED, NULL);
 }
 
 static int selinux_task_movememory(struct task_struct *p)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__SETSCHED, NULL);
 }
@@ -4509,7 +4511,7 @@ static int selinux_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 		secid = current_sid();
 	else
 		secid = cred_sid(cred);
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    secid, task_sid_obj(p), SECCLASS_PROCESS, perm, NULL);
 }
 
@@ -4530,7 +4532,7 @@ static int selinux_userns_create(const struct cred *cred)
 {
 	u32 sid = current_sid();
 
-	return avc_has_perm(&selinux_state, sid, sid, SECCLASS_USER_NAMESPACE,
+	return avc_has_perm(current_selinux_state, sid, sid, SECCLASS_USER_NAMESPACE,
 						USER_NAMESPACE__CREATE, NULL);
 }
 
@@ -4789,7 +4791,7 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
 	if (unlikely(err))
 		return -EACCES;
 
-	err = security_net_peersid_resolve(&selinux_state, nlbl_sid,
+	err = security_net_peersid_resolve(current_selinux_state, nlbl_sid,
 					   nlbl_type, xfrm_sid, sid);
 	if (unlikely(err)) {
 		pr_warn(
@@ -4818,7 +4820,7 @@ static int selinux_conn_sid(u32 sk_sid, u32 skb_sid, u32 *conn_sid)
 	int err = 0;
 
 	if (skb_sid != SECSID_NULL)
-		err = security_sid_mls_copy(&selinux_state, sk_sid, skb_sid,
+		err = security_sid_mls_copy(current_selinux_state, sk_sid, skb_sid,
 					    conn_sid);
 	else
 		*conn_sid = sk_sid;
@@ -4836,7 +4838,7 @@ static int socket_sockcreate_sid(const struct task_security_struct *tsec,
 		return 0;
 	}
 
-	return security_transition_sid(&selinux_state, tsec->sid, tsec->sid,
+	return security_transition_sid(current_selinux_state, tsec->sid, tsec->sid,
 				       secclass, NULL, socksid);
 }
 
@@ -4874,7 +4876,7 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 
 	ad_net_init_from_sk(&ad, &net, sk);
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), sksec->sid, sksec->sclass, perms,
 			    &ad);
 }
@@ -4895,7 +4897,7 @@ static int selinux_socket_create(int family, int type,
 	if (rc)
 		return rc;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    tsec->sid, newsid, secclass, SOCKET__CREATE, NULL);
 }
 
@@ -5032,7 +5034,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 						      snum, &sid);
 				if (err)
 					goto out;
-				err = avc_has_perm(&selinux_state,
+				err = avc_has_perm(current_selinux_state,
 						   sksec->sid, sid,
 						   sksec->sclass,
 						   SOCKET__NAME_BIND, &ad);
@@ -5072,7 +5074,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 		else
 			ad.u.net->v6info.saddr = addr6->sin6_addr;
 
-		err = avc_has_perm(&selinux_state,
+		err = avc_has_perm(current_selinux_state,
 				   sksec->sid, sid,
 				   sksec->sclass, node_perm, &ad);
 		if (err)
@@ -5171,7 +5173,7 @@ static int selinux_socket_connect_helper(struct socket *sock,
 		ad.u.net = &net;
 		ad.u.net->dport = htons(snum);
 		ad.u.net->family = address->sa_family;
-		err = avc_has_perm(&selinux_state,
+		err = avc_has_perm(current_selinux_state,
 				   sksec->sid, sid, sksec->sclass, perm, &ad);
 		if (err)
 			return err;
@@ -5282,7 +5284,7 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 
 	ad_net_init_from_sk(&ad, &net, other);
 
-	err = avc_has_perm(&selinux_state,
+	err = avc_has_perm(current_selinux_state,
 			   sksec_sock->sid, sksec_other->sid,
 			   sksec_other->sclass,
 			   UNIX_STREAM_SOCKET__CONNECTTO, &ad);
@@ -5291,7 +5293,7 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 
 	/* server child socket */
 	sksec_new->peer_sid = sksec_sock->sid;
-	err = security_sid_mls_copy(&selinux_state, sksec_other->sid,
+	err = security_sid_mls_copy(current_selinux_state, sksec_other->sid,
 				    sksec_sock->sid, &sksec_new->sid);
 	if (err)
 		return err;
@@ -5312,7 +5314,7 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 
 	ad_net_init_from_sk(&ad, &net, other->sk);
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    ssec->sid, osec->sid, osec->sclass, SOCKET__SENDTO,
 			    &ad);
 }
@@ -5328,7 +5330,7 @@ static int selinux_inet_sys_rcv_skb(struct net *ns, int ifindex,
 	err = sel_netif_sid(ns, ifindex, &if_sid);
 	if (err)
 		return err;
-	err = avc_has_perm(&selinux_state,
+	err = avc_has_perm(current_selinux_state,
 			   peer_sid, if_sid,
 			   SECCLASS_NETIF, NETIF__INGRESS, ad);
 	if (err)
@@ -5337,7 +5339,7 @@ static int selinux_inet_sys_rcv_skb(struct net *ns, int ifindex,
 	err = sel_netnode_sid(addrp, family, &node_sid);
 	if (err)
 		return err;
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    peer_sid, node_sid,
 			    SECCLASS_NODE, NODE__RECVFROM, ad);
 }
@@ -5358,7 +5360,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 		return err;
 
 	if (selinux_secmark_enabled()) {
-		err = avc_has_perm(&selinux_state,
+		err = avc_has_perm(current_selinux_state,
 				   sk_sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
@@ -5419,7 +5421,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 			selinux_netlbl_err(skb, family, err, 0);
 			return err;
 		}
-		err = avc_has_perm(&selinux_state,
+		err = avc_has_perm(current_selinux_state,
 				   sk_sid, peer_sid, SECCLASS_PEER,
 				   PEER__RECV, &ad);
 		if (err) {
@@ -5429,7 +5431,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (secmark_active) {
-		err = avc_has_perm(&selinux_state,
+		err = avc_has_perm(current_selinux_state,
 				   sk_sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
@@ -5456,7 +5458,7 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 	if (peer_sid == SECSID_NULL)
 		return -ENOPROTOOPT;
 
-	err = security_sid_to_context(&selinux_state, peer_sid, &scontext,
+	err = security_sid_to_context(current_selinux_state, peer_sid, &scontext,
 				      &scontext_len);
 	if (err)
 		return err;
@@ -5606,7 +5608,7 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
 		 * consistency among the peer SIDs.
 		 */
 		ad_net_init_from_sk(&ad, &net, asoc->base.sk);
-		err = avc_has_perm(&selinux_state,
+		err = avc_has_perm(current_selinux_state,
 				   sksec->peer_sid, asoc->peer_secid,
 				   sksec->sclass, SCTP_SOCKET__ASSOCIATION,
 				   &ad);
@@ -5837,7 +5839,7 @@ static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 
 static int selinux_secmark_relabel_packet(u32 sid)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), sid, SECCLASS_PACKET,
 			    PACKET__RELABELTO, NULL);
 }
@@ -5877,7 +5879,7 @@ static int selinux_tun_dev_create(void)
 	 * connections unlike traditional sockets - check the TUN driver to
 	 * get a better understanding of why this socket is special */
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, sid, SECCLASS_TUN_SOCKET, TUN_SOCKET__CREATE,
 			    NULL);
 }
@@ -5886,7 +5888,7 @@ static int selinux_tun_dev_attach_queue(void *security)
 {
 	struct tun_security_struct *tunsec = selinux_tun_dev(security);
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), tunsec->sid, SECCLASS_TUN_SOCKET,
 			    TUN_SOCKET__ATTACH_QUEUE, NULL);
 }
@@ -5915,12 +5917,12 @@ static int selinux_tun_dev_open(void *security)
 	u32 sid = current_sid();
 	int err;
 
-	err = avc_has_perm(&selinux_state,
+	err = avc_has_perm(current_selinux_state,
 			   sid, tunsec->sid, SECCLASS_TUN_SOCKET,
 			   TUN_SOCKET__RELABELFROM, NULL);
 	if (err)
 		return err;
-	err = avc_has_perm(&selinux_state,
+	err = avc_has_perm(current_selinux_state,
 			   sid, sid, SECCLASS_TUN_SOCKET,
 			   TUN_SOCKET__RELABELTO, NULL);
 	if (err)
@@ -5972,7 +5974,7 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 	}
 
 	if (secmark_active)
-		if (avc_has_perm(&selinux_state,
+		if (avc_has_perm(current_selinux_state,
 				 peer_sid, skb->secmark,
 				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
@@ -6050,7 +6052,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 		return NF_DROP;
 
 	if (selinux_secmark_enabled())
-		if (avc_has_perm(&selinux_state,
+		if (avc_has_perm(current_selinux_state,
 				 sksec->sid, skb->secmark,
 				 SECCLASS_PACKET, PACKET__SEND, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
@@ -6173,7 +6175,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 		return NF_DROP;
 
 	if (secmark_active)
-		if (avc_has_perm(&selinux_state,
+		if (avc_has_perm(current_selinux_state,
 				 peer_sid, skb->secmark,
 				 SECCLASS_PACKET, secmark_perm, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
@@ -6184,14 +6186,14 @@ static unsigned int selinux_ip_postroute(void *priv,
 
 		if (sel_netif_sid(state->net, ifindex, &if_sid))
 			return NF_DROP;
-		if (avc_has_perm(&selinux_state,
+		if (avc_has_perm(current_selinux_state,
 				 peer_sid, if_sid,
 				 SECCLASS_NETIF, NETIF__EGRESS, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
 		if (sel_netnode_sid(addrp, family, &node_sid))
 			return NF_DROP;
-		if (avc_has_perm(&selinux_state,
+		if (avc_has_perm(current_selinux_state,
 				 peer_sid, node_sid,
 				 SECCLASS_NODE, NODE__SENDTO, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
@@ -6217,7 +6219,7 @@ static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_t
 	driver = nlmsg_type >> 8;
 	xperm = nlmsg_type & 0xff;
 
-	return avc_has_extended_perms(&selinux_state, current_sid(),
+	return avc_has_extended_perms(current_selinux_state, current_sid(),
 				      sksec->sid, sksec->sclass, perms,
 				      driver, AVC_EXT_NLMSG, xperm, &ad);
 }
@@ -6263,8 +6265,8 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 				sk->sk_protocol, nlh->nlmsg_type,
 				secclass_map[sclass - 1].name,
 				task_pid_nr(current), current->comm);
-			if (enforcing_enabled(&selinux_state) &&
-			    !security_get_allow_unknown(&selinux_state))
+			if (enforcing_enabled(current_selinux_state) &&
+			    !security_get_allow_unknown(current_selinux_state))
 				return rc;
 			rc = 0;
 		} else if (rc == -ENOENT) {
@@ -6303,7 +6305,7 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = ipc_perms->key;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, isec->sclass, perms, &ad);
 }
 
@@ -6330,7 +6332,7 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, SECCLASS_MSGQ,
 			    MSGQ__CREATE, &ad);
 }
@@ -6346,7 +6348,7 @@ static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, SECCLASS_MSGQ,
 			    MSGQ__ASSOCIATE, &ad);
 }
@@ -6359,7 +6361,7 @@ static int selinux_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
 	case IPC_INFO:
 	case MSG_INFO:
 		/* No specific object, just general system-wide information. */
-		return avc_has_perm(&selinux_state,
+		return avc_has_perm(current_selinux_state,
 				    current_sid(), SECINITSID_KERNEL,
 				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case IPC_STAT:
@@ -6399,7 +6401,7 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
 		 * Compute new sid based on current process and
 		 * message queue this message will be stored in
 		 */
-		rc = security_transition_sid(&selinux_state, sid, isec->sid,
+		rc = security_transition_sid(current_selinux_state, sid, isec->sid,
 					     SECCLASS_MSG, NULL, &msec->sid);
 		if (rc)
 			return rc;
@@ -6409,17 +6411,17 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
 	ad.u.ipc_id = msq->key;
 
 	/* Can this process write to the queue? */
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, isec->sid, SECCLASS_MSGQ,
 			  MSGQ__WRITE, &ad);
 	if (!rc)
 		/* Can this process send the message */
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, msec->sid, SECCLASS_MSG,
 				  MSG__SEND, &ad);
 	if (!rc)
 		/* Can the message be put in the queue? */
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  msec->sid, isec->sid, SECCLASS_MSGQ,
 				  MSGQ__ENQUEUE, &ad);
 
@@ -6442,11 +6444,11 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, isec->sid,
 			  SECCLASS_MSGQ, MSGQ__READ, &ad);
 	if (!rc)
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, msec->sid,
 				  SECCLASS_MSG, MSG__RECEIVE, &ad);
 	return rc;
@@ -6465,7 +6467,7 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, SECCLASS_SHM,
 			    SHM__CREATE, &ad);
 }
@@ -6481,7 +6483,7 @@ static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, SECCLASS_SHM,
 			    SHM__ASSOCIATE, &ad);
 }
@@ -6495,7 +6497,7 @@ static int selinux_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
 	case IPC_INFO:
 	case SHM_INFO:
 		/* No specific object, just general system-wide information. */
-		return avc_has_perm(&selinux_state,
+		return avc_has_perm(current_selinux_state,
 				    current_sid(), SECINITSID_KERNEL,
 				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case IPC_STAT:
@@ -6546,7 +6548,7 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, SECCLASS_SEM,
 			    SEM__CREATE, &ad);
 }
@@ -6562,7 +6564,7 @@ static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, SECCLASS_SEM,
 			    SEM__ASSOCIATE, &ad);
 }
@@ -6577,7 +6579,7 @@ static int selinux_sem_semctl(struct kern_ipc_perm *sma, int cmd)
 	case IPC_INFO:
 	case SEM_INFO:
 		/* No specific object, just general system-wide information. */
-		return avc_has_perm(&selinux_state,
+		return avc_has_perm(current_selinux_state,
 				    current_sid(), SECINITSID_KERNEL,
 				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case GETPID:
@@ -6665,7 +6667,7 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 	rcu_read_lock();
 	tsec = selinux_cred(__task_cred(p));
 	if (p != current) {
-		error = avc_has_perm(&selinux_state,
+		error = avc_has_perm(current_selinux_state,
 				     current_sid(), tsec->sid,
 				     SECCLASS_PROCESS, PROCESS__GETATTR, NULL);
 		if (error)
@@ -6701,7 +6703,7 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 		return 0;
 	}
 
-	error = security_sid_to_context(&selinux_state, sid, value, &len);
+	error = security_sid_to_context(current_selinux_state, sid, value, &len);
 	if (error)
 		return error;
 	return len;
@@ -6724,27 +6726,27 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 	 */
 	switch (attr) {
 	case LSM_ATTR_EXEC:
-		error = avc_has_perm(&selinux_state,
+		error = avc_has_perm(current_selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETEXEC, NULL);
 		break;
 	case LSM_ATTR_FSCREATE:
-		error = avc_has_perm(&selinux_state,
+		error = avc_has_perm(current_selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETFSCREATE, NULL);
 		break;
 	case LSM_ATTR_KEYCREATE:
-		error = avc_has_perm(&selinux_state,
+		error = avc_has_perm(current_selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETKEYCREATE, NULL);
 		break;
 	case LSM_ATTR_SOCKCREATE:
-		error = avc_has_perm(&selinux_state,
+		error = avc_has_perm(current_selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETSOCKCREATE, NULL);
 		break;
 	case LSM_ATTR_CURRENT:
-		error = avc_has_perm(&selinux_state,
+		error = avc_has_perm(current_selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETCURRENT, NULL);
 		break;
@@ -6761,7 +6763,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			str[size-1] = 0;
 			size--;
 		}
-		error = security_context_to_sid(&selinux_state, value, size,
+		error = security_context_to_sid(current_selinux_state, value, size,
 						&sid, GFP_KERNEL);
 		if (error == -EINVAL && attr == LSM_ATTR_FSCREATE) {
 			if (!has_cap_mac_admin(true)) {
@@ -6788,7 +6790,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 				return error;
 			}
 			error = security_context_to_sid_force(
-						      &selinux_state,
+						      current_selinux_state,
 						      value, size, &sid);
 		}
 		if (error)
@@ -6812,7 +6814,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		tsec->create_sid = sid;
 	} else if (attr == LSM_ATTR_KEYCREATE) {
 		if (sid) {
-			error = avc_has_perm(&selinux_state, mysid, sid,
+			error = avc_has_perm(current_selinux_state, mysid, sid,
 					     SECCLASS_KEY, KEY__CREATE, NULL);
 			if (error)
 				goto abort_change;
@@ -6826,14 +6828,14 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			goto abort_change;
 
 		if (!current_is_single_threaded()) {
-			error = security_bounded_transition(&selinux_state,
+			error = security_bounded_transition(current_selinux_state,
 							    tsec->sid, sid);
 			if (error)
 				goto abort_change;
 		}
 
 		/* Check permissions for the transition. */
-		error = avc_has_perm(&selinux_state,
+		error = avc_has_perm(current_selinux_state,
 				     tsec->sid, sid, SECCLASS_PROCESS,
 				     PROCESS__DYNTRANSITION, NULL);
 		if (error)
@@ -6843,7 +6845,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		   Otherwise, leave SID unchanged and fail. */
 		ptsid = ptrace_parent_sid();
 		if (ptsid != 0) {
-			error = avc_has_perm(&selinux_state,
+			error = avc_has_perm(current_selinux_state,
 					     ptsid, sid, SECCLASS_PROCESS,
 					     PROCESS__PTRACE, NULL);
 			if (error)
@@ -6939,13 +6941,14 @@ static int selinux_secid_to_secctx(u32 secid, struct lsm_context *cp)
 
 	if (cp) {
 		cp->id = LSM_ID_SELINUX;
-		ret = security_sid_to_context(&selinux_state, secid,
+		ret = security_sid_to_context(current_selinux_state, secid,
 					      &cp->context, &cp->len);
 		if (ret < 0)
 			return ret;
 		return cp->len;
 	}
-	ret = security_sid_to_context(&selinux_state, secid, NULL, &seclen);
+	ret = security_sid_to_context(current_selinux_state, secid, NULL,
+				      &seclen);
 	if (ret < 0)
 		return ret;
 	return seclen;
@@ -6959,7 +6962,7 @@ static int selinux_lsmprop_to_secctx(struct lsm_prop *prop,
 
 static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
-	return security_context_to_sid(&selinux_state, secdata, seclen,
+	return security_context_to_sid(current_selinux_state, secdata, seclen,
 				       secid, GFP_KERNEL);
 }
 
@@ -7072,7 +7075,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	key = key_ref_to_ptr(key_ref);
 	ksec = selinux_key(key);
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
@@ -7083,7 +7086,7 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
 	unsigned len;
 	int rc;
 
-	rc = security_sid_to_context(&selinux_state, ksec->sid,
+	rc = security_sid_to_context(current_selinux_state, ksec->sid,
 				     &context, &len);
 	if (!rc)
 		rc = len;
@@ -7097,7 +7100,7 @@ static int selinux_watch_key(struct key *key)
 	struct key_security_struct *ksec = selinux_key(key);
 	u32 sid = current_sid();
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, ksec->sid, SECCLASS_KEY, KEY__VIEW, NULL);
 }
 #endif
@@ -7120,7 +7123,7 @@ static int selinux_ib_pkey_access(void *ib_sec, u64 subnet_prefix, u16 pkey_val)
 	ibpkey.subnet_prefix = subnet_prefix;
 	ibpkey.pkey = pkey_val;
 	ad.u.ibpkey = &ibpkey;
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sec->sid, sid,
 			    SECCLASS_INFINIBAND_PKEY,
 			    INFINIBAND_PKEY__ACCESS, &ad);
@@ -7135,7 +7138,7 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
 	struct ib_security_struct *sec = ib_sec;
 	struct lsm_ibendport_audit ibendport;
 
-	err = security_ib_endport_sid(&selinux_state, dev_name, port_num,
+	err = security_ib_endport_sid(current_selinux_state, dev_name, port_num,
 				      &sid);
 
 	if (err)
@@ -7145,7 +7148,7 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
 	ibendport.dev_name = dev_name;
 	ibendport.port = port_num;
 	ad.u.ibendport = &ibendport;
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sec->sid, sid,
 			    SECCLASS_INFINIBAND_ENDPORT,
 			    INFINIBAND_ENDPORT__MANAGE_SUBNET, &ad);
@@ -7169,12 +7172,12 @@ static int selinux_bpf(int cmd, union bpf_attr *attr,
 
 	switch (cmd) {
 	case BPF_MAP_CREATE:
-		ret = avc_has_perm(&selinux_state,
+		ret = avc_has_perm(current_selinux_state,
 				   sid, sid, SECCLASS_BPF, BPF__MAP_CREATE,
 				   NULL);
 		break;
 	case BPF_PROG_LOAD:
-		ret = avc_has_perm(&selinux_state,
+		ret = avc_has_perm(current_selinux_state,
 				   sid, sid, SECCLASS_BPF, BPF__PROG_LOAD,
 				   NULL);
 		break;
@@ -7215,7 +7218,7 @@ static int bpf_fd_pass(const struct file *file, u32 sid)
 	if (file->f_op == &bpf_map_fops) {
 		map = file->private_data;
 		bpfsec = map->security;
-		ret = avc_has_perm(&selinux_state,
+		ret = avc_has_perm(current_selinux_state,
 				   sid, bpfsec->sid, SECCLASS_BPF,
 				   bpf_map_fmode_to_av(file->f_mode), NULL);
 		if (ret)
@@ -7223,7 +7226,7 @@ static int bpf_fd_pass(const struct file *file, u32 sid)
 	} else if (file->f_op == &bpf_prog_fops) {
 		prog = file->private_data;
 		bpfsec = prog->aux->security;
-		ret = avc_has_perm(&selinux_state,
+		ret = avc_has_perm(current_selinux_state,
 				   sid, bpfsec->sid, SECCLASS_BPF,
 				   BPF__PROG_RUN, NULL);
 		if (ret)
@@ -7238,7 +7241,7 @@ static int selinux_bpf_map(struct bpf_map *map, fmode_t fmode)
 	struct bpf_security_struct *bpfsec;
 
 	bpfsec = map->security;
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, bpfsec->sid, SECCLASS_BPF,
 			    bpf_map_fmode_to_av(fmode), NULL);
 }
@@ -7249,7 +7252,7 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
 	struct bpf_security_struct *bpfsec;
 
 	bpfsec = prog->aux->security;
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, bpfsec->sid, SECCLASS_BPF,
 			    BPF__PROG_RUN, NULL);
 }
@@ -7357,7 +7360,7 @@ static int selinux_perf_event_open(int type)
 	else
 		return -EINVAL;
 
-	return avc_has_perm(&selinux_state, sid, sid, SECCLASS_PERF_EVENT,
+	return avc_has_perm(current_selinux_state, sid, sid, SECCLASS_PERF_EVENT,
 			    requested, NULL);
 }
 
@@ -7376,7 +7379,7 @@ static int selinux_perf_event_read(struct perf_event *event)
 	struct perf_event_security_struct *perfsec = event->security;
 	u32 sid = current_sid();
 
-	return avc_has_perm(&selinux_state, sid, perfsec->sid,
+	return avc_has_perm(current_selinux_state, sid, perfsec->sid,
 			    SECCLASS_PERF_EVENT, PERF_EVENT__READ, NULL);
 }
 
@@ -7385,7 +7388,7 @@ static int selinux_perf_event_write(struct perf_event *event)
 	struct perf_event_security_struct *perfsec = event->security;
 	u32 sid = current_sid();
 
-	return avc_has_perm(&selinux_state, sid, perfsec->sid,
+	return avc_has_perm(current_selinux_state, sid, perfsec->sid,
 			    SECCLASS_PERF_EVENT, PERF_EVENT__WRITE, NULL);
 }
 #endif
@@ -7400,7 +7403,7 @@ static int selinux_perf_event_write(struct perf_event *event)
  */
 static int selinux_uring_override_creds(const struct cred *new)
 {
-	return avc_has_perm(&selinux_state, current_sid(), cred_sid(new),
+	return avc_has_perm(current_selinux_state, current_sid(), cred_sid(new),
 			    SECCLASS_IO_URING, IO_URING__OVERRIDE_CREDS, NULL);
 }
 
@@ -7414,7 +7417,7 @@ static int selinux_uring_sqpoll(void)
 {
 	u32 sid = current_sid();
 
-	return avc_has_perm(&selinux_state, sid, sid,
+	return avc_has_perm(current_selinux_state, sid, sid,
 			    SECCLASS_IO_URING, IO_URING__SQPOLL, NULL);
 }
 
@@ -7436,7 +7439,7 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 	ad.type = LSM_AUDIT_DATA_FILE;
 	ad.u.file = file;
 
-	return avc_has_perm(&selinux_state, current_sid(), isec->sid,
+	return avc_has_perm(current_selinux_state, current_sid(), isec->sid,
 			    SECCLASS_IO_URING, IO_URING__CMD, &ad);
 }
 
@@ -7449,8 +7452,8 @@ static int selinux_uring_allowed(void)
 {
 	u32 sid = current_sid();
 
-	return avc_has_perm(&selinux_state, sid, sid, SECCLASS_IO_URING,
-			    IO_URING__ALLOWED, NULL);
+	return avc_has_perm(current_selinux_state, sid, sid,
+			    SECCLASS_IO_URING, IO_URING__ALLOWED, NULL);
 }
 #endif /* CONFIG_IO_URING */
 
@@ -7763,11 +7766,12 @@ static __init int selinux_init(void)
 {
 	pr_info("SELinux:  Initializing.\n");
 
-	memset(&selinux_state, 0, sizeof(selinux_state));
-	enforcing_set(&selinux_state, selinux_enforcing_boot);
-	selinux_avc_init(&selinux_state.avc);
-	mutex_init(&selinux_state.status_lock);
-	mutex_init(&selinux_state.policy_mutex);
+	memset(&init_selinux_state, 0, sizeof(init_selinux_state));
+	enforcing_set(&init_selinux_state, selinux_enforcing_boot);
+	selinux_avc_init(&init_selinux_state.avc);
+	mutex_init(&init_selinux_state.status_lock);
+	mutex_init(&init_selinux_state.policy_mutex);
+	current_selinux_state = &init_selinux_state;
 
 	/* Set the security state for the initial task. */
 	cred_init_security();
diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
index 7406706582f5..47739b88f172 100644
--- a/security/selinux/ibpkey.c
+++ b/security/selinux/ibpkey.c
@@ -141,7 +141,7 @@ static int sel_ib_pkey_sid_slow(u64 subnet_prefix, u16 pkey_num, u32 *sid)
 		return 0;
 	}
 
-	ret = security_ib_pkey_sid(&selinux_state, subnet_prefix, pkey_num,
+	ret = security_ib_pkey_sid(current_selinux_state, subnet_prefix, pkey_num,
 				   sid);
 	if (ret)
 		goto out;
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 275a7f8ec41a..40316fcb0c06 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -108,7 +108,7 @@ struct selinux_state {
 
 void selinux_avc_init(struct selinux_avc **avc);
 
-extern struct selinux_state selinux_state;
+extern struct selinux_state *current_selinux_state;
 
 static inline bool selinux_initialized(const struct selinux_state *state)
 {
@@ -151,62 +151,71 @@ static inline bool checkreqprot_get(const struct selinux_state *state)
 
 static inline bool selinux_policycap_netpeer(void)
 {
-	return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_NETPEER]);
+	return READ_ONCE(
+		current_selinux_state->policycap[POLICYDB_CAP_NETPEER]);
 }
 
 static inline bool selinux_policycap_openperm(void)
 {
-	return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_OPENPERM]);
+	return READ_ONCE(
+		current_selinux_state->policycap[POLICYDB_CAP_OPENPERM]);
 }
 
 static inline bool selinux_policycap_extsockclass(void)
 {
-	return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_EXTSOCKCLASS]);
+	return READ_ONCE(
+		current_selinux_state->policycap[POLICYDB_CAP_EXTSOCKCLASS]);
 }
 
 static inline bool selinux_policycap_alwaysnetwork(void)
 {
-	return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_ALWAYSNETWORK]);
+	return READ_ONCE(
+		current_selinux_state->policycap[POLICYDB_CAP_ALWAYSNETWORK]);
 }
 
 static inline bool selinux_policycap_cgroupseclabel(void)
 {
-	return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_CGROUPSECLABEL]);
+	return READ_ONCE(
+		current_selinux_state->policycap[POLICYDB_CAP_CGROUPSECLABEL]);
 }
 
 static inline bool selinux_policycap_nnp_nosuid_transition(void)
 {
 	return READ_ONCE(
-		selinux_state.policycap[POLICYDB_CAP_NNP_NOSUID_TRANSITION]);
+		current_selinux_state
+			->policycap[POLICYDB_CAP_NNP_NOSUID_TRANSITION]);
 }
 
 static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
 {
 	return READ_ONCE(
-		selinux_state.policycap[POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]);
+		current_selinux_state
+			->policycap[POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]);
 }
 
 static inline bool selinux_policycap_ioctl_skip_cloexec(void)
 {
-	return READ_ONCE(
-		selinux_state.policycap[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]);
+	return READ_ONCE(current_selinux_state
+				 ->policycap[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]);
 }
 
 static inline bool selinux_policycap_userspace_initial_context(void)
 {
 	return READ_ONCE(
-		selinux_state.policycap[POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]);
+		current_selinux_state
+			->policycap[POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]);
 }
 
 static inline bool selinux_policycap_netlink_xperm(void)
 {
-	return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_NETLINK_XPERM]);
+	return READ_ONCE(
+		current_selinux_state->policycap[POLICYDB_CAP_NETLINK_XPERM]);
 }
 
 static inline bool selinux_policycap_netif_wildcard(void)
 {
 	return READ_ONCE(
-		selinux_state.policycap[POLICYDB_CAP_NETIF_WILDCARD]);
+		current_selinux_state->policycap[POLICYDB_CAP_NETIF_WILDCARD]);
 }
 
 struct selinux_policy_convert_data;
diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 52718a78f06c..6bd8c434a37a 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -153,7 +153,7 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 		goto out;
 	}
 
-	ret = security_netif_sid(&selinux_state, dev->name, sid);
+	ret = security_netif_sid(current_selinux_state, dev->name, sid);
 	if (ret != 0)
 		goto out;
 
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index b858b46fd4b4..e35c224145a4 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -47,7 +47,7 @@ static int selinux_netlbl_sidlookup_cached(struct sk_buff *skb,
 {
 	int rc;
 
-	rc = security_netlbl_secattr_to_sid(&selinux_state, secattr, sid);
+	rc = security_netlbl_secattr_to_sid(current_selinux_state, secattr, sid);
 	if (rc == 0 &&
 	    (secattr->flags & NETLBL_SECATTR_CACHEABLE) &&
 	    (secattr->flags & NETLBL_SECATTR_CACHE))
@@ -79,7 +79,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
 	if (secattr == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	rc = security_netlbl_sid_to_secattr(&selinux_state, sksec->sid,
+	rc = security_netlbl_sid_to_secattr(current_selinux_state, sksec->sid,
 					    secattr);
 	if (rc != 0) {
 		netlbl_secattr_free(secattr);
@@ -252,7 +252,7 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 	if (secattr == NULL) {
 		secattr = &secattr_storage;
 		netlbl_secattr_init(secattr);
-		rc = security_netlbl_sid_to_secattr(&selinux_state, sid,
+		rc = security_netlbl_sid_to_secattr(current_selinux_state, sid,
 						    secattr);
 		if (rc != 0)
 			goto skbuff_setsid_return;
@@ -290,7 +290,7 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_association *asoc,
 		return 0;
 
 	netlbl_secattr_init(&secattr);
-	rc = security_netlbl_sid_to_secattr(&selinux_state,
+	rc = security_netlbl_sid_to_secattr(current_selinux_state,
 					    asoc->secid, &secattr);
 	if (rc != 0)
 		goto assoc_request_return;
@@ -339,7 +339,7 @@ int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
 		return 0;
 
 	netlbl_secattr_init(&secattr);
-	rc = security_netlbl_sid_to_secattr(&selinux_state, req->secid,
+	rc = security_netlbl_sid_to_secattr(current_selinux_state, req->secid,
 					    &secattr);
 	if (rc != 0)
 		goto inet_conn_request_return;
@@ -473,7 +473,7 @@ int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 		perm = RAWIP_SOCKET__RECVFROM;
 	}
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sksec->sid, nlbl_sid, sksec->sclass, perm, ad);
 	if (rc == 0)
 		return 0;
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 48ba999eebfa..502aefcf2d77 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -207,13 +207,13 @@ static int sel_netnode_sid_slow(const void *addr, u16 family, u32 *sid)
 	new = kmalloc(sizeof(*new), GFP_ATOMIC);
 	switch (family) {
 	case PF_INET:
-		ret = security_node_sid(&selinux_state, PF_INET,
+		ret = security_node_sid(current_selinux_state, PF_INET,
 					addr, sizeof(struct in_addr), sid);
 		if (new)
 			new->nsec.addr.ipv4 = *(const __be32 *)addr;
 		break;
 	case PF_INET6:
-		ret = security_node_sid(&selinux_state, PF_INET6,
+		ret = security_node_sid(current_selinux_state, PF_INET6,
 					addr, sizeof(struct in6_addr), sid);
 		if (new)
 			new->nsec.addr.ipv6 = *(const struct in6_addr *)addr;
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index d7e57cd3ecba..ca07023f3d5a 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -142,7 +142,7 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
 		return 0;
 	}
 
-	ret = security_port_sid(&selinux_state, protocol, pnum, sid);
+	ret = security_port_sid(current_selinux_state, protocol, pnum, sid);
 	if (ret != 0)
 		goto out;
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c9ba0073c1e3..3a1217b6e322 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -90,7 +90,7 @@ static int selinux_fs_info_create(struct super_block *sb)
 		return -ENOMEM;
 
 	fsi->last_ino = SEL_INO_NEXT - 1;
-	fsi->state = &selinux_state;
+	fsi->state = current_selinux_state;
 	fsi->sb = sb;
 	sb->s_fs_info = fsi;
 	return 0;
@@ -165,7 +165,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 
 	old_value = enforcing_enabled(state);
 	if (new_value != old_value) {
-		length = avc_has_perm(&selinux_state,
+		length = avc_has_perm(current_selinux_state,
 				      current_sid(), SECINITSID_SECURITY,
 				      SECCLASS_SECURITY, SECURITY__SETENFORCE,
 				      NULL);
@@ -381,7 +381,7 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 
 	mutex_lock(&fsi->state->policy_mutex);
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
 	if (rc)
@@ -443,9 +443,9 @@ static ssize_t sel_read_policy(struct file *filp, char __user *buf,
 	struct policy_load_memory *plm = filp->private_data;
 	int ret;
 
-	ret = avc_has_perm(&selinux_state,
+	ret = avc_has_perm(current_selinux_state,
 			   current_sid(), SECINITSID_SECURITY,
-			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
+			   SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
 	if (ret)
 		return ret;
 
@@ -597,7 +597,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		return -EINVAL;
 
 	mutex_lock(&fsi->state->policy_mutex);
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__LOAD_POLICY, NULL);
 	if (length)
@@ -652,7 +652,7 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 	u32 sid, len;
 	ssize_t length;
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__CHECK_CONTEXT, NULL);
 	if (length)
@@ -700,7 +700,7 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	ssize_t length;
 	unsigned int new_value;
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT,
 			      NULL);
@@ -756,7 +756,7 @@ static ssize_t sel_write_validatetrans(struct file *file,
 	u16 tclass;
 	int rc;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__VALIDATE_TRANS, NULL);
 	if (rc)
@@ -885,7 +885,7 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 	struct av_decision avd;
 	ssize_t length;
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_AV, NULL);
 	if (length)
@@ -939,7 +939,7 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 	u32 len;
 	int nargs;
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_CREATE,
 			      NULL);
@@ -1041,7 +1041,7 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	char *newcon = NULL;
 	u32 len;
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_RELABEL,
 			      NULL);
@@ -1106,7 +1106,7 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 		" This will not be supported in the future; please update your"
 		" userspace.\n", current->comm, current->pid);
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_USER,
 			      NULL);
@@ -1171,7 +1171,7 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	char *newcon = NULL;
 	u32 len;
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_MEMBER,
 			      NULL);
@@ -1299,7 +1299,7 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 
 	mutex_lock(&fsi->state->policy_mutex);
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETBOOL,
 			      NULL);
@@ -1355,7 +1355,7 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 
 	mutex_lock(&fsi->state->policy_mutex);
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETBOOL,
 			      NULL);
@@ -1473,7 +1473,7 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 	ssize_t ret;
 	unsigned int new_value;
 
-	ret = avc_has_perm(&selinux_state,
+	ret = avc_has_perm(current_selinux_state,
 			   current_sid(), SECINITSID_SECURITY,
 			   SECCLASS_SECURITY, SECURITY__SETSECPARAM,
 			   NULL);
@@ -2221,7 +2221,7 @@ static int __init init_sel_fs(void)
 	 * Try to pre-allocate the status page, so the sequence number of the
 	 * initial policy load can be stored.
 	 */
-	(void) selinux_kernel_status_page(&selinux_state);
+	(void) selinux_kernel_status_page(current_selinux_state);
 
 	return err;
 }
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 1f8d44faa9bc..112edf9b2106 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3616,7 +3616,7 @@ void selinux_audit_rule_free(void *vrule)
 int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
 			    gfp_t gfp)
 {
-	struct selinux_state *state = &selinux_state;
+	struct selinux_state *state = current_selinux_state;
 	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct selinux_audit_rule *tmprule;
@@ -3741,7 +3741,7 @@ int selinux_audit_rule_known(struct audit_krule *rule)
 
 int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *vrule)
 {
-	struct selinux_state *state = &selinux_state;
+	struct selinux_state *state = current_selinux_state;
 	struct selinux_policy *policy;
 	struct context *ctxt;
 	struct mls_level *level;
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 83a94ca4d738..4d1647ba8e5f 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -97,12 +97,12 @@ static int selinux_xfrm_alloc_user(struct xfrm_sec_ctx **ctxp,
 	ctx->ctx_len = str_len;
 	memcpy(ctx->ctx_str, &uctx[1], str_len);
 	ctx->ctx_str[str_len] = '\0';
-	rc = security_context_to_sid(&selinux_state, ctx->ctx_str, str_len,
+	rc = security_context_to_sid(current_selinux_state, ctx->ctx_str, str_len,
 				     &ctx->ctx_sid, gfp);
 	if (rc)
 		goto err;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  current_sid(), ctx->ctx_sid,
 			  SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT, NULL);
 	if (rc)
@@ -137,7 +137,7 @@ static int selinux_xfrm_delete(struct xfrm_sec_ctx *ctx)
 	if (!ctx)
 		return 0;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), ctx->ctx_sid,
 			    SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT,
 			    NULL);
@@ -160,7 +160,7 @@ int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid)
 	if (!selinux_authorizable_ctx(ctx))
 		return -EINVAL;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  fl_secid, ctx->ctx_sid,
 			  SECCLASS_ASSOCIATION, ASSOCIATION__POLMATCH, NULL);
 	return (rc == -EACCES ? -ESRCH : rc);
@@ -202,7 +202,7 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	/* We don't need a separate SA Vs. policy polmatch check since the SA
 	 * is now of the same label as the flow and a flow Vs. policy polmatch
 	 * check had already happened in selinux_xfrm_policy_lookup() above. */
-	return (avc_has_perm(&selinux_state, flic_sid, state_sid,
+	return (avc_has_perm(current_selinux_state, flic_sid, state_sid,
 			     SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO,
 			     NULL) ? 0 : 1);
 }
@@ -352,7 +352,7 @@ int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
 	if (secid == 0)
 		return -EINVAL;
 
-	rc = security_sid_to_context(&selinux_state, secid, &ctx_str,
+	rc = security_sid_to_context(current_selinux_state, secid, &ctx_str,
 				     &str_len);
 	if (rc)
 		return rc;
@@ -421,7 +421,7 @@ int selinux_xfrm_sock_rcv_skb(u32 sk_sid, struct sk_buff *skb,
 	/* This check even when there's no association involved is intended,
 	 * according to Trent Jaeger, to make sure a process can't engage in
 	 * non-IPsec communication unless explicitly allowed by policy. */
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sk_sid, peer_sid,
 			    SECCLASS_ASSOCIATION, ASSOCIATION__RECVFROM, ad);
 }
@@ -465,6 +465,6 @@ int selinux_xfrm_postroute_last(u32 sk_sid, struct sk_buff *skb,
 	/* This check even when there's no association involved is intended,
 	 * according to Trent Jaeger, to make sure a process can't engage in
 	 * non-IPsec communication unless explicitly allowed by policy. */
-	return avc_has_perm(&selinux_state, sk_sid, SECINITSID_UNLABELED,
+	return avc_has_perm(current_selinux_state, sk_sid, SECINITSID_UNLABELED,
 			    SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO, ad);
 }
-- 
2.49.0

