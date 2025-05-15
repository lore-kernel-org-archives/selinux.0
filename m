Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEA029A304
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314647; cv=none; b=fcVtFir3tC/j0ECqY1lMyvKa7HXqotpnmwJxJiznRuZGk2KrG1xp9S0bYjvrv/97zzhFOSO/ryxiJeWTxWvYYCHRtCNBL/qgnTd4uCy0ivDYzvpjs1tlQtgGmU/NM+STG3Ofzg8U6YV+D43XjgLCRVTPyqe3HIVGTeTjmb3te04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314647; c=relaxed/simple;
	bh=2/VAHuxT1g2oMPPZbhMpA8nVSv8tU2Jxi2584+ugiVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jr0Yhr1RrYFOGdS/cHzKt7C+p14oInp/jGMwPaKsCLyYDDm10P1Twb+qwwbhwV2Sz4RxOGDRZ83qASYFL6MR9Jd3LP1ESkJT1C7boK1Leo9PaMHMFcZNeZic35IC5Mi9O1L0rUTPOO6WT0wD8NqTaCGoB/bRBONKlDHWG6kq2FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUppErca; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUppErca"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7cadd46ea9aso132251285a.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314645; x=1747919445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsH9Jq9fSY3TgUOh6ZOvRm7k06qoi1/IoUqZ7IHW+wA=;
        b=WUppErcaNDZSYiUkpAP+p6zO6MT764zI+ods/z+10UPO0iv3sPwNx31LvfDUC+U9Ps
         8c1/ebRDxLO2EhICf83M8pPvcoKR6yGGkoGYrqjUsh899RHIpTJLmKS1uPReepdWRDPW
         aXTUtp9lOwwjx/BwXx5d8gbN+MfVtmQJoQK78dG4bosKPXNLRFOqOYEk+7wnB3i3CsLl
         j1AP+1hdf4p7BWiLqwtwbc9lDoUj3TjBJEvAVK6XGEyc7VZ8wV5Yi8YXHgXwS688b5KC
         /eHuUUrEgfwn4ij5CjVnjMcni4mdUjtPCqKsbozRcnX8+0jaEfuTShZG0L4ytsF4g3b2
         8TKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314645; x=1747919445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsH9Jq9fSY3TgUOh6ZOvRm7k06qoi1/IoUqZ7IHW+wA=;
        b=DU3wzr9Zg4Glmmfq64jmCVjMh6c/lpMrUzAUXw+8mjGjMsor4YHDCbl5iAXR205Up/
         EBIiBUlFUNAekv8FvxMYs9zSoRKppDMP4u0sie3/G0Z/yyVEZNJsv1x/5ZOP1FLn7a+Y
         WG6kfhh9GxMWjoAGSJe6mfOaDgP/5V2TkxI/0z8sw7wtmlGWk0eWB2dSHSj/H2WO5q/i
         ETtyywSA0fmTGJmWC/DAPU/LS3tVzCeahlqs50tY1bCLDmzoWCLck/0xAwPVdzpH11L2
         9lJj4uz3x8k2IU46Gz7u6M5u2vRDoPFshG47dKUDP3X634SeNBpZBKXnQumiIxlAs562
         X83g==
X-Gm-Message-State: AOJu0Yx4bfAtZihdyBDGFz/GhSiqYuhRRr8hvfdbXb1k4x/6qZR6wR7U
	vKc8DLpTx6Y8ZZFgCOxLIMg4wz2Ie5ZhYq/V14cpEGkq4IHSd8ZLPu86ZA==
X-Gm-Gg: ASbGnctDABF8e6fXoGNMVyzig0/7ycZUBzVLF2qeqOMuaQ0bU245tG7XMH+qtugwiuC
	aVeR82+JBgy839lcFv2GMYtyG97HxezFyXV22YT3h/aAP05GRH3aUBFVFpB1e4bwu0M7Hmd/Z5/
	whtARGGsKPhnLlHb+4ihAKFof3r29fvzX9vCr5SQIJy1KAiSDnCWGzFn+II1lBtCdd3WCtbliiK
	ZjpKbtQVb0ebDwQVF5qJJLllY9wLM4ZLWB9oP7OEREvrx9tp3cUwDgV61eNL+KpszUh5HrCA6ri
	hmfT0aECk5CvgG0fsqxiOdSALdlfz5j7Skck51IwRI2zK0aeCFVtkJny0fgyT+cKWv/WhWGTVk+
	uB6eJzxlj9qu83xLeEzbl84ZV1KZxMHXaz1QwXwLHHrHUQFf7+FX3UA==
X-Google-Smtp-Source: AGHT+IHXTwZLgDAPCvEkwjw3IAq9/BQPsKB7h8xnmeYYJTaGB20q3NUe14k500OgsaRXm+hfkOPuhw==
X-Received: by 2002:a05:622a:5c98:b0:478:f00e:eed5 with SMTP id d75a77b69052e-494a366cbbcmr40878791cf.48.1747314634199;
        Thu, 15 May 2025 06:10:34 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:33 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 20/49] selinux: update bprm hooks for selinux namespaces
Date: Thu, 15 May 2025 09:09:18 -0400
Message-ID: <20250515130947.52806-21-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
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
index 2c478b42a76d..94777b89a3b6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2290,6 +2290,11 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
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
@@ -2319,6 +2324,7 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 
 static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 {
+	const struct cred *cred = current_cred();
 	const struct task_security_struct *old_tsec;
 	struct task_security_struct *new_tsec;
 	struct inode_security_struct *isec;
@@ -2329,7 +2335,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	/* SELinux context only depends on initial program or script and not
 	 * the script interpreter */
 
-	old_tsec = selinux_cred(current_cred());
+	old_tsec = selinux_cred(cred);
 	new_tsec = selinux_cred(bprm->cred);
 	isec = inode_security(inode);
 
@@ -2385,12 +2391,23 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
@@ -2441,6 +2458,19 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
 
@@ -2527,6 +2557,9 @@ static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
 	 * higher than the default soft limit for cases where the default is
 	 * lower than the hard limit, e.g. RLIMIT_CORE or RLIMIT_STACK.
 	 */
+	/* Only check against the current namespace because the SID
+	 * does not change in the parent.
+	 */
 	rc = avc_has_perm(current_selinux_state,
 			  new_tsec->osid, new_tsec->sid, SECCLASS_PROCESS,
 			  PROCESS__RLIMITINH, NULL);
@@ -2567,6 +2600,9 @@ static void selinux_bprm_committed_creds(const struct linux_binprm *bprm)
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
2.49.0

