Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B9E24DD14;
	Tue, 10 Jun 2025 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576208; cv=none; b=BJqp2iYLbc4S9F2K1F7kLIyWdOnkHmkVWiGpPSZqhtTNuvYYEOgjBvMGEaJAjx10HTJB5lArHbL6e+KR5KDVm3NEUboPfLoe1yYIC6NtgPUF+fgMAValS21YQJRWWS1NUpVS1eyK0Axbz9u5uX6MGxs+QWMeaThB1WP69ICPJow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576208; c=relaxed/simple;
	bh=66bqjtasfdXKyKG0u2lvO6sl7MjdmrwFZAlb8dvax3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4XH7vge2JnRo0E+svcYXKwhukLqo508Jlj9d5qbpcCpW1YJKbA32TWg9bbe0qkhXmUTEVj1zBx4WREDvRkczqPhwjTL3eR3YsE+yJ1tJWqxHkgANe+97jy6M45jM2nNpZv70wFn0xUKFA5iXNO9t7mnLsiHw6KO1rw0ota99gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXaqQwgD; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXaqQwgD"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a585dc5f4aso78901101cf.2;
        Tue, 10 Jun 2025 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576205; x=1750181005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejXLpQct5D9tTvSh18gMbbHqYE/VgKFj5LdB9X4o9gA=;
        b=CXaqQwgDatJof/wK+36aduKk190I3XKSzoTZq2iQTvKsd8TlhBWdtwL6xOJD7GrpND
         19pr+lmuOaibMi7gJ3Oj/ib4tuZxHgmyCEmpU3e/PhqQRD2wFZPs70Ka3J1YpWTo8S16
         TR4DOgB+OkfpS+LLbzoObq12OEaj3HXltkCANahxdF/XpzPB2asdEgRk1Hh7Rwu/2N2h
         d7rM97jbRpb67ekqmVWnJlgjlB8hDmqhu3CRHudIp1jNW3wzg8Twi8U1uneXUkvMMFl4
         mygdEcdL1m73TiPTXmHxsVOpEeT29j5bSfY/3nYGsjEhBJUDkASL/bG/T6BsdiRLZtR2
         plzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576205; x=1750181005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejXLpQct5D9tTvSh18gMbbHqYE/VgKFj5LdB9X4o9gA=;
        b=RdiJUnPFJmaHMmbxv5TNu3Y0+NRN176hDm1rzdO6bUFq3o/JzNBu97MCRLosmfnQKN
         +ZIJuuHAZyXRJW4mFbSsKGhOBJavVPDMkRIZuMg1LG3Ogx05ZxzyI4WLdKYFNSSOf0wP
         pwEpwHjgQoYVSuHhfg0Vg6Ze4nuPa0taQe/nTHXRHlYOcxNaNNh0DQeAETt2ER7fGF02
         LCwmljWlVmq7wNaJOWDkyDJabkBlwkX190+YzW+Z1Yhv1fTQLir4J06FcOOtEYnjFwVx
         QHa+gELPaskbejX9DMMn2gubPoUfa1Jn+chjYsb6Ca9p6/YwJ70EqlXjO9fKzYu1cnI/
         d4gg==
X-Forwarded-Encrypted: i=1; AJvYcCVxKtnE2ZRCqL6TSiRPrcIi53MJPlZ7JTJj8wwKPn7xPamrwIpzt9fgtxCQCfvvUVdZsN32dIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlcvNRoqaWCOhRXfH6WHaxB8+mmGOQWRGCO+Weq/2zQU1O779t
	GFpTrTXZ1SFmoTwdYzeYeQ9Mdw6RY8Gdt7FeNopoM4iScdXM951nY6GMIQ4RRg==
X-Gm-Gg: ASbGncvWORXedz+VppecwZCl4E1QATuytd4H+L6CsoyxIH1GDNwPdPExAnvMrnCRMnp
	4I2uC2Zsm6YHHqfacfHGpTemwwkEBm8hvtTR1DxEk8VB9hLbGMlW/l2srZ6xI5rpJobLBOz6RJx
	ZPdEusbGk3DU07yCphgMTrM8pWoKOemV5DZM3AONEOrcommzjmIDg76kO6BY3irXwwR0/cezXEy
	39TmIh/bIxX3C7OMwsgXGTvpOUPbxzgKy04RUPjwKOpj2+LsILB1vBnavDIhHkOVhO2gWH+LZPE
	x1LQBz4m0gbHnDErUlcmyBAEow0e7TawWI8QXNLknnIoIWRQ7Y1pPLUtCC0+fewPpQxTZLSsUrk
	JsZuHUMqdu4mZIU8garAK9qtiLWslRmIjUG0qZNq+oKTalvRuB2ftvBvjyKE/WV8xwQ==
X-Google-Smtp-Source: AGHT+IGOW2MdJiuAqFifYz2eY+UpDZjE4V7MTPl2fV3hqIG+v+vECbAZGzfTdC1KFM5rNRKNTMjeCA==
X-Received: by 2002:a05:622a:1f11:b0:476:8288:9558 with SMTP id d75a77b69052e-4a713c667e8mr4580091cf.46.1749576204566;
        Tue, 10 Jun 2025 10:23:24 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:24 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 29/42] selinux: add kerneldoc to new permission checking functions
Date: Tue, 10 Jun 2025 13:22:00 -0400
Message-ID: <20250610172226.1470741-30-stephen.smalley.work@gmail.com>
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

Add kerneldoc to new namespace-aware permission checking
functions.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         | 145 ++++++++++++++++++++++++++++++++-
 security/selinux/include/avc.h |   3 +-
 2 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 07cd1b037ed1..fc40e840a143 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1265,6 +1265,21 @@ static u32 task_sid_obj_for_state(const struct task_struct *p,
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
@@ -1304,6 +1319,22 @@ static const struct task_security_struct *task_security(
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
 	return 0;
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
index 2c2268249b44..9def47812034 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -147,8 +147,7 @@ int avc_has_extended_perms(struct selinux_state *state, u32 ssid, u32 tsid,
 			   u8 perm, struct common_audit_data *ad);
 
 int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
-		       u16 tclass, u32 requested,
-		       struct common_audit_data *auditdata);
+		       u16 tclass, u32 requested, struct common_audit_data *ad);
 
 int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
 			    u32 requested, u8 driver, u8 base_perm, u8 xperm,
-- 
2.49.0

