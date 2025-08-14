Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E3F30100F;
	Thu, 14 Aug 2025 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178055; cv=none; b=WfHNJxBiKojO0Ep3Hbgc411DzR7e6upMEvEKvXLXukfCNhbkCERbdAUkkcSKs+vvGS9Zj6b/ppUusaxB3qVeCoGfiMb3HXc7nkK0HR93wRAwr20GxAy3VViocEieF83MURHAbFMspO92WqAqgHaORYdYdjvs54Yh1ulrqsbGBZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178055; c=relaxed/simple;
	bh=1WPFjFaBa9KpqIaGM3+J3fujTiT2+wEJE5RcGG3jHHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6jPU1+GDwvDxQTuZtESEgM5elzGV8npZpRguYGJRohGlMQE+WQf+kHYCcudDRwBKD4mtgjTdHtiTl/Jv0s42peyI49JvVQcOL8FY+vJvDYVE0hOA4CGTebE4H29M1SJXKn3F+5i9sL4vKlaPE5miWyEeMSHfigx7FNQlCfhgp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUrHUWZv; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUrHUWZv"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b109bd63d0so11481591cf.2;
        Thu, 14 Aug 2025 06:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178052; x=1755782852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlTAn2Y4pULA0G7AHEY+/JXOYpSOofkt2SxvjwdxxVg=;
        b=IUrHUWZvOjH08VFwnuZG3YDgPUOPvxDSsHSHK3ZXpNH/dHQCGZVtAO1tX0tJPE3PBY
         lG4XtnWkJK+EngoK1BgFt5omlIVKR2LKEw8u0I0ateThy/cicMhTrO5ea/jR6xIakO+I
         hliwDtCXD0DoxjPmd7IZHa63q3tdvOC6uEqfh2h2dEALOrjmdqpSWz+pSMiooAmzck0p
         XNhMtndvMbicY0G24G3LxvikfHaNKNnGJ83xmQs6MQoRCRfw49t14U4h0eZGnxSfgiFo
         1QFnuSMiHBNjwm68oBPfKkMy54OAqx6ud4c2pa+JH/22E1NPFCzQRpCOwptU70040uqe
         bw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178052; x=1755782852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlTAn2Y4pULA0G7AHEY+/JXOYpSOofkt2SxvjwdxxVg=;
        b=oh7fBDcM4BJAqlvWq7jArP4UmwBJSdYQouf8BWIXmFZUhTE5BLMgp4th5KW8UxsjLG
         OE0QCcGmHB5025bIpPkkhLrsDZizIEaaILHGfQJctPwlAOlQXG9b4AmiX02C9kzKS4eF
         ehBY5jA5qPpMoBME2wUSZbowC5uYBCANULgA77/DrYDvIHSoNZ+XIoIzAvTeyUnfHAkX
         g7FrYEyxsB8F42ZevBqxsNA9zqDqnEMYMU7+2ye1hmW4ZIk53R1LuBQHEdg4+EqBRcf9
         toDVLABbvAmw6pzaulzDHwYEHo19LpBYrd0hkYwN27CsMWvlGxEY0qPAUZ7tQMBEOCnX
         Akwg==
X-Forwarded-Encrypted: i=1; AJvYcCWX+oydGttWBw2+9wWGBnJDEva7z2qIuLLPyzbyHAsVFkE5M5axRVrqAEXE0KsQVaLA+C8vTZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0QDy+Zqoct4msuAfiAqpduUq8HJVbLa3/mYIplE4+XwWW8auo
	EbPHHqvfIjWSFyyGFc3Fhlh7yNqXN7kKCFGTyT62ukuR3p2/NNNSGVOTNH+lcg==
X-Gm-Gg: ASbGncvrhH6xVd2HtvEYTYlJyme2bsfiGqkMJBVcEgSF4IEM5n4Zc42hgBSQiELSFuo
	Ofplqzq6GZim3Tu8SJ8f8dzFCsRoOYChDQwmSfiwdBVWtAJGP8tQFAdSXdhcW9Yzg53ghf4P+Mt
	MM4xk2vBqNWgTysmhkD9uLg59Qd7s+pTR2rIiQPwH3ZO/okfLnx0kGhmHW52OGLT+nJD7fynNvQ
	Rzetjwx9/PCbSDyYnHD0cgFHLY+Iq6PEQHsYZ0aGmucdKOAG9QVoA2uKGzPeYCqP65sXRNknbag
	NjBYbR6DHyCk2RFdC+fgFMpnqkeyWFHuzOhOLG1BXrox0hzpgV6MdzRpAo6fe2iV3/7fq3CRKZc
	K5uNIGgVJtSv2gGiSSKDku7zUBUAT8Yc0PxzNpSLMsh5ou/zMyrMSByqIeELVfof+SPyTL9KXuv
	VXboitr9f9PBQVtdiF6q0j2l3Vqg==
X-Google-Smtp-Source: AGHT+IESXeD0QbZSYASvEDLKgkv2phRV6VPZEjiLVoa5vy+tFysDAOwAiV28LlqQUq4ZuQb6LDCQRA==
X-Received: by 2002:a05:622a:47:b0:4af:199d:107 with SMTP id d75a77b69052e-4b10ab1823amr41319941cf.48.1755178051980;
        Thu, 14 Aug 2025 06:27:31 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 29/42] selinux: add kerneldoc to new permission checking functions
Date: Thu, 14 Aug 2025 09:26:20 -0400
Message-ID: <20250814132637.1659-30-stephen.smalley.work@gmail.com>
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

Add kerneldoc to new namespace-aware permission checking
functions.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         | 145 ++++++++++++++++++++++++++++++++-
 security/selinux/include/avc.h |   3 +-
 2 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index dcdbaa6e3d13..5d9b7b22770f 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1264,6 +1264,21 @@ static u32 task_sid_obj_for_state(const struct task_struct *p,
 	return sid;
 }
 
+/**
+ * cred_task_has_perm - Check and audit permissions on a (cred, task) pair
+ * @cred: subject credentials
+ * @p: target task
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @ad: auxiliary audit data
+ *
+ * Check permissions between a cred @cred and a task @p for @cred's namespace
+ * and all ancestors to determine whether the @requested permissions are
+ * granted.
+ * Audit the granting or denial of permissions in accordance with the policy.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ */
 int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
 		       u16 tclass, u32 requested,
 		       struct common_audit_data *ad)
@@ -1303,6 +1318,22 @@ static const struct task_security_struct *task_security(
 	return tsec;
 }
 
+/**
+ * task_obj_has_perm - Check and audit permissions on a (task, other-task) pair
+ * @s: source task
+ * @t: target task
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @ad: auxiliary audit data
+ *
+ * Check permissions between a task @s and a task @t for the current namespace
+ * and all ancestors to determine whether the @requested permissions are
+ * granted.
+ * Audit the granting or denial of permissions in accordance with the policy.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ * DO NOT USE when @s is current; use cred_task_has_perm() instead.
+ */
 int task_obj_has_perm(const struct task_struct *s,
 		      const struct task_struct *t,
 		      u16 tclass, u32 requested,
@@ -1346,7 +1377,25 @@ int task_obj_has_perm(const struct task_struct *s,
 	return rc;
 }
 
-
+/**
+ * cred_has_extended_perms - Check and audit extended permissions on a (cred, tsid) pair
+ * @cred: subject credentials
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @driver: driver value
+ * @base_perm: the base permission associated with the extended permission
+ * @xperm: extended permission value
+ * @ad: auxiliary audit data
+ *
+ * Check extended permissions between a cred @cred and a target
+ * security identifier @tsid for @cred's namespace and all ancestors
+ * to determine whether the @requested permissions are granted for the
+ * specified (@driver, @xperm) pair.
+ * Audit the granting or denial of permissions in accordance with the policy.
+ * Return %0 if the @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ */
 int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
 			    u32 requested, u8 driver, u8 base_perm, u8 xperm,
 			    struct common_audit_data *ad)
@@ -1373,6 +1422,20 @@ int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
 	return 0;
 }
 
+/**
+ * cred_self_has_perm - Check and audit permissions on a (cred, self) pair
+ * @cred: subject credentials
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @ad: auxiliary audit data
+ *
+ * Check permissions between a cred @cred and itself for @cred's namespace
+ * and all ancestors to determine whether the @requested permissions are
+ * granted.
+ * Audit the granting or denial of permissions in accordance with the policy.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ */
 int cred_self_has_perm(const struct cred *cred, u16 tclass, u32 requested,
 		       struct common_audit_data *ad)
 {
@@ -1395,6 +1458,18 @@ int cred_self_has_perm(const struct cred *cred, u16 tclass, u32 requested,
 	return 0;
 }
 
+/**
+ * cred_self_has_perm_noaudit - Check permissions on a (cred, self) pair, no audit
+ * @cred: subject credentials
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ *
+ * Check permissions between a cred @cred and itself for @cred's namespace
+ * and all ancestors to determine whether the @requested permissions are
+ * granted.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ */
 int cred_self_has_perm_noaudit(const struct cred *cred, u16 tclass,
 			       u32 requested)
 {
@@ -1420,6 +1495,25 @@ int cred_self_has_perm_noaudit(const struct cred *cred, u16 tclass,
 	return 0;
 }
 
+
+/**
+ * cred_has_perm - Check and audit permissions on a (cred, tsid) pair
+ * @cred: subject credentials
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @ad: auxiliary audit data
+ *
+ * Check permissions between a cred @cred and a target SID @tsid for
+ * @cred's namespace and all ancestors to determine whether the
+ * @requested permissions are granted, interpreting the permissions based
+ * on @tclass.
+ * Audit the granting or denial of permissions in accordance with the policy.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ * DO NOT USE when checking permissions between two creds (or tasks);
+ * use cred_other_has_perm() or cred_task_has_perm() instead.
+ */
 int cred_has_perm(const struct cred *cred, u32 tsid, u16 tclass,
 		  u32 requested, struct common_audit_data *ad)
 {
@@ -1442,6 +1536,22 @@ int cred_has_perm(const struct cred *cred, u32 tsid, u16 tclass,
 	return 0;
 }
 
+/**
+ * cred_has_perm_noaudit - Check permissions on a (cred, tsid) pair, no audit
+ * @cred: subject credentials
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @avd: access vector decisions
+ *
+ * Check permissions between a cred @cred and a target SID @tsid for
+ * @cred's namespace and all ancestors to determine whether the
+ * @requested permissions are granted.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ * DO NOT USE when checking permissions between two creds (or tasks);
+ * use cred_other_has_perm() or cred_task_has_perm() instead.
+ */
 int cred_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
 			  u32 requested, struct av_decision *avd)
 {
@@ -1473,6 +1583,24 @@ int cred_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
 	return 0;
 }
 
+/**
+ * cred_ssid_has_perm - Check and audit permissions on a (ssid, tsid) pair
+ * @cred: subject credentials
+ * @ssid: source security identifier
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @ad: auxiliary audit data
+ *
+ * Check permissions between a source SID @ssid and a target SID @tsid for
+ * @cred's namespace and all ancestors to determine whether the
+ * @requested permissions are granted.
+ * Audit the granting or denial of permissions in accordance with the policy.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ * DO NOT USE when checking permissions involving cred/task SIDs; this
+ * helper is only for object-to-object checks.
+ */
 int cred_ssid_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
 		       u32 requested, struct common_audit_data *ad)
 {
@@ -1509,6 +1637,21 @@ static u32 cred_sid_for_state(const struct cred *cred,
 	return sid;
 }
 
+/**
+ * cred_other_has_perm - Check and audit permissions on a (cred, other-cred) pair
+ * @cred: subject credentials
+ * @other: other credentials
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @ad: auxiliary audit data
+ *
+ * Check permissions between a cred @cred and a task @p for @cred's namespace
+ * and all ancestors to determine whether the @requested permissions are
+ * granted.
+ * Audit the granting or denial of permissions in accordance with the policy.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ */
 int cred_other_has_perm(const struct cred *cred, const struct cred *other,
 			u16 tclass, u32 requested,
 			struct common_audit_data *ad)
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index a06e89ec1bfe..fd8c6b3a32df 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -151,8 +151,7 @@ int avc_has_extended_perms(struct selinux_state *state, u32 ssid, u32 tsid,
 			   u8 perm, struct common_audit_data *ad);
 
 int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
-		       u16 tclass, u32 requested,
-		       struct common_audit_data *auditdata);
+		       u16 tclass, u32 requested, struct common_audit_data *ad);
 
 int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
 			    u32 requested, u8 driver, u8 base_perm, u8 xperm,
-- 
2.50.1

