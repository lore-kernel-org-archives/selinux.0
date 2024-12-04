Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86EC26AC1
	for <selinux@vger.kernel.org>; Wed,  4 Dec 2024 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321187; cv=none; b=ULgU82Z+DVprIDKQv9b0xav66phxYAcW/VpN0F8JqKBNJHI7NMPziE3dWn0lvTXF6PLzeh3WIfoaEgTG7X4JSl4CZk8FKrxCIoorHD6pcsUe8VlWNHjrWn2ocmCNX7BmYwQlbmEkaIkOqbi4iSOf/a/saXf0wlRXZzyVh6YDEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321187; c=relaxed/simple;
	bh=xpM0XFaso8E1G/a4rhRlBYMQ50eIAq82eyJ61ebOdyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LzIGwweaPfI9CuP28iLKxSEe+rLGQnnng4w41asr4vrH/jGjLw4VZIJ7Y082gA/5s/4uPCDKIQDtpTbK5EVgxdOYZKSvtNUbudTOv7PN94kQuNP6YpJi9QNII8a2rELEAaokw/EMKhdQxJB1TfKksczneqOF2UXoiT5QNT7WuDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Ombcjgug; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Ombcjgug"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1733321181;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6BlgvmV0KNyiO5tjLs0YqatDap0ZulA5918cHcJ4i54=;
	b=OmbcjgugafepZMsgS3vi71Mg9GBWQ0dyFuEPmC3/VOg/BqccEjgNz9IRAv1Hq3Q5hiTRRq
	tJNc0VmnSFxJBByogKQ/KJNAGMkwypJV/cnMSj41P9Fc0Q3JKnODChbbY2RcHzPSh+2Xft
	sR/nWN89HjKMPXaJZVn8ACI6ww6o/BlM2kAxB94A+v+8JX4UZiIsRyw6UMw2PmH3TN2oGm
	YTBAGzgl24Jrx/QGANTdrD+NSWzDEUVE2N6hG8eIN5Yozz63k4jyErkJBJkJMurK9tINRi
	oaJ5xOh3xqHo7L89GtWsBVr/0KBUXnU+EzDTRAFd/ZnOCeOp1WVyEE7U+GymBg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libsepol: add missing word separators in error message
Date: Wed,  4 Dec 2024 15:06:14 +0100
Message-ID: <20241204140614.25879-1-cgoettsche@seltendoof.de>
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

The concatenation of the multi line error messages misses a separating
space between the boundary words.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/write.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 4ef98449..89c80e7e 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -231,13 +231,13 @@ static int avtab_write_item(policydb_t * p,
 		return POLICYDB_ERROR;
 	if ((p->policyvers < POLICYDB_VERSION_XPERMS_IOCTL) &&
 			(cur->key.specified & AVTAB_XPERMS)) {
-		ERR(fp->handle, "policy version %u does not support extended"
+		ERR(fp->handle, "policy version %u does not support extended "
 				"permissions rules and one was specified", p->policyvers);
 		return POLICYDB_ERROR;
 	}
 
 	if (!policydb_has_cond_xperms_feature(p) && (cur->key.specified & AVTAB_XPERMS) && conditional) {
-		ERR(fp->handle, "policy version %u does not support extended"
+		ERR(fp->handle, "policy version %u does not support extended "
 				"permissions rules in conditional policies and one was specified", p->policyvers);
 		return POLICYDB_ERROR;
 	}
-- 
2.45.2

