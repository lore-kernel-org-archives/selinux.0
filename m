Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87653002DB;
	Thu, 14 Aug 2025 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178034; cv=none; b=Wpih80UF8JYGblEeKQk4phOvfPedvqx9HoonNqsytZiKWZuigty95WrcOUuw92Lw6Rr/ELt9TRladKTfrTw0L8YOxJRo6OiFncfOhAQ8bSvQ2B66NQwgaxx0n6HnIWmAu7lL2kSCmPrODL6vY0qQPQXMC9iAgSSmqlSv6SOt2W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178034; c=relaxed/simple;
	bh=ksUdHk14eo0Hm1htAwdDq9obvyJ+dHlpJFeTRm9nMbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlKFKoma/2c1siKpjI3E2hn7shZ70DSS+dsAZ1pYtECXDu3prCn/oyId3wVQU21h+YJSKulTqiPg5OzG1NU1YlKMhX0hEunWWtsNtTK/A8DlV+xt/MkLViMPyKm8kZvckp3g/V7nKQXHVf7y0X5NNQlUgE9dRQUDrA6/o85uOvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4IrWrFT; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4IrWrFT"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70a9280c7c9so10254446d6.1;
        Thu, 14 Aug 2025 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178031; x=1755782831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35/Mxx9v8XEordl4DLG7PfE7pY76poYdZJD3ff1xWFw=;
        b=Y4IrWrFTPBsWGJKR130P2lQCv+UbQscgBKh98CWLNMThHhgqol4cuhbQCzU5TwBiRQ
         3CBe7pyZ12QtMMtxdhMINI+b4eYvFu3K6n3qmbseotgU172LPm8EJqpxTOx2m2udFPVL
         crziWGm3CGs5/Kz8jh7q7JWe8vDHze4y5LFHLgJEfIi+kmyYtY4Mhos5cdCgzHTTT1L3
         hb+MP9ndFyPAR7RvwmUOtVVL98QUuIy6cGDzxCeebq64W2sA3XQ/xidFLasWrk8LvZZX
         RcahF28gJ8rdtFjLO8K9qXPHE2w3quFM0Q/qitdPVXhVwuCrNfC7Bh3eCdT0rNIkgKQT
         GzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178031; x=1755782831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35/Mxx9v8XEordl4DLG7PfE7pY76poYdZJD3ff1xWFw=;
        b=GFd1MW+129aOfe1gVCvhLh1p+8KQKTTjeb78nZnBnXAuEgiLDhmYgqp2NwgVacJJqi
         F6dFeaa1Zy10aDkGiGKewzfMjAbQSegfdODytxVkaYbAMYPvJa4f9O3yTQ34ieuFqG6V
         6v7RZLQ/ECr/+wYt2oYfs+k/ES73j4QlgMc2GRXkKbwyB2+3s03n3PF4SRgIVxzARhmU
         PJW256i0O82WysD4b3LTNiiU21Y57aJT9LmKQQHOxjZMcWmuu3Rasgodgwl+o2sE53Yc
         da8dqy6vBXPQ+1MrUcRaKHqcpnN9R9O1p/VIrfUn/wEcYuk22XwFHXABJkt8FVPPIuvQ
         TdcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6yupv5Ds6ZUe7ASPyaRBQzkS8BcecgshFdf2X6yLe5L2PPcjou4/qPZ33j6XoLII3j9nQf/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpkXPYDaNZ79HlCq685qNuNyxthMNWwiH4DerKnNjcbOunZSz9
	aR/4RiYSbqTG3WmpUAaF8qtSF++nUoFNlYwvU+pLSu/s01QLQq64z2TcUh+JqA==
X-Gm-Gg: ASbGncuj1An/ZYDc4QvPTUf/MI+h13hpww1+3usjEAr4yndFhkV/lkbaQuWfKKj1/nt
	exCWUnJLu1A9qzRve6RCRMoJ+ZZo8hVUqQ5ZIxxOLxqdINuKHKevW5fm3sWNMGn/JvS/5JOjaX5
	tziQikegEtSJxP9LHdoCDFCYnaiY2cRtaIgcbH8TJ5IdrfhAFptQrH+91eMsU/6EvwbwKfgQ5cb
	Op+7k+CnOp0/NqN7SyN5wVixyzrwTBSFaqa1hkN55dO0bKlC3k7ogWWHO2ycBOctVErtxa9ksaR
	D44TtprbeTKhm5EJogo2cHkgxm1SycGc2wmvao4PWxc//DIgatV4iDcmhxZ7jExZALZIqYb7h4p
	7uHdbpPuYswmZBXXgMAGzG6xcnZPye8NkGQG6XeSmx9T8I+fnzYa86lhznQgDtzF1rC9ChdWjZv
	lMBuATba33+U5Pz2/W6ZTjNMVxvQ==
X-Google-Smtp-Source: AGHT+IE72fjRCsGWOm9LLYSJws3xFgJoTq4wR8LBBkzpry72EFEwRbA/A9epyU8/0lnhM1b9wChKnw==
X-Received: by 2002:a05:6214:2606:b0:707:5ca4:baa5 with SMTP id 6a1803df08f44-70ae6cfab47mr40738846d6.0.1755178031264;
        Thu, 14 Aug 2025 06:27:11 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:10 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 08/42] selinux: introduce cred_selinux_state() and use it
Date: Thu, 14 Aug 2025 09:25:59 -0400
Message-ID: <20250814132637.1659-9-stephen.smalley.work@gmail.com>
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

When using the SID from a cred, we should pass the selinux
namespace associated with the cred on security server calls
rather than the current selinux namespace, since they could differ.
In some of these cases, the cred is always obtained from the current
task so there is no real change, but this is cleaner and hopefully
less fragile. In other cases, the cred could in fact differ.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            | 44 ++++++++++++++---------------
 security/selinux/include/security.h |  2 ++
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6a21c39cfa91..3135378e9229 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -464,13 +464,13 @@ static int may_context_mount_sb_relabel(u32 sid,
 	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
 
-	rc = avc_has_perm(current_selinux_state,
+	rc = avc_has_perm(cred_selinux_state(cred),
 			  tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(current_selinux_state,
+	rc = avc_has_perm(cred_selinux_state(cred),
 			  tsec->sid, sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELTO, NULL);
 	return rc;
@@ -482,13 +482,13 @@ static int may_context_mount_inode_relabel(u32 sid,
 {
 	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
-	rc = avc_has_perm(current_selinux_state,
+	rc = avc_has_perm(cred_selinux_state(cred),
 			  tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(current_selinux_state,
+	rc = avc_has_perm(cred_selinux_state(cred),
 			  sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__ASSOCIATE, NULL);
 	return rc;
@@ -1683,10 +1683,10 @@ static int cred_has_capability(const struct cred *cred,
 		return -EINVAL;
 	}
 
-	rc = avc_has_perm_noaudit(current_selinux_state,
+	rc = avc_has_perm_noaudit(cred_selinux_state(cred),
 				  sid, sid, sclass, av, 0, &avd);
 	if (!(opts & CAP_OPT_NOAUDIT)) {
-		int rc2 = avc_audit(current_selinux_state,
+		int rc2 = avc_audit(cred_selinux_state(cred),
 				    sid, sid, sclass, av, &avd, rc, &ad);
 		if (rc2)
 			return rc2;
@@ -1711,7 +1711,7 @@ static int inode_has_perm(const struct cred *cred,
 	sid = cred_sid(cred);
 	isec = selinux_inode(inode);
 
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(cred),
 			    sid, isec->sid, isec->sclass, perms, adp);
 }
 
@@ -1791,7 +1791,7 @@ static int file_has_perm(const struct cred *cred,
 	ad.u.file = file;
 
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(current_selinux_state,
+		rc = avc_has_perm(cred_selinux_state(cred),
 				  sid, fsec->sid,
 				  SECCLASS_FD,
 				  FD__USE,
@@ -2006,7 +2006,7 @@ static int superblock_has_perm(const struct cred *cred,
 	u32 sid = cred_sid(cred);
 
 	sbsec = selinux_superblock(sb);
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(cred),
 			    sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
 }
 
@@ -2188,7 +2188,7 @@ static int selinux_capset(struct cred *new, const struct cred *old,
 			  const kernel_cap_t *inheritable,
 			  const kernel_cap_t *permitted)
 {
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(old),
 			    cred_sid(old), cred_sid(new), SECCLASS_PROCESS,
 			    PROCESS__SETCAP, NULL);
 }
@@ -3898,7 +3898,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	ad.u.op->path = file->f_path;
 
 	if (ssid != fsec->sid) {
-		rc = avc_has_perm(current_selinux_state,
+		rc = avc_has_perm(cred_selinux_state(cred),
 				  ssid, fsec->sid,
 				SECCLASS_FD,
 				FD__USE,
@@ -4009,7 +4009,7 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 		 * private file mapping that will also be writable.
 		 * This has an additional check.
 		 */
-		rc = avc_has_perm(current_selinux_state,
+		rc = avc_has_perm(cred_selinux_state(cred),
 				  sid, sid, SECCLASS_PROCESS,
 				  PROCESS__EXECMEM, NULL);
 		if (rc)
@@ -4089,14 +4089,14 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 		 */
 		if (vma->vm_start >= vma->vm_mm->start_brk &&
 		    vma->vm_end <= vma->vm_mm->brk) {
-			rc = avc_has_perm(current_selinux_state,
-					  sid, sid, SECCLASS_PROCESS,
-					  PROCESS__EXECHEAP, NULL);
+			rc = avc_has_perm(cred_selinux_state(cred), sid, sid,
+					  SECCLASS_PROCESS, PROCESS__EXECHEAP,
+					  NULL);
 		} else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
 			    vma_is_stack_for_current(vma))) {
-			rc = avc_has_perm(current_selinux_state,
-					  sid, sid, SECCLASS_PROCESS,
-					  PROCESS__EXECSTACK, NULL);
+			rc = avc_has_perm(cred_selinux_state(cred), sid, sid,
+					  SECCLASS_PROCESS, PROCESS__EXECSTACK,
+					  NULL);
 		} else if (vma->vm_file && vma->anon_vma) {
 			/*
 			 * We are making executable a file mapping that has
@@ -4299,7 +4299,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(current_selinux_state,
+	ret = avc_has_perm(tsec->state,
 			   sid, secid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__USE_AS_OVERRIDE,
@@ -4324,7 +4324,7 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(current_selinux_state,
+	ret = avc_has_perm(tsec->state,
 			   sid, isec->sid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__CREATE_FILES_AS,
@@ -4516,7 +4516,7 @@ static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcre
 		av |= PROCESS__SETRLIMIT;
 	if (flags & LSM_PRLIMIT_READ)
 		av |= PROCESS__GETRLIMIT;
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(cred),
 			    cred_sid(cred), cred_sid(tcred),
 			    SECCLASS_PROCESS, av, NULL);
 }
@@ -7101,7 +7101,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	key = key_ref_to_ptr(key_ref);
 	ksec = selinux_key(key);
 
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(cred),
 			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index ae22ef45321e..329b1fe48057 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -183,6 +183,8 @@ static inline u32 current_sid(void)
 
 #define current_selinux_state (selinux_cred(current_cred())->state)
 
+#define cred_selinux_state(cred) (selinux_cred(cred)->state)
+
 static inline bool selinux_initialized(const struct selinux_state *state)
 {
 	/* do a synchronized load to avoid race conditions */
-- 
2.50.1

