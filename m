Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D530749E;
	Thu, 14 Aug 2025 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178054; cv=none; b=nYQEIsOqTIt0EfC5YBm3Tp4fcHRHaingRd6XJXOtAxHTJsa9I8r/V8guP+AUhSIF3e5GOYVHjTkrAjReKvpTNR1K5k2a3ZBNNkCq2S3cQSMF5rXBdh3UkceGlpJqcAoyYYdteHuD8gc64CyrLG0F8B00lCGzxpZIQiCbz3ddAu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178054; c=relaxed/simple;
	bh=uinCFSRiAwJO1Z00o6+iZyNz5qNxCzuOAB6dKe2dQyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AN9CcQdgl8ihibWny/YBwakYF4zTlTp29Y+SJjirhiLAhOAUvmuWErdUyj38Hse3ojn9aWrdcxox6Rj7XuadA0B4i6430YQovbSCL48BbW2hAUjectg5KAT2alJjEiPpkT3DVcf+G7CnXZi8q3fod1uLlP1V9Vmh9AS1j3s7BEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUbuROjr; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUbuROjr"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b109bc07a4so5561291cf.2;
        Thu, 14 Aug 2025 06:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178051; x=1755782851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXxel+peA8S0NxTB7MUw6i9JqexRx8nL89MtzSp2XSg=;
        b=VUbuROjrLIVoGQ+j1I6Zd+iSxfpxpS/rwLxbQ72uSmI36vHR9LOQwyYoxOdX4J8TqF
         B7+MQBd9CtwsiGCJwmNjK7NkuF2Vxj2m+E/4+qLBCYsMU9xr098JfCQEW1QeIUDamutQ
         pPP27jZBuYxrWGw7nPB2A/R9iw+3QWYk4CdbEJLigStAdHhybvkYbpoOiASgKoekoySk
         V8H+/7hqBxfBLVGDf9pCN2oRtA9Phys8elmGRx+bo5eBKyea8P1geZlet2UMuogm8Xni
         5ovkAmLcJVMFZwo8xwTxiS0jtaOMpQcyhA9lDcKzA5koL6pJO2SvfgxjRKDioBE+Df6A
         XjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178051; x=1755782851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXxel+peA8S0NxTB7MUw6i9JqexRx8nL89MtzSp2XSg=;
        b=p/fAKrhMyOyXor9gdbLUZAHjqT2X/MLPO0SqH0aJSI1n72Zj8LhN/72Wm9a3oHHz/t
         cpOv1+Fis4tlKWin6/7qua7c43PkApb9wVs32lB/0AiI+gzoFF78F/mdkzJKCp7fBXjb
         +lGvdgNku2DDM+4+dnBjoM2LUqTQFhlF1WcBT0JA1g3ni3/vwYpb+apGnT+DDdmXn8Dy
         mCQfihHT9A0d527b8l7ZECUizoYEZl1SbQo/IKf+fRT/cc6y4Z+r3Erz6qifFN3IUxXM
         vAsXH8ukcMOKFxkxNpqK02yaUQ4DlKDNma3VSSybAsBVLvNDKUWbiPGCGLjviDw4SKWz
         02DA==
X-Forwarded-Encrypted: i=1; AJvYcCUJBBQv5zgBXS7+UYw7UMS9h/1hk3VCc+wpNHwBZdjcU7vnBcxocZagyGpHFAUAO/KxxPdjsGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkUrXVs/luExsez9RYbtbjw98blyIpKEvPx2PjvRyn+WDW/lm6
	TqC+gAViXyGfX82nCxMa4BlW8soLkQDZh7sJlSI2TBo3vvHO9zNED0a+Yg1HbA==
X-Gm-Gg: ASbGncuDm581u3U7fTVazHKmBBzcXXmrWNhoLwIy32CN0XC85On42MUJwNMPgTFwDG+
	caMY2dgCYiMP4JdaaXlsk4hWNlgQbOYWzGGBu6fZeVsV40haH3Y+i+7BvMtGKQDhQeJZwzR8kd7
	UGhOxS4WtD+99+isABFwIAgqz0U1cDBAtPxswupPJ43J/y+6N+ctBxY0Vfe1pJPRPe95bCItmfj
	GntMN+o0M17YNh1Tx0qxa5KTK7GN8FHOLfjqfC9LEDUZZ5Fxvc0kB7MfB5sZN+V4h0E5h+lcTUr
	bV2Hr7YQLr+KBH/GAlXmlsUoa3YcDnOvIffaVlz2mo3Lw5b2rZLr2mdNiuw3svhr1ZNTPxmor87
	s8hLpOp54XofnpN702Iv5yCv61fxYyUqesCEHemEfqCE9oiPr0/QN1Ot/P3QBu/PVEsVvL25EBk
	lALR1mNW692MWxQOSOabNQ6A70kg==
X-Google-Smtp-Source: AGHT+IGRSGDlXoRkOtesQuXLCe76B3MyX3jkmHYIzWT2EAuOHDl3yhPbxXpU3h7hCRNvVSVR+m7AXA==
X-Received: by 2002:a05:622a:110:b0:4b0:670b:f21a with SMTP id d75a77b69052e-4b10a917e18mr42360721cf.5.1755178050869;
        Thu, 14 Aug 2025 06:27:30 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:30 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 28/42] selinux: update bprm hooks for selinux namespaces
Date: Thu, 14 Aug 2025 09:26:19 -0400
Message-ID: <20250814132637.1659-29-stephen.smalley.work@gmail.com>
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

Update the bprm hook functions for SELinux namespaces.
Unlike most of the hook functions, this does not require
converting all of the permission checks to use the new
helpers that check permissions against the current and
all ancestor namespaces. Instead, we only need to check
the transition-related permissions against the current
namespace since only the SID in that current namespace
is changed by a transition. However, we do want to
check execute_no_trans against the ancestor namespaces
since they are not transitioning; hence, a check
is added to the end of selinux_bprm_creds_for_exec()
for that purpose. Otherwise, we just document the
fact that we are intentionally only checking against
the current SELinux namespace for the other checks.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d062ee0908a6..07bf35c14ae2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2283,6 +2283,11 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 			av |= PROCESS2__NNP_TRANSITION;
 		if (nosuid)
 			av |= PROCESS2__NOSUID_TRANSITION;
+		/*
+		 * Only check against the current SELinux namespace
+		 * because only the SID in the current namespace
+		 * is changed by a transition.
+		 */
 		rc = avc_has_perm(current_selinux_state,
 				  old_tsec->sid, new_tsec->sid,
 				  SECCLASS_PROCESS2, av, NULL);
@@ -2312,6 +2317,7 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 
 static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 {
+	const struct cred *cred = current_cred();
 	const struct task_security_struct *old_tsec;
 	struct task_security_struct *new_tsec;
 	struct inode_security_struct *isec;
@@ -2322,7 +2328,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	/* SELinux context only depends on initial program or script and not
 	 * the script interpreter */
 
-	old_tsec = selinux_cred(current_cred());
+	old_tsec = selinux_cred(cred);
 	new_tsec = selinux_cred(bprm->cred);
 	isec = inode_security(inode);
 
@@ -2378,12 +2384,23 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	ad.u.file = bprm->file;
 
 	if (new_tsec->sid == old_tsec->sid) {
+		/*
+		 * Only check against the current SELinux namespace
+		 * because only the SID in the current namespace
+		 * is changed by a transition.
+		 */
 		rc = avc_has_perm(current_selinux_state,
 				  old_tsec->sid, isec->sid,
 				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
 		if (rc)
 			return rc;
 	} else {
+		/*
+		 * Only check against the current SELinux namespace
+		 * because only the SID in the current namespace
+		 * is changed by a transition.
+		 */
+
 		/* Check permissions for the transition. */
 		rc = avc_has_perm(current_selinux_state,
 				  old_tsec->sid, new_tsec->sid,
@@ -2434,6 +2451,19 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 		bprm->secureexec |= !!rc;
 	}
 
+	/*
+	 * If in a non-init namespace, also check the ability of the
+	 * ancestors to execute without transitioning since the SID
+	 * in ancestor namespaces is NOT modified.
+	 */
+	cred = old_tsec->parent_cred;
+	if (cred) {
+		rc = cred_has_perm(cred, isec->sid,
+				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
+		if (rc)
+			return rc;
+	}
+
 	return 0;
 }
 
@@ -2520,6 +2550,9 @@ static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
 	 * higher than the default soft limit for cases where the default is
 	 * lower than the hard limit, e.g. RLIMIT_CORE or RLIMIT_STACK.
 	 */
+	/* Only check against the current namespace because the SID
+	 * does not change in the parent.
+	 */
 	rc = avc_has_perm(current_selinux_state,
 			  new_tsec->osid, new_tsec->sid, SECCLASS_PROCESS,
 			  PROCESS__RLIMITINH, NULL);
@@ -2560,6 +2593,9 @@ static void selinux_bprm_committed_creds(const struct linux_binprm *bprm)
 	 * This must occur _after_ the task SID has been updated so that any
 	 * kill done after the flush will be checked against the new SID.
 	 */
+	/* Only check against the current namespace because the SID
+	 * does not change in the parent.
+	 */
 	rc = avc_has_perm(current_selinux_state,
 			  osid, sid, SECCLASS_PROCESS, PROCESS__SIGINH, NULL);
 	if (rc) {
-- 
2.50.1

