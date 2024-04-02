Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC44A5466B
	for <selinux@vger.kernel.org>; Tue,  2 Apr 2024 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071783; cv=none; b=YmUurSHwf2YR0UYEbYeJAhk0aT+UybcHEyYVWLRe8CdcFY/ItBCYB3PRLAourwb0NnjuBsunMqNcwf4JWHE8K0nFCl952nSWmMaiBzY25/gADS02O8r/NdT0n85g+XzU/qaQvFr9SDJf9LDpa+YwSRvygwrmMoYBKud9mEzfrzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071783; c=relaxed/simple;
	bh=cCt1ctL021gBslllCvMTAH+gAnjLgxwSy7yzALCPXFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qvT+MG9URYoDLSntc2zUDkkM2eGoJ2o3H3cQcyC7o5CG0enf333u3OnVHltXLWPk0N5gtkL4M3x78K8ZEEa0db8DDUlJjsOJ91w6hU9rm2/CVoiMBbi0gnc8XC3o2Drzh+8eKtKy1jN0W+J86HoVgOix4ij4vR1znOUg0hFHLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=GsupiqSK; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="GsupiqSK"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712071770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j0629k++Ott5gvpVbA/IfliX+zpQbVvdRnVTnqY7fyI=;
	b=GsupiqSKTnpOLyW2bqiFpjSZgNJBEX1DYb9vpIiQCzmgkz8UKblSiKDlQ9HehuirNHo8pv
	zSbD1mb+k52PmGWvQ2LnojKk23QUHJuVTBy6ehYJAP8oX1xPrXnxYm4hIJsSFISyxPQo2f
	25QfAW4DJg752RCKb6x0TYkADHHMnD0N7t6MGyPV8osYkiWJu8zv88j4dxT4TRMndPc0g9
	/0fex+hzxBCinMg+GPiE/5tX21JPihUKabM3BNUQTbujNxWMNaYUfrs7+QIN/qA8WnHnwh
	/FicDNZu93bm7FJ0lQBxDEGt0RNHpersdc3GtsgvUqCEOSK8Ndx37X0l+RZaiQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/6] checkpolicy: include <ctype.h> for isprint(3)
Date: Tue,  2 Apr 2024 17:29:20 +0200
Message-ID: <20240402152925.99781-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Include the necessary header for isprint(3) to avoid an implicit
function declaration:

    policy_scan.l: In function ‘yyerror’:
    policy_scan.l:342:13: warning: implicit declaration of function ‘isprint’ [-Wimplicit-function-declaration]
      342 |         if (isprint((unsigned char)yytext[0])) {
          |             ^~~~~~~
    policy_scan.l:36:1: note: include ‘<ctype.h>’ or provide a declaration of ‘isprint’
       35 | #include "y.tab.h"
      +++ |+#include <ctype.h>
       36 | #endif

This does not currently break the build cause -Werror is stripped for
the parsing code to avoid breakage on old flex/bison versions that might
not generate warning free code.

Fixes: 39b3cc51350a ("checkpolicy: handle unprintable token")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_scan.l | 1 +
 1 file changed, 1 insertion(+)

diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index d7cf2896..62f28c11 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -22,6 +22,7 @@
 
 %{
 #include <sys/types.h>
+#include <ctype.h>
 #include <limits.h>
 #include <stdint.h>
 #include <string.h>
-- 
2.43.0

