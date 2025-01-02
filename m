Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016BF156960
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836356; cv=none; b=EzA5n41KAJiO1sVxCmi5oU3hh7O1MurBSEdJ1yu2fXvZXeGOPMgxWR3yQBT+XLEiYffQ3/nTRzAdUfrCx6xv9hDHi6NQSOQ2cFwJE7pd07VFOBV0cLYQEmCNriohOo0bZ8rNJJGnHizJ+ReLS4UsN3+DmFBQ00vdJitqElIdUiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836356; c=relaxed/simple;
	bh=J5ir3pXzVWcVZLlOckA90l1C7TFB8uRC8Osq2JnD+yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hmUllVffOXdiGhb3ERiwoV/M41ZRX7K+uxOcyzwZaj62p7zNgZlYxqmKt4R12vo0ZMIyPi32xX8hPx6xKtPO/r5pKb6Gl8T3WgCaPvTM9E9c95Sz+WpB6ZYAvX+jtcWadlq4dmZpvvO5vitoyKYbO/9gGTnLB88o+Al88ROmPLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEc9ST4b; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEc9ST4b"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467918c360aso133677751cf.0
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836351; x=1736441151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2S401lEPZsDKsA1n3s9T88OCDi2dN+S969GJxv7UcS8=;
        b=UEc9ST4by4WG/1AU1dJn9uTqZQhbiFUfJZC6oEpCPLKsQt/EHZ1d9L56Umx+1SffFs
         6ZnyVMWaPBTRJSjhkYZUA8CFY84Li5NfYiNMCYPSxCJ7Jo3dQuUjt2i9n2ULnuCja6Hh
         cP4KS75g1SME+aMRBgEjfc+2JFPmrZlwEMi4cpWw3IhvVZIk1n22yoHXoL8t6kPQs1np
         cNh7wvo/owQINOEpGHXkHC25xq3EvyUxsRM9O6rYi/tm2ZlW2sacmxY37t1MgwKVG4U+
         0FSov37NYfxxNwoB+849HOjhRvUoVUQVxLhoRe1SzUQGfT6PUk7KoP6yon4fDA6xZ0Vb
         jrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836351; x=1736441151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2S401lEPZsDKsA1n3s9T88OCDi2dN+S969GJxv7UcS8=;
        b=bfBUia1bhuja7GXOVcb8+3wd7L15cdkJaGr1kdUVd1GHD6lrwZ5BSkByObgik7XW25
         yhedkaZdikIxzh74toi6uDzQ+fKuIPSP1JcbNuw3YGmdfAxaxF6uK70gVepYxqTNTpeZ
         +YAHr4AmgAOS3njrA7Xy+4bU87n5LxhbLmswpZZaoa5GGvK/IXgsvCvvuVvZft8KZ6YZ
         I0Kjdb11EyQlVCmhj0aWJYuQVZMCyipPKhC4x4vFnkeVdkg4+z+R/DtdIqLuUIX+NCIC
         G1IBxgDqmEvIiQRx9rblT8tWkfb/ml97vT/dO0Pfwq7qkKJOVcrM1LA8h/0SSRbs0NCE
         Va1Q==
X-Gm-Message-State: AOJu0YwBvD8ODIOz5MSVGxHr9cMny8hBZ9Teq/buiL/dgQNhJNi2KrO9
	F9vGIFaD9fwsSBeKDPgoIVAoNhDc7ZNN6+OUq7evyj4z5Vr1/cGznMc6yg==
X-Gm-Gg: ASbGncuhP0tsH3v5o7XgvW71K/W2kZ9Tv9jEOXifKB0T3R7yH+Qelh5nbktZWvog1JW
	sBltfpD9XtcBJbZzHOGNw7odWua91JE3MEm4ZgR08vGNWwL6LIUXgHIuqD3KXxmBadQw0cte/0q
	zF+gCalGU2QQhYkFql6UBZPen9ro9UjJUyQsvhqQRsTbvL0nzU/u/feu1LqGNIALUGG9kcR2e0W
	rYZqVMbdmQ6GEnbjcFXG4AilJ2UNoNfaFszAbnwDaWOLosgUAVOgf3o6pn937nfPhWRpEiSGJsJ
	TCqULrawc5hLFu3kMIRZPBFI6DvO+uU1kAzQsyhsugyYPwehpxtANxXUJx9I60ZTSAXx8g==
X-Google-Smtp-Source: AGHT+IHWC34Ru4w2jFqRfyZaxevHnabZsS6UIkuWEop9fo+dW8eOSHZbYSeIPnGgnRlNKMIPpcSpeQ==
X-Received: by 2002:ac8:7f41:0:b0:466:b394:92bc with SMTP id d75a77b69052e-46a4a8b81famr689964751cf.6.1735836350948;
        Thu, 02 Jan 2025 08:45:50 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:50 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 23/44] selinux: rename cred_has_perm*() to cred_tsid_has_perm*()
Date: Thu,  2 Jan 2025 11:44:48 -0500
Message-Id: <20250102164509.25606-24-stephen.smalley.work@gmail.com>
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

Rename cred_has_perm*() to cred_tsid_has_perm*() for greater
clarity and parallelism with the other helper functions.
These functions check permissions between a cred and a fixed
target SID for the current namespace and its ancestors.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         |  12 +-
 security/selinux/hooks.c       | 240 ++++++++++++++++-----------------
 security/selinux/include/avc.h |   8 +-
 3 files changed, 130 insertions(+), 130 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 480ffac13c19..250d56dae487 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1481,7 +1481,7 @@ int cred_self_has_perm_noaudit(const struct cred *cred, u16 tclass,
 
 
 /**
- * cred_has_perm - Check and audit permissions on a (cred, tsid) pair
+ * cred_tsid_has_perm - Check and audit permissions on a (cred, tsid) pair
  * @cred: subject credentials
  * @tsid: target security identifier
  * @tclass: target security class
@@ -1498,8 +1498,8 @@ int cred_self_has_perm_noaudit(const struct cred *cred, u16 tclass,
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
@@ -1521,7 +1521,7 @@ int cred_has_perm(const struct cred *cred, u32 tsid, u16 tclass,
 }
 
 /**
- * cred_has_perm_noaudit - Check permissions on a (cred, tsid) pair, no audit
+ * cred_tsid_has_perm_noaudit - Check permissions on a (cred, tsid) pair, no audit
  * @cred: subject credentials
  * @tsid: target security identifier
  * @tclass: target security class
@@ -1536,8 +1536,8 @@ int cred_has_perm(const struct cred *cred, u32 tsid, u16 tclass,
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
index 5a0355229ad3..1619d5c2c187 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -454,13 +454,13 @@ static int may_context_mount_sb_relabel(u32 sid,
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
 
@@ -470,8 +470,8 @@ static int may_context_mount_inode_relabel(u32 sid,
 {
 	int rc;
 
-	rc = cred_has_perm(cred, sbsec->sid, SECCLASS_FILESYSTEM,
-			  FILESYSTEM__RELABELFROM, NULL);
+	rc = cred_tsid_has_perm(cred, sbsec->sid, SECCLASS_FILESYSTEM,
+				FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
@@ -1691,7 +1691,7 @@ static int inode_has_perm(const struct cred *cred,
 
 	isec = selinux_inode(inode);
 
-	return cred_has_perm(cred, isec->sid, isec->sclass, perms, adp);
+	return cred_tsid_has_perm(cred, isec->sid, isec->sclass, perms, adp);
 }
 
 /* Same as inode_has_perm, but pass explicit audit data containing
@@ -1764,8 +1764,8 @@ static int file_has_perm(const struct cred *cred,
 	ad.u.file = file;
 
 	if (sid != fsec->sid) {
-		rc = cred_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
-				   &ad);
+		rc = cred_tsid_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
+					&ad);
 		if (rc)
 			goto out;
 	}
@@ -1832,9 +1832,9 @@ static int may_create(struct inode *dir,
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
 
@@ -1843,7 +1843,7 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	rc = cred_has_perm(cred, newsid, tclass, FILE__CREATE, &ad);
+	rc = cred_tsid_has_perm(cred, newsid, tclass, FILE__CREATE, &ad);
 	if (rc)
 		return rc;
 
@@ -1876,7 +1876,7 @@ static int may_link(struct inode *dir,
 
 	av = DIR__SEARCH;
 	av |= (kind ? DIR__REMOVE_NAME : DIR__ADD_NAME);
-	rc = cred_has_perm(cred, dsec->sid, SECCLASS_DIR, av, &ad);
+	rc = cred_tsid_has_perm(cred, dsec->sid, SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
 
@@ -1896,7 +1896,7 @@ static int may_link(struct inode *dir,
 		return 0;
 	}
 
-	return cred_has_perm(cred, isec->sid, isec->sclass, av, &ad);
+	return cred_tsid_has_perm(cred, isec->sid, isec->sclass, av, &ad);
 }
 
 static inline int may_rename(struct inode *old_dir,
@@ -1919,17 +1919,17 @@ static inline int may_rename(struct inode *old_dir,
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
@@ -1938,15 +1938,15 @@ static inline int may_rename(struct inode *old_dir,
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
@@ -1963,8 +1963,8 @@ static int superblock_has_perm(const struct cred *cred,
 	struct superblock_security_struct *sbsec;
 
 	sbsec = selinux_superblock(sb);
-	return cred_has_perm(cred, sbsec->sid, SECCLASS_FILESYSTEM, perms,
-			     ad);
+	return cred_tsid_has_perm(cred, sbsec->sid, SECCLASS_FILESYSTEM, perms,
+				  ad);
 }
 
 /* Convert a Linux mode and permission mask to an access vector. */
@@ -2083,8 +2083,8 @@ static int selinux_binder_transfer_file(const struct cred *from,
 	ad.u.path = file->f_path;
 
 	if (sid != fsec->sid) {
-		rc = cred_has_perm(to, fsec->sid, SECCLASS_FD, FD__USE,
-				   &ad);
+		rc = cred_tsid_has_perm(to, fsec->sid, SECCLASS_FD, FD__USE,
+					&ad);
 		if (rc)
 			return rc;
 	}
@@ -2099,8 +2099,8 @@ static int selinux_binder_transfer_file(const struct cred *from,
 		return 0;
 
 	isec = backing_inode_security(dentry);
-	return cred_has_perm(to, isec->sid, isec->sclass, file_to_av(file),
-			     &ad);
+	return cred_tsid_has_perm(to, isec->sid, isec->sclass, file_to_av(file),
+				  &ad);
 }
 
 static int selinux_ptrace_access_check(struct task_struct *child,
@@ -2201,20 +2201,20 @@ static int selinux_syslog(int type)
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
@@ -2448,8 +2448,8 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
@@ -3059,8 +3059,8 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 	ad.type = LSM_AUDIT_DATA_ANONINODE;
 	ad.u.anonclass = name ? (const char *)name->name : "?";
 
-	return cred_has_perm(current_cred(), isec->sid, isec->sclass,
-			     FILE__CREATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, isec->sclass,
+				  FILE__CREATE, &ad);
 }
 
 static int selinux_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
@@ -3123,8 +3123,8 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	return cred_has_perm(current_cred(), isec->sid, isec->sclass,
-			     FILE__READ, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, isec->sclass,
+				  FILE__READ, &ad);
 }
 
 static noinline int audit_inode_permission(struct inode *inode,
@@ -3168,8 +3168,8 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	rc = cred_has_perm_noaudit(current_cred(), isec->sid, isec->sclass,
-				   perms, &avd);
+	rc = cred_tsid_has_perm_noaudit(current_cred(), isec->sid, isec->sclass,
+					perms, &avd);
 	audited = avc_audit_required(perms, &avd, rc,
 				     from_access ? FILE__AUDIT_ACCESS : 0,
 				     &denied);
@@ -3275,8 +3275,8 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	ad.u.dentry = dentry;
 
 	isec = backing_inode_security(dentry);
-	rc = cred_has_perm(cred, isec->sid, isec->sclass, FILE__RELABELFROM,
-			   &ad);
+	rc = cred_tsid_has_perm(cred, isec->sid, isec->sclass, FILE__RELABELFROM,
+				&ad);
 	if (rc)
 		return rc;
 
@@ -3315,8 +3315,8 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	if (rc)
 		return rc;
 
-	rc = cred_has_perm(cred, newsid, isec->sclass, FILE__RELABELTO,
-			   &ad);
+	rc = cred_tsid_has_perm(cred, newsid, isec->sclass, FILE__RELABELTO,
+				&ad);
 	if (rc)
 		return rc;
 
@@ -3738,8 +3738,8 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	ad.u.op->path = file->f_path;
 
 	if (ssid != fsec->sid) {
-		rc = cred_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
-				   &ad);
+		rc = cred_tsid_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
+					&ad);
 		if (rc)
 			goto out;
 	}
@@ -4123,8 +4123,8 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 	struct task_security_struct *tsec = selinux_cred(new);
 	int ret;
 
-	ret = cred_has_perm(current_cred(), secid, SECCLASS_KERNEL_SERVICE,
-			    KERNEL_SERVICE__USE_AS_OVERRIDE, NULL);
+	ret = cred_tsid_has_perm(current_cred(), secid, SECCLASS_KERNEL_SERVICE,
+				 KERNEL_SERVICE__USE_AS_OVERRIDE, NULL);
 	if (ret == 0) {
 		tsec->sid = secid;
 		tsec->create_sid = 0;
@@ -4144,10 +4144,10 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
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
@@ -4161,8 +4161,8 @@ static int selinux_kernel_module_request(char *kmod_name)
 	ad.type = LSM_AUDIT_DATA_KMOD;
 	ad.u.kmod_name = kmod_name;
 
-	return cred_has_perm(current_cred(), SECINITSID_KERNEL,
-			     SECCLASS_SYSTEM, SYSTEM__MODULE_REQUEST, &ad);
+	return cred_tsid_has_perm(current_cred(), SECINITSID_KERNEL,
+				  SECCLASS_SYSTEM, SYSTEM__MODULE_REQUEST, &ad);
 }
 
 static int selinux_kernel_module_from_file(struct file *file)
@@ -4186,15 +4186,15 @@ static int selinux_kernel_module_from_file(struct file *file)
 
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
-	return cred_has_perm(cred, isec->sid, SECCLASS_SYSTEM,
-			     SYSTEM__MODULE_LOAD, &ad);
+	return cred_tsid_has_perm(cred, isec->sid, SECCLASS_SYSTEM,
+				  SYSTEM__MODULE_LOAD, &ad);
 }
 
 static int selinux_kernel_read_file(struct file *file,
@@ -4702,8 +4702,8 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 
 	ad_net_init_from_sk(&ad, &net, sk);
 
-	return cred_has_perm(current_cred(), sksec->sid, sksec->sclass,
-			     perms, &ad);
+	return cred_tsid_has_perm(current_cred(), sksec->sid, sksec->sclass,
+				  perms, &ad);
 }
 
 static int selinux_socket_create(int family, int type,
@@ -4722,8 +4722,8 @@ static int selinux_socket_create(int family, int type,
 	if (rc)
 		return rc;
 
-	return cred_has_perm(current_cred(), newsid, secclass,
-			     SOCKET__CREATE, NULL);
+	return cred_tsid_has_perm(current_cred(), newsid, secclass,
+				  SOCKET__CREATE, NULL);
 }
 
 static int selinux_socket_post_create(struct socket *sock, int family,
@@ -5672,8 +5672,8 @@ static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 
 static int selinux_secmark_relabel_packet(u32 sid)
 {
-	return cred_has_perm(current_cred(), sid, SECCLASS_PACKET,
-			    PACKET__RELABELTO, NULL);
+	return cred_tsid_has_perm(current_cred(), sid, SECCLASS_PACKET,
+				  PACKET__RELABELTO, NULL);
 }
 
 static void selinux_secmark_refcount_inc(void)
@@ -5717,9 +5717,9 @@ static int selinux_tun_dev_attach_queue(void *security)
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
@@ -5746,8 +5746,8 @@ static int selinux_tun_dev_open(void *security)
 	struct tun_security_struct *tunsec = selinux_tun_dev(security);
 	int err;
 
-	err = cred_has_perm(cred, tunsec->sid, SECCLASS_TUN_SOCKET,
-			    TUN_SOCKET__RELABELFROM, NULL);
+	err = cred_tsid_has_perm(cred, tunsec->sid, SECCLASS_TUN_SOCKET,
+				 TUN_SOCKET__RELABELFROM, NULL);
 	if (err)
 		return err;
 	err = cred_self_has_perm(cred, SECCLASS_TUN_SOCKET,
@@ -6137,8 +6137,8 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = ipc_perms->key;
 
-	return cred_has_perm(current_cred(), isec->sid, isec->sclass, perms,
-			     &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, isec->sclass, perms,
+				  &ad);
 }
 
 static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
@@ -6163,8 +6163,8 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
-			     MSGQ__CREATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
+				  MSGQ__CREATE, &ad);
 }
 
 static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
@@ -6177,8 +6177,8 @@ static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
-			    MSGQ__ASSOCIATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
+				  MSGQ__ASSOCIATE, &ad);
 }
 
 static int selinux_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
@@ -6189,8 +6189,8 @@ static int selinux_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
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
@@ -6239,11 +6239,11 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
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
@@ -6290,8 +6290,8 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
-			     SHM__CREATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
+				  SHM__CREATE, &ad);
 }
 
 static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
@@ -6304,8 +6304,8 @@ static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
-			     SHM__ASSOCIATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
+				  SHM__ASSOCIATE, &ad);
 }
 
 /* Note, at this point, shp is locked down */
@@ -6317,9 +6317,9 @@ static int selinux_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
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
@@ -6367,8 +6367,8 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
-			     SEM__CREATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
+				  SEM__CREATE, &ad);
 }
 
 static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
@@ -6381,8 +6381,8 @@ static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
-			     SEM__ASSOCIATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
+				  SEM__ASSOCIATE, &ad);
 }
 
 /* Note, at this point, sma is locked down */
@@ -6395,9 +6395,9 @@ static int selinux_sem_semctl(struct kern_ipc_perm *sma, int cmd)
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
@@ -6626,8 +6626,8 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
@@ -6866,7 +6866,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	key = key_ref_to_ptr(key_ref);
 	ksec = selinux_key(key);
 
-	return cred_has_perm(cred, ksec->sid, SECCLASS_KEY, perm, NULL);
+	return cred_tsid_has_perm(cred, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
@@ -6889,8 +6889,8 @@ static int selinux_watch_key(struct key *key)
 {
 	struct key_security_struct *ksec = selinux_key(key);
 
-	return cred_has_perm(current_cred(), ksec->sid, SECCLASS_KEY,
-			     KEY__VIEW, NULL);
+	return cred_tsid_has_perm(current_cred(), ksec->sid, SECCLASS_KEY,
+				  KEY__VIEW, NULL);
 }
 #endif
 #endif
@@ -7005,15 +7005,15 @@ static int bpf_fd_pass(const struct file *file, const struct cred *cred)
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
@@ -7025,8 +7025,8 @@ static int selinux_bpf_map(struct bpf_map *map, fmode_t fmode)
 	struct bpf_security_struct *bpfsec;
 
 	bpfsec = map->security;
-	return cred_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
-			     bpf_map_fmode_to_av(fmode), NULL);
+	return cred_tsid_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
+				  bpf_map_fmode_to_av(fmode), NULL);
 }
 
 static int selinux_bpf_prog(struct bpf_prog *prog)
@@ -7034,8 +7034,8 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
 	struct bpf_security_struct *bpfsec;
 
 	bpfsec = prog->aux->security;
-	return cred_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
-			    BPF__PROG_RUN, NULL);
+	return cred_tsid_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
+				  BPF__PROG_RUN, NULL);
 }
 
 static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
@@ -7159,16 +7159,16 @@ static int selinux_perf_event_read(struct perf_event *event)
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
 
@@ -7216,8 +7216,8 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 	ad.type = LSM_AUDIT_DATA_FILE;
 	ad.u.file = file;
 
-	return cred_has_perm(current_cred(), isec->sid,
-			    SECCLASS_IO_URING, IO_URING__CMD, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid,
+				  SECCLASS_IO_URING, IO_URING__CMD, &ad);
 }
 #endif /* CONFIG_IO_URING */
 
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index e47b75819f4a..967848594270 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -158,11 +158,11 @@ int cred_self_has_perm(const struct cred *cred, u16 tclass, u32 requested,
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
2.47.1

