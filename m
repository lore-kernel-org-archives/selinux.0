Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AEE12EBE7
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836342; cv=none; b=P99RXHkcKqAPLtTVoKppu5gkErwQ8wslVL/owLhA0Is0GMwH/ovVvKBOhDZMTP89Cd2kK8ogVk+413XJmIyrJ8Kx7AiS/Zs4mhnEpf6xH0uIienHNQEEJOvVTYCKPsbOJ95gl4fQYMNS/Zkwgg3a4pw4lN+2ucA9p+OjcBz+Cw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836342; c=relaxed/simple;
	bh=SIRjXLX/AiPGgT0i/bxGUipBbo3ELVEhnxSBNSeTOzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=urowfAxfzz/NxCKCy0fBB6+iknR8Mw2p+RSZFVcFQTIUD243zQzFtlfORC623Kw6ZiRXCj5NbW0r9Eq548zeLeoiLDpSCheFjae0rJBaPdT1BmCChbIWgWb91aubi+ZRLitoV0jWa41Cg0EfMSfevkOtzSbxei2GCnO9DFjgq+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msWhZ8S3; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msWhZ8S3"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46769b34cbfso171273611cf.0
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836338; x=1736441138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MLJGuOZ6VMPcpfBG7y3RY8a4Gr/qjOpRbiH1q9Ej+I=;
        b=msWhZ8S371ScHsThRohPCk3860+u1bTGTPdi8gDIjmvYA5dToLTZTCM2pm7z8oEI3k
         wUvKA81F75+r+qzx4f3p13oucK3NYkS+aykMgKu9OSsLk+2IYJ+a0FCgPnlPqghXHWJE
         ZUzH02EUcda1TaepSIwN3nEHs5kGDoS+LtfACI6veawvvIqeToDvb4gzlGlIBDT1xP/K
         mpWW1M44BC6MXUWR9NSDQpm+Ta6cPoO+ELuUvsSbeq7wXFEHY//MPGxGyBK7aV5FJx1A
         6baRUeT3f6yXtw+1nr/HRjn4XosVIG3NkXYcGrJeS8ahTZ+HvRToDGItNplvRqqjhgoB
         ipiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836338; x=1736441138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MLJGuOZ6VMPcpfBG7y3RY8a4Gr/qjOpRbiH1q9Ej+I=;
        b=hF4cAqUPPvxXTDArJI2QYCA/ceXS07SeMtOLH2ESGa0R/2/R3Zs+qpPK6McMugrpvC
         DzMHQGOdB8j9a2JSh+Nh0F6xc3Ca6SI8LMNkhulTJH9kt9aUzSV56Hvgx9oGoLxMGM8J
         PCLUylL8dOBptHfUXhDpcyGslr5AqjBcS6WgqVSAoPWZWt8F6IxMVImvMKHBhVzBSn9D
         f9MSMYqjpyYN0FUd8dmII0L/ZWlFce+v1eJAh0Q2R5fDNxatiSU/gapRRG1gkj2KwAdn
         9p8C4y0DTjZai5f5HIP6cXYSqrlQaD34lGJ1p2RQvMAUU21+wK7PT4eS3bfr4ZTMGtgO
         BzQQ==
X-Gm-Message-State: AOJu0YyIH+YBfxFuce2iqCBc5CkKmF6T0DmMf7zmQhgNZL3JJON5Hrvm
	cd4yL6ixC5mmy+LmwnIVDp1Xdhoc5lj7RQsJq1RP3bhApadXJJ+A7dxJSQ==
X-Gm-Gg: ASbGnctaGgUqGUOgvT7rzs05y5TNUrX8WRlvQmP1KPi6kRA6RqppDPeJk/ff2J3dQKL
	aziDxQc5GZGACnagWSsM438Hfb9Yv7x+SD7/gEQKHaY3hx/g41Ipy7Nb6BMo9NIdmMieIfIIZYK
	7g2qbEg/2daqTftELZ4cAaqkWtiOVcCymLvovzNk1YJQmgXslUOqSu0vh5fybwKJxg+fiD2c6zf
	Iq89uJu8IZZl0ZYc/e6n3A9FinlqBnAOYzIsv5puLS2v6CFURwZw9i2sVoFji2VwygdWhbqqCZD
	ff9GszHBFN21uXHJuj+CT1XtnXYxuoV5tPaohWIX/mAJWvE9v307LVQzQR8EqrBunQDhHw==
X-Google-Smtp-Source: AGHT+IECIFxOPaJNFBqz+azW2rITeXiFwpSXys0Uh7+GLARosBQYz4egDHV61b+yKnsYYO/V5pTDOA==
X-Received: by 2002:a05:622a:1a28:b0:46a:3709:6780 with SMTP id d75a77b69052e-46a4a8dcbe6mr789930311cf.19.1735836337764;
        Thu, 02 Jan 2025 08:45:37 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:37 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 07/44] selinux: introduce cred_selinux_state() and use it
Date: Thu,  2 Jan 2025 11:44:32 -0500
Message-Id: <20250102164509.25606-8-stephen.smalley.work@gmail.com>
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
index ddaf1f527fe3..1aa0bb1a83ce 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -454,13 +454,13 @@ static int may_context_mount_sb_relabel(u32 sid,
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
@@ -472,13 +472,13 @@ static int may_context_mount_inode_relabel(u32 sid,
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
@@ -1675,10 +1675,10 @@ static int cred_has_capability(const struct cred *cred,
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
@@ -1703,7 +1703,7 @@ static int inode_has_perm(const struct cred *cred,
 	sid = cred_sid(cred);
 	isec = selinux_inode(inode);
 
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(cred),
 			    sid, isec->sid, isec->sclass, perms, adp);
 }
 
@@ -1777,7 +1777,7 @@ static int file_has_perm(const struct cred *cred,
 	ad.u.file = file;
 
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(current_selinux_state,
+		rc = avc_has_perm(cred_selinux_state(cred),
 				  sid, fsec->sid,
 				  SECCLASS_FD,
 				  FD__USE,
@@ -1992,7 +1992,7 @@ static int superblock_has_perm(const struct cred *cred,
 	u32 sid = cred_sid(cred);
 
 	sbsec = selinux_superblock(sb);
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(cred),
 			    sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
 }
 
@@ -2174,7 +2174,7 @@ static int selinux_capset(struct cred *new, const struct cred *old,
 			  const kernel_cap_t *inheritable,
 			  const kernel_cap_t *permitted)
 {
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(old),
 			    cred_sid(old), cred_sid(new), SECCLASS_PROCESS,
 			    PROCESS__SETCAP, NULL);
 }
@@ -3749,7 +3749,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	ad.u.op->path = file->f_path;
 
 	if (ssid != fsec->sid) {
-		rc = avc_has_perm(current_selinux_state,
+		rc = avc_has_perm(cred_selinux_state(cred),
 				  ssid, fsec->sid,
 				SECCLASS_FD,
 				FD__USE,
@@ -3859,7 +3859,7 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 		 * private file mapping that will also be writable.
 		 * This has an additional check.
 		 */
-		rc = avc_has_perm(current_selinux_state,
+		rc = avc_has_perm(cred_selinux_state(cred),
 				  sid, sid, SECCLASS_PROCESS,
 				  PROCESS__EXECMEM, NULL);
 		if (rc)
@@ -3939,14 +3939,14 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
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
@@ -4149,7 +4149,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(current_selinux_state,
+	ret = avc_has_perm(tsec->state,
 			   sid, secid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__USE_AS_OVERRIDE,
@@ -4174,7 +4174,7 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(current_selinux_state,
+	ret = avc_has_perm(tsec->state,
 			   sid, isec->sid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__CREATE_FILES_AS,
@@ -4326,7 +4326,7 @@ static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcre
 		av |= PROCESS__SETRLIMIT;
 	if (flags & LSM_PRLIMIT_READ)
 		av |= PROCESS__GETRLIMIT;
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(cred),
 			    cred_sid(cred), cred_sid(tcred),
 			    SECCLASS_PROCESS, av, NULL);
 }
@@ -6927,7 +6927,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	key = key_ref_to_ptr(key_ref);
 	ksec = selinux_key(key);
 
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(cred),
 			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index a66f061c7784..8f8531b80bfd 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -164,6 +164,8 @@ static inline u32 current_sid(void)
 
 #define current_selinux_state (selinux_cred(current_cred())->state)
 
+#define cred_selinux_state(cred) (selinux_cred(cred)->state)
+
 static inline bool selinux_initialized(const struct selinux_state *state)
 {
 	/* do a synchronized load to avoid race conditions */
-- 
2.47.1

