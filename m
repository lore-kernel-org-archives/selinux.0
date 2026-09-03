Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64349482E
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435846; cv=none; b=OaVS8Q/28Z20B1/QdOUwaAjP/diJ5/8rrbQkmzxw3o1NwsdkHF5eTKFzWCCIoLBleapFgOhe2F5k1LrjtV2KGKQZ+NdsgffkvmT2zjLzuX1xBjD4e4wyO6xeWS4rrRPDpahijImr4t5SXljKU0w1LsGx8dnxCOTbLpQjDLxPxlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435846; c=relaxed/simple;
	bh=DJxFO79bnPA1zKF9Imdq9HJz2lstab2NspnjKYSQsag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bws4w6vSXWwGXFmDpiFxjjZnNujAwf6W+x6tNY1qR1yQzjRT9X6ZxksMv6i9XRklHCp9LvO+3G0ypQvme0a5EvIZrd3cUw4LD72yrSPurJAp/axi4xpVrZnvN6ODEZEnpOe+WQOUY3CyDmHl8RPMYjmQvZU15UFM1Hnxn7BcwVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=YuOn0D4f; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="YuOn0D4f"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1788435833;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Oh2xR/EdMK5FtOfQ27FDfr7Emnn4uJqFzdwwLcoJSc8=;
	b=YuOn0D4fMUCCSJtK51MVC+WcLnGrht+dI2Zy5Wl4dcP/Mojqw10T5Rm2wk8o58arBCid83
	jiO4o9v7COFnaGO3T+SUawrk/my1ufpruldpaa7XK6p2vlkI5TVINL9VXPOsU617BL/iNb
	fv+Nw1V2jhB/4CUnK/lSJa6c4oDckdsUx8qTv+96cnNWkxpGRGSgMBnEMMtOsvN45AWL0Y
	Fo2/ZiSuMx0J6zAiLySu7jlyq+RR2WPjduTEgD0k5RqfLsE+3rBuS/HuKeOI21n8NMUgYe
	KJvqz0FdTJY68iVVnq/LkXGkk9eBURfqpFf6fvfmteTSwJZ20Jf2J1xohRmVGg==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] selinux: always fill AVC decision in avc_has_perm_noaudit()
Date: Thu,  3 Sep 2026 13:43:38 +0200
Message-ID: <20260903114338.77055-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

avc_has_perm_noaudit() is documented to return a copy of the access
decision in @avd, but its early return for an empty requested permission
set leaves the buffer untouched.  All callers pass an uninitialized
stack variable and afterwards feed it to avc_audit(), and the inode hook
even stores it in the per-task decision cache.

Fill in a deny-all, audit-all decision, similar to avd_init(), so every
caller receives a defined value at no cost on the hot path.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/avc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index a9401d6c2e5f..560a82c6d682 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1149,8 +1149,11 @@ inline int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 	u32 denied;
 	struct avc_node *node;
 
-	if (WARN_ON(!requested))
+	if (WARN_ON(!requested)) {
+		/* Provide a deny-all, audit-all decision to the caller. */
+		*avd = (struct av_decision){ .auditdeny = 0xffffffff };
 		return -EACCES;
+	}
 
 	rcu_read_lock();
 	node = avc_lookup(ssid, tsid, tclass);
-- 
2.55.0

