Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12570286418;
	Tue, 20 May 2025 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742497; cv=none; b=Rt8qN5PLEjz+HrNcbo4A27cYKBQbKzFIIjX9eiMgeRrbMt8kBnFKdN9oP8ZlTZNkrtTjV0bRuzoO+5IgVcAUJ2GkOcSpTMCC9M2s30Tn1GEq3aLWrTVXWfrSTvsy1EfuM/OmWYowXw3Tntxre+FHlsbMyl0w7uNx9r6d6YLPnj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742497; c=relaxed/simple;
	bh=66bqjtasfdXKyKG0u2lvO6sl7MjdmrwFZAlb8dvax3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFTljfb8a13xi2VuoQcBS3KMosjSX4iOD8w14T7026cKblvhNuo4NmtIUawb+GmKSfAu1A/jMgUtFjn7cC2iuT4SzwGgTG1BMRTkN37gm135XUNN+/b0MtIZWydQXfydkWwBmeufJqHOjeqFakFQS9y5wwVdh524ylc+tq2hX9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqBju4fE; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqBju4fE"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c96759d9dfso910153385a.3;
        Tue, 20 May 2025 05:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742495; x=1748347295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejXLpQct5D9tTvSh18gMbbHqYE/VgKFj5LdB9X4o9gA=;
        b=MqBju4fESBdps3o/K/yOlKSWOX8I/6BwjcKtuT8pSnSHbYR8dXJVDdCyjAFI2LnZml
         MGqngjha1DhZa0oeMwzG0UNntnQPnWRWX4uzNhPPRScQkxnn9skQrgaWbBc5jsKV4nRl
         ZEYnXqPaa9NtGenbHeS8AxjePcjapTAMJBztHeSTFhkeYGsjWgGPeFKRYJUZ/5gt1XAJ
         /ReIGu8OE6XXuJcqdMY3uUbV2zikZRvAGz5hXdDLyPm0Cuj4P122xMvUuysYvKpA0YN4
         vxLB08RGmicerg5vJ930l6LgsO8biCfSrhcDJVqudbHT1GKylNy8e4MSwL+7ssb8VnDJ
         LiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742495; x=1748347295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejXLpQct5D9tTvSh18gMbbHqYE/VgKFj5LdB9X4o9gA=;
        b=pMjm//M9WAQ2Z9g0qWzivY3nQ/JY5SbshXMFYsrfirXCHj4gGiducJ4MztdHj1VKsl
         k7ebZewH8srfi7YHprrPnDIAj2w3laOGIYm3P18og9/16OP/vroIrED6tJasgPPlFOEr
         wjCP/6CiCtE8d/S9OYl8LAgOuZY3TNmpm/OymEqdxUdl0hkRITrUGQfIvO+x88HSaGY7
         HDHyXwRmaH/2/1gWDLRpkiALpxMFgBc+KBiO7fIK02vHX/ao4JqvkgAIFCaJxAHwmlpU
         /koFJimEZMdBgYnN4F6Ib9VHVqTmJlHR6+M43QU3H115U8CfIUciaQOM1WEtdlQQDVMu
         7fxg==
X-Forwarded-Encrypted: i=1; AJvYcCXhpTVaeBsxhpVkH+ZsGEF/FHu3FvbHz+V3jEqZmfRjaevKpkuKas3sUZhgHWw9hqUfOrtlP38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz15Kb568A2YSOqCPPnVelyEB8K/SIRsEcYcCxqMUdEFKoaUfd
	iT84p16PjXGwJqXM4k7J2KPmtbVoOOufoFJeO57Jt2hex/WBQisskudDeWMPbA==
X-Gm-Gg: ASbGncuPbwDWfGiCP13KS2bvcR1HhaovlBmyjMo4kMNeKkTdbRWzisr6+/2fHLFmVLl
	hJn69yIpTEONhvQbes17QfjFHALyNao9Hh+mzPLLwjCHF6oQ17SWv6i73boGlRD8kevtbUjELoe
	2r7ZoN+sQLUtUre6tB7VvtI5PnaapFctewyYx6XuYGrCPbrntIffSpXqwWUPyWJUOu2yz6T6QJR
	i6A4GIIc+grCjg+5nCL8X8nX/mLwqTHe4qhiMl/0tD+Ny/bScvlphhDMn0Ih+91hL9QrlZmf4hV
	V39L/ZSDVTumEONwBZnEVgLypu/tF4qMw8pYcXH1q8JBmRKapLHF/fmaRKB7ZEASrt16+tCwiCy
	VSrvlpjvgFgzFWN4zQDSXFmpteRBocSlQFKzmghpcyDBfPnNPEQaKew==
X-Google-Smtp-Source: AGHT+IFl0ghrYJCZVetLw25+RBT4MLswRUlF+A6GqL4rt2uxKhutDj2V49hnQZ2RLPCJxLxobmhA2A==
X-Received: by 2002:a05:620a:1720:b0:7ca:d4f2:a059 with SMTP id af79cd13be357-7cd47fd8ed6mr2456574785a.53.1747742494837;
        Tue, 20 May 2025 05:01:34 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:33 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 28/42] selinux: add kerneldoc to new permission checking functions
Date: Tue, 20 May 2025 07:59:26 -0400
Message-ID: <20250520120000.25501-30-stephen.smalley.work@gmail.com>
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

