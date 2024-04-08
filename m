Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0748CC7
	for <selinux@vger.kernel.org>; Mon,  8 Apr 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588891; cv=none; b=toioEKLYfkF9CMKVkFuSaCfZfDvBZjsCgN+ikicgb4GyxfEKyqtA0eeyEx+fvRutcR1z/TNHUbxz16UVU6xg/Li0k/gDHEFB2FlKfCqi9vvCr7pwWPOin4Zok4pIJCU+4SqUUHHGkNnwmyd08mTUHrVtDX/MkFYwRA36m69M+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588891; c=relaxed/simple;
	bh=rvc2n53Q9u8avd7FglJiyqYsIMI+LXK/3nGHZxrKxyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f41RD6EPznu/JY9opdfNiA+yyskydMqDkKWCrg7nwiUb6kTv4yp9j5OZZi+n/WBxP11N13io9+XOTBD3d6GG1hYd9VT4B2856DE5PkNtyn2bPRDu8xmrJEybWf334UMYDhGLfJU8lea2YBWYLFz3TY+6guUFmYX+wuKhBVWD4TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ErzeCRjm; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ErzeCRjm"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712588886;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=baz5kBzFZKl2Gx0rInlqv4wkZqBnW3ystGCITxn4qtg=;
	b=ErzeCRjmzgLgY/mWgndC8nf3NqjAihgPOu3zsH7Oppi9idXVYZQvV359pWTb1SzqZBTMWP
	8p4lLqqQFg/cXmzLEttKzrRT+sbQKug2+Jz7rYJ27M33QBG4FOEdiuJBPGJR8Ky+yuAouG
	diFzJUIpXKm6w0QJqHFxJ0pvWZFSPNDoDArcNJkWOvLw0wC+zcRQC49Dbs9y1lZ06a4Wpm
	oBGvdWS4FNEiuuSThbbsDrsW/FymeK/AdDrmwqZPCSXhvifZ/ScbpRzkAMqEthmqmcBpRS
	ONRzr5FaJR3gyk+6Dd1kJlA37kFKCS3LXexjwfq0wuGswo3wixGPBXeJ47XlOQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/4] libsepol: improve policy lookup failure message
Date: Mon,  8 Apr 2024 17:07:59 +0200
Message-ID: <20240408150802.63941-1-cgoettsche@seltendoof.de>
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

If a policy version cannot be found include the policy target, and a
module prefix for non kernel policies in the message.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/write.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 283d11c8..2fcc1701 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -2252,8 +2252,10 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 	info = policydb_lookup_compat(p->policyvers, p->policy_type,
 					p->target_platform);
 	if (!info) {
-		ERR(fp->handle, "compatibility lookup failed for policy "
-		    "version %d", p->policyvers);
+		ERR(fp->handle, "compatibility lookup failed for %s%s policy version %d",
+		    p->target_platform == SEPOL_TARGET_SELINUX ? "selinux" : "xen",
+		    p->policy_type == POLICY_KERN ? "" : " module",
+		    p->policyvers);
 		return POLICYDB_ERROR;
 	}
 
-- 
2.43.0

