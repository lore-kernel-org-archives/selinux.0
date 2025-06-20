Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1015E2F2346;
	Fri, 20 Jun 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441551; cv=none; b=SmYAdqA2+dNtc6DjBpdogm/x/U8CyKrCgsPgX2wNUAOIDTjwemS059era8vkMLpHR7XgWqzeZrrQP+7nCMqldvyf2sF+yGXBzwogh1mupD0jxQ2AJEMZ/9m4mL5EewdjVE7i12EdvXT61pjfucafg/nclNd83sOJd7om6qmipMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441551; c=relaxed/simple;
	bh=GBUzIdbc+GKGAxCGhmqqPJi7eGsJ3NdmXSuRF5aJqkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZNAH+sN7XfcvrGbgtazoq6mUwNlvzCuFCKJUu63KnGqQ/zJpO6m6NvKT/0NtRhfHmeoZI+kAG23y6eQn1YjpGhNqFOTrL9ovhQ6HnMv8zm3LqBDWGrP5HoH8Oosl/evAO/GWCrOG8nYGY6zk0GPEb+Dlffu24QJFQwWsvKm234=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz4P3SL4; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz4P3SL4"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6face367320so19862826d6.3;
        Fri, 20 Jun 2025 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441549; x=1751046349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnN3+Pa1lv4RV6WZeYpCk0GmjIVDI17wUTFCx7hwmzI=;
        b=Lz4P3SL4IRQqvWFF9ySFh/Z4sehTj/gr/MfTkA7XufQ8cuz1zxbZxFMKi7jRlYiFXP
         Ctb8iNPZpZ2uhKcPBJHazo7BOAF1NCp/6f6NKZy+P8zKWHkREmACT3JRt9P59sX5WYFZ
         zRt6RRKuN/hS8rgUiqQxnS9hEO/DpKJRaNpEXRaoLgJX8s4PAAf+RcKH/VYVaRiJsWjf
         GkviLr/I9IFvDWiCBKU1MMEDdE68V/geJkB74+PD8diwXtbGsAKIPzcHNHMbuFsHa3NG
         OAbOTZ7+0S4jtyy8SAYW3Gg8adNICWHYZnlSXVVD7xvo5tTISq2Wp9MqQ0ZdcxmS4vyJ
         FmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441549; x=1751046349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnN3+Pa1lv4RV6WZeYpCk0GmjIVDI17wUTFCx7hwmzI=;
        b=jxaOCi4vMTOhXTknj1by1jnZeP6MaLUD17pKF9MGSl4bEURinKXx1qzgAT3Uo6ojlH
         TV5DTcCFTejPtMxEnTkFSGKpvDNVMOiu3qE5kL2Nowpvk/3Q6j6+VYkRIL28qaAs4xx+
         09sD6T0dM9hMiXfdXoNIV0Vvz59EfpQG6gOlw3qyJGyq6toszofIHju0tJ1j38VErus+
         WFx3EjoAWp6/l/3KJduvSuGDQyr5XzK7vUk6jNX0rh9TUHO/R3zoa2p70rjs5BkBTepY
         nPq5muWuf1aMbMGlN8VXYDcubpqPPtaWMKWauhavtz/PpK3vx0MDWeP7I/StG7SjvDT5
         Fb6w==
X-Forwarded-Encrypted: i=1; AJvYcCVGQ6ej2RkjY+yE/B9exoWRaI1URia1ro2rCIhTmNYENIb1Q8FTco45UNdKD1cCS9O0fmtxs/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzav3xpWKT8OulMwxo2vKJEMMeXkntdehKJOCIUYYl65kGTbybU
	Ru+z+tmClfPwiLyYTikXm8PdBpL9TPVKBq6ZzAq5esEcpqgC4VuPb6o2KO1iKg==
X-Gm-Gg: ASbGncv8mgyJ77pwX5XAEtmdavAo4+S0XmTAbW94S5TPjdJ5+NAXzQ89bl1iXNITEqH
	Q1f5XyuEraTjzkFj05IkdrCymM0yaczzbsXmpnDtnD/3CKgX0mLvdbUWQrXJ4X7I4uooqifkLCZ
	yJnq7x06WSd+ob8vNQryORq5Ol9DNpQozJm2Kw1O/xBxTIgbgKpn4cwI7pBzkfWGlfxmg6XrrZ3
	/EZFcxnt9AqgJY66RzTW2Di0ox0R2vmJtDYo+6r8WayPA/aijEUeRboyIqzJqlt9ZzrOcoiAy9N
	RpWO6dPqJFyvoQ5qvjvE669GgUhWilri4j57iSRcigfoDL41p9APuDm/j8fzVN/UdUfgYRb061+
	WGi4My5HgAlH8/Yj/8ffcWGkBA7Wmlcwcl4r42re5kqDBpBd9bOWgMu6XTCwM7bJv8AqVWCDjAK
	qa
X-Google-Smtp-Source: AGHT+IETfsTfmTQGr47ZpkC8mNXH8/ywSLEOHquzcL8+8B6vvSelTfgAe2gIpz2HGk9Ku4FykNctaw==
X-Received: by 2002:a05:6214:540c:b0:6fb:15e:6d71 with SMTP id 6a1803df08f44-6fd0a49525fmr65582316d6.12.1750441548762;
        Fri, 20 Jun 2025 10:45:48 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:48 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 38/42] selinux: switch selinux_lsm_setattr() checks to current namespace
Date: Fri, 20 Jun 2025 13:44:50 -0400
Message-ID: <20250620174502.1838-39-stephen.smalley.work@gmail.com>
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

Switch the selinux_lsm_setattr() checks to only check against
the current SELinux namespace because this operation only changes
the SID in the current namespace.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 44 ++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fd5a1b53b612..866a9fdf7522 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6709,35 +6709,41 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
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
@@ -6752,7 +6758,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			str[size-1] = 0;
 			size--;
 		}
-		error = security_context_to_sid(current_selinux_state, value, size,
+		error = security_context_to_sid(state, value, size,
 						&sid, GFP_KERNEL);
 		if (error == -EINVAL && attr == LSM_ATTR_FSCREATE) {
 			if (!has_cap_mac_admin(true)) {
@@ -6778,9 +6784,8 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 
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
@@ -6817,7 +6822,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			goto abort_change;
 
 		if (!current_is_single_threaded()) {
-			error = security_bounded_transition(current_selinux_state,
+			error = security_bounded_transition(state,
 							    tsec->sid, sid);
 			if (error)
 				goto abort_change;
@@ -6829,8 +6834,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		 * because only the SID in the current namespace
 		 * is changed by a transition.
 		 */
-		error = avc_has_perm(current_selinux_state,
-				     tsec->sid, sid, SECCLASS_PROCESS,
+		error = avc_has_perm(state, tsec->sid, sid, SECCLASS_PROCESS,
 				     PROCESS__DYNTRANSITION, NULL);
 		if (error)
 			goto abort_change;
@@ -6844,8 +6848,8 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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

