Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3CE269CF0;
	Tue, 17 Jun 2025 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169205; cv=none; b=drrMRdvDEwHwVhk+PvMhZd16uv2K4Swaq8uLZmVPzjw+yyv2oQCUZnWypHtQRpfW8b5CdoxDhRXEoTUWp9GtTv31U0OWH+U8koG2LuYvTKUPPe3RELWpHije1XhwOrzbxMemk51YRia3uReLum1DHPxwv+UOxRmgVTLASUse5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169205; c=relaxed/simple;
	bh=UsIKjXxb5wfnKXJeDRlLUuYVfTjsWiwre5vp8XTSmPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANlHQ6imAYoIOFBvwqdkxti1814dmk/hv2nioBw8su5T5obFxrL4EqpGJg0EWieTrQPSkSmCo9/m21ctJBx9rUmHqImAOO3Z5tNxrgHEG/NKZDhbWeyycU4lQ07BIsbS/cLErOvz8PirreYanZehDL7Iww9WnVHtmhsiyCLX7Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEwtK434; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEwtK434"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c56a3def84so587696185a.0;
        Tue, 17 Jun 2025 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169203; x=1750774003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RumHsXfStRtoSmipYMxdxlWusYg5oDHuaUKTjMBldas=;
        b=nEwtK434tupbufjoX5u+zTGthx7s1bz0L9oVEIa6B3jABbTgShnh1IdtSczyYKv+fj
         a1yqmOvNRJxhvP3UyDDbLfdGg2/shrOqw5iMen1IGn3wb0WiigV17Fz+WSS+Y65dnN6I
         IGNqH3zXSuffzg2gPDKN8QPY0u9FjqOmAqvowR2xwZ6l6ypuhXNL6J6MuzpwPHENeOIU
         JgbLRCvv97UqOELVP0jwqxYU45FDxRcbaz7zP4SVuPBjuMNQYbVs8bWhfMG7HJWr/sVc
         88y2yKn08+W3VDS3PXhPrp1FXApgc8gOoWt2JEqU7wjMPzSdAH+WmmMzgk6M0/EGPBEn
         yB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169203; x=1750774003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RumHsXfStRtoSmipYMxdxlWusYg5oDHuaUKTjMBldas=;
        b=pbjVBV2IwejEYhO2/doNvJCBChJvtU+zT/bml9UeG85iC8N5DeAL1Jus4AoJ3gobQb
         9o9TMS6ji1Od/WICovKYrxcjQKYl+QXPZmX1YVdx3ppH3uTIYLCno039Q9+Ws+crU7Z9
         fIUlNp6yy7U1E2JMQSmyn3HSeRO/TTnPw4SRwvbUj+C5vxl9sSoQc3+ByLrbWvRiUxeD
         0f2XmrOkHA/YJvS2Mi6+ucrlU8bpRPRLRzbEoQwi7ZAfW6SzVfoBmMrE06MRtAVCmGpr
         abwXHdJ3kY5l9AuX3pqrkec1ko5PhW5F/42akxlHNjwDJxM8vF+YA0NimZcA/16KYF3z
         KEgg==
X-Forwarded-Encrypted: i=1; AJvYcCUeP4PtXoto+alRRYzeFBt6oZXgdeHRvO5lEZ0DQWiqXAa+1Xw3jCQfjXMkXumt2MS7VxwhmPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzYFbrQyssoZjDNnYiEtyWPUld5IMkpnUk8fkYeQYhtK2MYJH3
	xcY3SEXxYMeKYW2LhFk/0Ht+L5ayVTpGlv7o/+vRfvwHTz/+5x1DzdtQ1oL1Mw==
X-Gm-Gg: ASbGncsxCWKX3OOlMw0neAZaeXYe8ohyh0HmRumG4EAzq17rjtsdZmlp7ClYx1DwCyy
	0PFua1JlI4PZxrBzg3o38XIsmj+zymXw1+htMCDLEN9P2RLxSuMzl2CAVdywfPK5E8wrZJRtjVs
	t3yxgelMx0LBqKipbGtzUIduYKaVH9G9/PJdD1UqTW/4l3AdDezmqFOHR7+aHl8Q7256hSn933O
	EUoCOMR+FyiuS+gxNWAhPx95Q7uJOwKMBnpucTpsDdMXmat4tWy1WLjbXquDFIv1I9ezlFqQYCL
	xut1ER2ZYvy+vsS6EyPLyfl+AOA6cEQKsODLntKirtQf8BfYl5bsbTTGd3nRVk2uR8Qy0XZ9JXC
	u2yQavAelS8DXE3pE8Bi07eO/k8Bd9//5KemGuOHMDYEHVUoFNeJ8rF3DTSGoIL/CGA==
X-Google-Smtp-Source: AGHT+IGZJWOtSPUJzDg2Ki3YccpstYwOpAvQOy74iBjsvsUWNiM3097G8kXgzFkVMGt/1UcB+vKX2A==
X-Received: by 2002:a05:620a:2489:b0:7d2:26e8:d186 with SMTP id af79cd13be357-7d3c6cd4b61mr2917838485a.36.1750169202503;
        Tue, 17 Jun 2025 07:06:42 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:40 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 29/42] selinux: add kerneldoc to new permission checking functions
Date: Tue, 17 Jun 2025 10:05:16 -0400
Message-ID: <20250617140531.2036-30-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
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
index 0c79f40d70af..396cee4b22fd 100644
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
@@ -1347,7 +1378,25 @@ int task_obj_has_perm(const struct task_struct *s,
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
@@ -1374,6 +1423,20 @@ int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
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
@@ -1396,6 +1459,18 @@ int cred_self_has_perm(const struct cred *cred, u16 tclass, u32 requested,
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
@@ -1421,6 +1496,25 @@ int cred_self_has_perm_noaudit(const struct cred *cred, u16 tclass,
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
@@ -1443,6 +1537,22 @@ int cred_has_perm(const struct cred *cred, u32 tsid, u16 tclass,
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
@@ -1474,6 +1584,24 @@ int cred_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
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
@@ -1510,6 +1638,21 @@ static u32 cred_sid_for_state(const struct cred *cred,
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

