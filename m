Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78209245033;
	Tue, 10 Jun 2025 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576191; cv=none; b=V3hO9KTULPGXz9oAabPUY38hjkLK4/kEhZ2HU713nFGXSUIaTIDUTqCcvL+kKpuzbjbdMGlj8h8eQkko1Hj8B75sdw4h/SZ3PvJyvBuEOyhj+GDGnGpd8g8FVARiQdwf2Io+ttUBYDyDE2gQJpfI2ESrKergdHPIhEhp+6MHSkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576191; c=relaxed/simple;
	bh=bIs8hAUQ07K1gA5Zp1GnnMN6BdLQCtLZvvrYg+oChKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uyk60lXiKIeJFh7WLBd9Hhn48HpBaEc9SVnybMCNlCX7yD5Mt9mX2b1AVyzX7FCSFpcMsOa4/GxgenvG74MSqi144h3mmLuwhvv8ANQ/zf3NReh2B/a9Ewu4m+9zmyD8dbrlYtBBpT3RpWOoroGao4IjDzNvfSREIw3+14kmE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5uoPRd0; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5uoPRd0"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d09ab17244so540316085a.0;
        Tue, 10 Jun 2025 10:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576188; x=1750180988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWD8C1KHX7bVx9UYblTDPHMQgdE706Pqtbuyeps723I=;
        b=l5uoPRd05kSEj8OObjrjeC2ptFC/Va8WkBdLVMp+LvvG9X6dm3QesS17zmXUhDAEAw
         9uUyWWsLUm2qVzxte+gZrc9oUHyK+slW4pXsGAYa3qdcdN+1PTMX2yCKzTlPPXAz7ggZ
         0iIYfdJyaSiGl16+SGvPA8vIlIHG1mDHEys98F7cfau0XX3PeuSsr3yxhb7NGCqZjFIm
         ex1W7VAr0BslnmPGY3dH46tz6u7n9RSRYkn42l/+LG2jijpLyvVsHx4gC3CYJvI4++8K
         wk/z5fRrouF6nSOqPVI+nEwP4DmTp5HlZyPlY+ZSm3vhyENc+M/vlFqofFKMo5spT0Ry
         +yMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576188; x=1750180988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWD8C1KHX7bVx9UYblTDPHMQgdE706Pqtbuyeps723I=;
        b=Guu2PKTWmE6Qh+MV/s2u6SeMJhCDa+HybMS9LgTEQ5TRhQ9SS6nSTnkgU3cNxiCOgp
         /tSN0OyFW7xgRqKwa7LlSx6BMRlMgYKnQJIquO4IfrENWeCKYk0qVHSTdrkek/++sF9D
         u0wWO/mTSpr7keodYAAlu2wo7on+U+BQWF0ahjJqQkOnqzinreaeZYOAF8eKlFqn3JkU
         oCesqxxWRE1c1+GFPo7HmfTBEwb1d9CaQ4tAqQXaQNboUXtmuuc7qSMe0gd/ghnk+Tzc
         Qgb1TKkRoFupOeKvU3eh7XvVKlQDvivt48JeFGqYkTYowtFalROX9NZLMZ9tSiadLd7A
         h4Pw==
X-Forwarded-Encrypted: i=1; AJvYcCX0thORtQVsEQlvNWnjM1J0kK0EiU/X8UTrlupsLDxu1ujWsrCX/aC+//4qEt5lhrX4N0xP/iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVHACS5iuxTOhUvMG3MEnFnEAstgrWD7ymsPQqv91s6GzInWkp
	HtpUBYHo959tQOWTJf6N9wU/i/1KTZ3QKLkvCeh2GoBBlAeZEwYNAuOtrmeuqQ==
X-Gm-Gg: ASbGnctc91M3ssKb+QC90lvJaWkeJylsHuuxpAGfB0hvJ9/Z0b8Ecw46rGPRoUINdqY
	l2HcprN1nVOciPX/N9RHpp6kZlMJCojxdwfz6ac2OYXpknsv1CpXEezxcqhS1YpG2Jsg9lojX7l
	e2HEJaxuVoipVU8mhr/zXS+9Lgt+5zw3NYPRIPqR+MrTnILXT/VwQtd0jGFHikk7ke3yqxOqVin
	B69wLlWqulQK+lSaw27fZ9eq9/zx+FgFhqtyyGsT4a4H6wbWxgPSeUfNGOqcsXJ05Z+55wFAKAf
	KWxdAQ7Fu180MtMDZjpxX9pfz3AdvHrz/TTvnpXjSaG7ex/oiFyo/hFl80gCxTmkIvnA7PifjKc
	s/bHaQP5yDBJratbhpjzCSGDrqQxLRfDYuO/1U2Bjc08ATlwXYwF6G8hS0KUOpo3YMw==
X-Google-Smtp-Source: AGHT+IGmWk/PQP1t8tIi82zOS8p2VsbCgoEbhXEQcVNLbcpTwXGu1NHJSafBwCpVZhGaCW8dzPCAzQ==
X-Received: by 2002:a05:620a:27cc:b0:7c5:55f9:4bc1 with SMTP id af79cd13be357-7d3a88fb06cmr27798085a.42.1749576188070;
        Tue, 10 Jun 2025 10:23:08 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:07 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 08/42] selinux: introduce cred_selinux_state() and use it
Date: Tue, 10 Jun 2025 13:21:39 -0400
Message-ID: <20250610172226.1470741-9-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
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
index 5bb51274faaf..f4209dbb4efc 100644
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
@@ -3874,7 +3874,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	ad.u.op->path = file->f_path;
 
 	if (ssid != fsec->sid) {
-		rc = avc_has_perm(current_selinux_state,
+		rc = avc_has_perm(cred_selinux_state(cred),
 				  ssid, fsec->sid,
 				SECCLASS_FD,
 				FD__USE,
@@ -3985,7 +3985,7 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 		 * private file mapping that will also be writable.
 		 * This has an additional check.
 		 */
-		rc = avc_has_perm(current_selinux_state,
+		rc = avc_has_perm(cred_selinux_state(cred),
 				  sid, sid, SECCLASS_PROCESS,
 				  PROCESS__EXECMEM, NULL);
 		if (rc)
@@ -4065,14 +4065,14 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
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
@@ -4275,7 +4275,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(current_selinux_state,
+	ret = avc_has_perm(tsec->state,
 			   sid, secid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__USE_AS_OVERRIDE,
@@ -4300,7 +4300,7 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(current_selinux_state,
+	ret = avc_has_perm(tsec->state,
 			   sid, isec->sid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__CREATE_FILES_AS,
@@ -4492,7 +4492,7 @@ static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcre
 		av |= PROCESS__SETRLIMIT;
 	if (flags & LSM_PRLIMIT_READ)
 		av |= PROCESS__GETRLIMIT;
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(cred),
 			    cred_sid(cred), cred_sid(tcred),
 			    SECCLASS_PROCESS, av, NULL);
 }
@@ -7077,7 +7077,7 @@ static int selinux_key_permission(key_ref_t key_ref,
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

