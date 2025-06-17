Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07E12E06EF;
	Tue, 17 Jun 2025 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169176; cv=none; b=I9yk5+eKv0pQpyqmvFfPy/lNPdK7NZo/DuNS1JdFNh8pkrMRfVeV1+9gW1drqT5BhTMoAor+7KkYzeu/54AlWfINeYd8+/0g0VBUyErY4aeaDDj3ndf+jLfteCYAfut4Y2Vd+jiVciVffpIGsb+DVHnKB4zbj1n+/TGPHdgsqKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169176; c=relaxed/simple;
	bh=gHtaTWT2C+OG9xCE17RSnfJSzNoWdN1IBUK211MsHpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1g0jmeq4Z6mbsMp0t84JVBjUuE8fv/ZxVe3tEuDUZRcatqFb7OdTlm5A0NaRxFqHS1y8FZ7B/+n4akA04rpaXi8ipD6/XwZ1ekLcrUPLJNmAkL34A8dlvp9gXPReay/CT+8mkArVmchL5IvBX3NnqxIF4DoF5BT3LavuG+4WK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leRe3OZg; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leRe3OZg"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d21f21baf7so567626485a.0;
        Tue, 17 Jun 2025 07:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169173; x=1750773973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Obyi/XhIjMyEn/54sLhZpl5Z7szXiWrf1jLF1Bju500=;
        b=leRe3OZg5xFFd6mbE2ub22LI8xog2nJnHF+aOAo2tEq2UC0LvyRqL75o7j0BV5AD68
         2UmCvMDOj4+fPGx4XmvPYsQrbd8fJBLvOpyKZdic7QPSP63e9Hkr1NXxQ/T6GRAkVOfB
         tGNtvwQFIBRVbSR7t42AAyhgFG3tO8va6XwoOCi1wJBmpQZz2GOmPMYotcNKfQTtN9ME
         1sHM+8c79BOhr7Yltfj7xA+6vkVpgjf+2b4XmVAIqqJo8nTDFbRB1ETo211F2IOKOobG
         9PlDlaQKoC9yAgWo4ClLvagJqOfzLkLtinEYDFhlGW32FnzcW9OT8nCnc7gkEs853Lp1
         6Tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169173; x=1750773973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Obyi/XhIjMyEn/54sLhZpl5Z7szXiWrf1jLF1Bju500=;
        b=S9/IeMl4tEYucFUIIAoxPm2d2xUXXl3nYt44geo6RivhVi3Vy6TdOSWcR2XoABm51F
         aYtg42rTB5ZWp4Z8c5/OZytA/j91ZcBGIHQwL1d8AiLGSJZ/LWvc0EfQ91euq1Z0OkQq
         IQvS6WQ0AM5K4/Tw75cROuRlykFXZKCPMomScf5/WdmhAo5IJm/tR3G2/aAvMrSZUJNU
         O5SfWdYIhnU5e3Z4lX/Qc/Rn+IsX/Mfa4bA6nQm3a5IsA1NDiuJC/6mJPMBBKh3s6iKy
         rlhEPmz0kDfP1hjyTsQEMlrEnTRe4AOLhpKXYciLNULBYaLUR3bjOtYlG2CbkNC3JmjL
         K+rg==
X-Forwarded-Encrypted: i=1; AJvYcCVPXlXTDXxIgArQEvmnR5MG/4bnIlBEOvqKiz8nenDxtwmzmTjEfJDPdBs//hi4smxQhUqjWjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwROVfZVONvW7A+/FZpjSev4Z8rpB3s55mZVBCaly7jy9WfE4DJ
	pLFFh2A41YUBTc3C/m2Z46f5mLvmpIxOeinufUtKdoptl/za09hYhI/3ktddrw==
X-Gm-Gg: ASbGncv4535mpUBSz0TbJNRsmUqKb8wewsyX+AbcJrjBdcb2XVV+bt2wKx9uz+DebVE
	khEAlS9b/psDDCrlzE/KYXoMzNyZdTqNXnhxUrN9OCPSKbXcJUsjtqfeONIh69jT9ruU2PlJQOF
	Zg563XjxMa6y89mR/KI1lqeoy8cYzZtBsAH/bpA+DaWKcxeEMaR4DiQYHssrjlgSOY9I28NKdF1
	A05sg9b+sq7lPL6O6iFiJIVbjtyPhzN+dIvkuUtwqp7ZhjdHSpQobz0TysNGseJtRxjW+YJ3LLC
	yMGuwBttaC9AKdGlJw68eWwZkWa8QV/ThMqOhYNW8hinBKXw/wMovJhrK7Dy+w48Oszhpd2syGC
	4u3VaENcq/A6yZ2yBbGmS+cRkejIGQRBLdvEgWtcZDLR2usdAtQrxv6ojOjNgVb/4WA==
X-Google-Smtp-Source: AGHT+IHMQRH46x3I249MkYffO5aPZpIQ/D4RMJpD/eqs0CEbjk+nnYB8nlchn6bG6Ab5BhJG59CIJA==
X-Received: by 2002:a05:620a:25ca:b0:7d3:a580:c197 with SMTP id af79cd13be357-7d3c6cdc185mr2441603985a.31.1750169173207;
        Tue, 17 Jun 2025 07:06:13 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:12 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 08/42] selinux: introduce cred_selinux_state() and use it
Date: Tue, 17 Jun 2025 10:04:55 -0400
Message-ID: <20250617140531.2036-9-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
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
index 95265434f1d4..22f7e7dc92a9 100644
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
@@ -3874,7 +3874,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	ad.u.op->path = file->f_path;
 
 	if (ssid != fsec->sid) {
-		rc = avc_has_perm(current_selinux_state,
+		rc = avc_has_perm(cred_selinux_state(cred),
 				  ssid, fsec->sid,
 				SECCLASS_FD,
 				FD__USE,
@@ -3985,7 +3985,7 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 		 * private file mapping that will also be writable.
 		 * This has an additional check.
 		 */
-		rc = avc_has_perm(current_selinux_state,
+		rc = avc_has_perm(cred_selinux_state(cred),
 				  sid, sid, SECCLASS_PROCESS,
 				  PROCESS__EXECMEM, NULL);
 		if (rc)
@@ -4065,14 +4065,14 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
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
@@ -4275,7 +4275,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(current_selinux_state,
+	ret = avc_has_perm(tsec->state,
 			   sid, secid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__USE_AS_OVERRIDE,
@@ -4300,7 +4300,7 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(current_selinux_state,
+	ret = avc_has_perm(tsec->state,
 			   sid, isec->sid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__CREATE_FILES_AS,
@@ -4492,7 +4492,7 @@ static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcre
 		av |= PROCESS__SETRLIMIT;
 	if (flags & LSM_PRLIMIT_READ)
 		av |= PROCESS__GETRLIMIT;
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(cred),
 			    cred_sid(cred), cred_sid(tcred),
 			    SECCLASS_PROCESS, av, NULL);
 }
@@ -7077,7 +7077,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	key = key_ref_to_ptr(key_ref);
 	ksec = selinux_key(key);
 
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(cred),
 			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 8d162a32ad9e..d4e1f9e088c1 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -181,6 +181,8 @@ static inline u32 current_sid(void)
 
 #define current_selinux_state (selinux_cred(current_cred())->state)
 
+#define cred_selinux_state(cred) (selinux_cred(cred)->state)
+
 static inline bool selinux_initialized(const struct selinux_state *state)
 {
 	/* do a synchronized load to avoid race conditions */
-- 
2.49.0

