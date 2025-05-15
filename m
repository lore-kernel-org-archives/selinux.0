Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D46029A304
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314643; cv=none; b=XPC+1ehsuZebA/WuS6tt6ybjKPLPDVhoQL2y5mna5mbAU1BmPIwVHPvUP9HdKUEKx01uVnbMbIm1cqkdGQPgEH1L7mbLk7oc7YmwtnVZOPerQTaK6l1J6uaWsjEjNk1qkoR24WMM9q6xS5t9q3NM+KWe6EVTWxlesJRQ8fkcgpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314643; c=relaxed/simple;
	bh=CnGPD+Sshgge95krPai/soEAfe5Db9gnpcTtfn9Qdzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmyHY83C6Nsmp7L0HZK2tDWEzpVj9T5nba1v4WmJHaLW8v6USD0bYRlV7Q67FLysHYsuiQLNAvIJukVs9QV8xX+sSZEefMyjBFGXroZhgpcKfm/vRq61S7Y8dPspOfuOI6829B7Q7a/XkHO77fMrXRvlmmb4DNZczSn8hJqAa/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+6qupb7; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+6qupb7"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4775ce8a4b0so14051881cf.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314640; x=1747919440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GKH7gCmF7PVeAprDXsieaoRawHj+6AtuENwrX8Zhto=;
        b=I+6qupb7l0cvtcozxrXq3UNPcxJb3B0+0s8qE+McmnmagGvlzGiGtnaiEOajrVGGYB
         4K6CQccUm2oFmr51HZbTeITHlFvt1dWqI0GdnE7hFQzsrE0n3amy/Ga6MfMzkB4uafzi
         zyu6yLeysQloHWIEdwF6nV0zgyb6Xy3p3Q1BkAKTXb6Vk5g+yT4ldyRjOM1IGc/kQBu4
         +XIvkhFNGkri/8C+gLcuI3afRRPb7+SfIcuq1/mCJ0JrsMF3uKnEHazbsOhLrAn7YrSZ
         ZDhbz+PYIP/v2Dy1WPcl1G+frsafRAm9AVFnQFPktWZSh+gRrUQE+jlclAdDC2jwCPV8
         N/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314640; x=1747919440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GKH7gCmF7PVeAprDXsieaoRawHj+6AtuENwrX8Zhto=;
        b=vEvlXTyBSxwjpXDjtIA1xOnSHv30x+dEUbLF2YYYAUxW4K6GV4a+Hcp8IaasD26ZoL
         TqRLfJCLWGnynHYzynKZHSh0CRxL1wdTnbGNMwAqYraTUVSEAYK+3ZoV1slcXmslAfIX
         1+ED21SpLwH/0wHlJoYVxMHFWodZYrz4mu36Wbm7vS3ykTyUTIbvUdh7Iney7+6+Rl+D
         f7n4AhxdJZ9OIAAJAg9SpuT2tVbsITpTnqtDvqftlb0vJ70yc3QMvOT0MDSWZg606ngy
         C7JwyEAU8efhQV6YVYXhDtolTu+pglbbKN+c2vAHP1oFTT8LlsH4KdDtNl1GJGoL6rvD
         +t0g==
X-Gm-Message-State: AOJu0YxE9cXOBXvgaMOV9qIF/SarLPl1gLCJ8D1xWfdMGcvx+IeauhWL
	Fq72b4cMUg3eaSqTZCB+Yp0qirTupTeDjGfpTSTA46aDXPmEKTwQhi3IYQ==
X-Gm-Gg: ASbGnctIjZQUAGbwDoknWjZBBDghX/GDJhClsrehpJW3xQQr41ZA2U1Yrs8OdwCAW31
	2W6X0NHccJaKCGjZzD9VGKXUbDREFZRhY2hE5fPUGXuXze0Rfwxb6f7QSpAH1jLYMGXShip/5XV
	e9dq71KyxaWsveprELTRDbSTktYkKMjI4YTTY0G6CARDzX+AxOiJWxCQh4PTFAsv5+F64/yNQsW
	PbhQXXRw49DKcU2IIjJVjWKTc3JZMlcv8zGaNk+x4yI9mBUbHDP21fpRmFHUGL9Qm9+YgVX+y67
	dFMA/zQYmH939NHT5i1mn175XFr/07XosGNBysxn0UwsqyfNSlD0psex82lIiWsZtqsxdha2m/I
	Su49Ko4Ls3NexooDcLBe8CZVSNJ3AEAjznYpAonyR4G9mfnXQaM/71A==
X-Google-Smtp-Source: AGHT+IGQETjPaVUyMs1WCFTfUPKtV8QinVL7dWnwq2P+DUMLQEpIuQvFXj2vssdk2b7bblAHb/oIPQ==
X-Received: by 2002:a05:622a:a10:b0:476:6a3d:de44 with SMTP id d75a77b69052e-494a3303de2mr51437901cf.18.1747314640142;
        Thu, 15 May 2025 06:10:40 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:39 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 29/49] selinux: switch selinux_lsm_setattr() checks to current namespace
Date: Thu, 15 May 2025 09:09:27 -0400
Message-ID: <20250515130947.52806-30-stephen.smalley.work@gmail.com>
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

Switch the selinux_lsm_setattr() checks to only check against
the current SELinux namespace because this operation only changes
the SID in the current namespace.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 44 ++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 383e032cd536..3c410ffd6c52 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6731,35 +6731,41 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
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
@@ -6774,7 +6780,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			str[size-1] = 0;
 			size--;
 		}
-		error = security_context_to_sid(current_selinux_state, value, size,
+		error = security_context_to_sid(state, value, size,
 						&sid, GFP_KERNEL);
 		if (error == -EINVAL && attr == LSM_ATTR_FSCREATE) {
 			if (!has_cap_mac_admin(true)) {
@@ -6800,9 +6806,8 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 
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
@@ -6839,7 +6844,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			goto abort_change;
 
 		if (!current_is_single_threaded()) {
-			error = security_bounded_transition(current_selinux_state,
+			error = security_bounded_transition(state,
 							    tsec->sid, sid);
 			if (error)
 				goto abort_change;
@@ -6851,8 +6856,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		 * because only the SID in the current namespace
 		 * is changed by a transition.
 		 */
-		error = avc_has_perm(current_selinux_state,
-				     tsec->sid, sid, SECCLASS_PROCESS,
+		error = avc_has_perm(state, tsec->sid, sid, SECCLASS_PROCESS,
 				     PROCESS__DYNTRANSITION, NULL);
 		if (error)
 			goto abort_change;
@@ -6866,8 +6870,8 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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

