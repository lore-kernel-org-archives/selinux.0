Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CA319F422
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334647; cv=none; b=YweVThH1GVv/tmwbDc0+u+XETy/rfj7Vh2zMP1aoJGNQ7izJsU+xk3ouPqpEJnMfhR2ZKSz3aKb2uj5m4Dh0juctuSDsg+vu/nu6W7cHzLuG+xrBBQ0SzpxQR17PbDqf3FpQ3Aqp0tyH46U180UBynstK/asBybHGJ+D5Dgoytk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334647; c=relaxed/simple;
	bh=Z9+x1NVzAAufmUTepc/LAwzRqkgrYbvHx5y25AjKa2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2bIDfEA+ENEfIA5dLpsJ/tcLRTmQ5SYAPglUUo0z4RtMfoJTjqwGCoLQQ9PxeFvZi6YKfnrM47i1EU5rdUvPTC+r+LO+1ElYiXRB0pEX2HLCOg/acfxp0ZtOPzejU0LFoyRnnmCIBcRbdGm5DKZm9pBPSoxeXi3lq/bJCWg+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=kR58ODVG; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="kR58ODVG"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334639;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Lo9k/ZhTAZ/EYIZJA2yr6cK46hVqanm3ERq67Q6DTs=;
	b=kR58ODVGhqCrguePSUOYimV8T1UFqgXqQmqFU9ruK0qdaPMj59cBg5FTZRs6tKH4awniRl
	nkz8joIMJWiAt4CiypYOf5ht/xfPiuqLVoTKCWTToXLo2SFHZSjPDpp3p5F7H2SUo0ZeGL
	ofX4fdUz2GOcUapZ1SgTVWnt3IQUv5yPA+AB5KO51mh1xpC8Fdu1kKly7uNmRfxdpRrxv0
	P4dNaYc1F9sA9+vWyZIm2rJj/y67lECHNAwH9IX4yAeF2RIi4bRHF16qFpFOJWBGUkVnXq
	CV9zcZzQpsg3+SCnc/JUzH23oIPDAyqRIKm22XiCVUGOOITM87f9zjpcp6vzRQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 34/47] libsemanage: drop macros used once
Date: Mon, 11 Nov 2024 15:16:53 +0100
Message-ID: <20241111141706.38039-34-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/utilities.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index 38ac72e4..9df7b9c1 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -28,9 +28,6 @@
 #include <unistd.h>
 #include <assert.h>
 
-#define TRUE 1
-#define FALSE 0
-
 char *semanage_findval(const char *file, const char *var, const char *delim)
 {
 	FILE *fd;
@@ -61,10 +58,10 @@ char *semanage_findval(const char *file, const char *var, const char *delim)
 int semanage_is_prefix(const char *str, const char *prefix)
 {
 	if (!str) {
-		return FALSE;
+		return 0;
 	}
 	if (!prefix) {
-		return TRUE;
+		return 1;
 	}
 
 	return strncmp(str, prefix, strlen(prefix)) == 0;
-- 
2.45.2

