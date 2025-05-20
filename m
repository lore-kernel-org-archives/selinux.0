Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BC6280015;
	Tue, 20 May 2025 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742506; cv=none; b=DzIVRPE+aukdEJ0iACi0L6VGS9Gi3NReMpTp0t8R487nvXtGms9nWvmGDUX7fCTk3MtzHT5b9/6jVBZ5lWhqtzrEla+J7+wCdkzorjL81lxgtYHW6yvZnMfWcsGLimRjRcm6Nqz5LrVr4OOIyxJZJc9tIAX3CyBG1odDqeCcb0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742506; c=relaxed/simple;
	bh=+xmwDkrTG6BmToUbfCDuZ8fkZ2cNMB3q84gEq0qm1U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0Gt3vK6yb0FyhGeSxZPXNjoEQHx2w/LfPwyJxoDhd45vhE1hMbq5JVSoQQizgiDt0WA3jkXdAQ5s8LnnKje7JzBfqrCyM2/8P1KC13/aGsdu5Y9I6b5msjE4IAcgl9XRL1A+xbYcBf8rFx5qhynr4ZNG2UV4S42B+tSatUl4nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHYlrZiq; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHYlrZiq"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2dfe2913a4bso1060323fac.1;
        Tue, 20 May 2025 05:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742503; x=1748347303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgwUOpo3cEycJg/Takp+h5yqmsEHex1JJNoefPmqz/Q=;
        b=kHYlrZiqCLNVsAgYr57KGqltP+eTxqFOe/WwPgPRQSD4dFp4IQ+GxN1oyK4TatD4wd
         mdh6IwagDU/JKK6aKymdhw60y4OBUuTq7OtIrh3rATBQFBA+9yNfAxAbHbXYZWtSMzoo
         p6wOO2zvk1z7byU0srxw96fpM/IflUxndL3w7OndfFXZD8KPJgGywO9UYCQROyHi0ekZ
         u1uSz+llf0+aSs/LZZ3tUMee/mkjTIFchaLcv5S3R+47+3hiS6nGmayqRhYyKA7EYlBj
         yQsy5cpasBXP4lJ/pZflDkZF7G3U5C3Kr0bV1Jw2YaFD/V0K4YCNK++GBYQdrRcopIJC
         4KYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742503; x=1748347303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgwUOpo3cEycJg/Takp+h5yqmsEHex1JJNoefPmqz/Q=;
        b=NBq0hcUtlbx8p039NLWOTmxIhdn3yxp+DGIbPABwnEd7h0hIPWJMAPFVI9iDL/NBsi
         KXuGn5TvHR0pGP1R2b7bJ4fH2H+B10b1uWbryFL3i8do+B69ZjyyUZ2wcKE2eTK6G7om
         Ung3n0pdYN6zgEb3c7tZtLp425z6/HgGtwzzJBvqslskdy9K+BebV1oh+GJoeSBl9XNB
         OQMS1mAP17zIRNv/NM/tVwQ5QQFWshDZx5VeAbz/dQQvN4iWgWtBW3/zAwnYmdqH2icX
         LIFtpEQ/FwumCEswyqvpuq/6RYh6NcF8y6iHXiZpLWg4HOCUnAW2zXDK+YgEdR+92agO
         BoKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUnoFj2X6cJ4/jCANTORlVlCIkHAcjlKfGuVOoZ4oMRz8xY0+Iopy7+fPMHKq2MnD5+2k3078=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCec4sG6wkkKpyJFLXXPJZyIMNwDWHjE3EWdrAOQwsSqz3TzYM
	Tg2sdPpOqUfkNOSiDv+TcCoiLy+J7QQEtnwMdz+SxsvbR2iwj/gAMb9ioNutwA==
X-Gm-Gg: ASbGncvZFGtjiTyPrZGkJ0ojXqGRML5CpjfblNGOEIzCwIaZYViCyliYczGDQwnWffp
	/Sq26BA7CL7R7xYTGEZ/HHlXwX52+NUIiPUZzfuAkHTyTyLuPKVFSZjYxde/CmqwIP/mfg/KjKv
	QCRHzSQhKTlNb3Vw126epPjqcwJIh4wvQ60jVHZiNhbd8G6l1q5WvfShCIPT1aly6KwIqnB7dgB
	Ihd9YzcqmcE6l7APpko57DC9LjUmPjluon815u2FQJSEaziwL8TJXoxANvgXw9hs1yeYlA2oR6P
	oxrQmEiLpYVDkK1zG9HWacCXlf0neGd3ZzIznUtyam6id9qbTSxuPFuV8uIBXp2yUD7g1b5sawk
	l6YCNef3DYSCDRt//TKGTr2XtL3XqjH8L8qCvKvN1o2C0LWEeXfaLnw==
X-Google-Smtp-Source: AGHT+IHVvVAFYWOQ0vtIBI+trtoEOotLauNMRYsaSzeGRHZ1kzkI55Lvnrzvti0UMATAmTWcY3xLvg==
X-Received: by 2002:a05:6871:d284:b0:2d6:245:a9b3 with SMTP id 586e51a60fabf-2e3c8187121mr9908488fac.6.1747742503077;
        Tue, 20 May 2025 05:01:43 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:42 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 35/42] selinux: annotate process transition permission checks
Date: Tue, 20 May 2025 07:59:33 -0400
Message-ID: <20250520120000.25501-37-stephen.smalley.work@gmail.com>
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

Annotate all process transition-related permission checks that are only
performed against the current SELinux namespace and not ancestors with
comments. These checks are only applied against the current namespace
because the process SID only changes in the current namespace; the SID
in ancestor namespaces remains unchanged.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 46 ++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 185a528a01c4..6368c3d5643a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2389,19 +2389,23 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 		if (rc)
 			return rc;
 	} else {
+		/* Check permissions for the transition. */
 		/*
 		 * Only check against the current SELinux namespace
 		 * because only the SID in the current namespace
 		 * is changed by a transition.
 		 */
-
-		/* Check permissions for the transition. */
 		rc = avc_has_perm(current_selinux_state,
 				  old_tsec->sid, new_tsec->sid,
 				  SECCLASS_PROCESS, PROCESS__TRANSITION, &ad);
 		if (rc)
 			return rc;
 
+		/*
+		 * Only check against the current SELinux namespace
+		 * because only the SID in the current namespace
+		 * is changed by a transition.
+		 */
 		rc = avc_has_perm(current_selinux_state,
 				  new_tsec->sid, isec->sid,
 				  SECCLASS_FILE, FILE__ENTRYPOINT, &ad);
@@ -2410,6 +2414,11 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 
 		/* Check for shared state */
 		if (bprm->unsafe & LSM_UNSAFE_SHARE) {
+			/*
+			 * Only check against the current SELinux namespace
+			 * because only the SID in the current namespace
+			 * is changed by a transition.
+			 */
 			rc = avc_has_perm(current_selinux_state,
 					  old_tsec->sid, new_tsec->sid,
 					  SECCLASS_PROCESS, PROCESS__SHARE,
@@ -2423,6 +2432,12 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 		if (bprm->unsafe & LSM_UNSAFE_PTRACE) {
 			u32 ptsid = ptrace_parent_sid();
 			if (ptsid != 0) {
+				/*
+				 * Only check against the current SELinux
+				 * namespace because only the SID in the
+				 * current namespace is changed by a
+				 * transition.
+				 */
 				rc = avc_has_perm(current_selinux_state,
 						  ptsid, new_tsec->sid,
 						  SECCLASS_PROCESS,
@@ -2438,6 +2453,11 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 		/* Enable secure mode for SIDs transitions unless
 		   the noatsecure permission is granted between
 		   the two SIDs, i.e. ahp returns 0. */
+		/*
+		 * Only check against the current SELinux namespace
+		 * because only the SID in the current namespace
+		 * is changed by a transition.
+		 */
 		rc = avc_has_perm(current_selinux_state,
 				  old_tsec->sid, new_tsec->sid,
 				  SECCLASS_PROCESS, PROCESS__NOATSECURE,
@@ -2544,8 +2564,10 @@ static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
 	 * higher than the default soft limit for cases where the default is
 	 * lower than the hard limit, e.g. RLIMIT_CORE or RLIMIT_STACK.
 	 */
-	/* Only check against the current namespace because the SID
-	 * does not change in the parent.
+	/*
+	 * Only check against the current SELinux namespace
+	 * because only the SID in the current namespace
+	 * is changed by a transition.
 	 */
 	rc = avc_has_perm(current_selinux_state,
 			  new_tsec->osid, new_tsec->sid, SECCLASS_PROCESS,
@@ -2587,8 +2609,10 @@ static void selinux_bprm_committed_creds(const struct linux_binprm *bprm)
 	 * This must occur _after_ the task SID has been updated so that any
 	 * kill done after the flush will be checked against the new SID.
 	 */
-	/* Only check against the current namespace because the SID
-	 * does not change in the parent.
+	/*
+	 * Only check against the current SELinux namespace
+	 * because only the SID in the current namespace
+	 * is changed by a transition.
 	 */
 	rc = avc_has_perm(current_selinux_state,
 			  osid, sid, SECCLASS_PROCESS, PROCESS__SIGINH, NULL);
@@ -6818,6 +6842,11 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		}
 
 		/* Check permissions for the transition. */
+		/*
+		 * Only check against the current SELinux namespace
+		 * because only the SID in the current namespace
+		 * is changed by a transition.
+		 */
 		error = avc_has_perm(current_selinux_state,
 				     tsec->sid, sid, SECCLASS_PROCESS,
 				     PROCESS__DYNTRANSITION, NULL);
@@ -6828,6 +6857,11 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		   Otherwise, leave SID unchanged and fail. */
 		ptsid = ptrace_parent_sid();
 		if (ptsid != 0) {
+			/*
+			 * Only check against the current SELinux namespace
+			 * because only the SID in the current namespace
+			 * is changed by a transition.
+			 */
 			error = avc_has_perm(current_selinux_state,
 					     ptsid, sid, SECCLASS_PROCESS,
 					     PROCESS__PTRACE, NULL);
-- 
2.49.0

