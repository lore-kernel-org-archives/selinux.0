Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AB529994D
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314627; cv=none; b=DG1KLBnhg8Fo/BUgl9EgzM0115VNqcTXIshyuXejazR7ThHVE8TCNhBMAywBwZP3LyB/YjJyQO8D1zCAVr5zWufuV03SRWLeOTmtcKRz0+3Fgl8IvjFv9+LMQU5vePfam+EJBjQOF1T7O5Q5gzhVK5dtOnE4H8uBFyDgtpj7DcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314627; c=relaxed/simple;
	bh=p8scst/FuMtw0vGP3VohyZzhXOxExZVc47JpLSBNEzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPKAO57jtrvLR8fKkdrVE2sgb3QYHe4AX2c+lkZ40x9SZin0hofR6J7LCm3yrP0B0cDbjREKO0ujnvLd1sgk+0UTmd0DIUtu0Y7sg4FVQd102jBguoz148RYZxb5p2tl5eSS0KBuEU4gqJ9vZltYf2/4VMD+jG6OFA95TYRXhqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfUj+4xu; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfUj+4xu"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47ae894e9b7so17887401cf.3
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314624; x=1747919424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/gaxo6QsNv4trHNzmlRqzufaFyu8JB8DlqsCESOLLo=;
        b=PfUj+4xuI4P5ott7c6vG7eZTo2qcUSBlRhzQW5Yf5RaSiEZvSIKSLadkwem5myerS/
         URArBrK3y3Vj6ifRa1Ys4FeK6mIP7yP8KfhFYoKq1rmC/WK3ljkh63d9x7J48rRo9vUD
         EgHjHKCFaFTqPPbMFmNCnRVk4EMciRnTa+xo4xc+IXNwZ/vNojb4MjsIWqAW4VQZ3/KK
         rg3qOsEMQ/OfCBERU8/mLfHwN/UT8aMJ0sfHsPw1S9s6955MH361ZUVf04M9JtimRvjl
         jkbAgN04RHcOb/yIR/oZQdWbYP1UgpRpzQ83NyuLoOTcCg7488k9v65d6sz1J1enJk5g
         CH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314624; x=1747919424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/gaxo6QsNv4trHNzmlRqzufaFyu8JB8DlqsCESOLLo=;
        b=DvVStbifx/cNj4S+NWTyNq8BdaNYDudeHgCeC9UKksogm7dCPgnDB5hnLoOw5Q33QU
         P+TLZ9HzZOEGHjR86si1ixeZb43c5GIrS3U8xWXv2Lq3XLr2Xa84e3biCt3Epjv5424f
         WGp2G1ict9Wpci1vh3sTEODWU/9uShN/w5oj+FUo0vL9upO2WRaXZRIeZYpV7HAwxuzb
         BjZdyBEc5XLROPEGypPPkLQ1tm1VbxrpjPahM3EVvOLnpeOrYcMt67zSyUIJ3E/vf6HR
         r1SHsmGHssOu0PcL6JidOTp+FMAZIwLfhDTDntPZ+SWT7KyqFvHU0nZHNfeXX58g6SqL
         VhUA==
X-Gm-Message-State: AOJu0Yw/egAKG5EeYoI5glAGPrVeBcqITL6Gpmwb6Kw4bw/+5dtu5S9K
	DDVJDyLzb2b0biVHa0WH92xb7lWwV8hIfD+Tnj6TsEIvp8ujNyGvikI5oQ==
X-Gm-Gg: ASbGncsCp05hoW5th4NiFqk7CcTmIO8N+H0qqzZORJLycmqFMjiMk9YwjzSrK5PHmvH
	DPmye/EuAZ1VytH9AUEs0m+zqlEPlFi0tJhR8hUcgJgMg+S+jRciU0Nx25Ho2Au2Y4R3c2fC8pz
	4EKbjyd005s1qzUEDv0n/2Q8EDFwDyWWZmKjJSatpxeOAt4nWrI7iO5WPJaTyYiXP7I1QdLTxXF
	vYBLJ+lvnXRb2527+zcWyDJjXI4KkDlldhL3k8IchsCXB2ZpInyIEiSYdOLGeEpuaYRC6pRmNj3
	foc0I7LqeLcXpU/rORy3D6y2IKsVQBuRmY1M0ofV0EibmZGyYL1PEmfbBFC6JMTvwsRr4Fa2rEZ
	DMLxYw12vLW2ebJLSRhrFNqSXq2Hy6NWc2F6vW93hxTjynyPJQIQ6nQ==
X-Google-Smtp-Source: AGHT+IHu1xnMaqFdzsELo8Z1tkHDpTaqH4uGKwciTLKguMUOpVHzqw/WlzENA07kUBp7OoYJeziDMw==
X-Received: by 2002:ac8:43d2:0:b0:494:7aac:58f0 with SMTP id d75a77b69052e-494a338f8f2mr29119051cf.36.1747314624107;
        Thu, 15 May 2025 06:10:24 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:23 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 07/49] selinux: introduce cred_selinux_state() and use it
Date: Thu, 15 May 2025 09:09:05 -0400
Message-ID: <20250515130947.52806-8-stephen.smalley.work@gmail.com>
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
index b6c619ba5635..55642e983469 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -465,13 +465,13 @@ static int may_context_mount_sb_relabel(u32 sid,
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
@@ -483,13 +483,13 @@ static int may_context_mount_inode_relabel(u32 sid,
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
@@ -1686,10 +1686,10 @@ static int cred_has_capability(const struct cred *cred,
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
@@ -1714,7 +1714,7 @@ static int inode_has_perm(const struct cred *cred,
 	sid = cred_sid(cred);
 	isec = selinux_inode(inode);
 
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(cred),
 			    sid, isec->sid, isec->sclass, perms, adp);
 }
 
@@ -1794,7 +1794,7 @@ static int file_has_perm(const struct cred *cred,
 	ad.u.file = file;
 
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(current_selinux_state,
+		rc = avc_has_perm(cred_selinux_state(cred),
 				  sid, fsec->sid,
 				  SECCLASS_FD,
 				  FD__USE,
@@ -2009,7 +2009,7 @@ static int superblock_has_perm(const struct cred *cred,
 	u32 sid = cred_sid(cred);
 
 	sbsec = selinux_superblock(sb);
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(cred),
 			    sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
 }
 
@@ -2191,7 +2191,7 @@ static int selinux_capset(struct cred *new, const struct cred *old,
 			  const kernel_cap_t *inheritable,
 			  const kernel_cap_t *permitted)
 {
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(old),
 			    cred_sid(old), cred_sid(new), SECCLASS_PROCESS,
 			    PROCESS__SETCAP, NULL);
 }
@@ -3877,7 +3877,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	ad.u.op->path = file->f_path;
 
 	if (ssid != fsec->sid) {
-		rc = avc_has_perm(current_selinux_state,
+		rc = avc_has_perm(cred_selinux_state(cred),
 				  ssid, fsec->sid,
 				SECCLASS_FD,
 				FD__USE,
@@ -3988,7 +3988,7 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 		 * private file mapping that will also be writable.
 		 * This has an additional check.
 		 */
-		rc = avc_has_perm(current_selinux_state,
+		rc = avc_has_perm(cred_selinux_state(cred),
 				  sid, sid, SECCLASS_PROCESS,
 				  PROCESS__EXECMEM, NULL);
 		if (rc)
@@ -4068,14 +4068,14 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
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
@@ -4278,7 +4278,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(current_selinux_state,
+	ret = avc_has_perm(tsec->state,
 			   sid, secid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__USE_AS_OVERRIDE,
@@ -4303,7 +4303,7 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(current_selinux_state,
+	ret = avc_has_perm(tsec->state,
 			   sid, isec->sid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__CREATE_FILES_AS,
@@ -4495,7 +4495,7 @@ static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcre
 		av |= PROCESS__SETRLIMIT;
 	if (flags & LSM_PRLIMIT_READ)
 		av |= PROCESS__GETRLIMIT;
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(cred),
 			    cred_sid(cred), cred_sid(tcred),
 			    SECCLASS_PROCESS, av, NULL);
 }
@@ -7116,7 +7116,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	key = key_ref_to_ptr(key_ref);
 	ksec = selinux_key(key);
 
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(cred),
 			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index e628b66a1ed0..4b61b4c90006 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -178,6 +178,8 @@ static inline u32 current_sid(void)
 
 #define current_selinux_state (selinux_cred(current_cred())->state)
 
+#define cred_selinux_state(cred) (selinux_cred(cred)->state)
+
 static inline bool selinux_initialized(const struct selinux_state *state)
 {
 	/* do a synchronized load to avoid race conditions */
-- 
2.49.0

