Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2637CD33
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222157; cv=none; b=L0I25Xp6vQw5DDZ62hk2I/mDqWnjFSNkvJlnh6pLv7NewSLFGiLruJGZQHF3zZv+JgjGbF+ymEKOOjRyHTYOHbKqvaoOhUbUIo8EzpGGzWSyYEflfTvrozi7LdgVpTztLH1k3ahDwHuqBH4BZvy/VvEQBdQRy0ivV0Q1h1U5d4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222157; c=relaxed/simple;
	bh=xD5BtoTLDpZCtrblwDRBMpzLqoqskOPx7fpSAjSphYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JotZ1ml99aXxc9R4NcDIqs44SKKmLd6oFYC7cfxxPZHiF9cs4rNJrmBtmmGvqKUu9WzMsgcSm/tEsX+nj7cRR/wii69bSesUinijTaP0og1DMkr04JobmSDBG946v0NYY42DHq2gk8AyJZ3VufFqFQ4e0qoCkmHjvFhOgtEd8+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=rVFEP/Dz; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="rVFEP/Dz"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222152;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYDF6erYTYuEEgikBvSfKGrSDh45Zlkthf8CClCA3Zs=;
	b=rVFEP/DzLfLkyVw9DHmqNWLxs9L/V56tO5Ux8d+BucLzbNXppwrJKKBAqNWdhEKOl83Vb9
	olmESDgtwazLJeOSyB6+ClKRLsGrzQ2fpSDhmGPkjwY4H2Zp6Ul7HJAxrav98F32H6pIBM
	HO6CCQ1JBKCsdeT4v27W9Z80Nt3KiRGwqd+g3rjZJV7o4wFsCI5w2mSCTIdyZBXqaCkNnP
	aP9Fy2WZwbe19g9Lk1ymsmRrXuvG++YSPfY7d7fea2Y/AXaJ8Lm+sWUjIGzXqAW0LgT27K
	0X4LEM2du+Pbvidk85qsNlRYszmutm4Tq1gp8SSMu0VMeSh50Yzx2VlaX0NhPw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 16/24] libselinux: simplify canonicalize_context() fallback
Date: Tue, 23 Jun 2026 15:42:05 +0200
Message-ID: <20260623134215.98273-15-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
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

Drop the original context directly via strdup() on the EINVAL fallback
instead of copying it back into buf with strncpy(). This also fixes a
non-EINVAL read() failure being reported as success with an empty
context.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/canonicalize_context.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/canonicalize_context.c b/libselinux/src/canonicalize_context.c
index d406f054..6e23c297 100644
--- a/libselinux/src/canonicalize_context.c
+++ b/libselinux/src/canonicalize_context.c
@@ -44,13 +44,15 @@ int security_canonicalize_context_raw(const char *con, char **canoncon)
 
 	memset(buf, 0, size);
 	ret = read(fd, buf, size - 1);
-	if (ret < 0 && errno == EINVAL) {
+	if (ret < 0) {
 		/* Fall back to the original context for kernels
 		   that do not support the extended interface. */
-		strncpy(buf, con, size);
+		if (errno != EINVAL)
+			goto out;
+		*canoncon = strdup(con);
+	} else {
+		*canoncon = strdup(buf);
 	}
-
-	*canoncon = strdup(buf);
 	if (!(*canoncon)) {
 		ret = -1;
 		goto out;
-- 
2.53.0

