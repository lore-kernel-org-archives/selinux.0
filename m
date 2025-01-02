Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F0154BE4
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836350; cv=none; b=f9m+6uG3hfbjAPVc16h117QIqgwcwa//dw7VLQykyMs6nBhQe1YOa9ikpniXvp7XvHtVu+5rQsx7LENpamTKjM9qV7gMe07qba7zWMi7TdYqtzeqronk6KQ5i5EVKOFW8pSHGCQu7rdffsTRy2CaPV2WEHjzvtwKnj6LdLNo3rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836350; c=relaxed/simple;
	bh=OvAnuEzack9VuIOgNEP6p07Pkeh5zPa4zXw/9LKuc/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W+poBiFiIlB0dUr+B/l8n8wzzYQYh7/wvOJ0zEIeoPWGApcXWzmBPX+SvYB3RobBS6efu0aqW0Gg3rXR2OPxA1JPzVYdpbpgQtNYuetUHjtPZvHcZhL9qpaLU3XKrReFjChMRDC79X78OJt/sJ4qHdpAsBK8dF0U1Z/ntYYUm/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSj9NPHs; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSj9NPHs"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467bc28277eso95725391cf.1
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836347; x=1736441147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljkPvdOs9go0qhM3C/UzLvjdIhlm6hrSdhwd6AjIkGc=;
        b=ZSj9NPHsL3vDf66KoGaGkgZJfCGeu/uJIeXoDVJsEaxGtEEpcv5Lw2xJ83qx3RfnsL
         CQFsAsxYYXVntlfmY4IT+f0pBh9iKaCCpvJCCJ+8yh935eXyfJLPT99lie63gLUMfl7B
         BqYGBeJQpTrsoiS6iHpc5r2bQyqZ5ung0EXrJzLp5tk/trihOSsZtxeQsrOozNYCJaXT
         m5bSP1Hv0QyQtgJpc51Xuc9nSL01KVoWYUl/a6Y67X4DsvCG99PgfMBvHADx3CiWrLZw
         hfza1DwfZjeiNf7VpXHMVw1e9Z7+Mf733EYsHKj0m+BjSOUbCRiv9lRrYMRPp9vngats
         0J2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836347; x=1736441147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljkPvdOs9go0qhM3C/UzLvjdIhlm6hrSdhwd6AjIkGc=;
        b=MqG5n5Bf160IAYuuUFfAFXYA1rTq+xIENpfI5xBKVRaI1HYMur/z2/1rsaW86eT5q9
         7gQYsXw65YCm+PJDxEWtHje+4s53awunxQ2h0Kfhv6xGfMcE5f9h5XxiYtyDyoUgAMbD
         DpTS/ugwtUnCdiSVLq4DPN3XVb6U0jdJ4/UBNhKKd40GpvvgWIii5YZbVRPH9cMvuX81
         VN8kTdTSsO10aL7dxT6opmx2w93VNMe0nt2ZQqTZwN0jab3VfEv4iab2FCxCype1YShn
         v9PwDmsO4r9+K8PeEhEgvkF09zs22PBNU8yWk+fL3kr/1/LlumnlU9Al/U6+SAIDqhWJ
         QknQ==
X-Gm-Message-State: AOJu0YyjqB+FE3V57npIJ5nt44EFwUVgrNAxuz+iDRkspmtbRwaAsPJP
	tDHQp7r/n+zn+GyXVE/fdHLUpmfvO9za/L1WZvElCdoF0HB3bD5aTo8iCw==
X-Gm-Gg: ASbGncstjqcw8ep59S/Qe+tZUWe+WGTCEzYxVFyR9OOKtSwSNzzDPIg/P00AnAn4Auy
	RnWrWDt7lSv7mO2p7Y8Z6mGWeTuEfX06JDto8p36yjKWcXjT9yzmrH795QHYe1cuw9qnVL2j6IH
	kZ9f9bW0h4hBKtPrTGt75dQsF5trLSR7MuPJqnRSbhFD/7PdNx90n1uiulUH7QfZzEuiL22gTeU
	ePB671I5LiHZ2USYZfzI2V7Faa0RLkjcvBe/brl4x1AzWBMrGFs64Gv8re/3FmbCn1HxRpuA8Kq
	1DYFVkbFALHSUqXv+OrmPPv//Jmj/zQnEo5OPSDQFT3KIahHwegKkWBAQYfD7frsfrhhqQ==
X-Google-Smtp-Source: AGHT+IERmRg3HJtOj99qZYJiBGYIuTwB2C/WoN0KADzX7cGSiVrx7NSQkwMDndwBx7AuZ9/DY5QWQA==
X-Received: by 2002:a05:622a:1aa8:b0:467:5eb6:5153 with SMTP id d75a77b69052e-46a4a8e4669mr890063211cf.19.1735836346905;
        Thu, 02 Jan 2025 08:45:46 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:46 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 18/44] selinux: introduce task_obj_perm()
Date: Thu,  2 Jan 2025 11:44:43 -0500
Message-Id: <20250102164509.25606-19-stephen.smalley.work@gmail.com>
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
index acf62dad064f..cc64dce0f061 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1277,6 +1277,62 @@ int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
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
 			    u32 requested, u8 driver, u8 xperm,
 			    struct common_audit_data *ad)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 028e94c6e396..a19cfef5325a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2116,9 +2116,8 @@ static int selinux_ptrace_access_check(struct task_struct *child,
 
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
index ec40b856da91..e47b75819f4a 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -171,6 +171,9 @@ int cred_other_has_perm(const struct cred *cred, const struct cred *other,
 			u16 tclass, u32 requested,
 			struct common_audit_data *ad);
 
+int task_obj_has_perm(const struct task_struct *s, const struct task_struct *t,
+		      u16 tclass, u32 requested, struct common_audit_data *ad);
+
 u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
-- 
2.47.1

