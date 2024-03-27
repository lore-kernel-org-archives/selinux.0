Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958E3DAC11
	for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567587; cv=none; b=KkaXFuCb5Ljke9iz1wCG+QQwxBlPU0sxCCq2cXHLCU8yjr3iXNsbPSl0YoBfXDHY6Wu+QhA3FB+QpMbCERGilMCV8JJ1SwmI/9AusaBVfpiOIu6Xhptc0qQ9pAI2DJ/pcBw6Dlh5PmYPjyeYW1mT0HKf99wECkmVW2jU6GCJXrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567587; c=relaxed/simple;
	bh=3WCnkSgyWaNN/B+dKIjA9UQ7cxuXTnbjP0YjR/ahcIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rcnz24s1co3KjOVqOfFLdB4WdhCBoLKFrDdhffU2Th4rbadc08dImhTCz+S7PELKWM3vWBAOI5fdcNuMkEfwSbdwths4flxyGIMSUL960hECyrN5HjK2OFYhvlRhDECrRw2dhFG+a19FcuzmpcJGxHImZEOfOwNlwUsVxvwPypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=kKEvYAJK; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="kKEvYAJK"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1711567573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i62AYR8aebWKS2SKcf3zE8yNG7RQQsZB5g+k8nNz4Q0=;
	b=kKEvYAJKh1BafXrNTqMYCWDcUkDm0BVFvIzOCUHg1JZlK2kzhDdKm07aevOa8mvaU2G8Qu
	24gWcbMFDM+Jyh1iRs2rL0GHWreuJBHB4Ay9WguUd7Sj8Uu+jYG195CzGo6k2l7vrif9dt
	cJ5MOCn3Mi1dkcsfVarFSBQr60+XImF1dzQGdxm0cwQvrBZ9YXsvthPzj+N0l91J9Hoh3u
	7FO8HLpgOapCTM9SfE3qUMeSQSYDiKnFFTvhQdsM9lUVnwTI+k3WIvCxMNtNOpXQkeYuLp
	rdndvSl9YGidhBOJ130/Nsq8W0wyVLllNCGYKgKieEkIGoLXxAsvFg9ez4xdzw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] selinux: update numeric format specifiers for ebitmaps
Date: Wed, 27 Mar 2024 20:25:57 +0100
Message-ID: <20240327192557.505937-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Use the correct, according to Documentation/core-api/printk-formats.rst,
format specifiers for numeric arguments in string formatting.
The general bit type is u32 thus use %u, EBITMAP_SIZE is a constant
computed via sizeof() thus use %zu.

Fixes: 0142c56682fb ("selinux: reject invalid ebitmaps")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20240327131044.2c629921@canb.auug.org.au/
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/ebitmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index f1ba333f127d..e515ad040ea2 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -381,7 +381,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 
 	if (mapunit != BITS_PER_U64) {
 		pr_err("SELinux: ebitmap: map size %u does not "
-		       "match my size %zd (high bit was %d)\n",
+		       "match my size %zd (high bit was %u)\n",
 		       mapunit, BITS_PER_U64, e->highbit);
 		goto bad;
 	}
@@ -407,13 +407,13 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 		startbit = le32_to_cpu(ebitmap_start);
 
 		if (startbit & (mapunit - 1)) {
-			pr_err("SELinux: ebitmap start bit (%d) is "
+			pr_err("SELinux: ebitmap start bit (%u) is "
 			       "not a multiple of the map unit size (%u)\n",
 			       startbit, mapunit);
 			goto bad;
 		}
 		if (startbit > e->highbit - mapunit) {
-			pr_err("SELinux: ebitmap start bit (%d) is "
+			pr_err("SELinux: ebitmap start bit (%u) is "
 			       "beyond the end of the bitmap (%u)\n",
 			       startbit, (e->highbit - mapunit));
 			goto bad;
@@ -436,8 +436,8 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 				e->node = tmp;
 			n = tmp;
 		} else if (startbit <= n->startbit) {
-			pr_err("SELinux: ebitmap: start bit %d"
-			       " comes after start bit %d\n",
+			pr_err("SELinux: ebitmap: start bit %u"
+			       " comes after start bit %u\n",
 			       startbit, n->startbit);
 			goto bad;
 		}
@@ -461,7 +461,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 	}
 
 	if (n && n->startbit + EBITMAP_SIZE != e->highbit) {
-		pr_err("SELinux: ebitmap: high bit %d is not equal to the expected value %ld\n",
+		pr_err("SELinux: ebitmap: high bit %u is not equal to the expected value %zu\n",
 		       e->highbit, n->startbit + EBITMAP_SIZE);
 		goto bad;
 	}
-- 
2.43.0

