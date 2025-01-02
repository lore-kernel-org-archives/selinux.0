Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06715575D
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836352; cv=none; b=rqqF6dDONF/2TmV2rs4Xfv4gmHhdXqbFNURg7VAgS/922Kpi+gvoMe6yzOj5zTBT2wWX0sZUDV5sq37nRK1dnQKPl8noBV3Nk5EFPbQXi/K8fZyBhQKROtAcmPFnJcvEeNFbwNsM+EW4zpe8OY8AUnmSPbQsysN6DYzuwuuS5og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836352; c=relaxed/simple;
	bh=p6xQr7fyLW6hJXEQ66hoI55mqfFqC7GtSALqtLBahkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jUT6ZpV7TJoV+NT9lWmagfjZtV5wSllnyMQtloq7jQ3qsQrthp6a8mIvqEoBoBqldLZebIBQOy4zt0p5mEZnaK8ELXHUoWOWjFGEWy21UP/sR+4cJiKHQsqWHCCcx4la24qOPGR5KmT3e7HyywodUMi59V6NwEyPiECuB8VQWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAikLcyy; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAikLcyy"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467a17055e6so128389751cf.3
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836349; x=1736441149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbvQFBPG02Kc4aTtsHuZjuF5x6gzUFwDF1PhT+HJtec=;
        b=TAikLcyyqgTOWvZUDOVbawRx4J8dNmDlQeVnbvPP5iKh+3/55820eeCWrvMBzhGYaA
         tSGZcjXxqGCQ/So7cjE5XMB2VDmmN1QQXWTTVRfJuot+8MEC9zrSmuvRhfScNG3yoGtn
         rETYLZVQKEQSzAQcm+FnydvjGtRNZFEk1vJteQBahn/wv+XC+o8i2Zz36gjtu0zdLCfT
         XCtMn9lQyX0QIBTy7z6Kr1oHsS7GhziiiYyFrICPNf5NRY7MetIe2ZacgjOUOkUf2MjM
         uiP5FwxJYnhxYl3wR9WWmM3CKbYPPOPk8E6xhcBlcTeby+KNcjr6CxRMnMVSRqU5MSNN
         fXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836349; x=1736441149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbvQFBPG02Kc4aTtsHuZjuF5x6gzUFwDF1PhT+HJtec=;
        b=Q9TmhL+8Wsi5vXnIl2KOSGBS471SDYI6yqC1ii4SZTV6PkpTapcc54udeR9wBzcMHJ
         UE+0gLp4m6rXczwm1sDw1ZJdDqR+4xbZd47kxu+dWs7MI4Ro+RX1ah3qNMFoafP0RnVd
         16g2iXXGvfhwhbXltiqyNsIjtZ3AxD93Tl1v/rKYtS4TqaOYFH0HZoXEYl7X1S/ztxvO
         8NrnI/8wTeDRehgpzmS1m2nQ1SrU3j4KJRpLfsWUPCo2q9jq65MN6HRWvmTRqIDxnOn6
         lxkOqG0K2UNseD8bFuvMADd8HQBdK20Mo9Z1i8K9LK/wW0IOggtpVlK2nHbs3mxr2lmi
         x7RQ==
X-Gm-Message-State: AOJu0Yz6m10BouvH1VSx5xw/a5PFB+0tCbH434CJhYD2s5Nuwm6UHuEE
	dzxF1rx29458b4Rhfng5bHx0oegCCBpAMHDJQpQ5dwV1JXUFskwmIgPtnw==
X-Gm-Gg: ASbGncvVcV4SHMv2J8ycsU5FiAeWAoM1ssA87AQu2HU5CE1tZTe2P1VHAL901OpIbeK
	/Lzh7nT0K77NidJI/Eg0UgohI/sNxkU3+eC6fDO3we4JYspnu2E75oFqke8gOFlZ2j0GwcB2cyi
	vmXIMHJDlSpR6UlmiVsPozZ0ATOTZYa/k2KMhGjQ3X9ozJNpmX83TtztZyWAJzGLU7QMZAqhJ/i
	YNl6l9XJn1kNnOBQDteOdzrAhksJsFWVHbNRA1KFxtzSDWGQD0y/SU5r87Jh/wednzUxpnm9w0E
	lmee69boYV8bqiFYTpYNort/kaqgSa1adGpgHzzXh0kkf1DuyKReeQXpHHOUxpEg/CRdhg==
X-Google-Smtp-Source: AGHT+IE/ay1Q7UeI/AOcpZnhoZ9k3zL6ZUYka226rzx3fyJderKg4EN+mS2K9P4iW82AzY1pBNauIA==
X-Received: by 2002:a05:622a:287:b0:45d:82a0:5028 with SMTP id d75a77b69052e-46a4a8b879cmr682051911cf.1.1735836348752;
        Thu, 02 Jan 2025 08:45:48 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:48 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 20/44] selinux: update bprm hooks for selinux namespaces
Date: Thu,  2 Jan 2025 11:44:45 -0500
Message-Id: <20250102164509.25606-21-stephen.smalley.work@gmail.com>
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
index 728a59aa52d6..e34ba9a9f2a0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2273,6 +2273,11 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
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
@@ -2302,6 +2307,7 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 
 static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 {
+	const struct cred *cred = current_cred();
 	const struct task_security_struct *old_tsec;
 	struct task_security_struct *new_tsec;
 	struct inode_security_struct *isec;
@@ -2312,7 +2318,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	/* SELinux context only depends on initial program or script and not
 	 * the script interpreter */
 
-	old_tsec = selinux_cred(current_cred());
+	old_tsec = selinux_cred(cred);
 	new_tsec = selinux_cred(bprm->cred);
 	isec = inode_security(inode);
 
@@ -2368,12 +2374,23 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
@@ -2424,6 +2441,19 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
 
@@ -2510,6 +2540,9 @@ static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
 	 * higher than the default soft limit for cases where the default is
 	 * lower than the hard limit, e.g. RLIMIT_CORE or RLIMIT_STACK.
 	 */
+	/* Only check against the current namespace because the SID
+	 * does not change in the parent.
+	 */
 	rc = avc_has_perm(current_selinux_state,
 			  new_tsec->osid, new_tsec->sid, SECCLASS_PROCESS,
 			  PROCESS__RLIMITINH, NULL);
@@ -2550,6 +2583,9 @@ static void selinux_bprm_committed_creds(const struct linux_binprm *bprm)
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
2.47.1

