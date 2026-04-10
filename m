Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EC82F12AF
	for <selinux@vger.kernel.org>; Fri, 10 Apr 2026 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849525; cv=none; b=jzhp+KhuLc/yvbQ8H6WbMQmp8UCo/z05moKDpFNYDGewOi5C8eQMjdqNyAM7QVLZrH57NO+PUNvErpeLbqonx1G7Z6vbchLUf5jaaRoD405efK8ihQzcRVZd5ZKgzqsJCGGO2cxmvgXjvtRvAFpPdSEdExlo3mCnEVsFALkUmk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849525; c=relaxed/simple;
	bh=JS6/pLxXlkZ2RpVxGs8F8tDsT2HDospwfsqx0zx3+SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FY9eQ90PWsmEwEkfKAgPgqOBsJxrr09fLtwhCUyEWS1LiaxW0FrWWT/LgugH2UVDFPx7d47NHfOwNRLnZiq0iD/7B/0Y4QxjlMBrSl54vpX0dXpzP6yGV+BVwQIudtBmc3l9MsQlxWo+VR0m2LKRTpLQgQreD+bp7K1CQhqKGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TveKEJs1; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TveKEJs1"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89cd8596724so23051866d6.0
        for <selinux@vger.kernel.org>; Fri, 10 Apr 2026 12:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775849523; x=1776454323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NnJ0yNuvGWq5uVG4qQI4KArCu0YSnQ08dMqYG6CkDa0=;
        b=TveKEJs1FvvK/Cl3YfZEA6EoHUtGqd/RqW8OZHkRQwX/IslAxZYgNjeqKu/dJ9SUfX
         N2Bvbmez09vMDNqUhVE1ZK6W1Qq4XIgIeRVSyO3iI+eNuaMwcT3AyTATvRS4ROhhHc92
         LEZfp8DK6nf9o1UMNr5+GLCFwPHtuJT2DGyOvyUsV2xjKn+xstHAkGX5iTjtBS0C9rQ9
         rmco+8r7p0MRTkQUuR/HLF0kpB0gs1jT7flepTgkWPTRb33+qrcfPvrVUOZakAv5akBx
         CqxQulYkmd6mU5WZMyWFSCxQQnpKjrXZ5ffLh2FG3ViHEQmMYycVagXncPRo7NVaBBfb
         S2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775849523; x=1776454323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnJ0yNuvGWq5uVG4qQI4KArCu0YSnQ08dMqYG6CkDa0=;
        b=YGRXcVMBdUx0nVsCqlPdkw22CyPY5DYNLzBGaTLncjExi8ZzX3mJLyNKoXtehpZwnR
         nDS4fKr4GMq3AmAOxnW3st7FFn4FzJ+Jtz0x9Q/JXKTIZsUNAzBVt0FPE2e0H/lhKB+w
         Kle9ndAAPqntnjjveqwOj/8WCT76SC780I4C6BeiHYkWFP1Y//8e3UR391l8LnWor9Ad
         8YiG4aVvYlhm6W6n3taOGLwM6eEqzzPhi78melYBWyiow3djpwFFMgVpCbOXbSd65q5o
         UDaQdgWWOGveE4GMMmIZjRbysahOFuaPenZVpXKjbGFgggwl+GBJhwDu77KmvPy0wIaM
         up0w==
X-Gm-Message-State: AOJu0YyyWurF5u2QoITFlVEIXwzfqq5LuP+KjcVBdn6PbvyE7746M7Su
	51b9FtYsWp0uz29w7BpmN16MjpVagRUsXVaUibbLXvwjN/xGhaWl9lPTWxlaLw==
X-Gm-Gg: AeBDieuxDkAhuyjqBgHwy5t7xXtc6FVqWEUa01RutAh6Zs++wtRwmcdhF4x4ipMatSc
	dH89aUC683JDyfaJtbs9ZC2yYzq+CfFNzEYqKUIQm1G5XnGlNLDWrDfk9/hw9RK4MuNfW3IKSY7
	i5+E9jEMAeQuuNRkLCkoww6L/xvrPp6IjNw/r3YSYQjJilyDQOwykzMEm33IpQBMyCrCT16AMa5
	tdhZ7oalgPb97cDGk9mKb9l63uKoUx1X1o7E7lcjhgrmjDbxIc6vUPTTbq6A9ItN162FEgweewE
	dd7573gfi6oXLKMppDfS+EvS5ckSZXyl6CerQSkFyNTiUc1C7R3hknyPBV6SMNyYar2jcAp1H+I
	YTyZfevF/UpXB5HmjTvJznXxevRGhvK406KoQ3cICBFu/RfMEYIXfMW2x4Zime83vc2yNyscElt
	c/wRPE6c016bzue/FURfFuH7gGzAGvWSr4PpaudWCMXqAWTnvvPRSBgoK5oGzftdpwwv62h4yji
	DMBHrVQ8FM3mzh/Cbh1ydihsITzYrOCdx+nNWSEGe+1w6PEbG1/lA8=
X-Received: by 2002:a05:6214:3303:b0:89c:e1ae:683b with SMTP id 6a1803df08f44-8ac86156f59mr62838136d6.1.1775849523112;
        Fri, 10 Apr 2026 12:32:03 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84cffe76sm37027506d6.47.2026.04.10.12.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:32:02 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4] selinux: fix avdcache auditing
Date: Fri, 10 Apr 2026 15:29:50 -0400
Message-ID: <20260410192949.16542-2-stephen.smalley.work@gmail.com>
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
search check.

Fixes: dde3a5d0f4dce ("selinux: move avdcache to per-task security struct")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v4 changes struct avdc_entry to contain a complete struct av_decision
rather than individual fields copied from it. This allows the use
of avc_audit_required() for both the cache hit and miss cases.

 security/selinux/hooks.c          | 32 ++++++++++++++-----------------
 security/selinux/include/objsec.h |  4 +---
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6ef9c1aade65..dbb03132d4af 100644
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
 
@@ -3205,9 +3203,7 @@ static inline void task_avdcache_update(struct task_security_struct *tsec,
 	spot = (tsec->avdcache.dir_spot + 1) & (TSEC_AVDC_DIR_SIZE - 1);
 	tsec->avdcache.dir_spot = spot;
 	tsec->avdcache.dir[spot].isid = isec->sid;
-	tsec->avdcache.dir[spot].audited = audited;
-	tsec->avdcache.dir[spot].allowed = avd->allowed;
-	tsec->avdcache.dir[spot].permissive = avd->flags & AVD_FLAGS_PERMISSIVE;
+	tsec->avdcache.dir[spot].avd = *avd;
 	tsec->avdcache.permissive_neveraudit =
 		(avd->flags == (AVD_FLAGS_PERMISSIVE|AVD_FLAGS_NEVERAUDIT));
 }
@@ -3228,6 +3224,7 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 	struct task_security_struct *tsec;
 	struct inode_security_struct *isec;
 	struct avdc_entry *avdc;
+	struct av_decision avd, *avdp = &avd;
 	int rc, rc2;
 	u32 audited, denied;
 
@@ -3249,23 +3246,22 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 	rc = task_avdcache_search(tsec, isec, &avdc);
 	if (likely(!rc)) {
 		/* Cache hit. */
-		audited = perms & avdc->audited;
-		denied = perms & ~avdc->allowed;
-		if (unlikely(denied && enforcing_enabled() &&
-			     !avdc->permissive))
+		avdp = &avdc->avd;
+		denied = perms & ~avdp->allowed;
+		if (unlikely(denied) && enforcing_enabled() &&
+			!(avdp->flags & AVD_FLAGS_PERMISSIVE))
 			rc = -EACCES;
 	} else {
-		struct av_decision avd;
-
 		/* Cache miss. */
 		rc = avc_has_perm_noaudit(sid, isec->sid, isec->sclass,
-					  perms, 0, &avd);
-		audited = avc_audit_required(perms, &avd, rc,
-			(requested & MAY_ACCESS) ? FILE__AUDIT_ACCESS : 0,
-			&denied);
-		task_avdcache_update(tsec, isec, &avd, audited);
+					  perms, 0, avdp);
+		task_avdcache_update(tsec, isec, avdp);
 	}
 
+	audited = avc_audit_required(perms, avdp, rc,
+				(requested & MAY_ACCESS) ?
+				FILE__AUDIT_ACCESS : 0,
+				&denied);
 	if (likely(!audited))
 		return rc;
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 5bddd28ea5cb..9b5151ad184c 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -32,9 +32,7 @@
 
 struct avdc_entry {
 	u32 isid; /* inode SID */
-	u32 allowed; /* allowed permission bitmask */
-	u32 audited; /* audited permission bitmask */
-	bool permissive; /* AVC permissive flag */
+	struct av_decision avd; /* av decision */
 };
 
 struct cred_security_struct {
-- 
2.53.0

