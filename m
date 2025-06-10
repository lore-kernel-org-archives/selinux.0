Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF16A24DCE8;
	Tue, 10 Jun 2025 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576210; cv=none; b=eb7sJcm6z6d+8pP001IrX6ipWX+RQ48ihOWIn2nq9j3PQixUNwR4/y0PhCqubF0X5U5mFp48O/pVtrvjHoBJie7sIjJtiit8xJI8eXLMZofeOvL/pBszDMAe4IiB/RTKHK2ncIc4P95Ruw9xQPu1sQnSgGD/zujy7sdheglNaBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576210; c=relaxed/simple;
	bh=Nuid2LPD6VebyF86t/lag9XKGxG+/mOnhmAL+1/4pT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O51+9bi6mkkbjTh+CP5lk9FaDKixPb2DibQPlIgnUxtE0e7zMws6+KK/yKFHntEdAwPfbK8I5FzhU2NqeZREF57PL9ivKcNgNeBnYNIN0Wfc4hYuwuj/uwypMEdoj1nxN0lTReHuKnyO+tcGYM5Uap9Hh84CjzNiVErFje1ungE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS8+GfzZ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS8+GfzZ"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a5ae2fdf4eso897291cf.0;
        Tue, 10 Jun 2025 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576206; x=1750181006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYUTHM83cnZk9ePVapLwILTlRxXT0aSgCKbxU/rwBgM=;
        b=kS8+GfzZDBPjdpG44lwAeNF8itlaREuTFe0gTOX03qTzy9Rkwf/BT342z/U/E+6bcQ
         JbZURYwBkMe79xzIKKunlQZ2mM9x6xIE3dUpF0NquTV/vtCTNJbmlgTKsi7yFNlrNcyo
         Cbq1QjacZEVzozV9ibPLuCI1TpfCM7rHf/2vuuEKC1r172tm4knT0XgSBJobQH8YTp70
         xLaxY3TU6LwhpMDYtSQFmbEumZLqMCoegwpum1uYs2isy5rvpw6oEYritfutYr5+yeco
         BzcL4FkhgKDuzaG3ULwHR6+DvVd9jkpK2kzlYe4AUidEdH8SF26nhhhyZRKLl73iYv1g
         h5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576206; x=1750181006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYUTHM83cnZk9ePVapLwILTlRxXT0aSgCKbxU/rwBgM=;
        b=sPFOBU+pVn+mK6nbqz117BE70P/R+Iihw0i6yzoEON2SHGBEid5FGuSg0eo/991NDa
         sUslO6XQ96c09Jvb0olRxExZjTlGeL7+CE/Wdsd3Kzr7eKTjUA0xUe131OYWotHybROE
         FBHJBh9s2upaHIb896zYzXT+qs5ii2Vv3AbihFv/wyRSqM2kvIlpaec7H6aZjg+us5Jt
         e2wybxesb+I+Wv29RVHLLa1Aj0aoj4G4u696BIfT8KiHAVmYlQ0hEaPkWlS6jfv0sRNt
         P5YNR41hRLfskEHvhSInpP7bXv391sL1gZRLAMbxfO9+z3b3zrjF0EDKXMSGAS7jdMie
         ABWg==
X-Forwarded-Encrypted: i=1; AJvYcCVH7mwbBXAo0kZDsE/EcBsJ2mGT4C8yAU2BavcNERvDhDfYXMoD7d4V82oshIL5egDiLDFWYgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Co1aZTeDH050wKR04/nolBlxi2kickmN8mopXxEIqTvUao6/
	Eo/VJN0NsWmUiZEoKFiAPNsbV55GELBGbeqyFm8Jo3LCgLCZ+tiJF2fg3BmY2g==
X-Gm-Gg: ASbGncvgxl4Oo8rD48TvSD3Kwz1SB363mV+qt3whpuwZTpiPet4i/zYPE+TOM83M9O9
	Z7GkLcaGzPHhX3q9N+yJ6Lf+s7h6ykTQsOufFLpW7WG7OjaQN7AIqOvlGyiHPb35z8rfkUWDIXP
	wMGX8ZtfZilUQIO6LdWplCFS5MhsTVjWvSJgf7oTcpyyWAHdIvFwfUmKbxFVdu1eVivL5Bl68cM
	97KR0sIs7mlm0FDywOCfka/VkpC2LeDU195R4SljP6tRHz4NdPCroBwZhuL4l+yuW5a+nzEKs9G
	jqSCStPeO/KQsCLw2Yuvq2wQsXidIhgNDulfHtNF4vk5sC1uxNnfBxR3ePZrxjPUaMJaALIj8tV
	G3K/e7/iLY7CGpuBoY2CNJ4LSjKX4p22o3a/k2WJGcQn3JmeQOPl3xdTwvJMKUVMIZQ==
X-Google-Smtp-Source: AGHT+IFWUjSE68V4QPW530XgrQ+WasS4mlIbv5DsKZ7ocWp3JORf+/YO7abbgb2ixpNqEvzbZSm/dg==
X-Received: by 2002:a05:622a:2304:b0:4a3:5ba8:4973 with SMTP id d75a77b69052e-4a713c3bca1mr4383381cf.5.1749576205973;
        Tue, 10 Jun 2025 10:23:25 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:25 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 31/42] selinux: rename cred_has_perm*() to cred_tsid_has_perm*()
Date: Tue, 10 Jun 2025 13:22:02 -0400
Message-ID: <20250610172226.1470741-32-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
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
index fc40e840a143..efafe8a06908 100644
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
index 25f7b9dd77d4..c04eda2f18fc 100644
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
@@ -3279,8 +3279,8 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 		struct av_decision avd;
 
 		/* Cache miss. */
-		rc = cred_has_perm_noaudit(current_cred(), isec->sid,
-					   isec->sclass, perms, &avd);
+		rc = cred_tsid_has_perm_noaudit(current_cred(), isec->sid,
+						isec->sclass, perms, &avd);
 		audited = avc_audit_required(perms, &avd, rc,
 			(requested & MAY_ACCESS) ? FILE__AUDIT_ACCESS : 0,
 			&denied);
@@ -3390,8 +3390,8 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	ad.u.dentry = dentry;
 
 	isec = backing_inode_security(dentry);
-	rc = cred_has_perm(cred, isec->sid, isec->sclass, FILE__RELABELFROM,
-			   &ad);
+	rc = cred_tsid_has_perm(cred, isec->sid, isec->sclass, FILE__RELABELFROM,
+				&ad);
 	if (rc)
 		return rc;
 
@@ -3430,8 +3430,8 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	if (rc)
 		return rc;
 
-	rc = cred_has_perm(cred, newsid, isec->sclass, FILE__RELABELTO,
-			   &ad);
+	rc = cred_tsid_has_perm(cred, newsid, isec->sclass, FILE__RELABELTO,
+				&ad);
 	if (rc)
 		return rc;
 
@@ -3860,8 +3860,8 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	ad.u.op->path = file->f_path;
 
 	if (ssid != fsec->sid) {
-		rc = cred_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
-				   &ad);
+		rc = cred_tsid_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
+					&ad);
 		if (rc)
 			goto out;
 	}
@@ -4246,8 +4246,8 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 	struct task_security_struct *tsec = selinux_cred(new);
 	int ret;
 
-	ret = cred_has_perm(current_cred(), secid, SECCLASS_KERNEL_SERVICE,
-			    KERNEL_SERVICE__USE_AS_OVERRIDE, NULL);
+	ret = cred_tsid_has_perm(current_cred(), secid, SECCLASS_KERNEL_SERVICE,
+				 KERNEL_SERVICE__USE_AS_OVERRIDE, NULL);
 	if (ret == 0) {
 		tsec->sid = secid;
 		tsec->create_sid = 0;
@@ -4267,10 +4267,10 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
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
@@ -4284,8 +4284,8 @@ static int selinux_kernel_module_request(char *kmod_name)
 	ad.type = LSM_AUDIT_DATA_KMOD;
 	ad.u.kmod_name = kmod_name;
 
-	return cred_has_perm(current_cred(), SECINITSID_KERNEL,
-			     SECCLASS_SYSTEM, SYSTEM__MODULE_REQUEST, &ad);
+	return cred_tsid_has_perm(current_cred(), SECINITSID_KERNEL,
+				  SECCLASS_SYSTEM, SYSTEM__MODULE_REQUEST, &ad);
 }
 
 static int selinux_kernel_load_from_file(struct file *file, u32 requested)
@@ -4307,14 +4307,15 @@ static int selinux_kernel_load_from_file(struct file *file, u32 requested)
 
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
@@ -4837,8 +4838,8 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 
 	ad_net_init_from_sk(&ad, &net, sk);
 
-	return cred_has_perm(current_cred(), sksec->sid, sksec->sclass,
-			     perms, &ad);
+	return cred_tsid_has_perm(current_cred(), sksec->sid, sksec->sclass,
+				  perms, &ad);
 }
 
 static int selinux_socket_create(int family, int type,
@@ -4857,8 +4858,8 @@ static int selinux_socket_create(int family, int type,
 	if (rc)
 		return rc;
 
-	return cred_has_perm(current_cred(), newsid, secclass,
-			     SOCKET__CREATE, NULL);
+	return cred_tsid_has_perm(current_cred(), newsid, secclass,
+				  SOCKET__CREATE, NULL);
 }
 
 static int selinux_socket_post_create(struct socket *sock, int family,
@@ -5808,8 +5809,8 @@ static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 
 static int selinux_secmark_relabel_packet(u32 sid)
 {
-	return cred_has_perm(current_cred(), sid, SECCLASS_PACKET,
-			    PACKET__RELABELTO, NULL);
+	return cred_tsid_has_perm(current_cred(), sid, SECCLASS_PACKET,
+				  PACKET__RELABELTO, NULL);
 }
 
 static void selinux_secmark_refcount_inc(void)
@@ -5853,9 +5854,9 @@ static int selinux_tun_dev_attach_queue(void *security)
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
@@ -5882,8 +5883,8 @@ static int selinux_tun_dev_open(void *security)
 	struct tun_security_struct *tunsec = selinux_tun_dev(security);
 	int err;
 
-	err = cred_has_perm(cred, tunsec->sid, SECCLASS_TUN_SOCKET,
-			    TUN_SOCKET__RELABELFROM, NULL);
+	err = cred_tsid_has_perm(cred, tunsec->sid, SECCLASS_TUN_SOCKET,
+				 TUN_SOCKET__RELABELFROM, NULL);
 	if (err)
 		return err;
 	err = cred_self_has_perm(cred, SECCLASS_TUN_SOCKET,
@@ -6273,8 +6274,8 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = ipc_perms->key;
 
-	return cred_has_perm(current_cred(), isec->sid, isec->sclass, perms,
-			     &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, isec->sclass, perms,
+				  &ad);
 }
 
 static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
@@ -6299,8 +6300,8 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
-			     MSGQ__CREATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
+				  MSGQ__CREATE, &ad);
 }
 
 static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
@@ -6313,8 +6314,8 @@ static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
-			    MSGQ__ASSOCIATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
+				  MSGQ__ASSOCIATE, &ad);
 }
 
 static int selinux_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
@@ -6325,8 +6326,8 @@ static int selinux_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
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
@@ -6375,11 +6376,11 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
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
@@ -6426,8 +6427,8 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
-			     SHM__CREATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
+				  SHM__CREATE, &ad);
 }
 
 static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
@@ -6440,8 +6441,8 @@ static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
-			     SHM__ASSOCIATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
+				  SHM__ASSOCIATE, &ad);
 }
 
 /* Note, at this point, shp is locked down */
@@ -6453,9 +6454,9 @@ static int selinux_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
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
@@ -6503,8 +6504,8 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
-			     SEM__CREATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
+				  SEM__CREATE, &ad);
 }
 
 static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
@@ -6517,8 +6518,8 @@ static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
-			     SEM__ASSOCIATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
+				  SEM__ASSOCIATE, &ad);
 }
 
 /* Note, at this point, sma is locked down */
@@ -6531,9 +6532,9 @@ static int selinux_sem_semctl(struct kern_ipc_perm *sma, int cmd)
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
@@ -6762,8 +6763,8 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
@@ -7022,7 +7023,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	key = key_ref_to_ptr(key_ref);
 	ksec = selinux_key(key);
 
-	return cred_has_perm(cred, ksec->sid, SECCLASS_KEY, perm, NULL);
+	return cred_tsid_has_perm(cred, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
@@ -7045,8 +7046,8 @@ static int selinux_watch_key(struct key *key)
 {
 	struct key_security_struct *ksec = selinux_key(key);
 
-	return cred_has_perm(current_cred(), ksec->sid, SECCLASS_KEY,
-			     KEY__VIEW, NULL);
+	return cred_tsid_has_perm(current_cred(), ksec->sid, SECCLASS_KEY,
+				  KEY__VIEW, NULL);
 }
 #endif
 #endif
@@ -7161,15 +7162,15 @@ static int bpf_fd_pass(const struct file *file, const struct cred *cred)
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
@@ -7181,8 +7182,8 @@ static int selinux_bpf_map(struct bpf_map *map, fmode_t fmode)
 	struct bpf_security_struct *bpfsec;
 
 	bpfsec = map->security;
-	return cred_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
-			     bpf_map_fmode_to_av(fmode), NULL);
+	return cred_tsid_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
+				  bpf_map_fmode_to_av(fmode), NULL);
 }
 
 static int selinux_bpf_prog(struct bpf_prog *prog)
@@ -7190,8 +7191,8 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
 	struct bpf_security_struct *bpfsec;
 
 	bpfsec = prog->aux->security;
-	return cred_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
-			    BPF__PROG_RUN, NULL);
+	return cred_tsid_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
+				  BPF__PROG_RUN, NULL);
 }
 
 static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
@@ -7315,16 +7316,16 @@ static int selinux_perf_event_read(struct perf_event *event)
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
 
@@ -7372,8 +7373,8 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 	ad.type = LSM_AUDIT_DATA_FILE;
 	ad.u.file = file;
 
-	return cred_has_perm(current_cred(), isec->sid,
-			    SECCLASS_IO_URING, IO_URING__CMD, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid,
+				  SECCLASS_IO_URING, IO_URING__CMD, &ad);
 }
 
 /**
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 9def47812034..1916ee418aa3 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -159,11 +159,11 @@ int cred_self_has_perm(const struct cred *cred, u16 tclass, u32 requested,
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
2.49.0

