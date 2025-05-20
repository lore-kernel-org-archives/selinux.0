Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DDA2857DB;
	Tue, 20 May 2025 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742495; cv=none; b=RJozqVvuvCKWsUr6Pq/sUr6IdlV0+KxStO2TQLEJV3z05jRINqQQEBSD1EoL2fOD2SQezlyGxxfDkeUkg8n8UON3X3srBRZq98GB4qHPPLdqiRRPi4QdudBIV3Ek0Te2Tw/dObYGO9/K3IPO6sqYbz6C6et7PdJbnBlQ/BuGTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742495; c=relaxed/simple;
	bh=E5ZxnyTbqNXtAYIB6oiOJA7Yz+dGN8bNdDyJgzn6McE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewzezsvWG7bzCe4GwhZ/XMXEXLYFM6BDHEpLqKPq09KhoXQp6OPS9ECjruiHOlAIzbq3fRRrN266GUhj0fqviaHNGIr9FDJq9CT64xOjqlY75tRPUTpOTYNLitRYqtOFOK1OgNRAZBN1z1GUyDG44HH+J6de+bgNjeLeul4ABPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VayO83oa; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VayO83oa"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c53b9d66fdso779005585a.3;
        Tue, 20 May 2025 05:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742493; x=1748347293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81TXiwJcvJZuO+nCD6mlG9eF+VJr3oSFdKnVNp5RQcM=;
        b=VayO83oa+b2b/hQAZ5znbKOYhGu4N97hDlZdDEqqgmlfI6on2ia5Lhspw079JzMvdl
         H891DRG05ONPQkQU+5ZlaPjJverVOhIqjWx7l/m1OjEIqegG+3peqSTYBmlki1JbbOW+
         IyW45dhjBhLYUJxlbmLs630uE4QHGD8z9DxuVZFPTo7VIbo6tRN45wxxB+VtMCheKd1m
         z+DAbzxp2vS+KCfT9SuPZ+lFpY8soimhPaJaNenAPMdfJwZLUFJ98EP0Gd4BgwwzernB
         7m2v6R2sSi5mt642r4ewfNEz2I8cLsHwNvYiNfYQ6fAjKI8K0AE7zVPc1En5swoJPdQ4
         8zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742493; x=1748347293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81TXiwJcvJZuO+nCD6mlG9eF+VJr3oSFdKnVNp5RQcM=;
        b=HIoYCujOgnFP6Y8xRW1eKyl6ioxN693GzSMpRtpxZx9m63OJ4t3hhl0r6eRsS04m3D
         +YUJPHttqOrHN4gaYSoDnNhOMpXpbaiio0NanNgTVRbfTAUNE+i5l+aTko/kZXJXJwiw
         gfIwoSMq5wAJhrZrrt3ViaeaBnDZFx2EAldcNOfxHERwUy2+SMdyD+5Rx6T3WOVvePyx
         JUeirFiQiBo3NWYTYfkU1EYxR9Jf+tTc5LpmqxL54CIJBtLp+ENtjWo4LY+bij9iaNBD
         MIr37lrF6JeIS+HkosFIumDOszLamb8KxBJ+LdisoJC4jUpnGB4giqpqN5IyVrkSHQH5
         BINg==
X-Forwarded-Encrypted: i=1; AJvYcCVHZC9ptY/+O5xSH3qWVdq7QErmAvDSnCLG5DV1rbMvBxhkHn4WG3K+bek1qqPy9LweGS2SDp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlZp/rXDqaMOQ3A2ZWxNwUW22TjF+V3U6l9nPbDcBok3ecgi/K
	3L6tvgsd0bvxxfvA4d2LS6kkALCaywVs5Ce3gtoNbUqKVlZSwAYHKkDK9eMW0w==
X-Gm-Gg: ASbGncseZJncUNjvpO9YesnnD+lymDFxm2CmYPobmjDSRMkITaI0myyP92QfPavmVK8
	h+/pJFHRm/aOl8VHuH+d+TJCaPo9skUyX7jjgotqc7I3OAAhuEP1R1DrpN49INpjcvZSHyQl67r
	GlkPoKooAnO0UKkh5qVPiLd2KWxqFmq2SPpNiNufNLtIK+L1o2AiMfKp6aO62fhy1eNx8v//JKA
	ScmXPHJX+OUMGXL4j+17Dd6+lHx+T9b2B1hAdUCOO4baCOgVK0GCe1Gfy7iX2vIT9+MHVQKWFbD
	k5r6VdqPq8eNZmWqrBtcWWYgZWb3iSxRAAxlsOkoDIxHEqE5gLlLYBVTLHdcMBsrpu+SNjjC/N1
	Q98A2uZSZR/EecOvA9eCUUDNOzvvgP7tfiHvDuDpiduKY7umwwsA3Wg==
X-Google-Smtp-Source: AGHT+IGYRGAy2pLUOMJ4epH8JfoHITjwEdoq9tD13xbUNi+N9bFJYU2AkdBsFxfgH3X7VMkh/Eh72A==
X-Received: by 2002:a05:620a:4051:b0:7cd:147:96c2 with SMTP id af79cd13be357-7cd47f1366dmr2428228285a.18.1747742492557;
        Tue, 20 May 2025 05:01:32 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:32 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 26/42] selinux: introduce task_obj_perm()
Date: Tue, 20 May 2025 07:59:24 -0400
Message-ID: <20250520120000.25501-28-stephen.smalley.work@gmail.com>
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
index dc0f95c3547e..77a1c58b1788 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2120,9 +2120,8 @@ static int selinux_ptrace_access_check(struct task_struct *child,
 
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

