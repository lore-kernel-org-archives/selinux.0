Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2E306D34;
	Thu, 14 Aug 2025 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178050; cv=none; b=LMRlRs9mCHjTmEnZqa2dQ9lobX7Ki4Dfin091vhPPn58iLr3n7wkJf3FCow6baPW6idtjBw9WKUpOT7hrRidSFxN6wf5V3K7XfopL3oxFVHOWJxe/iIziWda13QCveZYpSNnjvAZG4/5aNXWhwxDR59g3+/MSQQ7MYgRLqP1srk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178050; c=relaxed/simple;
	bh=9JBdcYOTozexTzS2r6b7zWh94BGzoaHlO2OLbLm4Vt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CubfEN6qlysQ3QWA/kU4irrgm+pLNzNzoQ+d+py1cyYPUc9p7i7yM/yFICW05WWNGAX5kYfg4/H1ZgEKpkD8YT15dUMdS1oC3mxC7FZ0nj08Go6kKDYAggKdPGViVR5pa/IKe+27Ck+Wmm6WIW4f1cGWs3/3oVra3hUOTdKV+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9PK25jP; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9PK25jP"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e8704c52b3so99764985a.1;
        Thu, 14 Aug 2025 06:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178047; x=1755782847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zVy12Ke6U46I0IHcanPJfbpZG2LuG4XIDfyoxEOt2o=;
        b=C9PK25jPOAozobTiwd8RUagwMGHYuTQ0ePkfgA0AxGgrWazB+MNGv6M3qBChHbBg4t
         /T8w4drYecmOpWHt73VrvZc6XcaZn/GVnpH05tddwS3+XuhEUOM5dCMpGIPAAjKkA3Z6
         mU19y81u/rHbRh9X62jd61YD2fEboNhfF+6I+OcLhj48zjlKrt9cEf54ZHWbCi8QdxE+
         QR8+13ZVGeZQzluhWgewg5lq2d1eh22fP4p9kVJa9w39KBCx9rMigQi3doj4XPQ4xHd8
         CaSFbaH1fsHAtL6WU1zu55WYvBaZyK/T0LFymG9nh3BEEX0SGjmnV03nqnGBPVxVRSCM
         kO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178047; x=1755782847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zVy12Ke6U46I0IHcanPJfbpZG2LuG4XIDfyoxEOt2o=;
        b=MDfK1OEvxbuXVqGXo+G8pZNVoz6SRh5siffjLI+q2kldaA+8zpvyWrrczXcVF8tzlI
         nOCFuPY/QglUdaRs0rFYLOJTNSR34pL4z0bn7iwPeZklCKjA9jAeU6fJLHnC6T4RfC4v
         Ip9GZpbdfie42dbmRc4SNZ63B31if/U005LHGy7IizRWLiaSIiw+7ak62Q2THDjUCqaV
         i2GJupey6ipib5AYQB87pBv1bx4XbdF8hx9dj8oZub4Qsws8fb9smRKVdceRbTwUZNN5
         r/cgjeovpvXFwcuzYZdsSEbuL5tp+mJnBJzoEDp9DgdrCAWd3Ghq/qJTSB0ut4HOnUMi
         C0qg==
X-Forwarded-Encrypted: i=1; AJvYcCUWLr85zD+uOde5F/fCx17FAd8t5BoKEzpYc758vrIEoTlVh0MRFjBsTLfIsQ7fER/6HPC1xCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6VMLQNLHoVwtt83MY9MFkuuUYzDGApPUlP7/Eq2q3wklTmTCc
	D0FXRAPYLGB9bDTpa76qR+2RCPlWdbW7fJLAd40TFVAj64fGye1Cafjwv8Nh9g==
X-Gm-Gg: ASbGnct4IUlltjFqir4uAlWRuADzIazk0P512No5drMZ31yk0M8aZMfsxv16v/0JRtG
	SbiU8MO3JNXynqzWBxHaAjm7aQlmIzohfojVfkvq5WOuo2hg0V3lBx/jOPh0TOd0EMS2uCb8Cxp
	J6/JuiwSxZYw/lKMMGz3Rspo15qZBeI2zYWaBFlgYA8h0UiGmFz314YtdLn8GPZx8a4M7tekAqK
	18m2ka1GlSU6WczeGlTOqywWUW0Ld9zVfzgGC6eTh5Tx+5c1LhWp17g4BF5oXOzBCmhrueHVsYa
	T14+KfJ3eBS7ieNjzAC4jEc5SUY5keaX37AUsVfuM6c40TIJbKVhhZ0l1aArC3PxFYTNMNalcf2
	0sy4/LZ+T6qLrIK/P6kTqZmR+cJwzBMlTaS/kQwJwOG+rsbBbvHQnuSluOwLLAkWLO40HpWfiN8
	GdtFzC8uBrOVK0yxuapnVmlBltig==
X-Google-Smtp-Source: AGHT+IFIMc3RsqE+KfNXaNgezBF2R1jhZn88ejh2GFlm6Rz1/sOUrnH1ct6wYB8gZF6K1fvIFSnGhg==
X-Received: by 2002:a05:620a:7084:b0:7e8:3a80:f5f8 with SMTP id af79cd13be357-7e8705b590fmr436744885a.45.1755178047466;
        Thu, 14 Aug 2025 06:27:27 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:26 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 24/42] selinux: introduce cred_self_has_perm()
Date: Thu, 14 Aug 2025 09:26:15 -0400
Message-ID: <20250814132637.1659-25-stephen.smalley.work@gmail.com>
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
index 03760f7e7cac..510bbbaf4a70 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1316,6 +1316,53 @@ int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
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
index f22acce323b8..ce2bfa56be6f 100644
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
 
@@ -3999,7 +3994,6 @@ static int default_noexec __ro_after_init;
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
 {
 	const struct cred *cred = current_cred();
-	u32 sid = cred_sid(cred);
 	int rc = 0;
 
 	if (default_noexec &&
@@ -4010,9 +4004,8 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
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
@@ -4040,10 +4033,8 @@ static int selinux_mmap_addr(unsigned long addr)
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
@@ -4074,7 +4065,6 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 				 unsigned long prot)
 {
 	const struct cred *cred = current_cred();
-	u32 sid = cred_sid(cred);
 
 	if (default_noexec &&
 	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
@@ -4090,14 +4080,12 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
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
@@ -4232,10 +4220,8 @@ static int selinux_file_open(struct file *file)
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
@@ -4357,9 +4343,8 @@ static int selinux_kernel_load_from_file(struct file *file, u32 requested)
 	int rc;
 
 	if (file == NULL)
-		return avc_has_perm(current_selinux_state,
-				    sid, sid, SECCLASS_SYSTEM, requested,
-				    NULL);
+		return cred_self_has_perm(current_cred(), SECCLASS_SYSTEM,
+					  requested, NULL);
 
 	/* finit_module */
 	ad.type = LSM_AUDIT_DATA_FILE;
@@ -4580,10 +4565,8 @@ static void selinux_task_to_inode(struct task_struct *p,
 
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
@@ -6767,29 +6750,24 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
@@ -7456,10 +7434,8 @@ static int selinux_uring_override_creds(const struct cred *new)
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
@@ -7491,10 +7467,8 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
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
index adbbecc681f2..3fce5cf92b0a 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -158,6 +158,12 @@ int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
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
2.50.1

