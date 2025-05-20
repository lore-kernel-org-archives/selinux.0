Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC482857C0;
	Tue, 20 May 2025 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742493; cv=none; b=mBNr7BGJ425gt+AFhPdIWC/5wpGISMRtVL67JfnMMftOdflpbEw8MGv7tIplAT5mqly05vrV5MZzKdaN8c6HjWI7degdslmTj8glyIGzirrsjQuaKLd+ec5o3YdamNlAQdUXFt/tMMQ+avF6iCSvSr8fF/coTeoFvbZ33E+ebgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742493; c=relaxed/simple;
	bh=Yr1p0j8erwRUZgvg/bjYKgmY1poOKEMBMd4PgOO3pwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feE0Kvhjb6yHbxrDdhuqb+vnoMj7raqRpRW7AM6i+QV3lFuht+LXKy9z7G/CELoc4TjBT3GJOFvQrqGEyCI2MBNbvFCKK0RhZUb6FGI1C1fC/vk/kvC98D3nRqq9s1RWBMDwBxv7dBHejvnu34bH0mp7ai3m3sDq9+WKlIuy3/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jArafwu1; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jArafwu1"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c7913bab2cso552125985a.0;
        Tue, 20 May 2025 05:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742490; x=1748347290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GymVG6MIOcNVRlcDmz0cZdaK2h7pabOaOPY2acttUwI=;
        b=jArafwu1TSLNN6NDN+BJHCYnOHBOe7kVpJOY+lmqD1b3EVWGBSdUgn61PquEVkrYM5
         LPI2oT30KRWVaoDZ6P3ylK+MAzx5o8UPbbwMf7wqKM78/9aSOJ6Ud/lr6hJ4gxJNCPdL
         dxqoWtHqTE1c8vun/dzlGYIfuvvKlMb4neQRcIQCKsVnHpz1tpa0uo87GTVebfFVjP3n
         VC/E7UkgiuEwfYeA+C6M+MP9U2sf+wC9mGsKLeOPxi0LKJ7IcHjxNmZ0vxYNawjEnlJk
         ohSOWnJk0J8Aq/Zly5VQRRutoDCPfoQwj30EE0UxAg4k8M9CTboy8So8tUd/RpdPXAMW
         MmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742490; x=1748347290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GymVG6MIOcNVRlcDmz0cZdaK2h7pabOaOPY2acttUwI=;
        b=u4zZa9dMaQC7KgHyLNYO1k6/ZMJEC09RrUHVe/7r1apaqb4S5J8c3C6gTKqlWqCfKB
         VdfYtg5O3/HDWRjafR9TwuOZtqZm5s1ryqa0ScrkN+EsgfuOL72XlHxEYxRXKlsT9IWr
         m9xe88yeInAYKi9BB28D+AFOjgLF1v6tGupWsaMP+TmXWPGjksNsPm43WiHwAj+0a7Pr
         4B6IPPT90AL/xYUgFY+YP2NCfCM9m6nHdOQa+kFYoi4855Z0zQFXWFqMiSSbQmSgfrhJ
         GUnikMEs5czPPhSPPCyZzBuvorGhV8qfJAgXtqKnVaLZmvDdeiQXUwx/t4Iqqj7I0+KQ
         sD5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUh7cQK4lKCuoCbPcNnRPdXxs/T+58Kh5f/I7bzXKhUblPemZb4eRbfNO6Z93wtgEBeBpWwqNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM6OKmgAsMkdV3zgzXrhsG9GZfdYf8tpnr7Ha7kvtI8rdXQh7k
	6551NgNZl/XO8D5mK0IcXOe5vKtoB+hE+3bZkL4MuM3aKGxYQ1/G4y1/3nYm7w==
X-Gm-Gg: ASbGncvUuW+71iO1jDybQXWLsTxNr1we+j1FK63iDdreSj/h8A7XWcJJQtIilYd0MY2
	TbnNRNrCMUz0DRek9xfqM4QFCjUbL9+YkQXx+N4JT0mkGaiXaR0aVYIkkU6piLtjmqkeUcP+1Oo
	sEtUwasKoERIochw1DKukbaY7dqmtQSPJRXcKs3mzPsJXFdcuyzFuZ1zrl2xv/pSYEBf1IV0g49
	V6G5SVpedS0FYgKhGEDlv0bJYFwJoogM/CwyG80oyYALeopnizN3GAMinDwwZIO2Q7cskpQQBhS
	lyEHFnrHxzYri9j6PA5JmAGwahvy4EHrV9/aqEO+EGDN773ngTOr+e9TM7cQRhiSk0TsHC11j3y
	/ScRbUeyY4UbA8X9gYSRVHLvV4JKDEwsOIt/lOpxqy3Npk7JhRYqaGw==
X-Google-Smtp-Source: AGHT+IEbioQZEbrZAn89NsI0bUWAeui45R9pcZE5OkLUQkN1pQwclY+6cGxVdahPlkQz3335Xuh8Yw==
X-Received: by 2002:a05:620a:3723:b0:7ce:c4c7:9b81 with SMTP id af79cd13be357-7cec4c7a286mr546387285a.30.1747742489964;
        Tue, 20 May 2025 05:01:29 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:28 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 23/42] selinux: introduce cred_self_has_perm()
Date: Tue, 20 May 2025 07:59:21 -0400
Message-ID: <20250520120000.25501-25-stephen.smalley.work@gmail.com>
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
index 7c7366a9b6a9..1e6a936e5df5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1652,9 +1652,7 @@ static int cred_has_capability(const struct cred *cred,
 			       int cap, unsigned int opts, bool initns)
 {
 	struct common_audit_data ad;
-	struct av_decision avd;
 	u16 sclass;
-	u32 sid = cred_sid(cred);
 	u32 av = CAP_TO_MASK(cap);
 	int rc;
 
@@ -1674,14 +1672,11 @@ static int cred_has_capability(const struct cred *cred,
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
 
@@ -3969,7 +3964,6 @@ static int default_noexec __ro_after_init;
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
 {
 	const struct cred *cred = current_cred();
-	u32 sid = cred_sid(cred);
 	int rc = 0;
 
 	if (default_noexec &&
@@ -3980,9 +3974,8 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
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
@@ -4010,10 +4003,8 @@ static int selinux_mmap_addr(unsigned long addr)
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
@@ -4044,7 +4035,6 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 				 unsigned long prot)
 {
 	const struct cred *cred = current_cred();
-	u32 sid = cred_sid(cred);
 
 	if (default_noexec &&
 	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
@@ -4060,14 +4050,12 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
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
@@ -4202,10 +4190,8 @@ static int selinux_file_open(struct file *file)
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
@@ -4327,9 +4313,8 @@ static int selinux_kernel_load_from_file(struct file *file, u32 requested)
 	int rc;
 
 	if (file == NULL)
-		return avc_has_perm(current_selinux_state,
-				    sid, sid, SECCLASS_SYSTEM, requested,
-				    NULL);
+		return cred_self_has_perm(current_cred(), SECCLASS_SYSTEM,
+					  requested, NULL);
 
 	/* finit_module */
 	ad.type = LSM_AUDIT_DATA_FILE;
@@ -4550,10 +4535,8 @@ static void selinux_task_to_inode(struct task_struct *p,
 
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
@@ -6773,29 +6756,24 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
@@ -7462,10 +7440,8 @@ static int selinux_uring_override_creds(const struct cred *new)
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
@@ -7497,10 +7473,8 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
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

