Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCC833F597
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680149; cv=none; b=h3nFZUdzY+lR89roaMiLvUJgvbSn2aEB6I7dm3hMci8aDbJdp0lCNy3SpBxPgx5t1ansZBL4MKpkNedAC6+xBoKfTeYKuDg525fgPDsdg/qbo5lkjbAUvt3g98e3ytQioUUS5TSMfc0D08NdEfW/WRbfxEdr5Yo4pN68FGuyWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680149; c=relaxed/simple;
	bh=sgU6+hBEhxzYVGGCs19EBkHjDNI/ulLSamueQkpTGIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swRx8qGKsQIOhD+LLr6HHGCAW4nejZr0GB/v0zxmdkK6HxFFrFtCORvOLk8UWUruxMg5nqffltwWXYOC5Cs1Ul5uTlp/hdv07hkymwMuLfYyvkELlvjUyR1ykKE7x0oaufqHxU3sc5QLJ+g5A0BLFtMeRGB5O3/aVNT+vyfS/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=sAEg8qzc; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="sAEg8qzc"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1780680144;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GsbUK2ryWUnTX8tAKgJ/e0DUYHk7nH//LiSgOR6p3Dk=;
	b=sAEg8qzcHbZAju9vxiz6/oH9v8kO/hoxVfkEOEE3BbDw727oE0ppAJTt6sU9BWJC9lpDDg
	VqXxuqVAZ5QkKgmwboy6qntimO5QO/u0YiUfezPE7RW3k7cYJiwNhy72nXMOUOX4Pc3z16
	TH6DXosuwDm0E9JbZidIv6saNV49nK1Zq81etvjvCJiG/Olijdwf+m/wizcZfwatsZEWzS
	HslH/5K0FVLDtpweJ4SBldyocYfhO8rpBep2wuqWSpXY+CtfG8fdoTIRc8e3v15jDMZc/v
	bD0QCCu1t9sVPkTsNMHdnEF43Ndy8O7LsidRfKfnTtaqNvqOhctJkopE0I3tnQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 08/11] secon: check selinux_raw_to_trans_context(3) for failure
Date: Fri,  5 Jun 2026 19:22:03 +0200
Message-ID: <20260605172207.222382-7-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-1-cgoettsche@seltendoof.de>
References: <20260605172207.222382-1-cgoettsche@seltendoof.de>
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

Bail in case selinux_raw_to_trans_context(3) fails.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/secon/secon.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.c
index df32c830..2f2b06ed 100644
--- a/policycoreutils/secon/secon.c
+++ b/policycoreutils/secon/secon.c
@@ -2,7 +2,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <assert.h>
-
+#include <errno.h>
 #include <string.h>
 
 #define xstreq(x, y) !strcmp(x, y)
@@ -637,7 +637,10 @@ static void disp_con(const char *scon_raw)
 	char *color_str = NULL;
 	struct context_color_t color = { .valid = 0 };
 
-	selinux_raw_to_trans_context(scon_raw, &scon_trans);
+	if (selinux_raw_to_trans_context(scon_raw, &scon_trans) < 0)
+		errx(EXIT_FAILURE, "Couldn't convert context %s:  %s", scon_raw,
+		     strerror(errno));
+
 	if (opts->disp_raw)
 		scon = scon_raw;
 	else
-- 
2.53.0

