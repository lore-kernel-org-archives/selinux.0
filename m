Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269BF2EBDE9;
	Tue, 17 Jun 2025 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169196; cv=none; b=XhFFdHAARIMv42g2G6uXSItguhJJupdHOyV11VON8UGF/z09gRhQO9WkVj87x7ymrsMp+6ODN/4mYBJ8Dal9IJtbMVaZwyMZihULKZiI/j6LfKZt8S7OcF+MGSkAC9ssIdH+VgT5yzj7F3NNU5qsLaFIQZcpGX67BqYzYBqzpNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169196; c=relaxed/simple;
	bh=0JL6q/rxWpVyeWYdWczgRlzg1NNQse9LeUxgjqCTAWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EC6LYg2MATbAUPh4n33eZP6esB0kvdtuPu+JR0UO7Mo49pIWnWMTkGNI1gJ5syrmsQUPDY5Idu38x7fED69SnMSU9VRchQSjwv2aIJDLHXO0R3mjRbzM41a00SISANz3vhROqn3Rreu18VU3P8KocPOcda2D1mPu/kQcaEetMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdGvr5dS; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdGvr5dS"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d219896edeso640541485a.1;
        Tue, 17 Jun 2025 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169194; x=1750773994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQXFLBceoO7ILS5BUWND2RWrVSn5U9Kk3bxYZP8CcRg=;
        b=ZdGvr5dSa6HTWKHNXpxBfAnnAYuV+es5dZEPxqp0U3wzmd617nrvHnedQeS6fImwNB
         yFEvguuEYaQTBh6s5HNVy28lP+/8sLuVGUkMiIn22jukBb8OS2mzsgvPHr4mOEtsdZwd
         0hmF4UNczx+kJTP0Pv/zCevc++s346sKqhNlo3QGTU3LAr5OX6UNXtdYgMjvjll8o3mB
         Pv+3cXUtey4SO1f0EXVnLE2TUegO95TWido8kH7sHEet9YRL5IiRqU9hafhB1Ny5kZKl
         OIfDN46abWmlGSWh4wszA9wL3iYVFMEetgC77vYanGtq4bKECbO4YoJmfDgT+KMq2kQ4
         KGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169194; x=1750773994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQXFLBceoO7ILS5BUWND2RWrVSn5U9Kk3bxYZP8CcRg=;
        b=DH5ORqEBKbxpKO1rT5qaY9DP8bwBn9tRcmpwBJOXkGKzrkgiT12jWUIHWL53To2ZtI
         a0uOqt5KiUGgfec9w57sbfY2NpLH8NuqnVpl5EArI2/2YzOM6wS1inEJEe1bztBx87mj
         TJxH/YMIBDsh8zWLxNM7l64Hw+TmahzX3ybwjEIT2MPXZL8B62eLy1Eg/zlkxtLU0BW2
         qjVHFHgAuiGyso9wchYnX8ufsiKBJYGfDOvBFEkMT1u4M0TKwokyT0Soe0J/M81aIaqc
         PWj43tIX2pHp+PnYWMqPfNwMm6eKMgiy/EL2gLC2P/sQabZsx+16dqUouArOWhnA39y5
         f4MA==
X-Forwarded-Encrypted: i=1; AJvYcCXTWrrX9Z/b/BRpEj+lHJarn8AWCT2oBxdI3sTxP4ALvsM558l0d6hL7uxofIoAt2vjkkIn9hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9haWoEfKI7x9DAjI0mwEWdosjRYCg7sDc+U2BUJlq7tluCO1C
	FImGAhSGsXsIcxCSvFoRdObrIZSNke6/fQTC382oAgt7IMDA4WKww7EsTvl+zA==
X-Gm-Gg: ASbGncvuADuAkaYQbGF11pEfdNEwU3OpggE4fFenEcgSIRxcBiAZKU+i4ilt+S1HpUW
	NoA6SNXyYAK/qtsTCt3CJk7zQNO4yJqAW1oORr3x926XcwoWBU2bnxYpeLmsS9Q2VJQCmphi5Xh
	777whZooz6zDKGGg1hWgciH7i+Ry1vrFaN2VuGy1P4LCyLkUhtQzQVI/zVR8uTTVMwqhCuukm9h
	ZRDb5g9kc9h+PThdhS3U/gP1nJv/TzNQRLsclYeBtTb1zpaCf1XzrHGWNJ5jFmdYiOApdR6mMy2
	tmVfF5ZnxkctXUHbLzHe5ZDxiuX5gTwop45ENfCuR3f0jV46VlD5XFwPf02J3GX4YYqCwZcNQ68
	CcxyBN0B7zQRHNWp0AnUE1A4MZUdtyYFXG6wmUr5xcVqfVgt4pCqx26OrvkO7GVN01A==
X-Google-Smtp-Source: AGHT+IEkIVpN6oqfjN0kDewFKbgtpGzK0p74MPvgkWlggftiVijz2EYGu+saILT07+oKvLVINxjeAA==
X-Received: by 2002:a05:620a:25d4:b0:7c5:49b7:237c with SMTP id af79cd13be357-7d3c6cdc704mr1974416385a.27.1750169193825;
        Tue, 17 Jun 2025 07:06:33 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:33 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 24/42] selinux: introduce cred_self_has_perm()
Date: Tue, 17 Jun 2025 10:05:11 -0400
Message-ID: <20250617140531.2036-25-stephen.smalley.work@gmail.com>
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
index 6f5a51268c93..c382e2d04ab6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1658,9 +1658,7 @@ static int cred_has_capability(const struct cred *cred,
 			       int cap, unsigned int opts, bool initns)
 {
 	struct common_audit_data ad;
-	struct av_decision avd;
 	u16 sclass;
-	u32 sid = cred_sid(cred);
 	u32 av = CAP_TO_MASK(cap);
 	int rc;
 
@@ -1680,14 +1678,11 @@ static int cred_has_capability(const struct cred *cred,
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
 
@@ -3975,7 +3970,6 @@ static int default_noexec __ro_after_init;
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
 {
 	const struct cred *cred = current_cred();
-	u32 sid = cred_sid(cred);
 	int rc = 0;
 
 	if (default_noexec &&
@@ -3986,9 +3980,8 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
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
@@ -4016,10 +4009,8 @@ static int selinux_mmap_addr(unsigned long addr)
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
@@ -4050,7 +4041,6 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 				 unsigned long prot)
 {
 	const struct cred *cred = current_cred();
-	u32 sid = cred_sid(cred);
 
 	if (default_noexec &&
 	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
@@ -4066,14 +4056,12 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
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
@@ -4208,10 +4196,8 @@ static int selinux_file_open(struct file *file)
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
@@ -4333,9 +4319,8 @@ static int selinux_kernel_load_from_file(struct file *file, u32 requested)
 	int rc;
 
 	if (file == NULL)
-		return avc_has_perm(current_selinux_state,
-				    sid, sid, SECCLASS_SYSTEM, requested,
-				    NULL);
+		return cred_self_has_perm(current_cred(), SECCLASS_SYSTEM,
+					  requested, NULL);
 
 	/* finit_module */
 	ad.type = LSM_AUDIT_DATA_FILE;
@@ -4556,10 +4541,8 @@ static void selinux_task_to_inode(struct task_struct *p,
 
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
@@ -6743,29 +6726,24 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
@@ -7432,10 +7410,8 @@ static int selinux_uring_override_creds(const struct cred *new)
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
@@ -7467,10 +7443,8 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
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

