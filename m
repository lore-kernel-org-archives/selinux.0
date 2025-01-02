Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B37B3E1
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836358; cv=none; b=gUqp+V0Iif76dlSVnWtPTV0ebWtTbNaV6gM0teblZbgAsXDAMsOApQAGMesCpJPUSpwD8El6KTruid4aFnDXsbGpQVBuYwW8SR8j+O9ZVvIWIxAL5WYFo6zRgAUeCCEWkEeiOF9S60MHqPk6tT5la2cLA3wF+vA3j4LzV6yN4lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836358; c=relaxed/simple;
	bh=pLYKtOLkVEeztobOa9R9waUcezrEI3PVPPvPHuXaEII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SFApzNZW7OBKJsy/95OV+RpdYOIoZz4NynuzCITTFoxWBRDFqn6bLE1XwWqUKnQlMYOosZDTK4tX5qZFOOjezlA4bzSR8YxpHY4gnbl2cJCBe9fCr1CGBT0mYsYd+rcUi2MhbRkrVaYSJa7puOJupAvm2O5u99idOAP8s5XgBM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIJot9q2; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIJot9q2"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467a17055e6so128390341cf.3
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836354; x=1736441154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuKGORPO0S6GHRdMIITTSQiI/DOvb7oakAlW6iIk5Eo=;
        b=VIJot9q2LHWskY8TqBXRvUsgUAERmdGUQYTRpsRiqF1aIHInvdwrki52gLDeI//Nl/
         puxniMS1qiPEN0sxRD/KGF7ZOFVV6WjEKFhVH3E7dXQvessCyvykreObbSxVOVNRSPrE
         6OeLrEATmAtRW+6Q99WuOO4j6zQ7dQJGdP1j/ILV7FKZtl4+h/mEGvMBJ1LbARoaib+A
         CsYfv3ohJ//7g7DoJwgGZHWcxfHIHF1leojMshmD0Vaq13RvCjBOpBYybuOm0rt+fn2x
         uqgQYeRIcbbT+1lS8IRkwsOz/Qbf6ZgiJTFglky4RSvDFsmTSG2SIwfYv9A3cyYNAS59
         TTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836354; x=1736441154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuKGORPO0S6GHRdMIITTSQiI/DOvb7oakAlW6iIk5Eo=;
        b=uthZcMeagfA2I4hvccDaIfavUM0TFZ9OBs81hX1ctfIOUm4vFiqIwho6reESQdeUH5
         HuUlX9RDcW20AY1F+n00tBciOJ82xVg7V27EatRal0+/N6dvGgJQ3bF7ffsPAqqbSIGA
         NfHVJBKQcdHQB1RtgyDkpaRgzL7BRzJp/yv0194KGMOuXtK5fFKq2QhZujJeUGn+3w6n
         2NZzYFc1i+3tqTMq8sumE29PirgIvVS9f0Y8R0YJ6D8QV6dEqx8xGZIFhqAKnrFqSUuq
         pFKNErsdGa791O29Q+Mvqwez4iu+Sfcv84j/hnpqCkdaCLbHIFBzyCT/okTrE4Hf+FHF
         /5Nw==
X-Gm-Message-State: AOJu0YxDxy/o6TjdQ0uHzqMrbQj2cTwDu2wRejA/7Sj5LqCGOUTNAb0k
	ckzvlrdTswSw+zf0ej93+LX4D4A8flFaSTwrNodx0aZ4F0lcdTKTjNDcMg==
X-Gm-Gg: ASbGncvC6SZ5uQmxx03nX+bmh9dNUbXdVJ1Fx1JOXzaKMi2rXke6GVPPslDFlve0dCI
	rlnlMFjLXpNiv3d4Kk0OMdYXpRMr/QoPuFrV1doQJz9ZSAht1vc0Tpqs7ySXKIlGHU5nHFAMUa+
	Br8ucII6GuPnxlbeJG906x+7JztXyk0JA5+b7gjPTAFl7mvZUuAv4Q0MsBJqbmomMa+4wOiOVBH
	w4VBL6fwiyI4gNEl/h7pfNz3QLTdYXOBGq36F0YpRgN7NwjNnhukPQJqd6LwZXHXmxInOzpzABG
	o3yXJa0fvQyOGfLn1A6q6DHmJrFjNOUUq+RZYQt0Utz+N1LQesL5zy37HCmqXAu0SjIrDA==
X-Google-Smtp-Source: AGHT+IE4z/CXulTefc5KPufPzDoLmQ1aNmh25HkKlBLaEKaoR8lNrxyartjkqW2lzb5GJ4QODROSUA==
X-Received: by 2002:ac8:5a0a:0:b0:467:5711:bdb8 with SMTP id d75a77b69052e-46a4a9a34a6mr871558631cf.46.1735836353686;
        Thu, 02 Jan 2025 08:45:53 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:53 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 27/44] selinux: annotate process transition permission checks
Date: Thu,  2 Jan 2025 11:44:52 -0500
Message-Id: <20250102164509.25606-28-stephen.smalley.work@gmail.com>
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
index 3fd787bf5cc6..5730138d4eb8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2385,19 +2385,23 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
@@ -2406,6 +2410,11 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 
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
@@ -2419,6 +2428,12 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
@@ -2434,6 +2449,11 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
@@ -2540,8 +2560,10 @@ static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
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
@@ -2583,8 +2605,10 @@ static void selinux_bprm_committed_creds(const struct linux_binprm *bprm)
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
@@ -6651,6 +6675,11 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
@@ -6661,6 +6690,11 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
2.47.1

