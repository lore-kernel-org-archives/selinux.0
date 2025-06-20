Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4752EF64E;
	Fri, 20 Jun 2025 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441544; cv=none; b=TCqpNCM0Hid8Nlj5lL60KgPvahBBivZ9kjzpAbMeDCL5IRCGP7bB90H6K1eMZXSe63yfg/WeQdhFB/yr+Up4GggmKOhJLs3OA2/8vZCjeO6Zco02HFLhOcL3Ek/gKrnGlfukhSV+/c++L5gucOn+tNvDZBF32Xs3XkynXIq12QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441544; c=relaxed/simple;
	bh=RiQbbN6KZ4SVbnJnAfcxhR27ypqiCxJbW9+Vm0Io2YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGwm62Fu904twErUEWu8489hKZisLRw3PDA/ddry7ZxlPePJIFqFQZNjoJJ3EbW8vENMKjwHJvB9NYKcTjpr95sDRwiNxoq5e0kNvqkkPJCnVRSOI0D7npbNd7M2cOrUPa7UzUJeULJqq1+9jyYQpHojsCF4QOYck45LWFiFUzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amqkvOc1; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amqkvOc1"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fafd3cc8f9so31145816d6.3;
        Fri, 20 Jun 2025 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441541; x=1751046341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lbq1jv+RDblCl0HTEh19vWR8LL+efD0LnEhbgiFmXCU=;
        b=amqkvOc1lZoxDNSY0RJ7ik3QXAzQ8Cf91fyNQPrvbaVWVXxgfvIVsnXUhiTEhLGjGt
         LDjUvOegcMls6O7U+us6L26OdfQUIa3gDplt2TLK8vyd5VnDtJmF/ZbqNfZkHxAfIxLT
         2LeETs9BmeN7Vy6KpWXjfY3K3E+nf5jJ1lt3BNkS3MMPtpRBZRcKG/9OfyzjQ98pRxyX
         iCg25E6Z+RaX4fYJqFfS9/RqzhDGnh0fk/gFpeAxhrwwgkpka5XeQAgM0Zq3UMcmKmGF
         aRO+t/Qvuq3nwpCRpcvoR1gkjSt/tv60+uaX6h9/WwqDsTL6utiegXRtNmdctv/zk3aZ
         hR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441541; x=1751046341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lbq1jv+RDblCl0HTEh19vWR8LL+efD0LnEhbgiFmXCU=;
        b=gjNpA8p88CqeZMF3XBvsyM12LnC/tgrKeUenipPU3sa9hvOVJsJYE4S4UpLZrRJ883
         JOr+fPsH90/6OT4G1nhTu/15eEYu62VDMf9Ly41vVq6WoMGkYHZphIW5pvSe+OeHK2cQ
         LNMq0qS/kk/Fq9F4z1LwZuaXtoJqXEUluJW0oYxVfWEFlxbstDDyqaKB63/mbOdAiVbm
         2Vr1sj+m4ylodHB0kzsj3PRODUpz2FHCfwtrVzbNNoG4/HAtos6SgGuYPIHctUflajTK
         hmsP8731Q/I3Mq38VVDoMGKLFHFEtdyq7ZOTcMrOYuC4a9MIUjk8JuqfKaxl7eHwOtFW
         FhJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrxkKxGQxx/m+6ibA+NdkwqTBx1lEtT5oZDGJEYOeCaPw83MGghoms01Nk62DNhL8yT1aB9tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3D0x9/nlMNTP8tU/KouwGh8EPsPloOfEOQO/XeMEGNY4JD0z
	1h21xiRHR8GvXDuINd+QDSdwFc9dgDpj2PxvPKEsQabQ8bqPFmJUHnqWqzw8UA==
X-Gm-Gg: ASbGnct+zQ+oF6k/xlZTroNGk/uuJ9dbEqYSlZprQ++8NKcx+JiWNK4sRaAEVg5YEDy
	dyhcMGff2loNdyKKMhmkkLO59WVln+drmpU++AQ9/dAy9S9yiEDS9XPbEz+Z5P95qdO7Rmhaf/6
	CEGtdEgkuakUMUAiZwB+0dffrvHlaZyTlerUjdgb8m+frgsVfzIETk2YHJYt4osVuO3703LxcRy
	uNQNn2CZlbWzeM1tskW9a42nor6gRKNfi30WXK2hWKMJqrb+9AUJxcZj6szrgTeE0hbWmngOF8G
	HLw6fyNqwzII4N48GPi6ECm93VCnSH/Ki/H483bF6pEHM1cG+7s2GEUxAzSZTRSwgkdPwZEzQS/
	TynktJN1ylleaDbnG09kj1zNtbcLDHIf0Ri9YAKNC0prD3lN6oInAVUnZABBLNtMQt1zZlJdC9G
	wF
X-Google-Smtp-Source: AGHT+IGqTa9zV5s5yLiGjaJLT0rYB3LCQvt29yTrT+oNAjjk9/kJb3Rh8dxPIawViwvJk1aSUOXaBA==
X-Received: by 2002:a05:6214:540c:b0:6fb:4e82:6e8 with SMTP id 6a1803df08f44-6fd0a4bb5e6mr63008466d6.14.1750441541465;
        Fri, 20 Jun 2025 10:45:41 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:41 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 27/42] selinux: introduce task_obj_has_perm()
Date: Fri, 20 Jun 2025 13:44:39 -0400
Message-ID: <20250620174502.1838-28-stephen.smalley.work@gmail.com>
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

Introduce task_obj_has_perm() for namespace-aware permission checking
between two tasks using the objective SID for both tasks and
without assuming that either task is current.

Convert the permission checks of this form in the hook functions
to use this new helper.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         | 57 ++++++++++++++++++++++++++++++++++
 security/selinux/hooks.c       |  5 ++-
 security/selinux/include/avc.h |  3 ++
 3 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 9385dcd84eee..0c79f40d70af 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1291,6 +1291,63 @@ int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
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
+
+	do {
+		tsid = task_sid_obj_for_state(t, state);
+
+		rc = avc_has_perm(state, ssid, tsid, tclass, requested, ad);
+		if (rc)
+			break;
+
+		if (!tsec)
+			break;
+
+		cred = tsec->parent_cred;
+		if (!cred)
+			break;
+
+		tsec = selinux_cred(cred);
+		ssid = tsec->sid;
+		state = tsec->state;
+	} while (cred);
+
+	rcu_read_unlock();
+	return rc;
+}
+
+
 int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
 			    u32 requested, u8 driver, u8 base_perm, u8 xperm,
 			    struct common_audit_data *ad)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9e4683bf34da..bb8767762b7d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2126,9 +2126,8 @@ static int selinux_ptrace_access_check(struct task_struct *child,
 
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
index 3198ed11aa80..a06e89ec1bfe 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -177,6 +177,9 @@ int cred_other_has_perm(const struct cred *cred, const struct cred *other,
 			u16 tclass, u32 requested,
 			struct common_audit_data *ad);
 
+int task_obj_has_perm(const struct task_struct *s, const struct task_struct *t,
+		      u16 tclass, u32 requested, struct common_audit_data *ad);
+
 u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
-- 
2.49.0

