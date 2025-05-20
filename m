Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A7527AC30;
	Tue, 20 May 2025 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742514; cv=none; b=l4sW3uGBpUvhxrX56PpokZJxiwpPEWCkUJUukbyp3004u4tI4AXWILFkg288YnFTsJBWopwW4yZ6ySxG+F7qzpPwfXzL0mcHaKXAQ6DfEWndD3JH74eHtKy8XL8ZfXjFcKzDqjLp1iskwV5FJR5HSu2Ur63PqX072eJaHAUEFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742514; c=relaxed/simple;
	bh=xCgJWuhAdk7fjHmF7GzTKvQo1ZoBM/dbQQfiJz3aG8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAUSmt0n+xbjOHSWj/O9tqJxMkTlnX5lTMNgs4q/7Kt3SjY3dF05cdfJq/Usa1JqpxIH4lpLUP2WxDXhBTMprX7EMHiO5pYOjYgzBTczMPk9FGWvYFknhYskz1ihQHbhXB5Z87CPB1VTAQhzIG1bEohON/90RPj7Hdf0Gz6f01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcNq2oxl; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcNq2oxl"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c922734cc2so631492085a.1;
        Tue, 20 May 2025 05:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742512; x=1748347312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEczguOl6nAWgItA9NzlhVqIdnL+Z2/RLUnt2nS2uhw=;
        b=KcNq2oxlUuLL6SUC/i9XfPvgZ7X6q6u5rVEj1aII2CUDUEYok7dPlR1qmai4jkIru2
         dmslueCNxIsMtOXP6I2g2lgjpKp7rVayvNCBwWy0/EthqDZXk9f7Hwkl198dFw+Xb1+7
         3cLlvpHG8LK7fp3a724XiJUGQeAfCn6VL680xc7Ffni0cj0zNl9HLXFOt/5rYU6LvUmg
         1e7R4S8URTFlNdZlXuSsiCJ7G2/eEjx6e9U9w9vjrfLDoHlXn3wqWqYSWChlrtr6e3e2
         yIzu+KDPiqaY8H2EkKZ6GKp86Fj9mSyyC96s1Hol2/xzoJmxl1OmPO3pxbX/DelJ8bf8
         0BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742512; x=1748347312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEczguOl6nAWgItA9NzlhVqIdnL+Z2/RLUnt2nS2uhw=;
        b=KM3F4Ev9OTQ0MXedUf2YaLye7pEPD0Fa/nkiSKYvcbjt1NX57ZFThoDQfOeTc+xQCX
         3NhW30AOm+3mt/RsvLON7ACz5XCc34U5nXzXBf0PbHUTel8vAp4qs+P7jfS5haH+25u2
         eNlDzLwqvkPLrvgJo56Q+6QSB5Gw0BV15xuquWDCzNu0tIb02eAkHsvAtVsAxCLtk22b
         dgfycwnIOuXSW5kg1UH6RMBVJ887OIanYHbqnJ4ePnmH+DD3kockwu8RWiNEJolodfqd
         6EATMrbDcWD3AZ7zXaH0Uz+Ddy3HxZHpradRQATQXYU2/bMQLaVIG8KcPUW4YaXFOk5j
         A1DA==
X-Forwarded-Encrypted: i=1; AJvYcCXNhOnz2o7hz6lEHIHvfTC0uwIZzvtDr+65aMOKhqFPO0stBU0YtduM+//QYTuQ4lWQ7e/ogus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2OAl1E5AI7mEo49BhSYW0IKtTBYjBzBAcCpRyg5aGfcxxVvVh
	kU8DAzkoyTPuCsLShHYclARBDR2TuTbJB/t5RE5aXgygUu3A5IKUlMUeET9FPA==
X-Gm-Gg: ASbGnctpChHpVcC1ZkI4IM7jKe7tKOH9JwrYW2DkmgvJ0ApxCCZfjdHRD8RXSHueiWY
	qsZjbr+ZVL9hJ4RVGUd/xXqZEVC67D55eh6WhZ7a+l6TXAEjcJNDhONtYRTyQSbVRxp+xvOinnK
	/kIBtn2sNXuQUOZ1f/BJWQRmi7TBnp00cDTKV8Vt7hBbwrhDPtXhX2PeFfIb3uiFE68i4rgRnTL
	Tk9tGrmaSgK6W8FwSBcofjbpY7O9VnHhITRN2DgPYeMwPZ5ywyYaN74tzsHuYm2eSRxyeDgFZHc
	0tQOKHVbKyAuAat3DfhSqugJVTkWKmJlEolwIC/wxXvcQJRZSMMIXLpVqQ8tbFeOetraPaIfBK+
	Xtsk9sG8ixBlHz7Zr7QHPWpu/DlEYxZWHJjKyAaCPEqp2wv562XmAwQ==
X-Google-Smtp-Source: AGHT+IHQ1jNY4NRFnYrsZ6rrRUh+m0B+F0eHZOZ0nKXzQQLOgNv4NJ57lv4KdId2205MuL+JRk/a3Q==
X-Received: by 2002:a05:620a:6608:b0:7c0:a1c8:1db3 with SMTP id af79cd13be357-7cd39dcc9b6mr3493938085a.11.1747742511556;
        Tue, 20 May 2025 05:01:51 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:50 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 37/42] selinux: switch selinux_lsm_setattr() checks to current namespace
Date: Tue, 20 May 2025 07:59:35 -0400
Message-ID: <20250520120000.25501-39-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
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
index 6368c3d5643a..9bcd84ea7c95 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6727,35 +6727,41 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
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
@@ -6770,7 +6776,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			str[size-1] = 0;
 			size--;
 		}
-		error = security_context_to_sid(current_selinux_state, value, size,
+		error = security_context_to_sid(state, value, size,
 						&sid, GFP_KERNEL);
 		if (error == -EINVAL && attr == LSM_ATTR_FSCREATE) {
 			if (!has_cap_mac_admin(true)) {
@@ -6796,9 +6802,8 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 
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
@@ -6835,7 +6840,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			goto abort_change;
 
 		if (!current_is_single_threaded()) {
-			error = security_bounded_transition(current_selinux_state,
+			error = security_bounded_transition(state,
 							    tsec->sid, sid);
 			if (error)
 				goto abort_change;
@@ -6847,8 +6852,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		 * because only the SID in the current namespace
 		 * is changed by a transition.
 		 */
-		error = avc_has_perm(current_selinux_state,
-				     tsec->sid, sid, SECCLASS_PROCESS,
+		error = avc_has_perm(state, tsec->sid, sid, SECCLASS_PROCESS,
 				     PROCESS__DYNTRANSITION, NULL);
 		if (error)
 			goto abort_change;
@@ -6862,8 +6866,8 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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

