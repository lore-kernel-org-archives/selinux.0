Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DA714F9F7
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836360; cv=none; b=shf+ASuee0q8JibfOOG/Q/g1ResoMFJBr1wAf8wJHkansq2j2oPLS/AVSBgLa7b3WHQzJ1Xtz7z7ycTRGdN+qrH5JgFUVVikn8cTWFQsRy09XR279n3wyuu10WwBlCsOGavUUIJCaNwfQ1r06Wu/8CzkJ8qseGD4C3gBnDpdeRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836360; c=relaxed/simple;
	bh=ciA55Er2WCBV42DsQ/CCKkGVWYkwO0k0AVId9Y14xAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jv5DDx2gKCJgl72Es20vvnd4QNK9dCFe7L9s2ka9bv2yiob092h97v7wheOyzLuT93JS3Z5yNRFWAOf5pINNq4nU4X4k7GWwLn2UvhsE/5e5xCA3pQGQk19ZhuOKk7G+vItBFl/kERIhfi77GrWAdSQMfT4VHQuTz1Qo9ZFqb9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUe+XzNX; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUe+XzNX"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6ff72ba5aso946803985a.1
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836355; x=1736441155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iS2JKJ/kLXdoj5LJgkhhamyl48FBR8NUfIx1FZgTPE=;
        b=lUe+XzNX+SmNi3XCmwLPmweqQ6OmjlomHpmEFVcfkD8JBiezCjL8BNovAd77X7Mn+Q
         RsubqmqSaEItVTzd8z6uGrA6w030YXqPmi4T58onJJcFuFFZW1Xh4To+rr1AOPSGCkf5
         iSClu85OHTLgH/X5GkKahdgB/rmYiWmIjuRmbsP5zrArM0JEmdvJ8LxC5W91Z1CS9vvb
         LJr5NPLGSaj2ctUk317RNaRup5sx09XOZNSjYFZUcdpCvN+7L4FtnPYzgHdbavqfgJU4
         qUCKF6UY9m5mpZhAlXrgkGKnSSQdXJVr3HNwAzlG1VxWET1OGiCKS51mjwppil9reg5Z
         wmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836355; x=1736441155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iS2JKJ/kLXdoj5LJgkhhamyl48FBR8NUfIx1FZgTPE=;
        b=UERLYyAP/nk01xnUVYLJC2WCs/BHCtr7Yl3weKCpwCwquU7ZBSimKctAwItwYpxgsG
         uqOKnVtN4Vpboo6aO6NnAK2vvQSZ2KujUHNleHUyMWwDkDRmhzIsHSi+yZX46PXFu7yo
         8tHfiwm45c8LT2+NHJm5jbrtKvlqR8cawPlt69I5Lui7bIiMgbY7trhiDo2g/THonvXi
         Fh1pKvreq1PdkNNpNztH5Kw2byOQpF9psG2CO/HtW4BWPo9NqVrVhpXTlHB9PIGD4XRR
         XcKTvBkwmEoIJgYeCRvMT0cmwWNw/qvkfVAGljWBcouyZbpCnbVyEJYG8y7zR89XMO1W
         BFuA==
X-Gm-Message-State: AOJu0YyMAQGl/1KjNetwJfFwoKMUbU7nv1xDjtdRtCKF2rCeAz7rH1Fl
	Y09vw7Op8+M6TLh+LCB1FlEYMz6hHXDszBj/Z53zkabNVnrZ+0mSm2V9Fg==
X-Gm-Gg: ASbGncswbCxP8vgywDG37m2StG1uXC/T8djroQ0TJ1OiPjWnv/jf6yuLs8W7wmZ+wRB
	9jfsiL28iSj4De9X/JMe63Pye3v1I5LteMfUZYbGSHkPj+Gs4K6SwJzYXwyRXIWRcqTZg6QIpe6
	6mLfpLs2oZ2I40FHSGRNAELyiiJktTgMr6lyju+VYDASOFl1v25syxXf5dJD5/JTQI4q5J08iKL
	N0GFDYDswIobqSAY3eajE2jNbiSBDVKckOL7p5r6H+AFT5AGVTYpInXxYFx+Jv6I/jq8RDOTym7
	hMOduCkTBGJvyE2h78fxDvZGsV+eiZaCuSoH31d6htrDcLoqLJMhOjrXvo37ntw7+I5TOw==
X-Google-Smtp-Source: AGHT+IFz5usn++utfgGPhO9gq1mk/9/5QjFeW4ctKLdRoF13OqOyrbZp+OybEjHa+btTtZmlLJsUew==
X-Received: by 2002:a05:620a:4452:b0:7b6:785e:ce1a with SMTP id af79cd13be357-7b9ba7168afmr6610831285a.4.1735836355333;
        Thu, 02 Jan 2025 08:45:55 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:54 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 29/44] selinux: switch selinux_lsm_setattr() checks to current namespace
Date: Thu,  2 Jan 2025 11:44:54 -0500
Message-Id: <20250102164509.25606-30-stephen.smalley.work@gmail.com>
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

Switch the selinux_lsm_setattr() checks to only check against
the current SELinux namespace because this operation only changes
the SID in the current namespace.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 44 ++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5730138d4eb8..d9a1d2e075a8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6560,35 +6560,41 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 {
 	const struct cred *cred = current_cred();
+	struct selinux_state *state = current_selinux_state;
 	struct task_security_struct *tsec;
 	struct cred *new;
-	u32 sid = 0, ptsid;
+	u32 mysid = current_sid(), sid = 0, ptsid;
 	int error;
 	char *str = value;
 
 	/*
 	 * Basic control over ability to set these attributes at all.
 	 */
+	/*
+	 * Only check against the current SELinux namespace
+	 * because only the SID in the current namespace
+	 * is changed by this operation.
+	 */
 	switch (attr) {
 	case LSM_ATTR_EXEC:
-		error = cred_self_has_perm(cred, SECCLASS_PROCESS,
-					   PROCESS__SETEXEC, NULL);
+		error = avc_has_perm(state, mysid, mysid, SECCLASS_PROCESS,
+				     PROCESS__SETEXEC, NULL);
 		break;
 	case LSM_ATTR_FSCREATE:
-		error = cred_self_has_perm(cred, SECCLASS_PROCESS,
-					   PROCESS__SETFSCREATE, NULL);
+		error = avc_has_perm(state, mysid, mysid, SECCLASS_PROCESS,
+				     PROCESS__SETFSCREATE, NULL);
 		break;
 	case LSM_ATTR_KEYCREATE:
-		error = cred_self_has_perm(cred, SECCLASS_PROCESS,
-					   PROCESS__SETKEYCREATE, NULL);
+		error = avc_has_perm(state, mysid, mysid, SECCLASS_PROCESS,
+				     PROCESS__SETKEYCREATE, NULL);
 		break;
 	case LSM_ATTR_SOCKCREATE:
-		error = cred_self_has_perm(cred, SECCLASS_PROCESS,
-					   PROCESS__SETSOCKCREATE, NULL);
+		error = avc_has_perm(state, mysid, mysid, SECCLASS_PROCESS,
+				     PROCESS__SETSOCKCREATE, NULL);
 		break;
 	case LSM_ATTR_CURRENT:
-		error = cred_self_has_perm(cred, SECCLASS_PROCESS,
-					   PROCESS__SETCURRENT, NULL);
+		error = avc_has_perm(state, mysid, mysid, SECCLASS_PROCESS,
+				     PROCESS__SETCURRENT, NULL);
 		break;
 	default:
 		error = -EOPNOTSUPP;
@@ -6603,7 +6609,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			str[size-1] = 0;
 			size--;
 		}
-		error = security_context_to_sid(current_selinux_state, value, size,
+		error = security_context_to_sid(state, value, size,
 						&sid, GFP_KERNEL);
 		if (error == -EINVAL && attr == LSM_ATTR_FSCREATE) {
 			if (!has_cap_mac_admin(true)) {
@@ -6629,9 +6635,8 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 
 				return error;
 			}
-			error = security_context_to_sid_force(
-						      current_selinux_state,
-						      value, size, &sid);
+			error = security_context_to_sid_force(state, value,
+							      size, &sid);
 		}
 		if (error)
 			return error;
@@ -6668,7 +6673,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			goto abort_change;
 
 		if (!current_is_single_threaded()) {
-			error = security_bounded_transition(current_selinux_state,
+			error = security_bounded_transition(state,
 							    tsec->sid, sid);
 			if (error)
 				goto abort_change;
@@ -6680,8 +6685,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		 * because only the SID in the current namespace
 		 * is changed by a transition.
 		 */
-		error = avc_has_perm(current_selinux_state,
-				     tsec->sid, sid, SECCLASS_PROCESS,
+		error = avc_has_perm(state, tsec->sid, sid, SECCLASS_PROCESS,
 				     PROCESS__DYNTRANSITION, NULL);
 		if (error)
 			goto abort_change;
@@ -6695,8 +6699,8 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			 * because only the SID in the current namespace
 			 * is changed by a transition.
 			 */
-			error = avc_has_perm(current_selinux_state,
-					     ptsid, sid, SECCLASS_PROCESS,
+			error = avc_has_perm(state, ptsid, sid,
+					     SECCLASS_PROCESS,
 					     PROCESS__PTRACE, NULL);
 			if (error)
 				goto abort_change;
-- 
2.47.1

