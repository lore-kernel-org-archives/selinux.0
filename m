Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B982EA74A;
	Fri, 20 Jun 2025 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441542; cv=none; b=CYlyzI3m0OQzm2hn5a+OFTmYaFyLIyF3n2GS6N+l2vXRgjzZ9zUgpvjK+RWjugjehvzEq5dRnXsC3nhCE4OLgo/Gx8dLQwvWEDXqyla1dA7lqRDGJQK20hafU72xejtYykghbL34bXjdiv59u2mZzeuq6CMay6B68/T2c8Z3QV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441542; c=relaxed/simple;
	bh=uwfOLtJWUPqUYlG5rPIw2UdPqswiFSjgXcOlBFNH7Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUgPnTBKzM7CI90YZlJ2+obMXYZ9Y0eE78YfSr/6MoM/V2tWsPkTKAAED+0KdAk/tkPmzQ1KE+4RI8TLl2fS5NCy7iUk3nq4kkn0g5gCNS90/on0tbxQQOyxjQ7SqXCXtozwUo080eNq79vRgU/Cj0gYrLvJ1KmDWPM2OH7tnb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJJE7BQe; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJJE7BQe"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fadd3ad18eso22559456d6.2;
        Fri, 20 Jun 2025 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441539; x=1751046339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTJgl0Bkyvs6Z/JI7m9rIMNRZ79NAB4ZrY6zwTMPP8w=;
        b=XJJE7BQeewjBWbq9LQj9755uOwpWXI/znsRuDsIqUH7nFF4/zDYMPmxVzczYraNLlo
         s6jmq0zxKDnaNoIED4gKpdujIJY5Jw30UbRe8So2Ov70/FgZA3eM+rAdeLBNcOlWliRp
         l8gl6sbMPQbASqkf0RqmDfiw+ks0W8bxx/CnNCxvOTSOjHdvenh5xeaK0V9mYNy8RNBO
         8xbMI75bhiTlBeFkrIuA5dBvTcULGyGpvi0MQ44FYF95Nyd8ZEpZjF0xfdwsnbDFKhEW
         oamrEUlZK05r7GxspOMaianyF48cOaQdzt5iTdQqssN5uIBvswv5YECllXpZOB2uShsN
         2TUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441539; x=1751046339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTJgl0Bkyvs6Z/JI7m9rIMNRZ79NAB4ZrY6zwTMPP8w=;
        b=K4zhgdzTHyJtM49xBA9QG0IWY5NmIPpWT8uyODI1HWJadyOLR6WBlXArqiG7uR8mG8
         FnmF3MoRLvUH8gh0PFJKB4Yzga0a+Yw1vGaBYZP8m0iEjTCjc+Hlys0l6Rn65l3w3h9U
         Hy2oJIxwgY3VdpWCFil/tWnTzR8nfMYb4NAPg+EKWCC+kc/lw21feG9BBDGtNZdIUQvN
         G1P1wrmIum82OiOgYgSGf3cFuDmLuTW0qZ9bJe4e4+opSWGO0pfmLyMeMXDJi/pPs8Ym
         jkl6gwFFIDFr0aGi/oT9P+X6qtOeo42wT2G7BW87bfXaneiufnrfL5QYnMKwMdR1vO2B
         YsPg==
X-Forwarded-Encrypted: i=1; AJvYcCWOlMDMfCi1zYypOXQOYe+snRFKT0Fh8UproxguP6g6BUbYrCnU3eZINTrQ5lwUVRVefWIDVN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPsUxR2k2nxsTvH6RvlxKzsdnUf9qbpnkdz/idTY6ZS/66Vv/x
	je0v7p7Oji40XkPGq4CMWgrYWPHTyunR4gbbfir96sXCQqMycizx5D9yRutjZQ==
X-Gm-Gg: ASbGncu0mtbKoo8iDoa6LXUNniME9aeV3c2tUrnC8aTnvNVh8wspRX/W/jYxQrWAdG1
	aCBVNNZIOdNCNb2FbpckcAlnE2SEBCT8gaRxyEiNUgi1BEYkvbeAizlRqIGuUUuG4dWPJqSw82B
	SMYln6otZ2mZupRlhNLrnLflMRcvIriLP82f0eXjzsDvOf4/7gHdLAJ4/p8IvQaY/+YGzQ3tWjD
	t1m+XKJY8re2PZVpTg89+qxLSdt+Tpa2iRaykz+nNNbsQjwrTgjWASKEcnDg90fddVzmY1BCJEo
	Ld+DDUybyykGTfK6GA0CABfCLD70qZj/LNM3KVeIatuigEY5I4QliO+6tVgCS13IJeHmNTSlHVE
	/J2Inns9eHjrGUHRp8Dj+LJ5ic23meOXL0BjKrhAYuYFc/937Wxo9pH2vjPeqAJoZFA==
X-Google-Smtp-Source: AGHT+IE+//yuohlORRRQqNtgub9DYUApGcK4mUfBC9nkAoagmm8z4/8kIkH/EdVXTt6vT0/R4/Jxpw==
X-Received: by 2002:a05:6214:311a:b0:6fa:8c15:75c1 with SMTP id 6a1803df08f44-6fd0a43bd02mr68640176d6.2.1750441539155;
        Fri, 20 Jun 2025 10:45:39 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:38 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 24/42] selinux: introduce cred_self_has_perm()
Date: Fri, 20 Jun 2025 13:44:36 -0400
Message-ID: <20250620174502.1838-25-stephen.smalley.work@gmail.com>
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
index 6ad3d1ed07f0..1aac31f88725 100644
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
 
@@ -3987,7 +3982,6 @@ static int default_noexec __ro_after_init;
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
 {
 	const struct cred *cred = current_cred();
-	u32 sid = cred_sid(cred);
 	int rc = 0;
 
 	if (default_noexec &&
@@ -3998,9 +3992,8 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
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
@@ -4028,10 +4021,8 @@ static int selinux_mmap_addr(unsigned long addr)
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
@@ -4062,7 +4053,6 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 				 unsigned long prot)
 {
 	const struct cred *cred = current_cred();
-	u32 sid = cred_sid(cred);
 
 	if (default_noexec &&
 	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
@@ -4078,14 +4068,12 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
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
@@ -4220,10 +4208,8 @@ static int selinux_file_open(struct file *file)
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
@@ -4345,9 +4331,8 @@ static int selinux_kernel_load_from_file(struct file *file, u32 requested)
 	int rc;
 
 	if (file == NULL)
-		return avc_has_perm(current_selinux_state,
-				    sid, sid, SECCLASS_SYSTEM, requested,
-				    NULL);
+		return cred_self_has_perm(current_cred(), SECCLASS_SYSTEM,
+					  requested, NULL);
 
 	/* finit_module */
 	ad.type = LSM_AUDIT_DATA_FILE;
@@ -4568,10 +4553,8 @@ static void selinux_task_to_inode(struct task_struct *p,
 
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
@@ -6755,29 +6738,24 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
@@ -7444,10 +7422,8 @@ static int selinux_uring_override_creds(const struct cred *new)
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
@@ -7479,10 +7455,8 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
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
2.49.0

