Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D812459F7;
	Tue, 10 Jun 2025 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576207; cv=none; b=YQjEZsW9Mw1o4cDqoSBDasHVzHgO/b07TnsZ/0ZirMscjk0Tkp84uItbpQCpTDnjESBGUR9h92R7T0eZt0WHZ5IwpzO8atwbFDPPS+RPbcXmpqwO9ij7jnfjyspiDFe12K69AzUHL/STC5xILZELhu7r0Guag37zSLS/TPf5dr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576207; c=relaxed/simple;
	bh=RK2c2snQV1174G2mJ1l0C1Ecfhhrc6r9NDzsqJ4oOmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oV7OaGGBnnpacWY6eeVawTE9i9W/wsEXDpx0MEen/QHic7vqWFFUSyDOSB6hbvm8b9xI1Zk9bHxjipHYrdlAEjQWaBV9xDc7Xe9cVUJM2lotM+U4FSZsF79mhmxarRkLQ75PKvUW7qSoR4eOUuo0Bf7d5vCNp5Nk6WnrAWeo0+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap+PgYSx; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap+PgYSx"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso786846d6.1;
        Tue, 10 Jun 2025 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576204; x=1750181004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKHxJvOpFKszXBb9FdUByVo94kwP1xAcywVPr+4ePz8=;
        b=ap+PgYSxiHWRBb0JU8Lkbcl3iuU97bfrTVgwRHvpIq6ObnQTjQvkXcmf8YDBhi7CLI
         dlV97eBHZ10AzomHRksgNYa3H4M6OW1OT7QBb15cFkyDfFOpUYDiNAbdrTaIO/MHO9vh
         4z1SDi1buUtt66JTfLMMdTNdHoFYuNkhuIGZpnNSVTSsoFxmcGRQ40wgdXIXV/dyIZem
         HICEshL5y1NgouozDXk+ApaeZAV+ceKwOQgLxE0wMXLGCTmKFzKrhr+tYJoO22K0WAAh
         YVTm50f4/hn4Io7kqw7dLD9O4LbAqssUqpFhRAjnqGSoc7tk1XtzyUxWgAWi8M75l+67
         8QXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576204; x=1750181004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKHxJvOpFKszXBb9FdUByVo94kwP1xAcywVPr+4ePz8=;
        b=VzNffDC8msVLeIjGl8FdOtKMK5FDfUKO4geq0y/IRqrgjrf8/b/EvgBdBQ1X75ADSM
         sZf6wjlPt7wVDCZPYSAlYHBBrF/P8fTCSAGQ6srLuHLx2j0Am6caWZB4aXt75R8RivyR
         0hJJ5XhXkH7xFfbazOY7bSMaXREYrWv9ag5YLa5n9ThCQJOS78c+yRF2FcNci7nxLzzA
         2XztJ1IZ75yfJ34RCDb+lv5AkH5qL1gIegBUBGqYH+bFRUSxqw9FZ9Y9p1jv0Hw8F9kt
         fiXhfd0CpXpZXZBN5FLdX53FGU6XcizO+31TP1DOy9M/hKNeeHuYbRDEkyShzs9qSkno
         VYBA==
X-Forwarded-Encrypted: i=1; AJvYcCUlL8o0jbxZwiRuazmatcrvugrIbD1FL6DzDwDksdUtZ3ChkUag1uoXrQAHVE5AcyXjtzjaD4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1reyZHnsZ1MC2NEwijrB04XGQux9LBalkQRDKyZFtIQCM5g0c
	Rsx5V2eToUGAi3Zq6mRMlvr8KfD7hGlI01BhWW/9DcYVkjl1Nlv4c/hv1czHdg==
X-Gm-Gg: ASbGncuMOR9VSioSUv1p18Q1JODSn6lFtl9dr7NYh9DnLNlMjKW2r7aLKn5Z1ZD8khB
	eqQYrQWBc4y5ndk1kMZ7W8/4w7luMCNwkU3GIHXcEbR6hMrb3ibaNr5lczvcs0VmYBuywWjqtrw
	xIST2xPBYnU1nUS89SB+ByL3cV8QYr5U0cnsrnIskwdezp9wf/YJvVIU6rJDtnnyW0fK+H8JVhU
	xk07PX2ZpdB5/Kmdl3Z4ftQHiqDgVmGt/8Jd+P9P4P2TxYQPSbrQINrwfHh3ryzLp+2Wp5A7Qxv
	1P6z7me9xZ3j2vCJn1P5x9fWmQnu7NwTw7Ps1+CBiQBi+8y5qO6CcKizksWRmKLhWve6BkinzcI
	hkJK70JSm13bSbBNE018IC62ZwxcZQR7KsGwPkN/MrqZVJ308388wa5qwC5r1Gk8kO+t3NUdRiz
	gD
X-Google-Smtp-Source: AGHT+IGyQ5Eb+lS6MLcGxsaQXqKmNhfuPnjFeGV9nnqt7BFuzFPB7kdrCl3HaAg9thu9KEncoMBwqA==
X-Received: by 2002:a05:6214:1d2d:b0:6fa:ee98:65b6 with SMTP id 6a1803df08f44-6fb2c37a117mr4496706d6.4.1749576203934;
        Tue, 10 Jun 2025 10:23:23 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:23 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 28/42] selinux: update bprm hooks for selinux namespaces
Date: Tue, 10 Jun 2025 13:21:59 -0400
Message-ID: <20250610172226.1470741-29-stephen.smalley.work@gmail.com>
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
index 44730629c772..2e2aa80b76af 100644
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
2.49.0

