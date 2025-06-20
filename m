Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A082F19A2;
	Fri, 20 Jun 2025 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441550; cv=none; b=Nkk1qrZnOl+9vn6E9cpy6CHeX4bNxz/vydpdrfcKZM095z5jDZZ8+wFIefNNZ0sxjz6COZuRI2nUZv083wH3YTKL5VYpNNLMDdmkaQxBHc0IYz6U8o3zbOiVsMQvQLqFBT+6KAx4rRB8yjjR56l2MBZGc46LIGFx7CjnNVYF3f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441550; c=relaxed/simple;
	bh=x9zAJxNwRIQMICIXUGxIO36bl9V3ry6aLLji4L2TxgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMJ/DSxH83O/mgfJ8KotvcXA0mNCqThPNujDxMAKZzIl93eZK2ei32EO9Xwl7/2boDmof14WjB/SvagGxb4a0SDolNk+JuIpIBkmeK+HODdi8cOTBSuixh5woa3WfOe4Q5VWAUu5RQecaYUx1PHwYivQ41roMGBnxaDt/hMclog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jg9ZOIAv; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jg9ZOIAv"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6faf66905adso12559646d6.2;
        Fri, 20 Jun 2025 10:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441547; x=1751046347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSymi8qX9X+LMWCj32+jm+5wQVw7Ky1UktaFqunFAoE=;
        b=Jg9ZOIAv3PKVMLaDOSKtGcKmxUBP1jtxah1PhBYcRS5YE5W1JMly4EmhVvkPQ3BBj+
         IBwgF++NHNIjfKp++QMBLW7RgYFsY/8jXnTFnqswLtTZoJxVfZUOtpeCU92+McbOh7fX
         3atjvOLIoRi6TGV+E6vOAjvbTOZ//Q83r5BCVeZqnetWrmRUBzhNhl4uvjIv/+79dsxz
         Sa99gphDJjC7FNEX3mEXJ2wIjVrJdSXa3B/RNKPzTcf12pYm9vl5iDavb8DO5L1FbC3Y
         JcveqY4kWQQqFLitii+czb/iOZ4aR7RM15g03F4KtQP61J7NsZybO9QvBXBnlfRZ+D63
         Bj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441547; x=1751046347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSymi8qX9X+LMWCj32+jm+5wQVw7Ky1UktaFqunFAoE=;
        b=wwVI4mSPsy5ibU3UK5ANG4kTpQCRnpGVNloA53LZmBDmvVI8rwrb8mayOVkKBvjaW8
         GpAj7VcCZxlOpDEqoJ878mdlmCiVNjpE4iWkU8bvBayDM0HUTiQAqcKBSSsWwh6f+UC8
         IM1onfTzARcbBATjXVOoE1ZcsT1+R4r9gwdGNC3tWq5t5u8NjDQhJUb32U2Ze8XfUBNl
         TSGsZhyEGgk9xDklO97L7TTxtBPRd9ko02omVWTz9DQ4CQ04sHg+sjAaTwdyFKFHT1LF
         kc/M2OJ6gVequT56Hw0693CnY7Rnq2Hyti7nzVEDAnqkGNSsmL9OBykoUnXGKxsqBkpe
         Q91A==
X-Forwarded-Encrypted: i=1; AJvYcCXJ8tYEPaFgJ72/lhylkdR9rx5nY6za0ZaFjvrgOPHjOqVFt3+KsBbl+aFHdKoifo05NtpVOPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVr/qVii7mFou2s5nd56ruTTR8LtzhmvkEe/nXZkWCCsmwGCOR
	hPtkD+4fpk3DvuvvYMU5+7Oo5KF1z575VOPZaoYXufiuVLHDIjwrK1fcBkK4eA==
X-Gm-Gg: ASbGncs8MOqDJ6s/HUA1Np7W3AbfbuyQ1xS57iNACSyYbFYR6tS0X4bzsDFGgiX3adH
	uEy8KaBEJWTlV/Y1738fIQz2wVtMORDTGK/eQQDCc/jpG8SvCEFsVu4wjBuMSdnztb8wqiiowta
	R/CJViIXy3A/MofFA9/cfDxwXEGa8s8zfaIByFZbpz/wemO4mDbWf7L4KTJnageevLpqvQlyJ1g
	qGGuvvh1eEuU2hjAdG/65iNrIHRfXH8qMlILyJx27gdoOpZA4nDO5g9DDdBSPw2f2sVcv8DiTPo
	bXmM10xBLnl9E45HnaiPmhTAGRjeNafrwrOuMxbAYnOxSw/AgWK1zP3tDzaPXxWA+bhj/vgD4i5
	BDJ9U02JM3cEQ8zd7RBO6QSYRHrfz32tbj5pi3X+in1QowXf/7q0x5wgIzgICJoMnLQ==
X-Google-Smtp-Source: AGHT+IEY6HlT9uj3B4MI538iO5vahKKIWoe6oKjK/evwMbBTqsCC5PTRN1BCi7WXK0dwjWKllJ+PPA==
X-Received: by 2002:a05:6214:4885:b0:6fb:6778:e205 with SMTP id 6a1803df08f44-6fd0a535472mr66421296d6.25.1750441547395;
        Fri, 20 Jun 2025 10:45:47 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:47 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 36/42] selinux: annotate process transition permission checks
Date: Fri, 20 Jun 2025 13:44:48 -0400
Message-ID: <20250620174502.1838-37-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
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
index 21efa17b4d56..fd5a1b53b612 100644
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
@@ -6800,6 +6824,11 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
@@ -6810,6 +6839,11 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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

