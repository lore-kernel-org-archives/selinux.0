Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205D02EF9CE;
	Fri, 20 Jun 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441545; cv=none; b=Jle0hqQGurHJX9rwVPIFU7fUztrcbpdxZR4HI1V2u7mL7Hrx/2E/FAa/IvgXGDqZu1OSP5DsUtHNE1NAJ+sqiXjLgYClIBsMOxk6i5SxMlR0NzKp670tLXFhcPCBZOvwt0GVJqtFtJBWE7fkvx1gkYRy/bV/JxHEj3uawFl7Jqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441545; c=relaxed/simple;
	bh=M9VYi8w2upr0hT2g5ErZ7vj7WTJoPwAAuD5x0XTAXUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2rQBdGrxP82aKm+gYyqrkYcLJjIjhhtyf96MVRdF8VA98nROiFLiY7HTgTzNV64mZrJpGDWXcWBo0SffHU9uonOPH/ktYrDgBHbjoplcI1+NPPJ7kNOuaTiq+v4hk7sF5OSews0xZwwgLG7XsPATiRABVX6wZropIOxoLb3ZB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEIf11AX; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEIf11AX"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fafb6899c2so22694276d6.0;
        Fri, 20 Jun 2025 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441543; x=1751046343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRQavpO6D6Ii5vhmos6RSKhhNP9GgjV7HhkIpYX2xx0=;
        b=CEIf11AXWFGCU/aJlKuE8oqTZlalqdJIdVx1zIKozl6Ddg/kxb8BYHTtCKwSTCBVlu
         xSKIs0R5o5EH1UYDMSBR0FEM+16spM+EtVMokIFwl+JCws/PWBNsbytVAOn8DuczSQ3e
         Hb1PwMjT3VHiSwMdnMOqsW5AAEyHXeTN4+mZCZGsji/MYgUwhZOdjolcHbGK0zmCECr2
         bhpq5DWPOEcRSqjQkiBb0vC2PnwsFFSzS89Dt3OM+84p0cwADyHk1ThDESenD3toKpOH
         Sbx8mrqG6JbglbGg+279jPcpBdCttF9cU0PKE8+DpZ1Sgi2elhDUnyujQAvognKiMZHj
         kwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441543; x=1751046343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRQavpO6D6Ii5vhmos6RSKhhNP9GgjV7HhkIpYX2xx0=;
        b=CGxB83gNHalgGmiZ5ZucoxedBft2O+gJOCcDMVfq7za4wCxNF+PiYPT4aRH+1hG7vR
         DfpQ5iBPtN9tuP3uYSWM/G+kw93OqxE8YqLDcYIn1rNCy74ANBAU/1bt/vgJORdu0zhe
         8g8WGEuRxVsT/9Ri6U4KKT0RSTI92oC7h9R2qHp6JT8yrgET8QBJVHb4M7ocN2nIKHlU
         xDqLGqwF5C/xBRNBCyZGIH/o56N+/tycFkniMFDDnCSEg+/07kc6K6flZCuRoriHuGjz
         up4Dvuife0IGEYwZDb7+cIUfmdIgGvJ4qicSdNOFOAw/aZImDv0hjKo0o2ZvMJ2hLDuS
         969Q==
X-Forwarded-Encrypted: i=1; AJvYcCVC/waFVUT/gr6gqKz3H/iOWlyv5RdIpnVmgMkFHi+PzxFZGglfWQgOk8bNa9qsiAwh4VVIu6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBUZVQ5c/BkpmQZwpsTe6ZrZtBXMipcbr43WSfsRcaGe+OL54Y
	KpvZ+wQQwnHbQyB9ib8FW/HnOqrHaXGTT99j8AASDvw9arQCFnfA1G9bk8/Amw==
X-Gm-Gg: ASbGncv8uX6519lm1XAtCvW7+aOjtfdvb2VYPJ9C0UrBd2XB05GKSKBYOG6uxpg4aBH
	KAzs9Xatjq7fmUdVEWfEid4gGQErKfv+awN6Vah3W5i82gNOQzFSBvrgQ5G1heA9e17vzwIal7y
	mvvquaCo49zwdPXy5bG+ag11zDulTbwZJ8BBN9df86E9qx0WE40FetJqj3Tp/3Q6v/1hHZv6so0
	xI9obfc4Z9Vp74IjOjBoVtZpC3Qc6t4ad9QabGgQPfd5mOE3KoN3ozqyUGGYoqR6lvTmFbEatd8
	4Iimq/ZW0iFW++jlz67DPYRNwtA2BlVhdmfEvYbEEYrzV/M2wCs/cwWmRWNU2fSVdBbP3EMh9V9
	jihm4aPv5cKfJ+y5918PnttD6NxxipzkeWzl5gagU6Ient7H9+XiYWgu/8Y/gpMB1sQ==
X-Google-Smtp-Source: AGHT+IEB01qqcs7CaUz8LoYQPXkBsWzvOflScH30neGTKmFz/f3ZhvC9UZ4SvzIGIe0EXRkt67aTnQ==
X-Received: by 2002:ad4:5f8e:0:b0:6fb:3e49:cd23 with SMTP id 6a1803df08f44-6fd0c87d9c4mr50339196d6.3.1750441542659;
        Fri, 20 Jun 2025 10:45:42 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:42 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 29/42] selinux: add kerneldoc to new permission checking functions
Date: Fri, 20 Jun 2025 13:44:41 -0400
Message-ID: <20250620174502.1838-30-stephen.smalley.work@gmail.com>
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
2.49.0

