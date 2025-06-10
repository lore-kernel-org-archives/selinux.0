Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F6D256C84;
	Tue, 10 Jun 2025 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576212; cv=none; b=iEDKw+i/lvEjA/FGUhg8az9rgJb51aqxfTFg8mhQAl6VbkUG6r4JD/xHbSNdspWfI8R9K6nRDVJgIMKpqn1pdJ/tB1oS8Gaxsfm3MqxDap5Eqc+x/eBoF/ylGtwyxS3EJHZ4uCvvtAkjP8ESNnMnH8AUO832D47UZ5c2XNu6HbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576212; c=relaxed/simple;
	bh=An9JopZAUeaqxKpEfTO2GI0ClL8rp9zrXUuLJKcx6K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABmlw5zCVwYrapHgEqfQLSYYZiZuqvIO89EetWfybVitLhwah1FCCcdFcsjzrAGT0JrEaZlWantK0JPuCa/T9V/pGAIBKRlNOPwYkzGF/P/1ENR5baND9pJnmWqSzcXuJebbICTsBb5JUZoTjmhdq+i32NgWM3T1+SDS5C0jyXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJaIJIfm; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJaIJIfm"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d09a032914so466144485a.3;
        Tue, 10 Jun 2025 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576210; x=1750181010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s48JP50IwJF68UTZ+9BRaQXxF0ZRa/g8oh4jsJMYs2E=;
        b=mJaIJIfmU35+Zt5XdzSoZIIU8BwXBdEs+AJ++ccChThrm3nfzTFxyNnT0azgXlIfKR
         2c7srwbg5NcGO1L3SJFTOxtsX67YEaVxwQQJMv1G00qSxs5HaUgZAtsjRIFvSJZg6Gev
         Yy2xR/C7qwVzCNUpZ3ixlz+izdkJ3K5bkOysPPo8TmAX2qKTZpIMSnftj17Fy99p97CQ
         kPzBR91YSnvEj7BDH0awGq1BtmVdl4SPL4EML81s9cJng6NJ5gTXJB5cbngSYq+Mfhjs
         Meu0NoRGx4Gnd44z4xoBpz3BRZ/C59QFgC2pjR+n6IT/N66Z6oQuTxhBEXG57+ek8vRr
         TIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576210; x=1750181010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s48JP50IwJF68UTZ+9BRaQXxF0ZRa/g8oh4jsJMYs2E=;
        b=cxvanOm6YzBD2rAeUVJjeHKE8XNbYvhGI6ZC0maz8I7cdGpfBYqiId8JoGP6mxfJYe
         +WQtqp9z8sBZ1l8I4kIsoE2dzYWCYAeDa4ZJCfNCrEhmF6Bi5SBsoAfo2bmNc1jXiXzZ
         OY9PTQBmI+L/+w16gcG2gGdhMFAqkRPw861pkNIC2he7Rk0Gbu1MKxb7bcG8MlumGP5P
         fQTcDx1lei/104l9zaMTLBjamgQG/H/OmIBPUFXQBAFQS1k81fnRONnCEIDUNIVo9TEd
         8lpF0nqnYG1rhuKqKot8kcgui4pnvaPR+xarsG4vQF0wYHi/SSJPPnA5wUGLp7ccfeL+
         0p3A==
X-Forwarded-Encrypted: i=1; AJvYcCUFHa2aMTbPj0D0YXShEibaas3wiqfjFms4bLh7M1k0TKLESxGb0l41DewFqwfj70u+mPVQwMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPHg+mh6kPtBz7gnImHoYaMbs8sH+XApNY7BVzux9LUdvWq4i3
	M7YUL83hTqDyGbXb2RgfREXGJtozPKZCYIHQXjZL4CIHYrwEZ4HihYJBsujg5w==
X-Gm-Gg: ASbGncvAyg0hTPNrE2Ha+Cr1vgjS9UyGP0V50KNyy8tQjtI1IpdbelRbW586RCN6fzY
	c1CBcBl+MrHOYdgeSFA91KAgnB2VNgZpO5kCEn4sraLWaC7mdPWgUrGMnQK/A1BKij/tfwjZW8D
	ffwErVY+Ea7M6Why9lJ7LtphRM0K6B2kIyes7IzaY7BpBciFvNoZWDUqDlDnxPWZHAVBwc3V4uw
	It+FIse1U+cRG0Q4vD3lNAd3cwE5B/c9tOJeO/M7qN8iETNakzVO6giy1ppTrJ9g0IeytcXMc3Q
	cBogHMQil6DeCKnHu1x+u6kOtfcoQYssy8g0RplHiq5tl64USbwzc0Cl1FiVS2JqLJFHAazriRo
	/VwoPFQzRMg8zGO9xgAKDtqz7GdpFcfsc6psjIQfPja2Q9pAn2lPpiDP1PVha0/Uij00Ys5I8tO
	KH
X-Google-Smtp-Source: AGHT+IHhmmTVZrWaLyo0vmWPbjFYa34wHWE6gZXF1hAOItY/BoQ+21W3b763QdUc10fxuc8wanVBeQ==
X-Received: by 2002:a05:620a:2916:b0:7d3:8b87:37cd with SMTP id af79cd13be357-7d3a880626fmr38365685a.3.1749576209683;
        Tue, 10 Jun 2025 10:23:29 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:29 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 36/42] selinux: annotate process transition permission checks
Date: Tue, 10 Jun 2025 13:22:07 -0400
Message-ID: <20250610172226.1470741-37-stephen.smalley.work@gmail.com>
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
index 775bf64fd3d5..1c09f4012937 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2395,19 +2395,23 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
@@ -2416,6 +2420,11 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 
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
@@ -2429,6 +2438,12 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
@@ -2444,6 +2459,11 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
@@ -2550,8 +2570,10 @@ static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
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
@@ -2593,8 +2615,10 @@ static void selinux_bprm_committed_creds(const struct linux_binprm *bprm)
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
@@ -6788,6 +6812,11 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
@@ -6798,6 +6827,11 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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

