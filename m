Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89C915381A
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836349; cv=none; b=rXqSSvNlm7DzaG1zLXXgpaoKEQ0k3/hNKOj2kH2oRQnYJLp/92/tHWc2SAUVWWM0Ty/eTJ4BLm1DdHg5z/fV4DbbrxDMT6rjU+H4lVsWGh/YGc6EfRfThrxIfZGNHaYN2Sthjnw3GtV8DLnBsHfeVc7iDYfrlMLFmUBH5h5iibM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836349; c=relaxed/simple;
	bh=RIebBJ3L69k0MVF9/NuKfiY3De+d/RjwSlQCWHMkv9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q91C43MQK+BNC6hyNUfu+6NGS9MHKYq8kG3Rf72Lp3yhkf6EfUrZMfVjWyZd1Jr7UqA1/vaCDdrjrW5c04BZdn9X5gKsm6Ud9HMqrntvaoNlxDfnDnqA6Ww7tBaqTpMd5dYbr4n/vIAPEgi4a+59ClzqIqBg2kFr9eikhd17zs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bud/F1F3; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bud/F1F3"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467918c360aso133676481cf.0
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836344; x=1736441144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2NHjynO+/XFHmOt+lWq5CCom9u6lL1TgIztn1inUPM=;
        b=Bud/F1F3Yw8VnkRTLH18NhRpmEEmmee2Xe3l7p+cnFI+vlXUhP2epoHqJeyptz6TNj
         1Fx9MGq/R8a9lXwfHokhWld+ikuewrCLDunK1TRV1biViiiRKsc8B1cdslbZHNuWZ1e0
         +6x6F1wKLXOgqZ3IJYES/piLZrglTHVXQccFD824oqmUpYwQu7skZtKg0yBiyd0jlD41
         LXMZ8h8pKbycFe/t898Z7CIyQKVaJCfGqorqhyNZdfm4xpHjjWKsRABcLfDSI/jHqgJq
         AtyZyRyc8CK1qjhWbroSVokc3wgrxmn05wngnFSdg02CG/vMOGYmpIRdGSwkk2gEquzX
         y6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836344; x=1736441144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2NHjynO+/XFHmOt+lWq5CCom9u6lL1TgIztn1inUPM=;
        b=rdWfWGQqABu3dy8eHb70eL7NAMLNqmvb8DkLUcKPNurOEAjjLNiYgnZlzUfkrd+b6K
         wu+lrtd+XhmZRS53H5+QFE/0C/gEd+GYREnuiBwuC697D3Qkb4YFf9pcUqPHz+UT04BC
         FUvS9TckwdnB9G2VmtzSacYl+TSbYSMi7jFxEyXNzswIX4X7qsvIQpXJkLjFmb/BxHWk
         q/mW2Ng0nx/kW8MyPQ1GjvR8DzrlQ1uFL/eRlToxvGCv8FWlFGIp3lu94el5jlyXmxY/
         m7rBQGYNvoZM7mPzK6F71nz7cv3bpfxp+E6nxVZ6xnX56fE2yaO0yydtlzm91wJHU6E7
         fiFg==
X-Gm-Message-State: AOJu0Yy0clWL6FFEErlMPj1iBkX1tbwNV1Bi2teBJHNGOlPxkzWdZzvS
	mT1tka99usEOTIGmAjsVcRw13bTzT9jwELa0p6dSQECkxEKFyUfsZbL9xg==
X-Gm-Gg: ASbGncs/ZXz1iyWF1OSUWtWsPLw0K3FcI7CGeZC7ErrfZARju24iEfJ6cdMm/F6/8v8
	x8tbJ2LICTJV5CN7g0YTuQvqxrcoiuP7boikXyi9pVSOb8LqAqkpobiT7PunvEqTbQgEFF/eswU
	WetYiDQFRAM5AoYM1ibuoTvXzmdJ5Sw63FJrD4KnWY1cIgaPcF8V/he45O3kQF62UmyUS+n5M1L
	yC7P7eyVGqdMvjzBvJ+7enuGAaUXe5YuGOALx9rexJB/qzIbqqoTvlXJq90l8tbbiihi62niEQE
	y92oCpNDPj26Wk1q52pzXh0hy4ebof8WkqwxQr4LDo+/ZHZeA7OU3ejLwsvGpTF29sypiw==
X-Google-Smtp-Source: AGHT+IEide/e11nkG8mgLyVa6kd+e9OoRRh18yZUZzjQe7QdS8YSR4Ix6rjrI2xYfuF93TYShha4zQ==
X-Received: by 2002:ac8:7e87:0:b0:467:6bd8:accd with SMTP id d75a77b69052e-46a4a8ce467mr652738881cf.15.1735836344461;
        Thu, 02 Jan 2025 08:45:44 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:44 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 15/44] selinux: introduce cred_self_has_perm()
Date: Thu,  2 Jan 2025 11:44:40 -0500
Message-Id: <20250102164509.25606-16-stephen.smalley.work@gmail.com>
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

Introduce a cred_self_has_perm() function for checking permissions
between a cred and itself against the current SELinux namespace
and all ancestors. Also provide a cred_self_has_perm_noaudit() variant
for use where auditing is not desired.

Update existing permission checks in the hook functions to use this
new helper.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         | 47 +++++++++++++++++++
 security/selinux/hooks.c       | 86 ++++++++++++----------------------
 security/selinux/include/avc.h |  6 +++
 3 files changed, 84 insertions(+), 55 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 93a7eaa42cdd..8f6a8992170a 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1302,6 +1302,53 @@ int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
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
index 7608774ac283..f0fb515ca56e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1654,9 +1654,7 @@ static int cred_has_capability(const struct cred *cred,
 			       int cap, unsigned int opts, bool initns)
 {
 	struct common_audit_data ad;
-	struct av_decision avd;
 	u16 sclass;
-	u32 sid = cred_sid(cred);
 	u32 av = CAP_TO_MASK(cap);
 	int rc;
 
@@ -1676,14 +1674,11 @@ static int cred_has_capability(const struct cred *cred,
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
 
@@ -3853,7 +3848,6 @@ static int default_noexec __ro_after_init;
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
 {
 	const struct cred *cred = current_cred();
-	u32 sid = cred_sid(cred);
 	int rc = 0;
 
 	if (default_noexec &&
@@ -3864,9 +3858,8 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
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
@@ -3894,10 +3887,8 @@ static int selinux_mmap_addr(unsigned long addr)
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
@@ -3928,7 +3919,6 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 				 unsigned long prot)
 {
 	const struct cred *cred = current_cred();
-	u32 sid = cred_sid(cred);
 
 	if (default_noexec &&
 	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
@@ -3944,14 +3934,12 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
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
@@ -4086,10 +4074,8 @@ static int selinux_file_open(struct file *file)
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
@@ -4212,9 +4198,8 @@ static int selinux_kernel_module_from_file(struct file *file)
 
 	/* init_module */
 	if (file == NULL)
-		return avc_has_perm(current_selinux_state,
-				    sid, sid, SECCLASS_SYSTEM,
-					SYSTEM__MODULE_LOAD, NULL);
+		return cred_self_has_perm(current_cred(), SECCLASS_SYSTEM,
+					  SYSTEM__MODULE_LOAD, NULL);
 
 	/* finit_module */
 
@@ -4394,10 +4379,8 @@ static void selinux_task_to_inode(struct task_struct *p,
 
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
@@ -6608,29 +6591,24 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
@@ -7277,10 +7255,8 @@ static int selinux_uring_override_creds(const struct cred *new)
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
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 199d83d354fb..dd2db5d7f433 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -152,6 +152,12 @@ int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
 			    u32 requested, u8 driver, u8 xperm,
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
2.47.1

