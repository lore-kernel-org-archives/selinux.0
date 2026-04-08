Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647E27979A
	for <selinux@vger.kernel.org>; Wed,  8 Apr 2026 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670350; cv=none; b=MCp59PdM2nlgNPsLHwGnjmTdesIsVA1xLB4xDXoDZbYYXQ01jlmojRsnBwm6GycWebuOT1DVfPIv/fIPi37ZbQu7HsCmFFN3bci+Oeh3QG5V8YBbIy4118NWOrqKj+F7vxZhIiqiapmPG1c2opuJ5Xk+J7T4ypB9vXHqVdiGvcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670350; c=relaxed/simple;
	bh=zjzRRrD+nEhIpRsP85Pxjf3WXbc/IAnarPfSpppDg68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YXaJnMpLLU2SCP7C5lw6lV7h+zHXXXlyO+MjEDs8uhptj3vFC40joKJ/suYq7sKQULC74TmJuFePCiwEUQ+sM+XzeRkCpgJNeBq6ftt41MQgiI0JcJX1z/L0DsiVTXWXY2FMbEvXOki27ICkeLJnJtW5NCVLeLwf6Ruf7PwS8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+/frBmO; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+/frBmO"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cfdac74050so3368385a.3
        for <selinux@vger.kernel.org>; Wed, 08 Apr 2026 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775670348; x=1776275148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ytWEGYdQlPmw+tJjXbmehvJU3BxlYqxWH1M3xXo6Lk=;
        b=V+/frBmOiamcMpDGz/TiYTV4g0CbR2NeJaBrTe+nEXtbcWQB2wGpP0Il8gKAWAUhVq
         ntKTDDBf/fYNioKQOvlfWbZTVmJIQz1ksR96Up+hmY3wOAVkTwiO2uIiP7Rxu4oluFOG
         8aj0d2SgGJ22BULSmOffjezYv2kFyb6W9GAaCw4iS6xtZmlAPuvFXX5kkpdxrOYI/9pV
         BKbhb+aQC8IG83JuFzGyPZQjW+oRZNbKzKDRaROjAIFo4mHiSScbRC9gsgElwbxQ5TH7
         T/1F/tYuoz9jm704It5JBzd7d0lP7ucLHjs3no2y0oAT93so/ecVom/wwA2BAeVTf+Z7
         QllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775670348; x=1776275148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ytWEGYdQlPmw+tJjXbmehvJU3BxlYqxWH1M3xXo6Lk=;
        b=lMKrroRR6XsQp0PlCc0U0dyRaOsPVpZPiTXp27Kej1nXMWb+mvETd/TxcrzA2Ov21r
         fms3s/Ju0wLGS8knsh9QOOB8SJqVnJXOwZzKPT96EkX/7kn4a6AV0g1GVg9WiRKVMaSz
         Q24NAuDKszbSW8qSsu0sUW2Tm52zWPen99U0POwyUpk+G0kzmz5NSMDzCO/1cajoOrn9
         BUZCNMJzACTwmlfYRmAIVVUzrPGxXxO3nz55v1Jr+lmWwIvnUUucU1eqZ6+Wa9ZYXAAQ
         gAsP3QLjatKQyKL+5zo0edUBWi9y4MChd0D4FJaPTHr3YEhg35IweXLfcNXYGD91qicT
         a30A==
X-Gm-Message-State: AOJu0YxbC2B11OReDUBlvvdOjaWhtLT6yUE7aPaELd/4WSj4Dnh767Cw
	jKoe7Bs66rV775lMxFjZYYDM/9l4qmhIvBDCc9o09pGYrlDJwhwYoymEi/rDUQ==
X-Gm-Gg: AeBDievf/0BPGx2+QzRQhoHbqx0TNrLBy28+vyAZlCX2ZpObjMzQ/qevDqB9tBoQcBG
	8Vv8S5u+m1o4en2bApcqJoVq8ZldQ7u9xPONtUNBfYCLh9F2W5JUDi9FDNlypF49lfoj06hyNTX
	NLj+s3P/9cVNiuzZVhj+h2FX02w1TTZt3eZyYs7vrbJhDoJB8rW00zEzZqmKGwTbrkjs1GGpCQs
	IOYczWwxCzkBPzccVRUt2l9XsFjbIBiEfR5Qjot8mzvXGA0fo2GsO7C1VO5qc5WtjWT8bDvawLd
	Vz+ZpKXAc5m0TaHOxp4SAsvVCRDKmn4RfxwrmPlKpcwTV/xCg/JnvDbJLQUXf9VvDoSMOp8zFjE
	OsE99TImolMjWTIMEOIqYA/mpDckCPtvqRBUxY2/7LMhN7MCZaW0Z/NBtfuuP8aWHOmqTjzxS8e
	de9vZym3ryl1g+0dFBODeyg05xHbIUcKjhWmmYHtLiFo5gKlBGPr9HKV9S5hMbELs5DBRzQ1hEG
	lsPOlyOPSRDaLlqRgKu+QNgH7+mD0BK+IiW1VPh7xfE1x3ccXKd/CY=
X-Received: by 2002:a05:620a:198b:b0:8db:7315:7072 with SMTP id af79cd13be357-8db731572b4mr372818385a.60.1775670348115;
        Wed, 08 Apr 2026 10:45:48 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d4b24ea458sm1192771185a.9.2026.04.08.10.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 10:45:47 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] selinux: fix avdcache auditing
Date: Wed,  8 Apr 2026 13:45:11 -0400
Message-ID: <20260408174510.16051-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-task avdcache was incorrectly saving and reusing the
audited vector computed by avc_audit_required() rather than
recomputing based on the currently requested permissions and
distinguishing the denied versus allowed cases. As a result,
some permission checks were not being audited, e.g.
directory write checks after a previously cached directory
search check. This manifests as unaudited permission denials
even after removing all dontaudit rules.

Fixes: dde3a5d0f4dce ("selinux: move avdcache to per-task security struct")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c          | 25 +++++++++++++++----------
 security/selinux/include/objsec.h |  3 ++-
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6ef9c1aade65..c279ebdb3a33 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3185,15 +3185,13 @@ static inline int task_avdcache_search(struct task_security_struct *tsec,
  * @tsec: the task's security state
  * @isec: the inode associated with the cache entry
  * @avd: the AVD to cache
- * @audited: the permission audit bitmask to cache
  *
- * Update the AVD cache in @tsec with the @avdc and @audited info associated
+ * Update the AVD cache in @tsec with the @avd info associated
  * with @isec.
  */
 static inline void task_avdcache_update(struct task_security_struct *tsec,
 					struct inode_security_struct *isec,
-					struct av_decision *avd,
-					u32 audited)
+					struct av_decision *avd)
 {
 	int spot;
 
@@ -3205,7 +3203,8 @@ static inline void task_avdcache_update(struct task_security_struct *tsec,
 	spot = (tsec->avdcache.dir_spot + 1) & (TSEC_AVDC_DIR_SIZE - 1);
 	tsec->avdcache.dir_spot = spot;
 	tsec->avdcache.dir[spot].isid = isec->sid;
-	tsec->avdcache.dir[spot].audited = audited;
+	tsec->avdcache.dir[spot].auditallow = avd->auditallow;
+	tsec->avdcache.dir[spot].auditdeny = avd->auditdeny;
 	tsec->avdcache.dir[spot].allowed = avd->allowed;
 	tsec->avdcache.dir[spot].permissive = avd->flags & AVD_FLAGS_PERMISSIVE;
 	tsec->avdcache.permissive_neveraudit =
@@ -3249,11 +3248,17 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 	rc = task_avdcache_search(tsec, isec, &avdc);
 	if (likely(!rc)) {
 		/* Cache hit. */
-		audited = perms & avdc->audited;
 		denied = perms & ~avdc->allowed;
-		if (unlikely(denied && enforcing_enabled() &&
-			     !avdc->permissive))
-			rc = -EACCES;
+		if (unlikely(denied)) {
+			if (enforcing_enabled() && !avdc->permissive)
+				rc = -EACCES;
+			audited = denied & avdc->auditdeny;
+			if ((requested & MAY_ACCESS) &&
+				!(FILE__AUDIT_ACCESS & avdc->auditdeny))
+				audited = 0;
+		} else {
+			audited = requested & avdc->auditallow;
+		}
 	} else {
 		struct av_decision avd;
 
@@ -3263,7 +3268,7 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 		audited = avc_audit_required(perms, &avd, rc,
 			(requested & MAY_ACCESS) ? FILE__AUDIT_ACCESS : 0,
 			&denied);
-		task_avdcache_update(tsec, isec, &avd, audited);
+		task_avdcache_update(tsec, isec, &avd);
 	}
 
 	if (likely(!audited))
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 5bddd28ea5cb..baf7564c6a2f 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -33,7 +33,8 @@
 struct avdc_entry {
 	u32 isid; /* inode SID */
 	u32 allowed; /* allowed permission bitmask */
-	u32 audited; /* audited permission bitmask */
+	u32 auditallow; /* auditallow permission bitmask */
+	u32 auditdeny; /* auditdeny aka ~dontaudit permission bitmask */
 	bool permissive; /* AVC permissive flag */
 };
 
-- 
2.53.0

