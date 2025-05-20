Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C439027FB25;
	Tue, 20 May 2025 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742482; cv=none; b=HAEN61g1mhfRMNgIpxpXA+ziCVABbwysHWkgAN4yfncOhjpya2rq2kQv3gK2bNBdwKhJQ3rY/2h3YCUOlAmlzfMuBPj8PI06lcnbmS1ajTSq0RzADOj+PT/xyNVzFRgS3Hgt6Ank7Cvxj4S2obNnb1JTX0r4JaUyYAXER/Xl8F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742482; c=relaxed/simple;
	bh=65+oEqTAohPc0to24abZSE5Vyv6K0295f58ohavLCps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+qS2AlI6Xbjr1LchS5m4J4og9MEXRy0S6cZbLHcuz5KCWz7YC5O1OjNrnVLr2URXx1rNi4MXYRpUeZ9vcacuO79YTGuP5W37ZmZU3COAtdAwi2l2iBWxFWRDkB6faxsZwFLewtAHGA4BofP2gkwDO6+QqGHM1Dh77wNUsY/Y+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhFOsY97; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhFOsY97"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ecf99dd567so64750906d6.0;
        Tue, 20 May 2025 05:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742479; x=1748347279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ebe4IFy46ZpPMlv+gEvE9revbYH5sMZu61vDVTPTqWk=;
        b=RhFOsY977iMfU+IeuaLJfrVzv0Z4itPFhu80iRACdfaDiSOypVdhm1743BRZM8l34d
         uPuJJ6wHmhrBLc/YROr80eycLkTQOgjAGKy6c+Z1+pmZLIfyLLGZjImRFdUgDiP+IWTN
         pDzkByCB8LRlEcTQjAzxJPf5sSV5N+KU0hoDlTcrStnVA+z+89L7MCy28+PrS72s9t0Z
         hcm5whwsx8VR99WxZrs7H5TaYfoIQiSzn8CJOgITlDogUyTD/s1E3MAjn0S7Z5bOUnNi
         TtHS0wiv56HM7XI2A1/KNobc1MqjoxnALi5KdJmV47fNvJ+ikNytd9JvFG5e4iHigOIo
         ZnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742479; x=1748347279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ebe4IFy46ZpPMlv+gEvE9revbYH5sMZu61vDVTPTqWk=;
        b=HPKADnhem2gHT8ho7U0ycjHnFFiBCaYmPbeUOe4Pi5PWaNh5Ssbl7o7HkBuJJhu1TQ
         F2FM6ScQx3fCQjdiI5VD+qMAyf1iwZFrUbdDA6+p3903ZZpmH4lQPpr/gkb0/RF2YsP8
         Ma4upF2HyYP+TdFdYjoViQkgIm1tDeDhJsGqxfBc+VLtIPfVMWBZzM/lvhUI4x0DHKHo
         TJb+yTB9Lj/GiT6CxaAB9MflZ9skE5uSA+Pz3D4eLniMIq68Gi0O1sgZ9M4FWP4mcD25
         aHBZ+yXNDxd3vInLnHzpvhp1xlFrz4IngKnLNh8lEOss7iUumUMWhchfHU+40hdG9UN2
         qoFg==
X-Forwarded-Encrypted: i=1; AJvYcCULyibXPVCayJ2t+ull7c6/5p0AvFjDhQWDDaguu8a2Mi69kkUYaPjSXq4J1Nz2mdbrL+QFa1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYqxKcUd1KZS9ZMsWGwPQbNg0ZFFB4wXw4gJHBkRffQFrGwQtF
	PJkH0C1COZeyGKzdGYa3FBiSxEVsMyGk7R3UUWtoJ3n3nXShRqhmcvGPdcdJ+g==
X-Gm-Gg: ASbGncujE1xa/+8ltZp9i6smF4+eW1D0iKt2EEOzZr4mRBmP6MTEkLyUt4V8m2xh84A
	2xSQIxayA0UbiEz2JQYvDI/hESwrDhyIZCmbNJYaJjTxTGVT/MktmA0iXAARwNZrDzsSlQfDGN6
	KuM86uQ8u3knvppKgV0xyfceXpsniOMb8GPH/oGtuOuxXHjR5sgfHXDrD8FtIy0u3WYelnR+da7
	eklvDNRz6pGeo6bVafQjNofzQYy+DERXAdgxjnMSp4OstNbVXk8iMunudA8UvradVnkE+05FqhK
	6HDhSKtDRiQ00MvNISQnt+1F8XpGa1wepwvMMD0d3pftgrp0VAGFoIrEdbs9v/+E7cijF0ikhjb
	8JMyJcArr7SF664jpCLBSQ6VT/dmBx+lxeszjBg0HrE0waNb6DDSZ/A==
X-Google-Smtp-Source: AGHT+IHXJw54RKblAOXn8cBX8pUMKnfMIofoH1XEFN0cuJ1KAsZH0k9jfh2aGo7WfCHxc8yepAByKw==
X-Received: by 2002:a05:620a:2955:b0:7c7:93c7:f35d with SMTP id af79cd13be357-7cd4673c076mr2286353985a.31.1747742468679;
        Tue, 20 May 2025 05:01:08 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:07 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 08/42] selinux: introduce cred_selinux_state() and use it
Date: Tue, 20 May 2025 07:59:06 -0400
Message-ID: <20250520120000.25501-10-stephen.smalley.work@gmail.com>
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
index ad86e814aacd..884c96758624 100644
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
index d7ce97bb9464..a2c833df53f5 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -180,6 +180,8 @@ static inline u32 current_sid(void)
 
 #define current_selinux_state (selinux_cred(current_cred())->state)
 
+#define cred_selinux_state(cred) (selinux_cred(cred)->state)
+
 static inline bool selinux_initialized(const struct selinux_state *state)
 {
 	/* do a synchronized load to avoid race conditions */
-- 
2.49.0

