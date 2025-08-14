Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49893307495;
	Thu, 14 Aug 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178052; cv=none; b=Ghqikz0Zi1682MVlcDxMhcmQrT+Ltoulak98Xwcx12oDZmFFYqowHnPfU5lucAOgRoTL99GDEs1sY9KWyCX1uwb+VQfG11XigKeDtRK2F3+ke1ZQOBMRiFO8ZfVblg+gQsI1BHDWN6NxfID8laUAjeSQZp8lb7iJ+VdTAyIsrqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178052; c=relaxed/simple;
	bh=8RzbMMp6FnXWJHwBsxI6iDc9cjJ4NBY75BtSW3OiQjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jifLJ3dn3uzzM/2+nJ3u8mKI+GK8K5G0vgvBc18HH5cdyDBzebsnSTSrLvQZByHNKfnJbwyYmpprWbPfAiWZhfrJfHjnt21aRzEy9qFmJmp1aMEHjs4SK7tolIcovUBNpiSX1Fvn0hD+ylx65+jTRPydT4fAZQ6E919mwvoGjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdaW4FfC; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdaW4FfC"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b109ac42c2so8323191cf.1;
        Thu, 14 Aug 2025 06:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178050; x=1755782850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnGr8UR+U7w/ycHq+sbnRUR7N4yPY5sVIlJ6w11fifY=;
        b=kdaW4FfCby1aivDHFNlK14A2/+rjuDtwS2o6fNSVFj/NtQ6x/KDyIC4FWA7GSHC7ll
         z1FlvnO8yS1BilIhVbt8Yl89+FlzQDhccmD8cDF+3ZQpy3YPuh/RUg6sPiRB9qcmSApO
         Vo3PzxiLxmxuUrrb+LQs5pmhL45DHzk/ploAvalrUzngna/qpWntnUt536DDiofzymvf
         WypXReYrPIwrZ09G3WV7o1YcSbGcAAr5WtFyB6/KsEbt9yfRuc3m7OiaIKyCLnXbsvJW
         9XxNbWOPn61xWycY+L0sxhaUOV7Y7pHadp17glellc8E5ZGzZQNGMgJYHfWNvCpR9fVV
         78YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178050; x=1755782850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnGr8UR+U7w/ycHq+sbnRUR7N4yPY5sVIlJ6w11fifY=;
        b=Lr761cfqKKsy7rnKxJEERqc9C4DcR3jcRbYkCR/hftiPa+uIrkhvOfLwXfytJ57uga
         JVhL3Ejo0TgbgMLOEavIN3RTypNSnMks99rD/9FSWgR73apg4e035kfoU40IjI4BWtTW
         VTJpNMR2eT6ubftvgPE9VDBnefxjj5qWHFKI2vYA3KQEJqAGv4MQmLx2cl4nxMeG8XWa
         +KQRBnFpM1rc/a+1JCDibO3dZQXB7vRqEzbzC9N1DrY3XqqWCZX58CYAonif01Amcxjc
         HpEK1OP9kg7oF1+oAwbwiiSmWK0eDJMMPkEb36BGJe1r6B3S8IhcEjYlDafh85l3uZGe
         1A3w==
X-Forwarded-Encrypted: i=1; AJvYcCWvF06RLUtd8lOVOTOg3hBEdnZ6kdGrCxBEcui1f9IXRrYvBKZ3Ni7NEzE7UEfQgE4wismQKhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpvgta93a/IgYwubTE4+UZulmBwIRKew4ksMKc5gTcIxGb+Fee
	xvPCHeTouwXi+RrQp1e+xnvGqPjn+Hpom9tmImA92Swoz9khW/c6y444CMU0tQ==
X-Gm-Gg: ASbGncvR4aqsxtsC7Q4B70G+iE9wtBRoWTKwT4rgPcVlxStF6blAoOX2h23MRqq0zap
	dpnQjFIEbTohncH30kbLQBVVT6qwm9a3AO49FpTKgd0zzoVB+sgx3ye4o3bA9eKm5qVybc656xG
	uSFhotA2JnByWU80G+yE4POCF7JUSHPBLXmnxzP7INiTOUmwgN4TdsPA0XVc24Ftu7mARIqI5o1
	oOTah3MCMH2yy+xMNAnZQ9frmAoXrWwS2mEWjF47i3TLhMxM/fQkljNI3XkrcHmz/MX4kZO6MLP
	NQ/QpfEa85kAJvCa3VCPlLF4wPIQYvUCyt0Hw2/O0vmO44SKPjLVuv+gktnokj7KfnRJyDfGDlp
	MnWySp0a6rF4EHyilhuGOdyTKzq7AyDuxV33X4YY9leK+hS69oIpa4H+DbUEl/1FZY8Ew9uhQTY
	k3uQ0x9jvLo+1t6SO3ouzQPGdscA==
X-Google-Smtp-Source: AGHT+IFZggvL6ogZ5pYWpnQvmv+gmdI5cnzAKzMunGkGrPS8xj1GiCYzmuybXWXfIm5OHzoLmOod4A==
X-Received: by 2002:a05:622a:590e:b0:4b0:61bf:c2b with SMTP id d75a77b69052e-4b10aab568dmr44417261cf.42.1755178049854;
        Thu, 14 Aug 2025 06:27:29 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:29 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 27/42] selinux: introduce task_obj_has_perm()
Date: Thu, 14 Aug 2025 09:26:18 -0400
Message-ID: <20250814132637.1659-28-stephen.smalley.work@gmail.com>
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
index f529d7f90c80..dcdbaa6e3d13 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1290,6 +1290,63 @@ int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
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
index 8dea622f9361..d062ee0908a6 100644
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
2.50.1

