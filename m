Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232722ED85A;
	Tue, 17 Jun 2025 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169211; cv=none; b=qc8NX09KXdcxjpB3wbsZ9jYwHbeQ9MpbX9/REd7wg/TjFGPQj0Yk8abHKeV6pQv2WFi6BDGVr4dslsQ2yCbI/NFZLSfhPOplyxMJzfXByemln0w8QtkzvzO2BFK/jvvByEg/yx+vTp8e3X2ix6goBFrqLhPvwdOw4GHJlp6pjFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169211; c=relaxed/simple;
	bh=tPQOFqFmPw1puyFHLYaaB2vK+rUubNpvE/f+ZzTs1Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGWQTvDV1S4Qx1LV1o89bZovXTyo2WfLKhTAnRYQ6SHcfqtyM7o0kWJQNHHuoL9dxJ7A8ExjJW9DDGal8xguve8dlVhaZAXEWNN8DAp/WwXm5FvEXQVZtBDMijWZQ7CXwBPwPp2bc5rututT4+vRtNw6VffRz0Qv4DW8v36H9/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATL7ETel; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATL7ETel"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d3e5df4785so14099285a.0;
        Tue, 17 Jun 2025 07:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169209; x=1750774009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR4EhK6ap27DM8/2e0+7d/R8Jt6XPAec5edX/twsafs=;
        b=ATL7ETel/x6byZOhnLytOgHfvkmUUbCLjTdgsFFCeOxQ0BVCDf+o9jGp/JsfWQFK0P
         KdxRUq477LoDWE/CKGmBQW9q1U46TiU7hCk12qH5OUfUYM2CQF/FKRpUZ3NdP8qQqudm
         /o/PCSGtP9Sd1COut6wOY81OyeeaMAUgeRiw72t5VrPBHb9BZ2bU1tjirMjCb68tyv+y
         8Ymf8OtDULXAAaNvBuRh/xrKlHZNHuG6EF3KFLU38k8GtlvaDHTMPiFpdS6HHS/9LXxI
         t93ieV5O9kflmmPX4peRiMpdcXI0C7rM4g2cI3wOX8lmVop+ieSmDv8IkCG2h74vVN63
         4Hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169209; x=1750774009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oR4EhK6ap27DM8/2e0+7d/R8Jt6XPAec5edX/twsafs=;
        b=Ldh5HlQ2W3nTIX4hqRdEEdbLKvSOkzf6gE1R0xoUy/kck9R3tZw7hS5UQ27wcKNbrB
         z64b8cvrxV848e/4CJYV70rtzuR6Ni+/ufIXQcq7xjWGMkBBq/zWwR9AIv+U7+aXvhYn
         7LnPXZyIchHEvFRV5W0SvA9W/D+OKoLsOPrUj66qa0o0nCO+gowoP5JV0KsQNLtxpdtf
         M+v3vLUeHDruNzHSPQY7WbxEwJPlhNxAKyiMFUUl5GHy0H0PGlZhQYXIvsXEZRUm5CPz
         TAQ4vpNKOeZQQgCS1HFb3jwMe6yAs8XMTKhx5AvKXuLlP3eTWsBuapZw1ZcOou7XO8j8
         /KUg==
X-Forwarded-Encrypted: i=1; AJvYcCV3uIiTpLJ2dzEk4y6fgKy8IYgpW7XIsRpOwteQN2fXuIoNRxAoScm+91QGkPMPpNP7CMV6i6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp0/r/Tfu/myO7eB2BYgxMaEPGdC98W15w22OfdaiFnRo+I4aL
	hwusYNhrE/7+Ab0fE4KfKSdOAoM5XDchBbrPQhdZDEiXcFBZB6WQPx5oe/6AuQ==
X-Gm-Gg: ASbGncteQTnFL86EAOvfVHEefkA5hVSNxnZiEMkhD2PBOYQJeHBU5FrBSWCXM0byTnV
	cZpNaLU6Nj/DPzCsYQogikx4fnQginCjwEkdF3uN7vCFIXlMzHGSTL+2B7AjPhzWmMwmv/pd7lE
	eS6wvOeXifzJrsiJl49Ye/oZNkemaoPTeGIdI6mBiNeh5peM8S+7gIX85pwiA7I+c5gOChRObAh
	vI6/EvX633sWswuC48Dr/QvOl0NiTakUfr9XiPhUT+XUioiclSOW4SBSMuyimkrTY9C/YMw7E9i
	/H3wPiBRXIbao4K+/s+FYOsfVFTRv86cUIh+i4x/GZuPL7AB56vs2391hn2/eNLyKbwKDiUYnCM
	3iqKojSSiU5H3DPZqYUyN0jgTuHXtgNxQMrFabM/KbiHiXsyAQsxvrHL2z+6iFAgG2A==
X-Google-Smtp-Source: AGHT+IF/rCD6k/F4zViU4HpkCZvwpU2FxTw/BiQDdKWdN14rH7YmXVrnaAHYHBOt39NSkgmSEBSI8A==
X-Received: by 2002:a05:620a:468c:b0:7d2:cc6:b485 with SMTP id af79cd13be357-7d3c6c0d3bdmr2517429285a.8.1750169208754;
        Tue, 17 Jun 2025 07:06:48 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:48 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 36/42] selinux: annotate process transition permission checks
Date: Tue, 17 Jun 2025 10:05:23 -0400
Message-ID: <20250617140531.2036-37-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
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
index 1513eb6efb64..e79d63e923de 100644
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

