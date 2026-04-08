Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FE63C65FF
	for <selinux@vger.kernel.org>; Wed,  8 Apr 2026 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667110; cv=none; b=fL6awJ4W9j0VxrwP91rztjEJx51UBIPhd4IF/8akyb+XnfuN2jLejb1JjdKLKyJwUNF+Q+bsYY9VvJKKEL16iGgiKwEXxG794ETGywIzQc5v9g5gRIZnjLV+BCiP6R6TDdxY46JNlJaEt/VxY/JdzWFVCLt6lcz832ODfL9V6Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667110; c=relaxed/simple;
	bh=vtKku1Q0Q32dZCxN4CzzeYB6M2HOQ8uM7htpFs4pWL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HRVJW7T2d/kJXesJeWpXjufOnF3bspQ4QodXJmi2yIHv6KBUOgcfhqvzeS4DUH0VFHW1/RvMCKDE0Zsys1qBelToWpWQGbiP50dKA5BmP0nyugiz2MZMr6e9hLJ1v3YUWFuZwxVTXtkrSm1eewQsIDuhUpwa/VDPExQmOv4JM0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWQhjPo7; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWQhjPo7"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8d67a483d3eso11983885a.1
        for <selinux@vger.kernel.org>; Wed, 08 Apr 2026 09:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775667108; x=1776271908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eCR1SbxvQZPysvYdIa1VHu4dYE+BHkfNSIgxIK9At8I=;
        b=EWQhjPo7NPDkf6Ipt0B5knGtNv346BpkzPCaxBPRgmcPw95V79WQjKfAM/UAUZ+oIb
         25wsvCNSqZZcxZ4ZQcieEfTiFSTqQwR2cdjQgk/CjBRPmqPG6zWE17LTfJUJtMFaKXjK
         dPZwWr6YQk+HIZzCS8A+bNjEjuzBMuRSFS6gOw0zNBHgLZhXP9YlS/2VVyeH3sa6/wPU
         dgbY5IOz53hRrRb0i6IAqnP6uwAl/psPjSJZSe1aMncvGZ2RQ/kqBOaHKB9O7FEa6aMO
         SYjLnVtjCMRf0t0rK6K8om5sVl7n6+vBUj9XPjapreSXoohmOV/i0BekMjFeuzK6FEyA
         IKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775667108; x=1776271908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCR1SbxvQZPysvYdIa1VHu4dYE+BHkfNSIgxIK9At8I=;
        b=Ica/9jB1oCFdqMNrOtfKVEueKI5zDuS/OzpBi1E683uY0f5G7zcgDHKdSR7Ebn0ycX
         GpSnhA8ACDhHT5dZDtizT1ClbOYlHLiEjF1ZcCrIhpCesbsNQp0iUoFG2pgfIV58sPqr
         UDs35Xwkk6v6DpF7vQFeD2xYHi8l8KwYhkAOH5ytGM2L07Xts0honYBK9a66Nks0WVh7
         QswaKzmgOFzzgoEaVXi8t8hDPEfC1cKun1TbPy/DMUlKUfqVn+3/f8xTY3KZ8pnOxm/0
         MsobwcARpbI/uMlYhmAdtcnLUiXniidiUPvY+L9ecHF0zIkRYBjcl0hNLfElDbKYWXiz
         qoRg==
X-Gm-Message-State: AOJu0YydT6tqSZLsubuMpzsmfk8GFVWvYckxIqg0QpUfTVR9sQCJJUpJ
	gtAjz63Qwh0X8Sx4q+Pfb7/y9cFpuZLYvGiuJkGZ2fwn0LtZbAzGTMU7vaJzUQ==
X-Gm-Gg: AeBDieunk8g3oPSnS4wvTACiCq1niJJ01h3oTAO74cYtUZczH4M/1fov5jYarbXc+Oy
	Wgs30KBjyf/ut1N2U40c0mammWBWin2wGA0pyT9O6FCfKZaNNcoKjCqmHoWLNOVE9mpUX5bfpg7
	0UaYCFmmEPaOzfs4RFt8Ea5VGu6TsLgMqekYfkMVt9NB0pPSDSdjzG6nvn45LwPwFCAoF8kKb6+
	cSMqJ08Xt7lsGI8TyoGeRQ7hPJIlMHN/FYcD/hJnTyPm7BMbffyz0D5FVtsqioNGL18nhtn9AXO
	ns/SbmoP0E/lqctcXbgst4xmMYkgnpknZmMXteqPbWFvi2RCvSS/2Lfu2objX+oExTtgWsadO5e
	UPGGOScJjcGI659jhkHLmkym7oOYtBtV8hzZJwm+IdYXaNfYSMRIsp/olCs1GwW64Yl+rfLATq6
	WukNeoMoS0C3pOtCDCk5L8x0WKNuDLpSFH2RQlyCZTPvlrJxJSqA6CqMZByS3CW8QwB8260ItYP
	etbgiY19bOR7oynsMCy8vWzkfBykPus8g73SEF4Lz0ZiD1ZywAEpxE=
X-Received: by 2002:a05:620a:3707:b0:8c5:2ce6:db1 with SMTP id af79cd13be357-8d41b8df39dmr3162690585a.3.1775667107691;
        Wed, 08 Apr 2026 09:51:47 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d43e17d30esm1336578785a.6.2026.04.08.09.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 09:51:47 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: fix avdcache auditing
Date: Wed,  8 Apr 2026 12:51:06 -0400
Message-ID: <20260408165106.15820-1-stephen.smalley.work@gmail.com>
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
 security/selinux/hooks.c          | 21 +++++++++++++--------
 security/selinux/include/objsec.h |  3 ++-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6ef9c1aade65..a77a9aa43ea7 100644
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
 		if (unlikely(denied && enforcing_enabled() &&
-			     !avdc->permissive))
+				!avdc->permissive)) {
 			rc = -EACCES;
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

