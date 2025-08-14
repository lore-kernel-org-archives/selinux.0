Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0583093C5;
	Thu, 14 Aug 2025 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178063; cv=none; b=Vse6N/Wiygg0nXrzAqjM5xUBPj6yL3vb55Xyy1/BDJVqJGFEIldkHBR5zenszp8fagvP3SVBwrmbedl8pAZWj4rfHBb9Jh8k73+EnjTYy8nEZ+8piy1Six+9hy1eH5gn7+1ZkMw1EZOhI6ON7EB1fFBy7NTzOjmCr0nke60je8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178063; c=relaxed/simple;
	bh=px85H1bu7LmEqxzrfUCtwVROCgR2OAyHILULVbfiWfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYwFiwQooTIZGL27GxnlDnqNEWVW0wChYSitAVkAygFMEI29TPD+voQoB2QJPmZGA3R1xkV5dHrl0G/BarWm1joFys71fPOwigwOcUflsVcmiTEce5CPUEWAKFTZCKGqO3/iuztG7Yf2HLg+mqx4sJH4B+d415ddJ/uDzgMYcdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQAK8GZQ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQAK8GZQ"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109bcceb9so9486021cf.2;
        Thu, 14 Aug 2025 06:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178060; x=1755782860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2w72d2j19eM7K8PKiL1t/C0diNvUgAjGs3Std0ImcI=;
        b=HQAK8GZQq/ZasYRW6HqXGFbueKWSp96jWm4q6+MWlFqvJhcDN/0lR7ZQm++cJ8sNUo
         XBQLvZF4hl0pPNesLdNIvcmdl/iC37ZuX0uAuaxg7PqyZF6W1cX+MRn2jATHKm/nGEle
         Dv/rTh9M3eh+XT/JTO+ySkYJ8wviqIYN4af903ZyreHxxSeVgOmsXCrjFRTL2g/u47Rk
         9XFMRuC0ji7dLmmZLfIqHAmZT0Nvo4GIL2ugswgIYIlHAr9Qrq7Vt0X+mSyBNMOE36kj
         5NURBp116QDl/S3bSu9GqLkc1e3cAjKBryc/xQ7i0vfsqk8vr9dDQmhYRxICCGt06opT
         ByGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178060; x=1755782860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2w72d2j19eM7K8PKiL1t/C0diNvUgAjGs3Std0ImcI=;
        b=q0k08EIZq7PRBSyr69pRz8GQCopt1j8rwXTPd0mPF7m6+wsxTmqygLiDx109X9rlRy
         EkusbUP8ntiybRHHCoDCgbg7pUZJsctaUieJ0xyA4a9l6XLwzJT+N/9e9z5mC5wSesWk
         DvUhN5fifrCwmmKYHiEnd42xJkwlmLypHwIOxV6u8jZ+xb3A4BmgJ7vUGEIZ8bxMDDse
         en+wNSCu15AdkFI0H5OLxz2qXuV6UjEP3GvHWJ2BxjjvIEsLnfwFDr6AeJYwQxb1dSkS
         M5ij8HOfmUQo+Gi1NkoTLMfWsG8EaTsmVzMTaZqVXWskhuNGAuEcatO6/FJAPkHIuJ4u
         4Gkw==
X-Forwarded-Encrypted: i=1; AJvYcCXCqMkZ92sLrIOJUR2KyaL8MpvxZ0kj6wQ7ph9X8JQApemhP8txV+ucS+OuKKQgBnu1Tbv0aMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxryyBXms/cLcC6TwOEZxJ6ABsYi1mJBNzHp+SbYXoWtNK6mSNr
	iblvRZKreXT0qCdUSM5lnmL0ZTsdUvSmjwmWfkJBg2bYojEq+BbTRUwPYzvEPg==
X-Gm-Gg: ASbGncsExZ8Zy50yiZsQpHLGFOognwxH1yS1XwKUiJWGh1Zgv1rZh15iSAAZj9j6ddA
	Emck2B0yo7gn2ZenvZkzkejka/LnVeMIK7T1pHyQOT3+QMQgGeztfvh9HpFguSr6A0cIZAvyPUc
	sx5B4gCbBr+AEOS4H8UQjiSCJoXWLXWb/d0iAC8Juv7xyV3g1nd97OpZIhVLvshVjQ1+E0XKZkn
	wgWap0oWSdMFmdeTeKKjDpmevESri2S0y7Ysg0yNivenrtTJIlHioa9So/H1XLCsuTvqUJUp3a6
	8wWZjwDMudfZkuqUkysKqCcAK2Z5xUbSlYeQsesccWzsD0hySRX1eP557mj0XuLzD6W36ilNabD
	cyv6Tnmo3HQqJ7XtkxyWJimDDNxKi6ul7VyDsahgBHnRUkWuGIqXj/yhnTQqnIBYgCfDyBGzQgL
	O7bRE33hESW16nn4rLjI1ZhnjEqw==
X-Google-Smtp-Source: AGHT+IEnxlfv8OAfDflL9Xkr7MigQAg4KnaYsEh1bajNxiIYuq9gcYBPD9z1fh+jFPd9uaAfbr23PA==
X-Received: by 2002:ac8:590e:0:b0:4b0:7950:8cdb with SMTP id d75a77b69052e-4b10abcaa14mr39789231cf.31.1755178059995;
        Thu, 14 Aug 2025 06:27:39 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:39 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 38/42] selinux: switch selinux_lsm_setattr() checks to current namespace
Date: Thu, 14 Aug 2025 09:26:29 -0400
Message-ID: <20250814132637.1659-39-stephen.smalley.work@gmail.com>
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

Switch the selinux_lsm_setattr() checks to only check against
the current SELinux namespace because this operation only changes
the SID in the current namespace.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 44 ++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e35b3fb16bb8..15b0dd725f76 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6721,35 +6721,41 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
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
@@ -6764,7 +6770,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			str[size-1] = 0;
 			size--;
 		}
-		error = security_context_to_sid(current_selinux_state, value, size,
+		error = security_context_to_sid(state, value, size,
 						&sid, GFP_KERNEL);
 		if (error == -EINVAL && attr == LSM_ATTR_FSCREATE) {
 			if (!has_cap_mac_admin(true)) {
@@ -6790,9 +6796,8 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 
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
@@ -6829,7 +6834,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			goto abort_change;
 
 		if (!current_is_single_threaded()) {
-			error = security_bounded_transition(current_selinux_state,
+			error = security_bounded_transition(state,
 							    tsec->sid, sid);
 			if (error)
 				goto abort_change;
@@ -6841,8 +6846,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		 * because only the SID in the current namespace
 		 * is changed by a transition.
 		 */
-		error = avc_has_perm(current_selinux_state,
-				     tsec->sid, sid, SECCLASS_PROCESS,
+		error = avc_has_perm(state, tsec->sid, sid, SECCLASS_PROCESS,
 				     PROCESS__DYNTRANSITION, NULL);
 		if (error)
 			goto abort_change;
@@ -6856,8 +6860,8 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
2.50.1

