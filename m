Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB427259CB0;
	Tue, 10 Jun 2025 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576214; cv=none; b=WptahKTRxzob4531g/CjNJd9C6B75+gGujSkx4d/hVSlJppwPyAdz4n48jjvyag7yjYfFSN8bt2ozpWj45biJZCVuFYE2UPfESMYOe8XQIDBCedYDnd9NimWAC3O6/RUTJawnqIzFirZW+PDsfXhEi+bIBDo/qBWIih7VO5ZnaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576214; c=relaxed/simple;
	bh=2F6DiUcZn83Wzuuh8tNjoH5y1UlibV7m9/YWmuJG/0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3pkwmqNAEqqW5ziB9xCFDgI0pXZqyV73RCKKyLnV1mtjR9Uqk6shUHvns+qNyDM9nXeQkE9c5IYMcPbq5znKDpwg+S52i1OqKHSXAzRx1jC5Lj12Ci8AnVCxenxSWm67xIFERpPlibfQxazo52dwf+jkJawCJdFHthc5vS5g9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhrFUu32; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhrFUu32"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d2107eb668so879207185a.1;
        Tue, 10 Jun 2025 10:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576211; x=1750181011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dlyIz7cqzhYxbl688j4UTLwV2O8ZoYGbfkMS/S68BA=;
        b=BhrFUu32rNMM1DKKB4gWqadFfKAoQqv4c5aFRSm6iKTxCv2EWjgpCakYcgBKVZUScv
         i0IANSfh48rWxgxxL4qVjAhNJ/r9viugg8BB1Pno0W4bjujB4pkYTPyNaCA2GVZ/GlFa
         dzfjfISxQoxGuiiS7XVGlwdDSZhlEZOP/vLckqz9v939nyEh1Wx9yxByrtCGhOR9QPEv
         d3JQf+laGANh4z+QxzW4rBm8AOog5pWE1DpUhVYYB8x9YxDppGl7TayMIokhjRQ3aYws
         XaiTK6JBl+zeqhEbLSDELpdi3OdFqt1KrLywo2VuyiUbBBfJVgtvI0O/C9Eui+P+LgIn
         jUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576211; x=1750181011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dlyIz7cqzhYxbl688j4UTLwV2O8ZoYGbfkMS/S68BA=;
        b=aX+ksOBVakC7I1stcM0biy2jc3GngknoHuOg9JcWfvIQ8UHJnpSUh4e6Ijy/YjQB+/
         BK9+SnKfuXzUaYyskeDApnR6K+RGnGupfG3lc0jcLPkHxGi5/+ANAQjFCq1GZUHkfx4D
         8NcQbPk6M9MpFzZlbUFw1x5byhXTmOXd8ySpZ6WxfwTHPUWlO/ErMcpBx0pyM0oabBE/
         eLfJ7ZnDBlCaG6MdWlyORU/U92y1UyV2sZMb71ilIMYqySSfAYtPCvyRamFOOUAlRyDN
         XEn5HOhrnuctCF+fzPe0OK8VvGtXdcK++3YTSMdb0ZikinenzqFbpzUP8lO9b5eG/fYA
         A1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWISQ+seylcgnMWUKpJ97kDcUkbFX2xoafDk1SQ783eZQ6KIWEnIlEdRu0HtCDlAFoh/oSQxE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfCYvLrtyhAk9+BOSMRJsCnZ0YQnZIl15yrAIQl4jGL8GEdxlr
	IxADZbwyuLIdRKqcxn1IemN7XG3/PXJ/KtkKoPlYMR/jDpuxF9mipX/EJvpYKw==
X-Gm-Gg: ASbGncvJjxCYYHhh7DLpctVpK5/px0agNv2ldDzL6xlnQM58A0UXNLjcb5VIbqqBfjA
	vUtQc7bCrrAm7S30qV5T2/E1m05Q2lgxeChpdcDDvzJt7+07WsfCmEK8djf/FfJKy3Y9qfGXP5T
	9JrtvkBbQOzBqoafl4SKzVKvLp+i35jRyDR/50qpYJVdHRe1tr50ixEZqQk+LVmhS/Hb5zna2hm
	kSIxaZ3bd9eZz7unl5X6fFfJZPSZyJoACunM8ZyTj5rco3+4acDg6I3Arui6PbC9OsnA4Dr2/2d
	yGzGUS0FXtPL8QLw052v48qhJjGKZEtN+/pIFQEd8IvS3jOmRj/ooeT48g6RdWweKAOU+unwDvw
	BqxYqJ050ef2a7eTKKHVygEQMHE/Sl+17vKySHHxWqJLY5Sn4zDPF+Eakgx+16jjN+Gn8toT/7f
	ge
X-Google-Smtp-Source: AGHT+IEa5A2+r5d6FDqBHlmOVfI/wKjVIFRDPf7BaHZnjroW/fllspWZdqJUVH+uTZVNPAN6HGKHFw==
X-Received: by 2002:a05:620a:370c:b0:7c5:4a8e:b6b with SMTP id af79cd13be357-7d3a88f9031mr30908185a.46.1749576211274;
        Tue, 10 Jun 2025 10:23:31 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:30 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 38/42] selinux: switch selinux_lsm_setattr() checks to current namespace
Date: Tue, 10 Jun 2025 13:22:09 -0400
Message-ID: <20250610172226.1470741-39-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
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
index 1c09f4012937..ad502bcc3e6c 100644
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

