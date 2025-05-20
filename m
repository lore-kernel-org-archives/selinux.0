Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22F287505;
	Tue, 20 May 2025 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742501; cv=none; b=QGMtu0zWEgxjrAtvwil0dqkGaZ9PG+XFjUpSkerETolwjv4x85UnVdkVxpF8jt7gmjNDAPOn4VMUSrgGJJfxhz89eQyCMYOg/vHnckNopF84J3UJOo63TvylVQWa0yv1y78v28o2PoOy5ohSsu/rehhsZ+CplhZjpI7vQ1I0AeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742501; c=relaxed/simple;
	bh=2Nm54mU7kOAVoRxyocii9sQ6Tni/WQeNjKJLEJGc6MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAYs1mW0sePbeHmbVL7UgO2e7Pc3/qlo4r1EyZIvRvtlZKz/Ot3ilK0RxdZWl6ozgMiWkFMQvgvMARr03AuyZSyZZurF7ksoFaKhXCIKXH7mec4rulWcksh1WutTopbnkEi4uuZS3GM2ygEAyyaGgnPnFX4aQDDeJNXqgcVx0xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqTOzYLy; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqTOzYLy"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72c13802133so2024508a34.3;
        Tue, 20 May 2025 05:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742498; x=1748347298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dua3v18uREIdn0v3rGgpma8BAFzLDfnoHVTlcgNWZQk=;
        b=YqTOzYLy4h1WP84d7CL/09F9Nai3YHvheQqqTnvqM9Z5/oUi0y9ItEk5KFkNNMVXbo
         AZRKg7lrRWnMjdUJZO+m2JEXBLxXRxUk0FzOpvMEfoGxHlpmB4NP/j8pVpE3HKmmxO9H
         B8q8+FcX7FxIN1N0cl/JGmGqwTrMQsnxr73zxCiKxSK1QJfU8XdJDh911OlXMMgpsz5M
         19jf+yrYd1wwR0AR4nbWEP36oMmrf7HT8knTGP3eGz4UYQ6LqHCy0E3RanLOkTW5TbsI
         sFhOv5whoNUIqKDl9REqSlEgRJAm/yp4NDTRIISf0hjOqjzzrTQWeku4Sm9R1hSUCrIc
         ZQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742498; x=1748347298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dua3v18uREIdn0v3rGgpma8BAFzLDfnoHVTlcgNWZQk=;
        b=YNL1sqxXm4xaaO9yGaIdHjmQ4/mWViFExFdU49JNM4FWiivVdswE1rTzkEs4VuwjQf
         8XgZs2uCDLkHT3V+tqvXHX1AVE+wHfaFRkJBdFgFg+1K8YzIqv4nk1Hp1pt5cADuHycu
         b43pV2B6MBbTpxQyF6DQ9kVM26gmrIPWDBhJbAGqknzF968iTdWH4bed5mxE2ID8t5CY
         rL5u3lEvyMRuWpWGA+TeEUTSSfaJhEH/Xrq5iHSwBTr+ct/3b1Z30mBdFoLQQC7u1sd+
         Pwfoo8hoK5rIzoS9mcNf53mff2w7o/QOZyN9NX9KdTYH8AuvBFHk5cugW8PIRwAAKBzw
         2WcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoWuJ9A7y1lWcSZjgio8Q/KNmf1zvT9i72NNOeTdTLPu/kv+yRD0ybxzlqSp9gvL6ZPi5ACtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo6341ypIVVz7s7UlRN5U7DGm5/xshPYN6XEQ/XvRBUnDwg7sH
	EOm09tqpsJeLIHh9xhX59DiDK7moqKdlSXVs1il744mh+C5YZhW/vo+SdKKTBQ==
X-Gm-Gg: ASbGnctoJL42dmrZS1nCogh19Tc5TZz5NGXmU5RXMdghqD5EacggqJJ5yxPw7ypVnyd
	5w15NVbTKnM60mp3lTOMj90YWC35/YmSviXt6gGi9vWc5SPtXujIyrbxuUWeQejz3m2l5z6hy/U
	lX5oC31YmxyXKqceunZ+rvxNP/zD4IrxkRzgt0DMkiUW7+0RVTZEXq98FGpaT+hSeex45Ggc80V
	+bm5JUDfZYRoHogBykT2s77lE1TKwAAv9YpJDL4wmF+5GAA04j6qOx9VcQNayhCQL/uLbdawsZm
	sTINNnZjHBGfVz29jhZxjXaNByVBKtZGwryAGYdRhiBjC+GV9GBFHoQBkloxLikyk7EAGT//euf
	/PrtVZuXIa/qdQyeWY+sKmzu/Zo+s2gn7Vh6uBx7Z8EFD9AtyNB/uUV9FC409y55t
X-Google-Smtp-Source: AGHT+IHLpDz+S68J9+XBRbI4ujZ93ejnd9gOfwbEJXAB+wzdDDwiWIwREhFNRdiOiHjmWW9I6p2UXQ==
X-Received: by 2002:a05:6870:ff44:b0:2d6:6677:f311 with SMTP id 586e51a60fabf-2e3c8183d7amr9268778fac.3.1747742497567;
        Tue, 20 May 2025 05:01:37 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:36 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 30/42] selinux: rename cred_has_perm*() to cred_tsid_has_perm*()
Date: Tue, 20 May 2025 07:59:28 -0400
Message-ID: <20250520120000.25501-32-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
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
index 95829ffa7751..40fdcc3c7f4d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -449,13 +449,13 @@ static int may_context_mount_sb_relabel(u32 sid,
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
 
@@ -465,8 +465,8 @@ static int may_context_mount_inode_relabel(u32 sid,
 {
 	int rc;
 
-	rc = cred_has_perm(cred, sbsec->sid, SECCLASS_FILESYSTEM,
-			  FILESYSTEM__RELABELFROM, NULL);
+	rc = cred_tsid_has_perm(cred, sbsec->sid, SECCLASS_FILESYSTEM,
+				FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
@@ -1689,7 +1689,7 @@ static int inode_has_perm(const struct cred *cred,
 
 	isec = selinux_inode(inode);
 
-	return cred_has_perm(cred, isec->sid, isec->sclass, perms, adp);
+	return cred_tsid_has_perm(cred, isec->sid, isec->sclass, perms, adp);
 }
 
 /* Same as inode_has_perm, but pass explicit audit data containing
@@ -1768,8 +1768,8 @@ static int file_has_perm(const struct cred *cred,
 	ad.u.file = file;
 
 	if (sid != fsec->sid) {
-		rc = cred_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
-				   &ad);
+		rc = cred_tsid_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
+					&ad);
 		if (rc)
 			goto out;
 	}
@@ -1836,9 +1836,9 @@ static int may_create(struct inode *dir,
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
 
@@ -1847,7 +1847,7 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	rc = cred_has_perm(cred, newsid, tclass, FILE__CREATE, &ad);
+	rc = cred_tsid_has_perm(cred, newsid, tclass, FILE__CREATE, &ad);
 	if (rc)
 		return rc;
 
@@ -1880,7 +1880,7 @@ static int may_link(struct inode *dir,
 
 	av = DIR__SEARCH;
 	av |= (kind ? DIR__REMOVE_NAME : DIR__ADD_NAME);
-	rc = cred_has_perm(cred, dsec->sid, SECCLASS_DIR, av, &ad);
+	rc = cred_tsid_has_perm(cred, dsec->sid, SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
 
@@ -1900,7 +1900,7 @@ static int may_link(struct inode *dir,
 		return 0;
 	}
 
-	return cred_has_perm(cred, isec->sid, isec->sclass, av, &ad);
+	return cred_tsid_has_perm(cred, isec->sid, isec->sclass, av, &ad);
 }
 
 static inline int may_rename(struct inode *old_dir,
@@ -1923,17 +1923,17 @@ static inline int may_rename(struct inode *old_dir,
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
@@ -1942,15 +1942,15 @@ static inline int may_rename(struct inode *old_dir,
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
@@ -1967,8 +1967,8 @@ static int superblock_has_perm(const struct cred *cred,
 	struct superblock_security_struct *sbsec;
 
 	sbsec = selinux_superblock(sb);
-	return cred_has_perm(cred, sbsec->sid, SECCLASS_FILESYSTEM, perms,
-			     ad);
+	return cred_tsid_has_perm(cred, sbsec->sid, SECCLASS_FILESYSTEM, perms,
+				  ad);
 }
 
 /* Convert a Linux mode and permission mask to an access vector. */
@@ -2087,8 +2087,8 @@ static int selinux_binder_transfer_file(const struct cred *from,
 	ad.u.path = file->f_path;
 
 	if (sid != fsec->sid) {
-		rc = cred_has_perm(to, fsec->sid, SECCLASS_FD, FD__USE,
-				   &ad);
+		rc = cred_tsid_has_perm(to, fsec->sid, SECCLASS_FD, FD__USE,
+					&ad);
 		if (rc)
 			return rc;
 	}
@@ -2103,8 +2103,8 @@ static int selinux_binder_transfer_file(const struct cred *from,
 		return 0;
 
 	isec = backing_inode_security(dentry);
-	return cred_has_perm(to, isec->sid, isec->sclass, file_to_av(file),
-			     &ad);
+	return cred_tsid_has_perm(to, isec->sid, isec->sclass, file_to_av(file),
+				  &ad);
 }
 
 static int selinux_ptrace_access_check(struct task_struct *child,
@@ -2205,20 +2205,20 @@ static int selinux_syslog(int type)
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
@@ -2452,8 +2452,8 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
@@ -3064,8 +3064,8 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 	ad.type = LSM_AUDIT_DATA_ANONINODE;
 	ad.u.anonclass = name ? (const char *)name->name : "?";
 
-	return cred_has_perm(current_cred(), isec->sid, isec->sclass,
-			     FILE__CREATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, isec->sclass,
+				  FILE__CREATE, &ad);
 }
 
 static int selinux_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
@@ -3128,8 +3128,8 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	return cred_has_perm(current_cred(), isec->sid, isec->sclass,
-			     FILE__READ, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, isec->sclass,
+				  FILE__READ, &ad);
 }
 
 static noinline int audit_inode_permission(struct inode *inode,
@@ -3273,8 +3273,8 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 		struct av_decision avd;
 
 		/* Cache miss. */
-		rc = cred_has_perm_noaudit(current_cred(), isec->sid,
-					   isec->sclass, perms, &avd);
+		rc = cred_tsid_has_perm_noaudit(current_cred(), isec->sid,
+						isec->sclass, perms, &avd);
 		audited = avc_audit_required(perms, &avd, rc,
 			(requested & MAY_ACCESS) ? FILE__AUDIT_ACCESS : 0,
 			&denied);
@@ -3384,8 +3384,8 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	ad.u.dentry = dentry;
 
 	isec = backing_inode_security(dentry);
-	rc = cred_has_perm(cred, isec->sid, isec->sclass, FILE__RELABELFROM,
-			   &ad);
+	rc = cred_tsid_has_perm(cred, isec->sid, isec->sclass, FILE__RELABELFROM,
+				&ad);
 	if (rc)
 		return rc;
 
@@ -3424,8 +3424,8 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	if (rc)
 		return rc;
 
-	rc = cred_has_perm(cred, newsid, isec->sclass, FILE__RELABELTO,
-			   &ad);
+	rc = cred_tsid_has_perm(cred, newsid, isec->sclass, FILE__RELABELTO,
+				&ad);
 	if (rc)
 		return rc;
 
@@ -3854,8 +3854,8 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	ad.u.op->path = file->f_path;
 
 	if (ssid != fsec->sid) {
-		rc = cred_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
-				   &ad);
+		rc = cred_tsid_has_perm(cred, fsec->sid, SECCLASS_FD, FD__USE,
+					&ad);
 		if (rc)
 			goto out;
 	}
@@ -4240,8 +4240,8 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 	struct task_security_struct *tsec = selinux_cred(new);
 	int ret;
 
-	ret = cred_has_perm(current_cred(), secid, SECCLASS_KERNEL_SERVICE,
-			    KERNEL_SERVICE__USE_AS_OVERRIDE, NULL);
+	ret = cred_tsid_has_perm(current_cred(), secid, SECCLASS_KERNEL_SERVICE,
+				 KERNEL_SERVICE__USE_AS_OVERRIDE, NULL);
 	if (ret == 0) {
 		tsec->sid = secid;
 		tsec->create_sid = 0;
@@ -4261,10 +4261,10 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
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
@@ -4278,8 +4278,8 @@ static int selinux_kernel_module_request(char *kmod_name)
 	ad.type = LSM_AUDIT_DATA_KMOD;
 	ad.u.kmod_name = kmod_name;
 
-	return cred_has_perm(current_cred(), SECINITSID_KERNEL,
-			     SECCLASS_SYSTEM, SYSTEM__MODULE_REQUEST, &ad);
+	return cred_tsid_has_perm(current_cred(), SECINITSID_KERNEL,
+				  SECCLASS_SYSTEM, SYSTEM__MODULE_REQUEST, &ad);
 }
 
 static int selinux_kernel_load_from_file(struct file *file, u32 requested)
@@ -4301,14 +4301,15 @@ static int selinux_kernel_load_from_file(struct file *file, u32 requested)
 
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
@@ -4859,8 +4860,8 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 
 	ad_net_init_from_sk(&ad, &net, sk);
 
-	return cred_has_perm(current_cred(), sksec->sid, sksec->sclass,
-			     perms, &ad);
+	return cred_tsid_has_perm(current_cred(), sksec->sid, sksec->sclass,
+				  perms, &ad);
 }
 
 static int selinux_socket_create(int family, int type,
@@ -4879,8 +4880,8 @@ static int selinux_socket_create(int family, int type,
 	if (rc)
 		return rc;
 
-	return cred_has_perm(current_cred(), newsid, secclass,
-			     SOCKET__CREATE, NULL);
+	return cred_tsid_has_perm(current_cred(), newsid, secclass,
+				  SOCKET__CREATE, NULL);
 }
 
 static int selinux_socket_post_create(struct socket *sock, int family,
@@ -5838,8 +5839,8 @@ static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 
 static int selinux_secmark_relabel_packet(u32 sid)
 {
-	return cred_has_perm(current_cred(), sid, SECCLASS_PACKET,
-			    PACKET__RELABELTO, NULL);
+	return cred_tsid_has_perm(current_cred(), sid, SECCLASS_PACKET,
+				  PACKET__RELABELTO, NULL);
 }
 
 static void selinux_secmark_refcount_inc(void)
@@ -5883,9 +5884,9 @@ static int selinux_tun_dev_attach_queue(void *security)
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
@@ -5912,8 +5913,8 @@ static int selinux_tun_dev_open(void *security)
 	struct tun_security_struct *tunsec = selinux_tun_dev(security);
 	int err;
 
-	err = cred_has_perm(cred, tunsec->sid, SECCLASS_TUN_SOCKET,
-			    TUN_SOCKET__RELABELFROM, NULL);
+	err = cred_tsid_has_perm(cred, tunsec->sid, SECCLASS_TUN_SOCKET,
+				 TUN_SOCKET__RELABELFROM, NULL);
 	if (err)
 		return err;
 	err = cred_self_has_perm(cred, SECCLASS_TUN_SOCKET,
@@ -6303,8 +6304,8 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = ipc_perms->key;
 
-	return cred_has_perm(current_cred(), isec->sid, isec->sclass, perms,
-			     &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, isec->sclass, perms,
+				  &ad);
 }
 
 static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
@@ -6329,8 +6330,8 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
-			     MSGQ__CREATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
+				  MSGQ__CREATE, &ad);
 }
 
 static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
@@ -6343,8 +6344,8 @@ static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
-			    MSGQ__ASSOCIATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_MSGQ,
+				  MSGQ__ASSOCIATE, &ad);
 }
 
 static int selinux_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
@@ -6355,8 +6356,8 @@ static int selinux_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
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
@@ -6405,11 +6406,11 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
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
@@ -6456,8 +6457,8 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
-			     SHM__CREATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
+				  SHM__CREATE, &ad);
 }
 
 static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
@@ -6470,8 +6471,8 @@ static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
-			     SHM__ASSOCIATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_SHM,
+				  SHM__ASSOCIATE, &ad);
 }
 
 /* Note, at this point, shp is locked down */
@@ -6483,9 +6484,9 @@ static int selinux_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
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
@@ -6533,8 +6534,8 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
-			     SEM__CREATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
+				  SEM__CREATE, &ad);
 }
 
 static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
@@ -6547,8 +6548,8 @@ static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
 
-	return cred_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
-			     SEM__ASSOCIATE, &ad);
+	return cred_tsid_has_perm(current_cred(), isec->sid, SECCLASS_SEM,
+				  SEM__ASSOCIATE, &ad);
 }
 
 /* Note, at this point, sma is locked down */
@@ -6561,9 +6562,9 @@ static int selinux_sem_semctl(struct kern_ipc_perm *sma, int cmd)
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
@@ -6792,8 +6793,8 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
@@ -7052,7 +7053,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	key = key_ref_to_ptr(key_ref);
 	ksec = selinux_key(key);
 
-	return cred_has_perm(cred, ksec->sid, SECCLASS_KEY, perm, NULL);
+	return cred_tsid_has_perm(cred, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
@@ -7075,8 +7076,8 @@ static int selinux_watch_key(struct key *key)
 {
 	struct key_security_struct *ksec = selinux_key(key);
 
-	return cred_has_perm(current_cred(), ksec->sid, SECCLASS_KEY,
-			     KEY__VIEW, NULL);
+	return cred_tsid_has_perm(current_cred(), ksec->sid, SECCLASS_KEY,
+				  KEY__VIEW, NULL);
 }
 #endif
 #endif
@@ -7191,15 +7192,15 @@ static int bpf_fd_pass(const struct file *file, const struct cred *cred)
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
@@ -7211,8 +7212,8 @@ static int selinux_bpf_map(struct bpf_map *map, fmode_t fmode)
 	struct bpf_security_struct *bpfsec;
 
 	bpfsec = map->security;
-	return cred_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
-			     bpf_map_fmode_to_av(fmode), NULL);
+	return cred_tsid_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
+				  bpf_map_fmode_to_av(fmode), NULL);
 }
 
 static int selinux_bpf_prog(struct bpf_prog *prog)
@@ -7220,8 +7221,8 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
 	struct bpf_security_struct *bpfsec;
 
 	bpfsec = prog->aux->security;
-	return cred_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
-			    BPF__PROG_RUN, NULL);
+	return cred_tsid_has_perm(current_cred(), bpfsec->sid, SECCLASS_BPF,
+				  BPF__PROG_RUN, NULL);
 }
 
 static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
@@ -7345,16 +7346,16 @@ static int selinux_perf_event_read(struct perf_event *event)
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
 
@@ -7402,8 +7403,8 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
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

