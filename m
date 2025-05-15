Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5029A336
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314644; cv=none; b=YB8dpY8z9sEV5CfzT9l1SWLNDLjAWyXiLkFqU51MsyLTrNwlXk5UbJ7sk/4vmW9aywIvLk7Fl3uTJW+W2f/ZX0mxdMZqua48zPxJJcL/BG+ZxUJuHColbaOKIkaWHv7CkftMeX8p8L0zBt0mNOeJpzDLlzsa6KuJF3r5BrHv1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314644; c=relaxed/simple;
	bh=dB02jPfXmdyI9zEO/VVcAHaeCUiAWhoOt/MNRBUyfiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqpegGDY0jz1BtMyhjq7kw3O7vMYW32unhU1Ia5BvIFqxXGbQk6QRuDNm8yPrFgqUohiUcuUdnbW/BsAsChUWMhP9HrjXNFzaCKvHOabf3q3J3NN/eB3daTOj763Z8ybuVbQnQo7z/w+/2qgV/0HFfTe87EUaPHD70/qAgYFZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imYzA6o2; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imYzA6o2"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c96759d9dfso135054785a.3
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314641; x=1747919441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7Ui8aPk1KIJVAopFtCRPsb7q+b7pg1WTHkR05bZfGI=;
        b=imYzA6o2ZkZ/W8qx90cuSEJbVDg7otiifQwpdY++crLZmjDYrjg7kXzpmFScRTVurf
         jwDqxPy9w0QQB6Ne1pSxjjLZwYVb09ikcNj255+x1mW5D5TI/R08fz55JHClyfWmw5GI
         oj0/EEJflq/YJKwjhaGH0DGieJlq3zcedoBpg9eo5dprgxDa9Np1DmGMQbL12KIHVcOq
         gnDFWby7XRnqDtkh1U5YlVkmH7+nir6SJo6BVsjt3BN7OZkj8xpJN4HrpPcfEPG0Qg0S
         bo5+q2rDsmvRqu6e4cJtuPX50PYBj8mnh+4hU25GKUo6fFhoHRFFOGpHY8TM6ODHONGD
         BWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314641; x=1747919441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7Ui8aPk1KIJVAopFtCRPsb7q+b7pg1WTHkR05bZfGI=;
        b=lrMU8z6dHtXnhxpR6OMfWQ8OVdVNe6nIwtm+i/y/abGQcG+37jILVg2tEJhF8Q0tTp
         srvVhp2eYbO2WoiSsL1iPw4792KcxZt2iLWpDTHYAD4GCb42ZR+IWm75h5nfI+vg1l5e
         1lpbmUfe9oK7Ms2KKZdgMdGD/+v6Hjrh1rwtX9apvmu2TIPPc5MLGzo/ujCV30hM8bM6
         5BTnfbufc1jS0EtlBvCfk5Z14Im//IAaw6s3z8a/QYGIWqf/asqPFXzDRKYc1Yckv1uk
         K5kGgqyPasVc20UZAZnwersstrh34Oys69Rbdm4wW34Xcw9Kcp1ndkSd5+I9OmvKew/J
         GSVg==
X-Gm-Message-State: AOJu0YyPpa+3K5FmXmNTJSCPv2zJoo89jvMlwIshbE85SiRdDfImR4vY
	YbRPQdXDf1JEHff0aHWFhRUU3bknj9vbiK+Le5p9Jk7LZdJjn9wx5TYliw==
X-Gm-Gg: ASbGncs7NQ/C1IK3XzD21hofooMBLS7RecHOUC0JNyWqSIm8CNqXvw4w01ierWmMYeR
	+1dMHDjNdf/4AyTTkhAUavIG34/B/Rr46/8AubOLBnrf++7CgPgPg9WYy/zjUrbcD1g6XxM0TWq
	9aUmMJAp2EIaDhnaRjoiit+N7Pw4FvPK3aB2yb/ed/Km9Co3WGNZG49xjzhakJ5IJdPDLltwgf/
	xSvu6J7sooQpfwpFGQVthFyaIFSsNhM6qnVrw9c+Ot26igBYsOAb2m3DsuPox1vjHkwtrnYRDLH
	1tD8uEHkfBHdrkOUrWJlUG+/fPPsJzwZx4qEiN0dFVt0m3sSB6pAJp/uy3/a5byxPsOwG6KgBbb
	cEl+1NFAUtXN4faKA1TqlvaKibG9iYbUoT6Tzg9+JLiliyW0KjoCATA==
X-Google-Smtp-Source: AGHT+IHYq9lN+98LSf02F9MaZimH54TYd3Wy4Q5HbujYKw38onNW6Ieks68qRnjGC97yXJrbrmKx9g==
X-Received: by 2002:a05:620a:2909:b0:7c5:994a:7f62 with SMTP id af79cd13be357-7cd3c809a01mr302084885a.41.1747314630645;
        Thu, 15 May 2025 06:10:30 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:30 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 15/49] selinux: introduce cred_self_has_perm()
Date: Thu, 15 May 2025 09:09:13 -0400
Message-ID: <20250515130947.52806-16-stephen.smalley.work@gmail.com>
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

Introduce a cred_self_has_perm() function for checking permissions
between a cred and itself against the current SELinux namespace
and all ancestors. Also provide a cred_self_has_perm_noaudit() variant
for use where auditing is not desired.

Update existing permission checks in the hook functions to use this
new helper.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         | 47 +++++++++++++++++
 security/selinux/hooks.c       | 92 ++++++++++++----------------------
 security/selinux/include/avc.h |  6 +++
 3 files changed, 86 insertions(+), 59 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index cf0161404bf5..d5902f643a41 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1317,6 +1317,53 @@ int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
 	return 0;
 }
 
+int cred_self_has_perm(const struct cred *cred, u16 tclass, u32 requested,
+		       struct common_audit_data *ad)
+{
+	struct task_security_struct *tsec;
+	struct selinux_state *state;
+	u32 ssid;
+	int rc;
+
+	do {
+		tsec = selinux_cred(cred);
+		ssid = tsec->sid;
+		state = tsec->state;
+		rc = avc_has_perm(state, ssid, ssid, tclass, requested, ad);
+		if (rc)
+			return rc;
+
+		cred = tsec->parent_cred;
+	} while (cred);
+
+	return 0;
+}
+
+int cred_self_has_perm_noaudit(const struct cred *cred, u16 tclass,
+			       u32 requested)
+{
+	struct task_security_struct *tsec;
+	struct selinux_state *state;
+	u32 ssid;
+	struct av_decision avd;
+	int rc;
+
+	do {
+		tsec = selinux_cred(cred);
+		ssid = tsec->sid;
+		state = tsec->state;
+
+		rc = avc_has_perm_noaudit(state, ssid, ssid, tclass,
+					  requested, 0, &avd);
+		if (rc)
+			return rc;
+
+		cred = tsec->parent_cred;
+	} while (cred);
+
+	return 0;
+}
+
 u32 avc_policy_seqno(struct selinux_state *state)
 {
 	return state->avc->avc_cache.latest_notif;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index eb3a824321fa..fdb28284266f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1665,9 +1665,7 @@ static int cred_has_capability(const struct cred *cred,
 			       int cap, unsigned int opts, bool initns)
 {
 	struct common_audit_data ad;
-	struct av_decision avd;
 	u16 sclass;
-	u32 sid = cred_sid(cred);
 	u32 av = CAP_TO_MASK(cap);
 	int rc;
 
@@ -1687,14 +1685,11 @@ static int cred_has_capability(const struct cred *cred,
 		return -EINVAL;
 	}
 
-	rc = avc_has_perm_noaudit(cred_selinux_state(cred),
-				  sid, sid, sclass, av, 0, &avd);
-	if (!(opts & CAP_OPT_NOAUDIT)) {
-		int rc2 = avc_audit(cred_selinux_state(cred),
-				    sid, sid, sclass, av, &avd, rc, &ad);
-		if (rc2)
-			return rc2;
-	}
+	if (opts & CAP_OPT_NOAUDIT)
+		rc = cred_self_has_perm_noaudit(cred, sclass, av);
+	else
+		rc = cred_self_has_perm(cred, sclass, av, &ad);
+
 	return rc;
 }
 
@@ -3982,7 +3977,6 @@ static int default_noexec __ro_after_init;
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
 {
 	const struct cred *cred = current_cred();
-	u32 sid = cred_sid(cred);
 	int rc = 0;
 
 	if (default_noexec &&
@@ -3993,9 +3987,8 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 		 * private file mapping that will also be writable.
 		 * This has an additional check.
 		 */
-		rc = avc_has_perm(cred_selinux_state(cred),
-				  sid, sid, SECCLASS_PROCESS,
-				  PROCESS__EXECMEM, NULL);
+		rc = cred_self_has_perm(cred, SECCLASS_PROCESS,
+					PROCESS__EXECMEM, NULL);
 		if (rc)
 			goto error;
 	}
@@ -4023,10 +4016,8 @@ static int selinux_mmap_addr(unsigned long addr)
 	int rc = 0;
 
 	if (addr < CONFIG_LSM_MMAP_MIN_ADDR) {
-		u32 sid = current_sid();
-		rc = avc_has_perm(current_selinux_state,
-				  sid, sid, SECCLASS_MEMPROTECT,
-				  MEMPROTECT__MMAP_ZERO, NULL);
+		rc = cred_self_has_perm(current_cred(), SECCLASS_MEMPROTECT,
+					MEMPROTECT__MMAP_ZERO, NULL);
 	}
 
 	return rc;
@@ -4057,7 +4048,6 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 				 unsigned long prot)
 {
 	const struct cred *cred = current_cred();
-	u32 sid = cred_sid(cred);
 
 	if (default_noexec &&
 	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
@@ -4073,14 +4063,12 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 		 */
 		if (vma->vm_start >= vma->vm_mm->start_brk &&
 		    vma->vm_end <= vma->vm_mm->brk) {
-			rc = avc_has_perm(cred_selinux_state(cred), sid, sid,
-					  SECCLASS_PROCESS, PROCESS__EXECHEAP,
-					  NULL);
+			rc = cred_self_has_perm(cred, SECCLASS_PROCESS,
+						PROCESS__EXECHEAP, NULL);
 		} else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
 			    vma_is_stack_for_current(vma))) {
-			rc = avc_has_perm(cred_selinux_state(cred), sid, sid,
-					  SECCLASS_PROCESS, PROCESS__EXECSTACK,
-					  NULL);
+			rc = cred_self_has_perm(cred, SECCLASS_PROCESS,
+						PROCESS__EXECSTACK, NULL);
 		} else if (vma->vm_file && vma->anon_vma) {
 			/*
 			 * We are making executable a file mapping that has
@@ -4215,10 +4203,8 @@ static int selinux_file_open(struct file *file)
 static int selinux_task_alloc(struct task_struct *task,
 			      unsigned long clone_flags)
 {
-	u32 sid = current_sid();
-
-	return avc_has_perm(current_selinux_state,
-			    sid, sid, SECCLASS_PROCESS, PROCESS__FORK, NULL);
+	return cred_self_has_perm(current_cred(), SECCLASS_PROCESS,
+				  PROCESS__FORK, NULL);
 }
 
 /*
@@ -4340,9 +4326,8 @@ static int selinux_kernel_load_from_file(struct file *file, u32 requested)
 	int rc;
 
 	if (file == NULL)
-		return avc_has_perm(current_selinux_state,
-				    sid, sid, SECCLASS_SYSTEM, requested,
-				    NULL);
+		return cred_self_has_perm(current_cred(), SECCLASS_SYSTEM,
+					  requested, NULL);
 
 	/* finit_module */
 	ad.type = LSM_AUDIT_DATA_FILE;
@@ -4563,10 +4548,8 @@ static void selinux_task_to_inode(struct task_struct *p,
 
 static int selinux_userns_create(const struct cred *cred)
 {
-	u32 sid = current_sid();
-
-	return avc_has_perm(current_selinux_state, sid, sid, SECCLASS_USER_NAMESPACE,
-						USER_NAMESPACE__CREATE, NULL);
+	return cred_self_has_perm(current_cred(), SECCLASS_USER_NAMESPACE,
+				  USER_NAMESPACE__CREATE, NULL);
 }
 
 /* Returns error only if unable to parse addresses */
@@ -6777,29 +6760,24 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 	 */
 	switch (attr) {
 	case LSM_ATTR_EXEC:
-		error = avc_has_perm(current_selinux_state,
-				     mysid, mysid, SECCLASS_PROCESS,
-				     PROCESS__SETEXEC, NULL);
+		error = cred_self_has_perm(current_cred(), SECCLASS_PROCESS,
+					   PROCESS__SETEXEC, NULL);
 		break;
 	case LSM_ATTR_FSCREATE:
-		error = avc_has_perm(current_selinux_state,
-				     mysid, mysid, SECCLASS_PROCESS,
-				     PROCESS__SETFSCREATE, NULL);
+		error = cred_self_has_perm(current_cred(), SECCLASS_PROCESS,
+					   PROCESS__SETFSCREATE, NULL);
 		break;
 	case LSM_ATTR_KEYCREATE:
-		error = avc_has_perm(current_selinux_state,
-				     mysid, mysid, SECCLASS_PROCESS,
-				     PROCESS__SETKEYCREATE, NULL);
+		error = cred_self_has_perm(current_cred(), SECCLASS_PROCESS,
+					   PROCESS__SETKEYCREATE, NULL);
 		break;
 	case LSM_ATTR_SOCKCREATE:
-		error = avc_has_perm(current_selinux_state,
-				     mysid, mysid, SECCLASS_PROCESS,
-				     PROCESS__SETSOCKCREATE, NULL);
+		error = cred_self_has_perm(current_cred(), SECCLASS_PROCESS,
+					   PROCESS__SETSOCKCREATE, NULL);
 		break;
 	case LSM_ATTR_CURRENT:
-		error = avc_has_perm(current_selinux_state,
-				     mysid, mysid, SECCLASS_PROCESS,
-				     PROCESS__SETCURRENT, NULL);
+		error = cred_self_has_perm(current_cred(), SECCLASS_PROCESS,
+					   PROCESS__SETCURRENT, NULL);
 		break;
 	default:
 		error = -EOPNOTSUPP;
@@ -7466,10 +7444,8 @@ static int selinux_uring_override_creds(const struct cred *new)
  */
 static int selinux_uring_sqpoll(void)
 {
-	u32 sid = current_sid();
-
-	return avc_has_perm(current_selinux_state, sid, sid,
-			    SECCLASS_IO_URING, IO_URING__SQPOLL, NULL);
+	return cred_self_has_perm(current_cred(), SECCLASS_IO_URING,
+				  IO_URING__SQPOLL, NULL);
 }
 
 /**
@@ -7501,10 +7477,8 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
  */
 static int selinux_uring_allowed(void)
 {
-	u32 sid = current_sid();
-
-	return avc_has_perm(current_selinux_state, sid, sid,
-			    SECCLASS_IO_URING, IO_URING__ALLOWED, NULL);
+	return cred_self_has_perm(current_cred(), SECCLASS_IO_URING,
+				  IO_URING__ALLOWED, NULL);
 }
 #endif /* CONFIG_IO_URING */
 
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index d00c9ecf5d91..25a4c438001e 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -154,6 +154,12 @@ int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
 			    u32 requested, u8 driver, u8 base_perm, u8 xperm,
 			    struct common_audit_data *ad);
 
+int cred_self_has_perm(const struct cred *cred, u16 tclass, u32 requested,
+		       struct common_audit_data *ad);
+
+int cred_self_has_perm_noaudit(const struct cred *cred, u16 tclass,
+			       u32 requested);
+
 u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
-- 
2.49.0

