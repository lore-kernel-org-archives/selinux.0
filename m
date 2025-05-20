Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1967B2857C0;
	Tue, 20 May 2025 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742496; cv=none; b=BOu5k50PRB71fJLhEr6nJie5Mi1l4ti8Oedfh2e4Frr0jevc28tZKHr6U8/H+8lWKcXuGWP/4uN6B7/haY43WPjtxbKTELvfOpojmhBPdSID9cvEKFSj4odmqnrGSlzLfLZHl/qZ0kaTIydFVmvInqWxbDBrmJ2KY+gmRlNZtls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742496; c=relaxed/simple;
	bh=OC49yr8T25Da6RPiqFW8WJBh4Wl7/qzYPGxn/1HgVo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxGbe/9t0yxO0Gnk5HJoIK91L7s/4lk/ptVdS6KJN/MY0DgQddmve2HswrfD5ZQYd+fHWWZznwrlUU9eR9UTe2i7v3VuK1kykXMMMFbls0cJtnuQPZ1CAshyKzssRZQNAIhbpGZ2bSEgcoeec/X14mCHAE/gwD7X7iLnBwjQr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlRR8teU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlRR8teU"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c9376c4dbaso614629485a.0;
        Tue, 20 May 2025 05:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742494; x=1748347294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9xxg98NP5WQNOGdEJX54woohgc9O4+lMdNE25nVGTw=;
        b=UlRR8teUBy4YfPyLKVnCxoC/0nemzxyRvJwdfhUP3ddGPZzKL88ITBPPSXLPe6yKos
         VwiG6ewrlUQp2Te+oQgKBhhkIuJ9Ta70bPsajKyFLEPIqaBtkHVBjaDBuu3t4o6o3o7p
         3byNt/3f3kp3O6ZhLW3i7BL37YsSLcjRyJJcV+Fr+urcKPEgQeB6GbQRdqGS2IsJBTgL
         R36MS+5xyQ12IdQj6wARUAmX1EAlF7GYubf36tmeN0UlMnqMLn9tz9uUqo+htXg1XdgJ
         f+Tjjm4LRQ6auWmLgzpyFc05EpBPnJE/+WWp5WCxHDEcSVDlG5d4vcesAYpvDOpnZfAd
         QDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742494; x=1748347294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9xxg98NP5WQNOGdEJX54woohgc9O4+lMdNE25nVGTw=;
        b=YaqvqOdFpHekIL0osBz8CGOAsQm3HwCBGFaDJdnT/f25FYPNVhsX/HYGyJ9X7pEiH5
         Uc+Hyk7gJHFS/r7ZFA4CVrvHo3SiXmlc3n73jDysULgZm/GhUvI1UC6KdBlSbf22LlgI
         Dmo2ri76mxC4ASO54iuzgRgNpKyZdiHsRW51o5wYv+mfzZ3LIJGQkIofiwP2+coiWa3U
         X/wNksTiAtTdi+C+RzOhcgNF7OYHiT+DcX1XjB36Bc1o2vw4JJawbgRu8fGENXXAakVx
         ODy01bHaI6i+2XjxlfmGthJuG0HepofHSKV1wSGYqLUtFZXDJ55R40dLrguaoRmpNAk6
         3+fA==
X-Forwarded-Encrypted: i=1; AJvYcCX7o52hIv2CnfJPZlHi5y+ZKSdXuA0zJK4Lrf0ATVLO4GZjAZIPSP8wZ/er+dwFPGG5FbE2wE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDD6OoeofdEySWTkMEMYzHkNCQIe1c439xK4F79wXIm6fCkFa+
	/lt/+IrQdghjQB9Saxq2Zt5Qwc29qkahwekTHdvFyxfk9hz2IjQ3yjk0YxBA6w==
X-Gm-Gg: ASbGncury2GfN0Ilz8xOiUFC/cVulCZpzTc1ZIbcoVBtnCg02QxN5QMmw2cx+vBk840
	dzbOihwx2RShBwNLH9lSA59LFWjyfKA5O0s9yFke7QRKuiWr2EOyy5gmE0xSxTEzV5Jbe3dDmIk
	dzk7EzEnz0ErozA0DGu+lYIV7ajWosTxtYMhbcrr8OMQbfODPQd2p/KlMVV1R6G0jYT3i6pNoCa
	ANKYayHNCsy+aJSvx2QIOqSJ2l1D4rkN/Tcts84WKOgqJfd/yaTcEa0Wnx3YmyEfKzHJJwJ5xX+
	rjbZrG+qQ4Na+xsf/SwIAZT9eu52NBjONXfM2GYHRWbcCEnYyAt2X3rAFnaVE+HGyH+JMJGe4Y5
	4sQusYFhrlcjbn2wMGnOXzaGPrIkwppEHpC5BIwWh/HJEOh/yPZpKU9BRKUWwJDXF
X-Google-Smtp-Source: AGHT+IHSJUfM0Rdhid8zZRcrRIR69zsCKh1kC3SBjrX1KR9W0vGx+yPyEKi420CNcGEhcGxaakB0BA==
X-Received: by 2002:a05:620a:2b89:b0:7c2:3f1f:1a15 with SMTP id af79cd13be357-7cd39dccb92mr3642473285a.8.1747742493567;
        Tue, 20 May 2025 05:01:33 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:32 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 27/42] selinux: update bprm hooks for selinux namespaces
Date: Tue, 20 May 2025 07:59:25 -0400
Message-ID: <20250520120000.25501-29-stephen.smalley.work@gmail.com>
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
index 77a1c58b1788..1c7def807fb2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2277,6 +2277,11 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
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
@@ -2306,6 +2311,7 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 
 static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 {
+	const struct cred *cred = current_cred();
 	const struct task_security_struct *old_tsec;
 	struct task_security_struct *new_tsec;
 	struct inode_security_struct *isec;
@@ -2316,7 +2322,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	/* SELinux context only depends on initial program or script and not
 	 * the script interpreter */
 
-	old_tsec = selinux_cred(current_cred());
+	old_tsec = selinux_cred(cred);
 	new_tsec = selinux_cred(bprm->cred);
 	isec = inode_security(inode);
 
@@ -2372,12 +2378,23 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
@@ -2428,6 +2445,19 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
 
@@ -2514,6 +2544,9 @@ static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
 	 * higher than the default soft limit for cases where the default is
 	 * lower than the hard limit, e.g. RLIMIT_CORE or RLIMIT_STACK.
 	 */
+	/* Only check against the current namespace because the SID
+	 * does not change in the parent.
+	 */
 	rc = avc_has_perm(current_selinux_state,
 			  new_tsec->osid, new_tsec->sid, SECCLASS_PROCESS,
 			  PROCESS__RLIMITINH, NULL);
@@ -2554,6 +2587,9 @@ static void selinux_bprm_committed_creds(const struct linux_binprm *bprm)
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

