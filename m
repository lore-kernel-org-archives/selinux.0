Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F03364E97
	for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763582215; cv=none; b=DdPMlKLvmNoNJ2UDaly02DGN2SVUzLowalKBHKMhf2407rHOETwavWTqzviszvZZExOxLoujhG45WB02IPvXQUs70eSPxBVhIxplVhnqYRV5ahZExf5EONQV671W1o4oSoDWHuhVwTLA0GCHx6uhXFRhihVuDv33Ti8jqA3hAIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763582215; c=relaxed/simple;
	bh=kGuprSca6WSoAHhCV1ze8xzRDXeSM174dM66WPn9idU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEzNHZQ4Tn9mYgZr/WqdYBAH0gH6L1gL7CkVHKwysteWn/GOb5T+VTq49cfvQox9Q810CugYmYYh/kL/ttyfgbnN3xKGUwkBgWoNfi4k6dZuwTNZmfich+T87G6cGiST/5eKp70YYsYN7RmM9JxGjDDKumzpY3z0mUdTHjjmkY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=R3SpYjO+; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R3SpYjO+"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b1bfd4b3deso8416585a.2
        for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 11:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763582210; x=1764187010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2xbRGVFNMPmaJxMzIopmV8MYgKc2JX5tRw+cQ5i5pc=;
        b=R3SpYjO+e1vxx1W2QJte2gRy4ap5vz0+5pTs53FkMyhElVFGXCSfbevDyvsJXMx1YM
         mI1FhSVJT2U+aRGSPYnkAHgpLk7z0uB+cDvp2KM5J7pqi5Pv7vNJ0VAvb36yA1IDmCGJ
         /cVE7Jy8SvZlc4URYwyUMhiaJO9jfvy9TZGQvEKIea9adGkIQmsOUGF4SzG8xGJpJAJO
         p90gyNCQZzWL6L7nlHJtuDDJFGvFqeR8UVfMgjgTcqpD2B/T3e9HTxb+n1d5RW45bTf7
         A0LzmVXfYy3rPpSMQN0KA4tcgYPppP2OtvaIGszWhHVnEfjLS6Tq0bgW4sNX7gqh2SFg
         ds5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763582210; x=1764187010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N2xbRGVFNMPmaJxMzIopmV8MYgKc2JX5tRw+cQ5i5pc=;
        b=CNtG4HJtEM+5jRD2X3m62q6X+pTxSJdL8GhzSLVWh8PoBgTaZJ433XXe5Z0esH0e4S
         gi+s3L4b2XsnCA0RtjqtMf8u6ZUhfqS1k3PBIPGBVsJhc+Q/AE/Y/HlpXG8K2vk/6yUw
         0mkKnmdK0OA1ElkR6WYG4KCDOsFklp9VzZLQdCNoQZugI+B+LhJrBSAPg3/5fR6k4bLI
         muTW6dx/IITDfQFL5pGEffQdvTONFU4VN62zk7w3th0fQu+Zdy8dVMCAASvHLeyJJDcF
         5FoJxMlQtaufE4Ng/UzVV1UkspUTuHWzRBl76iBJbWHXSO2sNB2DNT0nOhlgciNeVlD0
         fj5g==
X-Gm-Message-State: AOJu0Yz8AsVlWUMX5g5wPyGlmTUsu1MaeNSbLiH696HavgRN/kRCi21O
	Wsy/dEFroC2XjwKcCbj1mFz2ki9rQVgZ8B2N3Ylhi+pw++Fgr8UjQBBRxV1nJ769ToKqet9vdHl
	By5A=
X-Gm-Gg: ASbGncuhroQipNOCHKEpImHVcFysJQLC4KvsOGgGRKZVUgqT48cyZ/NoZx0ng1/24Hq
	8NucPUU/XTAaZOqM88VNuYK3nLVwSshkJmIMo2Y4a8UDKhZaT3Eg6tZNmM2xJNhougrxFegzNc2
	weHdaz9hFw9Udv4/f81lopxm5YfOGjGLF8QLlY4jemYkBZ6vSVKrsWsEhjLRk5L4RXKox2qN5Kk
	gYFIGEW2T2Kh9p1ekaO82o4CSe6DfPflx2RalE/iA5vx9sX6evlbG5AmL5BvyDZL5uF5j2g77ta
	P69M6M2BxKpgoGOwpm7CmZZs7gSYK190wGHM0lcvGd63UextSsUs5cMR0qdBddqjxiRVuMl7FcA
	rwHe4IRZRzPPdf/uvwCMNsuprMXtckbhjp0s/OCM5i/tedNWNWrKLdUlNExaRdXqzWbD8zNZ/y4
	4uG815khwYrlO+BfIaiy64CRZ/epMLpVlRJJuPsInxY8Wn46TiK7CLAQMA
X-Google-Smtp-Source: AGHT+IGDDXNMMM6w13EaqTGDRq8AEp8d/jHfCO7gRo+/1eKEby/puoqsZaXX2QGjsObf5GMURYXgZA==
X-Received: by 2002:a05:620a:440a:b0:8b2:4383:b3d7 with SMTP id af79cd13be357-8b32a1b5847mr1379185a.78.1763582209676;
        Wed, 19 Nov 2025 11:56:49 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932da24sm16845685a.6.2025.11.19.11.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:56:48 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 3/3] selinux: rename the cred_security_struct variables to "crsec"
Date: Wed, 19 Nov 2025 14:56:31 -0500
Message-ID: <20251119195628.184825-6-paul@paul-moore.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251119195628.184825-4-paul@paul-moore.com>
References: <20251119195628.184825-4-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=24983; i=paul@paul-moore.com; h=from:subject; bh=kGuprSca6WSoAHhCV1ze8xzRDXeSM174dM66WPn9idU=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBpHiD592B640Bp6IFgI+cX0yFxjYNQecEmxsJgO GvmmqNLGj2JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaR4g+QAKCRDqIPLalzeJ cybeEACAZEGev1sVY4uZQEqWq0WD/87LfT644uCvpEXNVnseVNAgLYCvNJCqRO6/uNYazRIFjua Q/+XSLKIZLvgrb/NV+WHmAh8E3RuhVvu0IMYNvmiXNL3FwphrWGaYjhsVGub22DEsd71cv3iLTA 2aFidKZFsxo+NhzroN+uSikYLK1AjNBFR2wHWRsivdHQ+NaeI7s16TYwKJUJV3rvG9vZxBGIYTu xeJSMmHQ94ITk37slmuhjpuHqE0UGxbFQVMbzKE37OK6Vew7pIyQ2mph5BdnYI9g32yqzEtL+OI S9Xq+y/ztB0Y7DPw4X/Wg5bk5Dg0iA3hghOTN6gHTXBuxp8wj5isJFmmwK1mUn7ck0m3aEurSAA Im/4akiSqtAldkhqYl/C2lyVxqor87zVuiveeuWpMHvHJkS0kWRjtqiLYa0zcw38lreE2OyO2Of g5a7GlVJy0XgnHsouRgRcD1qFlXwKzvZetbw3/1dqn1vZ8fc/37+8ONW/Qpq0+00TB/rE+hX5rS tZymP44mxD2QFbw2Z/CybS3HjhPU4hBYtofO+E1zvheWunpd9xGEiTpx22JZTE5y5rvABrWFqJL yTBtwe/kH4Gy5MXOQSoXGcA1s0YdycbJQQGndL3h6AIBmI2gTH4MCjuIomGViGv7IZFL0KjNWjR qIY/rlB1TXtiiiw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Along with the renaming from task_security_struct to cred_security_struct,
rename the local variables to "crsec" from "tsec".  This both fits with
existing conventions and helps distinguish between task and cred related
variables.

No functional changes.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c          | 230 +++++++++++++++---------------
 security/selinux/include/objsec.h |   4 +-
 2 files changed, 117 insertions(+), 117 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0ac4b05eb56c..e713291db873 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -210,12 +210,12 @@ static int selinux_lsm_notifier_avc_callback(u32 event)
  */
 static void cred_init_security(void)
 {
-	struct cred_security_struct *tsec;
+	struct cred_security_struct *crsec;
 
 	/* NOTE: the lsm framework zeros out the buffer on allocation */
 
-	tsec = selinux_cred(unrcu_pointer(current->real_cred));
-	tsec->osid = tsec->sid = SECINITSID_KERNEL;
+	crsec = selinux_cred(unrcu_pointer(current->real_cred));
+	crsec->osid = crsec->sid = SECINITSID_KERNEL;
 }
 
 /*
@@ -223,10 +223,10 @@ static void cred_init_security(void)
  */
 static inline u32 cred_sid(const struct cred *cred)
 {
-	const struct cred_security_struct *tsec;
+	const struct cred_security_struct *crsec;
 
-	tsec = selinux_cred(cred);
-	return tsec->sid;
+	crsec = selinux_cred(cred);
+	return crsec->sid;
 }
 
 static void __ad_net_init(struct common_audit_data *ad,
@@ -437,15 +437,15 @@ static int may_context_mount_sb_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct cred_security_struct *tsec = selinux_cred(cred);
+	const struct cred_security_struct *crsec = selinux_cred(cred);
 	int rc;
 
-	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
+	rc = avc_has_perm(crsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(tsec->sid, sid, SECCLASS_FILESYSTEM,
+	rc = avc_has_perm(crsec->sid, sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELTO, NULL);
 	return rc;
 }
@@ -454,9 +454,9 @@ static int may_context_mount_inode_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct cred_security_struct *tsec = selinux_cred(cred);
+	const struct cred_security_struct *crsec = selinux_cred(cred);
 	int rc;
-	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
+	rc = avc_has_perm(crsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
@@ -1788,7 +1788,7 @@ static int file_has_perm(const struct cred *cred,
  * Determine the label for an inode that might be unioned.
  */
 static int
-selinux_determine_inode_label(const struct cred_security_struct *tsec,
+selinux_determine_inode_label(const struct cred_security_struct *crsec,
 				 struct inode *dir,
 				 const struct qstr *name, u16 tclass,
 				 u32 *_new_isid)
@@ -1800,11 +1800,11 @@ selinux_determine_inode_label(const struct cred_security_struct *tsec,
 	    (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)) {
 		*_new_isid = sbsec->mntpoint_sid;
 	} else if ((sbsec->flags & SBLABEL_MNT) &&
-		   tsec->create_sid) {
-		*_new_isid = tsec->create_sid;
+		   crsec->create_sid) {
+		*_new_isid = crsec->create_sid;
 	} else {
 		const struct inode_security_struct *dsec = inode_security(dir);
-		return security_transition_sid(tsec->sid,
+		return security_transition_sid(crsec->sid,
 					       dsec->sid, tclass,
 					       name, _new_isid);
 	}
@@ -1817,7 +1817,7 @@ static int may_create(struct inode *dir,
 		      struct dentry *dentry,
 		      u16 tclass)
 {
-	const struct cred_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid;
@@ -1827,7 +1827,7 @@ static int may_create(struct inode *dir,
 	dsec = inode_security(dir);
 	sbsec = selinux_superblock(dir->i_sb);
 
-	sid = tsec->sid;
+	sid = crsec->sid;
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
@@ -1838,7 +1838,7 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	rc = selinux_determine_inode_label(tsec, dir, &dentry->d_name, tclass,
+	rc = selinux_determine_inode_label(crsec, dir, &dentry->d_name, tclass,
 					   &newsid);
 	if (rc)
 		return rc;
@@ -2251,8 +2251,8 @@ static u32 ptrace_parent_sid(void)
 }
 
 static int check_nnp_nosuid(const struct linux_binprm *bprm,
-			    const struct cred_security_struct *old_tsec,
-			    const struct cred_security_struct *new_tsec)
+			    const struct cred_security_struct *old_crsec,
+			    const struct cred_security_struct *new_crsec)
 {
 	int nnp = (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS);
 	int nosuid = !mnt_may_suid(bprm->file->f_path.mnt);
@@ -2262,7 +2262,7 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 	if (!nnp && !nosuid)
 		return 0; /* neither NNP nor nosuid */
 
-	if (new_tsec->sid == old_tsec->sid)
+	if (new_crsec->sid == old_crsec->sid)
 		return 0; /* No change in credentials */
 
 	/*
@@ -2277,7 +2277,7 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 			av |= PROCESS2__NNP_TRANSITION;
 		if (nosuid)
 			av |= PROCESS2__NOSUID_TRANSITION;
-		rc = avc_has_perm(old_tsec->sid, new_tsec->sid,
+		rc = avc_has_perm(old_crsec->sid, new_crsec->sid,
 				  SECCLASS_PROCESS2, av, NULL);
 		if (!rc)
 			return 0;
@@ -2288,8 +2288,8 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 	 * i.e. SIDs that are guaranteed to only be allowed a subset
 	 * of the permissions of the current SID.
 	 */
-	rc = security_bounded_transition(old_tsec->sid,
-					 new_tsec->sid);
+	rc = security_bounded_transition(old_crsec->sid,
+					 new_crsec->sid);
 	if (!rc)
 		return 0;
 
@@ -2305,8 +2305,8 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 
 static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 {
-	const struct cred_security_struct *old_tsec;
-	struct cred_security_struct *new_tsec;
+	const struct cred_security_struct *old_crsec;
+	struct cred_security_struct *new_crsec;
 	struct inode_security_struct *isec;
 	struct common_audit_data ad;
 	struct inode *inode = file_inode(bprm->file);
@@ -2315,18 +2315,18 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	/* SELinux context only depends on initial program or script and not
 	 * the script interpreter */
 
-	old_tsec = selinux_cred(current_cred());
-	new_tsec = selinux_cred(bprm->cred);
+	old_crsec = selinux_cred(current_cred());
+	new_crsec = selinux_cred(bprm->cred);
 	isec = inode_security(inode);
 
 	/* Default to the current task SID. */
-	new_tsec->sid = old_tsec->sid;
-	new_tsec->osid = old_tsec->sid;
+	new_crsec->sid = old_crsec->sid;
+	new_crsec->osid = old_crsec->sid;
 
 	/* Reset fs, key, and sock SIDs on execve. */
-	new_tsec->create_sid = 0;
-	new_tsec->keycreate_sid = 0;
-	new_tsec->sockcreate_sid = 0;
+	new_crsec->create_sid = 0;
+	new_crsec->keycreate_sid = 0;
+	new_crsec->sockcreate_sid = 0;
 
 	/*
 	 * Before policy is loaded, label any task outside kernel space
@@ -2335,26 +2335,26 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	 * (if the policy chooses to set SECINITSID_INIT != SECINITSID_KERNEL).
 	 */
 	if (!selinux_initialized()) {
-		new_tsec->sid = SECINITSID_INIT;
+		new_crsec->sid = SECINITSID_INIT;
 		/* also clear the exec_sid just in case */
-		new_tsec->exec_sid = 0;
+		new_crsec->exec_sid = 0;
 		return 0;
 	}
 
-	if (old_tsec->exec_sid) {
-		new_tsec->sid = old_tsec->exec_sid;
+	if (old_crsec->exec_sid) {
+		new_crsec->sid = old_crsec->exec_sid;
 		/* Reset exec SID on execve. */
-		new_tsec->exec_sid = 0;
+		new_crsec->exec_sid = 0;
 
 		/* Fail on NNP or nosuid if not an allowed transition. */
-		rc = check_nnp_nosuid(bprm, old_tsec, new_tsec);
+		rc = check_nnp_nosuid(bprm, old_crsec, new_crsec);
 		if (rc)
 			return rc;
 	} else {
 		/* Check for a default transition on this program. */
-		rc = security_transition_sid(old_tsec->sid,
+		rc = security_transition_sid(old_crsec->sid,
 					     isec->sid, SECCLASS_PROCESS, NULL,
-					     &new_tsec->sid);
+					     &new_crsec->sid);
 		if (rc)
 			return rc;
 
@@ -2362,34 +2362,34 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 		 * Fallback to old SID on NNP or nosuid if not an allowed
 		 * transition.
 		 */
-		rc = check_nnp_nosuid(bprm, old_tsec, new_tsec);
+		rc = check_nnp_nosuid(bprm, old_crsec, new_crsec);
 		if (rc)
-			new_tsec->sid = old_tsec->sid;
+			new_crsec->sid = old_crsec->sid;
 	}
 
 	ad.type = LSM_AUDIT_DATA_FILE;
 	ad.u.file = bprm->file;
 
-	if (new_tsec->sid == old_tsec->sid) {
-		rc = avc_has_perm(old_tsec->sid, isec->sid,
+	if (new_crsec->sid == old_crsec->sid) {
+		rc = avc_has_perm(old_crsec->sid, isec->sid,
 				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
 		if (rc)
 			return rc;
 	} else {
 		/* Check permissions for the transition. */
-		rc = avc_has_perm(old_tsec->sid, new_tsec->sid,
+		rc = avc_has_perm(old_crsec->sid, new_crsec->sid,
 				  SECCLASS_PROCESS, PROCESS__TRANSITION, &ad);
 		if (rc)
 			return rc;
 
-		rc = avc_has_perm(new_tsec->sid, isec->sid,
+		rc = avc_has_perm(new_crsec->sid, isec->sid,
 				  SECCLASS_FILE, FILE__ENTRYPOINT, &ad);
 		if (rc)
 			return rc;
 
 		/* Check for shared state */
 		if (bprm->unsafe & LSM_UNSAFE_SHARE) {
-			rc = avc_has_perm(old_tsec->sid, new_tsec->sid,
+			rc = avc_has_perm(old_crsec->sid, new_crsec->sid,
 					  SECCLASS_PROCESS, PROCESS__SHARE,
 					  NULL);
 			if (rc)
@@ -2401,7 +2401,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 		if (bprm->unsafe & LSM_UNSAFE_PTRACE) {
 			u32 ptsid = ptrace_parent_sid();
 			if (ptsid != 0) {
-				rc = avc_has_perm(ptsid, new_tsec->sid,
+				rc = avc_has_perm(ptsid, new_crsec->sid,
 						  SECCLASS_PROCESS,
 						  PROCESS__PTRACE, NULL);
 				if (rc)
@@ -2415,7 +2415,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 		/* Enable secure mode for SIDs transitions unless
 		   the noatsecure permission is granted between
 		   the two SIDs, i.e. ahp returns 0. */
-		rc = avc_has_perm(old_tsec->sid, new_tsec->sid,
+		rc = avc_has_perm(old_crsec->sid, new_crsec->sid,
 				  SECCLASS_PROCESS, PROCESS__NOATSECURE,
 				  NULL);
 		bprm->secureexec |= !!rc;
@@ -2483,12 +2483,12 @@ static inline void flush_unauthorized_files(const struct cred *cred,
  */
 static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
 {
-	struct cred_security_struct *new_tsec;
+	struct cred_security_struct *new_crsec;
 	struct rlimit *rlim, *initrlim;
 	int rc, i;
 
-	new_tsec = selinux_cred(bprm->cred);
-	if (new_tsec->sid == new_tsec->osid)
+	new_crsec = selinux_cred(bprm->cred);
+	if (new_crsec->sid == new_crsec->osid)
 		return;
 
 	/* Close files for which the new task SID is not authorized. */
@@ -2507,7 +2507,7 @@ static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
 	 * higher than the default soft limit for cases where the default is
 	 * lower than the hard limit, e.g. RLIMIT_CORE or RLIMIT_STACK.
 	 */
-	rc = avc_has_perm(new_tsec->osid, new_tsec->sid, SECCLASS_PROCESS,
+	rc = avc_has_perm(new_crsec->osid, new_crsec->sid, SECCLASS_PROCESS,
 			  PROCESS__RLIMITINH, NULL);
 	if (rc) {
 		/* protect against do_prlimit() */
@@ -2529,12 +2529,12 @@ static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
  */
 static void selinux_bprm_committed_creds(const struct linux_binprm *bprm)
 {
-	const struct cred_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	u32 osid, sid;
 	int rc;
 
-	osid = tsec->osid;
-	sid = tsec->sid;
+	osid = crsec->osid;
+	sid = crsec->sid;
 
 	if (sid == osid)
 		return;
@@ -2911,7 +2911,7 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
 {
 	u32 newsid;
 	int rc;
-	struct cred_security_struct *tsec;
+	struct cred_security_struct *crsec;
 
 	rc = selinux_determine_inode_label(selinux_cred(old),
 					   d_inode(dentry->d_parent), name,
@@ -2920,8 +2920,8 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
 	if (rc)
 		return rc;
 
-	tsec = selinux_cred(new);
-	tsec->create_sid = newsid;
+	crsec = selinux_cred(new);
+	crsec->create_sid = newsid;
 	return 0;
 }
 
@@ -2929,7 +2929,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const struct qstr *qstr,
 				       struct xattr *xattrs, int *xattr_count)
 {
-	const struct cred_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
 	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	u32 newsid, clen;
@@ -2939,9 +2939,9 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 
 	sbsec = selinux_superblock(dir->i_sb);
 
-	newsid = tsec->create_sid;
+	newsid = crsec->create_sid;
 	newsclass = inode_mode_to_security_class(inode->i_mode);
-	rc = selinux_determine_inode_label(tsec, dir, qstr, newsclass, &newsid);
+	rc = selinux_determine_inode_label(crsec, dir, qstr, newsclass, &newsid);
 	if (rc)
 		return rc;
 
@@ -3660,7 +3660,7 @@ static void selinux_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop)
 static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 {
 	struct lsm_prop prop;
-	struct cred_security_struct *tsec;
+	struct cred_security_struct *crsec;
 	struct cred *new_creds = *new;
 
 	if (new_creds == NULL) {
@@ -3669,10 +3669,10 @@ static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 			return -ENOMEM;
 	}
 
-	tsec = selinux_cred(new_creds);
+	crsec = selinux_cred(new_creds);
 	/* Get label from overlay inode and set it in create_sid */
 	selinux_inode_getlsmprop(d_inode(src), &prop);
-	tsec->create_sid = prop.selinux.secid;
+	crsec->create_sid = prop.selinux.secid;
 	*new = new_creds;
 	return 0;
 }
@@ -3698,7 +3698,7 @@ static int selinux_inode_copy_up_xattr(struct dentry *dentry, const char *name)
 static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 					struct kernfs_node *kn)
 {
-	const struct cred_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	u32 parent_sid, newsid, clen;
 	int rc;
 	char *context;
@@ -3726,8 +3726,8 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 	if (rc)
 		return rc;
 
-	if (tsec->create_sid) {
-		newsid = tsec->create_sid;
+	if (crsec->create_sid) {
+		newsid = crsec->create_sid;
 	} else {
 		u16 secclass = inode_mode_to_security_class(kn->mode);
 		const char *kn_name;
@@ -3738,7 +3738,7 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 		q.name = kn_name;
 		q.hash_len = hashlen_string(kn_dir, kn_name);
 
-		rc = security_transition_sid(tsec->sid,
+		rc = security_transition_sid(crsec->sid,
 					     parent_sid, secclass, &q,
 					     &newsid);
 		if (rc)
@@ -4165,10 +4165,10 @@ static int selinux_task_alloc(struct task_struct *task,
 static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 				gfp_t gfp)
 {
-	const struct cred_security_struct *old_tsec = selinux_cred(old);
-	struct cred_security_struct *tsec = selinux_cred(new);
+	const struct cred_security_struct *old_crsec = selinux_cred(old);
+	struct cred_security_struct *crsec = selinux_cred(new);
 
-	*tsec = *old_tsec;
+	*crsec = *old_crsec;
 	return 0;
 }
 
@@ -4177,10 +4177,10 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 {
-	const struct cred_security_struct *old_tsec = selinux_cred(old);
-	struct cred_security_struct *tsec = selinux_cred(new);
+	const struct cred_security_struct *old_crsec = selinux_cred(old);
+	struct cred_security_struct *crsec = selinux_cred(new);
 
-	*tsec = *old_tsec;
+	*crsec = *old_crsec;
 }
 
 static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
@@ -4199,7 +4199,7 @@ static void selinux_cred_getlsmprop(const struct cred *c, struct lsm_prop *prop)
  */
 static int selinux_kernel_act_as(struct cred *new, u32 secid)
 {
-	struct cred_security_struct *tsec = selinux_cred(new);
+	struct cred_security_struct *crsec = selinux_cred(new);
 	u32 sid = current_sid();
 	int ret;
 
@@ -4208,10 +4208,10 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 			   KERNEL_SERVICE__USE_AS_OVERRIDE,
 			   NULL);
 	if (ret == 0) {
-		tsec->sid = secid;
-		tsec->create_sid = 0;
-		tsec->keycreate_sid = 0;
-		tsec->sockcreate_sid = 0;
+		crsec->sid = secid;
+		crsec->create_sid = 0;
+		crsec->keycreate_sid = 0;
+		crsec->sockcreate_sid = 0;
 	}
 	return ret;
 }
@@ -4223,7 +4223,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
 	struct inode_security_struct *isec = inode_security(inode);
-	struct cred_security_struct *tsec = selinux_cred(new);
+	struct cred_security_struct *crsec = selinux_cred(new);
 	u32 sid = current_sid();
 	int ret;
 
@@ -4233,7 +4233,7 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 			   NULL);
 
 	if (ret == 0)
-		tsec->create_sid = isec->sid;
+		crsec->create_sid = isec->sid;
 	return ret;
 }
 
@@ -4748,15 +4748,15 @@ static int selinux_conn_sid(u32 sk_sid, u32 skb_sid, u32 *conn_sid)
 
 /* socket security operations */
 
-static int socket_sockcreate_sid(const struct cred_security_struct *tsec,
+static int socket_sockcreate_sid(const struct cred_security_struct *crsec,
 				 u16 secclass, u32 *socksid)
 {
-	if (tsec->sockcreate_sid > SECSID_NULL) {
-		*socksid = tsec->sockcreate_sid;
+	if (crsec->sockcreate_sid > SECSID_NULL) {
+		*socksid = crsec->sockcreate_sid;
 		return 0;
 	}
 
-	return security_transition_sid(tsec->sid, tsec->sid,
+	return security_transition_sid(crsec->sid, crsec->sid,
 				       secclass, NULL, socksid);
 }
 
@@ -4801,7 +4801,7 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 static int selinux_socket_create(int family, int type,
 				 int protocol, int kern)
 {
-	const struct cred_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	u32 newsid;
 	u16 secclass;
 	int rc;
@@ -4810,17 +4810,17 @@ static int selinux_socket_create(int family, int type,
 		return 0;
 
 	secclass = socket_type_to_security_class(family, type, protocol);
-	rc = socket_sockcreate_sid(tsec, secclass, &newsid);
+	rc = socket_sockcreate_sid(crsec, secclass, &newsid);
 	if (rc)
 		return rc;
 
-	return avc_has_perm(tsec->sid, newsid, secclass, SOCKET__CREATE, NULL);
+	return avc_has_perm(crsec->sid, newsid, secclass, SOCKET__CREATE, NULL);
 }
 
 static int selinux_socket_post_create(struct socket *sock, int family,
 				      int type, int protocol, int kern)
 {
-	const struct cred_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	struct inode_security_struct *isec = inode_security_novalidate(SOCK_INODE(sock));
 	struct sk_security_struct *sksec;
 	u16 sclass = socket_type_to_security_class(family, type, protocol);
@@ -4828,7 +4828,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 	int err = 0;
 
 	if (!kern) {
-		err = socket_sockcreate_sid(tsec, sclass, &sid);
+		err = socket_sockcreate_sid(crsec, sclass, &sid);
 		if (err)
 			return err;
 	}
@@ -6530,37 +6530,37 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 			       char **value)
 {
-	const struct cred_security_struct *tsec;
+	const struct cred_security_struct *crsec;
 	int error;
 	u32 sid;
 	u32 len;
 
 	rcu_read_lock();
-	tsec = selinux_cred(__task_cred(p));
+	crsec = selinux_cred(__task_cred(p));
 	if (p != current) {
-		error = avc_has_perm(current_sid(), tsec->sid,
+		error = avc_has_perm(current_sid(), crsec->sid,
 				     SECCLASS_PROCESS, PROCESS__GETATTR, NULL);
 		if (error)
 			goto err_unlock;
 	}
 	switch (attr) {
 	case LSM_ATTR_CURRENT:
-		sid = tsec->sid;
+		sid = crsec->sid;
 		break;
 	case LSM_ATTR_PREV:
-		sid = tsec->osid;
+		sid = crsec->osid;
 		break;
 	case LSM_ATTR_EXEC:
-		sid = tsec->exec_sid;
+		sid = crsec->exec_sid;
 		break;
 	case LSM_ATTR_FSCREATE:
-		sid = tsec->create_sid;
+		sid = crsec->create_sid;
 		break;
 	case LSM_ATTR_KEYCREATE:
-		sid = tsec->keycreate_sid;
+		sid = crsec->keycreate_sid;
 		break;
 	case LSM_ATTR_SOCKCREATE:
-		sid = tsec->sockcreate_sid;
+		sid = crsec->sockcreate_sid;
 		break;
 	default:
 		error = -EOPNOTSUPP;
@@ -6585,7 +6585,7 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 
 static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 {
-	struct cred_security_struct *tsec;
+	struct cred_security_struct *crsec;
 	struct cred *new;
 	u32 mysid = current_sid(), sid = 0, ptsid;
 	int error;
@@ -6671,11 +6671,11 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 	   operation.  See selinux_bprm_creds_for_exec for the execve
 	   checks and may_create for the file creation checks. The
 	   operation will then fail if the context is not permitted. */
-	tsec = selinux_cred(new);
+	crsec = selinux_cred(new);
 	if (attr == LSM_ATTR_EXEC) {
-		tsec->exec_sid = sid;
+		crsec->exec_sid = sid;
 	} else if (attr == LSM_ATTR_FSCREATE) {
-		tsec->create_sid = sid;
+		crsec->create_sid = sid;
 	} else if (attr == LSM_ATTR_KEYCREATE) {
 		if (sid) {
 			error = avc_has_perm(mysid, sid,
@@ -6683,22 +6683,22 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			if (error)
 				goto abort_change;
 		}
-		tsec->keycreate_sid = sid;
+		crsec->keycreate_sid = sid;
 	} else if (attr == LSM_ATTR_SOCKCREATE) {
-		tsec->sockcreate_sid = sid;
+		crsec->sockcreate_sid = sid;
 	} else if (attr == LSM_ATTR_CURRENT) {
 		error = -EINVAL;
 		if (sid == 0)
 			goto abort_change;
 
 		if (!current_is_single_threaded()) {
-			error = security_bounded_transition(tsec->sid, sid);
+			error = security_bounded_transition(crsec->sid, sid);
 			if (error)
 				goto abort_change;
 		}
 
 		/* Check permissions for the transition. */
-		error = avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
+		error = avc_has_perm(crsec->sid, sid, SECCLASS_PROCESS,
 				     PROCESS__DYNTRANSITION, NULL);
 		if (error)
 			goto abort_change;
@@ -6713,7 +6713,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 				goto abort_change;
 		}
 
-		tsec->sid = sid;
+		crsec->sid = sid;
 	} else {
 		error = -EINVAL;
 		goto abort_change;
@@ -6880,14 +6880,14 @@ static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 static int selinux_key_alloc(struct key *k, const struct cred *cred,
 			     unsigned long flags)
 {
-	const struct cred_security_struct *tsec;
+	const struct cred_security_struct *crsec;
 	struct key_security_struct *ksec = selinux_key(k);
 
-	tsec = selinux_cred(cred);
-	if (tsec->keycreate_sid)
-		ksec->sid = tsec->keycreate_sid;
+	crsec = selinux_cred(cred);
+	if (crsec->keycreate_sid)
+		ksec->sid = crsec->keycreate_sid;
 	else
-		ksec->sid = tsec->sid;
+		ksec->sid = crsec->sid;
 
 	return 0;
 }
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 00804562c2c3..8fc3de5234ac 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -217,9 +217,9 @@ selinux_ipc(const struct kern_ipc_perm *ipc)
  */
 static inline u32 current_sid(void)
 {
-	const struct cred_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 
-	return tsec->sid;
+	return crsec->sid;
 }
 
 static inline struct superblock_security_struct *
-- 
2.52.0

