Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ACA3090D4;
	Thu, 14 Aug 2025 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178059; cv=none; b=KNp+Qf75vlJR4ilTbEFI3eQ6gXksjAi/NW1DzUx/Ub2aXPEOugrGuWTq0qq0INplNc+LEtoJvFx5NTYu/fcOTC5pQB+leyuX+o0qsW5Q2y17yXVxxyBdo07STjU3P/uzRYBwoXjaEXQRvQdOFtt71jDJfDRr1tamnAt3hpv4Vq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178059; c=relaxed/simple;
	bh=fzLwe/NR0VtAanpoEBopaeyKnP7bt9l5CVMagn5h82g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taIpbD00ysJqv02rewss33yHDAK9Sz3l1VakJxoNc2n8i2+3KyLHvdRZrMBvIbHUorrZi7FM/VZdtH1HSPwoLJHafpt+r5291/3WXf1NakqqgZ7xqRreSnmK5km4oH+or0RtZUKWZl9xgvLojhORgWoHoqZlDrhsQAQa/smmbco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYI9745q; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYI9745q"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b10c1abfe4so8557081cf.2;
        Thu, 14 Aug 2025 06:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178054; x=1755782854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPsnVVjsqU1SggNkgKr3/YrlXwNJkzhXagWQ7jrP40A=;
        b=VYI9745qxiZnqeblFcqhteX8LhPhcfzbSLBCTN/FSFvz1TArNrWRX/OdqSBY0y0x0w
         53Hb2NSbmNr6fOMyPq1g1EYM2IdI8A50OpoAhJk/Q8fagXYLLN6+ekRDp+/44SEcKs45
         IL1GoPZjPPl4U4PrjNW4wwzkBX7kz15Bs0e/P5FTCnJyxuEe4QvMZcqLAvj+kwPIoe9z
         EU0fsaVYf6axKmUuev09QnUiJMttxWAe4LFkVNfLEDMKeLf7I8xif0o8TCx+rrdCFVXr
         sl0lrLapA33Q14v938q8bLBV3r1Ay3PA02ogAkuYs3BcNNlw3NG44oHk9lsJMuGl7jrA
         Deyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178054; x=1755782854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPsnVVjsqU1SggNkgKr3/YrlXwNJkzhXagWQ7jrP40A=;
        b=hK/o3QC96TU3E6hy/a+tdRCfJNio6IeJomVhysS1StVnKZZbBJME2laX86H9avUjck
         VtJLECjYfYPIPuDZiSLYtD6Dlsi0Lg3lXgt06ZzGA0Wo/ABJEiPK63r1cB9xDnh54F7a
         PERn7DDgGeWBrNKINdBbAb5PcmzDHD1qUpPzRhvw80hH1wMhJIm3kyJRYzBxITxOCJr9
         /TJ2Vw6AGJ7gD1xDkYQf8xqWucVPbNAFKRcFEYql7k99km0DT+RzX5KFOh08vhCstESA
         tn1Vzj3PRF3aIRV0Vvp/IjFV80NBBXybSRkjJ2sdm47lxjI7RePZX30lIJKeB9ZYvbz2
         sjgw==
X-Forwarded-Encrypted: i=1; AJvYcCXv1GRwmcI4XeGig3RvWNQbItEKnJ6PosJ9QbrdgXbvMvps+n2zEM+jG3S9CPrA8jnv2mvP0KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOl93fH4swnzwZOGKivTCXTE4RGPLkGbymdErBMWrzaxFY2ebR
	iruP3Dgw4AoY7R3SSXarP6Dx03gZb0aBzaaQgeikFLunsD5zLvJMnb7iGVX7sA==
X-Gm-Gg: ASbGncvyRmKJ283u/DwRO29BJBqRPcyPgAfkmnJzVnajaF1+oFP0e4fC/uUZcGpQ9qH
	2vglSoYsFlc672pgo4Udr6SfmzB3J7moRnbJ1kmpVzyIx0IWSiDHjRorduWj6T97g40EPLkYQ7v
	NC+mRbJp4lpZWmFQ+0N7RxM9/7Ixxc6wNykNSGpoL4ajbpR+xkRmglD93mFQhhxxmJyZB85G5v3
	H5ZDLCEZEQZK9O/SCgPy5XkFSaFONTQIi1GepNG+PHMtzOdRCvyQwfiGVd0hqnmhgdMhzEX8CUn
	HnPua6hpsDWy1D1Tz8BY8shL4mLy+/VcbQZ3TC2+W/jlLt8K6UVRehbVPKxgqiHBQn/VLQdu2Q8
	J0l1zJn1n+CgmkWaWRzYP+b3/fWlkX9RUAyhZd5/Y18/LNx+YSaZYGtKxuud2CgGTqVp6rHK775
	pGwQ0p75VC5Y9FirYgpCx0emT0ig==
X-Google-Smtp-Source: AGHT+IFdIX4QmEc2/kuSqg9dVvrfqC9cISm2dMBV5V+8tpEDZ2tBR6cm2AfXT5unpOmZPDOVnR8guw==
X-Received: by 2002:a05:622a:1147:b0:4b0:7075:2fd3 with SMTP id d75a77b69052e-4b10a9096c1mr49019891cf.7.1755178053876;
        Thu, 14 Aug 2025 06:27:33 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:33 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 31/42] selinux: rename cred_has_perm*() to cred_tsid_has_perm*()
Date: Thu, 14 Aug 2025 09:26:22 -0400
Message-ID: <20250814132637.1659-32-stephen.smalley.work@gmail.com>
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

Rename cred_has_perm*() to cred_tsid_has_perm*() for greater
clarity and parallelism with the other helper functions.
These functions check permissions between a cred and a fixed
target SID for the current namespace and its ancestors.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         |  12 +-
 security/selinux/hooks.c       | 239 +++++++++++++++++----------------
 security/selinux/include/avc.h |   8 +-
 3 files changed, 130 insertions(+), 129 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 5d9b7b22770f..e153f0122b4d 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1497,7 +1497,7 @@ int cred_self_has_perm_noaudit(const struct cred *cred, u16 tclass,
 
 
 /**
- * cred_has_perm - Check and audit permissions on a (cred, tsid) pair
+ * cred_tsid_has_perm - Check and audit permissions on a (cred, tsid) pair
  * @cred: subject credentials
  * @tsid: target security identifier
  * @tclass: target security class
@@ -1514,8 +1514,8 @@ int cred_self_has_perm_noaudit(const struct cred *cred, u16 tclass,
  * DO NOT USE when checking permissions between two creds (or tasks);
  * use cred_other_has_perm() or cred_task_has_perm() instead.
  */
-int cred_has_perm(const struct cred *cred, u32 tsid, u16 tclass,
-		  u32 requested, struct common_audit_data *ad)
+int cred_tsid_has_perm(const struct cred *cred, u32 tsid, u16 tclass,
+		       u32 requested, struct common_audit_data *ad)
 {
 	struct task_security_struct *tsec;
 	struct selinux_state *state;
@@ -1537,7 +1537,7 @@ int cred_has_perm(const struct cred *cred, u32 tsid, u16 tclass,
 }
 
 /**
- * cred_has_perm_noaudit - Check permissions on a (cred, tsid) pair, no audit
+ * cred_tsid_has_perm_noaudit - Check permissions on a (cred, tsid) pair, no audit
  * @cred: subject credentials
  * @tsid: target security identifier
  * @tclass: target security class
@@ -1552,8 +1552,8 @@ int cred_has_perm(const struct cred *cred, u32 tsid, u16 tclass,
  * DO NOT USE when checking permissions between two creds (or tasks);
  * use cred_other_has_perm() or cred_task_has_perm() instead.
  */
-int cred_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
-			  u32 requested, struct av_decision *avd)
+int cred_tsid_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
+			       u32 requested, struct av_decision *avd)
 {
 	struct task_security_struct *tsec;
 	struct selinux_state *state;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3c487b48e510..f229a8099167 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -448,13 +448,13 @@ static int may_context_mount_sb_relabel(u32 sid,
 {
 	int rc;
 
-	rc = cred_has_perm(cred, sbsec->sid, SECCLASS_FILESYSTEM,
-			   FILESYSTEM__RELABELFROM, NULL);
+	rc = cred_tsid_has_perm(cred, sbsec->sid, SECCLASS_FILESYSTEM,
+				FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = cred_has_perm(cred, sid, SECCLASS_FILESYSTEM,
-			  FILESYSTEM__RELABELTO, NULL);
+	rc = cred_tsid_has_perm(cred, sid, SECCLASS_FILESYSTEM,
+				FILESYSTEM__RELABELTO, NULL);
 	return rc;
 }
 
@@ -464,8 +464,8 @@ static int may_context_mount_inode_relabel(u32 sid,
 {
 	int rc;
 
-	rc = cred_has_perm(cred, sbsec->sid, SECCLASS_FILESYSTEM,
-			  FILESYSTEM__RELABELFROM, NULL);
+	rc = cred_tsid_has_perm(cred, sbsec->sid, SECCLASS_FILESYSTEM,
+				FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
@@ -1695,7 +1695,7 @@ static int inode_has_perm(const struct cred *cred,
 
 	isec = selinux_inode(inode);
 
-	return cred_has_perm(cred, isec->sid, isec->sclass, perms, adp);
+	return cred_tsid_has_perm(cred, isec->sid, isec->sclass, perms, adp);
 }
 
 /* Same as inode_has_perm, but pass explicit audit data containing
@@ -1774,8 +1774,8 @@ static int file_has_perm(const struct cred *cred,
 	ad.u.file = file;
 
 	if (sid != fsec->sid) {
-		rc = cred_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
-				   &ad);
+		rc = cred_tsid_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
+					&ad);
 		if (rc)
 			goto out;
 	}
@@ -1842,9 +1842,9 @@ static int may_create(struct inode *dir,
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
 
-	rc = cred_has_perm(cred, dsec->sid, SECCLASS_DIR,
-			  DIR__ADD_NAME | DIR__SEARCH,
-			  &ad);
+	rc = cred_tsid_has_perm(cred, dsec->sid, SECCLASS_DIR,
+				DIR__ADD_NAME | DIR__SEARCH,
+				&ad);
 	if (rc)
 		return rc;
 
@@ -1853,7 +1853,7 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	rc = cred_has_perm(cred, newsid, tclass, FILE__CREATE, &ad);
+	rc = cred_tsid_has_perm(cred, newsid, tclass, FILE__CREATE, &ad);
 	if (rc)
 		return rc;
 
@@ -1886,7 +1886,7 @@ static int may_link(struct inode *dir,
 
 	av = DIR__SEARCH;
 	av |= (kind ? DIR__REMOVE_NAME : DIR__ADD_NAME);
-	rc = cred_has_perm(cred, dsec->sid, SECCLASS_DIR, av, &ad);
+	rc = cred_tsid_has_perm(cred, dsec->sid, SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
 
@@ -1906,7 +1906,7 @@ static int may_link(struct inode *dir,
 		return 0;
 	}
 
-	return cred_has_perm(cred, isec->sid, isec->sclass, av, &ad);
+	return cred_tsid_has_perm(cred, isec->sid, isec->sclass, av, &ad);
 }
 
 static inline int may_rename(struct inode *old_dir,
@@ -1929,17 +1929,17 @@ static inline int may_rename(struct inode *old_dir,
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 
 	ad.u.dentry = old_dentry;
-	rc = cred_has_perm(cred, old_dsec->sid, SECCLASS_DIR,
-			  DIR__REMOVE_NAME | DIR__SEARCH, &ad);
+	rc = cred_tsid_has_perm(cred, old_dsec->sid, SECCLASS_DIR,
+				DIR__REMOVE_NAME | DIR__SEARCH, &ad);
 	if (rc)
 		return rc;
-	rc = cred_has_perm(cred, old_isec->sid, old_isec->sclass,
-			   FILE__RENAME, &ad);
+	rc = cred_tsid_has_perm(cred, old_isec->sid, old_isec->sclass,
+				FILE__RENAME, &ad);
 	if (rc)
 		return rc;
 	if (old_is_dir && new_dir != old_dir) {
-		rc = cred_has_perm(cred, old_isec->sid, old_isec->sclass,
-				   DIR__REPARENT, &ad);
+		rc = cred_tsid_has_perm(cred, old_isec->sid, old_isec->sclass,
+					DIR__REPARENT, &ad);
 		if (rc)
 			return rc;
 	}
@@ -1948,15 +1948,15 @@ static inline int may_rename(struct inode *old_dir,
 	av = DIR__ADD_NAME | DIR__SEARCH;
 	if (d_is_positive(new_dentry))
 		av |= DIR__REMOVE_NAME;
-	rc = cred_has_perm(cred, new_dsec->sid, SECCLASS_DIR, av, &ad);
+	rc = cred_tsid_has_perm(cred, new_dsec->sid, SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
 	if (d_is_positive(new_dentry)) {
 		new_isec = backing_inode_security(new_dentry);
 		new_is_dir = d_is_dir(new_dentry);
-		rc = cred_has_perm(cred, new_isec->sid, new_isec->sclass,
-				   (new_is_dir ? DIR__RMDIR : FILE__UNLINK),
-				   &ad);
+		rc = cred_tsid_has_perm(cred, new_isec->sid, new_isec->sclass,
+					(new_is_dir ? DIR__RMDIR : FILE__UNLINK),
+					&ad);
 		if (rc)
 			return rc;
 	}
@@ -1973,8 +1973,8 @@ static int superblock_has_perm(const struct cred *cred,
 	struct superblock_security_struct *sbsec;
 
 	sbsec = selinux_superblock(sb);
-	return cred_has_perm(cred, sbsec->sid, SECCLASS_FILESYSTEM, perms,
-			     ad);
+	return cred_tsid_has_perm(cred, sbsec->sid, SECCLASS_FILESYSTEM, perms,
+				  ad);
 }
 
 /* Convert a Linux mode and permission mask to an access vector. */
@@ -2093,8 +2093,8 @@ static int selinux_binder_transfer_file(const struct cred *from,
 	ad.u.path = file->f_path;
 
 	if (sid != fsec->sid) {
-		rc = cred_has_perm(to, fsec->sid, SECCLASS_FD, FD__USE,
-				   &ad);
+		rc = cred_tsid_has_perm(to, fsec->sid, SECCLASS_FD, FD__USE,
+					&ad);
 		if (rc)
 			return rc;
 	}
@@ -2109,8 +2109,8 @@ static int selinux_binder_transfer_file(const struct cred *from,
 		return 0;
 
 	isec = backing_inode_security(dentry);
-	return cred_has_perm(to, isec->sid, isec->sclass, file_to_av(file),
-			     &ad);
+	return cred_tsid_has_perm(to, isec->sid, isec->sclass, file_to_av(file),
+				  &ad);
 }
 
 static int selinux_ptrace_access_check(struct task_struct *child,
@@ -2211,20 +2211,20 @@ static int selinux_syslog(int type)
 	switch (type) {
 	case SYSLOG_ACTION_READ_ALL:	/* Read last kernel messages */
 	case SYSLOG_ACTION_SIZE_BUFFER:	/* Return size of the log buffer */
-		return cred_has_perm(cred, SECINITSID_KERNEL,
-				     SECCLASS_SYSTEM,
-				     SYSTEM__SYSLOG_READ, NULL);
+		return cred_tsid_has_perm(cred, SECINITSID_KERNEL,
+					  SECCLASS_SYSTEM,
+					  SYSTEM__SYSLOG_READ, NULL);
 	case SYSLOG_ACTION_CONSOLE_OFF:	/* Disable logging to console */
 	case SYSLOG_ACTION_CONSOLE_ON:	/* Enable logging to console */
 	/* Set level of messages printed to console */
 	case SYSLOG_ACTION_CONSOLE_LEVEL:
-		return cred_has_perm(cred, SECINITSID_KERNEL,
-				     SECCLASS_SYSTEM,
-				     SYSTEM__SYSLOG_CONSOLE, NULL);
+		return cred_tsid_has_perm(cred, SECINITSID_KERNEL,
+					  SECCLASS_SYSTEM,
+					  SYSTEM__SYSLOG_CONSOLE, NULL);
 	}
 	/* All other syslog types */
-	return cred_has_perm(cred, SECINITSID_KERNEL, SECCLASS_SYSTEM,
-			     SYSTEM__SYSLOG_MOD, NULL);
+	return cred_tsid_has_perm(cred, SECINITSID_KERNEL, SECCLASS_SYSTEM,
+				  SYSTEM__SYSLOG_MOD, NULL);
 }
 
 /*
@@ -2458,8 +2458,8 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	 */
 	cred = old_tsec->parent_cred;
 	if (cred) {
-		rc = cred_has_perm(cred, isec->sid,
-				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
+		rc = cred_tsid_has_perm(cred, isec->sid,
+					SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
 		if (rc)
 			return rc;
 	}
@@ -3070,8 +3070,8 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 	ad.type = LSM_AUDIT_DATA_ANONINODE;
 	ad.u.anonclass = name ? (const char *)name->name : "?";
 
-	return cred_has_perm(current_cred(), isec->sid, isec->sclass,
-			     FILE__CREATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, isec->sclass,
+				  FILE__CREATE, &ad);
 }
 
 static int selinux_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
@@ -3134,8 +3134,8 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	return cred_has_perm(current_cred(), isec->sid, isec->sclass,
-			     FILE__READ, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, isec->sclass,
+				  FILE__READ, &ad);
 }
 
 static noinline int audit_inode_permission(struct inode *inode,
@@ -3284,8 +3284,8 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 		struct av_decision avd;
 
 		/* Cache miss. */
-		rc = cred_has_perm_noaudit(current_cred(), isec->sid,
-					   isec->sclass, perms, &avd);
+		rc = cred_tsid_has_perm_noaudit(current_cred(), isec->sid,
+						isec->sclass, perms, &avd);
 		audited = avc_audit_required(perms, &avd, rc,
 			(requested & MAY_ACCESS) ? FILE__AUDIT_ACCESS : 0,
 			&denied);
@@ -3402,8 +3402,8 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	ad.u.dentry = dentry;
 
 	isec = backing_inode_security(dentry);
-	rc = cred_has_perm(cred, isec->sid, isec->sclass, FILE__RELABELFROM,
-			   &ad);
+	rc = cred_tsid_has_perm(cred, isec->sid, isec->sclass, FILE__RELABELFROM,
+				&ad);
 	if (rc)
 		return rc;
 
@@ -3442,8 +3442,8 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	if (rc)
 		return rc;
 
-	rc = cred_has_perm(cred, newsid, isec->sclass, FILE__RELABELTO,
-			   &ad);
+	rc = cred_tsid_has_perm(cred, newsid, isec->sclass, FILE__RELABELTO,
+				&ad);
 	if (rc)
 		return rc;
 
@@ -3884,8 +3884,8 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	ad.u.op->path = file->f_path;
 
 	if (ssid != fsec->sid) {
-		rc = cred_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
-				   &ad);
+		rc = cred_tsid_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
+					&ad);
 		if (rc)
 			goto out;
 	}
@@ -4270,8 +4270,8 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 	struct task_security_struct *tsec = selinux_cred(new);
 	int ret;
 
-	ret = cred_has_perm(current_cred(), secid, SECCLASS_KERNEL_SERVICE,
-			    KERNEL_SERVICE__USE_AS_OVERRIDE, NULL);
+	ret = cred_tsid_has_perm(current_cred(), secid, SECCLASS_KERNEL_SERVICE,
+				 KERNEL_SERVICE__USE_AS_OVERRIDE, NULL);
 	if (ret == 0) {
 		tsec->sid = secid;
 		tsec->create_sid = 0;
@@ -4291,10 +4291,10 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 	struct task_security_struct *tsec = selinux_cred(new);
 	int ret;
 
-	ret = cred_has_perm(current_cred(), isec->sid,
-			    SECCLASS_KERNEL_SERVICE,
-			    KERNEL_SERVICE__CREATE_FILES_AS,
-			    NULL);
+	ret = cred_tsid_has_perm(current_cred(), isec->sid,
+				SECCLASS_KERNEL_SERVICE,
+				KERNEL_SERVICE__CREATE_FILES_AS,
+				NULL);
 
 	if (ret == 0)
 		tsec->create_sid = isec->sid;
@@ -4308,8 +4308,8 @@ static int selinux_kernel_module_request(char *kmod_name)
 	ad.type = LSM_AUDIT_DATA_KMOD;
 	ad.u.kmod_name = kmod_name;
 
-	return cred_has_perm(current_cred(), SECINITSID_KERNEL,
-			     SECCLASS_SYSTEM, SYSTEM__MODULE_REQUEST, &ad);
+	return cred_tsid_has_perm(current_cred(), SECINITSID_KERNEL,
+				  SECCLASS_SYSTEM, SYSTEM__MODULE_REQUEST, &ad);
 }
 
 static int selinux_kernel_load_from_file(struct file *file, u32 requested)
@@ -4331,14 +4331,15 @@ static int selinux_kernel_load_from_file(struct file *file, u32 requested)
 
 	fsec = selinux_file(file);
 	if (sid != fsec->sid) {
-		rc = cred_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
-				   &ad);
+		rc = cred_tsid_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
+					&ad);
 		if (rc)
 			return rc;
 	}
 
 	isec = inode_security(file_inode(file));
-	return cred_has_perm(cred, isec->sid, SECCLASS_SYSTEM, requested, &ad);
+	return cred_tsid_has_perm(cred, isec->sid, SECCLASS_SYSTEM, requested,
+				  &ad);
 }
 
 static int selinux_kernel_read_file(struct file *file,
@@ -4861,8 +4862,8 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 
 	ad_net_init_from_sk(&ad, &net, sk);
 
-	return cred_has_perm(current_cred(), sksec->sid, sksec->sclass,
-			     perms, &ad);
+	return cred_tsid_has_perm(current_cred(), sksec->sid, sksec->sclass,
+				  perms, &ad);
 }
 
 static int selinux_socket_create(int family, int type,
@@ -4881,8 +4882,8 @@ static int selinux_socket_create(int family, int type,
 	if (rc)
 		return rc;
 
-	return cred_has_perm(current_cred(), newsid, secclass,
-			     SOCKET__CREATE, NULL);
+	return cred_tsid_has_perm(current_cred(), newsid, secclass,
+				  SOCKET__CREATE, NULL);
 }
 
 static int selinux_socket_post_create(struct socket *sock, int family,
@@ -5832,8 +5833,8 @@ static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 
 static int selinux_secmark_relabel_packet(u32 sid)
 {
-	return cred_has_perm(current_cred(), sid, SECCLASS_PACKET,
-			    PACKET__RELABELTO, NULL);
+	return cred_tsid_has_perm(current_cred(), sid, SECCLASS_PACKET,
+				  PACKET__RELABELTO, NULL);
 }
 
 static void selinux_secmark_refcount_inc(void)
@@ -5877,9 +5878,9 @@ static int selinux_tun_dev_attach_queue(void *security)
 {
 	struct tun_security_struct *tunsec = selinux_tun_dev(security);
 
-	return cred_has_perm(current_cred(), tunsec->sid,
-			     SECCLASS_TUN_SOCKET, TUN_SOCKET__ATTACH_QUEUE,
-			     NULL);
+	return cred_tsid_has_perm(current_cred(), tunsec->sid,
+				  SECCLASS_TUN_SOCKET, TUN_SOCKET__ATTACH_QUEUE,
+				  NULL);
 }
 
 static int selinux_tun_dev_attach(struct sock *sk, void *security)
@@ -5906,8 +5907,8 @@ static int selinux_tun_dev_open(void *security)
 	struct tun_security_struct *tunsec = selinux_tun_dev(security);
 	int err;
 
-	err = cred_has_perm(cred, tunsec->sid, SECCLASS_TUN_SOCKET,
-			    TUN_SOCKET__RELABELFROM, NULL);
+	err = cred_tsid_has_perm(cred, tunsec->sid, SECCLASS_TUN_SOCKET,
+				 TUN_SOCKET__RELABELFROM, NULL);
 	if (err)
 		return err;
 	err = cred_self_has_perm(cred, SECCLASS_TUN_SOCKET,
@@ -6297,8 +6298,8 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = ipc_perms->key;
 
-	return cred_has_perm(current_cred(), isec->sid, isec->sclass, perms,
-			     &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, isec->sclass, perms,
+				  &ad);
 }
 
 static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
@@ -6323,8 +6324,8 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
-			     MSGQ__CREATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
+				  MSGQ__CREATE, &ad);
 }
 
 static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
@@ -6337,8 +6338,8 @@ static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
-			    MSGQ__ASSOCIATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
+				  MSGQ__ASSOCIATE, &ad);
 }
 
 static int selinux_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
@@ -6349,8 +6350,8 @@ static int selinux_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
 	case IPC_INFO:
 	case MSG_INFO:
 		/* No specific object, just general system-wide information. */
-		return cred_has_perm(current_cred(), SECINITSID_KERNEL,
-				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
+		return cred_tsid_has_perm(current_cred(), SECINITSID_KERNEL,
+					  SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case IPC_STAT:
 	case MSG_STAT:
 	case MSG_STAT_ANY:
@@ -6399,11 +6400,11 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
 	ad.u.ipc_id = msq->key;
 
 	/* Can this process write to the queue? */
-	rc = cred_has_perm(cred, isec->sid, SECCLASS_MSGQ, MSGQ__WRITE, &ad);
+	rc = cred_tsid_has_perm(cred, isec->sid, SECCLASS_MSGQ, MSGQ__WRITE, &ad);
 	if (!rc)
 		/* Can this process send the message */
-		rc = cred_has_perm(cred, msec->sid, SECCLASS_MSG, MSG__SEND,
-				   &ad);
+		rc = cred_tsid_has_perm(cred, msec->sid, SECCLASS_MSG, MSG__SEND,
+					&ad);
 	if (!rc)
 		/* Can the message be put in the queue? */
 		rc = cred_ssid_has_perm(cred, msec->sid, isec->sid,
@@ -6450,8 +6451,8 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
-			     SHM__CREATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
+				  SHM__CREATE, &ad);
 }
 
 static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
@@ -6464,8 +6465,8 @@ static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
-			     SHM__ASSOCIATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
+				  SHM__ASSOCIATE, &ad);
 }
 
 /* Note, at this point, shp is locked down */
@@ -6477,9 +6478,9 @@ static int selinux_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
 	case IPC_INFO:
 	case SHM_INFO:
 		/* No specific object, just general system-wide information. */
-		return cred_has_perm(current_cred(), SECINITSID_KERNEL,
-				     SECCLASS_SYSTEM, SYSTEM__IPC_INFO,
-				     NULL);
+		return cred_tsid_has_perm(current_cred(), SECINITSID_KERNEL,
+					  SECCLASS_SYSTEM, SYSTEM__IPC_INFO,
+					  NULL);
 	case IPC_STAT:
 	case SHM_STAT:
 	case SHM_STAT_ANY:
@@ -6527,8 +6528,8 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
-			     SEM__CREATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
+				  SEM__CREATE, &ad);
 }
 
 static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
@@ -6541,8 +6542,8 @@ static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
-			     SEM__ASSOCIATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
+				  SEM__ASSOCIATE, &ad);
 }
 
 /* Note, at this point, sma is locked down */
@@ -6555,9 +6556,9 @@ static int selinux_sem_semctl(struct kern_ipc_perm *sma, int cmd)
 	case IPC_INFO:
 	case SEM_INFO:
 		/* No specific object, just general system-wide information. */
-		return cred_has_perm(current_cred(), SECINITSID_KERNEL,
-				     SECCLASS_SYSTEM, SYSTEM__IPC_INFO,
-				     NULL);
+		return cred_tsid_has_perm(current_cred(), SECINITSID_KERNEL,
+					  SECCLASS_SYSTEM, SYSTEM__IPC_INFO,
+					  NULL);
 	case GETPID:
 	case GETNCNT:
 	case GETZCNT:
@@ -6786,8 +6787,8 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		tsec->create_sid = sid;
 	} else if (attr == LSM_ATTR_KEYCREATE) {
 		if (sid) {
-			error = cred_has_perm(cred, sid, SECCLASS_KEY,
-					      KEY__CREATE, NULL);
+			error = cred_tsid_has_perm(cred, sid, SECCLASS_KEY,
+						   KEY__CREATE, NULL);
 			if (error)
 				goto abort_change;
 		}
@@ -7046,7 +7047,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	key = key_ref_to_ptr(key_ref);
 	ksec = selinux_key(key);
 
-	return cred_has_perm(cred, ksec->sid, SECCLASS_KEY, perm, NULL);
+	return cred_tsid_has_perm(cred, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
@@ -7069,8 +7070,8 @@ static int selinux_watch_key(struct key *key)
 {
 	struct key_security_struct *ksec = selinux_key(key);
 
-	return cred_has_perm(current_cred(), ksec->sid, SECCLASS_KEY,
-			     KEY__VIEW, NULL);
+	return cred_tsid_has_perm(current_cred(), ksec->sid, SECCLASS_KEY,
+				  KEY__VIEW, NULL);
 }
 #endif
 #endif
@@ -7185,15 +7186,15 @@ static int bpf_fd_pass(const struct file *file, const struct cred *cred)
 	if (file->f_op == &bpf_map_fops) {
 		map = file->private_data;
 		bpfsec = map->security;
-		ret = cred_has_perm(cred, bpfsec->sid, SECCLASS_BPF,
-				   bpf_map_fmode_to_av(file->f_mode), NULL);
+		ret = cred_tsid_has_perm(cred, bpfsec->sid, SECCLASS_BPF,
+					 bpf_map_fmode_to_av(file->f_mode), NULL);
 		if (ret)
 			return ret;
 	} else if (file->f_op == &bpf_prog_fops) {
 		prog = file->private_data;
 		bpfsec = prog->aux->security;
-		ret = cred_has_perm(cred, bpfsec->sid, SECCLASS_BPF,
-				   BPF__PROG_RUN, NULL);
+		ret = cred_tsid_has_perm(cred, bpfsec->sid, SECCLASS_BPF,
+					 BPF__PROG_RUN, NULL);
 		if (ret)
 			return ret;
 	}
@@ -7205,8 +7206,8 @@ static int selinux_bpf_map(struct bpf_map *map, fmode_t fmode)
 	struct bpf_security_struct *bpfsec;
 
 	bpfsec = map->security;
-	return cred_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
-			     bpf_map_fmode_to_av(fmode), NULL);
+	return cred_tsid_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
+				  bpf_map_fmode_to_av(fmode), NULL);
 }
 
 static int selinux_bpf_prog(struct bpf_prog *prog)
@@ -7214,8 +7215,8 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
 	struct bpf_security_struct *bpfsec;
 
 	bpfsec = prog->aux->security;
-	return cred_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
-			    BPF__PROG_RUN, NULL);
+	return cred_tsid_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
+				  BPF__PROG_RUN, NULL);
 }
 
 static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
@@ -7339,16 +7340,16 @@ static int selinux_perf_event_read(struct perf_event *event)
 {
 	struct perf_event_security_struct *perfsec = event->security;
 
-	return cred_has_perm(current_cred(), perfsec->sid,
-			     SECCLASS_PERF_EVENT, PERF_EVENT__READ, NULL);
+	return cred_tsid_has_perm(current_cred(), perfsec->sid,
+				  SECCLASS_PERF_EVENT, PERF_EVENT__READ, NULL);
 }
 
 static int selinux_perf_event_write(struct perf_event *event)
 {
 	struct perf_event_security_struct *perfsec = event->security;
 
-	return cred_has_perm(current_cred(), perfsec->sid,
-			     SECCLASS_PERF_EVENT, PERF_EVENT__WRITE, NULL);
+	return cred_tsid_has_perm(current_cred(), perfsec->sid,
+				  SECCLASS_PERF_EVENT, PERF_EVENT__WRITE, NULL);
 }
 #endif
 
@@ -7396,8 +7397,8 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 	ad.type = LSM_AUDIT_DATA_FILE;
 	ad.u.file = file;
 
-	return cred_has_perm(current_cred(), isec->sid,
-			    SECCLASS_IO_URING, IO_URING__CMD, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid,
+				  SECCLASS_IO_URING, IO_URING__CMD, &ad);
 }
 
 /**
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index fd8c6b3a32df..5c6c07033711 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -163,11 +163,11 @@ int cred_self_has_perm(const struct cred *cred, u16 tclass, u32 requested,
 int cred_self_has_perm_noaudit(const struct cred *cred, u16 tclass,
 			       u32 requested);
 
-int cred_has_perm(const struct cred *cred, u32 tsid, u16 tclass, u32 requested,
-		  struct common_audit_data *ad);
+int cred_tsid_has_perm(const struct cred *cred, u32 tsid, u16 tclass,
+		       u32 requested, struct common_audit_data *ad);
 
-int cred_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
-			  u32 requested, struct av_decision *avd);
+int cred_tsid_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
+			       u32 requested, struct av_decision *avd);
 
 int cred_ssid_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
 		       u32 requested, struct common_audit_data *ad);
-- 
2.50.1

