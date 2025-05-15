Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4FF299AA6
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314642; cv=none; b=OAy4yL7ygsfTsSiBDXAzuTj9S+OdexqXXYajBBfSEeD4JKljc03byKfH5tRqyZB0mzyBEmmJz3yO+cvtWFP19k3K55SBluqPjzuZ6Uv9UGqRNLIHAh3vLIZaFF7gZM5yWHZwIPzsK8nf7QHnOuRaCC8AHwymY7gHUSxWMj/g6+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314642; c=relaxed/simple;
	bh=+eebbQ+RgPkZ3R9WiduOeUvf6r2qE9vXjiv/v5U0qM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhBkcOfKs7PC4hwHM7kzGN1i7Edn4luPPJfO4hR80fMcahID+aQPx6ochaKYHGEA/IhZcRzrtGOcXS9GUvBwHIsOVqQHatSUqs6Lf0FKc/IEs3dCGRxLEkJ3xZS+8ew8OxEkL1s+VcLPWg0gSi7druxBl9vwySyw+daiqxtq42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juTDzpk2; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juTDzpk2"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4766631a6a4so9933961cf.2
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314639; x=1747919439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQnvE77nM9a+caVkdbinUNNBTM8sQJsm+MYkU44aY1g=;
        b=juTDzpk2rQFoGzspA4FNZsHEFv9ZtJxamTsCS8W0lPoZduPqhGXKnQSGX85376ZZKh
         Nno71/c1h7fmC4MpOmPAkz6x7BJ1fbnp0WDyNG4IBF3oQrzE8XV6FMxodTjqry6LWG1o
         vZBTSygjYeR0qyCSLeZSCA82LWGHLMM9T5QgdFUqpHrlTsLqwvnLGVVidtL0OWqIthOq
         YWm16rSKvBzcXdupbTVtUedNoO2nb6lS1fSrkcmJsYusqupBsutbpL8JTlpFfiNj6exo
         siIR6rml9gA6O1f6t7F5456iZLqg+Yo4npLsPoiLSfIDbd3o0sKoZ1ERb1HGDAgL0si8
         ThUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314639; x=1747919439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQnvE77nM9a+caVkdbinUNNBTM8sQJsm+MYkU44aY1g=;
        b=hvcuy9Cuei/n0BkgeNL+tHNaFR1tJynIz8WD3UObg3j1Y6EPE5hekpE2aFGMyA209+
         0eRagnK8KOZP+QBd6foA07XFF2Uu/BsoZH2zmclGwZnnSsfGEGb18Ghg3C6hkmgOr0MU
         uGwzG81EiqrF00gmH9RsfZ/+D4sp4P+tPa7gq1aXRKD3MaUBm3h3kyv2CKHSmIdUjgO4
         2wVLXalf0kaS32DoGAVfl/30T+8TOkxiq+zafFAeltzeSbMRL3qBiMofxnLYxpyPfzFb
         Q7jlHv1TBSQN/O2ZlJyjfsj1lwU38q4KBqkDWDCLI7GAHn4462KfcTX4Nw4yXFQkLTwO
         Nysw==
X-Gm-Message-State: AOJu0YxsWctCr3b9wwhXoH8d/NRS07WIPmXY2Jrzb7cdL7pE3Y+9ei1b
	ScWG2I4VlmjEFmqJ1rjav51h1l2Pa7bX54xrPTzr3d1GxmPiH87ks8yOjg==
X-Gm-Gg: ASbGnctRO4n/mVQn4kZlN8E9MZF/g+hB/qFr69ias4MmRdPuX2M4ywWYSN6CDhvoE1t
	9ew+8JBYg3Qi2XPQR5jGL1FmOIkyYy9LJWVHkCOCeX9V3a3f9pInpqyaN467Hs33wWGjOIDRlCr
	z4fHOKuYY6Z0HYx7dbp998lsNCphxHyjIlK9o280nSwty4mnJGQtlSs6bQb5oHGCdq6B8LXUsOB
	+hqdqA0T64WG36rU+RF4O84Vv69cW6pWzQ8pVtMTDxG5qSFjHqZCj+t4DFhWiKPn8Qo7iF4xp5X
	1OQNYt1+SlvNSeecWLHDmDFefdM54u6YLU69+WTf7kwXG20S+pP6mT0l0g1dcYve06gsvZykHsD
	ACnZsTy8rYxfxT+fkw0AONgAjg7SrYaEPUAeOt1zaqJoGSDf1fkc318GWMCdgvqRM
X-Google-Smtp-Source: AGHT+IHwtk/AY6ERQbhtB54adMokqvNtDpz+Nhdilhc07AC5aKwbZ4j79rgdGm4l1XuKalTFkVAeKw==
X-Received: by 2002:a05:622a:8c4:b0:494:ac74:a2af with SMTP id d75a77b69052e-494ac74a484mr5295951cf.15.1747314638767;
        Thu, 15 May 2025 06:10:38 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:38 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 27/49] selinux: annotate process transition permission checks
Date: Thu, 15 May 2025 09:09:25 -0400
Message-ID: <20250515130947.52806-28-stephen.smalley.work@gmail.com>
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
index 1b0fef00cc84..383e032cd536 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2402,19 +2402,23 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
@@ -2423,6 +2427,11 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 
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
@@ -2436,6 +2445,12 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
@@ -2451,6 +2466,11 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
@@ -2557,8 +2577,10 @@ static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
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
@@ -2600,8 +2622,10 @@ static void selinux_bprm_committed_creds(const struct linux_binprm *bprm)
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
@@ -6822,6 +6846,11 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
@@ -6832,6 +6861,11 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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

