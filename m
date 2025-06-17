Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9389E2ECD15;
	Tue, 17 Jun 2025 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169203; cv=none; b=opOGemw2HJng7Jud+cRmkiv7FJ12xN7ck77+MSNRGIGlbOvtUl70Ble58lkPfqqe1ppvjOrVeTB19iC6nIQllb9WU+TA92Hhy3BXCd8lk7jK6kwsqc/WA3vVmRcjLAsror8cle6uAt81SBkHTlSj6JFhNOn92QTZAtJzy6Oq8X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169203; c=relaxed/simple;
	bh=So1KSef0Avi3kmR6eI9vd+epzvOEhILH2Kazn5i4SUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHcq3SgnYmuEAHBz7KYgMfHMgGhZ5WGiJNfs2PJigsgt+oJzKCHiQxHsXDk8B13P+K735v+p5wiBFl2ehGrJs9ZeGo46NVbRumebUhR7mMMCRjO4gdOaBFsFzJTvszqXtKOpYymRUbcp73KTdf+8YxCpR5PLBz+AeUpafASD38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcELC16C; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcELC16C"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d0a2220fb0so682165385a.3;
        Tue, 17 Jun 2025 07:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169200; x=1750774000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G00l0ZFw41yYoFrtIqTX0R8TuRDQOkIk7N9w2MX3ivU=;
        b=BcELC16CQoKBRXm6MVR7/3S3/4vn8AVZF8x6VLUo9w/PP4odk+FRqbA25dTcu3LFZb
         24VYU2TjwGP0Y06iesgEsZkH60wIUDbg0BA5nNXsjTKkXNub71/njo1+wZgqizTJxSWE
         HhOB+0BQjyCbWIH46Ml8QGzVpQiMlWwCmysexLTj+FpkU3UqNIQg2TlDmFpY5qBszOxI
         Bbk367mob1dEfoJMRmFwVnwPCB4J+R1NKqzjf+1fwEW3ikHrSxh9OGYyF6u200KItoKn
         F7dlQJAQouJIW+D1s/O2uausOMTqeK/kO+gMpYj+iFSwZd93xiaspjk3fjktlDeBqbBx
         UU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169200; x=1750774000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G00l0ZFw41yYoFrtIqTX0R8TuRDQOkIk7N9w2MX3ivU=;
        b=RC2Kkb+G8jJr/sSE+084USjnOQjZDCALjgzPGvq8I8Bzq5LjVyZbx2+yaITG9LThqu
         gqYLC76DHRirDNnJcxl1LPYWHRdDaUVfhQ1O3SmRtQ4tGGOC089ydwgcSZXHbx18ztGj
         uGqins4akdwfI4sHNd0G7NhT2Faopk9NTKKLwLV7VWLRfXeCkmDXqtffO5eOmidkCH01
         8k8I2w0KTHyROmJ149B7AMFqH8JRv1/g9DsjsAYCveSpbeFFh9qBl9tiB/QFVDN7toUs
         AL6NEmz6UioI+HZqtiopCta0nonDkxP0A1a98dstekN1E+meKW7bH5ig8arVG/lsm/00
         yydw==
X-Forwarded-Encrypted: i=1; AJvYcCUKvL30M0Z4EvL4vfhQdSeCt0C3S2DNfNc60woTsGrn4SLzKHWxYhaXzsJbq/bEwlRKneHAjd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB4Q7kS6vWfs60vhS/mwjc3yh6Jm3gbUhayqN7NGPT60SjaH/G
	cIiEIv//J+YZID7FsFAeLJgRMQudR5tltnpHerqgW+coak1flgsjid2XAl+aZw==
X-Gm-Gg: ASbGncs3cJY7rDHos6nEustEjvatMoVDpouaG78P0ulXDqASR0sgy+jM4rU0uE6h7zF
	iL6dbZqzsR8iAORFwH99DbidT9Zv7uUPAVOPxcrXy4iKsczYTYs5moHpVIaGFBL+Rm1a1BWHlaD
	UT2ABfd9hig+Y/fcIz84J+uFoDvytRYAMrzCtb5tw7aB4zq2xQfProCRp0ehUpbY4ebxpYxWdE8
	SKvYrw87JVwsfcE5SFMWP21pl/9Abb/a0+qAjOFulx/sgtvhvTOgy+R+iIYlhfY0xQR92zWTUtV
	2LAP8a5rtqDtuvxUB3BAgYl9zOmW5KDPIu+SQqNQ5tYV1SWKpJFzmEItmkmafBbsc4QQNNnHvOc
	/vzK30yGEM52p6TB7SKVIs8IrWdz6JlHFDHUVqBjA6CdnLL5id1KnELfO/uXHOfFLtrwATwtHbL
	yn
X-Google-Smtp-Source: AGHT+IHNSZ4Sg8xmpkz6ofy+k6ZSho6FKNvxR+/rjQYqIPP45mOG95GZzLY0rNqmoKCW1bYUm1xkZQ==
X-Received: by 2002:a05:620a:a107:b0:7d3:c8ba:a9eb with SMTP id af79cd13be357-7d3c8baac23mr1891233685a.40.1750169200056;
        Tue, 17 Jun 2025 07:06:40 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:39 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 28/42] selinux: update bprm hooks for selinux namespaces
Date: Tue, 17 Jun 2025 10:05:15 -0400
Message-ID: <20250617140531.2036-29-stephen.smalley.work@gmail.com>
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
index 860f1ff2231f..d088cba8d6aa 100644
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

