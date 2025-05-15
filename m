Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18DA298CA9
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314646; cv=none; b=VOEDfT2JKyR+v4hFfxmbLrK9463D8wKSvaxE0ZP3F2gtZps6ZPH8N9FfRQ11HHG9p0xFXYy9t9FtNy0GCUzNkgVF24TwClLvEpF7RNYsPSJc6ttEKMOgydSdtpr53BE45U/7acjhOur5yzZwcArIR3TpqHa/UzJCIrM8+ppnlzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314646; c=relaxed/simple;
	bh=J8SieK50+GE1hyeYFYher71tfgsV09ACQpwcoLQAPbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFRYO3GaLZ0y4h9Iiq4wSyP+7XlmxgHEzuFGaY1PsvWKhfDpQud8IhMLiu69XwM8PZB7zhqDIrmhx27UO7LkDT8oEjHWmj/PpFoSJLjL0I3MxLDVcOirbJJnlatce1HIzdxGX9PUVhpIG6LdQPPAhLq3qeWosluxCZb1cV3r8BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWoRMool; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWoRMool"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7427a4def77so1035590b3a.0
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314644; x=1747919444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mprMBLXtn7cr5J+FcWPCPmtIWgoY2mmuzZ02hJHZpDI=;
        b=HWoRMoolxnhaXrXH01BLDGE418tsFqBfTmQy4dLRaxkJ1C92+ZQdkHfNA+y4AKGp28
         715NJpJ3FJieznUUtw2CfVDTY6ljY3iiHJUO2kJmSDTB7yfk+G/OaUw1FjUDwcYaDEj7
         AM3BorU0Ho1cI5cXG2qwO/aVym3Fz+0TEef8JE22UPNX5xBNEWtad4XcDakodcsu3sGY
         MVYELMmTUUt/mwMEZFgEn5ob0VGTEfiTUyjDb2Mdnp5zL+hJIq4AbKdZrLHgfmFl6oCs
         FffyixGv6thoyCqjXg4l4h+0zFyjW1nXlyNv8/cdBA4/XqGsN4IwnCMfUuH2bFSMPz2p
         +OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314644; x=1747919444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mprMBLXtn7cr5J+FcWPCPmtIWgoY2mmuzZ02hJHZpDI=;
        b=UXBTQsI7czLqTavod+Nz5BScU5jVy8obwkTPK8zYU+zimgPDBSUT9qhzupNiVXTyCk
         A7BAwuYDb2JkHcExhD1xLqGRdqBwQZcCMfeDHzOpL+AX8mvmjayo54G5mmaAKH07YdLE
         J2tlAxH/K4IOiTKXcgQ7lkLuPwQZ8baZ13LLgZcoo8d+bAKiu6HrUHtf8sSr3nkk3Lv1
         +ejtDGnvvtHL4E5cP8Vf6OjPd022nNRRtsXL5GY0UgJ0zJpEXkjD6dC61LnUNC5ed9ru
         L1AIlqPGaRIidjbXeN1/JqCi60uo4vyNwqusRu1Mylngp3ZYyxOCM+ii4iSVhcovN/N7
         R3Og==
X-Gm-Message-State: AOJu0YyYOocKCToGrBlXG03UMxAgaVn6OxZi9LqxtHSkivv666YizTjA
	31mZx4uaSyzFNr5lZIiC6XB+Fn2g9O/qn/eJneGO8jut+0DvgZKjtNwO9Q==
X-Gm-Gg: ASbGncuYXAQLVynT5TIVsGsdCRhjzJeny1u/0sofCYyiZkGhaofzb42C0EbmwEpwGMW
	JlrrXQqoWAx7Gg4kHl4X1LLcWF9muoUoaLS+Fef36cy1ML/aLyHY3QZVLy+YfXgOxN4WuzPHFw0
	Pe97bsrL3Y1RZWt4ld0YD8MfO6J0WoC1y32ZYoEK5ud/+SykpMSBMnj8krjZxEOhXGIstsSOIPc
	+MocREH8tH8V59SxskHhQthaKZwwwpEFbduOoEBh0Tn76nq6PcfZ6fQe1WPHhEj6Kw/mI/LIxmt
	63exRV75J2+6gDaqPt8AX/K70Dz+mdhDD6J+HjgQBD73kAwYFJKEHd3VcNU6fy/lZfroEn7FPPb
	WwwgpLFAKBP6rQZAF3dYHcc17AaMSpyKTnZUqflaUZg52jPWGp+ClvxoC7p66SI2b
X-Google-Smtp-Source: AGHT+IERfKc2L936MdVocDu/kPflnYqKEGEZ+TIdDTwLdlre3fzzvbDynUKBGakRz1TgJER5Ba5Trg==
X-Received: by 2002:ac8:7441:0:b0:477:6f6d:607a with SMTP id d75a77b69052e-494a333ea97mr28532261cf.7.1747314632821;
        Thu, 15 May 2025 06:10:32 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:32 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 18/49] selinux: introduce task_obj_perm()
Date: Thu, 15 May 2025 09:09:16 -0400
Message-ID: <20250515130947.52806-19-stephen.smalley.work@gmail.com>
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

Introduce task_obj_perm() for namespace-aware permission checking
between two tasks using the objective SID for both tasks and
without assuming that either task is current.

Convert the permission checks of this form in the hook functions
to use this new helper.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         | 56 ++++++++++++++++++++++++++++++++++
 security/selinux/hooks.c       |  5 ++-
 security/selinux/include/avc.h |  3 ++
 3 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 9385dcd84eee..07cd1b037ed1 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1291,6 +1291,62 @@ int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
 	return 0;
 }
 
+static const struct task_security_struct *task_security(
+	const struct task_struct *p)
+{
+	const struct task_security_struct *tsec;
+
+	tsec = selinux_cred(__task_cred(p));
+	while (tsec->state != current_selinux_state && tsec->parent_cred)
+		tsec = selinux_cred(tsec->parent_cred);
+	if (tsec->state != current_selinux_state)
+		return NULL;
+	return tsec;
+}
+
+int task_obj_has_perm(const struct task_struct *s,
+		      const struct task_struct *t,
+		      u16 tclass, u32 requested,
+		      struct common_audit_data *ad)
+{
+	const struct cred *cred;
+	const struct task_security_struct *tsec;
+	struct selinux_state *state;
+	u32 ssid;
+	u32 tsid;
+	int rc;
+
+	state = current_selinux_state;
+	rcu_read_lock();
+	tsec = task_security(s);
+	if (tsec)
+		ssid = tsec->sid;
+	else
+		ssid = SECINITSID_UNLABELED;
+	rcu_read_unlock();
+
+	do {
+		tsid = task_sid_obj_for_state(t, state);
+
+		rc = avc_has_perm(state, ssid, tsid, tclass, requested, ad);
+		if (rc)
+			return rc;
+
+		cred = tsec->parent_cred;
+		if (!cred)
+			break;
+
+		rcu_read_lock();
+		tsec = selinux_cred(cred);
+		ssid = tsec->sid;
+		state = tsec->state;
+		rcu_read_unlock();
+	} while (cred);
+
+	return 0;
+}
+
+
 int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
 			    u32 requested, u8 driver, u8 base_perm, u8 xperm,
 			    struct common_audit_data *ad)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index dd005d172f35..5944643077cd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2133,9 +2133,8 @@ static int selinux_ptrace_access_check(struct task_struct *child,
 
 static int selinux_ptrace_traceme(struct task_struct *parent)
 {
-	return avc_has_perm(current_selinux_state,
-			    task_sid_obj(parent), task_sid_obj(current),
-			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
+	return task_obj_has_perm(parent, current, SECCLASS_PROCESS,
+				 PROCESS__PTRACE, NULL);
 }
 
 static int selinux_capget(const struct task_struct *target, kernel_cap_t *effective,
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 1631f6cdbefd..2c2268249b44 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -173,6 +173,9 @@ int cred_other_has_perm(const struct cred *cred, const struct cred *other,
 			u16 tclass, u32 requested,
 			struct common_audit_data *ad);
 
+int task_obj_has_perm(const struct task_struct *s, const struct task_struct *t,
+		      u16 tclass, u32 requested, struct common_audit_data *ad);
+
 u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
-- 
2.49.0

