Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FAA3090EE;
	Thu, 14 Aug 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178061; cv=none; b=Lo5OFNnC5d/dOiaHiVrAXkqdYm584tkVPsePFXi4G5ML6x4Br1CUoDgsZEHtT87b54I3Npvqt+q8zxIWWmYvHtL3NMF6x3pUNxY/ndbkIzCEGsB8hdQx1xHexO7RERMEGF67P7RSbiQoPdWlxsLuGmh4rxN7IebsjT3OGznOvQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178061; c=relaxed/simple;
	bh=SjmIx/7UYqo0E3Lk3QlSBDqsTZwOnTbDmEwieZU3ytk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHancxTIbCrgk7kocaoyVFoyCO+MDfD1SsPrviRLLugaDMifvBqgvbFXEy1fKWVc0bSeNoqGO/oykuSFqp1G3Yv7bNngdXUtzFWWG9BpnEy2mZSdr3cxhRE8nwnMVCkDWLR15N+dOLbC/LUXLEHC+DCY+jJYNZWHYurRgESmpEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfyWV+U6; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfyWV+U6"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109c59dc9so12709521cf.3;
        Thu, 14 Aug 2025 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178058; x=1755782858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DSJYyfSqFn8j16S+PLjAxzeMGdVIa+W/VtNYnJwCE4=;
        b=kfyWV+U6m09kQ/yykx7q6CHteBUcHqosAUdna3VF1XoGDsm2XIKs7FC1v6R7sywiUe
         b5QtwijE3Cki2nd6ygkUuJEo7cZKvrCCI4I/HdbqBArneh0POe+LJ8HGfu/PorRjhuIU
         3KGCbfCGwXpPYGQ60WPFY7xfHPiE64rvi/P6ToSd/BX44Hrbg2pzANUrULLw5+BYk8PB
         jdrs4G1yjwQkjapfqHWm9wgnA8zB9rBNoIhlM5zAa95YD5jjTh7vXKM7Q7mtxRQw1r0j
         BX0CdQlrBA3q6+yb/epOe7QVxZ0iHhW8ZBrpqVHsflX5qksqb+9TqJ2YPMdkY+bSv2xa
         PaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178058; x=1755782858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DSJYyfSqFn8j16S+PLjAxzeMGdVIa+W/VtNYnJwCE4=;
        b=P064eeAaWQi0rRYb/ayvUgfiMylC9jVz4rJua5PIRtw+EatxBst7f5ueA8rEw2TyWz
         ShsDvUHrTZcVJiKp1nKdLeE+Ah+HKYI89JHEEeZ4YaTx2qlkn+N7n3TEWpeGclPPQoYu
         V630Y6qXDvgKK7HKP2mRiggvd6fIXR4uPFeU3/sNZK5UbIIoQoKdoeNfHUABi4NjXaAx
         vRc1kDe25Zpay60TGv9KFn4jLEiDOGhYCVZKzm787hUCo/eAX4IwxR4SOAvp+ItLs9dZ
         z4hlFvvUOU2bXtIVd/IH/3/FYgzErEYWI4ta6w5EBvEDZ8xXC2E5jy+ACTA+0TOxgsqH
         FQQg==
X-Forwarded-Encrypted: i=1; AJvYcCWkL7lHAIlpX2ARz8InKGB9wph/dEEapHCzjzcoj8VycwsEouHzA4IqZ5GsPqC7JvAQkYaLWD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIIdmJlYVJt0gM27wjwBd42qotYu+LeO745I8Ph4xVb693TeQG
	kiDBtCHD1HruYJ/1qnyzAJ0+YGQsDhjzajbtyqYZBtxZIpCIb+/UFX5ZClmaFA==
X-Gm-Gg: ASbGncsn0vlGO9bxoeS/jNLv3+GgnudkhzCEncpvjOyyz411rAK7xE2Gi/rEH37QBx+
	+BtIOOKpraEPz+9eSn5QQZWbiZ0mts5/ic3PpTJyM3IMlE1QzJh22hxbcmS2HnXvha0KnGq0yMj
	orEEA9XaD/ri6hciegfCt6/x0X6ZULdEtZ5+v6v0e9DVDqAnj9+iy8xV9L9+Wb+7JnvpZFlrdUj
	qXZUcgwvDcWTsbjZg7wHZ5vYxKBnjePTdNpq12QaTnhN+4YMeBd0f77iWGqsnbipNI/VoFBX1i4
	sKvn8l94r/LtEmn/9atcus7QyHK4aw3Pa9oWahJPjG/qEHtYu0w4xVkjwUP6bKOLsWTLXuppSxK
	RusdMfCJng8LhpD6mHnb594sqdxVewRqqp397jlUfZX2i5I7IU2twNKtOW+oMcZ+LsOuuWymtkc
	7MmCWFfGzE8cqaW1kLzxlTE7C8dQ==
X-Google-Smtp-Source: AGHT+IElvq+1fRLAvqBKzj+c7hUGYldxhC5067lL7e8OyQip6/a1K3ccj+aT/R3BHfgmd+MbcnHdqQ==
X-Received: by 2002:a05:622a:2d5:b0:4af:3b7:7011 with SMTP id d75a77b69052e-4b10aa6b7a0mr42504171cf.35.1755178058251;
        Thu, 14 Aug 2025 06:27:38 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:37 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 36/42] selinux: annotate process transition permission checks
Date: Thu, 14 Aug 2025 09:26:27 -0400
Message-ID: <20250814132637.1659-37-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
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
index 8a32f5655980..e35b3fb16bb8 100644
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
@@ -6812,6 +6836,11 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
@@ -6822,6 +6851,11 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
2.50.1

