Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D529B78D
	for <selinux@vger.kernel.org>; Thu,  9 Apr 2026 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753529; cv=none; b=VrroBtQdgbufuX2NNwb0xDyQfOGw/iSGTpLM5gBCKb8FoIlk9pvLGKh5G9b9+NiINPQbsFbuR+8sD/3YWSbCyRNH/M9jiOZYndzmUWGzr8KR0lmsX6Twkgmis4mAO1M55xrx7aQ9W7r172PYC9ZpJRrpdJY7EEA3Ab5m4cuB4gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753529; c=relaxed/simple;
	bh=r0SHrar3xwjnv0LIheQwmI+qHMtlQXIyEYEZOi1xRw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EFGMRWQr0BkIR7Xu/gYQ/hFn7euANHGEX3apZS1dJpVZX7BgSfxjIv9qhBZThQ5Ee2/U9VTZQRs5hJLR32M/m72kLejC3gaKE+FHWBL3spvPrAj1QXEJAiBNBBVv8Z+ThtfvpVH+bzxvwtUEAxmAA4Z+63OzrV4ERwL/+lhtIWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=opwyigxZ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opwyigxZ"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8a016799d2cso14492516d6.1
        for <selinux@vger.kernel.org>; Thu, 09 Apr 2026 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775753527; x=1776358327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1MnvcOC4rht0a188f2CHyVhrtUr1iFkqBvWxP3Mtp+E=;
        b=opwyigxZuVVRksh59nqH5UEctPzj0auPhey8DizCYRvP85PGdw/NkQtsiBJf2dnU1P
         ZCRONj+VBktJ2V5u60kLRAmDERYpczb2pQiAsE03Z9dLSctsDemmE50tr+YRqotw0Mh0
         VyVM8RYht/N6WnIk8nw4ygftNNbT0vaSajFaZ350RoUAB3FzLuhQbIkZ8lxDplGqsT4R
         9A+rWMm6lZIWleTS5kWrA+j+quBO6WNl5+ZGjUu5yFFEVf+KNNSVZq1HR+eB0m1M25iU
         EuoysZC2u9dKBnDS35epYXYhrflmlqfzNeSqqt6EmQzznICFmYy7tDP4HhBU4He0i/QP
         gQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775753527; x=1776358327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MnvcOC4rht0a188f2CHyVhrtUr1iFkqBvWxP3Mtp+E=;
        b=AJhsc+W+A7r2rDOf53/GScjgRgTupjDAGCVc+UIDJqo4KgUDVxzN87hXzGbHlDt7AJ
         QrbagRJ4GeNNWR4LTOf5gcDQj/+Jn7A3mKORH5ekubkPeHKqRqYAO6v/BF4hGV8HiosK
         u1LIiiV80VCQuAK5kJHkjRBladorKSm+KKfx6F1RAKlid4dXd1ElAJzdEZFkA1wHbcx3
         1f/8AqWEJ/fOIKxcvZTHnyVE/bNXGbjAy4SPPO5b3zesro1yVL7fIjH62qVxl8g3yvEM
         7tzRi5hXr1M5ai/iaB+IP00tBcA9ovJFitu7gXaubqQUeT3uRFz0IlzUKBktPodVWspZ
         /5lg==
X-Gm-Message-State: AOJu0YzNw0+nEojtWAGYacAixo9HWZyzVRY/PS85wNl9ZIypw7gRTL30
	FpnqPxBK7VlVn4FyjsaHZMnW1GA596h68QaUO7u1rIK4YzPloRX+GCEmMG4viw==
X-Gm-Gg: AeBDieu2qSUctXVIUavcBOOQUXoQYDAOJqZG6bc+1+EmvNjuLvKp6O9liswUt33NdD8
	2JtXHNYIxYMr6xOZasjFRY+AHxcxalBo/Prki/O/aL3XaUH8XVpYL+uk3A+i3wLqs8JOiu5jt4h
	13WwYOKQ+6ClA/QQM6iYN90sKIZnbBnVG0y+lPjBEcMaIYorBtEi6OI2UN124tfcubQ4XaPPbGS
	bXIG/jrfQenhkyPAzYz4DzzJBbCHMW2IV4CASIxD3YmEnj7fvpwkUxcthL4oW5deHeCqt5UYnd8
	S7c4Bj2heVHQt7XjWy08eVFMFd8xH2kMgox1b6QMyQak58TRVzzJMJ1L71BQGGmF27Hp0Qj9A6I
	6Agv3EmOxTviv+6o5VYvghuQqM/ZwHBYLwf1garyZ/w025WxezYSTi4o1X+KDN/JBnMbUN94HOD
	32Y27fMXp2gHV99K0y2TBYm+KzP0cDCHoV/x0CPSJbR4S0NTTGUJHRn3MdyuWYlFf0e8yRZri+r
	A9kFcg7loqBAk19R5y4C0jgUaDz+sZnYrDA1cvpx/C08Yra4Y9zOvo=
X-Received: by 2002:a0c:f104:0:b0:8ac:7e8d:859b with SMTP id 6a1803df08f44-8ac7e9bec43mr29398126d6.16.1775753526847;
        Thu, 09 Apr 2026 09:52:06 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84c9c37csm306066d6.36.2026.04.09.09.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 09:52:06 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3] selinux: fix avdcache auditing
Date: Thu,  9 Apr 2026 12:49:04 -0400
Message-ID: <20260409164903.19584-2-stephen.smalley.work@gmail.com>
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
v3 fixes the calculation of audited for the auditallow case to use
perms rather than requested, and drops the confusing reference to
dontaudit from the description.

 security/selinux/hooks.c          | 24 ++++++++++++++----------
 security/selinux/include/objsec.h |  3 ++-
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6ef9c1aade65..0bd86d093599 100644
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
@@ -3249,11 +3248,16 @@ static int selinux_inode_permission(struct inode *inode, int requested)
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
+		} else
+			audited = perms & avdc->auditallow;
 	} else {
 		struct av_decision avd;
 
@@ -3263,7 +3267,7 @@ static int selinux_inode_permission(struct inode *inode, int requested)
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

