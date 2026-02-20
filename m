Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177421F7541
	for <selinux@vger.kernel.org>; Fri, 20 Feb 2026 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771617484; cv=none; b=qVhumDiZGyTCELOLuhKgG1rrlgAIePa2W/S3A2IGORN1+w9Sefm0mmMaoyo0iojyirB/eqQ82Hd5QoCKTpq9pIN66/dw+aEL1cWVYuTJTC9hrvmlhQ3N7YOWi0WNhwXB++gEH59F9WPb1aqwQMDOwAMtLl1PDFvnkLrk03BgVhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771617484; c=relaxed/simple;
	bh=NAbbElAOUyGVOUsIDLJCv4J1I23aj72XuN333S2mYao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fR7C4O4bLje3FjjOpUkG6/FB486XRv7v/jt4/v4lbEYJz3J8v1e1LetI6NErnwFSPdsxxS6wA8yBiVP9JpLSo5494CFlegJFMdtJ5HLNBBdz1HnY8LBufxMLgJfa5w7tX7y8sgoQbGjwLdfJPb1fVH+Lq7g6dsg9i0fPxqg+w9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWy0tF60; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWy0tF60"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8946e0884afso40602916d6.1
        for <selinux@vger.kernel.org>; Fri, 20 Feb 2026 11:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771617481; x=1772222281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLfl1XSeCu9xJkVAcoZv117wxs0LRN1g0//k51/MzHs=;
        b=CWy0tF60xGgzrspqMXXC91AEW9KNXd2EBWYD/54uMSUyq+0jtAZCE3NOaWX1bmuaSn
         SeGPgV7cGtkxcaO+cQigOgKqUlMSJv3XL/xdLUVZn00LtoxjtU2CAbjhXC6OnTiyoQ9K
         XWQSpnIKZzEcE8qnwum3kqD279KIVJYFaqbQzohLUEKheeWkanFpGKyt+/rGVWzfaxOS
         Z3Lgw2HLUTxl62qEjtJ3QaHPvb+VsVcYUS+XPebZxRkueLkb62+7hecN9o6qeOdslUZP
         wx8eA6LV70EjaGPA4+2QIoi/kGRQSaGxxgppLV+1Tiuc26wrSe2/unCanmHKLlTt7+Qu
         1mAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771617481; x=1772222281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLfl1XSeCu9xJkVAcoZv117wxs0LRN1g0//k51/MzHs=;
        b=VMgeTdKgIcl9vLXDGYUtT7TOmS0uOgYBoQi+u1N5p3IEBnPcp9ca8S3os5Fown8IzE
         3tRJAEixpDSV2fxztdKcUyUxu8FhAU/120r/SXv+2nnfadcVuv2evG+lyJaAt6osYgH0
         jZkCMV5XBoyRjQMKIOnSkn6PW4ouBinOec643l5HYQWfCA8E4ut/BrPuh0tI+mB0Ubrq
         fTHDN+MSs8HyZh1OaKJGK1jXxUKQGynY8QDYApk3D/yPiCco86ugfsMkUAzwyWPkka3b
         YA6WaI/Xo9gzdF7tzscsFEOFwlfDB7aJxl7nvr3/FeRah/mC3e7Dd9/CvU6eBBe0KWm/
         qnTA==
X-Forwarded-Encrypted: i=1; AJvYcCU8GC4rhOruRGqHmgs/tPxAvVhpNBT5Zm1xm5EdkkD7Jyp3gZxa+CJFRgYby2Gc9sdd4BvvYiXF@vger.kernel.org
X-Gm-Message-State: AOJu0YyuCp6Hv9D926kJSv9mpAg2hjg/1/Wb4I1j62cC+H65AB2uUVe7
	fEP1xrOfYaEBEESlDEMfqP2Yc9NjPhqThoMvlR9uEG+imSSUHMhwx9Q6
X-Gm-Gg: AZuq6aLoReaNjsOYJEb36INI5rKBgzAgL4DIVXg+9jq+eVhogp3sxSYUaTw+FTBgujr
	JxMDzEFKg/QziMhOJbE/Gff6vyKPulGopM6lsNzeIhuuWlDeUe1Yg/BVgtNEHumIgT8jaodb9oo
	DdE61Clumc0VLkASJ811/t/3iPavZ5VFapsHoXnex/ZWPbMXwlGAi80EAFaU1P+th7p4Qu5o6Pc
	tu8XWnkeMUAtEPQ4MXJkR8jALbBVvWjmbD2EDTWwh7BaW6iciED2PXRZ9wKi1JaiTBZJ0MihCeg
	YM50FdQC/Zx8XDyi6CFQ5nxXG8upSihtndH0EAQ6Q6wWUdQT81KboQfAc3hIWnJo8TCX1rQaSLJ
	FLUqztdDG+OARULInsjSZYlx5Gjtd7VuI+TfAQRyPVxLrxN4efuGJ2PaWptQdoj6jrVcunQMVtO
	9UTJHE5JAfSJGFuojo8eofsnm9OCAC9UPHCSyJFasK0qZIjw99njzKofFjyoRCoSVOuLtbrMZjm
	B2Fm4AqacyIwpDN4u4AVuFj/ch/
X-Received: by 2002:ac8:5985:0:b0:503:2efb:9a09 with SMTP id d75a77b69052e-5070bd00c15mr14521551cf.76.1771617480820;
        Fri, 20 Feb 2026 11:58:00 -0800 (PST)
Received: from localhost (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d550785sm1902901cf.11.2026.02.20.11.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:58:00 -0800 (PST)
From: danieldurning.work@gmail.com
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-integrity@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	john.johansen@canonical.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	mic@digikod.net,
	casey@schaufler-ca.com,
	takedakn@nttdata.co.jp,
	penguin-kernel@I-love.SAKURA.ne.jp
Subject: [PATCH] lsm: move inode IS_PRIVATE checks to individual LSMs
Date: Fri, 20 Feb 2026 19:54:05 +0000
Message-ID: <20260220195405.30612-1-danieldurning.work@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Durning <danieldurning.work@gmail.com>

Move responsibility of bypassing S_PRIVATE inodes to the
individual LSMs. Originally the LSM framework would skip calling
the hooks on any inode that was marked S_PRIVATE. This would
prevent the LSMs from controlling access to any inodes marked as
such (ie. pidfds). We now perform the same IS_PRIVATE checks
within the LSMs instead. This is consistent with the general goal
of deferring as much as possible to the individual LSMs.

This reorganization enables the LSMs to eventually implement
checks or labeling for some specific S_PRIVATE inodes like pidfds.

Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
---
 security/apparmor/lsm.c               |  32 ++++++++
 security/commoncap.c                  |  11 ++-
 security/integrity/evm/evm_main.c     |  33 +++++++++
 security/integrity/ima/ima_appraise.c |  12 +++
 security/integrity/ima/ima_main.c     |   6 ++
 security/landlock/fs.c                |  23 ++++++
 security/security.c                   | 101 ++------------------------
 security/selinux/hooks.c              |  77 ++++++++++++++++++++
 security/smack/smack_lsm.c            |  56 ++++++++++++++
 security/tomoyo/tomoyo.c              |  35 +++++++++
 10 files changed, 290 insertions(+), 96 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index a87cd60ed206..5b3ced11bdbc 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -323,18 +323,27 @@ static int common_perm_create(const char *op, const struct path *dir,
 
 static int apparmor_path_unlink(const struct path *dir, struct dentry *dentry)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+		return 0;
+
 	return common_perm_rm(OP_UNLINK, dir, dentry, AA_MAY_DELETE);
 }
 
 static int apparmor_path_mkdir(const struct path *dir, struct dentry *dentry,
 			       umode_t mode)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+		return 0;
+
 	return common_perm_create(OP_MKDIR, dir, dentry, AA_MAY_CREATE,
 				  S_IFDIR);
 }
 
 static int apparmor_path_rmdir(const struct path *dir, struct dentry *dentry)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+		return 0;
+
 	return common_perm_rm(OP_RMDIR, dir, dentry, AA_MAY_DELETE);
 }
 
@@ -346,6 +355,9 @@ static int apparmor_path_mknod(const struct path *dir, struct dentry *dentry,
 
 static int apparmor_path_truncate(const struct path *path)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+		return 0;
+
 	return common_perm_cond(OP_TRUNC, path, MAY_WRITE | AA_MAY_SETATTR);
 }
 
@@ -357,6 +369,9 @@ static int apparmor_file_truncate(struct file *file)
 static int apparmor_path_symlink(const struct path *dir, struct dentry *dentry,
 				 const char *old_name)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+		return 0;
+
 	return common_perm_create(OP_SYMLINK, dir, dentry, AA_MAY_CREATE,
 				  S_IFLNK);
 }
@@ -367,6 +382,9 @@ static int apparmor_path_link(struct dentry *old_dentry, const struct path *new_
 	struct aa_label *label;
 	int error = 0;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
+		return 0;
+
 	if (!path_mediated_fs(old_dentry))
 		return 0;
 
@@ -386,6 +404,11 @@ static int apparmor_path_rename(const struct path *old_dir, struct dentry *old_d
 	struct aa_label *label;
 	int error = 0;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry)) ||
+		(d_is_positive(new_dentry) &&
+		IS_PRIVATE(d_backing_inode(new_dentry)))))
+		return 0;
+
 	if (!path_mediated_fs(old_dentry))
 		return 0;
 	if ((flags & RENAME_EXCHANGE) && !path_mediated_fs(new_dentry))
@@ -444,16 +467,25 @@ static int apparmor_path_rename(const struct path *old_dir, struct dentry *old_d
 
 static int apparmor_path_chmod(const struct path *path, umode_t mode)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+		return 0;
+
 	return common_perm_cond(OP_CHMOD, path, AA_MAY_CHMOD);
 }
 
 static int apparmor_path_chown(const struct path *path, kuid_t uid, kgid_t gid)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+		return 0;
+
 	return common_perm_cond(OP_CHOWN, path, AA_MAY_CHOWN);
 }
 
 static int apparmor_inode_getattr(const struct path *path)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+		return 0;
+
 	return common_perm_cond(OP_GETATTR, path, AA_MAY_GETATTR);
 }
 
diff --git a/security/commoncap.c b/security/commoncap.c
index 8a23dfab7fac..1b61d43529c2 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -88,7 +88,7 @@ static inline int cap_capable_helper(const struct cred *cred,
 		if (ns->level <= cred_ns->level)
 			return -EPERM;
 
-		/* 
+		/*
 		 * The owner of the user namespace in the parent of the
 		 * user namespace has all caps.
 		 */
@@ -432,6 +432,9 @@ int cap_inode_getsecurity(struct mnt_idmap *idmap,
 	struct dentry *dentry;
 	struct user_namespace *fs_ns;
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return -EOPNOTSUPP;
+
 	if (strcmp(name, "capability") != 0)
 		return -EOPNOTSUPP;
 
@@ -1027,6 +1030,9 @@ int cap_inode_setxattr(struct dentry *dentry, const char *name,
 {
 	struct user_namespace *user_ns = dentry->d_sb->s_user_ns;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	/* Ignore non-security xattrs */
 	if (strncmp(name, XATTR_SECURITY_PREFIX,
 			XATTR_SECURITY_PREFIX_LEN) != 0)
@@ -1068,6 +1074,9 @@ int cap_inode_removexattr(struct mnt_idmap *idmap,
 {
 	struct user_namespace *user_ns = dentry->d_sb->s_user_ns;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	/* Ignore non-security xattrs */
 	if (strncmp(name, XATTR_SECURITY_PREFIX,
 			XATTR_SECURITY_PREFIX_LEN) != 0)
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 73d500a375cb..0095712b8d75 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -590,6 +590,9 @@ static int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 {
 	const struct evm_ima_xattr_data *xattr_data = xattr_value;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	/* Policy permits modification of the protected xattrs even though
 	 * there's no HMAC key loaded
 	 */
@@ -675,6 +678,9 @@ static int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 {
 	enum integrity_status evm_status;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	/* Policy permits modification of the protected xattrs even though
 	 * there's no HMAC key loaded
 	 */
@@ -725,6 +731,9 @@ static int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 static int evm_inode_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 				const char *acl_name)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	return evm_inode_set_acl(idmap, dentry, acl_name, NULL);
 }
 
@@ -807,6 +816,9 @@ static void evm_inode_post_setxattr(struct dentry *dentry,
 				    size_t xattr_value_len,
 				    int flags)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+
 	if (!evm_revalidate_status(xattr_name))
 		return;
 
@@ -836,6 +848,9 @@ static void evm_inode_post_setxattr(struct dentry *dentry,
 static void evm_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
 				   struct posix_acl *kacl)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+
 	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0, 0);
 }
 
@@ -852,6 +867,9 @@ static void evm_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
 static void evm_inode_post_removexattr(struct dentry *dentry,
 				       const char *xattr_name)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+
 	if (!evm_revalidate_status(xattr_name))
 		return;
 
@@ -879,6 +897,9 @@ static inline void evm_inode_post_remove_acl(struct mnt_idmap *idmap,
 					     struct dentry *dentry,
 					     const char *acl_name)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+
 	evm_inode_post_removexattr(dentry, acl_name);
 }
 
@@ -911,6 +932,9 @@ static int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	unsigned int ia_valid = attr->ia_valid;
 	enum integrity_status evm_status;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	/* Policy permits modification of the protected attrs even though
 	 * there's no HMAC key loaded
 	 */
@@ -960,6 +984,9 @@ static int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 static void evm_inode_post_setattr(struct mnt_idmap *idmap,
 				   struct dentry *dentry, int ia_valid)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+
 	if (!evm_revalidate_status(NULL))
 		return;
 
@@ -1019,6 +1046,9 @@ int evm_inode_init_security(struct inode *inode, struct inode *dir,
 	bool evm_protected_xattrs = false;
 	int rc;
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return 0;
+
 	if (!(evm_initialized & EVM_INIT_HMAC) || !xattrs)
 		return 0;
 
@@ -1094,6 +1124,9 @@ static void evm_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 	struct inode *inode = d_backing_inode(dentry);
 	struct evm_iint_cache *iint = evm_iint_inode(inode);
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return;
+
 	if (!S_ISREG(inode->i_mode))
 		return;
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 5149ff4fd50d..d705c908132f 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -665,6 +665,9 @@ static void ima_inode_post_setattr(struct mnt_idmap *idmap,
 	struct ima_iint_cache *iint;
 	int action;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+
 	if (!(ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode)
 	    || !(inode->i_opflags & IOP_XATTR))
 		return;
@@ -790,6 +793,9 @@ static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	int result;
 	int err;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	result = ima_protect_xattr(dentry, xattr_name, xattr_value,
 				   xattr_value_len);
 	if (result == 1) {
@@ -817,6 +823,9 @@ static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 static int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			     const char *acl_name, struct posix_acl *kacl)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	if (evm_revalidate_status(acl_name))
 		ima_reset_appraise_flags(d_backing_inode(dentry), -1);
 
@@ -842,6 +851,9 @@ static int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
 static int ima_inode_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 				const char *acl_name)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	return ima_inode_set_acl(idmap, dentry, acl_name, NULL);
 }
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5770cf691912..5ddac6c15c7f 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -794,6 +794,9 @@ static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
 	struct ima_iint_cache *iint;
 	int must_appraise;
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return;
+
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return;
 
@@ -826,6 +829,9 @@ static void ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 	struct inode *inode = dentry->d_inode;
 	int must_appraise;
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return;
+
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return;
 
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index fe794875ad46..5fe15313a3f5 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1528,6 +1528,9 @@ static int hook_path_link(struct dentry *const old_dentry,
 			  const struct path *const new_dir,
 			  struct dentry *const new_dentry)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
+		return 0;
+
 	return current_check_refer_path(old_dentry, new_dir, new_dentry, false,
 					false);
 }
@@ -1538,6 +1541,11 @@ static int hook_path_rename(const struct path *const old_dir,
 			    struct dentry *const new_dentry,
 			    const unsigned int flags)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry)) ||
+		(d_is_positive(new_dentry) &&
+		IS_PRIVATE(d_backing_inode(new_dentry)))))
+		return 0;
+
 	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
 	return current_check_refer_path(old_dentry, new_dir, new_dentry, true,
 					!!(flags & RENAME_EXCHANGE));
@@ -1546,6 +1554,9 @@ static int hook_path_rename(const struct path *const old_dir,
 static int hook_path_mkdir(const struct path *const dir,
 			   struct dentry *const dentry, const umode_t mode)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+		return 0;
+
 	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_MAKE_DIR);
 }
 
@@ -1560,23 +1571,35 @@ static int hook_path_symlink(const struct path *const dir,
 			     struct dentry *const dentry,
 			     const char *const old_name)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+		return 0;
+
 	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_MAKE_SYM);
 }
 
 static int hook_path_unlink(const struct path *const dir,
 			    struct dentry *const dentry)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+		return 0;
+
 	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_FILE);
 }
 
 static int hook_path_rmdir(const struct path *const dir,
 			   struct dentry *const dentry)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+		return 0;
+
 	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
 }
 
 static int hook_path_truncate(const struct path *const path)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+		return 0;
+
 	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
 }
 
diff --git a/security/security.c b/security/security.c
index 31a688650601..658dbb10ea40 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1310,9 +1310,6 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	struct xattr *new_xattrs = NULL;
 	int ret = -EOPNOTSUPP, xattr_count = 0;
 
-	if (unlikely(IS_PRIVATE(inode)))
-		return 0;
-
 	if (!blob_sizes.lbs_xattr_count)
 		return 0;
 
@@ -1386,8 +1383,6 @@ int security_inode_init_security_anon(struct inode *inode,
 int security_path_mknod(const struct path *dir, struct dentry *dentry,
 			umode_t mode, unsigned int dev)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
-		return 0;
 	return call_int_hook(path_mknod, dir, dentry, mode, dev);
 }
 EXPORT_SYMBOL(security_path_mknod);
@@ -1401,8 +1396,6 @@ EXPORT_SYMBOL(security_path_mknod);
  */
 void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
-		return;
 	call_void_hook(path_post_mknod, idmap, dentry);
 }
 
@@ -1419,8 +1412,6 @@ void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 int security_path_mkdir(const struct path *dir, struct dentry *dentry,
 			umode_t mode)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
-		return 0;
 	return call_int_hook(path_mkdir, dir, dentry, mode);
 }
 EXPORT_SYMBOL(security_path_mkdir);
@@ -1436,8 +1427,6 @@ EXPORT_SYMBOL(security_path_mkdir);
  */
 int security_path_rmdir(const struct path *dir, struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
-		return 0;
 	return call_int_hook(path_rmdir, dir, dentry);
 }
 
@@ -1452,8 +1441,6 @@ int security_path_rmdir(const struct path *dir, struct dentry *dentry)
  */
 int security_path_unlink(const struct path *dir, struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
-		return 0;
 	return call_int_hook(path_unlink, dir, dentry);
 }
 EXPORT_SYMBOL(security_path_unlink);
@@ -1471,8 +1458,6 @@ EXPORT_SYMBOL(security_path_unlink);
 int security_path_symlink(const struct path *dir, struct dentry *dentry,
 			  const char *old_name)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
-		return 0;
 	return call_int_hook(path_symlink, dir, dentry, old_name);
 }
 
@@ -1489,8 +1474,6 @@ int security_path_symlink(const struct path *dir, struct dentry *dentry,
 int security_path_link(struct dentry *old_dentry, const struct path *new_dir,
 		       struct dentry *new_dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
-		return 0;
 	return call_int_hook(path_link, old_dentry, new_dir, new_dentry);
 }
 
@@ -1510,11 +1493,6 @@ int security_path_rename(const struct path *old_dir, struct dentry *old_dentry,
 			 const struct path *new_dir, struct dentry *new_dentry,
 			 unsigned int flags)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry)) ||
-		     (d_is_positive(new_dentry) &&
-		      IS_PRIVATE(d_backing_inode(new_dentry)))))
-		return 0;
-
 	return call_int_hook(path_rename, old_dir, old_dentry, new_dir,
 			     new_dentry, flags);
 }
@@ -1532,8 +1510,6 @@ EXPORT_SYMBOL(security_path_rename);
  */
 int security_path_truncate(const struct path *path)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
-		return 0;
 	return call_int_hook(path_truncate, path);
 }
 
@@ -1550,8 +1526,6 @@ int security_path_truncate(const struct path *path)
  */
 int security_path_chmod(const struct path *path, umode_t mode)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
-		return 0;
 	return call_int_hook(path_chmod, path, mode);
 }
 
@@ -1567,8 +1541,6 @@ int security_path_chmod(const struct path *path, umode_t mode)
  */
 int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
-		return 0;
 	return call_int_hook(path_chown, path, uid, gid);
 }
 
@@ -1599,8 +1571,6 @@ int security_path_chroot(const struct path *path)
 int security_inode_create(struct inode *dir, struct dentry *dentry,
 			  umode_t mode)
 {
-	if (unlikely(IS_PRIVATE(dir)))
-		return 0;
 	return call_int_hook(inode_create, dir, dentry, mode);
 }
 EXPORT_SYMBOL_GPL(security_inode_create);
@@ -1615,8 +1585,6 @@ EXPORT_SYMBOL_GPL(security_inode_create);
 void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
 					struct inode *inode)
 {
-	if (unlikely(IS_PRIVATE(inode)))
-		return;
 	call_void_hook(inode_post_create_tmpfile, idmap, inode);
 }
 
@@ -1633,8 +1601,6 @@ void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
 int security_inode_link(struct dentry *old_dentry, struct inode *dir,
 			struct dentry *new_dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
-		return 0;
 	return call_int_hook(inode_link, old_dentry, dir, new_dentry);
 }
 
@@ -1649,8 +1615,6 @@ int security_inode_link(struct dentry *old_dentry, struct inode *dir,
  */
 int security_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
-		return 0;
 	return call_int_hook(inode_unlink, dir, dentry);
 }
 
@@ -1667,8 +1631,6 @@ int security_inode_unlink(struct inode *dir, struct dentry *dentry)
 int security_inode_symlink(struct inode *dir, struct dentry *dentry,
 			   const char *old_name)
 {
-	if (unlikely(IS_PRIVATE(dir)))
-		return 0;
 	return call_int_hook(inode_symlink, dir, dentry, old_name);
 }
 
@@ -1685,8 +1647,6 @@ int security_inode_symlink(struct inode *dir, struct dentry *dentry,
  */
 int security_inode_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
-	if (unlikely(IS_PRIVATE(dir)))
-		return 0;
 	return call_int_hook(inode_mkdir, dir, dentry, mode);
 }
 EXPORT_SYMBOL_GPL(security_inode_mkdir);
@@ -1702,8 +1662,6 @@ EXPORT_SYMBOL_GPL(security_inode_mkdir);
  */
 int security_inode_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
-		return 0;
 	return call_int_hook(inode_rmdir, dir, dentry);
 }
 
@@ -1724,8 +1682,6 @@ int security_inode_rmdir(struct inode *dir, struct dentry *dentry)
 int security_inode_mknod(struct inode *dir, struct dentry *dentry,
 			 umode_t mode, dev_t dev)
 {
-	if (unlikely(IS_PRIVATE(dir)))
-		return 0;
 	return call_int_hook(inode_mknod, dir, dentry, mode, dev);
 }
 
@@ -1745,11 +1701,6 @@ int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
 			  struct inode *new_dir, struct dentry *new_dentry,
 			  unsigned int flags)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry)) ||
-		     (d_is_positive(new_dentry) &&
-		      IS_PRIVATE(d_backing_inode(new_dentry)))))
-		return 0;
-
 	if (flags & RENAME_EXCHANGE) {
 		int err = call_int_hook(inode_rename, new_dir, new_dentry,
 					old_dir, old_dentry);
@@ -1771,8 +1722,6 @@ int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
  */
 int security_inode_readlink(struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
-		return 0;
 	return call_int_hook(inode_readlink, dentry);
 }
 
@@ -1790,8 +1739,6 @@ int security_inode_readlink(struct dentry *dentry)
 int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
 			       bool rcu)
 {
-	if (unlikely(IS_PRIVATE(inode)))
-		return 0;
 	return call_int_hook(inode_follow_link, dentry, inode, rcu);
 }
 
@@ -1811,8 +1758,6 @@ int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
  */
 int security_inode_permission(struct inode *inode, int mask)
 {
-	if (unlikely(IS_PRIVATE(inode)))
-		return 0;
 	return call_int_hook(inode_permission, inode, mask);
 }
 
@@ -1832,8 +1777,6 @@ int security_inode_permission(struct inode *inode, int mask)
 int security_inode_setattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct iattr *attr)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
-		return 0;
 	return call_int_hook(inode_setattr, idmap, dentry, attr);
 }
 EXPORT_SYMBOL_GPL(security_inode_setattr);
@@ -1849,8 +1792,6 @@ EXPORT_SYMBOL_GPL(security_inode_setattr);
 void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 				 int ia_valid)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
-		return;
 	call_void_hook(inode_post_setattr, idmap, dentry, ia_valid);
 }
 
@@ -1864,8 +1805,6 @@ void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
  */
 int security_inode_getattr(const struct path *path)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
-		return 0;
 	return call_int_hook(inode_getattr, path);
 }
 
@@ -1901,11 +1840,11 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 {
 	int rc;
 
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
-		return 0;
-
 	/* enforce the capability checks at the lsm layer, if needed */
 	if (!call_int_hook(inode_xattr_skipcap, name)) {
+		if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+			return 0;
+
 		rc = cap_inode_setxattr(dentry, name, value, size, flags);
 		if (rc)
 			return rc;
@@ -1931,8 +1870,6 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
 			   struct dentry *dentry, const char *acl_name,
 			   struct posix_acl *kacl)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
-		return 0;
 	return call_int_hook(inode_set_acl, idmap, dentry, acl_name, kacl);
 }
 
@@ -1948,8 +1885,6 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
 void security_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
 				 struct posix_acl *kacl)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
-		return;
 	call_void_hook(inode_post_set_acl, dentry, acl_name, kacl);
 }
 
@@ -1967,8 +1902,6 @@ void security_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
 int security_inode_get_acl(struct mnt_idmap *idmap,
 			   struct dentry *dentry, const char *acl_name)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
-		return 0;
 	return call_int_hook(inode_get_acl, idmap, dentry, acl_name);
 }
 
@@ -1986,8 +1919,6 @@ int security_inode_get_acl(struct mnt_idmap *idmap,
 int security_inode_remove_acl(struct mnt_idmap *idmap,
 			      struct dentry *dentry, const char *acl_name)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
-		return 0;
 	return call_int_hook(inode_remove_acl, idmap, dentry, acl_name);
 }
 
@@ -2003,8 +1934,6 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
 void security_inode_post_remove_acl(struct mnt_idmap *idmap,
 				    struct dentry *dentry, const char *acl_name)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
-		return;
 	call_void_hook(inode_post_remove_acl, idmap, dentry, acl_name);
 }
 
@@ -2021,8 +1950,6 @@ void security_inode_post_remove_acl(struct mnt_idmap *idmap,
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
-		return;
 	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
 }
 
@@ -2038,8 +1965,6 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
  */
 int security_inode_getxattr(struct dentry *dentry, const char *name)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
-		return 0;
 	return call_int_hook(inode_getxattr, dentry, name);
 }
 
@@ -2054,8 +1979,6 @@ int security_inode_getxattr(struct dentry *dentry, const char *name)
  */
 int security_inode_listxattr(struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
-		return 0;
 	return call_int_hook(inode_listxattr, dentry);
 }
 
@@ -2087,11 +2010,11 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
 {
 	int rc;
 
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
-		return 0;
-
 	/* enforce the capability checks at the lsm layer, if needed */
 	if (!call_int_hook(inode_xattr_skipcap, name)) {
+		if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+			return 0;
+
 		rc = cap_inode_removexattr(idmap, dentry, name);
 		if (rc)
 			return rc;
@@ -2109,8 +2032,6 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
  */
 void security_inode_post_removexattr(struct dentry *dentry, const char *name)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
-		return;
 	call_void_hook(inode_post_removexattr, dentry, name);
 }
 
@@ -2197,9 +2118,6 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
 			       struct inode *inode, const char *name,
 			       void **buffer, bool alloc)
 {
-	if (unlikely(IS_PRIVATE(inode)))
-		return LSM_RET_DEFAULT(inode_getsecurity);
-
 	return call_int_hook(inode_getsecurity, idmap, inode, name, buffer,
 			     alloc);
 }
@@ -2222,9 +2140,6 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
 int security_inode_setsecurity(struct inode *inode, const char *name,
 			       const void *value, size_t size, int flags)
 {
-	if (unlikely(IS_PRIVATE(inode)))
-		return LSM_RET_DEFAULT(inode_setsecurity);
-
 	return call_int_hook(inode_setsecurity, inode, name, value, size,
 			     flags);
 }
@@ -2245,8 +2160,6 @@ int security_inode_setsecurity(struct inode *inode, const char *name,
 int security_inode_listsecurity(struct inode *inode,
 				char *buffer, size_t buffer_size)
 {
-	if (unlikely(IS_PRIVATE(inode)))
-		return 0;
 	return call_int_hook(inode_listsecurity, inode, buffer, buffer_size);
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
@@ -3596,8 +3509,6 @@ int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
  */
 void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 {
-	if (unlikely(inode && IS_PRIVATE(inode)))
-		return;
 	call_void_hook(d_instantiate, dentry, inode);
 }
 EXPORT_SYMBOL(security_d_instantiate);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index feda34b18d83..e17d776fb159 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2948,6 +2948,9 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	int rc;
 	char *context;
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return 0;
+
 	sbsec = selinux_superblock(dir->i_sb);
 
 	newsid = crsec->create_sid;
@@ -3049,42 +3052,68 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 
 static int selinux_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
+	if (unlikely(IS_PRIVATE(dir)))
+		return 0;
+
 	return may_create(dir, dentry, SECCLASS_FILE);
 }
 
 static int selinux_inode_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_dentry)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
+		return 0;
+
 	return may_link(dir, old_dentry, MAY_LINK);
 }
 
 static int selinux_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	return may_link(dir, dentry, MAY_UNLINK);
 }
 
 static int selinux_inode_symlink(struct inode *dir, struct dentry *dentry, const char *name)
 {
+	if (unlikely(IS_PRIVATE(dir)))
+		return 0;
+
 	return may_create(dir, dentry, SECCLASS_LNK_FILE);
 }
 
 static int selinux_inode_mkdir(struct inode *dir, struct dentry *dentry, umode_t mask)
 {
+	if (unlikely(IS_PRIVATE(dir)))
+		return 0;
+
 	return may_create(dir, dentry, SECCLASS_DIR);
 }
 
 static int selinux_inode_rmdir(struct inode *dir, struct dentry *dentry)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	return may_link(dir, dentry, MAY_RMDIR);
 }
 
 static int selinux_inode_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 {
+	if (unlikely(IS_PRIVATE(dir)))
+		return 0;
+
 	return may_create(dir, dentry, inode_mode_to_security_class(mode));
 }
 
 static int selinux_inode_rename(struct inode *old_inode, struct dentry *old_dentry,
 				struct inode *new_inode, struct dentry *new_dentry)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry)) ||
+		(d_is_positive(new_dentry) &&
+		IS_PRIVATE(d_backing_inode(new_dentry)))))
+		return 0;
+
 	return may_rename(old_inode, old_dentry, new_inode, new_dentry);
 }
 
@@ -3092,6 +3121,9 @@ static int selinux_inode_readlink(struct dentry *dentry)
 {
 	const struct cred *cred = current_cred();
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	return dentry_has_perm(cred, dentry, FILE__READ);
 }
 
@@ -3102,6 +3134,9 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	struct inode_security_struct *isec;
 	u32 sid = current_sid();
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return 0;
+
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
 	isec = inode_security_rcu(inode, rcu);
@@ -3230,6 +3265,9 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 	int rc, rc2;
 	u32 audited, denied;
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return 0;
+
 	mask = requested & (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
 
 	/* No permission to check.  Existence test. */
@@ -3283,6 +3321,9 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	unsigned int ia_valid = iattr->ia_valid;
 	u32 av = FILE__WRITE;
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return 0;
+
 	/* ATTR_FORCE is just used for ATTR_KILL_S[UG]ID. */
 	if (ia_valid & ATTR_FORCE) {
 		ia_valid &= ~(ATTR_KILL_SUID | ATTR_KILL_SGID | ATTR_MODE |
@@ -3308,6 +3349,9 @@ static int selinux_inode_getattr(const struct path *path)
 {
 	struct task_security_struct *tsec;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+		return 0;
+
 	tsec = selinux_task(current);
 
 	if (task_avdcache_permnoaudit(tsec, current_sid()))
@@ -3356,6 +3400,9 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	u32 newsid, sid = current_sid();
 	int rc = 0;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	/* if not a selinux xattr, only check the ordinary setattr perm */
 	if (strcmp(name, XATTR_NAME_SELINUX))
 		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
@@ -3435,18 +3482,27 @@ static int selinux_inode_set_acl(struct mnt_idmap *idmap,
 				 struct dentry *dentry, const char *acl_name,
 				 struct posix_acl *kacl)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
 }
 
 static int selinux_inode_get_acl(struct mnt_idmap *idmap,
 				 struct dentry *dentry, const char *acl_name)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	return dentry_has_perm(current_cred(), dentry, FILE__GETATTR);
 }
 
 static int selinux_inode_remove_acl(struct mnt_idmap *idmap,
 				    struct dentry *dentry, const char *acl_name)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
 }
 
@@ -3459,6 +3515,9 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 	u32 newsid;
 	int rc;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+
 	if (strcmp(name, XATTR_NAME_SELINUX)) {
 		/* Not an attribute we recognize, so nothing to do. */
 		return;
@@ -3494,6 +3553,9 @@ static int selinux_inode_getxattr(struct dentry *dentry, const char *name)
 {
 	const struct cred *cred = current_cred();
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	return dentry_has_perm(cred, dentry, FILE__GETATTR);
 }
 
@@ -3501,6 +3563,9 @@ static int selinux_inode_listxattr(struct dentry *dentry)
 {
 	const struct cred *cred = current_cred();
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	return dentry_has_perm(cred, dentry, FILE__GETATTR);
 }
 
@@ -3593,6 +3658,9 @@ static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
 	char *context = NULL;
 	struct inode_security_struct *isec;
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return -EOPNOTSUPP;
+
 	/*
 	 * If we're not initialized yet, then we can't validate contexts, so
 	 * just let vfs_getxattr fall back to using the on-disk xattr.
@@ -3637,6 +3705,9 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 	u32 newsid;
 	int rc;
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return -EOPNOTSUPP;
+
 	if (strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
 
@@ -3664,6 +3735,9 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
 {
 	const int len = sizeof(XATTR_NAME_SELINUX);
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return 0;
+
 	if (!selinux_initialized())
 		return 0;
 
@@ -6546,6 +6620,9 @@ static void selinux_ipc_getlsmprop(struct kern_ipc_perm *ipcp,
 
 static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 {
+	if (unlikely(inode && IS_PRIVATE(inode)))
+		return;
+
 	if (inode)
 		inode_doinit_with_dentry(inode, dentry);
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a0bd4919a9d9..8f432348dfbd 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1020,6 +1020,9 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 	bool trans_cred;
 	bool trans_rule;
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return 0;
+
 	/*
 	 * UNIX domain sockets use lower level socket data. Let
 	 * UDS inode have fixed * label to keep smack_inode_permission() calm
@@ -1093,6 +1096,9 @@ static int smack_inode_link(struct dentry *old_dentry, struct inode *dir,
 	struct smk_audit_info ad;
 	int rc;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
+		return 0;
+
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, old_dentry);
 
@@ -1124,6 +1130,9 @@ static int smack_inode_unlink(struct inode *dir, struct dentry *dentry)
 	struct smk_audit_info ad;
 	int rc;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
@@ -1157,6 +1166,9 @@ static int smack_inode_rmdir(struct inode *dir, struct dentry *dentry)
 	struct smk_audit_info ad;
 	int rc;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
@@ -1199,6 +1211,11 @@ static int smack_inode_rename(struct inode *old_inode,
 	struct smack_known *isp;
 	struct smk_audit_info ad;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry)) ||
+		(d_is_positive(new_dentry) &&
+		IS_PRIVATE(d_backing_inode(new_dentry)))))
+		return 0;
+
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, old_dentry);
 
@@ -1231,6 +1248,9 @@ static int smack_inode_permission(struct inode *inode, int mask)
 	int no_block = mask & MAY_NOT_BLOCK;
 	int rc;
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return 0;
+
 	mask &= (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
 	/*
 	 * No permission to check. Existence test. Yup, it's there.
@@ -1267,6 +1287,9 @@ static int smack_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct smk_audit_info ad;
 	int rc;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	/*
 	 * Need to allow for clearing the setuid bit.
 	 */
@@ -1292,6 +1315,9 @@ static int smack_inode_getattr(const struct path *path)
 	struct inode *inode = d_backing_inode(path->dentry);
 	int rc;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+		return 0;
+
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
 	smk_ad_setfield_u_fs_path(&ad, *path);
 	rc = smk_curacc(smk_of_inode(inode), MAY_READ, &ad);
@@ -1351,6 +1377,9 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 	int rc = 0;
 	umode_t const i_mode = d_backing_inode(dentry)->i_mode;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	/*
 	 * Check label validity here so import won't fail in post_setxattr
 	 */
@@ -1421,6 +1450,9 @@ static void smack_inode_post_setxattr(struct dentry *dentry, const char *name,
 	struct smack_known *skp;
 	struct inode_smack *isp = smack_inode(d_backing_inode(dentry));
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+
 	if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		isp->smk_flags |= SMK_INODE_TRANSMUTE;
 		return;
@@ -1455,6 +1487,9 @@ static int smack_inode_getxattr(struct dentry *dentry, const char *name)
 	struct smk_audit_info ad;
 	int rc;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
@@ -1541,6 +1576,9 @@ static int smack_inode_set_acl(struct mnt_idmap *idmap,
 	struct smk_audit_info ad;
 	int rc;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
@@ -1563,6 +1601,9 @@ static int smack_inode_get_acl(struct mnt_idmap *idmap,
 	struct smk_audit_info ad;
 	int rc;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
@@ -1585,6 +1626,9 @@ static int smack_inode_remove_acl(struct mnt_idmap *idmap,
 	struct smk_audit_info ad;
 	int rc;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
@@ -1616,6 +1660,9 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
 	size_t label_len;
 	char *label = NULL;
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return -EOPNOTSUPP;
+
 	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0) {
 		isp = smk_of_inode(inode);
 	} else if (strcmp(name, XATTR_SMACK_TRANSMUTE) == 0) {
@@ -1672,6 +1719,9 @@ static int smack_inode_listsecurity(struct inode *inode, char *buffer,
 {
 	int len = sizeof(XATTR_NAME_SMACK);
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return 0;
+
 	if (buffer != NULL && len <= buffer_size)
 		memcpy(buffer, XATTR_NAME_SMACK, len);
 
@@ -2918,6 +2968,9 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	struct socket *sock;
 	int rc = 0;
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return -EOPNOTSUPP;
+
 	if (value == NULL || size > SMK_LONGLABEL || size == 0)
 		return -EINVAL;
 
@@ -3517,6 +3570,9 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 	if (inode == NULL)
 		return;
 
+	if (unlikely(IS_PRIVATE(inode)))
+		return;
+
 	isp = smack_inode(inode);
 
 	/*
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index c66e02ed8ee3..98eb8cd67f78 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -120,6 +120,9 @@ static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
  */
 static int tomoyo_inode_getattr(const struct path *path)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+		return 0;
+
 	return tomoyo_path_perm(TOMOYO_TYPE_GETATTR, path, NULL);
 }
 
@@ -132,6 +135,9 @@ static int tomoyo_inode_getattr(const struct path *path)
  */
 static int tomoyo_path_truncate(const struct path *path)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+		return 0;
+
 	return tomoyo_path_perm(TOMOYO_TYPE_TRUNCATE, path, NULL);
 }
 
@@ -159,6 +165,9 @@ static int tomoyo_path_unlink(const struct path *parent, struct dentry *dentry)
 {
 	struct path path = { .mnt = parent->mnt, .dentry = dentry };
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(parent->dentry))))
+		return 0;
+
 	return tomoyo_path_perm(TOMOYO_TYPE_UNLINK, &path, NULL);
 }
 
@@ -176,6 +185,9 @@ static int tomoyo_path_mkdir(const struct path *parent, struct dentry *dentry,
 {
 	struct path path = { .mnt = parent->mnt, .dentry = dentry };
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(parent->dentry))))
+		return 0;
+
 	return tomoyo_path_number_perm(TOMOYO_TYPE_MKDIR, &path,
 				       mode & S_IALLUGO);
 }
@@ -192,6 +204,9 @@ static int tomoyo_path_rmdir(const struct path *parent, struct dentry *dentry)
 {
 	struct path path = { .mnt = parent->mnt, .dentry = dentry };
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(parent->dentry))))
+		return 0;
+
 	return tomoyo_path_perm(TOMOYO_TYPE_RMDIR, &path, NULL);
 }
 
@@ -209,6 +224,9 @@ static int tomoyo_path_symlink(const struct path *parent, struct dentry *dentry,
 {
 	struct path path = { .mnt = parent->mnt, .dentry = dentry };
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(parent->dentry))))
+		return 0;
+
 	return tomoyo_path_perm(TOMOYO_TYPE_SYMLINK, &path, old_name);
 }
 
@@ -229,6 +247,9 @@ static int tomoyo_path_mknod(const struct path *parent, struct dentry *dentry,
 	int type = TOMOYO_TYPE_CREATE;
 	const unsigned int perm = mode & S_IALLUGO;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(parent->dentry))))
+		return 0;
+
 	switch (mode & S_IFMT) {
 	case S_IFCHR:
 		type = TOMOYO_TYPE_MKCHAR;
@@ -267,6 +288,9 @@ static int tomoyo_path_link(struct dentry *old_dentry, const struct path *new_di
 	struct path path1 = { .mnt = new_dir->mnt, .dentry = old_dentry };
 	struct path path2 = { .mnt = new_dir->mnt, .dentry = new_dentry };
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
+		return 0;
+
 	return tomoyo_path2_perm(TOMOYO_TYPE_LINK, &path1, &path2);
 }
 
@@ -290,6 +314,11 @@ static int tomoyo_path_rename(const struct path *old_parent,
 	struct path path1 = { .mnt = old_parent->mnt, .dentry = old_dentry };
 	struct path path2 = { .mnt = new_parent->mnt, .dentry = new_dentry };
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry)) ||
+		(d_is_positive(new_dentry) &&
+		IS_PRIVATE(d_backing_inode(new_dentry)))))
+		return 0;
+
 	if (flags & RENAME_EXCHANGE) {
 		const int err = tomoyo_path2_perm(TOMOYO_TYPE_RENAME, &path2,
 				&path1);
@@ -360,6 +389,9 @@ static int tomoyo_file_ioctl(struct file *file, unsigned int cmd,
  */
 static int tomoyo_path_chmod(const struct path *path, umode_t mode)
 {
+	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+		return 0;
+
 	return tomoyo_path_number_perm(TOMOYO_TYPE_CHMOD, path,
 				       mode & S_IALLUGO);
 }
@@ -377,6 +409,9 @@ static int tomoyo_path_chown(const struct path *path, kuid_t uid, kgid_t gid)
 {
 	int error = 0;
 
+	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+		return 0;
+
 	if (uid_valid(uid))
 		error = tomoyo_path_number_perm(TOMOYO_TYPE_CHOWN, path,
 						from_kuid(&init_user_ns, uid));
-- 
2.52.0

