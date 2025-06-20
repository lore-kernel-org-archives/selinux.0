Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D172EB5CD;
	Fri, 20 Jun 2025 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441529; cv=none; b=XT8eCAMJofhhkdCYZeY3F4lJWzllvCcHMAxLF9KDyPXhI4O6TtC4337xaqnKJIdFou9tVFnrQDWnpbgmHQ38mPSTl9mroYW3hojDQVtuTY4/9y/q4YtOnKVkY5FEhsyigGCSJO+kfgkGQ8dA1Bqg1Cie9gi4VEZVYCTgZc4VwO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441529; c=relaxed/simple;
	bh=rGCK3SMKLJIAypyDmv/Byb0Q00I6dKY3/3FAT3IL8RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdXtqGgO8fS2dCTec115q8+gadsR/mHDmHUhLbso9u+MrL60tdS1WIwZqa5sjRMK9OpzVqGsAEYf4QHj+zpWzStudRJ+SKG2erJZLd/JrOb2Bi7DZ7vlmRqzuaVrCJnUBEyHvp3fOkwCW/Q55KGdxOyECW4DbFf6LTzmHI6JYMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irr8OEWs; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irr8OEWs"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fafd3cc8f9so31142666d6.3;
        Fri, 20 Jun 2025 10:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441526; x=1751046326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+R8Ysz/V0iugRQYmfKLPtNM6QVoCcMNRpgV3p0S6enY=;
        b=irr8OEWsRBnmbDZioWI8peyx8TPEqxyj4ulkDnpUKANnd44gG4sNUc/dcg0PsNubnv
         en53+mF9q6ujnAufJYS+4qRsvcFitHux9gZDfNA4AhqVTZ8U3iyDGpDsx2dab2rkckv7
         FclkMc/aYK+mXjLZy+S9q5CIME+qksZrUvHSc/vUXZWUV9qPnhk83bVzvkv+ThZuTZBM
         kCNmC3vXog1S/gtyF93RHz+wu+a3/oFrT4qC7EHH/DYamaJH+QWsH3psoxq8eJktD55K
         lKLhHXVrM1Bz8j3dLHXwuNRzBJct+ivD4gNX4y6cigb1Dx/CoykkmPgRmwHFb0PEgnkf
         Ktmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441526; x=1751046326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+R8Ysz/V0iugRQYmfKLPtNM6QVoCcMNRpgV3p0S6enY=;
        b=ctM18Hi0fwORAazCYnN8mmiovEzJs2KwVfO73ngSsveqTJ4LIJgyQjnUPUXFP1Gbt3
         99RdT6TXKwEBdmTTJB+STiMxhBUaP++uBMpcsa/1uEIqORAdKvHGMh7agF5nORu1qDfb
         0nEi85aLocSz7HvEEuXnOfl17c9xaQinunLqij01mQyk5uKt8kYn59UXIQB1/m4JO4Ie
         CNJX2dC2h4GO2VMwGlOcfL2nzy5dYuzdTp7dCO+0XB+k3HVNWvh0PYVXQXZDWLBJ4gNB
         35amAfIXW1RCvijEh1uqf48nE2k+nwGm2AxQzHJHNY8xA/r/EkFO6Zw+Ha2MNp2SYA7L
         2pqg==
X-Forwarded-Encrypted: i=1; AJvYcCV9shccVGrIkgf4PafNpt4h11FMRfk3hjOtOJcGT3QGbOP+HflruFKmxfk8BuFJeOPmaGNIab4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8Kx7Z1i9qigxbFxH2K0F9c/Odt+sAC/A02lcEruQUs5EeDlh
	5jSuzPhNnwDrEtrGDOH9cC50WPQeq1/NsyZ7j8+6XpMGpCps1CN3BiqlZPjWwg==
X-Gm-Gg: ASbGnctbV1kuOylHvIvIsYLajcBzqEr1q++imk53fKnN2LZfuksKf4XcdsPzXpoegNJ
	BfwdbWtU9twEy+4Ejp8Dd3t7sbcydfsLZPJJUCSI+K3hQmC12M3Pw9pPimagiEtVMGLC0A0vMt8
	gwZgMiBxxcCqSENuWp+UOrPO1H9VOtSAk2rLMwroBEmXHHK7N3ypk5jfLxy+yQU6TOJ8XEWgfUC
	e3os6S/FQ6QIhVFVciHSAbsMI3JNVXEEtUm0FkFiIf/ISHKlCkodUzK1As9D2mmxXCWy0w+2UpY
	8c52cc7YNMihrjqzTJsXVuGskroudvjGRG+FeCt1CdxcNMVWZ8eNxS7eFjUFUrN7du3vzCIo2A6
	o544Xa9z9c98U8mT+6NdLJp47o0r8EEmNaG27gIClA2L2gkDkIU6fuQYwQ8g7Fecy/w==
X-Google-Smtp-Source: AGHT+IE0RVZWCMLeROk3UCJZbvyfKWnwXEcgVmhG9P52pzoeL8DIDCF4dl4xgyiycqUlt9fN9mRpiQ==
X-Received: by 2002:a05:6214:509c:b0:6fa:fb7d:6e4c with SMTP id 6a1803df08f44-6fd0a54d8c8mr65350836d6.25.1750441526284;
        Fri, 20 Jun 2025 10:45:26 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:25 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 08/42] selinux: introduce cred_selinux_state() and use it
Date: Fri, 20 Jun 2025 13:44:20 -0400
Message-ID: <20250620174502.1838-9-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
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
index 53147dd87ce4..7254418e7e5e 100644
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
@@ -3886,7 +3886,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	ad.u.op->path = file->f_path;
 
 	if (ssid != fsec->sid) {
-		rc = avc_has_perm(current_selinux_state,
+		rc = avc_has_perm(cred_selinux_state(cred),
 				  ssid, fsec->sid,
 				SECCLASS_FD,
 				FD__USE,
@@ -3997,7 +3997,7 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 		 * private file mapping that will also be writable.
 		 * This has an additional check.
 		 */
-		rc = avc_has_perm(current_selinux_state,
+		rc = avc_has_perm(cred_selinux_state(cred),
 				  sid, sid, SECCLASS_PROCESS,
 				  PROCESS__EXECMEM, NULL);
 		if (rc)
@@ -4077,14 +4077,14 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
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
@@ -4287,7 +4287,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(current_selinux_state,
+	ret = avc_has_perm(tsec->state,
 			   sid, secid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__USE_AS_OVERRIDE,
@@ -4312,7 +4312,7 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(current_selinux_state,
+	ret = avc_has_perm(tsec->state,
 			   sid, isec->sid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__CREATE_FILES_AS,
@@ -4504,7 +4504,7 @@ static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcre
 		av |= PROCESS__SETRLIMIT;
 	if (flags & LSM_PRLIMIT_READ)
 		av |= PROCESS__GETRLIMIT;
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(cred),
 			    cred_sid(cred), cred_sid(tcred),
 			    SECCLASS_PROCESS, av, NULL);
 }
@@ -7089,7 +7089,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	key = key_ref_to_ptr(key_ref);
 	ksec = selinux_key(key);
 
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(cred),
 			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index b94cc01f181a..5db362488a3f 100644
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
2.49.0

