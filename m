Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C50299AA1
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314638; cv=none; b=pm+qSgoL50F2AV5itSff6c7oEBDpeJHriUYyKFINsLLzRwo00pO7PJN5itCsujWfn8sANoSKTO7ZOOCyfUwGNgn1bX7hbZbdAmekoQC/KplKueYRQg0KGX5wP6a21s4+SMPUQjfEyvAKCg2ItMdt/JHtU49tC7a2sh8ThplPv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314638; c=relaxed/simple;
	bh=2QmSE13uyVQ+7H759cvTsd+tMHR2iZivVA6igtJDcpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSw2QHpoTsF/UqWZTw2+TVMZG15oNwVsJCRTFa+VI2M4KLD4TDOOUemkilOLvvS2uDoycSv1KDG1HW2PDzh1WmJgcPNfHjQiOkglaUpiEe6oEY7Psm3QzUEns0hoNREpT5WP6zddLJ4H/DkURhPfIM2oxxkI85NB6teh6Sg1LPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGFwKMEt; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGFwKMEt"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-48d71b77cc0so12612351cf.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314635; x=1747919435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPOzJLd9ueW7l3fjGGvuuT7JI0JByXXC3f93zZlilsg=;
        b=fGFwKMEtQyESQ8VKi/HMaaMWXCMXYua1yz0W2ovjJLAbTsxjgwAjgeQzQZ94Dm0A8W
         oImppLiltBFhLQAqFtu28BT7YTkwRplnHUJMo9NoiREYj150cCi3zP9pqW0Xcm0IMaGc
         kvBkmt2d0JDJQ6amOBpUGMQc7llCay1rDnEEnpaCbbuyRXaHeVyXXfbS6oor/VMDpO2x
         cpJu210VfRYIHhif0hiPOoy38+FwDSY4/VuhpjIONtdtTG1sNT2LVdKTc0NicL9nIWYQ
         om0fot4vbfRxX+hGVzdfOdHuSh/Uf/4v3l8R1HozIcOno8Zjn8Lmu8+YvjuuPQhg0hXN
         JRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314635; x=1747919435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPOzJLd9ueW7l3fjGGvuuT7JI0JByXXC3f93zZlilsg=;
        b=WbUlyxU/AAfSMh/3GJHcaosu51dE9n/P4sW24iwEGHPQMk5mK1rHjxz61wOU2Tu/Nh
         rdxJ3xFPNmdfZ+MyYSMVsZAuoUQA3X9vzvhmILqzq4djVofURd9fx60G3nghAAHZvBrK
         KFSaM7X56ZAqE+prMasF3E9El1XNegcHjnbVg1jm4vg+nl72WZGGS3dmBsgHwlBiW9NQ
         7S9xSTXwtIRI2EcOHltsKRztk219zZ1bJyEHNpM7MblRGAtudjrD62Jh9IKxTGJJdPSZ
         DmTrohRPixo8rPpFpUeeK+Thu3QVeg/lYnYOm2+nzt86MLVtV6qWb+Hxq/uF/bgfW9TS
         ln8Q==
X-Gm-Message-State: AOJu0Yxbi3JBQzomce7g1RGtx+PJyfwFtusAifEiaIPvwya3N74ShjSt
	npF2Wolic400cF+vMXZCRubMcffNWJYF808t8Jtwp3I96brm2eFPUvtBhw==
X-Gm-Gg: ASbGncsyw5t/47a4QKGxsMwsyKWrKIXwsDVtAg+NVi2lHyae6Spsw2U6d+gY1YcbyUy
	GfGIVIxRuDxKZVJukxmYRq1Noh2VIzVUjypoGgC+R/SKoNL1xjlqML10s8IsQgUl1mHzuXOaHHs
	PTuJRC0OvbvNsJBnYNtzpnBzFPRQsPgj2EFQ6t3TJbzxDogC4hBP/AQVeVzXRmuDUOxyhvrp3vt
	0oLN3MKMa55T23IGqkwkZyvPKlZvxa8fmHb6/39WhWkFHE+L49eFSRl4DzOKF2TCjO10Bo8BRAL
	OC4WA7Z2qN9nAzofLHQC3cqQ/nWOycPX8XxzVOx5IeoMGdk1kz+Xg84Ax8Ocp0i+acrIZZut52T
	/t72nDAqwyfssQhFqzaChdvsF3qdRQGGOt6iXh4uZZFeRR5REYGhWhA==
X-Google-Smtp-Source: AGHT+IGK9fOrSEA+caRWI8VEoSAL/66M0cr3OX+Why+RoVLBE5rhX8U+CJVrKwDRYbZQpl1hWXGzSA==
X-Received: by 2002:a05:622a:258c:b0:47a:ea2b:4a51 with SMTP id d75a77b69052e-49495ce04cdmr128231221cf.43.1747314634796;
        Thu, 15 May 2025 06:10:34 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:34 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 21/49] selinux: add kerneldoc to new permission checking functions
Date: Thu, 15 May 2025 09:09:19 -0400
Message-ID: <20250515130947.52806-22-stephen.smalley.work@gmail.com>
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

Add kerneldoc to new namespace-aware permission checking
functions.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         | 145 ++++++++++++++++++++++++++++++++-
 security/selinux/include/avc.h |   2 +-
 2 files changed, 145 insertions(+), 2 deletions(-)

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
index 2c2268249b44..94275fac8aef 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -148,7 +148,7 @@ int avc_has_extended_perms(struct selinux_state *state, u32 ssid, u32 tsid,
 
 int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
 		       u16 tclass, u32 requested,
-		       struct common_audit_data *auditdata);
+		       struct common_audit_data *ad);
 
 int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
 			    u32 requested, u8 driver, u8 base_perm, u8 xperm,
-- 
2.49.0

