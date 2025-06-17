Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD9C2F2C65;
	Tue, 17 Jun 2025 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169214; cv=none; b=QEmyTV1jaA1Y4jmHOIfMNFORoDsmM3YgjDM2l5yhkb6c7F2g2JKbUxbbmklxNkMyCMX1uqsbSEFBCq4R5S6ZbAndoICV7AkwASVRQOy8qvS+XoZWYn297PuLH4zuBJ9DWiMmPZpjywvKxFNtNjTuGCpN0++s3vcP6wq7a7cOlNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169214; c=relaxed/simple;
	bh=ddaSzyi4tO+6sW+HNK8noKB7YZDbPSSBl1I8Dbqa/74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsGQQHXL0Gj8ubxKVNUtMcAMvq+3T5OsDCx0aljLPqUczHcGL127/pSwnU6k27Q8+r071W+jh8SMqFCn6v9B92z+gVdHUzU/Yrtz/wVoLfj1W6IfhUP0r6G70E+C32P+NQjjNk8+bI2bcYgo8VEUbbSLpQoeeVPtd3wCWWQWdhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1e0TEqf; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1e0TEqf"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d3862646eeso344737885a.2;
        Tue, 17 Jun 2025 07:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169212; x=1750774012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2xCWQnac4NJitog/nymRYN6yKz1wqreokZHWRlOwmE=;
        b=G1e0TEqfxM7n0KjybxQc1YAhKOEqVVTRbNbmHbgkvnDzrfX5ygeG1SfmpwvXjLY1be
         zpanfwBYEyoq2TNdYpMdsMcYCscat85ro0ePZJ1+qPXQNu6M0RQzauEEOADnsg7ckPbm
         PgmLVzl1PNTR7ErMngoGyYvmurxfUCXSxuv/YC8Qr4Svl70VK1CQwri/kiv3blFr10nW
         Q70cqAaYWdU1lBAuozVvKyfFUDZ37r57V8J74MV0c/2q/YYh3JBmHgp3DzLCgMDIwnUW
         WrVoYrsWdVw0Dy63q8+Mmnh59Ms1nsmRZRtDJ1n4NSFz73hmCQSZDhxdDHcItMEsqGEQ
         5lCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169212; x=1750774012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2xCWQnac4NJitog/nymRYN6yKz1wqreokZHWRlOwmE=;
        b=G2py14N8DqZqC1XZCw5kmECt70lS7crf01D+1RyH/H+KzTB+qvbeglNzQbjjdepcrh
         t9ZBgKFjeFeU81gdnV9rB4QFJgh50CmbG7E6RDAQ/WhIDhaZzWzuTwhnowzujAJcutQ/
         ZlRyf4jfkZQiyhk7EZK9x/0DRBKvRiKwVrXuBHdUYi0I2je1uVRDC5nM8yRFy2uhdUYZ
         oqqdSQWp8u7VPLs6K8ZvgT61R5Wi72atuQAz/XxeM+24kyVZb+7sdUZNeqEe5IUbpCo6
         E5+UwBd797MtWmBrW9VrSy/o1ODfSuPSAAdblLoxBpnje9xUG9Yqnp96/gaVw/caxxCW
         1jZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWubv3yH4RQWRiplMdMqJJdEKlw4UXF0ehYaL5MqvzxlSKnX9AIDI6dm2xqzXuChuXK9RfnuZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpfz7GftXQwk4HHNaV8aCVcoN99M4vvehduve1f0UWau+M/Hor
	dAO5K0+XNX3vrLJi6/ZR4gmW9QVXhWzWeSz7RZkiU9kLEkRQfgXSKstvwQa6cA==
X-Gm-Gg: ASbGncuOZsdegYEd7tFOixstfMY4vRwbxIhBCcsafvkZZdlonwkVbq144WvFnoDLmtK
	CS/FXTfLDp/qACcqkwCpBFtDaWJW8VhLKq/ABOQa0LyPq7xN8Iw9gc1LhuOhvTye4IovAKY8gZc
	L+IDQpMc/97DseePyeJqEEjO8NV6ttqC8/8G94S92iYc0Jxq+potPQ+wz819Ag9tozw/oGL1OVt
	3/yP3AXWttU68qH5pTAYWzFH2PIAgSe0TBihsT+Lk9vfwyqMKE8EjCVJfFd8qfkFT1+sCeiuXAj
	b3GWz0UKTYe371MdKpS4QsVmQK9kQR7vW64CEyDUrOf/ZPbs1Zz5rIv0feuDxXl6T/mcASJSqZl
	IWtKvil2KVx9KVusRUhYCEhhmgsNmTNan8YsCzBiWJHGVfVF0PZ8fP5Rj+0MRy/kgpQ==
X-Google-Smtp-Source: AGHT+IE2hb9wSLu1qT1950ifXxhmUu+L/xRKjt10NspPgRdPN0YalOw4nZxLG8qDqsxPMd2FVfso0A==
X-Received: by 2002:a05:620a:4008:b0:7d0:a1da:3a3c with SMTP id af79cd13be357-7d3c6c0c79fmr2082942885a.3.1750169210411;
        Tue, 17 Jun 2025 07:06:50 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:50 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 38/42] selinux: switch selinux_lsm_setattr() checks to current namespace
Date: Tue, 17 Jun 2025 10:05:25 -0400
Message-ID: <20250617140531.2036-39-stephen.smalley.work@gmail.com>
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

Switch the selinux_lsm_setattr() checks to only check against
the current SELinux namespace because this operation only changes
the SID in the current namespace.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 44 ++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e79d63e923de..2045da8b2b85 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6697,35 +6697,41 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
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
@@ -6740,7 +6746,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			str[size-1] = 0;
 			size--;
 		}
-		error = security_context_to_sid(current_selinux_state, value, size,
+		error = security_context_to_sid(state, value, size,
 						&sid, GFP_KERNEL);
 		if (error == -EINVAL && attr == LSM_ATTR_FSCREATE) {
 			if (!has_cap_mac_admin(true)) {
@@ -6766,9 +6772,8 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 
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
@@ -6805,7 +6810,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			goto abort_change;
 
 		if (!current_is_single_threaded()) {
-			error = security_bounded_transition(current_selinux_state,
+			error = security_bounded_transition(state,
 							    tsec->sid, sid);
 			if (error)
 				goto abort_change;
@@ -6817,8 +6822,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		 * because only the SID in the current namespace
 		 * is changed by a transition.
 		 */
-		error = avc_has_perm(current_selinux_state,
-				     tsec->sid, sid, SECCLASS_PROCESS,
+		error = avc_has_perm(state, tsec->sid, sid, SECCLASS_PROCESS,
 				     PROCESS__DYNTRANSITION, NULL);
 		if (error)
 			goto abort_change;
@@ -6832,8 +6836,8 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
2.49.0

